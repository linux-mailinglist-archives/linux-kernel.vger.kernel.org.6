Return-Path: <linux-kernel+bounces-515832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9156A36985
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090BC1897F74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC791D540;
	Sat, 15 Feb 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+9NGsWH"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F14C92;
	Sat, 15 Feb 2025 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577954; cv=none; b=JdInRsxL7jzru4pKL6Try3LN82Fpltwn51AfMhwlZhyXJekcR/NY1bdB6804fOkEJAUOdAKAKg+YDG1lbfVqr9YGH9xNwTRPCZtJu/fvwrjyya6hfL4TpWVO4o8J9CQ6Nq0MHzB5vLh+NJxZaTkdyJvMq3aLV+dEF9dLbokXVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577954; c=relaxed/simple;
	bh=RDix+/+TMA7k1w8c7iWmcESPa40MeUHuuJ6OGsToqP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOI/BuKbPWKCKIam+imZszjHJs+ctFx5S18yyI//LzM7D44rI5X9589nAcj75LNF717gVkSecfO7RpoTYQWeDvkBLp/7LKY4wH2ff/xxyeb9E9yHRywppAsQ2YEfhSAhQZwlrD6pnZXbxrQsRzp+wsXvmQcy4Z2Dh3xpjOvMXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+9NGsWH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22104c4de96so3990585ad.3;
        Fri, 14 Feb 2025 16:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577951; x=1740182751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnuXwhPKY7wDxI4Vb0cLFSGpo9M4uNmayGUNt+K5nXQ=;
        b=j+9NGsWHOJ6FSIpJvnvtX/L7KjoGvswrfCXAj6F8zmveCOi68ZWcHH0pQQcWxVemcO
         yZjYlyGBrsg/3tCS4kjhQFi2QgllNQvQ2cmrgki86eShdLqN0d4Pl6cwS/lELXA05Bvg
         DrFL1hC+eETCS3PKXxwuaHm2Z5WOTLqYrDfdYHUyaw7TBYBx9qoy3nSNo5u8CTZDDHUt
         90cwACrKY9pOb12uImHw7RB6VrYqyVOgJa1h4GWF0LhTH1Bvrubqhk55YuPxq23U6qw/
         C7QYymCly5gWnPm0Mmplp8pBNj5iJY4wxNSdNuum4tRLzNZ4t2hzjCPLBsTX9GSxHZjE
         sHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577951; x=1740182751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnuXwhPKY7wDxI4Vb0cLFSGpo9M4uNmayGUNt+K5nXQ=;
        b=oG6z56HyprB79PDH3vyF8XUaxzYmk6kpSrKZ7eATfTWxzZNcEaB9p3AmhanGnKThfD
         pqGulL81zi7EXy0f6AFtxq5I0BMMhSxoD5fuXbdNwfMYV+7kDjL7xhucS2b+tmSdcr+Y
         9FKfl/FHNZAEtw4a10ZdWlXMdneo3wk3u/pOLj62b6PGH+MiTCNQ41+Sxg0vuit8Hc//
         Qg6Gr3FEaYtBJNF00y/1PtL6gpsegiu8LZfUUiDbS4VnDDoa8rGYoVKK4YpAklboNsGc
         8b+SX79kbZOZvsFXkD7byTVD5rE6j2clbSPypC2bgKRFdYOKnwQP6418DgVFV61qHWhz
         erYw==
X-Forwarded-Encrypted: i=1; AJvYcCUSXKg5XiyJvSiRoqN4655wNrzqqFCBCnevSnLuql/RAMa+chFTJc9VOjOiQVUBhjeSKzPUmQBbGaTU+ZN/@vger.kernel.org, AJvYcCUSk1opwty/nKzlpUFfv1OIfZ9zw4ub+2HVc0I+sQJL5uJVUhtAFfdXdLiKNi16CSngDyqjwDTjyqFp@vger.kernel.org, AJvYcCXXUalHJraLF9ynXI17JqdC6A5ptwHK7lzxcddcZo606Yi3n1Z086DEv2tR/j7c0+ID0Ozk8v9j5xwMrqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDecR2KtvfhIQ6N5Q7j6E6nkICB7mMej2hv1fMsuBX180EIa0U
	DCxwW60/JdYOx9oGKo385AU17yeBpVOuylbqkrSN7FyKQENq02Dz
X-Gm-Gg: ASbGncu9MmRVW25cQtCY5szswvKv+384F8IUTOpcD+HidiKcW6QvRiMQAdoszyLHVGm
	53VZwhcGZDlpfyiEPewr3vXaBuaps11UavzZ9do0f9bvKBtvdF06ov4r8XX8rthOk79u5lVwirV
	9MiB1DwIsJqGVMZJx5nXu0pXv+sv85vELiqqxc14VIHQ4BNS6F1BUbPq6Qg+71xGZvC6NEF6jTt
	XlrMWCYDDu+XZJ2jfkQVUtD39jdsKv82mXAa8IhMwyDbX5qiZo+qRyy4zEi/SvnU4i0nirpUe6L
	0KCR/rDMZv+ej4nLxg6QXZ37EZyWsvLwXPEZM/fvc+R/CBsouQKvQjsnV9AU+r26nwwB/ddBnxg
	Uk+wpQgKhbQ==
X-Google-Smtp-Source: AGHT+IGgY/dXJYnyF1dgWE0cS4WNHAlQm+hrMjO3hWUb5GNVVYJFHljlLirn42zG8WRNXX+yoHYx0g==
X-Received: by 2002:a17:903:32c8:b0:215:8809:b3b7 with SMTP id d9443c01a7336-221040135c0mr15618835ad.7.1739577951530;
        Fri, 14 Feb 2025 16:05:51 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:51 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:56 +1000
Subject: [PATCH 23/27] ASoC: tas2770: Add zero-fill and pull-down controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-23-723569b21b19@gmail.com>
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
 asahi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=+sGEqJnDHCIhxzVYE3pEiGOszPBCfBGomCpq/eBBdGo=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb+4w0NpSw3tm4vbQVjmPZyfkrlv1fmT8YdmyO/xKZ
 faq87XnO0pZGMS4GGTFFFk2NAl5zDZiu9kvUrkXZg4rE8gQBi5OAZgIszUjw0wGozkTXE/uq9O/
 sOf+2WNf3kjyb04/NqNB10FV/xF7/0xGhp98H2XqhaaH981LYEpvTTr03GpKL/cEHuF1Mdvy5xi
 V8AAA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Expose the bits that control the behavior of the SDOUT pin when not
actively transmitting slot data. Zero-fill is useful when there is a
single amp on the SDOUT bus (e.g. Apple machines with mono speakers or a
single stereo pair, where L/R are on separate buses).

Pull-down is useful, though not perfect, when multiple amps share a
bus. It typically takes around 2 bits for the line to transition from
high to low after going Hi-Z, with the pull-down.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 sound/soc/codecs/tas2770.c | 17 +++++++++++++++++
 sound/soc/codecs/tas2770.h | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index d74bbe12dea49da376fc577dd144912468fe163a..7ac7ccb32b4db2050a8543b950a9872b7551845b 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -602,6 +602,20 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
+					    TAS2770_TDM_CFG_REG4_TX_FILL,
+					    tas2770->sdout_zfill ? 0 :
+					    TAS2770_TDM_CFG_REG4_TX_FILL);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2770_DIN_PD,
+					    TAS2770_DIN_PD_SDOUT,
+					    tas2770->sdout_pd ?
+					    TAS2770_DIN_PD_SDOUT : 0);
+	if (ret < 0)
+		return ret;
+
 	ret = sysfs_create_groups(&component->dev->kobj, tas2770_sysfs_groups);
 
 	if (ret < 0)
@@ -755,6 +769,9 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		tas2770->v_sense_slot = -1;
 	}
 
+	tas2770->sdout_pd = fwnode_property_read_bool(dev->fwnode, "ti,sdout-pull-down");
+	tas2770->sdout_zfill = fwnode_property_read_bool(dev->fwnode, "ti,sdout-zero-fill");
+
 	tas2770->sdz_reg = devm_regulator_get(dev, "SDZ");
 	if (IS_ERR(tas2770->sdz_reg))
 		return dev_err_probe(dev, PTR_ERR(tas2770->sdz_reg),
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index f75baf23caf3a194a040474a7484a3d44f673435..2c2cd777f4bcba8ca91f79ccdfd9f159df5d3a97 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -67,6 +67,14 @@
 #define TAS2770_TDM_CFG_REG3_RXS_SHIFT 0x4
 #define TAS2770_TDM_CFG_REG3_30_MASK  GENMASK(3, 0)
 #define TAS2770_TDM_CFG_REG3_30_SHIFT 0
+    /* TDM Configuration Reg4 */
+#define TAS2770_TDM_CFG_REG4  TAS2770_REG(0X0, 0x0E)
+#define TAS2770_TDM_CFG_REG4_TX_LSB_CFG BIT(7)
+#define TAS2770_TDM_CFG_REG4_TX_KEEPER_CFG BIT(6)
+#define TAS2770_TDM_CFG_REG4_TX_KEEPER BIT(5)
+#define TAS2770_TDM_CFG_REG4_TX_FILL BIT(4)
+#define TAS2770_TDM_CFG_REG4_TX_OFFSET_MASK GENMASK(3, 1)
+#define TAS2770_TDM_CFG_REG4_TX_EDGE_FALLING BIT(0)
     /* TDM Configuration Reg5 */
 #define TAS2770_TDM_CFG_REG5  TAS2770_REG(0X0, 0x0F)
 #define TAS2770_TDM_CFG_REG5_VSNS_MASK  BIT(6)
@@ -110,6 +118,9 @@
 #define TAS2770_TEMP_LSB  TAS2770_REG(0X0, 0x2A)
     /* Interrupt Configuration */
 #define TAS2770_INT_CFG  TAS2770_REG(0X0, 0x30)
+    /* Data In Pull-Down */
+#define TAS2770_DIN_PD  TAS2770_REG(0X0, 0x31)
+#define TAS2770_DIN_PD_SDOUT BIT(7)
     /* Misc IRQ */
 #define TAS2770_MISC_IRQ  TAS2770_REG(0X0, 0x32)
     /* Clock Configuration */
@@ -139,6 +150,8 @@ struct tas2770_priv {
 	struct device *dev;
 	int v_sense_slot;
 	int i_sense_slot;
+	bool sdout_pd;
+	bool sdout_zfill;
 	bool dac_powered;
 	bool unmuted;
 };

-- 
2.48.1


