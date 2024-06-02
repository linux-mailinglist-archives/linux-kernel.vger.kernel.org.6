Return-Path: <linux-kernel+bounces-198361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93DF8D7726
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BD281960
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731554656;
	Sun,  2 Jun 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aySk10ev"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B621DA4E;
	Sun,  2 Jun 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717345843; cv=none; b=WZAccKRBtGbpyNWeQd2JTb4kW1wmoGuBLwPyOfOEN6GoRFZCbFzm3NmqlrvVbDGAKJw/uz+N83qtoT1istlhqHW9cV3TKY0KOT8dhhV3JPjE0NxOkWHYWuNivWBdU5RqJA6m7zVUXYHney59bPTkV/rnMC59NbmzrvS5rlaUBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717345843; c=relaxed/simple;
	bh=59+rZxWfeiQW9HhaaMn2cSYRmnsCAnFM81QQlR8WtTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=WrWki9qfUTF1Rwh8X56K/0PtSGNz5K3vuq41u6H8k0uLHmfCK3I7HZ3xsklc9+R6nDUWHePlZMg1q0ObG5fHWNgryqXGoUBBd1SKjOT3jgleKL8IoFsIYldZzjqe9yZZ5bDq0L2qf8f+gVoSIvIw/dgauhZkea31Ic9GHIKk6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aySk10ev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452AJnbl024147;
	Sun, 2 Jun 2024 16:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/cX8LtmgzkXbHvhMCNjc2a
	JIf8DHh2lY14nwv3J09WE=; b=aySk10evnB+8x++c+HoW0tiOlbdCDGLC2Bho3p
	OCo1523LYOvzM1aDnidrqn2dqKM+Zrrbjs6pU/SLTupysoz0vuM1DAXo5zDn44sZ
	vy5QTgS2weEdnqgFgh8xOOh3PYyYVJS0++3vjdv3YTUiBNNIFPP/G1Y5YrdttGs9
	Mb7hEgZoDiEeMxn4SKzE/nUgEmHLMp9vLz/qy7+RLgNYS7ezwDnZUtrvFIXGKvSN
	1Wcyj+cvgVdYm5mY6uZaz1JtLvOv6ww6RYSXkcj0aitQE4VHuhcoFqfKpFzBfBsl
	Cf9uZMHo7cU2EuJUpe9Kcq1cNOhKw9zJAz+ewN0bL+KF7gRQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v29ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 16:30:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452GUEAJ009411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 16:30:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 09:30:14 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 09:30:13 -0700
Subject: [PATCH] ASoC: mxs: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-snd-soc-mxs-pcm-v1-1-1e663d11328d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABSeXGYC/x3MQQrCMBCF4auUWTsQQ7XiVcRFkk7sgEnLjJZA6
 d07uniLb/H+DZSESeHebSC0svJcDedTB2kK9UXIoxm88727Oo9lRK22OWFpiksq6C751scchzg
 ksOMilLn9o4+nOQYljBJqmn6pN9dvwxL0QwL7fgCoUd27gwAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix
 Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC: <linux-sound@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1CQGR3JMWU5Hg_KFP2QzDsUmMI-nHzBF
X-Proofpoint-ORIG-GUID: 1CQGR3JMWU5Hg_KFP2QzDsUmMI-nHzBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406020142

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/mxs/snd-soc-mxs-pcm.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 sound/soc/mxs/mxs-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index df2e4be992d2..9bb08cadeb18 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -43,4 +43,5 @@ int mxs_pcm_platform_register(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_register);
 
+MODULE_DESCRIPTION("MXS ASoC PCM driver");
 MODULE_LICENSE("GPL");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240602-md-snd-soc-mxs-pcm-05f84bfb7b7c


