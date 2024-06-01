Return-Path: <linux-kernel+bounces-198037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984388D72AA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A521C20BEA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E942AA6;
	Sat,  1 Jun 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ckPCBaMZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9E2032D;
	Sat,  1 Jun 2024 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283392; cv=none; b=dQ3Gf9TW62LaJ7L2kXZE+clTxPYxVFF7FZg6I6Dh+A+5hEQrM1pv5QXqnAaJQrq/16ARxmk6sdfQZvG8QamC/lkEeXNYZa3v/DKhDWB2mP1RhoHahObkaaa6sz3bOO2LIcrOGx/997EJFXL5/N83nn2kB95Ew0eELunIyej1T+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283392; c=relaxed/simple;
	bh=Ejac065p3hSV7LFZ5s2YPxIUBg9t1HCo86cKn689q4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=NzD3Gbm9F5hpcUvb6ziRu2nKSGpnIL0CNcWgpeLQow63VkUak5WIqtoLw6WXUlG09QgjPu0DUuW5gYVAJAYvGJFJSxwzr3gO0ip1ZWJfqGriIblspcvCQv3K2gN8lxD+ss7AYRN1PlyDJADiwPWwvvXfstYRegqLJnw1M/7iK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ckPCBaMZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 451MkTcc018735;
	Sat, 1 Jun 2024 23:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7JsXaXglz8GMwqZbU8D7Xb
	/9VdGkdjiD05GYIpAzQ8U=; b=ckPCBaMZjSNH7UKOy7YaOzOtdRMPx3k8fMCkph
	ZGDxCwYcoHjDKhR/0rVGZfLoQVaHOgpnN10a8wp4JUyDgF8BrnXMIaFhXrgwKYW4
	hbVTLz2mgCzz94rN8VCykvbSE1eGnGhxqLOTXA+2yxAWXCSZScBBFsVwJowS4l05
	dwA7lJVQLXcSJckoVwLzTwShBOUyT7bdSqZgFN85FaMLf97Oojh56kSqikEbaFfi
	tumPuPHtQgH4K2585ORh9asikJkxvzDJxnGpwK2GQ7MFQLfu7q5GCunWS7WHKM4M
	8NpGt4j7RdSnH0vAMW/hC45864g4lBzOI8tpfbS8pD6qr/Jg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v1cad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 23:09:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 451N9m1S013184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 23:09:48 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 16:09:48 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 16:09:47 -0700
Subject: [PATCH] lib/asn1_encoder: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-lib-asn1_encoder-v1-1-8c634ed2d2e8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADqqW2YC/x3MQQrCQAxA0auUrA3M1FLEq4hIZia1gTaVpEqh9
 O6OLt/i/x2cTdjh2uxg/BGXRSviqYE8kj4ZpVRDG9ou9CHiXHCShOQaH6x5KWwYh5Rjf6ZL7gL
 U8mU8yPa/3u7ViZwxGWkef69J9L3hTL6ywXF8Ac6Vk5KEAAAA
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: werer5dGlAXoFJVUR7Gp0UmEtBRgNwtb
X-Proofpoint-ORIG-GUID: werer5dGlAXoFJVUR7Gp0UmEtBRgNwtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxlogscore=977 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406010185

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/asn1_encoder.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/asn1_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 0fd3c454a468..92f35aae13b1 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -449,4 +449,5 @@ asn1_encode_boolean(unsigned char *data, const unsigned char *end_data,
 }
 EXPORT_SYMBOL_GPL(asn1_encode_boolean);
 
+MODULE_DESCRIPTION("Simple encoder primitives for ASN.1 BER/DER/CER");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-lib-asn1_encoder-1fbc163a8c40


