Return-Path: <linux-kernel+bounces-352763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05F79923DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A751C2218A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9382485;
	Mon,  7 Oct 2024 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cpMQn3yQ"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDF4C91
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278495; cv=none; b=poEzeh6K8ZsRpKwqs+6CmJgUBQBTHEG/QU6HbC0/TykM8xHBvwZtQWA80sm7p5xqL0EYxoc1zJdA3VF7u/ulS/q+E+54lUieQniqHFjWvLMzERLKnvo8Op4ia8HBwYnIpx09Dyfm85lQlU+GBEgiga+CmfjCzeFG9YrWUWcsMFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278495; c=relaxed/simple;
	bh=Y3bEnslIGUKeozrhrtX84lP3gWA5Zak9pz5LWG6SWI4=;
	h=Mime-Version:Subject:From:To:Message-ID:Date:Content-Type:
	 References; b=oCaPD8Q1PbO6oYPAJOnFC8EfvMK39KvneKjM6CxX+71vNt561UdyYTaEwNGSN5lW3rJjy2LVi8CDDOGhJIuCkA0PI9cDNemObU1cjGF/g7rJzHFeyTPZcql9ECkY9h91ptwnyNqgO5bBk0kvPqBatX/GKz29I6WBKzyKFCqI1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cpMQn3yQ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241007052123epoutp03a812c8ada9ebc6ef3356d2ed0bf29b8e~8FB_z0_Ql0130601306epoutp03m
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:21:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241007052123epoutp03a812c8ada9ebc6ef3356d2ed0bf29b8e~8FB_z0_Ql0130601306epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728278483;
	bh=XkPIRM3U4jCdaiGC4n343ikwc4gQdie3fQQ4q/mvRqQ=;
	h=Subject:Reply-To:From:To:Date:References:From;
	b=cpMQn3yQZNbEOsIPwpxlHj6Aar/SeHAbVzrOO791fLvXwkojSVEGSs2Ynn75zem0K
	 rpgY5MjmAiNT/tpzaHsq/EovNGzXUBsg2Ui77dLONghgCMjMyNBuVf08IWjz93FUzO
	 4RdOXUCmeh1wYKk6dv2CEr7oQSeCcE6hxG2szh+s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20241007052123epcas2p447dbc2e44eb1561a43a0686ad3fe3151~8FB_exGLD3151631516epcas2p4g;
	Mon,  7 Oct 2024 05:21:23 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XMSDf32gpz4x9Q3; Mon,  7 Oct
	2024 05:21:22 +0000 (GMT)
X-AuditID: b6c32a4d-183ff70000004a06-ad-67036fd2976e
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C7.AA.18950.2DF63076; Mon,  7 Oct 2024 14:21:22 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] libf2fs: Fix calculation of usable segments for single
 zoned
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Yonggil Song <yonggil.song@samsung.com>, Siwoo Jung <siu.jung@samsung.com>,
	Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
Date: Mon, 07 Oct 2024 14:21:22 +0900
X-CMS-MailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmme6lfOZ0g9fXxSxOTz3LZLHqQbjF
	j5MmFk/Wz2K2uLTI3eLyrjlsFucnvmaymHr+CJMDh8emVZ1sHrsXfGby6NuyitHj8ya5AJao
	bJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBuUFMoS
	c0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ
	D/bOZyu4xlXRd/AfWwPjA44uRk4OCQETiZa5B5i6GLk4hAT2MErsuP2bvYuRg4NXQFDi7w5h
	kBphAX+JR/uuMYHYQgJKEtcO9LJAxPUlNi9exg5iswnoSvzdsJwdZI6IQBezxKqGm4wQC3gl
	ZrQ/ZYGwpSW2L98KFdeQ+LGslxnCFpW4ufotO4z9/th8qBoRidZ7Z6FqBCUe/NwNFZeUWHTo
	PBOEnS/xd8V1Ngi7RmJrQxtUXF/iWsdGsL28Ar4S86ZfYQWxWQRUJbqbFzGD/Cgh4CLxYxcn
	SJhZQF5i+9s5YGFmAU2J9bv0ISqUJY7cYoGo4JPoOPyXHeapHfOeQC1Sk9i8aTMrhC0jceFx
	GyNEq4fE2c9BkEALlPhxcBnjBEb5WYignYVk7SyEtQsYmVcxSqUWFOempyYbFRjq5qWWw2M0
	OT93EyM4DWr57mB8vf6v3iFGJg7GQ4wSHMxKIrwRaxjThXhTEiurUovy44tKc1KLDzGaAv08
	kVlKNDkfmIjzSuINTSwNTMzMDM2NTA3MlcR577XOTRESSE8sSc1OTS1ILYLpY+LglGpgMn5n
	sl7LN0JA6ncjp4/Bhrnyin33DSf8ONeyUoDb6dqUx4vcZk2PievsL2OL3T9bJon/9t/GFaIq
	alv6LTgOVIvq3+2NX37lmLxjUsnzPfZ6qjMO1q9jMoiN5TuWcybkSMOCnc82F+nv3HHmx8MD
	BkxrZM4GPpPpNffaPnk6W9R+J911M111b5+Mfuotp2A5e3dR4fcDZpP2HbZ/6sV5rlxyqqO2
	wqU3oUY5VmebfjS+uHNs59TwpTs+irVteXrG7e/ZO2xbwjUX5izva2ef6NH6oTFzRbrIko6d
	qyWKzu4QafKI1u88VpHYKvzkh0XR+qyNp9osFv3rurFls0NMRrPnCaHeWc/zhNzu3/BerMRS
	nJFoqMVcVJwIANoEqBEMBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
References: <CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>

There was a bug that did not subtract the super block area when calculating
the usable segments for a single zoned device with a conventional zone.
This bug resulted in incorrect the overprovision and reserved area.

	<256MiB legacy block + zoned block w/ 32MiB zone size>
	Info: Overprovision ratio = 3.570%
	Info: Overprovision segments = 656 (GC reserved = 560)

	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
	Info: Overprovision ratio = 3.700%
	Info: Overprovision segments = 676 (GC reserved = 578)

This patch fixes the bug by subtracting the super block area when there is
only one zoned device.

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 lib/libf2fs_zoned.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 89ba5ad73a76..cc5c064b7e3e 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
 	}
 	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
 						get_sb(log_blocks_per_seg);
+
+	/* single zoned device needs to remove a super block area */
+	if (c.ndevs == 1)
+		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));
+
 	return usable_segs;
 #endif
 	return get_sb(segment_count_main);
-- 
2.43.0

