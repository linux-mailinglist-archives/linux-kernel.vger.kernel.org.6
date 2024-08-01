Return-Path: <linux-kernel+bounces-271208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF10944AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114D4B27B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43419E7E3;
	Thu,  1 Aug 2024 12:09:00 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF4194AFE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514140; cv=none; b=gNLZEtdkuB66hc/OPJHdLg4QP/dPjDCKylV+r4DxXfMqPg5ScFGpoGmpjcXnJocLg1jz1jIj2yZzKHcaY+KrttATslPdlpjK2xFPheTsgzJSCFY6xbnU2/IzXXRhedAMIPvwFOItEF+xbGvpxWl71CTG7jPpoRXxKwP7UTs5c2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514140; c=relaxed/simple;
	bh=SqFmdthhxjhZoN+MbRwDB+pCfp3HdWMh/DwiMuR+0ik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qYF9kwoWlRahuk2vAjmATi18y7AAZyhiDkzeJoQ28bbBkdsA6OBOv2kCmAIp6xb/JEGYyfl/3h2R32yZzJcDmLVa90A4q1fQ6JAHhMhG/VPMr/rVdCqBZimFQU+g32XZ+Wf+dxSamEEeJHnoUQff44fGD99Yiur5jLJf5nnseUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso667792839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514138; x=1723118938;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kghZQjLzdfxbI6zQtAYGeWfZsShZPKK3M+yNsz9Ej2s=;
        b=bOY0IxSCfqix64WKjvteq4UQNvirm/zJAkd8Y5ctvKVugy6qPlDbpEWrJ6KGOesCwR
         ngyChuH2BlyNPw20nQxkX6cOCh5X4U1xI2TLNGii0Oiiln5BS6XRo284Ocopu91SCRmW
         SlzscJXnuVQPSbBKJtHx3IIE+dKr8O8zNwYMxNMqOZq2EV0McSKJk97jky9hBcfWJcax
         83vfWSh7W+uW5F9muXQEIIHMouGIVpOu2n0V7NW/e6I/7Ko2c4qyN63IB6s8FMw/uRWr
         HQixij6hlEN5HLolh+iTysGB34eHbW9tan+Y6PIOAtEBzjo1hsZYLyAvJhcU4bhOes4n
         NPsA==
X-Gm-Message-State: AOJu0Ywr2BSu7mL58D/RLW/Z5hwZdTtwuJwO4wmPvmac4IYJ8kos9zCk
	OPZkMwcSjpWd+TpGRvAbbRQ+nglusVZHd5b257n9Xvu+/by2u+V5NDRAW//UcUwO+Vdms7FqZeh
	GV+pDdleW/xRaFTLO8bEO01TYTTcn5mYBdq+XawSA/5wMBT1G4MKz+SI=
X-Google-Smtp-Source: AGHT+IHZn7eAkztxmHhviOhky2gK09UVELWBmVJqXWAOVbq6Any2FNxkN5aHXvqrALmyVrl7UtpXLg3isWDIzrF0Cl9ElTTo3wRy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8510:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4c8c9b31021mr98985173.1.1722514137921; Thu, 01 Aug 2024
 05:08:57 -0700 (PDT)
Date: Thu, 01 Aug 2024 05:08:57 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fcb37061e9e13ec@google.com>
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
+		printk("err: %d, folio: %p, in: %p, read_folio: %p %s\n", err, folio, mapping->host, filter, __func__);
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

