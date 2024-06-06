Return-Path: <linux-kernel+bounces-204160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB768FE4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD455B256FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9CD1953A0;
	Thu,  6 Jun 2024 11:14:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0EB1870
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672444; cv=none; b=c+w7mBYfabrQp7ZLxVCdHgretXOnN+CBEjnLzcts4HPD9TjsQPT9TzPzkN+teKf6dICMCf9vBGWVXB/4Ez/NoJbNXKSZuTl+Au3TV9USVQSt3ScVXyqYMpk74sdVS5YTzipNn1WcdDcA07MZrr8QPQU21aA8xg+MJQCnqTmPvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672444; c=relaxed/simple;
	bh=nzHs55R+1AqGnwYlGJ62wQOcYp0psfm9a+xg37Hn2lM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KPXACD3WjNjm0PSQsNq+8C9/X5s/H+Noa+K+0XiIPWoyI9h87c8RmRBZ8YuS91dBL1Aj6UkxXSisJs/AIOjjdcWDJaiEgSIuXpqa7rvNnjuZEhy4B6aSqaXa/1rLCO6yBMuy9hJFt6HdPuUGIustlzTbo6Z0fKb0YuyH7FRDfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ead7796052so89937039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717672442; x=1718277242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tvm/Y99htpenXJRLokTAxdXzibHSU39nDmWPWK+PqQ=;
        b=r5C+qYPSjChd0g/cDxokUAOeTjD7JivxJMXNT40G839J7xGnw9pa3T4oBCFQr3vEU9
         OK8k3KoueYb/YKU2GKbSmqisfWQxdwVOSDGuRecX2ut673K7Bpb9MBQiBuvtLrpDBo+x
         Io+M9QS6NDqxW6cW4s1L/l7BDkl+5g4PWhPbnle/QcYRjQ4rxlJlh7YO9nZBlU2ZVv9v
         StESUNyJtcR5pkU8/6h6rZb69IOYGBVWN8fzCuoV9E9gRv6G7hhW/AelRgzUyDaYD7Ri
         Vtp3FhKZd2ewFl74Fytt+eeIZxgHU0TVycTmT0k+VTAj1Kzf1csTRXXbG9Oy3LSyMHE1
         9faw==
X-Gm-Message-State: AOJu0YyTLpbPcIuqq/z/BesnSmLj5504lyotOj0Wked9YoNcQbzTTxaf
	No4M/Ew2+2rrliJR9HMa+G9VK03lOnQzMr0VpHmipq+4G5lxMncklQXwoQwxGAV4JHjDNaXy0bg
	3UJ7LJs0wbnAmh417y9j35FpnTXXpuvd1NMS7yKamfMQwxSude3L7OIk=
X-Google-Smtp-Source: AGHT+IFbE6UPHb2oSpTp0EGGUxAkBCOtfAGNQEprNjzemFTpm9oVnLgZCODRo6R+ZldL4cC+BPlaDulrfsns9+0RkreQylMo9zew
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c6:b0:7eb:364f:116b with SMTP id
 ca18e2360f4ac-7eb3caa26damr18831639f.4.1717672442342; Thu, 06 Jun 2024
 04:14:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 04:14:01 -0700
In-Reply-To: <CAL+9cWJXXK43PpTJ_hAYEnWMZO_HS_exEz=rfAvsN6Rv6BtHEA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c44348061a36c77a@google.com>
Subject: Re: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/06 11:12:56 ignoring optional flag "sandboxArg"="0"
2024/06/06 11:12:57 parsed 1 programs
2024/06/06 11:12:57 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         45db3ab7 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13e682ce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

