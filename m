Return-Path: <linux-kernel+bounces-214018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E5907E03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A61C221BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858713E03E;
	Thu, 13 Jun 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ep933FWh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18035F876;
	Thu, 13 Jun 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313573; cv=none; b=uWHBhYFIM8aqGIt6zCNhWVvVC6h6Fmfm+KKzI1rnlVYSfIc6hYAGiOJjjKxuKOaXSHDJUfOYcd44DMCBXy5bCREPPJI9VFbM3r9rDmNz6ISuowSzWa53jSmiBZyYidCl10yEmBhxbYeF/38dihbc4iUBWCwj1l3gtZSFMZs61Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313573; c=relaxed/simple;
	bh=1SjFag+zblxVHVX2U4wOAQCkKSe/t8YFaC7nNewXyj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=A7e5kInD+AjH1U2isEUWbKASCBa4yA/3Cg9MclHYBs+MQR5sj7hN7VYZSimNJa7DMX9T0v+y06jzOUwQ4dvT/4zXlAwwTKdipVKmHlE2ndZ4cuBzhSE7B+5begTo+Ch/NOsmd4XTGNQ7XWMPLKT9Dy3Ck+th3Sn2gdyzAqc4KpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ep933FWh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGNgJ010871;
	Thu, 13 Jun 2024 21:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MK/AxgMbP+eMIJlBexs0+I
	4jPh8964rdSbmmx5rrIpk=; b=ep933FWhfRl/K+6mQ6jfOPHftW9edK/ulwbNxr
	+/Bmy+iMkD9yZAAvTxzWLrZ9TCaITNuwRg2i7YkNZ2HDCKE5LmfsnhXZ2tyPTypk
	kmG7DU8al9jwOHQYA+1EgQJjy+3mDSBitQ9yEZR7XalRlVLC/t+E2+KV4uI/XNaI
	8wk+sFQZVigIaFLX4IK5gM7jAFbwu0cyWmImWpEamsiJTw21N8EkcicuzNWvOlFy
	dL1NBYdorxPDOkxAL04GQfXQ42K35UyPfe6EVC+tb4bJ5qwbM/3r3S+RExyoqVm7
	OnQLApdj89XpmNTg1z78cduAw3++93ohIm3ADPBj5x1cNKvw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q3gax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 21:19:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DLJOom027563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 21:19:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:19:24 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 14:18:48 -0700
Subject: [PATCH] firmware: meson_sm: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-arm64-drivers-firmware-meson-v1-1-28e4138a8597@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADdia2YC/x3NQQ6CQAxG4auQrm0CIyHBqxgXhfmRJs5gWkUSw
 t0dXX6b93ZymMLpUu1kWNV1yQXNqaJxlnwHayymUIe27pozp8hiqWs5mq4w50ktfcTACb5kDiN
 CK730ET2VytMw6fY/XG/Fgzh4MMnj/Os+NL83TuIvGB3HFy3Xr3qQAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cdmlw0QgDzQIQJmTYdZi4gfsRnr1XSk0
X-Proofpoint-ORIG-GUID: Cdmlw0QgDzQIQJmTYdZi4gfsRnr1XSk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130153

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/meson/meson_sm.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/firmware/meson/meson_sm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 5d7f62fe1d5f..f25a9746249b 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -340,4 +340,5 @@ static struct platform_driver meson_sm_driver = {
 	},
 };
 module_platform_driver_probe(meson_sm_driver, meson_sm_probe);
+MODULE_DESCRIPTION("Amlogic Secure Monitor driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-firmware-meson-2ce24a9a9de9


