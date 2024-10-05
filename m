Return-Path: <linux-kernel+bounces-351644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD1991426
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FAF1F24181
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 03:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AEB208CA;
	Sat,  5 Oct 2024 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g2321tHH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF0211C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099866; cv=none; b=PmmMNW+oidyn7IKZUB4F35eGi6LmalXtAovb3etNkbqvaqQyQVYiIxzI6EtodRXJoqqIyyTcumHbIrgvws7qx1kJAnfjp54LH0rNEfEjsfFaUYklM+rqnTawP0BvH1XwLtoMHXK+lNt8dlKX0YnePqB2vLaMz5oPpq74hJ3lneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099866; c=relaxed/simple;
	bh=fT4pGPhw9oOgaC5NQBOv5uUKaJKtqubAWz+cg5KbCAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LPvUU5O0qOhijV8LYKhPGi5k0Qo5Sew5MaCwTSTXZ7HDWmoq6R2E6Zp6R3g8jH3TVklEr9j4mSGXUAZ9qZYwVsXd0lHmrnXIplx82FqANtF0Ljj/14xBO0hH9e/7S6R95XFlKwUPzBftu5YoUVopH7xTgsHQdKWkOagBOjcDGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g2321tHH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49514o0i017091
	for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2024 03:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q5eolaYck/S2yKDqIH6K5o
	mQqj9LrAofaXanA3ShjV4=; b=g2321tHHSXvrNicINtfpLieossimSsFOBHfYPe
	UAuGXcmhV0Fq7CR1nTNJ4ltRprNtZ2I3lciP3YS3TOZ5JDtUDigr1qGWAiAJpHaG
	wSfkkn2HRAW+k93lgivgsPoJpRpVEx0e414CgzQPn3Q25bx32MbyNvN8jqOT/y5J
	Tx97b69lJf/JslZBB4LCfvx64mVJE24x6lueSwZIcCH6gcDd/cp/FOFhSsvHHVAR
	ugcDbVqZ+iT/FHkazOMJiIJ34wvt0p220/2TCKvVEy0r0NixcM+nxwWBaJBxuLVx
	AzsJNg31xE5kR7mMlNKhf6O7j8JvG4vo7rCptUv7rCgIubXA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422ttn07a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 03:44:24 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-286f532c9d5so2240401fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 20:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099863; x=1728704663;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5eolaYck/S2yKDqIH6K5omQqj9LrAofaXanA3ShjV4=;
        b=Dco/eSg5MESYiNRd3UlHi0nTAxiDNDEiBYSr95ueD1FdPRC8slGomNhChv8DCz44EL
         SrwfOgrLKbBpEDv1IlocZfIthvUxToaibu5RPAGOdCIRfURYbbKffvB1Wz0grmQe4mBR
         yoVOAM7x7bWF/m6dgGU5C56rmzK5MuTSCsUT2Ro+ntRs/i7D9ySkmf+cZS+JyIVTmGs2
         uivOF3MSpiZae3lvo6UOtcdeFUqzsEqOOSzQShzoY1cHxexoLlWzBk4Lxmr7b04eA31T
         H3OLttuzGqk3x61Lm28etWLWMbbyBn7z8ObImJu3qxOl1aiNIhT9wOyXVCWQVx0kMx4S
         nrBw==
X-Forwarded-Encrypted: i=1; AJvYcCXh1LkssFiAIGJl9Mhvt7mrucR8ootmvB83w1gUVs/EMMYhNk9Tst5yc5FUqTTjQ3Zpgub10cqsV9QlBcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WckcXKMH4TQIsvQbda6R19Gp2f+WC9pHZTNmsRX3DM4M+ZWt
	M1f8pZv3AMD21YajK46dEYxrN36Z3cQ1QVTpqdfa5MvMnINPCvDguwMHtaNraiIYiZeHNdattKp
	sBqoYttrU810qSpmY2SWR764277X22mXw4jYmHkF8LsJsO99vi+x+V1bEwDkvClp+3AtEidJfWQ
	==
X-Received: by 2002:a05:6870:a710:b0:25e:bd07:4743 with SMTP id 586e51a60fabf-287c18e916bmr3399323fac.0.1728099862952;
        Fri, 04 Oct 2024 20:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt+OakMQhFFKz3hbm+Dg7y40Yn/RL+ZpMB1Io5eCX37bs3y9EOzyE7uxlzH/RP/c7blRpXpw==
X-Received: by 2002:a05:6870:a710:b0:25e:bd07:4743 with SMTP id 586e51a60fabf-287c18e916bmr3399313fac.0.1728099862711;
        Fri, 04 Oct 2024 20:44:22 -0700 (PDT)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287d735852asm565335fac.50.2024.10.04.20.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:44:21 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Fri, 04 Oct 2024 20:47:29 -0700
Subject: [PATCH] soc: qcom: pd-mapper: Add QCM6490 PD maps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-qcm6490-pd-mapper-v1-1-d6f4bc3bffa3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANC2AGcC/x3MMQqAMAxA0atIZgNpCYpeRRxKGzWDWlsQQXp3i
 +Mb/n8hS1LJMDYvJLk163lUmLYBv7ljFdRQDZYsGyLGy+8dD4Qx4O5ilIRmIe6JfbBOoHYxyaL
 P/5zmUj702WhCYwAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=fT4pGPhw9oOgaC5NQBOv5uUKaJKtqubAWz+cg5KbCAE=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBnALbS81WDp9J+kcgnCBnYd9ZmiuGqsuEhxqQqD
 FpSFYOvOXuJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZwC20hUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUp9xAAhul2ZaVx6iXSRvbbAfdlwt+XGpH3k3NBIIQo3WN
 QLcBMU44IWOE7Hae7eIl080mJxo71nwa4Bbj5Mpmj4yW/1RjGB92zEbEDNQPRO5Cf/VYA7g3YN3
 CsevIBIvO8RCZFsM2yJ9ELo8iCPrF6dNUeq146mAydV6/0T1pfljYGkFpLhLh4Y3if03/Dn0fjC
 U+TKX1BE3U4lm+hOQOcBZMsdTJ+PyRFWgXxSWWk5CR2jpzpRbtrI6lfgUofSTbxwxa09Qrhv+7M
 vMtIwaQ0Kq7Ktivtwf5zwIDMsju6mba5KajdMNCrpnGBLZc9S9M4RX9eqQy4EMfGfnjlGhbQza+
 Dx0zNXzwOqk5DodjmJ0h0ST8MizEzavziggBdAE5ZVzAhGKcfnk4ErsHen328fO85tBA+P6nCA9
 137bx69+w2/B/7HhEQoPl8gCiYR56kd9G9MgHUXrQLo01AQ5J05/NXPl+lXzYVuUHhLbSRvxoM7
 cI7Cg10uZltSkwOiku27L+EUCpk38tpDeMRXYUygp4/BhImm99f2voUC8FCYWc/8M4VXQ5avJb0
 kR4nZ2x7RteZ0loaznzALNBL0fkglYbjeHKPWXC8XsdZaDeWHV2kF1yX2RhuRdkRFQFba3IH+sn
 kJTkvBi9P0NA8s7RJzhr7f2KOZxmYFgORaobjBwuvWBs=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: 4Nih729Jyn69hpl0uSPXYSzHJQtQTrBe
X-Proofpoint-GUID: 4Nih729Jyn69hpl0uSPXYSzHJQtQTrBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050026

The QCM6490 is a variant of SC7280, with the usual set of protection
domains, and hence the need for a PD-mapper. In particular USB Type-C
port management and battery management is pmic_glink based.

Add an entry to the kernel, to avoid the need for userspace to provide
this service.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom_pd_mapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index c940f4da28ed..6e30f08761aa 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -540,6 +540,7 @@ static const struct of_device_id qcom_pdm_domains[] __maybe_unused = {
 	{ .compatible = "qcom,msm8996", .data = msm8996_domains, },
 	{ .compatible = "qcom,msm8998", .data = msm8998_domains, },
 	{ .compatible = "qcom,qcm2290", .data = qcm2290_domains, },
+	{ .compatible = "qcom,qcm6490", .data = sc7280_domains, },
 	{ .compatible = "qcom,qcs404", .data = qcs404_domains, },
 	{ .compatible = "qcom,sc7180", .data = sc7180_domains, },
 	{ .compatible = "qcom,sc7280", .data = sc7280_domains, },

---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20241004-qcm6490-pd-mapper-1f04704cd2ae

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


