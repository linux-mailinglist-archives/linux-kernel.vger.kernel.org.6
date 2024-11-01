Return-Path: <linux-kernel+bounces-392780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F69B9809
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C021C2191B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA91CEE96;
	Fri,  1 Nov 2024 19:02:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2814E2CF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487726; cv=none; b=N266PrJ+BydyAQrd5qF5USPHTEkrsW9l3/+ZocwbXxRuEox0veIlekojZ1VUJKLnSkTIVtBMkvSYkPT19avh8ZvxHEJNq6F20uVkUlfVhb2r0VsgmehD/mPi+A8g1r428lpLrSIwvf03MGDo7sLxIPn3T9yWViXUyZ1bsXlIXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487726; c=relaxed/simple;
	bh=elZ2Y4xb+q6SBvsUbOv7WkDEkhV95Z7ralXEdDeVpjY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dHeLEHn+WzE7gwSbk8BmN58IrjYPlU487NJBLlRWrt8uer3Am/S31ITUucEV93ZacWn/HR7I3XKRTXvWveRCFRSm4vqBJStPzmXEhz+rnMzfjZTxIlxbPV6Rba5MMBsSQcVKrAILzDK/Ec0SIMHOUAAFRcM070W13Uf8kn0mxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so29294635ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487723; x=1731092523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkQyL8Z38BSSMQu6LynWJn3lSRtW0cs0L7VxR/etyvA=;
        b=ehsRl9rILK0WrAfyTl0ENMjhWHIvh3dfukP9OABR6Rzw6gbbF44osZ8FDqNvjByfj/
         yq4SShs1UeAmln6kIxEhCEmmGxMIcjuGYGUEreDmdivBKgQLmJtme13UmI/wTc+gZQml
         WYL54TQRVeoZ6uGxvpcwNswWYIbLv5cxPuNjyC8eRBGfDpSEwGpp9sI/rTQoBqtM4Jj+
         U9U4LVyj60kOmlLvzJsnwW4tfLiSao3U3fUsZYM8dqXJZlugI7bfhy1zfZdt4le5A0TU
         XYEIVRziA3QvXas2iltPl0pnukf93hWvokGSo7FdMRTGSMbptKDcmfuZJGrSnuiL7xQc
         BZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEOuT1YrkMQvyKepRNRKdeDyZZDHeMFm7FRzHYWR7zY3Bqbqoyu60R56QC9ok1HCY+EhMHrxLPNo6pExc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoam7rufB4X6jg4U/aDzJJgvxnfJF6d2/QLJ7J+3W6hCJtnw7D
	EUkqyYhrvHUG+UnSAdIXCeR4g/3YFd3AkLY1leFG7gJPo+zB27rlNR2SnJkzN/WzUQ1r+3PP4kV
	OEsnXCrK8tfJknCVy0SYphtinoNFjm3WnyF7O/Qc6/HS2ymBwjU9u2Uw=
X-Google-Smtp-Source: AGHT+IGAv2HhohkX0XrPNPJ+o2V8MHjOmP7uaOrOTVGzBzWKsdOt4Xv7NrshNE9SbnJ3vohnl47a8/E4SzYiJhccPpqHWMjiQoYz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:3a1:a619:203c with SMTP id
 e9e14a558f8ab-3a5e262e89cmr135256465ab.23.1730487723382; Fri, 01 Nov 2024
 12:02:03 -0700 (PDT)
Date: Fri, 01 Nov 2024 12:02:03 -0700
In-Reply-To: <4a7fe7a1-02d9-4488-8aef-b4c3851224ed@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672525ab.050a0220.529b6.0169.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_uring_show_fdinfo (2)
From: syzbot <syzbot+6cb1e1ecb22a749ef8e8@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6cb1e1ecb22a749ef8e8@syzkaller.appspotmail.com
Tested-by: syzbot+6cb1e1ecb22a749ef8e8@syzkaller.appspotmail.com

Tested on:

commit:         4a8b9560 io_uring/fdinfo: fix sparse registered buffer..
git tree:       git://git.kernel.dk/linux for-6.13/io_uring
console output: https://syzkaller.appspot.com/x/log.txt?x=14016187980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37061a3807403bdc
dashboard link: https://syzkaller.appspot.com/bug?extid=6cb1e1ecb22a749ef8e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

