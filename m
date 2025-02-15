Return-Path: <linux-kernel+bounces-515835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E03A36984
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FFC3B38D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99866156F39;
	Sat, 15 Feb 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNQfKvSx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676127452;
	Sat, 15 Feb 2025 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577977; cv=none; b=miEFkByk7ooqsKA6Ojkykk2jLjdbAL6xwkWFFTs2TCqLZC23CEqrkSGbS+y472Z7MOzQcXkQ6u4efFqPOrLFgZLCgbuYYHBKRGdbS1FRfgFMKe3+B97Wlch3MJhUhMQ0JWmwaOYtCjnLkAVTqhJWY6aH98QdDeV/78riaVPzJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577977; c=relaxed/simple;
	bh=eo0FgT54k97mDSR8rz6Pu8NwpXky/0riRsqEIavkVRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdRBSmIWf9sah2KhIuHsSqcWw3KOK1hTPRvR10SucalE/P7aYnPi8s6pwtLgOSiSEBKgr9AOpUixRlwRlgAlrbe63dBr2hQEKk//8lr96SJxa+ItIzpdLe5oxlpWV8NsxzlM/araI08QqHVidtuQSwacK+5NHge61HZK4I88JFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNQfKvSx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e83d65e5so35560865ad.1;
        Fri, 14 Feb 2025 16:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577972; x=1740182772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRen9lz0iA3eKqSin+5VNNTShffgRxZVjvG8oHS7fzY=;
        b=XNQfKvSxBq+Ljuk2paYd8JXJIQs6j1gnnEjbF/JHnfH4Ol5wQLrk9UxJ5el+dw5JBS
         UnmMdzCjUR1BsFrkuxNFOyHjsfHeNApnqtWQ4uYUp3W+XhDiw4Q1B4+lvSQyNCjbRYRU
         wTULyIrKdOjrecAJGw+o+p96uFFpIp47B03ya5LoDKSQr3gDlYYAvaqSqdRFQeQtwfM8
         cCwqj04vfI5EYr/JCXbnV+IXbLVi5pnSqCTffcKEaWvKG1p/T6RltwmxEaFet6SQRZ8T
         Lq0x8jvkxyYO3+y+5PehYKR0+C1aUqTbNz4Mehspp+NJ5m5gYh8+uo74Dww30Qcdcuo7
         fbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577973; x=1740182773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRen9lz0iA3eKqSin+5VNNTShffgRxZVjvG8oHS7fzY=;
        b=vMLe4jtROUQLd9lAU1LawS7ZcgoxhZ21ETAMuLehQreJx4pAEsyDZl+IkykJq4Kqs7
         bYPzNjLfumGrYZ6vCJdrYRlhC3J5APD3MP70MGzLegBmo4y6iDlvQsJSZgjNg1L01SQq
         qCr7g8A/hXG5IqGQ80fpqrJ6ASUiRQmEEhSrF/hUa+3iKvw7MExL0Yc7ZjUNJPuq9wMl
         m8fxDwbSWjz3k2L4SwZdI1c4N/riwWpgR/m37a3fSkujtAmMC7GTFmaGY2gdohCzKIsm
         E5AUz1IUGXY3/AzYaOv38EKDqGFq7XDHjRPjhJDEz5FGaciCjE+R6dooPHnD4BfhiogN
         kCIg==
X-Forwarded-Encrypted: i=1; AJvYcCVjQiRiODxYow1mXCqmbGHPyAKPA16vrE51CkJJlH5n5KZFWgeRvRmhTmoPGSMOUYE3VNwU1Ej/8Q8I@vger.kernel.org, AJvYcCXayE61czZyLIqCCXKYEtQdAUDflg3fRz+/2UCxzkWd2/k5IWCbhm27UDj3vWNtro6VexHbZlmsUL0Ya0g=@vger.kernel.org, AJvYcCXrC9WKnrKdpPLlWEMUy1s5tRm2RUabHI/W45YCWNC/x1WTVdjmx6z4GsvWVOPOAdpbgrI/CPunHAB6uTKB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1aINs2g5gG0BFe0giCANHXFQR5ZRL3r8YxqrZbn27rje4GfS
	cSPChZTNCyn/Nu3hHLsnjHmJW9l+ihtRl/EAVYNwt/yecqn4+2Ez
X-Gm-Gg: ASbGncuhsCFkqGW38RVx93oS8V0Ll1l1fVnSLi0gEzYZYiSDUzzpsHk4VDDGlNVpQ4Q
	BkIJJZDwxvat3U/oEpbMTIm6yoSSEqnkUvko1AXW+f/to8v7nLNfxp5gz7rVzcCF3Vw4hSB1VmM
	NYyfO2Vf7Lu2spWVeAN1GmHrIEPioW2G20BD7IeYMy6UmY3fe3ZpsLPEOpRopK+BOrCBOcguRpl
	GTnbqG6q4N4HXREuXVeE0UKzhUsdmjQFxA9TLHwE0vzKNibokxm/i/oLD7VJMMCmzZ6Ht88SmSi
	zOzB20SN2KDUQMGMgM6RRGCbBNwpO4pRVLC2V4q5OcfF+F3CtmQQ2N80ksMjQ8B3MfPpDCzfcU/
	HRoI8PNrxDQ==
X-Google-Smtp-Source: AGHT+IFHQB6Hi75lq+IHVc2EFRmqZFJg6IszUCPchCSlNMP6cT4k1DouRGvCzCmAtaa7EuyBYHLM8g==
X-Received: by 2002:a17:90a:df11:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-2fc40f105e6mr1703877a91.13.1739577972631;
        Fri, 14 Feb 2025 16:06:12 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:06:12 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:59 +1000
Subject: [PATCH 26/27] ASoC: tas2764: Set the SDOUT polarity correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-26-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=JUEJyKGKi/edxIy+wXLBYHgRqMQ6HGn+xp2GKuXciig=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb+7g7a02Zrw3+W/E9bv1iwQVhabuv82/LEf/8nLuJ
 H+zCG6ujlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACYy+Tcjw6opz99Hf7+24N17
 22kGAfXf1X34v9VOjZhgfVbqGMPGqU4M/4MUPrvNlFz/t3VWzivNpS63vnzXaS5zzzgZXCi1y2B
 mMTcA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

TX launch polarity needs to be the opposite of RX capture polarity, to
generate the right bit slot alignment.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 10 +++++++++-
 sound/soc/codecs/tas2764.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index bdbc210ea8306ecebf704fe33fbe41083867e1ca..0cae0e8819d890f0818b531a40094f22e4e18fcb 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -426,7 +426,7 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -435,12 +435,14 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_RISING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
 		fallthrough;
 	case SND_SOC_DAIFMT_IB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_FALLING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_RISING;
 		break;
 	}
 
@@ -450,6 +452,12 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2764_TDM_CFG4,
+					    TAS2764_TDM_CFG4_TX_MASK,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 786d81eb5b1e71bad094ef94e4b56e8f7c910285..4a419c11d4b08eebb915762db00af5c06ff3dd42 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -84,6 +84,12 @@
 #define TAS2764_TDM_CFG3_RXS_SHIFT	0x4
 #define TAS2764_TDM_CFG3_MASK		GENMASK(3, 0)
 
+/* TDM Configuration Reg4 */
+#define TAS2764_TDM_CFG4		TAS2764_REG(0X0, 0x0d)
+#define TAS2764_TDM_CFG4_TX_MASK	BIT(0)
+#define TAS2764_TDM_CFG4_TX_RISING	0x0
+#define TAS2764_TDM_CFG4_TX_FALLING	BIT(0)
+
 /* TDM Configuration Reg5 */
 #define TAS2764_TDM_CFG5		TAS2764_REG(0X0, 0x0e)
 #define TAS2764_TDM_CFG5_VSNS_MASK	BIT(6)

-- 
2.48.1


