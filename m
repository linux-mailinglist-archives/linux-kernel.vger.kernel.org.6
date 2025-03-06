Return-Path: <linux-kernel+bounces-548355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47854A543D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF133ADF9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE61C84B8;
	Thu,  6 Mar 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TP7pAvaV"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD3184E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246868; cv=none; b=kVLzdXsLJVZSQR+ODEeuadpvNhTOEUheIRVLawOQnRvXn2IPyyfZoprVnIkeEyPgN3Kpzj241rJwbocHUYUp4UFDbXp/1cwj2/LOzBY6d1MO2D6A0rd4c4cVzsUkUP5IqLw1MDOSLGa7+n+KYWqwulCAxpuEGLtVfKdZbHZp9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246868; c=relaxed/simple;
	bh=IKUqieU/P7COi1kDWcYTEF8cXcJQU0Cl9e3vNe1QNQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QUrMC3aQT63HBewBZAomjkueL6gzWgwKcF6Sq+eg1c9PfD4iBUIiL3oGY+uvJ6Uro2ejqhzohSta8Wv1zSLr7A+ib07v9BCd3YzAEKFDtFGGRikxz0txwek+dPUQabYaE+7ouIb8Kyt3nsJpFgJ4xYcpLC8A6ynOEFcWry/q70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TP7pAvaV; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250306074102epoutp04450c8e7db06746413f46cb11bc91fa2a~qJsvMLdx_0460204602epoutp04I
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:41:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250306074102epoutp04450c8e7db06746413f46cb11bc91fa2a~qJsvMLdx_0460204602epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741246862;
	bh=+BcYtXY3TNCTI9bTILp9kA5TJ6CO/fCWbh8+ui2EJZE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TP7pAvaVCf2JIQRIjYvDQCc98pgRGwEzwaXHlg+9npR0i50LpBI7460fI5ej7ApxG
	 C1ntbPkN8IyJwMc4N+q3cogmanTnGkaxs62WdFSbo/hS1AaUGpACX4kAJXkzxedCne
	 LbEeieWL2PZeJluGQ+VejtZyAm8AIZGqq4OYtzEc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250306074102epcas1p26db72044cac9fc5ad35bc25620d57683~qJsulLgnq3185131851epcas1p2d;
	Thu,  6 Mar 2025 07:41:02 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.249]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z7hDY468hz4x9Q3; Thu,  6 Mar
	2025 07:41:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.AB.23869.D8159C76; Thu,  6 Mar 2025 16:41:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f~qJstzgcQv0358703587epcas1p4T;
	Thu,  6 Mar 2025 07:41:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306074101epsmtrp11f529e534244b62ce4ee1f99afb80464~qJstx3QsH2853928539epsmtrp1b;
	Thu,  6 Mar 2025 07:41:01 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-94-67c9518d8709
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.C0.18949.D8159C76; Thu,  6 Mar 2025 16:41:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.238]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250306074101epsmtip16dc04253f077b5685d15b9ca4bb30795~qJstoXnpM1818718187epsmtip1C;
	Thu,  6 Mar 2025 07:41:00 +0000 (GMT)
From: Sooyong Suk <s.suk@samsung.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org
Cc: jaewon31.kim@gmail.com, spssyr@gmail.com, Sooyong Suk
	<s.suk@samsung.com>
Subject: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
Date: Thu,  6 Mar 2025 16:40:56 +0900
Message-Id: <20250306074056.246582-1-s.suk@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmnm5v4Ml0gylnpC3mrF/DZtG9eSaj
	xeVdc9gs7q35z2qx6O8Vdot7dxvYLc7/Pc7qwO6xc9Zddo9Nnyaxe5yY8ZvFo2/LKkaPz5vk
	PDY9ecsUwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
	lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQ
	wMDIFKgwITtj388DzAWrRSuuvt7E2MB4T7CLkZNDQsBEYuqDJUxdjFwcQgI7GCU+HX7CCOF8
	YpT4fKmPHcL5xihx5k4TO0zL0/3/2CASexklDnRuY4ZwvjBKbDj6hA2kik1AVeLNjZtAszg4
	RASyJJ6vTgIJMwv4S1z/dowRxBYW8JG4u2o+K4jNAlT+/tEDsAW8AuYSkydtYIVYJi8x89J3
	qLigxMmZT1gg5shLNG+dDbZXQuAau8Sa3Y1QDS4SU9/NYIKwhSVeHd8CdbWUxMv+Nii7WOJX
	30dWiOYGRon+Y0uYIRL2Eiv2d7KCHM0soCmxfpc+xDI+iXdfe8DCEgK8Eh1tQjC3/d50gQUi
	LCqx7Y0DhOkhcW2OP0iFkECsxOvFM9knMMrNQvLALCQPzEJYtYCReRWjWGpBcW56arFhgRE8
	HpPzczcxglOgltkOxklvP+gdYmTiYDzEKMHBrCTCe9HvZLoQb0piZVVqUX58UWlOavEhRlNg
	kE5klhJNzgcm4bySeEMTSwMTMyMTC2NLYzMlcd4L21rShQTSE0tSs1NTC1KLYPqYODilGpgk
	NThXG2ikbn2qutOAebUXh4hI3AWOSaqf5/lMm3Y/4MRr+y972X78jOa2ElMsWD41v8VLxul0
	w36fkxLn4v9lz3ZmmOnaeyom78jWF5Omx53M70nRMDy9v5ZxlfHrTyeWam7VFVgwV+vIvlKf
	kOLHdrNeT0s8ZsmT+ibv1Y3E2W7Kd8VjWW7JH3xyROHYmqZH7u9q/V6V7A29J7nnsu8Ss/xj
	xxZFSVT+WvFQcOFLC4FDrm7t9wtO+askrvFiSGjMyLtjOvHSW9aPfXF27xYGr30c8HBl2sc2
	ft4tLsc+iT6tY9zY37NNIzvedrf3hIuiUo479a69FHp06VBEybm093KR5RvVvPrUbbPfbj6u
	xFKckWioxVxUnAgAWXfzEAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnG5v4Ml0g/eb2CzmrF/DZtG9eSaj
	xeVdc9gs7q35z2qx6O8Vdot7dxvYLc7/Pc7qwO6xc9Zddo9Nnyaxe5yY8ZvFo2/LKkaPz5vk
	PDY9ecsUwBbFZZOSmpNZllqkb5fAlbHv5wHmgtWiFVdfb2JsYLwn2MXIySEhYCLxdP8/ti5G
	Lg4hgd2MEs9btjJBJEQlnv3+xtLFyAFkC0scPlwMUfOJUWLNrK1sIDVsAqoSb27cZASpERHI
	k3jeHQMSZhYIlDjxuZUdxBYW8JG4u2o+K4jNAlT+/tEDsDivgLnE5EkbWCFWyUvMvPQdKi4o
	cXLmExaIOfISzVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
	TYzgYNXS2sG4Z9UHvUOMTByMhxglOJiVRHgv+p1MF+JNSaysSi3Kjy8qzUktPsQozcGiJM77
	7XVvipBAemJJanZqakFqEUyWiYNTqoHpqtCEx7os8o3l3rUvI0UUj2htZPLaLmDiXszzenb5
	3n1SFtlPHU80PJ62w8yzsiVQd1vEVOvAqwE/LR7pL43IPVnQ7HLlUaHnTg//ncsnb5u6M/fd
	sknu3BbiH/Jf35LVmrVyknbP0n1nr3CGrQl4Hf38/g6v07dYOvu23ejT9Pkz60hbgYXYQd+Z
	msvnJVwwn7zm+IWjAXM2zfrd7nZrypuJEUJhT3ek/TFg+/foMadC5p+T6bWHZF/suKA340LN
	77rZ9oeDk0ttL+/tuPjhvIb/TY81qt9cIvkiyk3b9X7td0wJumrUr7RC0+1vh7uROLuVdvLn
	w42xxoWl1h3qU0+KF6ZqqPTOetw2o/e9EktxRqKhFnNRcSIAL76Q+MUCAAA=
X-CMS-MailID: 20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>

There are GUP references to pages that are serving as direct IO buffers.
Those pages can be allocated from CMA pageblocks despite they can be
pinned until the DIO is completed.

Generally, pinning for each DIO might be considered as a transient
operation as described at the documentation. But if a large amount of
direct IO is requested constantly, this can make pages in CMA pageblocks
pinned and unable to migrate outside of the pageblock, which can result
in CMA allocation failure.

In Android devices, on first boot after OTA, snapuserd requests a huge
amount of direct IO reads which might occasionally disturb CMA
allocations.

To prevent this, use FOLL_LONGTERM as gup_flags for direct IO requests
via blkdev_direct_IO or __iomap_dio_rw by default not to allocate buffer
pages from CMA pageblocks.

Signed-off-by: Sooyong Suk <s.suk@samsung.com>
---
 block/bio.c         | 2 +-
 include/linux/uio.h | 2 ++
 lib/iov_iter.c      | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index d5bdc31d88d3..683113b3e35a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1247,7 +1247,7 @@ static unsigned int get_contig_folio_len(unsigned int *num_pages,
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
-	iov_iter_extraction_t extraction_flags = 0;
+	iov_iter_extraction_t extraction_flags = ITER_ALLOW_LONGTERM;
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..d1e9174ee29a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -377,6 +377,8 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 /* Flags for iov_iter_get/extract_pages*() */
 /* Allow P2PDMA on the extracted pages */
 #define ITER_ALLOW_P2PDMA	((__force iov_iter_extraction_t)0x01)
+/* Allow LONGTERM on the extracted pages */
+#define ITER_ALLOW_LONGTERM	((__force iov_iter_extraction_t)0x02)
 
 ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
 			       size_t maxsize, unsigned int maxpages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9ec806f989f2..4b5c7c30cd4d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1832,6 +1832,8 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
 		gup_flags |= FOLL_WRITE;
 	if (extraction_flags & ITER_ALLOW_P2PDMA)
 		gup_flags |= FOLL_PCI_P2PDMA;
+	if (extraction_flags & ITER_ALLOW_LONGTERM)
+		gup_flags |= FOLL_LONGTERM;
 	if (i->nofault)
 		gup_flags |= FOLL_NOFAULT;
 
-- 
2.25.1


