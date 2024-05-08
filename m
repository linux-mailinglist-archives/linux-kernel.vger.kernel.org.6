Return-Path: <linux-kernel+bounces-173000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D98BF9E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E307287E52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21067E103;
	Wed,  8 May 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C4MV5gEp"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10957D40E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162187; cv=none; b=kjA1ph5vWjZfIBJySZ2fXNzR/WBiC+HJPn6ugmbd/CBbcfnxKbHEg64QoidHpavgXQFPgJZQYPFyKAESBgwpjs6fFjVNKLEm5n66sVUmNFHynJhNFxizx9x8bOTkmGHdU8RaJfCIykce+zbglzme2PR5jG8bsMEdGLliWHbPphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162187; c=relaxed/simple;
	bh=snJN4Df6DU019UCJtAmXu+NvV52neCa6WX3l+iJA2Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bur26K9d9d8UQE6XtU19v6ZHesb+hxO+F24lwrlqCbop5rtQtJeNGqxcO0+8uTD4lHTKUhe9+s9v0KBT7XNm10SpLg9WZgPnqVXzWlqYKNhYFzBnDKrvEVaRkWSFg0vJ/OoJMVFBA29EtW09l/RwTKwQTqsVkJlK09XMxaue5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C4MV5gEp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715162183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkuupc/bTWDBM/qgtKXvWiw928oiixEs1ZTUcK3CiX4=;
	b=C4MV5gEpzMK+SjA3+P6MBs1obUWGxx4y+XHTher0dAqLtRXL2+27HAevrFHrkd1gEoHvdq
	MbWsBs74UJrR7m8btrI/nsWzxPm9+vpq/MJ+TFqO1TjatRLQW5jI91sxApzSnfQmrOTltl
	DdviWIuuyK0ImKOuOX1iDQKJ6ycJX+I=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 08 May 2024 17:55:38 +0800
Subject: [PATCH 1/4] mm/ksm: fix ksm_pages_scanned accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-b4-ksm-counters-v1-1-e2a9b13f70c5@linux.dev>
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
In-Reply-To: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715162174; l=1280;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=snJN4Df6DU019UCJtAmXu+NvV52neCa6WX3l+iJA2Lw=;
 b=sii/wcJR6QpIF+eWSdTOUi950cTGX4hLZNmHf4BI4ooy5PMU0VGDAd1Dg/mYKZpIk3WVRH171
 nEXbbd5ZrOcARiEU5K4yf9CsPeKr1ytC/0lQeZAUGjvu0Qf2mIXD4M7
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

During testing, I found ksm_pages_scanned is unchanged although the
scan_get_next_rmap_item() did return valid rmap_item that is not NULL.

The reason is the scan_get_next_rmap_item() will return NULL after
a full scan, so ksm_do_scan() just return without accounting of the
ksm_pages_scanned.

Fix it by just putting ksm_pages_scanned accounting in that loop,
and it will be accounted more timely if that loop would last for
a long time.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e1034bf1c937..0f9c491552ff 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2753,18 +2753,16 @@ static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct ksm_rmap_item *rmap_item;
 	struct page *page;
-	unsigned int npages = scan_npages;
 
-	while (npages-- && likely(!freezing(current))) {
+	while (scan_npages-- && likely(!freezing(current))) {
 		cond_resched();
 		rmap_item = scan_get_next_rmap_item(&page);
 		if (!rmap_item)
 			return;
 		cmp_and_merge_page(page, rmap_item);
 		put_page(page);
+		ksm_pages_scanned++;
 	}
-
-	ksm_pages_scanned += scan_npages - npages;
 }
 
 static int ksmd_should_run(void)

-- 
2.45.0


