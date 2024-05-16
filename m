Return-Path: <linux-kernel+bounces-181262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCAD8C79B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D846B21210
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE514D452;
	Thu, 16 May 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxXZmyhp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638EA143895;
	Thu, 16 May 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874545; cv=none; b=lPtza/hVdAbN4Luf3PznHM1+fD8BVyRQzI1fIrVOKlw6XgYeg2nfGIUkX6/rfuCv7NSL03l9RIeqs1Uf4mHf6tzFbAbfZum31a55t6FgEztpD3mziHo7n+5T3A+ppu8UUmADmFQblw/zDp0CEiY3KofRy0ChGQo4o9s4r+LS8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874545; c=relaxed/simple;
	bh=TaCKIb+tOlae/OaZnCw4aoUwvzQ2N3Q/DzEajBzwE8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/tJtppE2Omt6b7cdpAPDWEP6bZSV7PytqyDuXNJn9XObCRAQ8wziQybeSaalh1PjP7xT/X28rsSWJ10G704DDfoupu4V8pzRlFSq3HyPexzN7iYvxus+/jAP1ohUVI9AYRVMEi5MMAkTOmvpLXISA5decbb4dB16/0Sh5byVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxXZmyhp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso3693988a12.3;
        Thu, 16 May 2024 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874543; x=1716479343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVGMf75YF+vt1t27uWnw5jAT2X3eMlVNjnjRhN5vWv4=;
        b=hxXZmyhpV8+/Gy/hU2Rqptf1VE2ZP57apPbg7oTaL/rVPOVZb9dSG0WkdQtzSV/Ucq
         httY5qTayTKJzzBhTWI+ODq8Cm4PWE+xcXIVMsaQRS+vu94tFGTbZT4CQiyEHrafuErp
         Ohwe6vAOE7EZllUfC7OgLFMQTwjP1wqvgYqWHNC9o6qkgfb2gALFmYuzl4C5xuMKd+rg
         ISnjvc+ccz0LiGJaxe+DaGTyegsywOu0kyX16ZXCLKnondrmtRTxhSJmOunTKagz0KXd
         0xdkTmHw6Dju2jNeV8Pq/9lne9rMKSmCgvn4AEijs0SNmWONVZG6RO6ls4qyybVjE4T9
         vo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874543; x=1716479343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVGMf75YF+vt1t27uWnw5jAT2X3eMlVNjnjRhN5vWv4=;
        b=NnYgKrMo0EeqkuoWjiuFFZ/4nnOTD0MtQdLI9XYHbkWn84iB73OLO5uaC3dIzIaSHd
         sVL0ixvIuSvQq/G2L60yOsLKvE6CIpZbuDskx3b6iYjKtZZCQIEAWXFBWozsi9PM1mMi
         2bGXDu8q817noGg09d6AHbvsxhg11R9/xF4k1vPsZW4TrdPWX29Wge4zBHAG6dtXeDX/
         ydIhasTHAR1eKKzyKfHOdz1/XZT9WGRe1tglPRjcl1sNmFr5Q78APWM4HeYeJWBjx1sI
         M12VYTxxerS6fyv4Fi4FSZ9jHJ3bnF6dL8wxhyOdmvdvV+mwfCkpqX6W9CuM2zjA6f3D
         r+5A==
X-Forwarded-Encrypted: i=1; AJvYcCXxdPYCJLnHAMTxZ/f1KcsmbsBTabzCvTldB81uOOoh8XiqcNn6jBlxPixdYfL+V9gICguUkj26UygIsALYCZUX0ZBK7/npM8xpkj3NqUET1eOlZUWXi5njJKaEXMj2SP9Tg4ndhhWj/Q==
X-Gm-Message-State: AOJu0YxrogXouSQKUfdYWek61GsGxCLXMOIyMkkMeB2X28Ug0P+56Lc1
	M3UYC768A7xzOnr3v/c3oXZHzQoqSf42w5A3Vdpi/fLF7dl3YE9R
X-Google-Smtp-Source: AGHT+IEOXzHhAeph+JwKQNsAh5vTm8beBoiALShHRSVjBXyTmqnOak4rMy3vcQIPzPH7/wuZU+EBQQ==
X-Received: by 2002:a50:d5dc:0:b0:56e:60d:9b16 with SMTP id 4fb4d7f45d1cf-5734d5974e6mr12980759a12.6.1715874542455;
        Thu, 16 May 2024 08:49:02 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574bcad0362sm7372766a12.20.2024.05.16.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:02 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v2 0/2] ASoC: codecs: add support for everest-semi es8311 codec
Date: Thu, 16 May 2024 17:43:29 +0200
Message-ID: <20240516154800.125284-1-matteomartelli3@gmail.com>
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
Changes in v2:
- dt-bindings: removed wrong es8311 schema file
- dt-bindings: added es8311 into existing es8316 schema file
- Link to v1: https://lore.kernel.org/all/20240510131238.1319333-1-matteomartelli3@gmail.com/
---
Matteo Martelli (2):
  ASoC: es8311: dt-bindings: add everest es8311 codec
  ASoC: codecs: es8311: add everest es8311 codec support

 .../bindings/sound/everest,es8311.yaml        |  52 +
 sound/soc/codecs/Kconfig                      |   4 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/es8311.c                     | 970 ++++++++++++++++++
 sound/soc/codecs/es8311.h                     | 162 +++
 5 files changed, 1190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8311.yaml
 create mode 100644 sound/soc/codecs/es8311.c
 create mode 100644 sound/soc/codecs/es8311.h
---
base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 

