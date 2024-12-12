Return-Path: <linux-kernel+bounces-443472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7639EF2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA8C17BE99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2223D405;
	Thu, 12 Dec 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lNTicmOb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81823A19B;
	Thu, 12 Dec 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020734; cv=none; b=tKWZ+3bRhmZEtJg48y5Wk4k+gNfKR1bfT950uM16U5JsjeS2MSLiKqPY0+W38MkmLyfhrqs6KFQu6vjTudGs+eRLEU7ITt3rcENQXzxEruNMJtJ5DHWb99HGRYZsyNUwfwL6OExYss5qWNFLW7MP1J7aMDv65TFxLAOdhqRJN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020734; c=relaxed/simple;
	bh=JvPeDwcDpuyRS6zav1xQv9Awpv7pifnXVwSM059EKk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pB8TY+isigNqOTeVEm+1+Bc3su/zoY2XHC45OJzra3cIHlHhq+W7y24fiSqCeJssieob70zdhZFr4E+BEOqKHPgMs9CrP5h8mIR5gRB0vDzune7sWttfTx7qUinWBEivo8k2Yamqd0t+HwcvkTpVYi+RdAKomYeKCQuZAGMJ/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lNTicmOb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDHCiq000492;
	Thu, 12 Dec 2024 16:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/memcVoHSwFdQVq4BRWnoW5JOKhzsDrU+lvtpZ774PQ=; b=lNTicmObCuonHJMm
	kQLuNau9kzY4pC6x1DsxDwpsKEMbcW3UUUKCcuZUGLxxnZDwhkh/eZVHIsj01E0F
	T/LjxVplpx5V+wXdXXz3drRBx8ZzFrWVEb4e6N1o23eOIAk1zp/KMcK60avLoCU4
	nE5pklRVC3EPNpvQBDA/GllCeK4ZizcD3GE+nG9b8+LB25TgVtPpSVQSKBprILe+
	P7GdjQBl4Swmmzk7XKdZo3uH7KVhKNC+Wia2Zcm7x+0d4hSqdDtp5tYoUPR3i0N1
	k0V70WrW4nySQnekoBzF4Fe41qHzeSJ8FFmJM+IN8leOFSTFfycAhaD7mnnOcm0E
	/xuizw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes22kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:25:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCGPIDl005072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 16:25:18 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 08:25:10 -0800
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
        <quic_pkumpatl@quicinc.com>, <kernel@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v5 2/4] ASoC: codecs: wcd937x: Add static channel mapping support in wcd937x-sdw
Date: Thu, 12 Dec 2024 21:53:32 +0530
Message-ID: <20241212162334.36739-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212162334.36739-1-quic_mohs@quicinc.com>
References: <20241212162334.36739-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dE4J9rSjBwGcTTyDgCaI0-moA9pM9LwT
X-Proofpoint-ORIG-GUID: dE4J9rSjBwGcTTyDgCaI0-moA9pM9LwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120118

Add static channel mapping between master and slave ports in wcd937x-sdw
driver.

Currently, the channel mask for each soundwire port is hardcoded in the
wcd937x-sdw driver, and the same channel mask value is configured in the
soundwire master.

The Qualcomm boards like the QCM6490-IDP require different channel mask
settings for the soundwire master and slave ports.

Implemented logic to read TX/RX channel mappings from device tree
properties (qcom,tx-channel-mapping and qcom,rx-channel-mapping).

Modified the wcd937x_connect_port to handle master channel masks during
port enable/disable operations.

Added wcd937x_get_channel_map api to retrieve the current master
channel map for TX and RX paths.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x-sdw.c | 39 ++++++++++++++++++++++---
 sound/soc/codecs/wcd937x.c     | 53 ++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wcd937x.h     |  7 ++++-
 3 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index 0c33f7f3dc25..1fbff313b965 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -19,7 +19,7 @@
 #include <sound/soc.h>
 #include "wcd937x.h"
 
-static const struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
+static struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_HPH_L, WCD937X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_HPH_R, WCD937X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD937X_CLSH, WCD937X_CLSH_PORT, BIT(0)),
@@ -30,7 +30,7 @@ static const struct wcd937x_sdw_ch_info wcd937x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_DSD_R, WCD937X_DSD_PORT, BIT(1)),
 };
 
-static const struct wcd937x_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
+static struct wcd937x_sdw_ch_info wcd937x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD937X_ADC1, WCD937X_ADC_1_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_ADC2, WCD937X_ADC_2_3_PORT, BIT(0)),
 	WCD_SDW_CH(WCD937X_ADC3, WCD937X_ADC_2_3_PORT, BIT(0)),
@@ -1019,7 +1019,9 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct wcd937x_sdw_priv *wcd;
-	int ret;
+	u8 master_ch_mask[WCD937X_MAX_SWR_CH_IDS];
+	int master_ch_mask_size = 0;
+	int ret, i;
 
 	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
 	if (!wcd)
@@ -1048,10 +1050,36 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 				   SDW_SCP_INT1_PARITY;
 	pdev->prop.lane_control_support = true;
 	pdev->prop.simple_clk_stop_capable = true;
+
+	memset(master_ch_mask, 0, WCD937X_MAX_SWR_CH_IDS);
+
 	if (wcd->is_tx) {
-		pdev->prop.source_ports = GENMASK(WCD937X_MAX_TX_SWR_PORTS - 1, 0);
+		master_ch_mask_size = of_property_count_u8_elems(dev->of_node,
+								 "qcom,tx-channel-mapping");
+
+		if (master_ch_mask_size)
+			ret = of_property_read_u8_array(dev->of_node, "qcom,tx-channel-mapping",
+							master_ch_mask, master_ch_mask_size);
+	} else {
+		master_ch_mask_size = of_property_count_u8_elems(dev->of_node,
+								 "qcom,rx-channel-mapping");
+
+		if (master_ch_mask_size)
+			ret = of_property_read_u8_array(dev->of_node, "qcom,rx-channel-mapping",
+							master_ch_mask, master_ch_mask_size);
+	}
+
+	if (ret < 0)
+		dev_info(dev, "Static channel mapping not specified using device channel maps\n");
+
+	if (wcd->is_tx) {
+		pdev->prop.source_ports = GENMASK(WCD937X_MAX_TX_SWR_PORTS, 0);
 		pdev->prop.src_dpn_prop = wcd937x_dpn_prop;
 		wcd->ch_info = &wcd937x_sdw_tx_ch_info[0];
+
+		for (i = 0; i < master_ch_mask_size; i++)
+			wcd->ch_info[i].master_ch_mask = WCD937X_SWRM_CH_MASK(master_ch_mask[i]);
+
 		pdev->prop.wake_capable = true;
 
 		wcd->regmap = devm_regmap_init_sdw(pdev, &wcd937x_regmap_config);
@@ -1065,6 +1093,9 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 		pdev->prop.sink_ports = GENMASK(WCD937X_MAX_SWR_PORTS - 1, 0);
 		pdev->prop.sink_dpn_prop = wcd937x_dpn_prop;
 		wcd->ch_info = &wcd937x_sdw_rx_ch_info[0];
+
+		for (i = 0; i < master_ch_mask_size; i++)
+			wcd->ch_info[i].master_ch_mask = WCD937X_SWRM_CH_MASK(master_ch_mask[i]);
 	}
 
 
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index c9d5e67bf66e..e8d3fddbc7b1 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -1197,13 +1197,21 @@ static int wcd937x_connect_port(struct wcd937x_sdw_priv *wcd, u8 port_idx, u8 ch
 	const struct wcd937x_sdw_ch_info *ch_info = &wcd->ch_info[ch_id];
 	u8 port_num = ch_info->port_num;
 	u8 ch_mask = ch_info->ch_mask;
+	u8 mstr_port_num, mstr_ch_mask;
+	struct sdw_slave *sdev = wcd->sdev;
 
 	port_config->num = port_num;
 
-	if (enable)
+	mstr_port_num = sdev->m_port_map[port_num];
+	mstr_ch_mask = ch_info->master_ch_mask;
+
+	if (enable) {
 		port_config->ch_mask |= ch_mask;
-	else
+		wcd->master_channel_map[mstr_port_num] |= mstr_ch_mask;
+	} else {
 		port_config->ch_mask &= ~ch_mask;
+		wcd->master_channel_map[mstr_port_num] &= ~mstr_ch_mask;
+	}
 
 	return 0;
 }
@@ -2689,10 +2697,51 @@ static int wcd937x_codec_set_sdw_stream(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int wcd937x_get_channel_map(const struct snd_soc_dai *dai,
+				   unsigned int *tx_num, unsigned int *tx_slot,
+				   unsigned int *rx_num, unsigned int *rx_slot)
+{
+	struct wcd937x_priv *wcd937x = dev_get_drvdata(dai->dev);
+	struct wcd937x_sdw_priv *wcd = wcd937x->sdw_priv[dai->id];
+	int i;
+
+	switch (dai->id) {
+	case AIF1_PB:
+		if (!rx_slot || !rx_num) {
+			dev_err(dai->dev, "Invalid rx_slot %p or rx_num %p\n",
+				rx_slot, rx_num);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < SDW_MAX_PORTS; i++)
+			rx_slot[i] = wcd->master_channel_map[i];
+
+		*rx_num = i;
+		break;
+	case AIF1_CAP:
+		if (!tx_slot || !tx_num) {
+			dev_err(dai->dev, "Invalid tx_slot %p or tx_num %p\n",
+				tx_slot, tx_num);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < SDW_MAX_PORTS; i++)
+			tx_slot[i] = wcd->master_channel_map[i];
+
+		*tx_num = i;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops wcd937x_sdw_dai_ops = {
 	.hw_params = wcd937x_codec_hw_params,
 	.hw_free = wcd937x_codec_free,
 	.set_stream = wcd937x_codec_set_sdw_stream,
+	.get_channel_map = wcd937x_get_channel_map,
 };
 
 static struct snd_soc_dai_driver wcd937x_dais[] = {
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 4afa48dcaf74..4ef57c496c37 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -489,6 +489,7 @@
 #define WCD937X_MAX_MICBIAS			3
 #define WCD937X_MAX_BULK_SUPPLY			4
 #define WCD937X_MAX_SWR_CH_IDS			15
+#define WCD937X_SWRM_CH_MASK(ch_idx)		BIT(ch_idx - 1)
 
 enum wcd937x_tx_sdw_ports {
 	WCD937X_ADC_1_PORT = 1,
@@ -510,12 +511,14 @@ enum wcd937x_rx_sdw_ports {
 struct wcd937x_sdw_ch_info {
 	int port_num;
 	unsigned int ch_mask;
+	unsigned int master_ch_mask;
 };
 
 #define WCD_SDW_CH(id, pn, cmask)	\
 	[id] = {			\
 		.port_num = pn,		\
 		.ch_mask = cmask,	\
+		.master_ch_mask = cmask,	\
 	}
 
 struct wcd937x_priv;
@@ -524,9 +527,11 @@ struct wcd937x_sdw_priv {
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD937X_MAX_SWR_PORTS];
-	const struct wcd937x_sdw_ch_info *ch_info;
+	struct wcd937x_sdw_ch_info *ch_info;
 	bool port_enable[WCD937X_MAX_SWR_CH_IDS];
+	unsigned int master_channel_map[SDW_MAX_PORTS];
 	int active_ports;
+	int num_ports;
 	bool is_tx;
 	struct wcd937x_priv *wcd937x;
 	struct irq_domain *slave_irq;
-- 
2.34.1


