Return-Path: <linux-kernel+bounces-518874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C76A395B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC53A2F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB77F22F14C;
	Tue, 18 Feb 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/T3q/H/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A822D7BB;
	Tue, 18 Feb 2025 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867812; cv=none; b=Cy/BCq3O4oiOY4F/BxfPFWYcezpmIamMZfbTLzwOwhsXcl01wdteZyAFlOrkqpoKU7Bx0nk2rSqbEyeGEkmUY2hQdyrRmgs2MdA84xOm/Gb2MubBeHqKavVOQIzIe8Rjeh1PgBhSHiF4WdTbSTbdU6puqCHFBnFZEU34X4LRENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867812; c=relaxed/simple;
	bh=y9R3gC4DcFYDFbAgeXOJCoKDJMqg1SlzEiGmhUycXwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGSVXkTENb47laiThAz8a/9SpbnBgxJY+R9VK1s/vX/abgMXEy7tg8N8SDBxVMTX9Q6teLGfD/eHEEH6XA7bfcp/0PNiAQG1pSSFALKsGfjVfrdq2p607t4n+6J4cNSP18KMoThxNRHQkem+0Vwf2FAa64waraDYSAnKZ4Fi9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/T3q/H/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d39a5627so74768315ad.1;
        Tue, 18 Feb 2025 00:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867810; x=1740472610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeoXHbMNaZZnZxWSox36s26riivTYQEGCI8dhE09lK8=;
        b=W/T3q/H/iypc3iFzUXQoiI4C6i1e/epxDRFg5swK5Mmz5Tl8vg3/qmm3EIZ+teDbhb
         1D2S2dfPDZcnwlVW2UbfuvDuue62yZltFVMokoRrejDnwEP9AwdPd2Aju+SaDl7qhCP2
         KLXiAh13B8gFxf0/fzfe7xeZR2bHZEyr9YwxFmxNX/EpA19/lKISBXI78V1smoYa4K9R
         6scFE6Ol98ScDhQWnP8UnSZ7RFZbFthDY+NivOcTVA7nLvqRjyrhj156IluqojBsb77I
         nd8zJo1ZMRFoUZANDy4t7ZOuV5FU3sOU8W8c5DNyyNqLryvz0S+xaaaTDPPxqZyH3fuA
         bUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867810; x=1740472610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeoXHbMNaZZnZxWSox36s26riivTYQEGCI8dhE09lK8=;
        b=mSoPktFU39CnI1dvxzHhH7ou5ZNFK+FU9YLqIaeFpFr7cC490QDqnW7Bm5GyABuEtX
         4lvK610X4WX91Y84E5EMXNgr3WvaniekoGu1qFHbYIGvoCNem/NFu9PR+z7a7zT9qgHx
         JJ21dmh6Se4z/4TYWV6NA6u3J/86boG6kHo2tIZppnrF8sMo06IPEgSJBvwCrCwO2WCa
         xkm9l5n1zNK3ecyJIoy2YJYBKG1fngIU1+6x0QFdeigzew3nrsQa26GTNfhm7o5sj+IV
         7nc19Gci7Rrk+pmbnkHCzBEPxnc+qYBwuly+t3oDrQBeqW5FH8mGqq10hbfJCKgS2uI8
         EMbw==
X-Forwarded-Encrypted: i=1; AJvYcCW0TQ5IHF6kTgCTvHO6IgDAlWLo0velIQh7o5Wxv/JyNZlT1O1nnl4QahL+8oDaz6fERop4rKAnWKfPiuM7@vger.kernel.org, AJvYcCWG4BK4iEI8bgBRv3VCSVXqKh3kk4nmj+m3zjUJt+j7FBqTEOXRS82FUgReCS5Go1gGgvMcmisHHt3Ta9k=@vger.kernel.org, AJvYcCWU9XmtsruQDorw+7pa7WqemJtPQ5l+uXOPUKj7VhDJgtKrxYWJeK3CGlMwjRrmNH6pNV/VOzCj3qg5@vger.kernel.org, AJvYcCXIs6g5o7SvqO3OiO5lDyijaDenK9qd5ICt81Y59UcWUvPrAZbFSD6ng8rYUJkB7+jJG5lvEiNkEQ/kouY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0orjnXay5KdRHGHlZ8otlh2UWxk2hveR1eTcu2en+tb3pLPmh
	PRgXW1P+0Ggnxsf/Y5PuQIcffLhH1/0aTm+ASv1B1nMp+1uS2i+FgA8I3gVV
X-Gm-Gg: ASbGncunE0YP6kEqr/f2ESInTicE8mgMhTLVrOSqP8L5H7358hWrRt7rCZDzzh584Bo
	Es2Dejx5iJ9DZrOugd5mKjWaf7DtMmK4YgqzM13Cj+ERFEi5+mpnD+swSqzKKhvjVj+mWB2BvLE
	i+RUFBvC8oKlwFrYAdB39KIBHQ3CqtTSNqYJh/67Nr6y6OpeNpO7i0JdG4halbL3aVCc3VE3waW
	skEjsjXTEf8sVKFJpM5a2HlGu7D20Q/zQO+jhjsbEbwbKo0/N7YPKsCZAzLXg9bvyDI4CJUesqE
	TGzR2oj3YNfOUdmcQQ8Ie40x3+O5oI/xLFwcY5+ho2J4npOIVPZf8ugcWlUeHvKjtSqdMy9IuLd
	nr+koU90SKA==
X-Google-Smtp-Source: AGHT+IGPbLuqbipaBn28ukI985CLtVT8f1ut4Ayk1W47T5tA6vEIHMLymg1VfjkuDP7Cp+W7NPG/cg==
X-Received: by 2002:a05:6a21:7a4c:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-1eec8e7219amr2930381637.24.1739867809711;
        Tue, 18 Feb 2025 00:36:49 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:49 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:41 +1000
Subject: [PATCH v2 07/29] ASoC: tas2770: Factor out set_ivsense_slots
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-apple-codec-changes-v2-7-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=2q7/AnA+S3zg5UY6950rlfHRPwEmvXdr4IHaVW0DiDY=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3BJqftW3cyx71y+yON1BqfuC5sJ1L3iiLn+6UlFmX
 eVVoOnVUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwEQeHWT4K949b6/VTqVLzo+Y
 JSVPFcbNEjTnizrl0vqu6EvtZ6tbOxj++3Wl3axIK7fZe8hxsd3C50HXRBt2+WvMaS+dFVRmc3k
 OLwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

Add a new explicit function for the setting of I/V sense TDM slots.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 40 +++++++++++++++++--------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 863c3f672ba98dd74a5ba1b15d650a90f91176a1..4a86fcec0c1ecab45b9ebcdfc90c78f3290c6fa6 100644
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


