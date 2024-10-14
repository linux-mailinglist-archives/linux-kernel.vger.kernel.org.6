Return-Path: <linux-kernel+bounces-363059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301FB99BD69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E70E1F21E84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66B17BD3;
	Mon, 14 Oct 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eQEun3r8"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98721C687
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870236; cv=none; b=KpUPm4PVjwGl6RufjVqV+gEZ1fvj83mj3e6BHZH83Q+rsjd+hZkKNBkNJXKciLBSsNKcxjQ+9gLl2E51ChQWsYJE01UFdjxtUQQpLniu1aG/7NevtjRH8xh2FmXl/33nH/YbuV9U/dJ234SMRJVHIOiM6vh8j73DnZ1FB5plKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870236; c=relaxed/simple;
	bh=HEJCwlbRp7/Ddp0AfEPMEbkW2EAlHA4Yqq9H5+MRUkg=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=BKKLjZUAjj3x3nskKGvVptPhUOt71k6SSVNoYSjoUrxkWjsUZQ0Rg55YebcdOdE5/Cg6tajpWPL5TAsjy49oqM+Ej75pgQRoDv65VqEET1v/xIi30JhYKwOhEGIR5oTWnC0QrFrLAH3pbNM3rkxV6g+up9OphUC0bMXYZD78EJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eQEun3r8; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241014014343epoutp012ca7b21291e586d1cc90d1c5cfbdd823~_Lk7a_4o70757607576epoutp01-
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:43:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241014014343epoutp012ca7b21291e586d1cc90d1c5cfbdd823~_Lk7a_4o70757607576epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728870223;
	bh=5tNDyzmv7hh4tEfaKy/ETU6TxQAsf/m9S2xTXYxFnFY=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=eQEun3r872qviaLuMXrQunZomGFGNd9ObIMIyFQ1+DW0JfX+/m9rIWS9EmPG7E1Cv
	 xAfGcgJP1NH9gItWebN8Qlnf3sERCttta1qmRgAprhMcWZU8/4gIPkJUSrtvHOUMuO
	 0Vy2dbiaIjLGYrnjCHXRQi6Pu/opmX3JiT6wUf80=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20241014014342epcas2p40ed2c85cbe3090d77a4a66e906e5c4e0~_Lk7F6ehY0308503085epcas2p4Y;
	Mon, 14 Oct 2024 01:43:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XRg4G164lz4x9Px; Mon, 14 Oct
	2024 01:43:42 +0000 (GMT)
X-AuditID: b6c32a46-da9ff7000000262a-e4-670c774d4508
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.24.09770.D477C076; Mon, 14 Oct 2024 10:43:42 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] libf2fs: Fix calculation of usable segments for
 single
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>,
	Yonggil Song <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZwlFkBAV2yxf1DBt@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241014014341epcms2p3467a0b744b7bfc269871c8e75e80c896@epcms2p3>
Date: Mon, 14 Oct 2024 10:43:41 +0900
X-CMS-MailID: 20241014014341epcms2p3467a0b744b7bfc269871c8e75e80c896
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTVNevnCfd4M8fJovTU88yWax6EG7x
	46SJxZP1s5gtLi1yt7i8aw6bxfmJr5kspp4/wuTA4bFpVSebx+4Fn5k8+rasYvT4vEkugCUq
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	05/TWAtWC1Sc3vOUuYHxAU8XIyeHhICJxLGbzexdjFwcQgI7GCV6P/xk6mLk4OAVEJT4u0MY
	pEZYIFhi098ZbCC2kICSxLUDvSwQcX2JzYuXsYPYbAK6En83LAezRQRUJA4tugw2k1ngMpPE
	uxvP2SCW8UrMaH/KAmFLS2xfvpURxOYU0JK42n4PqkZD4seyXmYIW1Ti5uq37DD2+2PzGSFs
	EYnWe2ehagQlHvzcDRWXlFh06DwThJ0v8XfFdaiZNRJbG9qg4voS1zo2gt3AK+ArceXWe7A5
	LAKqElse7oG6zUWi7TiEzSwgL7H97RxmUJgwC2hKrN+lD2JKCChLHLkFVcEn0XH4LzvMhzvm
	PYHapCaxedNmVghbRuLC4zZGiFYPibOfgyYwKs5ChPMsJKtmIaxawMi8ilEstaA4Nz212KjA
	CB61yfm5mxjBiVHLbQfjlLcf9A4xMnEwHmKU4GBWEuF9P5UzXYg3JbGyKrUoP76oNCe1+BCj
	KdCTE5mlRJPzgak5ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkG
	pjtW9TVfTLQlF3lt/Zh5btrSg89nfLi+60WxR3WO9PNjDbNPtn/m2V/ylvV1TziDzcLlC73E
	D8lZu1tMadH52MLYpcdz/KpEPVNu5ceQLe6ac2/seKCzJvXKAvvwCW1+25hn7FwvHxZ0ep23
	0d4LG9/8dLrweHHf5jwVZsbHUqn1qhWnxbQXnDz0YOY5CcHtIkFG9Q+mfO4yNOubkrm6mffi
	ag5XNccJ/dPq435lq1ovlrRdt+frtLR7lnJF9z/E5wefXeG57Gb+zCt7zT2VueujX8z+t6T9
	1MJ33Ndm5BqVqW6ZpiKpEuo3+5Rj1Kp62RbW99eN1mREr8t7KrOqkWfHFOHtslUF0pFsAQeZ
	JyixFGckGmoxFxUnAgCGG5ZkFQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
References: <ZwlFkBAV2yxf1DBt@google.com>
	<20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8@epcms2p2>
	<20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
	<e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
	<20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
	<20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f@epcms2p7>
	<CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p3>

> On 10/10, Yonggil Song wrote:
> > There was a problem that did not subtract the super block area when calculating
> > the usable segments for a single zoned device with a conventional zone.
> > This resulted in incorrect the overprovision and reserved area.
> > 
> > 	<256MiB legacy block + zoned block w/ 32MiB zone size>
> > 	Info: Overprovision ratio = 3.570%
> > 	Info: Overprovision segments = 656 (GC reserved = 560)
> > 
> > 	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
> > 	Info: Overprovision ratio = 3.700%
> > 	Info: Overprovision segments = 676 (GC reserved = 578)
> > 
> > This patch addresses the problem by subtracting the super block area when
> > there is only one zoned device.
> > 
> > Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> > ---
> >  lib/libf2fs_zoned.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> > index 89ba5ad73a76..1a0985378789 100644
> > --- a/lib/libf2fs_zoned.c
> > +++ b/lib/libf2fs_zoned.c
> > @@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
> >  	}
> >  	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
> >  						get_sb(log_blocks_per_seg);
> > +
> > +	/* single zoned device needs to remove a super block area */
> > +	if (c.ndevs == 1 && c.devices[0].zoned_model == F2FS_ZONED_HM)
> 
> Does this work?
> 
Yes, it works.

I have attached the results of test on null_blk below.
If you have any concerns, please feedback.

						before				after
legacy block (32GB)				136 (GC reserved = 130)		136 (GC reserved = 130)
single zoned block				676 (GC reserved = 578)		656 (GC reserved = 560)
(32GB, 32MB zone, 8 conv, 1016 seq)
legacy + zoned multi				656 (GC reserved = 560)		656 (GC reserved = 560)
(32GB, 256MB legacy block + 32MB zone, 1016 seq)

Thanks.
> > +		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));
> > +
> >  	return usable_segs;
> >  #endif
> >  	return get_sb(segment_count_main);
> > -- 
> > 2.43.0

