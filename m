Return-Path: <linux-kernel+bounces-339960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0AE986CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B8C1F2327B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE14188CA5;
	Thu, 26 Sep 2024 06:42:17 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A3188A0A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332937; cv=none; b=pzqfBMF7jnrd8NwZyboj/fXLgoN14njOYFiZ8weHboBvrWCAart/odpmX08O57odV9dlZdr9yf5OhnYlkxVuXlr0IAG6bk6fDK5SEnpm98/7No0bE2bUHoFBn68mfPEjtV5GVZ57HT4J8cthTdzLFiz6Cga7sIWsFKj16p/JSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332937; c=relaxed/simple;
	bh=f7Nq8ZDTD1+j9voujtl94g/f7w0ytOyvL4kDqort0po=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IiyVfvSUH6Vbc+nWKpFeQHwcrECQwGaS655grBlNyN8ekv2yKBrNA6DjAQwRSO/cpZrWWLt71WxN7WD2wHnQlhVQHWnzVi/oG4zTiqa090wtIJHtINUlXg3fKiwIiZNou/4A83XoC23JGPRgclJ6OMyfZcrdBuGlYEuuzl9Gj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a19665ed40so6221645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727332935; x=1727937735;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkanA4ajI8Bhw9rIcbajl0B0RrqXruyIlBN9NlK+x+M=;
        b=wzG0YCvt+qWMk8WBCkbsls65HERtczZXD/F9gVUgCQnPwQiYInAJPDPQqsW+g7USdl
         J9ejja9PEDz9o7+WVMMxOyvnb5QytvHGnygc7ZaRE9C+w0HUvcjW/xsS4EVoSvA73ZjU
         CgNDSspt9+RD/lIIXtzYi/F51/xNhQnAraAwy+8CTErwihDowxo543EA477SnD0ug8Ym
         tNUvzvSj8VjRfqUx69wc//9QLLMwILNv1bamZXvTAyeOCjtpkl8yQblW7fCzvz0AClDP
         LEGYDEXxKJKv42LLWxQzOqbjAHgJTqlEXvpn5j66LkmRMC6Lk8xy2HPpN8gpNzvaCf9I
         HZsA==
X-Gm-Message-State: AOJu0YygGtRo2DzVuAPLh2sIbjaa2zoxix4VNJh7xyyPKn5EaJ9nTWOx
	4a7c1IQTtesNphJkSSPZXog+HrtO5CODzhlDkVji4y/kSG5pdgTSddbQOxzLfPGP4Nfte5Ezf7Z
	NacKGPaJiP4PpFBGTT0rT5oAadLhLxOM7dYQswOolEkvUnqewnaxYmWI=
X-Google-Smtp-Source: AGHT+IEE+UyqTIBCIFJ7ae1Yfk23zHonbArzwjeQdfpTgAzmyCBtaE2SguVLlH5SFZksw13fZHAZWDWXal4GDpB/7mER3OtKWY6B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:3a0:9238:d3c with SMTP id
 e9e14a558f8ab-3a27688a1b7mr14533005ab.3.1727332934732; Wed, 25 Sep 2024
 23:42:14 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:42:14 -0700
In-Reply-To: <66f46641.050a0220.2af13c.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f50246.050a0220.211276.003e.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [iommu?] kernel BUG in trace_dma_unmap_sg
From: syzbot <syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [iommu?] kernel BUG in trace_dma_unmap_sg
Author: hch@infradead.org

#syz test

From f7cfc7e4d1f2796f688430799621c1575eac7218 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 26 Sep 2024 08:35:24 +0200
Subject: dma-mapping: fix DMA API tracing for chained scatterlists

Struct scatterlist allocations can be chained, and thus all iterations
need to use the chain-aware iterators.  Switch the newly added tracing
to use the proper iterators so that they work with chained scatterlists.

Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/dma.h | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index f57f05331d7385..569f86a44aaaf4 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -176,9 +176,9 @@ TRACE_EVENT(dma_free,
 );
 
 TRACE_EVENT(dma_map_sg,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 int ents, enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, sg, nents, ents, dir, attrs),
+	TP_ARGS(dev, sgl, nents, ents, dir, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -190,17 +190,17 @@ TRACE_EVENT(dma_map_sg,
 	),
 
 	TP_fast_assign(
+		struct scatterlist *sg;
 		int i;
 
 		__assign_str(device);
-		for (i = 0; i < nents; i++)
-			((u64 *)__get_dynamic_array(phys_addrs))[i] =
-				sg_phys(sg + i);
-		for (i = 0; i < ents; i++) {
+		for_each_sg(sgl, sg, nents, i)
+			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
+		for_each_sg(sgl, sg, ents, i) {
 			((u64 *)__get_dynamic_array(dma_addrs))[i] =
-				sg_dma_address(sg + i);
+				sg_dma_address(sg);
 			((unsigned int *)__get_dynamic_array(lengths))[i] =
-				sg_dma_len(sg + i);
+				sg_dma_len(sg);
 		}
 		__entry->dir = dir;
 		__entry->attrs = attrs;
@@ -222,9 +222,9 @@ TRACE_EVENT(dma_map_sg,
 );
 
 TRACE_EVENT(dma_unmap_sg,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 enum dma_data_direction dir, unsigned long attrs),
-	TP_ARGS(dev, sg, nents, dir, attrs),
+	TP_ARGS(dev, sgl, nents, dir, attrs),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -234,12 +234,12 @@ TRACE_EVENT(dma_unmap_sg,
 	),
 
 	TP_fast_assign(
+		struct scatterlist *sg;
 		int i;
 
 		__assign_str(device);
-		for (i = 0; i < nents; i++)
-			((u64 *)__get_dynamic_array(addrs))[i] =
-				sg_phys(sg + i);
+		for_each_sg(sgl, sg, nents, i)
+			((u64 *)__get_dynamic_array(addrs))[i] = sg_phys(sg);
 		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
@@ -290,9 +290,9 @@ DEFINE_EVENT(dma_sync_single, dma_sync_single_for_device,
 	TP_ARGS(dev, dma_addr, size, dir));
 
 DECLARE_EVENT_CLASS(dma_sync_sg,
-	TP_PROTO(struct device *dev, struct scatterlist *sg, int nents,
+	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 enum dma_data_direction dir),
-	TP_ARGS(dev, sg, nents, dir),
+	TP_ARGS(dev, sgl, nents, dir),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
@@ -302,14 +302,15 @@ DECLARE_EVENT_CLASS(dma_sync_sg,
 	),
 
 	TP_fast_assign(
+		struct scatterlist *sg;
 		int i;
 
 		__assign_str(device);
-		for (i = 0; i < nents; i++) {
+		for_each_sg(sgl, sg, nents, i) {
 			((u64 *)__get_dynamic_array(dma_addrs))[i] =
-				sg_dma_address(sg + i);
+				sg_dma_address(sg);
 			((unsigned int *)__get_dynamic_array(lengths))[i] =
-				sg_dma_len(sg + i);
+				sg_dma_len(sg);
 		}
 		__entry->dir = dir;
 	),
-- 
2.45.2



