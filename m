Return-Path: <linux-kernel+bounces-364822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E499D9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E37282003
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1991D5AB6;
	Mon, 14 Oct 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V48H5OWv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103F1D1E62
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945647; cv=none; b=I87UgBiYUOJmmCmJ5rEzePpDvsj6OuPzvc75LlZMNGu5hVBG4mTl+S8vmHVD8fPl0VBXFiEb5T9f9VAqGoMWl2NZP4tEmXlY5yFsOjVDX1xcC03B11fox9PWPAYLRxuAkh5iMe4e/ZTToU9BgOAWmX3dlmROkfpeLpeMmiorB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945647; c=relaxed/simple;
	bh=RsSbuU9TgaDj4zfwy0Zrk3JTIZTl04qcNsIjOOe9hrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2JG9C1kiSBNYf3zvTpUacearUjxcihij/fu8UI4f0Hca3OC+l6O8LgSCLtD7ob4H+Sab9zQhk/k7maHsF/MDVoBfm0axC1+DvNQTKLiQuVwVk4gt+gDVD/EtMtRN0zbVLrVFV5WOF7FU0wdkVmxupXVGd6FbfbB6AXHoVgFhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V48H5OWv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728945644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OY/5Z0+9KmuEdIqGJ7wBdFLQRrKe2T6MRM5knQPxYKo=;
	b=V48H5OWvWhYM6Zi+I1gUtFEw9L2bQXErJFeLg8bJMJBY5Yn2tTwDbA+KHtLOBfCc0GXaOh
	y8iJbtxpCh16DB3Z/KGmfjE4gatiyJ0c6oI1N+27JDEus2RUzPaHmptvSBqw8vYStOHOq3
	TRy9DinXlkjy9WcQdm2OO0fbCYHwbdc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-raOyuvHLMr6P9vuGHDmKaw-1; Mon,
 14 Oct 2024 18:40:43 -0400
X-MC-Unique: raOyuvHLMr6P9vuGHDmKaw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CA8A195608B;
	Mon, 14 Oct 2024 22:40:42 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.193.64])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A5D73000198;
	Mon, 14 Oct 2024 22:40:41 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/core-api: swiotlb: fix typos
Date: Tue, 15 Oct 2024 00:40:26 +0200
Message-ID: <20241014224026.1838525-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Correct references to swiotlb_tbl_map_single() and
swiotlb_tbl_unmap_single() in the documentation for swiotlb.

Fix two small typos that went unnoticed in commit c93f261dfc39
("Documentation/core-api: add swiotlb documentation"):
swiotlb_tlb_map_single --> swiotlb_tbl_map_single
swiotbl_tlb_unmap_single --> swiotlb_tbl_unmap_single

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 Documentation/core-api/swiotlb.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index cf06bae44ff8..9e0fe027dd3b 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -295,9 +295,9 @@ slot set.
 
 Fourth, the io_tlb_slot array keeps track of any "padding slots" allocated to
 meet alloc_align_mask requirements described above. When
-swiotlb_tlb_map_single() allocates bounce buffer space to meet alloc_align_mask
+swiotlb_tbl_map_single() allocates bounce buffer space to meet alloc_align_mask
 requirements, it may allocate pre-padding space across zero or more slots. But
-when swiotbl_tlb_unmap_single() is called with the bounce buffer address, the
+when swiotlb_tbl_unmap_single() is called with the bounce buffer address, the
 alloc_align_mask value that governed the allocation, and therefore the
 allocation of any padding slots, is not known. The "pad_slots" field records
 the number of padding slots so that swiotlb_tbl_unmap_single() can free them.
-- 
2.46.2


