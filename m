Return-Path: <linux-kernel+bounces-218640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E2690C2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0F91F2429A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106401BC53;
	Tue, 18 Jun 2024 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WvPRJArM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED91D9503;
	Tue, 18 Jun 2024 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686942; cv=none; b=jFB5fd52ZGzgYhOjd13iVFJPlNNFAIvyX3g2Ix/ynyafNqqu3Tu/rSXxIJOhTaLbCjOZ9hbwHKX6VsM6xzubMGlz9b8+MFoPi1GpwuIMOlDjPiX8l0QG3i6Ad95V2CrJE74HEVYUaAuWfyh8P4F5mMGHHhjPppNi8cAUVeE9iqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686942; c=relaxed/simple;
	bh=AlZ/wCfSEhRubv+Tmz0Bqb1i838j6C8aXAwYxBrB4zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=izoxnf+VL9JdaxHwpU923gC9gV5kYG8EOFL413zeXzdeI8AB3N4jRUpxG5Ayf6q3sJKnU0WhPDGvpgV2onAOvgjo1L8UwJ21fH/OAZ9QHvQ+9nfPXqwRMtV54FuQTdYBBbfbuKjl8A4+7KPSwTJcLC99tVvg8VECRkKwPBKRsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WvPRJArM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HJoYWI027454;
	Tue, 18 Jun 2024 05:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1APkn2ueUgDZ94kOPMZfO4
	eT2SKheEiO99NTt1S1EL0=; b=WvPRJArMeEC0Lflu2MVSkwjr/QywSzwX1a1q3r
	mamYLn6lh0ep1IDbeZU+EpBSS1AaTQ85S/rpW6Echdipv+rHb+Ul+4xk/Q9LVMHs
	9q7KYbowNVw0ogb+QX7MRGc1vuPlZ+zHWOfjf2rmmDXsmjV4pCKOq5/TFZln4gbP
	hgrzz46mquHMImI/q5D7JlrDAzxhe5eqBidfLXcat8MGHBo+eEnEP6kis61SHObf
	hCT4Km8YMz3X4oYi0W0YvgiuormwvZvOh9B3HpMv2x1ahmDIWiuXs+uNdr7q4/Zu
	rKiMIpJaosnPku0sS+Jwop/MK+RqIhE3diQR7LU04E1uiBZA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf5jrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:02:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I52F2w016138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:02:16 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 22:02:15 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 22:02:11 -0700
Subject: [PATCH] dsp56k: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-char-dsp56k-v1-1-56e435ffa664@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANIUcWYC/x3MQQrCMBBA0auUWTvQhBhbryIukmZqh5pYZrQUS
 u9udPng83dQEiaFa7OD0MrKr1JhTg0MUygPQk7VYFvrWm8umBNm382YhFcSxVoJJl3OfkbnOmN
 TH8c+WaiHRWjk7X+/3atjUMIooQzT7/nk8tkwB32TwHF8AfoKV+GMAAAA
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jqom5GfUZgX4k1517bxiaalDyJ_2vQ7j
X-Proofpoint-ORIG-GUID: Jqom5GfUZgX4k1517bxiaalDyJ_2vQ7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=877 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180035

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/dsp56k.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/dsp56k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
index bda27e595da1..1c2c8439797c 100644
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -530,5 +530,6 @@ static void __exit dsp56k_cleanup_driver(void)
 }
 module_exit(dsp56k_cleanup_driver);
 
+MODULE_DESCRIPTION("Atari DSP56001 Device Driver");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("dsp56k/bootstrap.bin");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-drivers-char-dsp56k-44812d9bf9d2


