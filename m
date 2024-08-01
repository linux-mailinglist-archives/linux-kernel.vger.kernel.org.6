Return-Path: <linux-kernel+bounces-271321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C09944CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B7AB26D54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD571AD41A;
	Thu,  1 Aug 2024 13:06:18 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A31A4B31
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517578; cv=none; b=G447Pzmf3ucNagSk3nX4+2nuKfkPYtRSmEd7s1q7JcSE9P/+kso7E9vSEXOOl+rVd3uKao6e6cJu0oZyH7DjxlW5tdUozfW8WGmh3u8ze47uc2DQQH1suyG551qiwi8jVDU/7bgwjCZ+FDCpYoguNmhAnKlcbOqE4hkfjK8Begk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517578; c=relaxed/simple;
	bh=YooCTfRSOC9hS390XEUyGdMjj+dNZC2oriYOxRWYhyI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UK5fpQjj49uwCCkC4CO2xlhh3ab8Vx0sNtZwT6JAZJDl6Tz5au4KDhGNjdSAZxVyw8LzB87i4AJgfrvRzKwkEzeE/zpu3PU0rKr3e9yxbByM0hqr1WwWHk9HMcZoO9RhNv16+AbzwhAgjzjgOx2f2J1Z1m24OMgOlSaGjnj2QQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so1001043539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517576; x=1723122376;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qVDkxZfCD4I5nw3v+jCtkqkddm3ZsUlbi41dxQUsOI=;
        b=Suanz0ZaR4IwMANMzd4TzDkMHDkCYIEDvrSAIYE95UbFioBbLnRObBj84yO6aIeaRA
         lcgU/OxvsoG6IScIeAY9ckiCQivUuPwblMl5oC6gALA9s5V6OTN/cT/qC/ix5r0lkOMU
         YtNLWf+MGEBrakNzKsSMx13iAdxzbgiO9E3I+tjjLLmv1hXzlKbkUF/yZvvK4rpeOmdX
         es7zEsufd0tS6MDUlm+NIFiXnbSKoDFSz/c9nVs9nL3Px2//Ro1YW1ZXDkWh3jrzcxaW
         iEiBc1pYUMNmDYBevKGKzBb542dFZR8XiUV+iG4tY3teLHK6TSNPDCin0yJiUu88OTEn
         JErg==
X-Gm-Message-State: AOJu0YwOZ//AH/UdhnQ2AW9lWHBPHl4kN9L42YIXc4iBqLRwozo2IChz
	xYAuwPVIIECJYv6putXyx5eJIMvY0Y1R/HjUvGQb/TCbLdJZIk0NKseJ/4TQ3OVKm0zi3S2K5DH
	Ga8SAqIkcVmv9J4kwe0Z4YoZ3Uig+JcpZ0wbAxfWaEWF/avNXbSHw/Uw=
X-Google-Smtp-Source: AGHT+IFytKzkeWSGZ6KB1N8xCuCrDp5WJh0hULT1Hzq5FCDRDPvnr9HLEVNfyAo6MvU9azjXqn8A2qAWcHfumRUoiwWLIkXNhYx1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6418:b0:81f:8285:d3ef with SMTP id
 ca18e2360f4ac-81fd42bcd50mr329639f.0.1722517575897; Thu, 01 Aug 2024 06:06:15
 -0700 (PDT)
Date: Thu, 01 Aug 2024 06:06:15 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b2d3b061e9ee030@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

why folio not inited?

#syz test: upstream 2f8c4f506285

diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..a830b22c9708 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3754,6 +3754,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
+		printk("err: %d, folio: %p, in: %p, read_folio: %p %s\n", err, folio, mapping->host, filler, __func__);
 		if (unlikely(err)) {
 			folio_put(folio);
 			if (err == -EEXIST)
@@ -3787,6 +3788,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 
 filler:
 	err = filemap_read_folio(file, filler, folio);
+	printk("err: %d, folio: %p, folio uptod: %d, %s\n", err, folio, folio_test_uptodate(folio),  __func__);
 	if (err) {
 		folio_put(folio);
 		if (err == AOP_TRUNCATED_PAGE)
diff --git a/fs/namei.c b/fs/namei.c
index 3a4c40e12f78..3f72aa8d604d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5272,6 +5272,8 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
 		page = read_mapping_page(mapping, 0, NULL);
 		if (IS_ERR(page))
 			return (char*)page;
+		else if (IS_ERR(page_folio(page)))
+			return (char*)page_folio(page);
 	}
 	set_delayed_call(callback, page_put_link, page);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8c1e7f9a609..d581cea14316 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -459,6 +459,8 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
 				page->index, squashfs_i(inode)->start);
 
+	printk("folio: %p, isize: %d, pidx: %d, idx: %d, fe: %d, %s\n", 
+		folio, i_size_read(inode), page->index, index, file_end, __func__);
 	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
 					PAGE_SHIFT))
 		goto out;
@@ -478,6 +480,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	} else
 		res = squashfs_readpage_fragment(page, expected);
 
+	printk("res: %d, %s\n", res, __func__);
 	if (!res)
 		return 0;
 
@@ -489,6 +492,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	if (res == 0)
 		SetPageUptodate(page);
 	unlock_page(page);
+	printk("out, res: %d, %s\n", res, __func__);
 
 	return res;
 }
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 6ef735bd841a..7e41196ea8de 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -49,6 +49,8 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 	/*
 	 * Skip index bytes into symlink metadata.
 	 */
+	printk("folio: %p, isize: %d, idx: %d, %s\n", 
+		folio, i_size_read(inode), index, __func__);
 	if (index) {
 		bytes = squashfs_read_metadata(sb, NULL, &block, &offset,
 								index);
@@ -93,6 +95,7 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
 	flush_dcache_folio(folio);
 	error = 0;
 out:
+	printk("error: %d, %s\n", error, __func__);
 	folio_end_read(folio, error == 0);
 	return error;
 }

