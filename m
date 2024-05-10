Return-Path: <linux-kernel+bounces-175813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D38C256F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1031F25C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30CF12C483;
	Fri, 10 May 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4RM06yW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED712C467;
	Fri, 10 May 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346788; cv=none; b=RoPJycZtrPDzto2vFdA3jNodiKp04iMQhdJ3smEPSkgZzcQGy8zrLLDvsnhN6CaT/xXGt6G7VqHOg0+MRcB6y20zKwqbYTDqOB8CdM3+UocvsDf8Rd5KzFeSuBS7V1SOG/SoJV7vwzvLJEjWZbgyDtrOu6LygR5fw1yBBiV2d3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346788; c=relaxed/simple;
	bh=quwH49lnHjzRFDaqGtfCyaHkqMkySDkqGB5yGE5eEcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPSZi0hLS3m31twzFKwwQwX3e+0e5UHNrUYO5o1AWJdO+vAQin9qJoN3shc078TJ1FW/XZVnhktuAS+I1AtU07nl/uYLw3yIcX8NxZ7krTgQnCVJ7cRZIrz53lri25wsrK7JByGdBPp7HVzJ7tP/nvrYqBttPGODohjQOLx05Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4RM06yW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fb14816f6so2534269e87.0;
        Fri, 10 May 2024 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715346784; x=1715951584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neD8kBMa+a8mByjSW095z/Jgzjs5CqZYPZVn+h9QyKM=;
        b=B4RM06yWHbhNKD+z+94EjBLi2+UK4EGzCPp4wjclsXw3EBGm0n/OUL9hqc/WKDveT9
         Pl6B+I4/TsuaktuX7t2Cc0TJRpcunS4IbCa69Ji4/26DFIRCc1rV/F90MFDzSL4xtE3f
         HuQnxX/l/Gm4YOyMQEElOuKXvdQFLCq+/dXym8Y5nZSbeHU1EbqHoAUOGZDokSxU7pok
         +FIcA6nhT74YvZZbddHraVApx9oOjsawc+cleMvDHQbo1w0Y9mlnAiZ7zRcmzBkJwByv
         2JW1fvNTHf7zmr00Lk2xvfOOEkJUhY5ATIDlsoSSyyEITb0TBgQF/9ewDa6IbneeVOZx
         lPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715346784; x=1715951584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neD8kBMa+a8mByjSW095z/Jgzjs5CqZYPZVn+h9QyKM=;
        b=SiPlN3pSpQkzJWUhS6UmaCnrWavLfa8Yp9XSFZ/S9yY489iDi50UQ9Wjkp202mU+1p
         IxvFgsaMq4finLN0AFpvjVG3rJDko3HKajwE8784Kj2oeOGPdS/ccCw40L/pfJQlf9Vr
         V+pUQB6bMzTjFscofRh62NZh997c98wa0s3q5f88pwuK/Xuftbua8SrS0MJbLarta546
         emH7lDa1umQyXtMJhpSAD4JZ1Ky6gMF6RVhmv95y6xXDIXODUzDPW3ZZoJWwSe5kbHOX
         NyVPgSzZzWtEQctRWwETGnBwXqUU+9xPC39TIP+fdmq9xvspEjkFkxy0T9hxvXLwi4oa
         FZcw==
X-Forwarded-Encrypted: i=1; AJvYcCV2FMuHrV32MMELT/w1PJnDSowy6uczZkOmwRv60cCSJ2EOas4RfY94fQn0E7UK4vjngJdhnJfHWgmnQcW8eW1xEbDbssYfCrOe1ThqxM7GDjJCNsWEYH2useXJbuirWGkRK5Lst2Pudg==
X-Gm-Message-State: AOJu0YwQXmYXqnvnmYfgIMdCnwJ5qq6XOahnUBXUZ8+uh1C7hEwONDUl
	JbI3dL0ePDE1h02HwtW4LkpbG1GoSUtbBmFYpJbhONZPIwkHiL+L
X-Google-Smtp-Source: AGHT+IGjdrz1sotzMq51gjCmOvNYzVwfzSwtbw4ybpXbIOEAnZb3TVbimikqGwdyXaeOz18/umfBrA==
X-Received: by 2002:a05:6512:47b:b0:51c:f00c:2243 with SMTP id 2adb3069b0e04-5220fc842e6mr1652677e87.35.1715346784221;
        Fri, 10 May 2024 06:13:04 -0700 (PDT)
Received: from localhost (host-79-55-54-147.retail.telecomitalia.it. [79.55.54.147])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a5a1781d350sm183515866b.23.2024.05.10.06.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 06:13:03 -0700 (PDT)
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
Subject: [PATCH 0/2] ASoC: codecs: add support for everest-semi es8311 codec
Date: Fri, 10 May 2024 15:00:12 +0200
Message-ID: <20240510131238.1319333-1-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.44.0
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


base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.44.0


