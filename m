Return-Path: <linux-kernel+bounces-345038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A998B15C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A07A1C211D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEFF28F4;
	Tue,  1 Oct 2024 00:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45D17FD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741885; cv=none; b=ZqWo/djvnHsdwnN0xVGLNzCN3cI2xTSiICX3sRg5tz8Oxs7FlKNJFXBO9N1dZ8S0z9YfNrR0uKyCEjksZhnPVgt1VQPuF/f1Hw3Ge6YkJSUi4Y5U8/bKrYtuszKc5ohf1ZdD5P4Xw5VfjQM/V9P5Cw3Jg2lyS61OxtjGgSkMB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741885; c=relaxed/simple;
	bh=iwyKJ1GF95odlMh5yw8EE5A7vbZiOAZkaF4w1c5osUU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ooE/OKsC+JhPIWkHIelDMoKHPmZqmO4tlYSsT057a15KiQRqXNSrKju5WUTSkCt3kVh+aTj/RaUiJbSsI9nSGoLYxsMK67ATQyKimAHSoFpb/ZDYzey5Jede11gjMwOR0HRh+hnoHEzn6CjozNeaQy7kxmZKBJQ+P4eni4daI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cdb749571so479291539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727741883; x=1728346683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDSGKJrVLkM5QvIpcM+BWUoS15R6ovXvpktOlIonX0M=;
        b=bMx5iO3E8t9V23Jr3CQHh0JuAINCuLsUF6MBJdgAYWNh9ZYDygOrDQOAYK8SRMI9Ky
         GpPBJSH6IzKBCAUN6QRQMK1NzR8YqSPWIvcUyQWL/CuSeIK5MSGyNkdNo31ADpNnpkCl
         rOoxZsodun2SSMCA3SewNVNzVWjtZHi4EMeAB4YnIT7ZRQOoWJX0tlNrt9dwwfZNsRg/
         Y5iWjb5rkGX3HCyPFcjB2i6NMd3BRjmSO6+CTtZwTCqZnXGblBXLZgSU+13yXTeptsR0
         Y3Hg8ItwoaUde0LZJywMbVllYZ++kdVrgI1pKpUaURovUbr4Sv15p+8YsafKBzi0CAM/
         JTZw==
X-Forwarded-Encrypted: i=1; AJvYcCXZTM5cpRignFwBDO0lWKyXhledLy/N2F5LAF7FAn/R+Fy/lbmaPahAZTXlVeINgR8MbrCxpzDB1GbjKU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNmgHKMiL/Nve6PN5rX2DQVjR8vcqtXV2ZGvxKaGbJ1WDiXzb
	zq8Ed4tOl5B1CtmzGF5nFlDCVspwQEtnd4mytp3gAhHF9+srOi5M3MOkp7ojC5PFmYdA8s7oSs9
	PNeQz/dIWfeugHwGaFueBE+h8VmDOZJtchVMMQQum0DQVpoIlN7BNNq0=
X-Google-Smtp-Source: AGHT+IEl7Irc2PSZeS/5Q+buNrD7f7RHvq1gSfUAnnHA6RzC9OblcRG6UJZlg/H7/y5GLg6KV5FpHUdkfyEtm+oSYj2mXbu8RFPp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:3a0:378a:884b with SMTP id
 e9e14a558f8ab-3a3451458b4mr108589705ab.3.1727741883330; Mon, 30 Sep 2024
 17:18:03 -0700 (PDT)
Date: Mon, 30 Sep 2024 17:18:03 -0700
In-Reply-To: <1da697fa-4be5-4601-aabe-21974228734b@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb3fbb.050a0220.6bad9.0045.GAE@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in
 udf_get_filelongad (2)
From: syzbot <syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12097d07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16211980580000

Note: testing is done by a robot and is best-effort only.

