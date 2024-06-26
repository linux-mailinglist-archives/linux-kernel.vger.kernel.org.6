Return-Path: <linux-kernel+bounces-231547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524339199CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AD31C21303
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99C194083;
	Wed, 26 Jun 2024 21:34:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC4190698
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437646; cv=none; b=d+CvQ9DiBqAKlI4iafdeThWU4TtFBkSl/aRcLeR+ANVLx/MtqLBXrLyu68TYVqxOtNHjxi863CnWexoIVObU21FbpuqmmFLwvFSDZDqkgKkapMFCM0Gi1n+LTUh9h1ZqFTKRZeLxd/gspQifIgYXZxerj3UTtAwn8cywEVKTfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437646; c=relaxed/simple;
	bh=lxyUyI7Ml7rGG22Ce9B1f+w1Bv/1wiDQpwFGxLAqsg0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kADQHYOjkOaVfGPc+wRo9crAr6N700rBaiwRFu1exF+Wh8tFALOlmFjb6wBXKFHfnlb9LVyF2pQbkPorx1YJMCAagRM72u06dCT4v+Ol44dpRDYetQlJ7L6tTfFtPF5X39kOevi1H+Jq0cLfDFbcN0+moYw490TfJ4kXfcWjA6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37625537d64so113313975ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719437644; x=1720042444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/wMDiKgLoFg9RcAgb7EI/542G1u2cd8KM50iNDh2t8=;
        b=S23l9eSvUbj2QRqjneHKwwPD03R5yREFTKo+AIZjDRNJgBboaWaO/gazAY3q+1ljcF
         E9X11Nti0eKCvGTvLuhmHomNJRXkqBpi1WWrbeSYcAq/QNJP5Ds3s30XQG7Zm37WKJiB
         o0wx25lMMgRpd/Ij9A0z25nZOyeiAH9AEMJXB5SwO0PQk/+ds4RhS/kw9i5D7zrERmWt
         OnyXVeiT9Jk1mETA7UuKhVvaVmtEymQDfWPTCcK/ibNfZPvOHGALFyA2BpnA3qhI91ie
         IhjdV61N17f2AO28YwJGSSX+zL134r90jvhorlqG30ctdG7Kb+/enj5sW42EuLW70g+R
         ffRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHGPqH5TEwELTZLvVBBl/nWi7ASLxHpHxewRPdrxWc0bq7JBK/sUzWRAGKVuzlx2XNERejFe/6QJ0xF0P2KrolZ3ZhJ+DJhoo2NJaR
X-Gm-Message-State: AOJu0Yz3vxbUseEAcws0LOGJG2s2YKQGlprtdoaxMHYPt//f0oCiEOiL
	1nYMJT3Ayy+ESbgAToGfWbpe/MZXOt/gPUZWTwgglCU3LsvpOPxn7m1uP7ceaOC3YsekgzwvXmV
	5tAYeHHe+DtIux98NDf/bMwBeJJjc6vRARzlaSljeSyRJ650nWKp3NZ4=
X-Google-Smtp-Source: AGHT+IFfy+Nbjrf2pKL0wh1L3WWKDsM5FXclSrHWOcJREVsHFK3u0Rm90ZSuxk4ROSbHWYVpL3QFeINWnPTJTzRZFDwTRmOfMqbh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-3763f70d037mr11866155ab.6.1719437644570; Wed, 26 Jun 2024
 14:34:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:34:04 -0700
In-Reply-To: <f3ab10ab-38e0-4856-9d89-3b5409da0e55@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004b0dc061bd1c6e2@google.com>
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in btusb_submit_intr_urb/usb_submit_urb
From: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com

Tested on:

commit:         66cc544f Merge tag 'dmaengine-fix-6.10' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146c143a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e096c1980000

Note: testing is done by a robot and is best-effort only.

