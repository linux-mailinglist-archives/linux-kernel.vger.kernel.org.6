Return-Path: <linux-kernel+bounces-269947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28356943922
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B328720E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D95416D9A2;
	Wed, 31 Jul 2024 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nui4mRBr"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927A16D9A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466597; cv=none; b=kB1gYDj6ndvcc7llFm2vyr/SB75vet0h1skMtZDTv5EW6vgtt2TO0Y5wsiwASpq9eDqOJpdMlY8zxId3Fr9Ta0JgJP7pyxIjFCX9a0w3vw+NgsRuGU8Up/w3KPOoEKmh5vuIspsoTaaXtcls9DL7ia1MnqOgBjYbdsmbMoUbaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466597; c=relaxed/simple;
	bh=vxumsIETT1KcBmghN7EEGLY7ydnRAHmF/PMHbYauBYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LL6axrkE0bu2DE53epTarV9hasCuAmdYweAHnu5YytGXj4wktYckm5zG8IrYhr38LGTeRIMGI6SZfdzXpa7snZ0S5HAzXaiFQvb2PPyOcbGIR9DcZOh/b8/QRE418qMfK1F8o3Nx/FcjzP+Y2eJAWYQ4afRRKFT/SgjgCXVSw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nui4mRBr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240731225633epoutp027aa4d9e813d867df895efacc26e63b54~nbj2Hp8RQ2658226582epoutp02k
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:56:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240731225633epoutp027aa4d9e813d867df895efacc26e63b54~nbj2Hp8RQ2658226582epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722466593;
	bh=vDXeH3fJTHsPEwzj07yQKF8VAvlIe20juNJuN/XEdd8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nui4mRBrl8GBGThXAVKoCowoNUUu6Dx9tEg2iLiT6mcW4y9Nu48VmYyWc81HcyBV9
	 Ed0AfloZ1uu3AKWlAJ+A/DSI4paM2bLZEI3auKIrEuXGRr1b10eWR9w+iujVeLWmKI
	 9BWsxExQHJnNFlST+1ty3zLuS2fxr8yE/87uYQvo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240731225632epcas1p3cc6bdbcce985adbdf2e8c80ec126ea37~nbj1lKKfX3087830878epcas1p3W;
	Wed, 31 Jul 2024 22:56:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.225]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WZ6sW5hYHz4x9Q0; Wed, 31 Jul
	2024 22:56:31 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.37.09734.F11CAA66; Thu,  1 Aug 2024 07:56:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240731225631epcas1p2658d1e469ff9339c90542f6dd947746e~nbj0Pi_zj0069100691epcas1p2q;
	Wed, 31 Jul 2024 22:56:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240731225631epsmtrp187eab93ac07e44a4a223bdc64f7b9a4f~nbj0O_ax90441604416epsmtrp1r;
	Wed, 31 Jul 2024 22:56:31 +0000 (GMT)
X-AuditID: b6c32a39-b5dfa70000002606-96-66aac11f8ea8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.B0.07567.E11CAA66; Thu,  1 Aug 2024 07:56:30 +0900 (KST)
Received: from VDBS1327.vd.sec.samsung.net (unknown [168.219.243.39]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240731225630epsmtip28124015ac9a82bbb4f45f808923f3258~nbj0F7TzE0342103421epsmtip2S;
	Wed, 31 Jul 2024 22:56:30 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Manjae Cho
	<manjae.cho@samsung.com>
Subject: [PATCH v5] staging: rtl8723bs: Improve clarity of MAR usage
Date: Thu,  1 Aug 2024 07:51:34 +0900
Message-Id: <20240731225134.917542-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmvq78wVVpBot2aVo0L17PZnF51xw2
	iyOfUy1eH7/B5sDisX/uGnaPF5tnMnr0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
	fnGJrVJqQUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaji8eZCmbxVFzs7WFsYJzO1cXI
	wSEhYCKxd3NyFyMXh5DADkaJ7QdvMkE4nxglLlxYwwjhfGOUODv9DUsXIydYx+HVT6Gq9jJK
	9Hw8wQ7h/GKUmNK4mg1kLpuApsT0tX4gDSICchJPbv9hBrGZBdIkVl19zQZiCwu4SEzuOcsO
	YrMIqEo07/0OZvMK2EgcedfFCLFMXmLmJZi4oMTJmU9YIObISzRvnc0MsldCYB27xIkVH9kh
	GlwklszaC3WpsMSr41ug4lISL/vboOxiiaV/NkHV1Eg8bZ0BZRtL/Dz3iRnkfmag+9fv0ofY
	xSfx7msPKyS4eCU62oQgqlUkzq/awAQRlpJoOGgIYXpI7GjKBakQEoiVOLx9AfsERrlZSO6f
	heT+WQirFjAyr2IUSy0ozk1PLTYsMIXHYnJ+7iZGcCrTstzBOP3tB71DjEwcjIcYJTiYlUR4
	hU6uTBPiTUmsrEotyo8vKs1JLT7EaAoM0YnMUqLJ+cBkmlcSb2hiaWBiZmRiYWxpbKYkznvm
	SlmqkEB6YklqdmpqQWoRTB8TB6dUA1NJ5ZTFcvxlcewzmnd+iSovEPzMPOUwqz2v4uSG+9Pl
	D7hKdvMHHHn1e+5sa4EbJnkNnFwCLu/afB5mzeu33Xh3WvqRkDcrFywXuHr2Z1augf4Hn/1X
	v4uoJZhn/Ll6wOnt0bRFIvFTV3i4ZbxauXFBwNtJszTbf8++/Xnd8jXiAZ13GpIOt+nf27JP
	92UW/4WorTIvT5evnbnhAecd8zgnK+l17M0tbbyWDnwbpbqPBazsDJsd9kDFW/RIyI23TnMM
	Pxz7YOTUHK9ZqWlmaSd7PeTEjE0dxzla+fRFGGf/XvT5xl2Xv84rj9Vn1wdVTePLa4l6zjft
	g/Z7sVbdrwVJOsVV4kqnmDPOVX0KvajEUpyRaKjFXFScCAAazXAu7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvK7cwVVpBr+uWFo0L17PZnF51xw2
	iyOfUy1eH7/B5sDisX/uGnaPF5tnMnr0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxqOLx5kK
	ZvFUXOztYWxgnM7VxcjJISFgInF49VOmLkYuDiGB3YwSXw/uZIVISEncb2ti7mLkALKFJQ4f
	Loao+cEocX3iEbA4m4CmxPS1fiDlIgJyEk9u/2EGsZkFMiS+fTnDBmILC7hITO45yw5iswio
	SjTv/Q5m8wrYSBx518UIsUpeYuYlmLigxMmZT1gg5shLNG+dzTyBkW8WktQsJKkFjEyrGCVT
	C4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCA09LYwfjvfn/9A4xMnEwHmKU4GBWEuEVOrky
	TYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5OqQamnD6le126
	MvdvKJfIf/ilGLthU164U4Dgwtbnms7edSsFOqYF/kw+UO3Skhzg95V35d5zc5Qc5v6MKvmw
	tS2sUWTFp0s50RWH8yfoW844UHLouCb71hX6TWkdRdJcXLpOezvW8fB5+e16cUw0wFA+V+d5
	UMPFz8oT1nwV9C6qNuN5LyzxtTU8+dKrar3CQztdhfb99bQWfHBmFePb6eXThZ0zPXsXHIjX
	e1bukXh5p9vj6njZQJ5OeX7TEiMN07q0VYbaomXT5uYxvH++uS59c9cNFcHbK+tXXeQ6mLL0
	tdDbW19nnvKsdgva7PxJLffJ82fLGLQnLF1vH3X91sZPGqZeZc6pTrxqr75HeCuxFGckGmox
	FxUnAgC2GuhuqwIAAA==
X-CMS-MailID: 20240731225631epcas1p2658d1e469ff9339c90542f6dd947746e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240731225631epcas1p2658d1e469ff9339c90542f6dd947746e
References: <CGME20240731225631epcas1p2658d1e469ff9339c90542f6dd947746e@epcas1p2.samsung.com>

This patch improves the readability of the code related to the Multicast
Address Register (REG_MAR) in the rtl8723bs driver. It adds comments to
clarify the purpose and offset of the register, making the code more
self-documenting without introducing new macros.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
---

v5: 
- Maintain consistent patch versioning
- Add change history

v4: 
- Refine commit message
- Adjust comment wording

v3:
- Remove MAR0 and MAR4 definitions
- Add comments for clarity instead of new macros
- Maintain existing REG_MAR usage

v2:
- Update patch title
- Improve commit message

v1:
- Initial version: Introduce MAR0 and MAR4 definitions

 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index c9cd6578f7f8..535cd439121d 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter *padapter)
 	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
 
 	/*  Accept all multicast address */
-	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
-	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
+	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);	/* Offset 0x0620-0x0623 */
+	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);	/* Offset 0x0624-0x0627 */
 
 	/*  Accept all data frames */
 	value16 = 0xFFFF;
-- 
2.25.1


