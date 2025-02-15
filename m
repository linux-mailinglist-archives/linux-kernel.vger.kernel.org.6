Return-Path: <linux-kernel+bounces-515816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E8A3695C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB1D1895C93
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA396125;
	Sat, 15 Feb 2025 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpwAE7XS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6731096F;
	Sat, 15 Feb 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577843; cv=none; b=gQWhl/M7xS9Opk0MRND+0Sqjkb+0W55n0eaEpgUul0jpVe/rfpbVtLkhLf0yAca3A9SFZV/VpuFOFrlTCIZ/e4HjRWGuaMwGzXutjbnsKHqcWTIBE0Whj8S9jQxsc86Vv8lzqWWAchRzVZ0S7mw7WUI0eN160OQnhEWS397VnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577843; c=relaxed/simple;
	bh=Q0SPl5JH9LaHvgfDJ96M2NZKrxwY3FINQN2Up2ZYVLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=af6x08IR1+jWY+sb2oAsAjbA7vThzPsPSYE8fWsxv62BUy2TD9O/S/JxwrBf8qm/unIMXqm0h31wh/UCVoX/6OK37sIs/CrQtkzivUVi3phnzHc0m9RgizR/Bfe0cVM+PgFYM70IcH4L2o9nY6aQpE0eL8qBk15+0CXcN55GDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpwAE7XS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220bff984a0so46093215ad.3;
        Fri, 14 Feb 2025 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577841; x=1740182641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03VCERuRQd3sonLjwX2xR3AgSfd5Oyw98QEf0M2noT4=;
        b=DpwAE7XSovHCQVrdlrDttQygRCqCnextqHu1/V5LNrRpzss3BVoqqXs4xuRic1+gYe
         sjLPEA/TA4MTYbrn2FTTXA+qCBjg9L3VNQ5wnBerFtoNCxWqmZ4qYnJu42w7G0LD7ku0
         GPjNnoFjw7bicksT70QifcAj42JjeOGJAfPGdwPGao07QSNEJIVrWxsFsh4uk+sDOnDe
         0LAhuzrqNhdOZGHiurqQcBG6U6HkmpHPy7HbTUZhDWi3LdwyhUSbD2mVTnhGbM4JrFBL
         kV7G1ZIEMPCeMd2vv2rg6yMHzsppUJg8LCdHdS7JxKHOcY8zvefHWHGqRFjjYN3rTiyI
         khQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577841; x=1740182641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03VCERuRQd3sonLjwX2xR3AgSfd5Oyw98QEf0M2noT4=;
        b=bbi95uyBFXi4WnSQSK2iUyprA1cmRh6LZrvu4A0UDeLql7xp83vXJJp9mcqaLNJZr+
         fsvb5rTZjX25oBF2UoDkF7z0ewMcGhIH6+3KKH/XQK+xA4nn7ekHS8IGh0btTX7i2xeY
         Ayxf4wlFDTnLalP+CUjSPHqX83pP0uyYnZduJTaRVXXvY97ftYKhzwKb0YgWrJcesfFA
         EutPpLf7uU7SioTl0emVG9RsdRsfjI/fvNWyFPSLl7nZkgF2CF8tm65AmDBuv2tY1ZuW
         +nuvrN1f2wk3s4TCiINFQr0Aq/0ky1iIXwXGIy/w7C3A5acmQxjDPqb8TUTZtNtcFDsw
         3rDw==
X-Forwarded-Encrypted: i=1; AJvYcCVc4tjFwpvDnyURxFCtTTFEmK/0RQt8sPSUidlLY2nxDRFGir3pX8Z86kglXtars+jUGDiLRPLuUGdiAW0=@vger.kernel.org, AJvYcCWb2WesPKUDCLr5VgxQnRZX1PNRcsWQiVkJAnyHO6NNPbHz3kZTRg7fiX4q9bsnsBy8aN+ZG61IqyCOhhp0@vger.kernel.org, AJvYcCWcHw65E/umVDRQKMRO21Y8p1eUPr54NiYIxHvuvrCxAOR64m8GoIQwW5scWnBr5lDXCU1Rkop+qxre@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2axzxGSo/QUM+0cvcJBxzdyjB8MZaIOrHLsZhifWhdat5/q+
	fCGhZMx5anZxsTzgQyDsCzWMRpB0EXPI0aocneHngiYGeM4jAVgK
X-Gm-Gg: ASbGncuAVO7T5OW3FZOvO/ooyCTSTmYhreVOxtZTb4mPLLSZf1gpSvUqvYkDvUbTfi3
	0DQgLmi1qQyBo015ccQ2sUsCbGKFGVNRbPjsXXFrvQWeNkjYdqwaYvj8oGKhMKmcFostvYlo1Vi
	Tqa/DlDAb55KleqQU+33BYlSnzl1LsE6Q4Ahj9M39xjg5KdQLXlxhy2PnFZHoONH/Ez+QlPceKT
	AvMZXzLP1IOP5iT3eQZXlRIcljqnCmpHCvyTFLCjTW7dnANB8dJLyy5D3h66Oq3NAR16taapZXF
	Z0udT+ESv6O1pOyTCEbgU5kjWdt0NbV3kVsQSnFMpBcZ4JFxJ1vis/Z6foW8AWC9jpMEXs4+8iC
	P16XEOgFXDQ==
X-Google-Smtp-Source: AGHT+IFEbbW3BAtsBgFCB9kBQKiM4ABgJn5ph4HV9zVEO0mqabKPwQqEDNW4omoAqNlYhJuWy8T6ng==
X-Received: by 2002:a17:902:ce06:b0:21d:3bee:990c with SMTP id d9443c01a7336-221040a99cemr16511975ad.42.1739577840941;
        Fri, 14 Feb 2025 16:04:00 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:04:00 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:40 +1000
Subject: [PATCH 07/27] ASoC: tas2764: Reinit cache on part reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250215-apple-codec-changes-v1-7-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=B1Sb5itjHDK3h5ZHbLewODahZLkXBqkrwz4IxIkfeXw=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb261Fz3vOn+1fEP22nlTIuzP/Ap23/14z4oJmSFOV
 TqJQllaHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAExkhgMjw+1vHUck4v6af+r5
 PD/iU+ua4Aszgt5nLLVSb8/RuWHXXM3I8PBZfitrjEPuMWNe3TlbP1uxrk570vRle1GfcMibrHg
 zFgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

When the part is reset in component_probe, do not forget to reinit the
regcache, otherwise the cache can get out of sync with the part's
actual state. (This fix is similar to commit 0a0342ede303 which
concerned the tas2770 driver.)

Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 503bb7f8b729d3760194a6f6f6996ff6469c580f..6e91ad9229cad62860adc1f446fffc8872d32ca0 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -539,6 +539,8 @@ static uint8_t sn012776_bop_presets[] = {
 	0x06, 0x3e, 0x37, 0x30, 0xff, 0xe6
 };
 
+static const struct regmap_config tas2764_i2c_regmap;
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
@@ -552,6 +554,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	}
 
 	tas2764_reset(tas2764);
+	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
 		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0xff);

-- 
2.48.1


