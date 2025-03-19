Return-Path: <linux-kernel+bounces-567438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B18A685F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF217793D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144924EF8C;
	Wed, 19 Mar 2025 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMiG6fUd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B516E863
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370171; cv=none; b=uxmbvmTHqlq7MmrSLLhS0P6/2U38nC0M1X7OpqnvswEghZHR6l0vif4LC0GN97E+nvZ/muWtwx0RDPSmli1BBlNgnWUdeM0E7Tl94wiIXBVJBiErXZWL1mX2k/R333xma18pftAhYjh6eQWrCxQ5uGa53ZugoodrdadRgylfRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370171; c=relaxed/simple;
	bh=A3upgMdd3p3F0mJjZSeVytonLMMt0jGHCZ5/TYwCOq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJ3sgG1SJ0eql1LHrxWcvs1D4i1MWdCrMBvYIkZl+hpho2ZZRkxXzJjSSAcBfP4QKORXhzXRPyJK8vfKdxUvfmSegi1/n50VlVg6xdnzc5dYF3rs7lcCPIOXMzfSNLG8KQXyXASl1e8WOQVG+8+22NvpMblr80Sdm7Q9Iy/Ahao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMiG6fUd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lgoH013129
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lMALD0Hve+i/GClWHdNV7zBXMss56VupDcZ
	53K5XeAk=; b=DMiG6fUd6j7m0B0zJ7khBMqj4aaEHsTpzdDuAUoIiAQv3Sm0oYA
	g1LfIUeeDZskcbUVbG1BAehGrfyDvs7mBGozs2dE/CcVFAuI5k01xW2RnIMUFMew
	0NUnqgvKLR0NlnDxQBeSOfvWQGUgB1x78LbUTuKKby7nB5OLdPngYS/DUdyWgDNP
	oi+WnnWHtXREhILcWhvoKvsTgdLmCRIYPMQcIgzH3mDiwvjfg0cCrkgQdRDH0y+0
	BVQVnYpEboNfLGWr+tTzGnsk+R3dn5/FHnZteO8zxmckKKu/zBr1JGNtZ0xOiwFm
	JKHHVt6UlVzeIyF2g9Vj44QYXPspLvHGF8Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtmk4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:42:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6eb1e240eddso27621136d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742370167; x=1742974967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMALD0Hve+i/GClWHdNV7zBXMss56VupDcZ53K5XeAk=;
        b=wJDhEAkfL8KY4WvCWH17pNxl4ijXwOMZWVHzMhP0JS2h9FwXCDBaUEAUSD6mzjUX7K
         I7GfiGyXKLPUPujAs/Qp9SURuuRwKCaLZ4yloWsZes49U7WvW9WMdmOEUkKx1lgXoa9n
         FQfv2n6vYuiHya7H8HLS0O0WNNO0NY0KyYXwIDn6oH+yMe81Z3gINZW2Y4oFOb0ataAA
         D3DgnmCw2mIT7WBMFpOLS0QL+V1jBJl0RYu1RRh1+SKv8bsA2tsYm1icyFQ/2D40TEMS
         OLqUTZ0s0ISTXItSdlQ/mga4JRCiCdPJbsH1dDtoszZbjUnAoKuJwm2uWXRjskkajJXA
         bjOA==
X-Gm-Message-State: AOJu0Yx2qXrmxL1SW8kByXrLpLCNp1zCpn1OSr3qLKz0GkOXn1LVzbps
	4ZS7Sjs1pSUpVgpNIDCDSdIKFbGDaymtYJzJrbePSuK5YBbt2qAeasErF+pJQWTT6m6mS+U2Wnm
	rJ6pb1bNlUiaZatXrOUr+J/zC58d0s84QeF8Mq/91Pfz70qbxfiAwsW95Be5M4/cvbNxbnhtb/w
	==
X-Gm-Gg: ASbGncunF1FoNMp76O8hyVKFX0lSsfUYADs/0FeX3GAnBouq3TYx19e0dWuEGWJ3b/0
	O8qi4qIYFh0fo5AQZpcN2Q75m+Pn+NTQFpMtuPL5rIqgFfypYb5q2lXDp8PeHM9jeqr6nPFKXL4
	iqkYoi+zATDfy75f90s1jWd/oyiA8JOrgSTG9OiBiwwqIYQ8zxNf0vyCDnNF0u0dLClSZsd1RtN
	iAZcbLX0TS4yag+vzJymWARPTiANlaaK4Y2b0KQ1BErr/xLIRRX4XT6T5ABMBdwqOayO+g7m55k
	xmn8q5wSezENxyPhyM7KKanKoUVTWPCzeueSFEuYkw==
X-Received: by 2002:ad4:5f8b:0:b0:6d8:b115:76a6 with SMTP id 6a1803df08f44-6eb28f74a48mr26669686d6.0.1742370167052;
        Wed, 19 Mar 2025 00:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4gA1ZS16L2OBmxic0C8JJhHMjFNqmulO61pKUHh+FpPsi9nD/+nleRfzWPJ+1Vm1XhO2qA==
X-Received: by 2002:ad4:5f8b:0:b0:6d8:b115:76a6 with SMTP id 6a1803df08f44-6eb28f74a48mr26669546d6.0.1742370166726;
        Wed, 19 Mar 2025 00:42:46 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:b6ca:9ea6:6507:9355])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f33242sm10773555e9.5.2025.03.19.00.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:42:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Update Loic Poulain's email address
Date: Wed, 19 Mar 2025 08:42:34 +0100
Message-Id: <20250319074234.165613-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zd8CNckHaNWQknGou8Wj6Aq_ofNVqKjN
X-Proofpoint-ORIG-GUID: Zd8CNckHaNWQknGou8Wj6Aq_ofNVqKjN
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67da7578 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10 a=QcRrIoSkKhIA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=stkexhm8AAAA:8 a=_yfGIwS9ScqeBdm4lDcA:9 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=622
 phishscore=0 adultscore=0 clxscore=1011 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190052

Update Loic Poulain's email address to @oss.qualcomm.com.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16f51eb6ebe8..87e7c9ffe528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19545,7 +19545,7 @@ F:	Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 
 QUALCOMM I2C CCI DRIVER
-M:	Loic Poulain <loic.poulain@linaro.org>
+M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 M:	Robert Foss <rfoss@kernel.org>
 L:	linux-i2c@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
@@ -19668,7 +19668,7 @@ F:	Documentation/devicetree/bindings/media/*venus*
 F:	drivers/media/platform/qcom/venus/
 
 QUALCOMM WCN36XX WIRELESS DRIVER
-M:	Loic Poulain <loic.poulain@linaro.org>
+M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 L:	wcn36xx@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wcn36xx
@@ -25655,7 +25655,7 @@ F:	kernel/workqueue.c
 F:	kernel/workqueue_internal.h
 
 WWAN DRIVERS
-M:	Loic Poulain <loic.poulain@linaro.org>
+M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 M:	Sergey Ryazanov <ryazanov.s.a@gmail.com>
 R:	Johannes Berg <johannes@sipsolutions.net>
 L:	netdev@vger.kernel.org
-- 
2.34.1


