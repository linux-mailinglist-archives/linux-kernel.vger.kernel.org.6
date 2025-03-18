Return-Path: <linux-kernel+bounces-566211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7CA674FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7625E3BEE32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2BA20D4F5;
	Tue, 18 Mar 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aFInx84s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64A20E027
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304133; cv=none; b=neVwbn11Lmi2HNAcCMTJ4Uuo+XquTPEu6oT7cDmMyjIsGRsBO6Qj1AJwwAqpeCm7xsOQEhXaeCN7BZGmL7HTY2fScdATMN9a6jP7qR4F3Unnr41KN3pHsMwtgENct4tKWZGC351LNTLkE9YQJyvvezdwUHdk/pUGwRkT0hc2t+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304133; c=relaxed/simple;
	bh=tLjVCeidA4XxC4ytznLkRf3RhpABAtXsV1uxmWtljSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X77v2ybamDcS31RpVEO9vfXXBVf3QUH7smPgVuNKeFmr0in9k/JXrRaLL0cmSd5Xcm1dPiSMfjdY4mRo+AyNZV/DS4k8zfwxZBCpfr+MtD2PJT0dI7qOcIeQg9/SODI35JKWooacKgrxHNhuYYRhs1vP//aM1cidBp+dBMHmIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aFInx84s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8jKqd004544
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	35TBaT2+83Cg64d1PZlPRf7THWnfYz9oGJDXX9UMi2U=; b=aFInx84sQ8RRn8rX
	+ebrdMyeQtsOLzwuTjX0ks8vlW3s+vxGHb90WdnsqD3N07FmkHk9PLBfdw/0IiEH
	XBi3E9HYqs+hNndU9Jb9LR8rRgY3Wb36SAyRhjOMa0zYt9k7sIfGwazM/541imZL
	+h3fGB83LUrRRNLUSuo7eHkoBjJqgbGSrr/JQOs63l9o4XLUDguPhxgbDcOKGsCQ
	ocZRBTABb4AdK1kjPCIqH4Pl1JUbXkjSjMf4MZD16nYWHD8YYlrcb98F5XETw0j2
	JF4JEcbywHZRhnE++nuXGk4/IK9VKDAKV1U66Eguzqp7AVQV0Ah8iF0z8WY57FD4
	aqim+Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbtjk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:22:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6eb1e240eddso12708886d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304129; x=1742908929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35TBaT2+83Cg64d1PZlPRf7THWnfYz9oGJDXX9UMi2U=;
        b=LSVdsolrEIdkpmiapXQ8kvn0Pje+wEZ2/PwlYZfqI9reiE95NELBHfLA2aJ8qA2M1r
         B+ZE0A6RgvhCNX0Nbd9lyq9F1DQNV+fHwi3yQWqmM4sktcyBkBStkQZsit7PLT/1BlwT
         b5OyEQnka+BpOaFUZtkEfW9AENxv3pBa+NADmncG//btK2FP4xSM9M2X0j+HkT6YDLSd
         NfH6CSEYhZZIGvugkFRAKsCrfAliy3+ITzWf9qaFB49RBV98anxk1Kq39oIMvWhk+F4v
         g1lB9BQK207pr6aF6qWTZ2i/Tsb395SNCjMfHZZUS5nMBSia57zpuuBko2ySBKiFDeMe
         EkYA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPb8iUrTS/Ulg64EFV+bRbHCnbQLCOIvqKuj79SF4QoOY/36/qoRnOzx6Ur+Vxk0w5HryK9M3x1ezuXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAZv3P4DoKVQ6ZNZSO7skbMvGq/0nKed65HCfilavVnXmqM/r
	vemdy0c5FqZ1yyymlZ6Z+S7ajZF1v3SrSzEAqPGNPRWGbgWGvQ8DI1pAIeLYH4v1D3u+3gYSjuO
	2zmB+72HnJa8OiUU1SiZUwbiPn0OfMIb+gj1Z83+JGNklg8JjWqBcJsorDa9cxVc=
X-Gm-Gg: ASbGncsqhnBOMane+GdliLRm/JHjheioxUCaJBgsNgpHBIuw0UaF1Ic3ZTmICpk40i8
	XVlJkIrSWPeTm44/crgCA0eIujBEiBkuOg7tChxoozxOdrobQ/AFtvHSl9EMatfst7UaTXJfuzi
	xALlJQL7x0SRb4hBGuvv3W/FTTJ1LLwRU8kzLU8MKRCTxGds7OjcFv9ZC6fcHFwOSwmoWOaFBjn
	Co8GyQrKY+cSHwe3dR5cmyQqwLGyURiz+zC1H+Bktr0gDb0Q4mRJhB6ohp4qEiZNdhrDn/pjhhc
	9i9LC39nQICR+F8W63ml+FFbOxtimbkQ0seKEfa0NGvQCjaV+IqLEcOg1sIGSvV9s18W5OI5jpS
	bRCmoMlH4qFVkMh3M2eukvbzZ8jbe
X-Received: by 2002:a05:6214:e6d:b0:6e6:5e15:d94f with SMTP id 6a1803df08f44-6eaeaa8e068mr235421876d6.27.1742304129517;
        Tue, 18 Mar 2025 06:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEid2bgsa5C6EGyKhom1hcOzDqdCNsgC6lqLPAGPrirEYmAM0zizkPcxE56W3DH8hIcoDwtMQ==
X-Received: by 2002:a05:6214:e6d:b0:6e6:5e15:d94f with SMTP id 6a1803df08f44-6eaeaa8e068mr235421536d6.27.1742304129179;
        Tue, 18 Mar 2025 06:22:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a79c4sm1664831e87.226.2025.03.18.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:22:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:21:58 +0200
Subject: [PATCH v2 05/10] dt-bindings: mfd: syscon: add
 qcom,apq8064-mmss-sfpb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-nexus-4-v2-5-bcedd1406790@oss.qualcomm.com>
References: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
In-Reply-To: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Lee Jones <lee@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tLjVCeidA4XxC4ytznLkRf3RhpABAtXsV1uxmWtljSw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn2XN19yjeAE/FrJ460aVoGzoua8M7KKbdxkvWW
 fkAut7kGcGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9lzdQAKCRCLPIo+Aiko
 1XkSCACU5gFpR9GRidct5OYxUCvwTTBl0VvkrjXfm5OyvOGome0NlRe7kBR4WWFfsG3BbUej+0u
 YfikvKIAqKMeHbRXXm9lBNvHZAV47bNHobS3PLJ2gOB9yBgYrLBUOFYNh4Mr8U/JK+3LaQMfSpk
 U83YvM/skgqyHhikgZ1kgXhwoiWiyN3ZeWviiP+MfTkU+JyUNQjkvR5HXmmI7TU2DqgYnCdj/QO
 qvrPliGG++ZGYITm7rxp/0k6V0PVtGXtonhIROkIM+LsYdZp2tpTqlZTfPd/t8oL5PjjQOTQW7/
 9cYvA32EgCddLLgZJ3FGfMNC+hxG3N1Mi/s+01T/BaKQ6Cqc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: _A8vRWHS6gvozqQqpOL9_2X_ZUG4HlEv
X-Proofpoint-GUID: _A8vRWHS6gvozqQqpOL9_2X_ZUG4HlEv
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67d97382 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=Gjla_oY5Z_Fy-GYXBTcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=908 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180099

Add compat string for Qualcomm MultiMedia SubSystem System FPB.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 0d2530bd05b8c114232926e3ba8b0fed99e276f9..60f153cb57d56b00813cf65070fc4636141c5b52 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -95,6 +95,7 @@ select:
           - mstar,msc313-pmsleep
           - nuvoton,ma35d1-sys
           - nuvoton,wpcm450-shm
+          - qcom,apq8064-mmss-sfpb
           - qcom,apq8064-sps-sic
           - rockchip,px30-qos
           - rockchip,rk3036-qos
@@ -196,6 +197,7 @@ properties:
           - mstar,msc313-pmsleep
           - nuvoton,ma35d1-sys
           - nuvoton,wpcm450-shm
+          - qcom,apq8064-mmss-sfpb
           - qcom,apq8064-sps-sic
           - rockchip,px30-qos
           - rockchip,rk3036-qos

-- 
2.39.5


