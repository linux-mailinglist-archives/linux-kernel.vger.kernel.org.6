Return-Path: <linux-kernel+bounces-186510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B528CC516
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300A01C216BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0E7E57F;
	Wed, 22 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JguZ4ulF"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B531420D1;
	Wed, 22 May 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396512; cv=none; b=IdF5xRT+HHrJKI1+INmiB5g6kIKwceC9wpagicGXHexiD/AagHT5bJSPN4bf/viwGbVGx8D6X/kChGuv9I+8E4VR4ejlsY4xkqyiZNpa6uzV3JsEcoc0aabV69mqZi4xyutRwb7Fh/GEnhqIxD/j5GfURpb2PjNALDzcbudc0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396512; c=relaxed/simple;
	bh=jqaMzYloGJC1p36Hu/Ki1EJd/LTPfFtj7hWey5jm20M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RORXfuHLhNEcDYCi7V/rbVDazxcaZE2Wsb7FjkQx4524MMOz6MchOaOIV9xWXVoDLaxFJHyXVwJuxSA0rVDw3BAiyVky2X50qDVcmHxllnXiQTa6NYdvTM4yxJRArcCCmzcuFQXrP+58wIg4Lzw86Ox1FxlWw+Fsr5qvhs5Sb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JguZ4ulF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f174e316eso6268497e87.0;
        Wed, 22 May 2024 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716396509; x=1717001309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8C8W8zCXK+dAO5cwNPCwrKE66eqW6f105qpnTPFwu8o=;
        b=JguZ4ulFhPw7UmEF58iMc6TlUB19JroegETA+/d40PhtvuV3+rlHnvR8DhrftQrkQg
         MX+tG/qzD6ImIEnT9hvZBFxVhZX7QGn+JwpabqntuzeQ9+Li3GK8hV7dvYiwEXwunoxy
         mFb1vrB5YW22ViU6p0eyemYeNUJXd/HyzGEC16KWSYOLR80GZ8lZkR1bJTaTYALsW3o9
         /3WaDYnD6xDYGImLgkhCs4ebLzfinID2w8btukf4Ngsfc2BhZYUGcdcJdOxzVk2G68zl
         euhgU7G3QJTdKfyriK43cu0omyamVMX1sOmeLuuhVonP6V0XO3yuzVY2btURaLH38DAd
         JOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716396509; x=1717001309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C8W8zCXK+dAO5cwNPCwrKE66eqW6f105qpnTPFwu8o=;
        b=I0/DKqIelNHq3Yj2z4Za1/F38AhOeiAyjHgH/jhXGcGuG8/HamLnbAok+xqC73c4M7
         bE7MMDo++w9rymbo+ND37SWsEaS4xQgYc+oOsE498sl4khP0AYb1Uqv2zDf3sg9/ANa9
         /Ezf6KKN0NGloQjGRhK8F30zIpaCiSx1f1WFSxmTFy1QzUavHjwJ/pKHIbTvNzoJUDxW
         n3mFGt4ONxiTHFYoD880QsKAlmCiYMXZJmWLET5O8f2LH/ss/oIi1GliotS4MwVoc/kg
         tTS0afJxvH55Tw1MApJd0ejn4TI9Mv+tv+mc6P1Q8YObphpUvg5uI1xurb4b6LeQq5cy
         xeKg==
X-Forwarded-Encrypted: i=1; AJvYcCW70GvwVjXWeWXnotI8ERZzip0ceMnr5eJQ6aw6FyctOtxl2v+RX04qnQ7kNhn6ICbbTDi9N15470Emw9yYya6FnOOvHZiF9swDd57CAga1ZKE23qSkBz6E+JFCDohfyZ8OBM7EryanGw==
X-Gm-Message-State: AOJu0Yw7iRX+0a+O5kDOhJegHwzE/2/lh1a23Fzi4E29nr+ICWaZxUIa
	i6mtLCidjaf/sCg0MdAXe5w3OzHsyMkv0Gf2NJ3pje+FVvztZLeL
X-Google-Smtp-Source: AGHT+IGFLQQAPPpvRXfa9xhEU5F9dI5rhT/wm4s1J9CSmmHq4iONdEXYR41VSlkn5CpM3n/278Iu8w==
X-Received: by 2002:ac2:5986:0:b0:51a:c8bb:fcf7 with SMTP id 2adb3069b0e04-526bebb4cefmr1600047e87.3.1716396508382;
        Wed, 22 May 2024 09:48:28 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17733sm1797951766b.195.2024.05.22.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:48:28 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Daniel Drake <drake@endlessm.com>,
	Katsuhiro Suzuki <katsuhiro@katsuster.net>,
	Matteo Martelli <matteomartelli3@gmail.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ASoC: codecs: add support for everest-semi es8311 codec
Date: Wed, 22 May 2024 18:46:54 +0200
Message-ID: <20240522164722.954656-1-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds support for the Everest-semi ES8311 codec.

Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
interface and I2C control.

Implemented and tested most of the codec features, with few limitations
listed in the driver commit message. The test setup was composed of a
ESP32-LyraT-Mini board, which embeds the codec, connected via I2C and
I2S to a Raspberry Pi Zero W host board. Some tests were also performed
on a Pine64 A64 host board (e.g. to test the suspend/resume not
supported by the rpi). The codec driver was bound with the simple-card
driver running on kernel v6.9-rc7.
---
Changes in v3:
- Rebased on for-next of broonie/sound.git
- Link to v2: https://lore.kernel.org/all/20240516154800.125284-1-matteomartelli3@gmail.com/
Changes in v2:
- dt-bindings: removed wrong es8311 schema file
- dt-bindings: added es8311 into existing es8316 schema file
- Link to v1: https://lore.kernel.org/all/20240510131238.1319333-1-matteomartelli3@gmail.com/
---
Matteo Martelli (2):
  ASoC: es8311: dt-bindings: add everest es8311 codec
  ASoC: codecs: es8311: add everest es8311 codec support

 .../bindings/sound/everest,es8316.yaml        |   7 +-
 sound/soc/codecs/Kconfig                      |   4 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/es8311.c                     | 970 ++++++++++++++++++
 sound/soc/codecs/es8311.h                     | 162 +++
 5 files changed, 1143 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/es8311.c
 create mode 100644 sound/soc/codecs/es8311.h
---
base-commit: 47d09270d7776e46858a161f94b735640b2fb056
-- 

