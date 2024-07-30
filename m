Return-Path: <linux-kernel+bounces-267817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCA9415D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C64B1F25304
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65429A2;
	Tue, 30 Jul 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O7C/2Fj8"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8D1A38DF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354781; cv=none; b=G8c7mq2ZfIQqanV64eqSzOEGDYv1juutjLxbyfp5YW9HbgzhCQk7slqY5+GtixhQMiILEvLC1pTEjAvMZgN/K0rkIjqVd2p9CHT1PMAp8n2/iu/yDIKywCDnjkZkVAMgi3CiCvZTO2mqDRq8KhgpriHWetnxHrmjlMN7VdSjB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354781; c=relaxed/simple;
	bh=57PoVLWWcLwWWsmbFJiDjFrqMnB792UmAI7+Kpkk9Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=JZUGBPCSy+6W95qTanO2wGdTvxMIoetGZvO1Il/WLNdxPk/7czTu7U2SPNEEiOdsKmQ/4ykMPruNRdvyFc1fPPzaYuXbuLJnfrMJrmsdMjXfpEv/ts5TVySV+7n78GPlm0jzo2tP8PktD83VfX0fWXe92bG5JtKNSt1vO8FGkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O7C/2Fj8; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240730155256epoutp0196a66e818c056bd2dfce80759073c44f~nCItQR5sZ0220702207epoutp01n
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:52:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240730155256epoutp0196a66e818c056bd2dfce80759073c44f~nCItQR5sZ0220702207epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722354776;
	bh=j/tEllXsbu7xRFKqSrll3TR5x39lxdLlv0YDia1J/dc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=O7C/2Fj8/cnKy5gd37KsmvVavcq/MrnZ/m37ucV+reOOlulcFZ27L8SKnl93GZNuh
	 6tunP3u6Pk4cZFI/WJghdB7sDoZthlznQIjwQiQNLmkuPfYt35FjOXrKGrKY24aWIK
	 JgzzRlcHdFCXrcZBIyx1w4yaGU95DTBD0P5HqP6A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240730155256epcas1p207ee6108c3d157fd0b6e94cdaff8c742~nCIssCN3s2345423454epcas1p2H;
	Tue, 30 Jul 2024 15:52:56 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.222]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WYKWC4qB0z4x9Pt; Tue, 30 Jul
	2024 15:52:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.9C.19509.75C09A66; Wed, 31 Jul 2024 00:52:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19~nCIrvgIw40681506815epcas1p47;
	Tue, 30 Jul 2024 15:52:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240730155255epsmtrp266eb7beb4421d909f2ee64f7338b54f8~nCIru5Kqf1946819468epsmtrp21;
	Tue, 30 Jul 2024 15:52:55 +0000 (GMT)
X-AuditID: b6c32a4c-10bff70000004c35-8a-66a90c57ab63
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.FC.08964.75C09A66; Wed, 31 Jul 2024 00:52:55 +0900 (KST)
Received: from VDBS1327.vd.sec.samsung.net (unknown [168.219.243.39]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730155255epsmtip274a3bb57d926bf29c507a7ddda6325e1~nCIrlJ0_u1316813168epsmtip2f;
	Tue, 30 Jul 2024 15:52:55 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Manjae Cho
	<manjae.cho@samsung.com>
Subject: [PATCH] Improve MAR register definition and usage for rtl8723
Date: Wed, 31 Jul 2024 00:50:54 +0900
Message-Id: <20240730155054.411059-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmvm44z8o0g58NihbNi9ezWVzeNYfN
	4sjnVIvXx2+wObB47J+7ht3jxeaZjB59W1YxenzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvk
	HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
	X1xiq5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnbHz0BqWgma+ioPrHjM1MH7l7mLk
	5JAQMJFouPmcpYuRi0NIYA+jxIUnf9khnE+MEh8n/IDKfGOUuDn1OxNMS/OUd0wQib2MEhN6
	VrFCOL8YJa49u8/WxcjBwSagKTF9rR9Ig4iAnMST23+YQWxmgTSJVVdfs4HYwgJuEjP7HjOC
	2CwCqhKzjv5gB7F5BWwkFp1eD7VMXmLmpe9QcUGJkzOfsEDMkZdo3jqbGWSvhMAmdomJuzax
	QDS4SEy6uJ8VwhaWeHV8CzuELSXx+d1eNgi7WGLpH5j6GomnrTOgbGOJn+c+MYPczwx0//pd
	+hC7+CTefe1hBQlLCPBKdLQJQVSrSJxftYEJIiwl0XDQECLsIXGi8x9YWEggVmLhvcwJjHKz
	kNw/C8n9sxBWLWBkXsUolVpQnJuemmxYYKibl1oOj8rk/NxNjOCkpuWzg/H7+r96hxiZOBgP
	MUpwMCuJ8MZfWZomxJuSWFmVWpQfX1Sak1p8iNEUGKoTmaVEk/OBaTWvJN7QxNLAxMzIxMLY
	0thMSZz3zJWyVCGB9MSS1OzU1ILUIpg+Jg5OqQYmZ0lvpVsnDXztXho9PM1l/XNF1xvGlw1n
	TN28JdLEV22adejjtBh1+yOB55f8eMj0dO2MSJEbGp7Bbap6ezdqbKpWOLa3+9vRx1eqxJbc
	/Zl2j1H4oFl8yp4dDrwsC251aV8zMJBaW3v9itZh3o7C1cWCL44fDSm5GJ0w+5LdNbYjSV1z
	NfIZ9J8tPJDpWusZJ5zPrGUfMZldxpr/o8KZrvOKPu8X3f7b6TN/0t2E3eLn6ixcf3++xVQR
	/zAvcA739kXn3FcUXln7+Zx69qOOgJZur3rHyfwyX40XWGo7JXo0b58yk+HlpVgOrq7onKqz
	JlfiZcWrKgMn6k3kvDj5VdwEqU09hz3evT6d+rZKiaU4I9FQi7moOBEAdl+vdPMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvG44z8o0g5alvBbNi9ezWVzeNYfN
	4sjnVIvXx2+wObB47J+7ht3jxeaZjB59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVsfPQGpaC
	Zr6Kg+seMzUwfuXuYuTkkBAwkWie8o6pi5GLQ0hgN6PE1hktTBAJKYn7bU3MXYwcQLawxOHD
	xRA1PxglGvY+ZgKJswloSkxf6wdSLiIgJ/Hk9h9mEJtZIEPi25czbCC2sICbxMy+x4wgNouA
	qsSsoz/YQWxeARuJRafXQ62Sl5h56TtUXFDi5MwnLBBz5CWat85mnsDINwtJahaS1AJGplWM
	kqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGBp6W5g3H7qg96hxiZOBgPMUpwMCuJ8MZf
	WZomxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqganNcetS
	CetjCw7Jc526Lau9qmlV2KNZFRXz7izcn/7kRdqy9IyeyICNBySfBSTkr/vD4tZoXGr8+Nta
	9fUn7q09Nvmnz22/gFfW5wXNpt7W4t5rtUJw/1K96FWPVZaW7ogPaqr9c3feL41Pkybzec49
	5R6j33888+7U85dr69kWrOHqlj38JIxH1lV0Ukt6nZx/WMme4/8Z2RJsTbf+uW7tP0lk3W3/
	h8Y6VqpWG+V3PPZK+ZTy0LeUZ/ZnzT0T6jf7TpT9XnssrP01d1Vh9fyDTqslQjbc+iBVlpK3
	/q7Rq6jsxdt5PD9Ivr1y/JOsdfbhWbcj58d+ZOGSSz2XvdHKp+DWPobHWjejJ82rXcKtxFKc
	kWioxVxUnAgAi1rB36sCAAA=
X-CMS-MailID: 20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19
References: <CGME20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19@epcas1p4.samsung.com>

This patch improves the usage of the MAR register by updating the
relevant
macro definitions and ensuring consistent usage across the codebase.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>

---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c    | 4 ++--
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index c9cd6578f7f8..9493562c1619 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter *padapter)
 	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
 
 	/*  Accept all multicast address */
-	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
-	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
+	rtw_write32(padapter, MAR0, 0xFFFFFFFF);
+	rtw_write32(padapter, MAR4, 0xFFFFFFFF);
 
 	/*  Accept all data frames */
 	value16 = 0xFFFF;
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 9a02ae69d7a4..baf326d53a46 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -151,6 +151,9 @@
 #define REG_BSSID						0x0618
 #define REG_MAR							0x0620
 
+#define MAR0						REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
+#define MAR4						(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
+
 #define REG_MAC_SPEC_SIFS				0x063A
 /*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */
 #define REG_RESP_SIFS_CCK				0x063C	/*  [15:8]SIFS_R2T_OFDM, [7:0]SIFS_R2T_CCK */
-- 
2.25.1


