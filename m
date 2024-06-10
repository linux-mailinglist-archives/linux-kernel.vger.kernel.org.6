Return-Path: <linux-kernel+bounces-208899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B0902A60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC10281F80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58FD4D8B6;
	Mon, 10 Jun 2024 21:02:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A010A22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053325; cv=none; b=tc1OA6xzoFkkKQsTD0DeJp5qnZYCtIKVW65Gv2XXiAXQNcF3dHO/3d0XXr+wyb80Un41k+skwqLvNCz4+RXKqZHwtlYDvDsGIQEHVT3h+SkiwPYCUq4bsuYw68MPTzuJYrR0D6Z6buqJtTX8IWhxSSj2QIdBeTYDLVU4O3Cy2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053325; c=relaxed/simple;
	bh=uGK/H8jul0vS24kYJwBiCgU9IXfRynQBAhQLqMeeiZ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aEophjnRUZ/x9nipnfLaKK50Tmg9H2c0Nh36sE2ZFW3VvbMhCwoy+97EE+kuuPvrIj/RH4lekTRVx0O2OXhcDkt9/vPdYJ3l18UpBl2ttsjBCxwhWaIecHKfm13Zvx76Q2uAp7BonxBnO221Rl4PTirW4MLVLMYrVrsDDIB7Sjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso38062339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053323; x=1718658123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyAxbW1AvITYuU0/y6kSCUzUzJn0ylmdyy8yZkC7FKg=;
        b=nPDfeiKB2AaC/01p9pO9E5Cub+gdqhhqcjEsojsMAw7hsKgHs+ffRKMMPQljpWYeaQ
         0Jeh2BRigbWkryDIC0gSthjtoR+ayqvId5l1PGHH/utwO301m3uaXdgZUMlVzRM5DJLd
         kEv6GF4DhiH4lWYsQo3sdelJGMsq/Q5EsnFNkI3Qwc+Kzu6hR/cRXfLywe83lblrnxsq
         d7xeZezgpMQIeSZm6Qnyk7E9C2s5o5Q3hhyt9+NCHJEV7ezNfVrXuZ/WEjGbLgDStHb/
         lWHmVrINTbpDYTEQlkT+A/WFrKaViit5R/+mo4jDwkYQ5c7O/vzNXFKmJ8tiLQJpC4Aw
         tiEg==
X-Forwarded-Encrypted: i=1; AJvYcCUEu0Sj/PETopiBVoagGwXafv6notFl54gMOvzj5cq2e8cpNh8IX8haCMNqL1vDZxWdakgocNVTTg1rEC0fYEd5+pjuF9iMn2DKuzUT
X-Gm-Message-State: AOJu0Yy3Y3vs9CXUJEejy4MkeZzJaniLac5GYCDebl9hbjUWSvwlI/QQ
	gp3CUrH5CH1gV39USIkU0GgBr+tD1EBg+Y0+BMxteDudZ3/afdMM7s+8RkdkG5p4Hf6SC0SfnRO
	p56VG/DQOmyk6poGSZzOPi7JF8mNnQO71Yv8Ud6WlCnjuIhQOFpCgXS0=
X-Google-Smtp-Source: AGHT+IExxV+PQle6/fPN4vrkA30l/cKLEZGt3NQDFvmJHYW7WCRxhrKu9B09fTCL6n10W9ekW76AdfTZUtyk9JcgU5c0XIGROiPv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d17:b0:7eb:81d6:c92c with SMTP id
 ca18e2360f4ac-7eb81d6d1a0mr9819439f.0.1718053323080; Mon, 10 Jun 2024
 14:02:03 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:02:03 -0700
In-Reply-To: <000000000000b3c7fa061652665f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007140a061a8f7624@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
From: syzbot <syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	usama.anjum@collabora.com, vishal.moola@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ed74abcd1da0244c3c3be865587dc2727148ee83
Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Fri Apr 19 11:50:27 2024 +0000

    selftests: mm: protection_keys: save/restore nr_hugepages value from launch script

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128d1bce980000
start commit:   977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=7fd4b85697bcf2a9daa2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c667cb180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149278f7180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: selftests: mm: protection_keys: save/restore nr_hugepages value from launch script

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

