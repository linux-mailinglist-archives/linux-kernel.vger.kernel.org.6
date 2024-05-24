Return-Path: <linux-kernel+bounces-188286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43518CE00E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6E91C209A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB693BBEB;
	Fri, 24 May 2024 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VwGLFtO1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718E3B2A2;
	Fri, 24 May 2024 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523031; cv=none; b=b1j+sBHgt6dBu/bzCPGAKDNYm2iPUPV8Apay5nx1wodCfm6AY6ioh3snUT4GyS9ueEmb2sAMasC05mlAOgAOqBifFaywybsrohkISiSRd4ZwuPf6/LfDsSE1rR7EnhZwqZ7C8v+jVaEfM6QQ8xjSAXMslAIR69jmCx0XpVz2360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523031; c=relaxed/simple;
	bh=HpzsEM1j54Mm6stWqCCqRta1D4uz8qQDHXF9mF77gNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acj0JwlwqsxSrtTJ+NLXGYRp5CJ9aKvY/DsBF3sXGa7+6MsDKh4JyHYuinSI8xc4QekDKLzCAWOI/5aMvayP+OOwz56EKka/VhJAcF/JWTZBWJqJBkzIpkNJBnqr3r4F/n9WXg3A3Hxo7Iaxb2btTRxMchMYOPftoAJkmn8Deqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VwGLFtO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNPt1u013094;
	Fri, 24 May 2024 03:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kxeak7j2X/vTjMnZOkyJl6dka7ghfJLwINS3QrlIbAY=; b=VwGLFtO1V5niC5Y0
	gUxWuM4VPRGQVQrKvi0fiAYumRuHYOnF8WJcgZo3eiy0KB9oIWxuWG8P4wLC4CGr
	o2if2TEGk0gIpO//6iO1Bj5NunhmBhh/OhzMVJcJAkjCGNBMl9Gd6x9qe9zJt6v9
	ej8upGn8i76wBuE0mdmQCFf1exVqSO8P5w+K0yZgqwf2UiguKy0Xai+xmyrqfES9
	Jo0B6gzS9fWz0rGwNRrMlmK7BwGxblK9uwZ8M+fcaTjY86fnCZpVzrYkNcj9aaeD
	cVtaZcQjMwBnNXB7qIxq+OG9CreyHUMSvHTeJq5HtFacBpY5pFIjEZAZtZgNzTLI
	csqWAw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa97s4aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 03:56:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O3uv7M007464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 03:56:57 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 May 2024 20:56:52 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v5 4/7] ASoC: codecs: wcd937x: add basic controls
Date: Fri, 24 May 2024 09:25:32 +0530
Message-ID: <20240524035535.3119208-5-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524035535.3119208-1-quic_mohs@quicinc.com>
References: <20240524035535.3119208-1-quic_mohs@quicinc.com>
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
X-Proofpoint-GUID: 9NERlY0s5rxcGRa4ccr3y7gnrZwkF90R
X-Proofpoint-ORIG-GUID: 9NERlY0s5rxcGRa4ccr3y7gnrZwkF90R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=911 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405240026

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

This patch adds basic controls found in WCD9370/WCD9375 codec.

Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x.c | 201 +++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 4470ee0ecae6..293a84a53918 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -120,6 +120,10 @@ struct wcd937x_priv {
 	atomic_t ana_clk_count;
 };
 
+static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(ear_pa_gain, 600, -1800);
+static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
+
 struct wcd937x_mbhc_zdet_param {
 	u16 ldo_ctl;
 	u16 noff;
@@ -476,6 +480,157 @@ static int wcd937x_connect_port(struct wcd937x_sdw_priv *wcd, u8 port_idx, u8 ch
 	return 0;
 }
 
+static int wcd937x_rx_hph_mode_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wcd937x->hph_mode;
+	return 0;
+}
+
+static int wcd937x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+				snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	u32 mode_val;
+
+	mode_val = ucontrol->value.enumerated.item[0];
+
+	if (!mode_val)
+		mode_val = CLS_AB;
+
+	if (mode_val == wcd937x->hph_mode)
+		return 0;
+
+	switch (mode_val) {
+	case CLS_H_NORMAL:
+	case CLS_H_HIFI:
+	case CLS_H_LP:
+	case CLS_AB:
+	case CLS_H_LOHIFI:
+	case CLS_H_ULP:
+	case CLS_AB_LP:
+	case CLS_AB_HIFI:
+		wcd937x->hph_mode = mode_val;
+		return 1;
+	}
+
+	dev_dbg(component->dev, "%s: Invalid HPH Mode\n", __func__);
+	return -EINVAL;
+}
+
+static int wcd937x_get_compander(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	ucontrol->value.integer.value[0] = hphr ? wcd937x->comp2_enable :
+						  wcd937x->comp1_enable;
+	return 0;
+}
+
+static int wcd937x_set_compander(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	struct wcd937x_sdw_priv *wcd = wcd937x->sdw_priv[AIF1_PB];
+	int value = ucontrol->value.integer.value[0];
+	struct soc_mixer_control *mc;
+	int portidx;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	if (hphr) {
+		if (value == wcd937x->comp2_enable)
+			return 0;
+
+		wcd937x->comp2_enable = value;
+	} else {
+		if (value == wcd937x->comp1_enable)
+			return 0;
+
+		wcd937x->comp1_enable = value;
+	}
+
+	portidx = wcd->ch_info[mc->reg].port_num;
+
+	if (value)
+		wcd937x_connect_port(wcd, portidx, mc->reg, true);
+	else
+		wcd937x_connect_port(wcd, portidx, mc->reg, false);
+
+	return 1;
+}
+
+static int wcd937x_get_swr_port(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(comp);
+	struct wcd937x_sdw_priv *wcd;
+	int dai_id = mixer->shift;
+	int ch_idx = mixer->reg;
+	int portidx;
+
+	wcd = wcd937x->sdw_priv[dai_id];
+	portidx = wcd->ch_info[ch_idx].port_num;
+
+	ucontrol->value.integer.value[0] = wcd->port_enable[portidx];
+
+	return 0;
+}
+
+static int wcd937x_set_swr_port(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(comp);
+	struct wcd937x_sdw_priv *wcd;
+	int dai_id = mixer->shift;
+	int ch_idx = mixer->reg;
+	int portidx;
+	bool enable;
+
+	wcd = wcd937x->sdw_priv[dai_id];
+
+	portidx = wcd->ch_info[ch_idx].port_num;
+
+	enable = ucontrol->value.integer.value[0];
+
+	if (enable == wcd->port_enable[portidx]) {
+		wcd937x_connect_port(wcd, portidx, ch_idx, enable);
+		return 0;
+	}
+
+	wcd->port_enable[portidx] = enable;
+	wcd937x_connect_port(wcd, portidx, ch_idx, enable);
+
+	return 1;
+}
+
+static const char * const rx_hph_mode_mux_text[] = {
+	"CLS_H_NORMAL", "CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB",
+	"CLS_H_LOHIFI", "CLS_H_ULP", "CLS_AB_LP", "CLS_AB_HIFI",
+};
+
+static const struct soc_enum rx_hph_mode_mux_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text), rx_hph_mode_mux_text);
+
 /* MBHC related */
 static void wcd937x_mbhc_clk_setup(struct snd_soc_component *component,
 				   bool enable)
@@ -1150,6 +1305,50 @@ static void wcd937x_mbhc_deinit(struct snd_soc_component *component)
 
 /* END MBHC */
 
+static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
+	SOC_SINGLE_TLV("EAR_PA Volume", WCD937X_ANA_EAR_COMPANDER_CTL,
+		       2, 0x10, 0, ear_pa_gain),
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
+		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
+
+	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
+		       wcd937x_get_compander, wcd937x_set_compander),
+	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
+		       wcd937x_get_compander, wcd937x_set_compander),
+
+	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD937X_HPH_R_EN, 0, 20, 1, line_gain),
+	SOC_SINGLE_TLV("ADC1 Volume", WCD937X_ANA_TX_CH1, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", WCD937X_ANA_TX_CH2, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", WCD937X_ANA_TX_CH3, 0, 20, 0, analog_gain),
+
+	SOC_SINGLE_EXT("HPHL Switch", WCD937X_HPH_L, 0, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("HPHR Switch", WCD937X_HPH_R, 0, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+
+	SOC_SINGLE_EXT("ADC1 Switch", WCD937X_ADC1, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("ADC2 Switch", WCD937X_ADC2, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("ADC3 Switch", WCD937X_ADC3, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC0 Switch", WCD937X_DMIC0, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC1 Switch", WCD937X_DMIC1, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("MBHC Switch", WCD937X_MBHC, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC2 Switch", WCD937X_DMIC2, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC3 Switch", WCD937X_DMIC3, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC4 Switch", WCD937X_DMIC4, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC5 Switch", WCD937X_DMIC5, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+};
+
 static int wcd937x_set_micbias_data(struct wcd937x_priv *wcd937x)
 {
 	int vout_ctl[3];
@@ -1316,6 +1515,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd937x = {
 	.name = "wcd937x_codec",
 	.probe = wcd937x_soc_codec_probe,
 	.remove = wcd937x_soc_codec_remove,
+	.controls = wcd937x_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd937x_snd_controls),
 	.set_jack = wcd937x_codec_set_jack,
 	.endianness = 1,
 };
-- 
2.25.1


