Return-Path: <linux-kernel+bounces-208838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218369029BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8A9B20E17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C689014F9D1;
	Mon, 10 Jun 2024 20:12:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900814F11E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050325; cv=none; b=AV5eS2osL3gQAAc788SJaIuiuYVInFvqMROqOIkmFhFeRwxGZUTQjelOkcvliqfeP232tdn3qg7xd4CtshAUuJgHndTl6wJu9EPSNaioUqQhvB2S4zttDsVEzumB2zdLsFcE+KYQ2YbRLBUMAScLVd+MOD/auz9Kxlkc0tgd/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050325; c=relaxed/simple;
	bh=mp1Q78UwSSe9n2Y0sLLqPNBBOSPg9iabbMrlvqKMXtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nz3VtZcL6Xryvn6BXNhUGcaRoeX/D+P9L3RLGuzIBSnDFLeH/elW8WqQMB6HHrmF35RjnqA4TKf/kbKMWSvVIYxx7w20YjeNnUbld0RA1I5TNLVnidzJXXg3oOskEzq4A58pu20Jjs3JjVJzrO+SbsUkXX9a8L19sKOmZtlVT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ead7796052so556025339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050323; x=1718655123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hYMnibR7DOM9ET3noPinHJRffU48mMLpItbsVsUdkA=;
        b=owyE/QV9IHUVuTJUsAaly6emi/9DO7HbO5aNDe6XJY/Cr3TRovxHLnZrdqJfwXv9a/
         q5cLATewkLRzJbIq/I1A/SxBZotakSzlnarMjWRcc5dtyN8+OQJ5sysbDGtshpDo3i/W
         4vsCXumg80Pk9cFRTgaEN0k7Ct6qrZhBbfuyYg6EaQrl+dQutqTLX3OrUsmSuyMyZomZ
         eks7PhmGgEwn7VDMu0jyCuhF+o+Ft0TS7iEQM9RUhhhRjZT2ZUERUGIhJJ3qQpgaeIyS
         +rH3PXi1Bbk0kVOf7DJlfAsi4Velw1T0mGfExg8nS9af1bjRlHI+z/H2q+kyj3h8W07O
         2LQw==
X-Forwarded-Encrypted: i=1; AJvYcCUT98X8tunScuRlI2Zl1wZR3tttFzAiSfvFh/gawF+zu2EiOV9HmozPh7jianx67giCmp9wxnD3hO+f0j0lypXZhIDDujSg0DxscJK7
X-Gm-Message-State: AOJu0YzW9zjfYTEprgKA+affx62RGcIrY/Oe02YYKCyzAQRkwQuHbByT
	InyWChT17IEXkxI4JGYShiky4FEtJhh68l7IGpVieDIIVN4sgyL0ZW9Bkuy2xXeVQx5oKDx+QgI
	goQ+JeoqFi+0TwGus8EXsyJ0EFfNwLsqCoaSyTpk03E/w9xuTLeTppi8=
X-Google-Smtp-Source: AGHT+IHJIpXmPJOEopzwZPN1wIDxsmWIFZqWwbZA8jsx6RcBPzv0N+h9ogETA+tpiIRvciHoELcRoUZXh3CZfbnibv5SqdjZE5oT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-3759cb9a138mr4169745ab.3.1718050323192; Mon, 10 Jun 2024
 13:12:03 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:12:03 -0700
In-Reply-To: <c3073a8c-bdaa-4123-ae27-9143d916a701@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000386b64061a8ec33d@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
From: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com

Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f51bce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151b5fce980000

Note: testing is done by a robot and is best-effort only.

