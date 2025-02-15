Return-Path: <linux-kernel+bounces-515814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98757A3695D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C9516B683
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABE14A088;
	Sat, 15 Feb 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCCwJ3kY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661A14A617;
	Sat, 15 Feb 2025 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577829; cv=none; b=SDc8ZqxtIhBZDcyONs+SnqxAZlHGikp6GeO8W+tZJhZbNr5Z1jqTlZpC2/WlrinYbLWBG855qcbPGrTFMVNHXouuBsK/irLIsrGOX8ors9k/WIGXDm/b+Ly6RnXzDrR2tWZ6/vq8cjkuN+7KKHDsBuo8E3VKVoU/BpzBhBoVuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577829; c=relaxed/simple;
	bh=HdOUzZNF2Pmnypg58HHdjSM5E49x+d0F3QxO9cXe+GA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkG0f9kOmcvOSHkJ5v/6QfnVJKHkeQCwvGR2+wuDDCXlpQD6K8fDJqWbVogREX7JuteD+HNOVofjkCfaivBLOojfRBcD+uvo5m/PJstVVPaIccF6LDiEpi2KkxJWuXlG/vo+mAkJY0sKA+nEyJm9fDXgxuM6LNtAfqOCb8iC3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCCwJ3kY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so46542085ad.0;
        Fri, 14 Feb 2025 16:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577827; x=1740182627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSfO+VowtOqUTrjFAcOWpa8HkJSqbuMrDyG+/l9mYPw=;
        b=DCCwJ3kYnZxCWrJykKetduES26BKLkqJfrox1RuH0cS+cjip5TAkoPpGx8Lghb74E1
         kYSl/8SXfNm/4JKL47RaOPrgP0rLSqcdrFgqs4nN/RfZctkV/qXMZGxVi9JDdTYv+ZSh
         jSxWEaf0ofEDeagGgaHr5RaWllPvybpca9rMpeoFfIcHnFGWhzujp2J4FSBOBbD6WfVF
         +huf9U6rwkMQSYALnF66bvD8PiF1BB5Hjy98msIyb9QGyPX4xn48Xc/Z4kX9gtC2QdAk
         CHvYzYBXpYyzygp1svqughyOcC77Le4OnAXWWKPpASuqjTWcWggOABbjc2Bf4XUox5a4
         1Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577827; x=1740182627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSfO+VowtOqUTrjFAcOWpa8HkJSqbuMrDyG+/l9mYPw=;
        b=RkmO2Z7QTyeT9ttP+3O+VGObulBSwDFBWGXWjNj+Mqaq1y2WQnSBt7p8E182ptELYI
         YkffSCTXDvblW/OZvfC2QxxSYDJvyrir4FoAiBgzwczHahwDlz+1ieRaL4LsCQb+Mxwb
         ch0v9aDcvXgLFQ/H/exTGvs5y3saDtLQ06yl0VBaQO67iSN9hV+FFhStpPl1dOoOX+cO
         3UhOnoN12q0v4s05hDvKQjlNnpq8+VvvGcMAiW8u6iSKxHT4LWhZaJb/vEwoJv4On8vO
         tB2cnbUhSA4Kou0cz6orQqb1KyWvs+uAPqoyib9oZU5qbPk2p/miRK9y70kYKSh4k2+W
         Yddg==
X-Forwarded-Encrypted: i=1; AJvYcCV5OIGa7RkzZSgymwlUliwRAmKlSdt8mf/iPwdEST55sriDfAyOKwvIz5VH3CNBG8RWPjLYCWVkNBT8@vger.kernel.org, AJvYcCXOR34gMvRiKy4TXkvsLw6VN8Hs2XpmTZAZLgc2EPvH24HuEWlx7vSCJanyQIalbGnJznULpkDpwIndwTE=@vger.kernel.org, AJvYcCXPia760xTpv9OjAoVdcbGauBnBF/NHKRaEG9+eiBcDzLoowLb34AV50JlLTjyBuw1aqQiYAqX/JEtvOZem@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdscRUQCHLQ2iUCekZBjLVLdM76/yHr6aG0dd43HU2VLvFm4v
	vjVsCFGEkYWhcZAh/20DkRWHhxTM2rdgcP/SkbOIxfXjxoL5cSgh
X-Gm-Gg: ASbGnctWCaIxtyOhHCgqOhklF/hvKGEGq+j84CqTIhKs8JXKOZSNmYzuEqRSLpCGQv5
	Bwpcab2JpFy3rqkhnfz8ZLBsXdvruPFbwCLQTAEmGxH93NiHBo8oXlTGFINBkm0a8txDWGyKDa0
	tRVj0mXfyIMWKTZqGWv/F7H6I543xgWyqRS0Vdtna3tTluPJJlqFfdXHC3VQq/Vp9LtgqHxXrFP
	WpLAs8GmjmgCH/vBL/eOfoqjFUX/3nZfwjir1YGVPXkEOzqLH+E2nwaG2/Ty76txu9CCePYXDwo
	rVMCVD4EBKpuf4bjIgWgdQswfqiLznd3w16HInzUUvf7EHdhJwplpEK//AtjwP0jZlNqRVcmyR1
	Ty2hbJURSNg==
X-Google-Smtp-Source: AGHT+IEVEmQ40FmDn+CfAUaadDKXT3q/Mz8plbwvQ9yvvlPi5yOo06GC2jozTAovzEvNDFO2homiqA==
X-Received: by 2002:a17:902:ea04:b0:21f:4c8b:c511 with SMTP id d9443c01a7336-221040bd73cmr17269215ad.33.1739577827311;
        Fri, 14 Feb 2025 16:03:47 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:46 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:38 +1000
Subject: [PATCH 05/27] ASoC: tas2770: Factor out set_ivsense_slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-5-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=f/J3i7KMIWxmruabP9W+++oGD5wdnj1RJnl1ABfMP9s=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb26d4LKSQ4BVccp6zeu1+dY741bmPVMX/C3TKqofE
 LKwMt2no5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgIlsU2X4KzafQzNpwfLf2493
 3y9r31Xe133DQv3F97cn7s44+1/lYTzD/8TQnVdYc15tXOZRECCnbVP8hEeE/eHJ2YkR7A2MAhV
 6PAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Add a new explicit function for the setting of I/V sense TDM slots.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 40 +++++++++++++++++--------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9f93b230652a5dd05f325eb506220b17f5a4b91d..0c8a02ac2c0db10c449a68d9365e79576e24abba 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -189,6 +189,31 @@ static int tas2770_mute(struct snd_soc_dai *dai, int mute, int direction)
 	return tas2770_update_pwr_ctrl(tas2770);
 }
 
+static int tas2770_set_ivsense_transmit(struct tas2770_priv *tas2770,
+					int i_slot, int v_slot)
+{
+	struct snd_soc_component *component = tas2770->component;
+	int ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG5,
+					    TAS2770_TDM_CFG_REG5_VSNS_MASK |
+					    TAS2770_TDM_CFG_REG5_50_MASK,
+					    TAS2770_TDM_CFG_REG5_VSNS_ENABLE |
+					    v_slot);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG6,
+					    TAS2770_TDM_CFG_REG6_ISNS_MASK |
+					    TAS2770_TDM_CFG_REG6_50_MASK,
+					    TAS2770_TDM_CFG_REG6_ISNS_ENABLE |
+					    i_slot);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 {
 	int ret;
@@ -221,19 +246,8 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG5,
-					    TAS2770_TDM_CFG_REG5_VSNS_MASK |
-					    TAS2770_TDM_CFG_REG5_50_MASK,
-					    TAS2770_TDM_CFG_REG5_VSNS_ENABLE |
-		tas2770->v_sense_slot);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG6,
-					    TAS2770_TDM_CFG_REG6_ISNS_MASK |
-					    TAS2770_TDM_CFG_REG6_50_MASK,
-					    TAS2770_TDM_CFG_REG6_ISNS_ENABLE |
-					    tas2770->i_sense_slot);
+	ret = tas2770_set_ivsense_transmit(tas2770, tas2770->i_sense_slot,
+					   tas2770->v_sense_slot);
 	if (ret < 0)
 		return ret;
 

-- 
2.48.1


