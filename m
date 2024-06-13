Return-Path: <linux-kernel+bounces-212519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168959062A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FB32838AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F6130A53;
	Thu, 13 Jun 2024 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lkq7CXMW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF63748E;
	Thu, 13 Jun 2024 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249212; cv=none; b=jVjX04mipgnyUw3Yg2MbBt1TdXpbTuqKPgzNmMqhNHv3n2uEzmED1ILsqR5VKncvVJf+6xdcc9Vuh+J9Dz4VUpdrs8GJ6zo4vUOcEikUjdtDvPIpYnH7eU3VvWYSpnyzqOksLNKjU0Yb2D3dvHk6fwhO1LvLE5Juo5Cia7J8ifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249212; c=relaxed/simple;
	bh=Ci/6KzgUEyT4IcUqdvbSzPDG4P3cJd9nDSTz7u6vAGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PupFgIUND4qBO6vUbTtCgFrPA1irue5maS2xVwQ6bNH+INONdULNDkwYcPIQIWi6bji5G0FzeXNWi2kxru141d9N2g+GsM83848o9/rKA7NEuKd06F9FzUuGTta6S8Upk2vh5czLffcoC1yK59hQGbC89k1eaZI/eB3hpe4rJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lkq7CXMW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D22sCA004228;
	Thu, 13 Jun 2024 03:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yc5eWxdqnW699o6z6p1XlX
	XM745raYjvb+nBTtzQq0o=; b=Lkq7CXMWltg0UF1UrfbUH4GooD3eEsJOuQoMov
	z3CfGyrrFecsJ++ymIg5odPn5VimB9gYW/yGq5VjYNUadJG3IEV/tS77cOehBJRe
	brqF1QJ5c+nFM/d5BOWHPsaL/vSGcHRabI2bv5VfbvSg/UbZjJ/aBZcFVEESY9xf
	Brer1DjD4la05yylGSu67ssafeh1B2dQX2SvP1yFLlJNLZVMV8xNc7Q3yFjmbiP0
	J3F2rckDzeR4VZf5PW3E3VfSnQjCPYpHCj6ZKyTsz6NPUTtcvci4eekTpv2yr1Wz
	yybJz643lCZxtyp9HKU4h0e1qim59Ykp3DLjWMo480QG7IJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqqn304bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 03:26:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D3QSFF019533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 03:26:28 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 20:26:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 20:26:26 -0700
Subject: [PATCH] ASoC: amd: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-sound-soc-amd-v1-1-ad1de0409c11@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOJmamYC/x3MQQqDQAyF4atI1g3MTEWhVyldjDNpDdRYkloE8
 e7Gbh58i/dvYKRMBrdmA6UfG8/iiJcGypjlRcjVDSmkNnQx4VTR5kXOLZhdte9i7AMFukbw20f
 pyes/eX+4h2yEg2Yp4xl6sywrTtm+pLDvB8p14q2BAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jUJ8Od1hB6UnDkUhtqAF6F901r_euKbk
X-Proofpoint-ORIG-GUID: jUJ8Od1hB6UnDkUhtqAF6F901r_euKbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130021

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/renoir/snd-acp3x-rn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/yc/snd-soc-acp6x-mach.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-i2s.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-pdm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-legacy-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/acp/snd-acp-pci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/amd/ps/snd-soc-ps-mach.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Corrections to these descriptions are welcomed. I'm not an expert in
this code so in most cases I've taken these descriptions directly from
code comments, Kconfig descriptions, or git logs.  History has shown
that in some cases these are originally wrong due to cut-n-paste
errors, and in other cases the drivers have evolved such that the
original information is no longer accurate.
---
 sound/soc/amd/acp/acp-i2s.c           | 1 +
 sound/soc/amd/acp/acp-legacy-common.c | 1 +
 sound/soc/amd/acp/acp-pci.c           | 1 +
 sound/soc/amd/acp/acp-pdm.c           | 1 +
 sound/soc/amd/ps/ps-mach.c            | 1 +
 sound/soc/amd/renoir/acp3x-rn.c       | 1 +
 sound/soc/amd/yc/acp6x-mach.c         | 1 +
 7 files changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 60cbc881be6e..0bc8617e922a 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -616,5 +616,6 @@ const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(asoc_acp_cpu_dai_ops, SND_SOC_ACP_COMMON);
 
+MODULE_DESCRIPTION("AMD ACP Audio I2S controller");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS(DRV_NAME);
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 3be7c6d55a6f..4422cec81e3c 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -475,4 +475,5 @@ void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
 }
 EXPORT_SYMBOL_NS_GPL(check_acp_config, SND_SOC_ACP_COMMON);
 
+MODULE_DESCRIPTION("AMD ACP legacy common features");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index ad320b29e87d..565623afd42e 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -247,6 +247,7 @@ static struct pci_driver snd_amd_acp_pci_driver = {
 };
 module_pci_driver(snd_amd_acp_pci_driver);
 
+MODULE_DESCRIPTION("AMD ACP common PCI support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(SND_SOC_ACP_COMMON);
 MODULE_ALIAS(DRV_NAME);
diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index f754bf79b5e3..bb79269c2fc1 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -178,5 +178,6 @@ const struct snd_soc_dai_ops acp_dmic_dai_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(acp_dmic_dai_ops, SND_SOC_ACP_COMMON);
 
+MODULE_DESCRIPTION("AMD ACP Audio PDM controller");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS(DRV_NAME);
diff --git a/sound/soc/amd/ps/ps-mach.c b/sound/soc/amd/ps/ps-mach.c
index e675b8f569eb..ff8ad036b077 100644
--- a/sound/soc/amd/ps/ps-mach.c
+++ b/sound/soc/amd/ps/ps-mach.c
@@ -75,5 +75,6 @@ static struct platform_driver acp63_mach_driver = {
 module_platform_driver(acp63_mach_driver);
 
 MODULE_AUTHOR("Syed.SabaKareem@amd.com");
+MODULE_DESCRIPTION("AMD Pink Sardine support for DMIC");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/renoir/acp3x-rn.c b/sound/soc/amd/renoir/acp3x-rn.c
index 5d979a7b77fb..3249f74a0197 100644
--- a/sound/soc/amd/renoir/acp3x-rn.c
+++ b/sound/soc/amd/renoir/acp3x-rn.c
@@ -72,5 +72,6 @@ static struct platform_driver acp_mach_driver = {
 module_platform_driver(acp_mach_driver);
 
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD Renoir support for DMIC");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1760b5d42460..4b32517c1b7c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -504,5 +504,6 @@ static struct platform_driver acp6x_mach_driver = {
 module_platform_driver(acp6x_mach_driver);
 
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD Yellow Carp support for DMIC");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-sound-soc-amd-d761170e0e31


