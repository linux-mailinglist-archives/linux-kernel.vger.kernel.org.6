Return-Path: <linux-kernel+bounces-358260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EFF997C22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327C3B21B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CB192D89;
	Thu, 10 Oct 2024 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lOaGwoMJ"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BA2F50
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536892; cv=none; b=jGJWf0ZCH3Zqcw/4p5LJF3haMqP0pJez29JgNO+iZ7OM1VS+qhuUq0Sjkx1PypI1PuC1PScV8oaHbBjvOesk+eVHTGGL/h1x2VlYCwsgp6AAtRORjKoSEmrC9JGMC5zdZiRmzQ6gT0w7yxcOT9YjXRedUBN1rDFv20aZzCFPWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536892; c=relaxed/simple;
	bh=dHq6VCP1hHO2QytBv9CEweFhJ2eiwLqJv4XOYupTF7I=;
	h=Mime-Version:Subject:From:To:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=fqeaD8QZaj2+sf+2FR4qXlGiHugHJE44EG4osahQEc3Vb0F8e61p1cFLpz9r5DapFzZmrurZ8XDCuPiIbwUGsPyfVaZUQ+Ze/nvgizW0egW3brpSpegXFSxqtE3LHFhRM8Wd72uNvO9yPnPZT/4A0hbLAdE6daHiMcirHW43b3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lOaGwoMJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241010050808epoutp02be039a9a287e3df308f7e70137b8b02d~8-yQ-bwmC1849318493epoutp02L
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:08:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241010050808epoutp02be039a9a287e3df308f7e70137b8b02d~8-yQ-bwmC1849318493epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728536888;
	bh=kDPmTXhPX6cxQzuvSTnQ8wrHQwVwp7TSgQJ6vfD5NDg=;
	h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
	b=lOaGwoMJMCctFMlArcITukaqyJaQ/V1BXHysVh4048VXazrMPxv2MIDrQHmOegG8z
	 PgQn0WXBAvA9k8eW1cb41VIcFn3O5B3oQAUshFCK3SiccpCJX50IAAONnKcaGYSzuK
	 NO3pahkIaiDKYntzldz0nWItWnd5fZ31OwFesd6I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20241010050807epcas2p4c745218ce269021cdeb83774ed7d9b8e~8-yQn6kKG1746417464epcas2p40;
	Thu, 10 Oct 2024 05:08:07 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XPHnz1THfz4x9Px; Thu, 10 Oct
	2024 05:08:07 +0000 (GMT)
X-AuditID: b6c32a48-7f9ff70000002653-bf-6707613757ce
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.C6.09811.73167076; Thu, 10 Oct 2024 14:08:07 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [RESEND][PATCH v2] libf2fs: Fix calculation of usable segments for
 single  zoned device
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
In-Reply-To: <20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241010050806epcms2p8927a8ebf52433366ddcb08384e7090c9@epcms2p8>
Date: Thu, 10 Oct 2024 14:08:06 +0900
X-CMS-MailID: 20241010050806epcms2p8927a8ebf52433366ddcb08384e7090c9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQtc8kT3dYN8pdovTU88yWax6EG7x
	46SJxZP1s5gtLi1yt7i8aw6bxfmJr5kspp4/wuTA4bFpVSebx+4Fn5k8+rasYvT4vEkugCUq
	2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
	nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
	hJtf2Ap6uSs2Xm1ib2CcxNnFyMkhIWAi8eP1DeYuRi4OIYEdjBK77jewdTFycPAKCEr83SEM
	YgoLJEnMXlQAUi4koCRx7UAvC4gtLKAvsXnxMnYQm01AV+LvhuXsIGNEBBqYJXY/3cQEMZ9X
	Ykb7UxYIW1pi+/KtjCA2p4CfxME576FqNCR+LOtlhrBFJW6ufssOY78/Np8RwhaRaL13FqpG
	UOLBz91QcUmJRYfOQ83Jl/i74jobhF0jsbWhDSquL3GtYyPYDbwCvhIPuu+C2SwCqhK7V+yF
	qnGRWHFyIlgvs4C8xPa3c5hBfmcW0JRYv0sfxJQQUJY4cosFooJPouPwX3aYD3fMewI1RU1i
	86bNrBC2jMSFx22MEK0eEmc/B0ECeSqzxLXn3SwTGBVmIcJ5FpK9sxD2LmBkXsUollpQnJue
	WmxUYAKP2uT83E2M4MSo5bGDcfbbD3qHGJk4GA8xSnAwK4nw6i5kTRfiTUmsrEotyo8vKs1J
	LT7EaAr08URmKdHkfGBqziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+J
	g1OqgSnzn9tPqber3ae7+qid0vt5Or2gbcPMQ2qLbq85UvHqQNP9IgUL2118qVWmTptnNNev
	/CYcPtPPp5jnrMLnyOlvGku9BOa8Uz9neDr3x5x36xYmGHGaWPtaMmpzekz4lFmfHhTHuUaB
	sX/tv+aZp6fsaZ2nxTZ7lZDUI4WeGXsOG6TMqQsyOLfFI0zsikPGkv+RXSmvKuNN49+4JMr+
	/LKk6vmrPXWvHCafFQxg8uL9xpkmr1FZKMJ268mPd6/457h6NVjuyMx7Yy63+eMJ3m2Veyec
	ML4+L/q4+JxHzt/DG8u4Z/C0FlYe25W2q124wVTLT95BXK48Q49Fac0Kve1fJYqer+9ecEJH
	2j1qnRJLcUaioRZzUXEiAHG3H6QVBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
References: <20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f@epcms2p7>
	<20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8@epcms2p2>
	<20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
	<e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
	<20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
	<CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>

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


