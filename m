Return-Path: <linux-kernel+bounces-515817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC979A36964
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A93D16919D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399B158851;
	Sat, 15 Feb 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3BGyzSd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D21096F;
	Sat, 15 Feb 2025 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577850; cv=none; b=rZQC6coBl01NDXJTU9WQEFvODQst7m5MGYJFUQj9XHw408JZCeBQK4EGCgPFksRYOt4xEWOJ0LlTbqf5+7xXq7FCE8cTFbAUbW9rWd640Z6XojSAxmxB7MqVhPTuNfhd1a4+lgMNKc23uq5J3tZyJ39t2pAkWTltmf+ugcpsx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577850; c=relaxed/simple;
	bh=x3X/J7jRRdV3oXpM/nwKMeoCk1MEJMElH9Do++utVEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d2YKM8rrjXe4jb+Yc7Zea/gzLx/jsva3JdV2RCG0WSD/nvqLhSQN6ET7cXQ7lIJnm5eZngVAMmHpk+yiQmHww3HodYwaDH1hU7E66gV9R9YBB+nHNZMGk7qC74hZ+FmLH9qoAfaq/kNGSY1OfGz9cmZpYaAJ0WQWToDHbpwiNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3BGyzSd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220bff984a0so46094405ad.3;
        Fri, 14 Feb 2025 16:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577848; x=1740182648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlnAUEumL1snBEGJ4Y34sXZ9QMbvLdlHubepbtqR47I=;
        b=Y3BGyzSdnz1P1ZqKztQopVZTqPN/ACu6qmRYdn93OK807LvlEAxpWdgIZa67dd6uaO
         gKOGWPq7A7ke3TPyrnK6P9BREMK1O9gCFvmv+oqZqW0t//MH59W2aiX2xBCw7U2/mpQH
         rHMp9ZRYJ6vFi7EzOL/ogI4VrqjKrTzAZk+mBpFpzKoMbT4A0pOs8dKGz53EChFoW2xM
         gRSgaBwxZnjXYpHBoKOFFiBV0wh1W5gmyxaFyVcggJ3Efeg+t8iQiqFkk/wPIqaiBE3n
         WvUusUFWBZi/QIEZbyR9arLJc59gsPo6tR8kJW+cJYyX25fSS+czv/XPpEQZB0knLadA
         SsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577848; x=1740182648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlnAUEumL1snBEGJ4Y34sXZ9QMbvLdlHubepbtqR47I=;
        b=Extla1rroP67E+qXd5mIk/F6I6StCk7IR9fXRu7N3iqolxCtJbvcksM2Gnk5gWTjIO
         3buSE2OspYDGhLLtsoXcieZk8jMCVxU6x8GsYcWQllPgiWaps367CHNIWNcqU/xSB1jW
         8LQb2mIXHGom0CKOeOYf57i5dxz1lFjaJ5bFwipCP2z8Fa6yOZQ0pjYUzynO82lH2LtM
         3RgwVrAi2Cd6RwKDHgPLwqHSe6vpmyFwIxcRiPxCpgQq3Kr/QxgE133dYdnLCRNVCzN3
         1anOCerLAwtvKjm3UPxoGaChNrAzFhb652P7SFBeF5FjQyLGAhrp2/XENdBEfXDsF2Kl
         ixwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBTQJoWsMeI94MPZVxh7aopXjHzM/O4DQb1aVIge1ZZF2t8gTm1ucpd+EDfwAbfX5qwbnPRAzMg/GdFnU=@vger.kernel.org, AJvYcCUvnJJ1trCHXmvByWtHP73jyDPFB6X4JgNmLiKIjvJ6a+mEl39ZpxtCZ7sE0mA4Nyiqx37yrt4xeEex@vger.kernel.org, AJvYcCWyIGtMvkchpZ2HipKhQebv93Y1bzNZckEut6KmHkhDP3m2J9Kjo9izAdLvqVI2PWon0XuxZOpcSa4I6ljq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3otUsP4pNftlux9vDlKRH/9BS/Bh44Np7lT25SD6qOoGvLcct
	+K9aOp2SRUBmZFkYPYwrmXMSUb27aPk/o5N6h6fICIWeIlc9Ux5L
X-Gm-Gg: ASbGnct8tl8GeEClIN3ttadywxRxhGJuVjCOUSTSUICrLUGyQpFgwr4FYSeHovXpXjG
	iK0E/GtZrpXhN5FRdY2frdA5UmOxkrAzddjFb3Otsi7iDU5cUYZ9BCtEXcFBBL9Ak03pi00YPrj
	Orvoh/FtRB+K5izkE1BvJVJa6oSdbJHSzPOfD8TQSc6WAgyQippJB9w9YM6NKsh0xJzj5KUOswB
	XEGsTmt9WQFgCEf9lK1sRC1D5Su/DsDj+5RUrgGcZq38qHzJXtVhdeHVm8jyV3UYYPAlYdjoFp5
	M8rWT8s2EumBg0cNkYWRkfBojEKQQ8L2/5XpZ7EY13g2t+80MJ4a3Cg0PeQsXcx11ai5lBCZMxh
	s+0mwVxC5dw==
X-Google-Smtp-Source: AGHT+IGMbVf+oIvKO42Y/8NEStakQJ1l6kBwVqtO/ZePkg1SGRKsak1GKPDunnaaDh6kBSNw0x7W/Q==
X-Received: by 2002:a17:903:41c3:b0:21f:baa:80c1 with SMTP id d9443c01a7336-221040d74e3mr19468095ad.53.1739577848518;
        Fri, 14 Feb 2025 16:04:08 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:07 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:41 +1000
Subject: [PATCH 08/27] ASoC: tas2764: Configure zeroing of SDOUT slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-8-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=ZrV0a5IsC1OB9lfc0Tl9W5OcpAjXMhwf4kd0SmKIBwI=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24tqq/efntJ1w/hZmUFr+w76sufdd6XT9SwLVRIM
 V94csffjlIWBjEuBlkxRZYNTUIes43YbvaLVO6FmcPKBDKEgYtTACYyq5rhf4SFZrHOKUn/CQd8
 YrPlhL8c/Pyxc2KJerWNcLlP1P+/eYwMd0uNT0Qv4VrqubLuNvdW2y2fN0y+N884vrQ0aF+Oos8
 fRgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

The codec has an option to zero out certain TDM slots on its SDOUT
output according to a preconfigured mask (otherwise the output is, for
the duration of unused slots, in a Hi-Z state). Configure this feature
based on a mask read from the devicetree.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/tas2764.h | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 6e91ad9229cad62860adc1f446fffc8872d32ca0..811f4f54cc26bee05d717552c360fa50e7d6c7fe 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -40,6 +40,7 @@ struct tas2764_priv {
 
 	int v_sense_slot;
 	int i_sense_slot;
+	u32 sdout_zero_mask;
 
 	bool dac_powered;
 	bool unmuted;
@@ -594,6 +595,23 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	if (tas2764->sdout_zero_mask) {
+		for (i = 0; i < 4; i++) {
+			ret = snd_soc_component_write(component, TAS2764_SDOUT_HIZ_1 + i,
+						      (tas2764->sdout_zero_mask >> (i * 8)) & 0xff);
+
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = snd_soc_component_update_bits(component, TAS2764_SDOUT_HIZ_9,
+						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN,
+						    TAS2764_SDOUT_HIZ_9_FORCE_0_EN);
+
+		if (ret < 0)
+			return ret;
+	}
+
 	if (tas2764->devid == DEVID_SN012776) {
 		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
 					TAS2764_PWR_CTRL_BOP_SRC,
@@ -736,6 +754,11 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
 	if (ret)
 		tas2764->v_sense_slot = 2;
 
+	ret = fwnode_property_read_u32(dev->fwnode, "ti,sdout-force-zero-mask",
+				       &tas2764->sdout_zero_mask);
+	if (ret)
+		tas2764->sdout_zero_mask = 0;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 20628e51bf94f047e3dc7cac73ac01519ada1852..10ef7d4a490e1dec3ba9c824479a6d35ac57f33e 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -117,4 +117,15 @@
 
 #define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
 
+#define TAS2764_SDOUT_HIZ_1		TAS2764_REG(0x1, 0x3d)
+#define TAS2764_SDOUT_HIZ_2		TAS2764_REG(0x1, 0x3e)
+#define TAS2764_SDOUT_HIZ_3		TAS2764_REG(0x1, 0x3f)
+#define TAS2764_SDOUT_HIZ_4		TAS2764_REG(0x1, 0x40)
+#define TAS2764_SDOUT_HIZ_5		TAS2764_REG(0x1, 0x41)
+#define TAS2764_SDOUT_HIZ_6		TAS2764_REG(0x1, 0x42)
+#define TAS2764_SDOUT_HIZ_7		TAS2764_REG(0x1, 0x43)
+#define TAS2764_SDOUT_HIZ_8		TAS2764_REG(0x1, 0x44)
+#define TAS2764_SDOUT_HIZ_9		TAS2764_REG(0x1, 0x45)
+#define TAS2764_SDOUT_HIZ_9_FORCE_0_EN	BIT(7)
+
 #endif /* __TAS2764__ */

-- 
2.48.1


