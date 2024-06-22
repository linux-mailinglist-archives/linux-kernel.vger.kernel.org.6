Return-Path: <linux-kernel+bounces-225498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D5913155
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F851C21134
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019A441D;
	Sat, 22 Jun 2024 01:21:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C8633
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019264; cv=none; b=uraAWUfUwTRVyNGJJYbOt6wsa4q5hmPYBd5GhA+AWDWOl5f3uVuY8DpFyHV08XMet5XI9N3lt4Zx5JB/bvTRV/I594VW39ajYKK/bEHCNQt4mijTB0h0FriNQcfDKU96A/69446v3v49RjzXfVFKYgaYMXWhSJdswM5OaHWu0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019264; c=relaxed/simple;
	bh=BEdyoebRmbIRM3CYYXodP7JfioswcNmVwwmhMzKpjM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QTO+Grihwvp+dyP35ZM99ZD3xfR+Rmt/WA8VEPupYUC54sH/TG9AxsXOBPTCS8GidEpjbQUe0wxPcc1kYChzSXIDYid4sggFitcz5tdz/OZPb8vENr6FnK88EwM3mQ2bX0fJe0iyAvwVIrqST2tlQo2tZEHiXBRqeiVb62tK3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ec091b556eso284684639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719019262; x=1719624062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mu7iN2utHv8H1C3WNVeU6BtFLQk3PoySxJn9HkCI00=;
        b=SbMwVOvygX2VCUuMRPIRbIdwEVBzgIsYAIEKzFAmvWoySxaY/9ygdM4wigcs3mNs8b
         n9NfKNjl2HOL9uUZITvt3rWJRsMit2X/fBp5y6+qsgwNSbwpyvVLip3QxBhLitYuDpxw
         UZCm84vhXcaVSjJJ/iVRoE+TvtokdpgYHBNVOJFmMkFeUiGzcdiqUx/8hXHLFFD1TXGJ
         u1AmaNnzRXfLaHCrnPFLODJxk5ymU6Fa/FRQB1oZrHQSobOZgzUXTxkg4xSdbyaog44Y
         nje1LQV0yHpOJbsaI3I+2wCuPtBcwIb+K5I+lgym7QObxEUVHxJjT5zmnR0irfH/HT8K
         /G1g==
X-Forwarded-Encrypted: i=1; AJvYcCUUP9rGo/KeEuaNSV6zDnyJ8/gRWqwJL6+uGnLu90YYHQtxQgdO7gq/9uUBzAFXZuH5bOQ3QIF9CtiS+VY9Vjks89AuyYTVpgP9Lo4V
X-Gm-Message-State: AOJu0Yx8JOkVt64Agph6Cwx+YMVxTXZvFnq7Bvn56uwhWowId3kWynzl
	stPr2HePz8ZeuXJCjeOm1SsCIQ6pUDc1HrY7Adf3AUuOzwo5USBvGSBjKEv+3QtF6Br/iFxqRXU
	xulhaIGI+jR3ZxAGfCcfuwT6M15FgvL8IxsSQ6e0Ade+tiBB3kDv5gBQ=
X-Google-Smtp-Source: AGHT+IHBO4byqCcTPsFZ0rhkYW6FTI25s8fVjvVLQx2mL9UplyEXqDL6E2t9NdPWiu5rRmWfUCDURHOAJhpNv9halHxawNva9BFL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1385:b0:376:11a3:a36b with SMTP id
 e9e14a558f8ab-3761d4df401mr5258215ab.0.1719019262363; Fri, 21 Jun 2024
 18:21:02 -0700 (PDT)
Date: Fri, 21 Jun 2024 18:21:02 -0700
In-Reply-To: <20240621123056.1783-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ed9ca061b705cb2@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_verify_work (8)
From: syzbot <syzbot+e6b87f5edf5469e359e9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e6b87f5edf5469e359e9@syzkaller.appspotmail.com

Tested on:

commit:         35bb670d Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12881b9c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f388d5a19fe3ad66
dashboard link: https://syzkaller.appspot.com/bug?extid=e6b87f5edf5469e359e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

