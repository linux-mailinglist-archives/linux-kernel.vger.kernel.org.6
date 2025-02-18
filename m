Return-Path: <linux-kernel+bounces-518869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E2A395A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0E3A6DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937920C03C;
	Tue, 18 Feb 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjbI1WKi"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC27192B71;
	Tue, 18 Feb 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867773; cv=none; b=Rqvc1BlqJWsvw8WOM0oVowGLB21beQmVZ4mDIgZnuUWL5sZpoEQA6P3ksvJj8LsL+weGqiQRbVeDI5bXlKru/WR2oLSCpt2K8+8/n7emQuRpn0PdDnCoDi377mf5a7I55YU0fX1900/7p4DUIaWNXKw+qzPDVRUL71ZRHs/s9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867773; c=relaxed/simple;
	bh=ihiPVhcMUYw/qHe10TgorGJcdQbOh6p+yirtw1hvn2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1HkUiAt7gCMralOjCDJrKIUljDhQ22VF0ZveGa56NOkW19HwWMQXpRePScqe9lbaZ5Kj6VFSk2NNuJWxXGrEpsLboz2KqlpFSBS8dcr8Qvun8+E2SwNocfhQkgcTTKpdT4XwUyNGNji2N3WKyQFGTJ2AFjW0BdzwNPvtl2OOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjbI1WKi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220f4dd756eso64592905ad.3;
        Tue, 18 Feb 2025 00:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867771; x=1740472571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF/O/lP/mT4jNnw/OxFlvVpNX2pXzauUtJPaPsgZZfE=;
        b=UjbI1WKiREg+NrjiEsRUJFn2givdYObci7s+6UQVq64r6y6AJqMxAomq9jxwN+E1D9
         x0b17z+Z8PpVO7FKp22OhkpATf/JrNRm38OKlKo14RBcYh9IwVrecPimCtJDdmgdK2dB
         R2BWN7yNLxkf5jAyXuUjfrBzcLb8YAkmP0lnXXIzq0PpXffjb3EPmIW0asPDNZZGZ/+0
         hgOjop3C6uqTPYIXnNwHbJPNIiIK2IaR4+f7/9kK+r/oedYBeT+gLM8JcF9GMA8kdMts
         JBYVrsvA8Yo2HzZAGLOLOx0cY53vHfu/KoCrVVvLHuAptsQYbvwRc0D3wmEpxRLPfUsW
         w7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867771; x=1740472571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF/O/lP/mT4jNnw/OxFlvVpNX2pXzauUtJPaPsgZZfE=;
        b=Gea/iYcVDW6YsGzUJYtLOr7HGrIpUZ/EnysymayoAdDXNE9HFIcYYhmH07rcsGjLZA
         jW6+uX8Y80hf2v74/O44RdK4T7u2uAUXO0ppc7ReeSo6d0tlnIMR6n02cvnQhSMf2FsF
         pT9tUT3+T2q5s6ylz8LM2qjlTKJgB6oU93ccMZhHkK7MBROCl86ETtoVW2txCwhTR/2q
         2CAwFvkh1wmjsgNskldNYzbIIZGzQJLL7ehGPXrSEnjKAjJBx/34r01vmgQFgX7DDHyR
         bLxTKfzg8AVSXhOkciNoGuG5ZABM5/C51wMGNGpuhXKd0AWeQKp04h0DwNubvWLjqLwB
         nnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHpy3aoRS7AU+QW36Pa5kNsWvS6HSXQZYLXEd40sXYSFP4El6Nfuoa2DGWFTLvf1jv+LZZYjl707Xslvc=@vger.kernel.org, AJvYcCV52KjqDI3gkktisYqZqxJImMRxxMOe+lMcqmCiaqvbe0onSzou1BSyxF1deH4cGQptWOwkqDrFLo83CDwv@vger.kernel.org, AJvYcCVn0wTfFNTnaJVtgZNWeetl8oxz3YE1YhfT9jm7YO9tixEVtXOmWTe0GTTmMUCC7qoEe7tg3cdEQa97@vger.kernel.org, AJvYcCXrFiblGKMFau1n44Phxylgirvp1fKzj00x7RE8M/hbNR/bkZY+EegmfiBj6GPszNtSsqEf8GJIDRGviMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr9QGQ/JDlIPqzx2HmzJ7BtYfAvAt1tzSXmDIEm9wbSSDqQjZR
	HYbIdEjEeSk155+WYRZixyfSd6wekApCYc5mzH7DzntMYGnHPPAzrfOJJ5JP
X-Gm-Gg: ASbGncu9rXr7w9YXTW5mVtyKiP5mt8gPtACEnsU/hHEfz5lzkdONi1lT7b1d0RcVwNB
	p2iOJGu+Wm/FkLuhb4e06eUUcgaJnNIXd36nR54GEvft18NRM6JCeW+AZf0qONmDlj2bBg4Fn6C
	bWFVKg3sG4NBiTwvns8urtjHO/chVRvDJr9W4RCpTdP4u1goyrD+r69KOPGdLCEAIe1j34g60fe
	+IuEIprpLBRQo/IGBI2/Vp3by6eIPhc2Ps2SUled8HQJxHY0AsJNMYbr0/MMFb8v2k7/omp/hV/
	BQdleiDoqj7g7Obdj7fE8E/d9kIPeX9ilNS3VwqP0AKxgxkgq18Lmv8vUuN4RqSNsYWBBUQ5Fzd
	nSBM48epmKg==
X-Google-Smtp-Source: AGHT+IHmXcMPPPj/jkvfcToQWS9qO+2Zddin1cLKfo5/ytUB2jIw0pEXVc/F3aPgclBbVhcX4ndltg==
X-Received: by 2002:a05:6a21:8886:b0:1ee:a914:1d57 with SMTP id adf61e73a8af0-1eea914203amr13137022637.3.1739867770702;
        Tue, 18 Feb 2025 00:36:10 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:10 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:36 +1000
Subject: [PATCH v2 02/29] ASoC: tas2770: Fix volume scale
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-2-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=974;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=q30IbUoUVIty8Km4kUwzvng0oNn9XrUmBVn70mfZY4c=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OJr/xofZLycZvb43zrhaoccpZTlIc4TiwpcbpkKd
 F6++1Szo5SFQYyLQVZMkWVDk5DHbCO2m/0ilXth5rAygQxh4OIUgIkI9zP8T9NmfFgRet5Ad7n0
 71Mzb/Nfip2Tn9O6/qNGV/MS1pXRpxkZti4UfenQp9ffzVQTJScTs3xbqbGcwGKp0vUZqx+FXzP
 iAQA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

The scale starts at -100dB, not -128dB.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9f93b230652a5dd05f325eb506220b17f5a4b91d..863c3f672ba98dd74a5ba1b15d650a90f91176a1 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -506,7 +506,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,

-- 
2.48.1


