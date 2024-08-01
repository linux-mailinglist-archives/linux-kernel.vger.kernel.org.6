Return-Path: <linux-kernel+bounces-270825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBB9445D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D06284365
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0114E2C0;
	Thu,  1 Aug 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ovf2qlLM"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E81EB4A2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498503; cv=none; b=DMO7lRsO02J+cgiA0V6sOsJTKuDQhPe3b4D6TB/em2xBuW6EnPIIWWxZpPmyHqOKBT3J2Xe0CxWNWIT5kqVsub1ZxTz6np8tdV3fk01j8IXSnutO+UKrpHxkT/3IzzfSmDmpG3k8ux5GDxsSeZyZYfiRDwgWnhsf5x1MAfcOZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498503; c=relaxed/simple;
	bh=BxMhIFy2Gb8FazhJHFHpOB+W/EjTMenJsTz76oP1vvo=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=rmdxh2B7boAd6fi11UwXGZz9xZjGwqrXZFY6tvbQ8tPOSuSrUX3UDJB786ebov6tYWGYG7MmiVuhP1fnHyugVBxP4p+fSz68AcJnbk/Hi9bmsuOLEAEvn/RuCy95tWJpfizpiBjxlrVW6o7WscwkEUlFA6gC8rr28zSX0v6j5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ovf2qlLM; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240801074818epoutp02f1352fc50034276ba65c30e742d01e26~ni0IM3p-K2655626556epoutp02C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:48:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240801074818epoutp02f1352fc50034276ba65c30e742d01e26~ni0IM3p-K2655626556epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722498498;
	bh=V/OQizZH033qH8C4iqIA1G7wnp72fkVhXBE0pNPn1Sk=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=ovf2qlLM8ZkhvMfn7V1S4PIasdwRTFh+0OuG1KUfKZ353LfUUkTZdP48YzueBVkT0
	 4AZhxYrSOnr2/ekIjzYlOkU9J0LlRJbOUcCwZnWddfyM7ipQcr6ROcx6NRQBUnCTho
	 Q52I8CJdpOUEIs+tPZJL3cCzs18bxM6xp+UtBpT4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240801074817epcas2p4846c2a33c31df385de449d9b3328237c~ni0Hr4K3-1221412214epcas2p4K;
	Thu,  1 Aug 2024 07:48:17 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WZLg51JRgz4x9QM; Thu,  1 Aug
	2024 07:48:17 +0000 (GMT)
X-AuditID: b6c32a45-ffffa700000028bf-12-66ab3dc10cc0
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.6A.10431.1CD3BA66; Thu,  1 Aug 2024 16:48:17 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] f2fs: avoid unused block when dio write in LFS mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Daejun Park <daejun7.park@samsung.com>, Seokhwan Kim
	<sukka.kim@samsung.com>, Dongjin Kim <dongjin_.kim@samsung.com>, Yonggil
	Song <yonggil.song@samsung.com>, Jaeyoon Choi <j_yoon.choi@samsung.com>,
	Jeuk Kim <jeuk20.kim@samsung.com>, Nayeon Kim <nayeoni.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
Date: Thu, 01 Aug 2024 16:47:15 +0900
X-CMS-MailID: 20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmue5B29VpBl9/slqcnnqWyeLlIU2L
	VQ/CLX6cNLHo393OYvFk/Sxmi/tbrzFaXFrkbnF51xw2i5Y/ThbnJ75msljVMZfRYur5I0wO
	vB6bVnWyeexe8JnJo2/LKkaPz5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
	F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnXO0oL9jPXXF17S/mBsYlnF2MnBwSAiYSv07/Y+ti
	5OIQEtjBKLHn/j/WLkYODl4BQYm/O4RBaoQFXCSWvzjNBmILCShJrL84ix0iridx6+EaRhCb
	TUBHYvqJ+2BxEYFXjBJnVouCzGQW2MskcWfJBCaIZbwSM9qfskDY0hLbl29lhLA1JH4s62WG
	sEUlbq5+yw5jvz82H6pGRKL13lmoGkGJBz93Q8UlJW7P3QRVny/x/8pyKLtGYtuBeVC2vsS1
	jo1ge3kFfCXaf2wEi7MIqEr8P70TaqaLxI6zq8GeZBaQl9j+dg4zKByYBTQl1u/SBzElBJQl
	jtxigajgk+g4/Jcd5quGjb+xsnfMewL1uZrEup/rmSDGyEjcmsc4gVFpFiKcZyFZOwth7QJG
	5lWMYqkFxbnpqcVGBYbwmE3Oz93ECE6iWq47GCe//aB3iJGJg/EQowQHs5IIr9DJlWlCvCmJ
	lVWpRfnxRaU5qcWHGE2BHp7ILCWanA9M43kl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5ak
	ZqemFqQWwfQxcXBKNTDlPvrlFHGkw+FAoN2hz3fXbsrZyiOpc+d26GVPs3K2SrVlx63D0lZ0
	Xw9zuPgy1faosvi3yvKuH4YGqT4aeyIln5+QdtiziSlioYzRt0+FLw8zv37jq307bAnzOYa5
	s0KT/znaOV8pElQJLHDhcuEW1UyoSon89srDYxXX1jr7hgrB4xqy/uoWXSLLJixa2XPS1XjG
	87mBhm9zf+tn+ascFku457tyw3HZ37bMLy9F/uldrBDLcVymor7qwDHjfcp32GK2tp7iEF+W
	qO5c3960hC1q0zoHM0WrRWmOedLbFJ+Xvkl3fLTf4k0b7y8XgwWPO9buW7R0J7t18PX625uX
	N4b+ZrVRTfG/x/r/pxJLcUaioRZzUXEiAPdMfekrBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b
References: <CGME20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>

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
 fs/f2fs/data.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b6dcb3bcaef7..b27a3f448f32 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1711,6 +1711,19 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		dn.ofs_in_node = end_offset;
 	}
 
+	if (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi)) {
+		int segno = GET_SEGNO(sbi, blkaddr);
+		bool last_seg, last_blk;
+
+		last_seg = !((segno + 1) % SEGS_PER_SEC(sbi));
+		last_blk = (f2fs_usable_blks_in_seg(sbi, segno) - 1) ==
+				GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
+
+		/* LBA of the next block to be allocated may not be contiguous. */
+		if (last_seg && last_blk)
+			goto sync_out;
+	}
+
 	if (pgofs >= end)
 		goto sync_out;
 	else if (dn.ofs_in_node < end_offset)
-- 
2.25.1


