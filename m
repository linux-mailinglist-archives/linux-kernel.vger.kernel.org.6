Return-Path: <linux-kernel+bounces-377419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEF9ABE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28DF1C22716
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E5A14A624;
	Wed, 23 Oct 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kqeFUjA4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE0EAC5;
	Wed, 23 Oct 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664165; cv=none; b=qz43kIjPnvL2zOLFGQhk2H6sHvfdhMcUVfNe6sYECNjfix1oc5eGwp0aqulHxcvuNW4JqyvSI5hN148zV5x1ZXrqIVnYaPx68sY1ZLNG3EchecIv5ROH7suCpAkYaOJhs4ce0CeLDDO2CgsqokbMzX3gE7mvveIFISstQpm5nHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664165; c=relaxed/simple;
	bh=va1R7XK24yU3ckqYaNWBRFt1s4VJR2AHFqneqM5mWWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeuTjztuTFUA2ISNuZQHFynAcdEt9fFmV28EbffqjwJuaEotSyletjUWL00ShaV+mOstKmmn4Wo5U60IBnqvE5Z/vLH5O4wy7oMxCwiXPZYLMhJIR0c64BLj5DyJEVhCPc1q3qJeIyQkjdBLF+VeXxeflIhSNoiU24yluC1/pDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kqeFUjA4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLZpQn029348;
	Wed, 23 Oct 2024 06:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oOD2K6jMH158wDF6AvplmvOw5+DIKxLf1BusBw0WBDA=; b=kqeFUjA4oL6sASvN
	olz/x5xKla/ta+87XrXlLvTFl8lRYzOrsVlQ4vljNuvYqXxG/MSSYlGR3QueouGD
	m1O5fBYQUc84bt4JEwLgOO9vrtkX6gU4D7dhyiL7/FLOCWwYYGIxwImdpvxcLedu
	egEbo3nPFR0Jqlo+yaVmmjGUbd6Y+7kBMAJVp4dNa5Lj2OvIFOFrtBx2zpe1Xzub
	yaWpZKcRUkwmCSa52NWg26hHHVYIe9JHXSEs5foB1mkmTSU/403IA1fNavelRqdc
	t+d0LI3ZevtQzG9yafnCgxI8mRG+KBzNwM+NjfGFeXYQDXYRcVPBV12bGQoGAuqt
	9OdgSQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w132a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:15:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N6Fo1i016774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:15:50 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:15:43 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao
	<yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>
CC: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Sanyog Kale
	<sanyog.r.kale@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 3/4] soundwire: qcom: Add set_channel_map api support
Date: Wed, 23 Oct 2024 11:43:25 +0530
Message-ID: <20241023061326.3871877-4-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023061326.3871877-1-quic_mohs@quicinc.com>
References: <20241023061326.3871877-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zNppRzICx12q74ud9sUl8f3wpKopSXXu
X-Proofpoint-GUID: zNppRzICx12q74ud9sUl8f3wpKopSXXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230035

Added qcom_swrm_set_channel_map api to set the master channel mask for
TX and RX paths based on the provided slots.

Added a new field ch_mask to the qcom_swrm_port_config structure.
This field is used to store the master channel mask, which allows more
flexible to configure channel mask in runtime for specific active soundwire ports.

Modified the qcom_swrm_port_enable function to configure master channel mask.
If the ch_mask is set to SWR_INVALID_PARAM or is zero, the function will
use the default channel mask.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/soundwire/qcom.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2b403b14066c..007183c6c047 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -156,6 +156,7 @@ struct qcom_swrm_port_config {
 	u8 word_length;
 	u8 blk_group_count;
 	u8 lane_control;
+	u8 ch_mask;
 };
 
 /*
@@ -1048,9 +1049,13 @@ static int qcom_swrm_port_enable(struct sdw_bus *bus,
 {
 	u32 reg = SWRM_DP_PORT_CTRL_BANK(enable_ch->port_num, bank);
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+	struct qcom_swrm_port_config *pcfg;
 	u32 val;
 
+	pcfg = &ctrl->pconfig[enable_ch->port_num];
 	ctrl->reg_read(ctrl, reg, &val);
+	if (pcfg->ch_mask != SWR_INVALID_PARAM && pcfg->ch_mask != 0)
+		enable_ch->ch_mask = pcfg->ch_mask;
 
 	if (enable_ch->enable)
 		val |= (enable_ch->ch_mask << SWRM_DP_PORT_CTRL_EN_CHAN_SHFT);
@@ -1270,6 +1275,27 @@ static void *qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)
 	return ctrl->sruntime[dai->id];
 }
 
+static int qcom_swrm_set_channel_map(struct snd_soc_dai *dai,
+				     unsigned int tx_num, unsigned int *tx_slot,
+				     unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
+	struct sdw_stream_runtime *sruntime = ctrl->sruntime[dai->id];
+	int i;
+
+	if (tx_slot) {
+		for (i = 0; i < tx_num; i++)
+			ctrl->pconfig[i].ch_mask = tx_slot[i];
+	}
+
+	if (rx_slot) {
+		for (i = 0; i < rx_num; i++)
+			ctrl->pconfig[i].ch_mask = rx_slot[i];
+	}
+
+	return 0;
+}
+
 static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
@@ -1306,6 +1332,7 @@ static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
 	.shutdown = qcom_swrm_shutdown,
 	.set_stream = qcom_swrm_set_sdw_stream,
 	.get_stream = qcom_swrm_get_sdw_stream,
+	.set_channel_map = qcom_swrm_set_channel_map,
 };
 
 static const struct snd_soc_component_driver qcom_swrm_dai_component = {
-- 
2.25.1


