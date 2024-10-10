Return-Path: <linux-kernel+bounces-358256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC0997C13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF45AB23C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3B19DF8E;
	Thu, 10 Oct 2024 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f5ULp6Ep"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F04A15
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536381; cv=none; b=T22DAJi9ZT871jtQjrRg+nGFYkUpJ5fycpeqAK3XQ8QL7NuGVDZipsLAsgZfvubleWvycsc1TINbbboreC1XpStNssa6S5H+GkOeO1XinfvkISZpScmqK6gn6dSMZ6ALxzitosXIQhdMglXjn0cC3OPl44ookh7ilN/4WEgvwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536381; c=relaxed/simple;
	bh=dHq6VCP1hHO2QytBv9CEweFhJ2eiwLqJv4XOYupTF7I=;
	h=Mime-Version:Subject:From:To:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=JuXYkQ3SvzKGbGYTVn82+qCKwJqzCRuHgk9J6jcfFYwiYi4Ko71JW5aMkW5tdBphVnFf6V1wJNusJwwh0G2F9+yq/1d1f0hY2/UWBLlMAv+SGsUfZc5MttP2zB0XbyZhRZGM1ZOK+PXMQatEfcSRzF0FFnyZY/3HKs7/4DQ1xYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f5ULp6Ep; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241010045937epoutp0258590f856ab0dc8a9636fbfffba0c42c~8-q09byso0892308923epoutp02D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241010045937epoutp0258590f856ab0dc8a9636fbfffba0c42c~8-q09byso0892308923epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728536377;
	bh=kDPmTXhPX6cxQzuvSTnQ8wrHQwVwp7TSgQJ6vfD5NDg=;
	h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
	b=f5ULp6EpU2pFt/uhR450E/XBce8kPbtb8U+DPMSMKtB4Sk5crkFXWu33dB2YK1ArE
	 OoeAZ2LUFf7WCqIL5wj8QjIunbP3Pkzb0kcxGzcbPq7FGST+ot0Pa68M2XmWS3+XS5
	 1Fg+EAolZUCf8OQszRsGxF1Denco2p3cjMWQIFzE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241010045936epcas2p2c75963a640c770267156f4a7902f055f~8-q0k7RzD1895418954epcas2p2w;
	Thu, 10 Oct 2024 04:59:36 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XPHc7604Vz4x9Q4; Thu, 10 Oct
	2024 04:59:35 +0000 (GMT)
X-AuditID: b6c32a48-7f9ff70000002653-fb-67075f37b5f1
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	D3.51.09811.73F57076; Thu, 10 Oct 2024 13:59:35 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2] libf2fs: Fix calculation of usable segments for single
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: Yonggil Song <yonggil.song@samsung.com>, Chao Yu <chao@kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f@epcms2p7>
Date: Thu, 10 Oct 2024 13:59:35 +0900
X-CMS-MailID: 20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTVNc8nj3doOeBvsXpqWeZLFY9CLf4
	cdLE4sn6WcwWlxa5W1zeNYfN4vzE10wWU88fYXLg8Ni0qpPNY/eCz0wefVtWMXp83iQXwBKV
	bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
	TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj
	ws0vbAW93BUbrzaxNzBO4uxi5OCQEDCRaHpe2cXIxSEksINRovn2BnaQOK+AoMTfHcJdjJwc
	wgJeEtsW3GUDsYUElCSuHehlgYjrS2xevIwdxGYT0JX4u2E5O8gcEYEGZondTzcxgSQkBHgl
	ZrQ/ZYGwpSW2L9/KCGJzCvhJXFv0kg0iriHxY1kvM4QtKnFz9Vt2GPv9sfmMELaIROu9s1A1
	ghIPfu6GiktKLDp0HmpXvsTfFdehZtZIbG1og4rrS1zr2Ah2A6+Ar8TtHd/B5rMIqEqsmTUH
	ao6LxI9HM8DqmQXkJba/ncMMCgdmAU2J9bv0IUGlLHHkFgtEBZ9Ex+G/7DAf7pj3BGqTmsTm
	TZtZIWwZiQuP2xghWj0kzn4OgoTyRSaJNY1v2CYwKsxCBPQsJHtnIexdwMi8ilEstaA4Nz21
	2KjABB61yfm5mxjBiVHLYwfj7Lcf9A4xMnEwHmKU4GBWEuHVXciaLsSbklhZlVqUH19UmpNa
	fIjRFOjjicxSosn5wNScVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMH
	p1QDk47Yowe/lYs6NeYud2VYOlP2clHuqvfedkI6L5Ycnts6WW++x8+su49XcJcUNXVmr5z7
	JOTJs7Mx56xL8yaqXpIzbfDdmryX5e33NI5CHaEd8R/+2s178jG+qPOr0oM25i6On0em+sQr
	hCbFn3vQ1BL9x8HTaY6f33zz3XcFWxmX3tnzyEc/RPkr/xSBScFL907Y6t5w/qpX0gSe+y9v
	GUXNbVer72a66GxY2rpZ54nkLj8/uQf3uXf5PD6vu323nucSdVFRxU1HFWr1Js1a7LhuqZFW
	98SnX3LOMC5/EfT+w/TXee+6edcxpub7hCds1/7o7tB4eVGpDm/tg+srAsPd4s7dX9ntqbil
	zeLnPyWW4oxEQy3mouJEAICP38MVBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
References: <20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8@epcms2p2>
	<20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
	<e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
	<20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
	<CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p7>

There was a problem that did not subtract the super block area when calculating
the usable segments for a single zoned device with a conventional zone.
This resulted in incorrect the overprovision and reserved area.

	<256MiB legacy block + zoned block w/ 32MiB zone size>
	Info: Overprovision ratio = 3.570%
	Info: Overprovision segments = 656 (GC reserved = 560)

	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
	Info: Overprovision ratio = 3.700%
	Info: Overprovision segments = 676 (GC reserved = 578)

This patch addresses the problem by subtracting the super block area when
there is only one zoned device.

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 lib/libf2fs_zoned.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 89ba5ad73a76..1a0985378789 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
 	}
 	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
 						get_sb(log_blocks_per_seg);
+
+	/* single zoned device needs to remove a super block area */
+	if (c.ndevs == 1 && c.devices[0].zoned_model == F2FS_ZONED_HM)
+		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));
+
 	return usable_segs;
 #endif
 	return get_sb(segment_count_main);
-- 
2.43.0


