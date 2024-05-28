Return-Path: <linux-kernel+bounces-192168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30C8D196D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3AD1C221FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E98616C854;
	Tue, 28 May 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHQYcMfl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869816C698
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895774; cv=none; b=Y1PDxAVOV8U35nm6AUX++/qr/DYLXF0edUh1mwfGtv0ZMA20wn0ENuQFdkUjFO+S4bxHyOvANEzDJJDUw3sWyl18hwvy7ggtMH4kaBI+eTr4IiueP/sOn7ndZi8Em9tK5HvAxKkCbg+0wyPESq+AWf5tHEBBEgESx13WwGAFsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895774; c=relaxed/simple;
	bh=Fhx6TTOqibqI01CNB0tq59za6TZyBibaHI3P84V+iE8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNC3vzOamn3Qb2Esl7vhYioQD52nrHAsgY5Dyi4WVkqUqFNKNz6+Z8LTz4tOXbm8o5R7uQmJ+vp4QkK+74IthSTOovEcjkhMg/nxvIgdzwOAX7OIsPSi6tHoFEe3TivMhy+oD7nM7RvJNqRdIqUyMlroM8KLmDZYNHtp2gJHWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HHQYcMfl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42108822e3cso22329215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716895769; x=1717500569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5oY5QDj/F2VjFpREI5FnfmpEsPpu1JW9qQI7HQyBXo=;
        b=HHQYcMflVg+OtmBs1SqR7Lzq+2HtlGvu7h2cPgb9t8GSsriHxCgP0BINbIUHfP8AhL
         IkbKxLxoZSYIMcaOq0c3jaU/7wAUppJEXuuLBJjomkm44xUXb1MFNrEX2ySSS+v/W7oM
         IwcM++5Z01QH5z3o+M1UbaWOKzpDb2MKP1BapgzGVkUXp07UmfN7XcV0f2TFEk7Tkow0
         rpkgaQpNafIgoJ4hRXza24dH6TjSw4enPuoLu0Rg2tNsu4gFsp29od8YavJLUaZFYC/u
         BH8kqxmo0VQ9408RAOVlWkFWRfbQA4TSCwZjUjt2K2QR8dz+j2OV+HvwwJ6UFlDhs9OP
         AeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895769; x=1717500569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5oY5QDj/F2VjFpREI5FnfmpEsPpu1JW9qQI7HQyBXo=;
        b=mw0gqZMWk6+wqOlRPqoa2010awmAV5gtMXG/kzmMxk2AosRRIB0Dt814Bashkl3Brw
         muSFcBu/bDQl2WPbE7p8C5oW4J64gaRe/Z3ec2v0O1IWgS5AqyYCw5c4TeCX5Izya6pi
         QVZsAKcmlU0XLS+FTe4S7X3/8+kwyf3Xdiq4mrgZB7lEP9cULScmoi2VAIvJOZAgmzKE
         De6OW8KX2qv7Q1I6pZZVo1URA1BbKIOd4jrXv3hK3XGWpnYNfwX9FA3QvVcsqehj1ufn
         2GVOoo57t/XabnZWzGruxh4mn3d+Xk6TM2p815JdUJBqiRWlAp3npah3JJlulS5g+z33
         sLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWisT7mNndrAEF89s9QCsQIX+lOSQeFtnLxrsHuvsw33gIg4zs4s+uMkYQIDLR85JjMKIp0SBlqAW11ToNz5MOVyTYx7jzm4CO5m4dJ
X-Gm-Message-State: AOJu0YyOLaPNYymovwRBqyOKTPVaCoC47/zCsFSp+Tg0bpZemukZt0+o
	rifCX3ZyZ0OPgZYJnE4BuRkZTrvy3ZSrhthPZAdzTXOSGHm33zDbwV9k4qke4sg=
X-Google-Smtp-Source: AGHT+IHEhP3H8xEy5lW4Agk2rSDU8yNaHdbHbk2CspUGWoXeNFtS8ar0NeKjZ/WLL0Q89fYZoR3UBQ==
X-Received: by 2002:a5d:47ab:0:b0:357:a6e3:8748 with SMTP id ffacd0b85a97d-357a6e3877emr7780899f8f.1.1716895768949;
        Tue, 28 May 2024 04:29:28 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08a8bcsm11458124f8f.44.2024.05.28.04.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:29:28 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 13:29:26 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlXAFvEdT96k5iAQ@localhost.localdomain>
References: <0000000000004096100617c58d54@google.com>
 <000000000000f9561b06196ef5b3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f9561b06196ef5b3@google.com>

On Mon, May 27, 2024 at 05:50:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c114aa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17770d72980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10db1592980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

#syz test

From 917fa54481422c650425c8b0330439f8a3308479 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 10:43:14 +0200
Subject: [PATCH] mm/hugetlb: Do not call vma_add_reservation upon ENOMEM

sysbot reported a splat [1] on __unmap_hugepage_range().
This is because vma_needs_reservation() can return -ENOMEM if
allocate_file_region_entries() fails to allocate the file_region struct for
the reservation.
Check for that and do not call vma_add_reservation() if that is the case,
otherwise region_abort() and region_del() will see that we do not have any
file_regions.

If we detect that vma_needs_reservation returned -ENOMEM, we clear the
hugetlb_restore_reserve flag as if this reservation was still consumed,
so free_huge_folio will not increment the resv count.

[1] https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/T/#ma5983bc1ab18a54910da83416b3f89f3c7ee43aa

Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..a178e4bcca1b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5768,8 +5768,20 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * do_exit() will not see it, and will keep the reservation
 		 * forever.
 		 */
-		if (adjust_reservation && vma_needs_reservation(h, vma, address))
-			vma_add_reservation(h, vma, address);
+		if (adjust_reservation) {
+			int rc = vma_needs_reservation(h, vma, address)
+
+			if (rc < 0)
+				/* Pressumably allocate_file_region_entries failed
+				 * to allocate a file_region struct. Clear
+				 * hugetlb_restore_reserve so that global reserve
+				 * count will not be incremented by free_huge_folio.
+				 * Act as if we consumed the reservation.
+				 */
+				folio_clear_hugetlb_restore_reserve(folio);
+			else if (rc)
+				vma_add_reservation(h, vma, address);
+		}
 
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
-- 
2.45.1

-- 
Oscar Salvador
SUSE Labs

