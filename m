Return-Path: <linux-kernel+bounces-235837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5C91DA4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787EB1C20CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E78287E;
	Mon,  1 Jul 2024 08:45:48 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3236AF5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823548; cv=none; b=tpqP+J5ifmUaORh9T0xVI8xMjqOHOTbR0yBWvJ5hoFyeVNhPb8Q7mFZ1KtiAzNa4rfBYvUNEA/MJR6HcDidnVRlu0AzDMMwbBL0ugn8qBi33cQd28XLX00Qp0r4nU1pbNUT1Iux9fmnYZxhyXlY+6AaR9K1Le8M0s3CMU5m0044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823548; c=relaxed/simple;
	bh=LyLnx7XRF7YDLqP2ULZszBNYIDRvvBrdHegUv9r676g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ICNaSf1YxLOMtHb/u0E3yD/KgNOeZBu0v88CVwaTtMsxaNvvLWYg9MHb6vXtcX5Vw/upNl1Kbrv3GaJ5Q4GR2W2bw3EyxccQ/4AD1SxVQNcDfLL2KMLPoG98HW70csSSfSVJZAWC+74Lz5zLjxW7J+sy5Xx5AhPadc7UNSmtuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3caa9e180so181070239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823545; x=1720428345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVYWamr9xmV1XQ044C1uaPNwG5V3ZEn451uAxABgvTM=;
        b=DX+i/L1Df5WJIDjr2EGu5+LCWobSDY29oQnxL/JgpKD/x2uV8talbmC/kD4uL1qMkg
         sbhzOPg3yBWgdjI1OIYansnePTDM3+khYNgoKdr1mlz65KHGigTzx9RpObZ/fNLOCrpx
         UyPSjgBAr4bkXs0x+Rc0XznjfOCGvBprGAKIbG8sQ1YlQ1Wkw4X99pMV9uPEIbE/cXlT
         bV88ulIe+VmM4IK+PiSwDCzmyvtNA07GjiJX6waFlVb8t/0HMN3ArtRQDp3JTmgUzwjC
         CJ/58E/fQwIJtgjNrf+mp5SzAJrGeKHrXUr8lWBygoIlXjelRrNT3Ty9h0Njw5zWJU/A
         GUkw==
X-Gm-Message-State: AOJu0YyDS3PHwbfYIEPm8Ag6m9hVNzHH45rum0zAaSSld2bL8+nK97j/
	AlruUFXY4INBBWH95HPVQuMo4P/XGbDRCIJfPdeDw1A6gCXpmk6ycaxjnxfu8ZPMLUal17nfTeM
	SDAdIwLF4nI7Rq8Y+BRHV8PXYZcjhivUe+fkUOMXCQnX0Rp7cPCnzJkw=
X-Google-Smtp-Source: AGHT+IFN4djy66q99ne/pp+iqZ7I5xlNcK3eqbFT7Rr9FlcfDBIk047ioPqltejJjFnDjQ/D3qsYC3AYhAvl1jDTF0mGnPFUhYvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8726:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4bbb5ad0288mr444895173.3.1719823545727; Mon, 01 Jul 2024
 01:45:45 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:45:45 -0700
In-Reply-To: <000000000000e9b6ff0618356b26@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000850b95061c2b9fc0@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
From: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
Author: lizhi.xu@windriver.com

#syz test: upstream f06ce441457d

when hit -BCH_ERR_fsck_errors_not_fixed in journal_entry_err, it will make
journal_entry_btree_keys_validate output too many same error log, and it will block
bch2_fs_start to release state_lock

diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 492426c8d869..67c3f09162e4 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -415,6 +415,8 @@ static int journal_entry_btree_keys_validate(struct bch_fs *c,
 					       flags|BCH_VALIDATE_journal);
 		if (ret == FSCK_DELETED_KEY)
 			continue;
+		else if (ret == -BCH_ERR_fsck_errors_not_fixed)
+			break;
 
 		k = bkey_next(k);
 	}

