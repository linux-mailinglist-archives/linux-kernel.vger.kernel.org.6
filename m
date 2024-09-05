Return-Path: <linux-kernel+bounces-316360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A096CE6C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE70B24075
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C7156665;
	Thu,  5 Sep 2024 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GglrP2Dj"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C91372
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513947; cv=none; b=LOCY7hWrB0RVEFHi4DGZ7jhuz/8P62QEqQ/fpRu5nfYvuwnWtGg0JNMm92/ERFqU8IqMvYIhWx9o8hbx7ikcnf9HYCuLIuSxwWlTz2OmTcl7I7iQ6Y/MphkU3qXsXf2snt45ufELwAF/8/m4WRGcsd/eFZqJ9xmqlIFo/wUk3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513947; c=relaxed/simple;
	bh=AA+oQSFX4E7b1qUAHMUr9W+D4X2plg5vDuxKpH8xrhI=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=WrbBzj1QNEFCTLeHyc4F20E3iB6AQlflvmKeI2WoMOrbDUqu5b/lgMufjhgq9pPOk04bkY8SJXFvtJmv1/jobEjAelu43OlARVfRgMqIFpT0mCGFgTtkBAhnh3ArESeuzIDdTIDp8o/vkN/tDKPm4Qp+wF7pE4qqRY/QxGdtWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GglrP2Dj; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240905052535epoutp013760105d44de8553fa0f933474cb8d6e~yQcg9N9hR0242802428epoutp011
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:25:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240905052535epoutp013760105d44de8553fa0f933474cb8d6e~yQcg9N9hR0242802428epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725513935;
	bh=W4s+YGCDaaFjY8QvplVjSGT3b8EjDtobIvfTNI3DeYQ=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=GglrP2DjSotETC1Ve52l97WhJ2dCJfuJ3sDwLRUJBr6s8sVH7dYrtNkaqHyxPgULL
	 mF0N7ZcbBM1mWuyTHSksdFNmT5hDRD9UAGWqzreeLeSCRHLn10j3wXCCnZlKsyB4a5
	 QGOQx1xodoyg8ncd8NMwVvIBDx2IMXCzgUQxkZGE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240905052534epcas2p1a071b52d0b3e882fc499f6abb6d187b9~yQcf9icu-2001420014epcas2p1k;
	Thu,  5 Sep 2024 05:25:34 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WznrG0Lm7z4x9Px; Thu,  5 Sep
	2024 05:25:34 +0000 (GMT)
X-AuditID: b6c32a46-24fff70000002752-6a-66d940cd1cfa
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.EA.10066.DC049D66; Thu,  5 Sep 2024 14:25:33 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: avoid unused block when dio write in LFS mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim
	<dongjin_.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>, Jaeyoon
	Choi <j_yoon.choi@samsung.com>, Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo
	Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
Date: Thu, 05 Sep 2024 14:24:33 +0900
X-CMS-MailID: 20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmqe5Zh5tpBt+7zC1OTz3LZPHykKbF
	qgfhFj9Omlj0725nsXiyfhazxaVF7haXd81hs2j542RxfuJrJotVHXMZLaaeP8LkwOOxaVUn
	m8fuBZ+ZPPq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
	LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJu
	cWleul5eaomVoYGBkSlQYUJ2xvXFjUwFr7kq7h05ytTAeJuji5GTQ0LAROL7jyNMXYxcHEIC
	Oxgllu9vYuxi5ODgFRCU+LtDGKRGWMBdYv30VawgtpCAksT6i7PYIeJ6ErcermEEsdkEdCSm
	n7jPDjJHROABo8SUG3vZQBxmgRlMEvNO97JBbOOVmNH+lAXClpbYvnwrI4StIfFjWS8zhC0q
	cXP1W3YY+/2x+VA1IhKt985C1QhKPPi5GyouKXF77iao+nyJ/1eWQ9k1EtsOzIOy9SWudWwE
	28sr4CvxfMNfsF4WAVWJf7MWMEHUuEjsfPAGLM4sIC+x/e0cZlBAMAtoSqzfpQ9iSggoSxy5
	xQJRwSfRcfgvO8xXDRt/Y2XvmPcEarqaxLqf65kgxshI3JrHOIFRaRYioGchWTsLYe0CRuZV
	jGKpBcW56anFRgVG8LhNzs/dxAhOn1puOxinvP2gd4iRiYPxEKMEB7OSCO9rkRtpQrwpiZVV
	qUX58UWlOanFhxhNgR6eyCwlmpwPTOB5JfGGJpYGJmZmhuZGpgbmSuK891rnpggJpCeWpGan
	phakFsH0MXFwSjUwdeQXHanKPl96cVNqUrfyKfU5yndneHbX3p22KKfF/VGVjI6c4qb/muXa
	S1UPtH2WMTrt4z3J7vKzVV1vCl8Z3WMWyxPeF1PZcUuxdE/mNtfWx+w9Fl+vPlKI8JhjvOHd
	xNnr7b4bpqY4qx7fO/2l3S7levcms1g+75dnP7RmhX7vTuwNktv8f2b3q8YAcT7X0rjfRav6
	p31d/6ollnXDWn6NGXO62e593VzUpXsg/ur8c/Onak8/v/R78vbjvwtiH7wTv1i7Z+7MLoPP
	+wNW/TH8rWGuVfFXWHf/6ZjcnupVTyNuT3R6lGX7wEfiTXqPyNYTOU5L+A4c+bltW8zld694
	7nBPeqGtdzH4eoIDuxJLcUaioRZzUXEiAKremvEoBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160
References: <CGME20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>

This patch addresses the problem that when using LFS mode, unused blocks
may occur in f2fs_map_blocks() during block allocation for dio writes.

If a new section is allocated during block allocation, it will not be
included in the map struct by map_is_mergeable() if the LBA of the
allocated block is not contiguous. However, the block already allocated
in this process will remain unused due to the LFS mode.

This patch avoids the possibility of unused blocks by escaping
f2fs_map_blocks() when allocating the last block in a section.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---

v2: Applied segment check code suggested by Chao Yu.


 fs/f2fs/data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c6d688208f8b..b94cf6eea2f9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1712,6 +1712,14 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		dn.ofs_in_node = end_offset;
 	}
 
+	if (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi) &&
+	    map->m_may_create) {
+		/* the next block to be allocated may not be contiguous. */
+		if (GET_SEGOFF_FROM_SEG0(sbi, blkaddr) % BLKS_PER_SEC(sbi) ==
+		    CAP_BLKS_PER_SEC(sbi) - 1)
+			goto sync_out;
+	}
+
 	if (pgofs >= end)
 		goto sync_out;
 	else if (dn.ofs_in_node < end_offset)
-- 
2.25.1


