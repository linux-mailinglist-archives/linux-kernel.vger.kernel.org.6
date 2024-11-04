Return-Path: <linux-kernel+bounces-394753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD49BB37F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08076281B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E31B21A0;
	Mon,  4 Nov 2024 11:31:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FD185B4D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719866; cv=none; b=RphdH9jfqQ6E/79ghQfjBaiyCkT5iz1u9KBRoRSN2yKabzfAa/N7u45hstCJwAIR70ZJopkZac8XUbZPb/H7AE+Vtk50pup9AsmmtKv473wsvoLWrUs3hfnRHnX/p9L82B/TZjbb+BKxf2kNo3/CYRawfR/re5UoexfpOXOeMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719866; c=relaxed/simple;
	bh=USTEXjGieWszLGj5z6r32OOADjpD4CWIcX6mjLJKHQ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=csRXmwxOSFiwKPbN4XZHIr0P1KtvPajnc8h5zRGwBOjTsWA8Q71U2Xwb0DPAzk89vJSp5wkrQg9D3llLhNSD0x5aYrPy9NzNIAQaBeFf3fsagIffdcbSHZ/WBLjxOi8wvJzLRMtuXwVP30BZz2tn9wG+MK5JZjieoUb+bRtzXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b3808522so29393285ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730719864; x=1731324664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K+Rxi0VCaGxt4BQbyfBUCQ8LjiJXLegtr22yoocie0=;
        b=SGnlZf4+2z0yL6Ff6Bac2WEZcaRd8PgosWSs1HljASJoANoRZ2PWFsa42MatvrElGT
         bW2p6d1LOEMbJLGHjkImYe+n9ljTuy8a3UzphK/R9219MJZ8vM/jRdsji2N+N4UEVEct
         5nsn42voPbebJKvzntc2bvppOlrJfJaHKZtJm1SMSR7IQwe/CPnrH6BZIMij13ZdjIzL
         KItnCC+Zi4HJ22jOA1fyNTx4EesKrumLoXseyt0OK+sGQ45lCYpMP9b+ojJo8E843zE7
         /aGqlOIWP13fQsEdq2eNFOVzXtT1HDXs3wupASBbRqQHNLjoQIz9TS/oKISc/HVq8Ofw
         wUew==
X-Forwarded-Encrypted: i=1; AJvYcCV8b7J/6LDo5mVV3iEo/DTURhGLfx9NGrxU/Wygn8R/CuI/jnRZcWcKPJEESA+3dlCo6FFtKwWTkcy8H5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdL5yForLozRTS/cbW5xWUjc2dU8VGNgD5uRxJYLvLXVc+M8jS
	UZgv8geRRjZCrUD1N3oZna/r9wTjHXLoByytR5XXCHo1dHEKJIEzAdszvZ6WYB8dwKugUMixSja
	7J7T1MWtISpDnKPj5GqDOR/yTU7AAQLsgUMkAcx57CoTQjVZeIDXHod0=
X-Google-Smtp-Source: AGHT+IEHvYw/XzmB2HY4/rJQxloYCEvLWoq1GowHu4aappO6X751IG15/mI2XWUfsn57t3nkVzFOEfFEIWW4ziCCkwXvAQWgEKMz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a6b02fbee5mr99594675ab.15.1730719864025; Mon, 04 Nov 2024
 03:31:04 -0800 (PST)
Date: Mon, 04 Nov 2024 03:31:03 -0800
In-Reply-To: <6728a3a7.050a0220.35b515.01b9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6728b077.050a0220.35b515.01ba.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] [usb?] WARNING in io_get_cqe_overflow (2)
From: syzbot <syzbot+e333341d3d985e5173b2@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3f1a546444738b21a8c312a4b49dc168b65c8706
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Oct 26 01:27:39 2024 +0000

    io_uring/rsrc: get rid of per-ring io_rsrc_node list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15aaa1f7980000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17aaa1f7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13aaa1f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=e333341d3d985e5173b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec06a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c04740580000

Reported-by: syzbot+e333341d3d985e5173b2@syzkaller.appspotmail.com
Fixes: 3f1a54644473 ("io_uring/rsrc: get rid of per-ring io_rsrc_node list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

