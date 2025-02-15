Return-Path: <linux-kernel+bounces-515807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10CA3694A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BDC1883EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F52A1BB;
	Sat, 15 Feb 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn23Mbon"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2B18B03;
	Sat, 15 Feb 2025 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577794; cv=none; b=QMg3j1jtJPuRu7wZByJfjGdMzyTP8ZRvNTLX5rzIx6zjuIOblwnr5TbhE41YwyRzXt8lDpcvg8K3czI0dDy/kiP5RwSbTzsQuK74ok/qOX7Cv3vdpvqnHhR5o/oy0XS/jTM0UnS8HpJarZShycIDWl/B3RykfdBQSFqfO+vq/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577794; c=relaxed/simple;
	bh=75ue9XmQyJ8qhP80PF/AOl1KCjY+SUIQzJSjEnRvCuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MZ0xdxcAT0dVExk0SZp3Jeb+DrleDMIuX36fK3msOl5QhBigIR0W5ZWq0mocx4GgThCg5uMkcwiSGgT5nVWJGufCf22BgViRs630ilxxy5nQpl7uFyCDWHZjVcs/c6qCVCC861SdtmYeVEhtbLe8+1luZ86F+np6dC8GtIi2r2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn23Mbon; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220f048c038so21024025ad.2;
        Fri, 14 Feb 2025 16:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577792; x=1740182592; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlljIDmRX1XH1IW3oY9g1rM7wniUPX9ut1iHFiQ3C7I=;
        b=Bn23MbonObpYsoZ2W/HbxH+Jm+kM4ZwZ4AI0XGwca4ugekWa3nVgS3mwwmGWOxV+F4
         cnWOo9LqlHEiZQ8rvDzfEyZZY3560f+f8bwjw9xpUQy8gG0UgcVpGirkH4Mkh5xkF/r4
         VqTRaIFXUkOtMBs+TPWNn6tAoQamdwGJfUuFhUv8iZ9ziJ/FgScOSTUMB9PMMW4WDct5
         aVPDwlmuvOl2g2bkjyYivXYhcTKW3DMxfStmmiXKQXU26LLL8guKaw5RtGYATEmytJrN
         g8JD3ruV0dIeQTs/Ok50Iigmf35sD/WCMiW7/TgiL2xokCudaXPdWHpw99DhcGa9DTvu
         6XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577792; x=1740182592;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlljIDmRX1XH1IW3oY9g1rM7wniUPX9ut1iHFiQ3C7I=;
        b=epyjSObyie4bZgJBnIoixUa/3GEXfpYwtrFPr42+kAtMmGMkRkQGZOYxF8HxqIX6GT
         vngZtQXHa6uyLc9Y97hRUm9LBDAeCJGkM+JOIldY6GCHac8TYNFrPCi3rda59Z9TioyK
         AAvss2JBkQRt8+T6i+HAmqU6ozj4YKL54A7T1Xc6g0GsYFBYfIJ7GVGETHb4hZi3S46U
         Fh+3tVyduqOTkw7o9tsAcCfLuc7ccXwo15X8DHqsCAj8wwrnISGCR1RGQP9p/sVztCNw
         tTHVPeG9y3yP1Q+TlHSnXGlVhVRaguWRyrSc4wlNHaX3UQT4kQCJufbumwzq0rZvFckQ
         NGrA==
X-Forwarded-Encrypted: i=1; AJvYcCVHcQyIynHODI4O5qIsfPyzRKpIIU0aVJASDXrzJTtSdLEjv8bHxqRaropgQXJfZYNadO22svLwgFzrMxM=@vger.kernel.org, AJvYcCVugfKqBGStOmJeuoCBT6UYSIzSemNjm3D3dgc7dVf++Tzwu8r1XGDlySeKiECh9egBedN6owqn544RAeJl@vger.kernel.org, AJvYcCXuDlX3E9AyypkeDGcS8sppCX35Jp0r0pLrsoUAHuzQDpCx0jVBQFSSFG4nJushpXCQyAK+4lyGH9/E@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgn77eT59VaL15w2qYiyKSo5XIsTejtkkCx3hrskI/QGQC4Ykk
	zDwcdKeSMXGB0qoIW2Rr1fAL7a/V4E7MKXnVXQjdM+Gp4cr9cYu/
X-Gm-Gg: ASbGncszDIwDi10AhSAIcec/T2ShPA/ro352t+7how5gKnbmBTTZGG+AD+bd117o8Xp
	XkD433x2Wdkofh73wn6XP2pD3CO64xFagOpWodpPhJUqCuVCGMGjpOK5SXg4wYWhdtAIZ0VwSzA
	bUvP5pfpKScuT8Z6hIOz1EBeNj+4ouU5VzCfeu9qH3SyV3nrGtXaLW2pBH97mQPthRIt9ZNIelu
	BOO3Klvj0L2AIP7c22ubnUbXB1FNow5x6QqlTzjJen7RtH6YIKn62NaetGqUi2hSz0PVC1G3+w2
	rAP7OLY7Hr3Wy1lniyx37X1/m4dGg9xoW/i8cbumFubgqeG6O1s4qVgtedGPRuJdkke+bz0nIZj
	p+XAx1SDYYA==
X-Google-Smtp-Source: AGHT+IEup2zgA/YTbycAj6IzspoC2++Jftu7jKLzx1hPV3+F+i7RaOUhB21dbPrRSyLCtfppm6LLiw==
X-Received: by 2002:a17:902:fc4e:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-22103f16d99mr19774315ad.14.1739577792063;
        Fri, 14 Feb 2025 16:03:12 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:11 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH 00/27] ASoC: tas27{64,70}: improve support for Apple codec
 variants
Date: Sat, 15 Feb 2025 10:02:33 +1000
Message-Id: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJnZr2cC/yWMQQqAIBQFryJ/3QcVddFVokXoqz5EiUIE0d2TW
 g7MzE0VRVCpVzcVnFLl2BuYTlFcp30BS2pMVluvrXE85byB45EQ+TcqBwQfUjSwLlErc8Es13c
 dxud5AZVWfeBlAAAA
X-Change-ID: 20250214-apple-codec-changes-6e656dc1e24d
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
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=75ue9XmQyJ8qhP80PF/AOl1KCjY+SUIQzJSjEnRvCuw=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb268Kpqxx+/WY2FLY4/4DzG3N+7VWbr5oo5UrpSnt
 YO5IrNzRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABPZeZyR4TDH5wyzDGvO3T3e
 s54v3XRAtLxbx1HiubkI94EDgnn3JjL8ld63WOZ3e2io9OOT6W9nn3zUsiMtesnuKy/PJ3UcfV4
 TyA0A
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Hi all,

This series introduces a number of changes to the drivers for
the Texas Instruments TAS2764 and TAS2770 amplifiers in order to
introduce (and improve in the case of TAS2770) support for the
variants of these amps found in Apple Silicon Macs.

Apple's variant of TAS2764 is known as SN012776, and as always with
Apple is a subtly incompatible variant with a number of quirks. It
is not publicly available. The TAS2770 variant is known as TAS5770L,
and does not require incompatible handling.

Much as with the Cirrus codec patches, I do not
expect that we will get any official acknowledgement that these parts
exist from TI, however I would be delighted to be proven wrong.

This series has been living in the downstream Asahi kernel tree[1]
for over two years, and has been tested by many thousands of users
by this point[2].

Regards,
James

[1] https://github.com/AsahiLinux/linux/tree/asahi-wip
[2] https://stats.asahilinux.org/

---
Hector Martin (14):
      ASoC: tas2764: Enable main IRQs
      ASoC: tas2764: Power up/down amp on mute ops
      ASoC: tas2764: Add SDZ regulator
      ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
      ASoC: tas2764: Mark SW_RESET as volatile
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Wait for ramp-down after shutdown
      ASoC: tas2770: Add SDZ regulator
      ASoC: tas2770: Power cycle amp on ISENSE/VSENSE change
      ASoC: tas2770: Add zero-fill and pull-down controls
      ASoC: tas2770: Support setting the PDM TX slot
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Set the SDOUT polarity correctly
      ASoC: tas2770: Set the SDOUT polarity correctly

James Calligeros (2):
      ASoC: dt-bindings: tas27xx: add compatible for SN012776
      ASoC: dt-bindings: tas2770: add compatible for TAS5770L

Martin Povišer (11):
      ASoC: tas2764: Extend driver to SN012776
      ASoC: tas2764: Add control concerning overcurrent events
      ASoC: tas2770: Factor out set_ivsense_slots
      ASoC: tas2770: Fix and redo I/V sense TDM slot setting logic
      ASoC: tas2764: Reinit cache on part reset
      ASoC: tas2764: Configure zeroing of SDOUT slots
      ASoC: tas2764: Apply Apple quirks
      ASoC: tas2764: Raise regmap range maximum
      ASoC: tas2770: Export 'die_temp' to sysfs
      ASoC: tas2764: Export 'die_temp' to sysfs
      ASoC: tas2764: Crop SDOUT zero-out mask based on BCLK ratio

 .../bindings/sound/ti,tas2770.yaml       |   1 +
 .../bindings/sound/ti,tas27xx.yaml       |   1 +
 sound/soc/codecs/Kconfig                 |   1 +
 sound/soc/codecs/tas2764-quirks.h        | 188 +++++++++++++++
 sound/soc/codecs/tas2764.c               | 302 +++++++++++++++++++++----
 sound/soc/codecs/tas2764.h               |  29 ++-
 sound/soc/codecs/tas2770.c               | 264 +++++++++++++++++----
 sound/soc/codecs/tas2770.h               |  20 ++
 8 files changed, 711 insertions(+), 95 deletions(-)
---
base-commit: cc7708ae5e2aab296203fcec774695fc9d995f48
change-id: 20250214-apple-codec-changes-6e656dc1e24d

Best regards,
-- 
James Calligeros <jcalligeros99@gmail.com>


