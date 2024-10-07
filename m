Return-Path: <linux-kernel+bounces-353724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1770F9931C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45431F2305A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6F1D9679;
	Mon,  7 Oct 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WgL9y4oP"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1691D7E26
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315948; cv=none; b=iFQ1VQk4Wlxb96IV0H8JhQmHIqx22XF8dOhebaClxL+aYS9TRyUx4wh0NtGGNo4EkNizVP2/ZMsYz7HvHulRLvCuh0487X7aRbE6C6EImHz1081xYZcT67pCwOL606GPrH0QYmo+RU75zBrVHLxtjNs4uLOPd10vQbZYttvIUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315948; c=relaxed/simple;
	bh=adjIKONqQldQq+nYfRFYqYIa4peg7k+DD94EtLL12aY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gvqL/T6oR8/KvT2asGtL7IQPF2KYGdvD19sLJJe2UAE4P2cdKmnEwj9s8oX6sITgUYO5xeOYw2ewhEOJGj0Yrae0myegV/uwdSapA6guNQ6KrmDxdt7R73J+nuhiccYjg/r0uYtK1AqEdFA2ZKjMHWS/S8vyqL9ym1PUEusetyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WgL9y4oP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d1eda8c7cso916566f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315944; x=1728920744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IebLd9pybc2nbLozfLLDXz3gBz/LDqnDpQAr15l89v0=;
        b=WgL9y4oPhVU5CU2XRqENuOYDGZx91sIqy10aYAOdQfDY3RAKMGiNU7Z+r6hAaNpaWT
         bgTQQ6g4+JFyn/2PngLEMpYbJA2HBdleUsuHshZC8PnbBETWjvKic5YWoxOrz07E6lWi
         OUJTh9Ho6JniWBR948uP3g90DuziHpXZqqyhBHFGZqJQWiFnnKqfrAsNbsP1HYHaHlBN
         q/31zIW+++dp9XHheuFEhqRrSrEOD8LEwDjF9gGyFbmWVsiz1LWsl7IiUJ7AW/dVUUbS
         kS+ac37+K/SRbw+dhucBbKnF3KIm0r7HwlG8bEnBdmadJoqxZwGbCGuBmZW6aYtPujun
         d3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315944; x=1728920744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IebLd9pybc2nbLozfLLDXz3gBz/LDqnDpQAr15l89v0=;
        b=ug764RrKBlPs4mDxrFQsmJHJAokFLAbSSfO4bdAMxsjMc+hLj6DIxAI7PLLboSXAj1
         SbxNTHtM4rNfnRV6iDKJmNNg6XJok0Qg9y5ujDFP1+19o0LmUHIt3r2eIELIs62X3MqI
         XXj3G3EqOK2Z3d8aLD4iwPKjj7+VbMQkmd+BZ616wuN2/qrp8VGYIuJtyQR1WGvrF2u8
         9kIOYrFto2tZpEzm2fhqdexjRVH3RIBX+0lCPKsVExGuB+XKuhXovbHHpdHbNTGtAjuR
         0HI3drBCV/T5zW8Qq6Zac4aI014ivDoksc5+pQE3KUSazKkvox5ORd7HQ42edVZXhmIZ
         OQbg==
X-Forwarded-Encrypted: i=1; AJvYcCXZy11qC8doBmLJ+5logpgtR69XmjsUqM0gWQQSMLhdiJDRlC9FeGG9ZpXjH1dPez7b7wNVTj604S35+Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOY+2xF0iiqBzdIH6YgCfcxTQ0lsJimNy5E66/wVb8tNj7Zky
	UjJFbDFXKNd0bMuxtnkmKAgP0+uU0sXjYzau6Pl0g87lAD6wkf34eW+rsYxQECU=
X-Google-Smtp-Source: AGHT+IG4xZiJ9Dxrm/XmWrYjYFc2ltp0HZl/BJIa/shgIDu3Ewcr2gbsH0yy3XGYqB+hqg8efWUjYA==
X-Received: by 2002:adf:f306:0:b0:37c:d526:9bb0 with SMTP id ffacd0b85a97d-37d0e76575dmr6868032f8f.35.1728315944069;
        Mon, 07 Oct 2024 08:45:44 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:43 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/6] iio: adc: ad7380: fix several supplies issues
Date: Mon, 07 Oct 2024 17:45:43 +0200
Message-Id: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcCBGcC/x2MQQqAIBAAvxJ7bkGzMvpKdJDcaiFKlCIQ/97Sc
 RhmMiSKTAnGKkOkhxNfp4CuK1h2d26E7IWhUU2rlWrReWsGhSu/mO4QDonR9NaavlvWwTmQMkQ
 S/1+nuZQPlvh6lGUAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

Hello,

This series tries to fix several issues found on the ad7380 driver about
supplies:

- vcc and vlogic are required, but are not retrieved and enabled in the
probe function
- ad7380-4 is the only device from the family that does not have internal
reference and uses REFIN instead of REFIO for external reference.

driver, bindings, and doc are fixed accordingly

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (6):
      dt-bindings: iio: adc: ad7380: remove voltage reference for supplies
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
      iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7380: add missing supplies
      iio: adc: ad7380: fix supplies for ad7380-4
      docs: iio: ad7380: fix supply for ad7380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  32 +++--
 Documentation/iio/ad7380.rst                       |  13 +-
 drivers/iio/adc/ad7380.c                           | 136 ++++++++++++---------
 3 files changed, 110 insertions(+), 71 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241004-ad7380-fix-supplies-3677365cf8aa

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


