Return-Path: <linux-kernel+bounces-516347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78428A36FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D485C3AEB8A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C01F4167;
	Sat, 15 Feb 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Lnmi5DA7"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6A18A6BD;
	Sat, 15 Feb 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641563; cv=none; b=hHFYYzNXNE7tc0kDBYjOVH6XjJth7jbPcLdfc5lDxkzI31P+nXeJ5usImAC8B67VVfLHWzILRcryjTQYAAHLan/ZQnqkMmwKA0xj6iDmGH8YIIhb3D1l4Ig3wup8G7yVvDgduNXI4QdABM+WdlqSsIZr+10Sqr2iZUTGW4vHWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641563; c=relaxed/simple;
	bh=BrBmxB6qV1KtB09CF+7fDW5a5cNS7W4d07BH+kxUSR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUOTihT7OiVYlWl9UwH2Q+qQd31WOGQ0JaerPoqZ3KUbOba4CEYnbD/dpSHBqcseyMebBTXayv6QlD0Levp0Du9V2eeLL4X6ZcWSUwaU9cz4azAlH/7RTteIvw9oew1zrUDpuC2d22L2LOUXTYlAduGsn8qNTDs3lspHxHrMtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Lnmi5DA7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641557; x=1740246357; i=w_armin@gmx.de;
	bh=3V97uMLFN9joLBUaGiY8JzzYzBSIJ7LHnWONkuXkoVU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Lnmi5DA7xONb8LW6X0cfa7IOZQ8j++HLRo0fIOf0v12B6pCEs6h0R4ruA9jt1K9l
	 zKODbVMWqh73aUCUKOmBT5s5o3CnkodC2CqmMaGFy42+jKrZA5Hpee50ooBrcvcCn
	 x/JWXwtz6yP3LT1COyCbOOqNcyFo17CmKUSy8Lzc7+GJLWqejN9aT2HuzFYTDBFXo
	 1qyqMF1in3xnzb+7C0VhHV3fR8yc6qjzPSZ/X4Ckq9Bjq4m7d0OvkxA7uF7HS3LGY
	 8BAhfb2mAxlucp6y1ZYol7isT/qyaXXFUGwp1jJY4UfwOKaeyAUCaFAxgTmaEMTPs
	 QJy2vjHA36uDGGmVaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MsHnm-1tUJA63Ope-0138EP; Sat, 15 Feb 2025 18:45:57 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
Date: Sat, 15 Feb 2025 18:45:44 +0100
Message-Id: <20250215174544.8790-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250215174544.8790-1-W_Armin@gmx.de>
References: <20250215174544.8790-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MepY5w1lSLYkMI+WXMyb2vRRrs6oji15agLgR4rn3y+lKe+L2j8
 n4+mnDp23hKKUfGsR0I3FynatnDF9ro/Yl5xIzKuHkOv08VF+MEOfOrTqhZXLAIFKuJOB0t
 hH59Tk+3k1w8IIzFjHH05+2yoBVUNMwtBYIS7/DvEOrkFnrzBmkDKguDeHTbJBpRGc2m45s
 Ey2RY0enLXbBTum9ZuYYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TsjmBlrxoeo=;1J8xsbgAjn3bF5s99yBBWhyLtrR
 BFP6lZ66e7Yxox+2OBSzs/DoGYl+2uxGdVdgfoBdWJNSMcF8Wexs5tGUo4S8oPoyOVBQoHCyT
 yj5dIAy2yTT2i6zwhn3ufG+FxxpeKvGmerTltba633bS0ODygzqTaBGOcDGD5bp5NK1RMiXDZ
 O2DLQQAT+sZX+rfqUuqKY2SwDJuI9TIPS/zwyxjn1JWnnl6L5/VqQw7hppDVZoDhVnn+O7E5G
 uFbjNy6b+xWTNIzUs+X3qKrhGvlp947eklyecv/z4bOELP3q52F5RUmZ9z74HczUOHlMv3EXr
 Wk3S+RwMlWNuMlsK6N9iNmvrl5uiSiC+hD9dDdMMbS6Vd4g/ZA1oiVlxhpTja9TltOIePvzO/
 5VWK+Cf6vVX1Wq/Dr9TsLkcitTm8RKD7LwjjuAbS6mcB41icQlq6A7Ua5cJXjgwpftMOiCcqt
 Yjk+6rfyUtrNrUs6n+mQJDud2vBhU9UhRZ04lacew91EL876K3jkQ0yxNkCkKo7WDSUhmf/vH
 3ysLSdjYoc7RCdXjyPPTpfza9AeZF+fzGgBY105TaDhVs3ooA28TXK+TFUS0FRXE+2V7ATjwO
 hd2Z+vV0XqQw67zFRP+vBBCUDENXclYDAXFZS0bRUhHY8pOp4l90PzE2DtMB968g1imCgG62Q
 Rxsxzy87hoJTJ6cE+jaLgbgb+OJUF06Ow2KUiBhREgX4/99Yx+eYTEH9vL0wEJwxlbyCKrUgD
 zh74Nofs0Hq38cOn9lVV+sv2avQHZ9nfLv+aCz+8Jpj34ZamjaTwjvgL4BFSnkQ6mpZzoWJQA
 VgWp3LxMiSLm2eUs1aUJ4i8Mj8jf2Tph1Gb9zjRuy8TMjmjVaUCSshWOIslyggPAVKBYDYmMJ
 oRSOOTKlzdEYPSa+HO0kODRx6iq5G4JjJW0fvCeg2W7K9vwNT04kFnS6uCo9NJt2BGF1xfoVN
 4iV1O8aQoF3FVu0uan/Zhx3cJK2T0NgGUhXmwKShZYP3pAYNXvd1h7/wJj0KaBvVP5sSHzIC3
 x/dMx1NdXj/B1SddqTVcX++OnuSsdY2KCA/AMI9sJxF9TPU6968PMI/R8PZRRk3Vgg7QTj8bP
 o84V73dWzPV1qgibxajDvwxbdQeyxDZiVCv8kiBfP0KE6yn8FY00qxmwvKWNhkAnEkl/WCv4Q
 YFRLvbtSsWrz/+ugV3xEmZvs28u7GbP89iYSTdZ55P+ncqtXHVq/8h3oKjTHjph79oApgQVgd
 NhTbREl7lbFBMc86fCsagISRLGdSEkgPYL2WGSkKXsYCPXbpZPiwLljEgrjZ0woLW34RXxj21
 zWVFUdkDB+lX/7foSj6KgWhgJiZ8s5geSFdn1D9f6UdP5u/bQ140Z6g22MT00FTIUaH+Wscv5
 /P+Oq1Pkfh2jn4/wru42/uYVoFaZkBO2d/fI8Ql1Q4wJUyerJ8mA/m5QYm

Both machines support the necessary WMI methods, so enable fan control
for them.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index e5aef09d9d96..399b2b2f1554 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -465,6 +465,7 @@ static struct quirk_entry quirk_acer_predator_ph16_72 =
=3D {
 	.cpu_fans =3D 1,
 	.gpu_fans =3D 1,
 	.predator_v4 =3D 1,
+	.pwm =3D 1,
 };

 static struct quirk_entry quirk_acer_predator_pt14_51 =3D {
@@ -472,6 +473,7 @@ static struct quirk_entry quirk_acer_predator_pt14_51 =
=3D {
 	.cpu_fans =3D 1,
 	.gpu_fans =3D 1,
 	.predator_v4 =3D 1,
+	.pwm =3D 1,
 };

 static struct quirk_entry quirk_acer_predator_v4 =3D {
=2D-
2.39.5


