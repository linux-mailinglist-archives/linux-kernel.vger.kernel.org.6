Return-Path: <linux-kernel+bounces-271006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD6944844
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C21C229E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54986170A35;
	Thu,  1 Aug 2024 09:27:41 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DF16F0C6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504460; cv=none; b=CW83As9H/jMHJcB3yrAwx2s9Y1pe007vPaVq6TJRjsYGR1l825Zy59HsOZxY+n/et4zX2wgrDa9sqVvw71/dSJcT8JwhBSWFdEAKOD0mXlzEqg0jZEnBqYV4K5C+mvdCtJthTPJ2vom2QstxB/ZHBJiG3LUualHzP1+5cQRbpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504460; c=relaxed/simple;
	bh=d8xVrIxIJS/LZCYRzRHq2tAQuVH6PQJxFYCVBQiDgxc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P2E5Yo4irDnMi+13V9DnaCnphHvRga+7eEPUzj7Pdr99jaSLRXkfgOMEguWwPr0njrvmD3GJ7TCVDAw8oRLHz6N9jQaDzRPEov4FhYUYHtj02Url8Hi/JVwrAjhrnPsL4aPz7I4Xg88snmcmwJop7fK4rxpTiYv/pkHH/vPebWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81d1b92b559so963694839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504458; x=1723109258;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIonP/BFiJflBMTc5yK7BLFJBcF91eCVmFXkU7cn3LY=;
        b=JgjBjV9UCsoo+aZdqqGzVjqZhwVq/nW0J/JaTgd4e7jpquL6MRUkvoxYp1FXNXHzmS
         XDEuR/f8YpC1v35m7t/hz3qWg6HMPn8TOd/O4xm0cmBwitjfMlKanSEvGYiiGtcL+vfF
         O6ge5qHn60D9KwT3M63fIjIiE4NKpcHTWUg4NbS4vqJGH2r4xLRxhuEhyaRBGX/7x+ZN
         Mx91DymSjP977ztKK2kjeWXZBvqw1p0fWwIri/LR39cgZE5oY/omAPAupzyV6K1ApKIS
         xk7Wy0kobpk+ufbDoBGV/i0Lw542j/mjl8TKm2DiX4LoUw4dUm4bShdbsPOahtVLNE7u
         3kyw==
X-Gm-Message-State: AOJu0YxbgNFq2a2/8x2zyasfHVXONvoJ/huWTt9BWyTUfhDtWHcrSP8T
	8VU7hCDdHjgseBz4dDALAfZUnPDOC4NyBPNr7KCaqAJthv+GdW3Lb9Re6h+rIhNH599MIFE1iXl
	cheebouM4marEPtqEkfAZmwjCz2i/PIHD16BqojJlAI/aBGYqIg0CvEs=
X-Google-Smtp-Source: AGHT+IHLgFKnuBEqRJxkd9FIZ0AO9h8M8dY+FcnX2LZ9gEYcpAItjcMLn5RNT1JHz29gWGvwp8pBzO3sV+o+EMaB1bAjl1wy8SCk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14d0:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4c8c9cd172fmr86596173.4.1722504458622; Thu, 01 Aug 2024
 02:27:38 -0700 (PDT)
Date: Thu, 01 Aug 2024 02:27:38 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000616c0e061e9bd272@google.com>
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
index 657bcd887fdb..b76a13395299 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3754,11 +3754,15 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
+		printk("err: %d, folio: %p, in: %p, %s\n", err, folio, mapping->host, __func__);
 		if (unlikely(err)) {
 			folio_put(folio);
 			if (err == -EEXIST)
 				goto repeat;
 			/* Presumably ENOMEM for xarray node */
+			void *kaddr = kmap_local_folio(folio, 0);
+			memset(kaddr, 0, folio_size(folio));
+			kunmap_local(kaddr);
 			return ERR_PTR(err);
 		}
 
@@ -3791,6 +3795,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		folio_put(folio);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto repeat;
+		printk("err: %d, folio: %p, %s\n", err, folio, __func__);
 		return ERR_PTR(err);
 	}
 
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

