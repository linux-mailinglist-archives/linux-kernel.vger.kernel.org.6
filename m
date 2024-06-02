Return-Path: <linux-kernel+bounces-198185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12D8D74A3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C19B1C20D46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D11364A9;
	Sun,  2 Jun 2024 09:45:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DA29422
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717321508; cv=none; b=hzGgWOgM1FIxaRDEhBQKwYeDESM+gqyHxB1zZ+xCmblyf22c5B9yPjqM9vjeEupWnzRYEfxH1ILhZ5NF/N0/GIhEXy45xSLf6o/1XcEA2w5RqmjmbGR8OcJHKkcc4s59nVM2ELOTquPWEPX73Gw1xTk51qkkLfrEaRo6tTjgfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717321508; c=relaxed/simple;
	bh=X02ZqsYm+8mJeG58fa3PnsuTia0k6am3tu6V/1Vj+Ks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kX8gnAlrcI8QEmo7XaNA/aZwfPlg62mKUq5QbuUajI7KyJygu+ORBwrUxU5DWJbuNdDqQx0wc0J2Zp9PAytvR5vi8YoDcS//nqHJJfjZZm0ChtKlo69GIdv57yhQ8Wyq+/vi9HFlF82SWYUU8UgWT53pPXnEZewADqGsAq414x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e25de500d2so304173939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 02:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717321506; x=1717926306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT1M6AljpZm6aS2bdrORp3SnIYZ1thPi3eJ9ZKOWJAA=;
        b=TYHqMXADcTrADd00gh4xBsonTgtdZgbqmTQN43gua24VKTbh4COmxDM8u10kbbsil7
         OwJFfV+tNL0kYrZnlzWkKZuV5pyy2ikDQ1SnbXfADnPkQe5Mg3mppY90g+tztXQbKlje
         Tdzj3K7N7E0ihw/ezvV1dAWGCW4SVt+7On7p/67Gj8W/7ol7cdKIQe//FgJbvBCdnuSd
         cMIeskTrMe4xPNNGCLOqBQwTNFmSi56jpu7HPhiZMGFIHZnV7d2hasu6z9PcC7wkTLrt
         RYaD1uKe//+7Un++dGV1qw8fa/3ra8MdGzcfb/7R2jkCe8HEUCBmclbvIB5rFvGSuLkb
         d6jw==
X-Forwarded-Encrypted: i=1; AJvYcCWYtDOVyXvRI32BCy7zqmlxPLoz410iuvobxiyvrGBYECBXdiOGVrlYplDYJJ2dvf0IHge2S2XoypznfzjOHhshp/u7lQlyTY5vvga/
X-Gm-Message-State: AOJu0YyRs6e5bdDCH/TVT8jz2K3IcP+zRgQDlfRAU/YooAFP7FxBOp/b
	90tBkASdDxVXG4sMrcvE1jE/hESRKYCMrPIycXlWUR5G/cuFMAzcZ18iphPg7wcqGM4Oc+qttDi
	gQUSM3/kOLEJ6lC+NQTLi5zwp+dBfSl1TdipdYdS5VSxAIdah3o5XBzk=
X-Google-Smtp-Source: AGHT+IEYLTlofTjfOA4vNEE8Mp/pZSsLeF8zezoko3sypdOkzTZxEXy+oFFgNL1Memn4HTCuel/dIFmaflM1qn4v0nNFxtMus/+F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc8:b0:7de:e10d:34e9 with SMTP id
 ca18e2360f4ac-7eafff5c963mr39628439f.4.1717321504945; Sun, 02 Jun 2024
 02:45:04 -0700 (PDT)
Date: Sun, 02 Jun 2024 02:45:04 -0700
In-Reply-To: <tencent_D0FA12FAC65F09B4AEC6AED04C8C67C38606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000448b320619e51259@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com

Tested on:

commit:         e33c4963 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16456bc2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1670df2c980000

Note: testing is done by a robot and is best-effort only.

