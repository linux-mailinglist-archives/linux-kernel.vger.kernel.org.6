Return-Path: <linux-kernel+bounces-216681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCE90A2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E31C2115F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B317F39C;
	Mon, 17 Jun 2024 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hrPsjxyh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9EA31;
	Mon, 17 Jun 2024 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718596385; cv=none; b=GgWzkgl+9jThjiBX6cMoYzgu2HBcL68WZx1cFGDeTCRKIn8Ww7cR3H9TGN/k/vQQ4pxJo04RrgQytZv0+zbzEtj+G9WdoVzRSDqgzv1NuFVH3NP4WweXoAZionkZ0XEkrqtNTcAVqJmh/XBgPnCNRp1MfKVxsIARgbpma4WDyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718596385; c=relaxed/simple;
	bh=+DEENcXMKXyiWZXETIGEWVoFCDj5PxY9bRACXwxWcyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=C6mN+hYDZDx5ZPTh3NM4XiCXTuOqAq/0YKvdnqy9k7irt9VuxIz2CPDmiqLKIlN11mxC0OM6b9/ughLm4mi0igBi3mj9Ef5SipF6ldlosOE5rClOtp+v6PGiDXNGJFrGoyGML5+5jqX5A5o+r97iCpopmh2+ZI2jbRuswjfmkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hrPsjxyh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GNjv9C027906;
	Mon, 17 Jun 2024 03:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HG6oEJg2/GeNLGbGBK0m7n
	b1SCOW0UJLipys6dM2UyA=; b=hrPsjxyhiDCBvrhyEC4QxJW2LhyKwED6zAzhgI
	4uh/NJOT5O4PBqOxPc1FMyguRyMV2YmGJXVZm0CCzDH9xZwqbTaDtW+nQRV8PRNn
	Vc8jCY23r0y/SmNc5Szi6qFKRV2hCUepS3+5ihFo1vj+yumRVavfhMXRIjBEMv6t
	y+5o7+k7y5+qKc9tIR3tp2mONwfmxqoGS9bEXMoRkEPe9JG8j9IfCtKvcpIdC52X
	CnXNYdiQUX//aheimnBIqPWHQrqNfATr2WphW5aWx7wo7GtInXJaTn79kkneUfqc
	AoC2HdOkgJoWd5WvElVfncE4o2lU+feEXiuWxLqoV0RPD9rQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3b72mkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 03:52:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H3qS17022208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 03:52:28 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Jun
 2024 20:52:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 16 Jun 2024 20:52:26 -0700
Subject: [PATCH v2] ASoC: fsl: imx-pcm-fiq: add missing
 MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240616-md-arm-sound-soc-fsl-v2-1-228772e81a54@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPmyb2YC/4WOSw6DIBRFt2IY9zUC9ddR99E4QHjUlyi0oMbGu
 PeiG+jkJie5v41FDISR3bONBVwokncJxCVjulfuhUAmMRO5uOUlL2A0oMII0c/OJNVg4wC6aGr
 byUJi2bAUfQe0tJ61zzZxpyJCF5TT/VE2kJtXGFWcMBz2nuLkw/c8sfAj9Gdv4cChRlNJroXNK
 /n4zKTJ6av2I2v3ff8BxWTWQdkAAAA=
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix
 Kernel Team" <kernel@pengutronix.de>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-sound@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7_hVxNreZFW5jF6KCta9oeKbC7ELmJx9
X-Proofpoint-ORIG-GUID: 7_hVxNreZFW5jF6KCta9oeKbC7ELmJx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_02,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170028

With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-fiq.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Fixed spelling of Freescale
- Link to v1: https://lore.kernel.org/r/20240615-md-arm-sound-soc-fsl-v1-1-8ed731c2f073@quicinc.com
---
 sound/soc/fsl/imx-pcm-fiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 0d124002678e..3391430e4253 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -319,4 +319,5 @@ void imx_pcm_fiq_exit(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(imx_pcm_fiq_exit);
 
+MODULE_DESCRIPTION("Freescale i.MX PCM FIQ handler");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-arm-sound-soc-fsl-c598fb353e69


