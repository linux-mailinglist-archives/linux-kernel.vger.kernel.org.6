Return-Path: <linux-kernel+bounces-515813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF817A36955
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB85188D8CC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7199D142624;
	Sat, 15 Feb 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRjCKbjZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CB70818;
	Sat, 15 Feb 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577824; cv=none; b=V2nelX1GuJd5GNa/48Mf0iZYJdp5aJU1+EyNyKTrNtJ2SGu34GBZFGLp5+txZWdfw350hNdKA+i8ejoIrRQ68XpJAK+ku1Ya3M9clYfvFJZfLryyVNjiwkHyx3wDS57YK3iWvWyOBgi4aR8sdxQaptCAcBMd0P8lhGPLi+0DTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577824; c=relaxed/simple;
	bh=l4QavxH/AnxLsGFPgX4G1Nwz/B0QgpuehWgSTj26p0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQuRxM9OCJvheOorPwtE5vC4tvQnuHknUakGQEfJ3ERLhtifasxPHk1bj56ugbxYjN2DGPRIR3qCY36t2SMbxoWs4SmZp4mJJkXwFYCpSTOQvh/s1YPAygQYVlbUovvSP3+I0LU4PF3cHridOJ9XwfUj67zeSgk/T9Ds6rvRkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRjCKbjZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220f4dd756eso20776675ad.3;
        Fri, 14 Feb 2025 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577820; x=1740182620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNJt0vNuEkV51zynYZo+HyYzdHqqBPC2Q3Ik+52LuJI=;
        b=cRjCKbjZib3ZQyXyFRxO2X7LogcZTWrF9yMVtp7gCYoBJ7wszpCkTtoAPc148jOL3D
         n91OWH3o7G9ueiC5vjfa9R4StEY2B25rnfYXtlk6YbBvY6dIoOZAPNzweUcq8sDSLCbZ
         ZdGmJyv3vi6k4yrPiSJEhVwrb1FCmAZ8apakItK/bSeAVkd2oEQHf3TkhJnvbagHaQUC
         ptxQOLjSTUvo0Ez4Q1XGWV4Tm397vstg2curNB3h8RHH879WlsYmYbgsHwY1uSbjUcFd
         D1eDIvElImysf7BWTbZmaYbtzyxGHW5YKGdSndKoEfolNfQgVWWOME6IFeqzHlJ790xx
         b8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577820; x=1740182620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNJt0vNuEkV51zynYZo+HyYzdHqqBPC2Q3Ik+52LuJI=;
        b=ox873KE2ZhPrbvVjSZTBU4TW5RISdcN181DYzY/u7lLRYzkjiJkoDmRazpfFk6OJRv
         voYvaQcg/ncrmYHfpphb3qeEi6/1e8JYOX9Murdd/BLjf1gFoIa31D55Sm4PbQz41C0i
         jtUIfUVPlS6DeETs8ML6j7h9upPl0sXfDvtbY+udrm1TKS/Nsh5yqo7B3KDTrJ3WLV4V
         jxlBQ9mqii2fGy5k9sQTjDhH5POxMkPesP+F9p5n8KCOVHzEffdbVcJOoDkfJHHLNZaP
         eC8dA3dXgBCDLLIoqELgbKAL5bqbNKgqMycicKsxI8lQCDFCWoLUcmIyo5He0DksmaD1
         XwDg==
X-Forwarded-Encrypted: i=1; AJvYcCV/whA/uQhDZdP6ZTf22SzJ886qCO+l1byXfAFHKK0eZi0opy6kYtlO3M66Rt3/xE/IvDvBqh8w7pVhuq3C@vger.kernel.org, AJvYcCWHuyR5RHw5lG+FUl2rQQsDDACXNRXgasFVY5Zs09TOvXzPb/MtkU1vW7WeM9VmILXeNszf483aedEY/64=@vger.kernel.org, AJvYcCWYOU8o6Ta7PJSp2hjuaqP6aU04eQyHs9WY91Vdbs0mfLMXHBtCzpSrZat6ae4Z/aSLhK7FMwBkLZ0b@vger.kernel.org
X-Gm-Message-State: AOJu0YyletE60gknsIWYrggpHgN3W52aqNGsRKl6ByyJ/OGDOHgAcRKo
	8quxszAoc4AbmV8Pa8+ByyPKeR/qn3lsBZEy41xuvYJkBQgNCOcI
X-Gm-Gg: ASbGncuI27xh1fkY9nXNpGacGvEb4g1Jx+PEOLnPD9l3Ui4ZPuvagmKIWOfKDsZcZY4
	6pZY5OgsyeLFExQVtSBLPaUSpdtnd6M6NZrD3dZ+f2HxR0/MeXD1F+00lVW6zPHcFW7qAdvo15c
	G2t3+WGDGRmxlGkDSKj6hHCXZ0IHx5U9G2kVf2fYh3vSVNCjDsgsCwGm3Q+6SIAnbWqho63kOW7
	6McXxRT07WxqkMFLDcLrc7Vy7kiIcjR41mUZoyA5B2CdPt2ZFJj27Whnhww8muatMjh4lsxuKbV
	XvOXC3Dpv1LS7owoop49MZrlcNc9pXhNgpf/atN6hMRk4w8DcuDjwBuLHnlX4wlWQ3SGeQ22eUx
	1sFVHW51Jhw==
X-Google-Smtp-Source: AGHT+IH196Eueol1g8kBTIGWU560rg+TCAzrZwEk5wy2aAGIGo8oIpQrrLzEAnIzsvQ0XO1c52riFQ==
X-Received: by 2002:a17:903:2f8f:b0:21f:515:d61 with SMTP id d9443c01a7336-22104028a15mr18838735ad.21.1739577820409;
        Fri, 14 Feb 2025 16:03:40 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:39 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:37 +1000
Subject: [PATCH 04/27] ASoC: tas2764: Add control concerning overcurrent
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-4-723569b21b19@gmail.com>
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
 asahi@lists.linux.dev, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik@protonmail.com>, 
 James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=ckryqoK6F5gfX0Q2xqupCAjDXnKZm8KUzcE+xjgsqAY=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb25VNolcz/Z/ncYlix/vdrAXh15b7H7oRerMeXxHn
 qXu+vXDu6OUhUGMi0FWTJFlQ5OQx2wjtpv9IpV7YeawMoEMYeDiFICJaEUxMjz6z3zjUZDswisH
 9kxKOa2ymJnrWaTnmuYDa3tff8qYZ3aUkeEO755O/s1B26Ir82QXR+6wP1IVYJW2pd46kcVj9+G
 SPBYA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik@protonmail.com>

Add control to expose the option of autoretry behavior on overcurrent
events in the codec.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 9 +++++++++
 sound/soc/codecs/tas2764.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index e04b8ecab819402b8c3d2b81a2a447730802e968..503bb7f8b729d3760194a6f6f6996ff6469c580f 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -623,12 +623,21 @@ static SOC_ENUM_SINGLE_DECL(
 	tas2764_hpf_enum, TAS2764_DC_BLK0,
 	TAS2764_DC_BLK0_HPF_FREQ_PB_SHIFT, tas2764_hpf_texts);
 
+static const char * const tas2764_oce_texts[] = {
+	"Disable", "Retry",
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	tas2764_oce_enum, TAS2764_MISC_CFG1,
+	TAS2764_MISC_CFG1_OCE_RETRY_SHIFT, tas2764_oce_texts);
+
 static const struct snd_kcontrol_new tas2764_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", TAS2764_DVC, 0,
 		       TAS2764_DVC_MAX, 1, tas2764_playback_volume),
 	SOC_SINGLE_TLV("Amp Gain Volume", TAS2764_CHNL_0, 1, 0x14, 0,
 		       tas2764_digital_tlv),
 	SOC_ENUM("HPF Corner Frequency", tas2764_hpf_enum),
+	SOC_ENUM("OCE Handling", tas2764_oce_enum),
 };
 
 static const struct snd_soc_component_driver soc_component_driver_tas2764 = {
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 0a40166040e7e877ca5d23db6cb65531af12c40b..20628e51bf94f047e3dc7cac73ac01519ada1852 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -44,6 +44,10 @@
 
 #define TAS2764_CHNL_0  TAS2764_REG(0X0, 0x03)
 
+/* Miscellaneous */
+#define TAS2764_MISC_CFG1		TAS2764_REG(0x0, 0x06)
+#define TAS2764_MISC_CFG1_OCE_RETRY_SHIFT  5
+
 /* TDM Configuration Reg0 */
 #define TAS2764_TDM_CFG0		TAS2764_REG(0X0, 0x08)
 #define TAS2764_TDM_CFG0_SMP_MASK	BIT(5)

-- 
2.48.1


