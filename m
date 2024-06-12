Return-Path: <linux-kernel+bounces-210818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBD09048EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B31F242AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44781AD5D;
	Wed, 12 Jun 2024 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TWrSV3zL"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8B63BF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158884; cv=none; b=rMCgvWQfZWdHWjEtQPFnc/W7CilwMtLiEFzKdvecpGcqPk1LgLjATfh+xRpKINYUsyn5m+T836b6lj9EcvEup3m5Feb5IQ5h9kL0Mq5QuEsWB591ATEl9NX1A2PBcBpSCo3VlNqEFLDq9E/M9hb4wvx4zyfv1iapIYyz0e5tZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158884; c=relaxed/simple;
	bh=2RfIPyM2BaJyeNcdDcFiSSt+OrKJFVJYbx/rL5T1DGU=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=Eu1w5ar27tdDNXePSWv+M2Dzfa4HZ91SQbclkFgI0PV4y3n9HFU0NQLf4sStqupVrW+5CIUB+VCZvAqusNWxuLNJLBAS6N63LuySgMmDfRZlYI8oaUb8QeAi3Ewh3Sf5n9N7Vw1+9TQdA83Lc3H109h9Epjc+L1w3f/jpyWQ7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TWrSV3zL; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240612022114epoutp0204a5be2943cc8bb6afc89282277ef6fc~YIGSM1Rm61703117031epoutp02q
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:21:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240612022114epoutp0204a5be2943cc8bb6afc89282277ef6fc~YIGSM1Rm61703117031epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718158874;
	bh=aHiTLqz3DTEetGM77pTEUK8RRyp3MuomMyvuo5JbqcY=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=TWrSV3zL3WX7ncK0gCU8tR+LluTJOxaTm4/cj6sSMmFtSTxJdZVCculQFuGzzO0cc
	 K1mOXeRpDRuYGApD9KCe9qWXUO1Jq+ZY9F/I7cHrdCu3w6t1aBZmDagns3molgr6cr
	 Zd5O/mscRw5gs+KuQ4aX3n9zAQ+KnP798i9hpL+c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240612022113epcas2p388bb2006691b6ca36d3fe0ce4a07c590~YIGRpYg_n2118421184epcas2p34;
	Wed, 12 Jun 2024 02:21:13 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VzTmn0hqqz4x9Q6; Wed, 12 Jun
	2024 02:21:13 +0000 (GMT)
X-AuditID: b6c32a47-4f767a800000264e-db-666906188eb0
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.A3.09806.81609666; Wed, 12 Jun 2024 11:21:13 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] f2fs: fix convert inline inode on readonly mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Daejun Park <daejun7.park@samsung.com>, Dongjin Kim
	<dongjin_.kim@samsung.com>, Seokhwan Kim <sukka.kim@samsung.com>, Yonggil
	Song <yonggil.song@samsung.com>, Eunhee Rho <eunhee83.rho@samsung.com>,
	Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
	<nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p7>
Date: Wed, 12 Jun 2024 11:20:12 +0900
X-CMS-MailID: 20240612022012epcms2p77300b5130d18b0397c9fc2877704949d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmua4kW2aawZktTBanp55lsnh5SNNi
	1YNwix8nTSx+Pulgs+jf3c5i8WT9LGaLS4vcLS7vmsNm0fLHyeL8xNdMFqs65jJaTD1/hMmB
	12PTqk42j90LPjN59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
	pYW5kkJeYm6qrZKLT4CuW2YO0GlKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALz
	Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMK39nMBb84Ko4/yWvgfEcRxcjJ4eEgInEsl1/WboY
	uTiEBHYwSjQe2c/excjBwSsgKPF3hzBIjbCAg8SMA5tZQGwhASWJ9RdnsUPE9SRuPVzDCGKz
	CehITD9xHywuIvCKUeLMalGQmcwCB5kkPp6ezQ6xjFdiRvtTFghbWmL78q2MELaGxI9lvcwQ
	tqjEzdVv2WHs98fmQ9WISLTeOwtVIyjx4OduqLikxO25m6Dq8yX+X1kOZddIbDswD8rWl7jW
	sRFsL6+Ar8SBdw1gcRYBVYlpN6azQdS4SNx89BFsJrOAvMT2t3OYQeHALKApsX6XPogpIaAs
	ceQWC0QFn0TH4b9wXzVs/I2VvWPeEyYIW01i3c/1TBBjZCRuzWOcwKg0CxHOs5CsnYWwdgEj
	8ypGsdSC4tz01GKjAmN4zCbn525iBCdRLfcdjDPeftA7xMjEwXiIUYKDWUmE90xMepoQb0pi
	ZVVqUX58UWlOavEhRlOghycyS4km5wPTeF5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp
	2ampBalFMH1MHJxSDUztif9FGFvDIm5OyVZQ+s3jslLMy3nv5PcMCXVH/Q+7Mhnp1VzK1pqX
	yZzH/+zQvC+s9Zfr0+01hFh9Kna+NWiLv8++VL5/Y3hY9Ym8+NMzLPZ8/Sa67HFuNiu32crK
	RzXrPnKnr7rOrh7vcK4j3+tJ+v9PywP513ZuZXdYwcSpsnDJo3dFMws2z7/tu/iwxNFj8zl3
	xPtc0Q2dxTc54V7DhZtR1wLV448v2uxXanitoHxRVvjyjEebt8bwWQXO11/76tfLavFn+h1u
	p7zeOS6dlOZ3sDRRkcHln0VZhkd9wekrTFo/J7x45tuxr2ze7Q9Z6k+1kjQfNvhbP2356dFt
	evneJ7uItf+W7vUq8VRiKc5INNRiLipOBACaB+P9KwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240612022012epcms2p77300b5130d18b0397c9fc2877704949d
References: <CGME20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p7>

syzbot reported a bug in f2fs_vm_page_mkwrite() which checks for
f2fs_has_inline_data(inode).
The bug was caused by f2fs_convert_inline_inode() not returning an
error when called on a read-only filesystem, but returning with the
inline attribute as set.
This patch fixes the problem by ensuring that f2fs_convert_inline_inode()
returns -EROFS on readonly.

Fixes: ec2ddf499402 ("f2fs: don't allow any writes on readonly mount")
Reported-by: syzbot+f195123a45ad487ca66c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f195123a45ad487ca66c
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/inline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7638d0d7b7ee..ae1d8f2d82c9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -203,10 +203,12 @@ int f2fs_convert_inline_inode(struct inode *inode)
        struct page *ipage, *page;
        int err = 0;

-       if (!f2fs_has_inline_data(inode) ||
-                       f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
+       if (!f2fs_has_inline_data(inode))
                return 0;

+       if (unlikely(f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb)))
+               return -EROFS;
+
        err = f2fs_dquot_initialize(inode);
        if (err)
                return err;
--
2.25.1


