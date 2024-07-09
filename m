Return-Path: <linux-kernel+bounces-245047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E991992AD87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777651F22309
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265742AA9;
	Tue,  9 Jul 2024 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W6CI5h3l"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E0376EC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487152; cv=none; b=OmXxhn4nhFKsBzCCDgCWD5GQqFlMdwG0gSbfoW6b+xg6ooqJtq/y5GMJg0Fo5iczmsHDbhLtzHH1KVEnw0zzv+K+/TBPBbKyGh7Uqq0YfT/9M1mc7bKmREuNeDXdvZ7XftSbDKlnHkDkqrBEYz8p3nlXVdjw38ZOM8XFb6kBbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487152; c=relaxed/simple;
	bh=zhXUxg9EOpmx0CiXmSG794sId4TJVZklA0dfYHPw/DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7xD+rcK21wFJ5Ak9eCq0RxrDoGFvznPFkuzrpnF81bPLVI9IQhf4ZBO6sKeoZI3FnSLJNioDSVH9UgTS4/P6f+PRScyDkYJ0RHvpF2aNrjzraaanPajJO66AKgzSkY5hjlW/GfW4flNPWXXZhe9g2vXE9GPRJQyLv4ffnSjCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W6CI5h3l; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9cc681ee7so1918528b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720487149; x=1721091949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxt6sRBunEAJdmr/SMQIrLMhyKmCuiWg3A5plz8J5+8=;
        b=W6CI5h3lC1KoLwMAZA9GskkbrMCdqI1bj+tEUVGG+jD4QocknpFzHYI8+SxnES9CCz
         FjgsILHtjKy2eYJBdUSeBM9voUQ5oW2W7V1XKYtvzmsaFuP4SJIyW/11lo8gQer8zPuw
         QY0+ntxDME93cMyG3zezbJ/eUL8JPqYRjioEFlQbtJagPlYOAcTF3J6j6nfGsempqHmK
         R0Ac8kWDhZNe5BQQO0vNX43umzSzxYuqlUdSAkhkZm7i/vT/Vm5zwhPUG54KEpQWA1PN
         XvB06ARd/L/fhjuh1kB7tm6UBJ2ABuwrVKEn9HD9DrygdE7JCXUiAgqbzE525KIJIHZ/
         DdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487149; x=1721091949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxt6sRBunEAJdmr/SMQIrLMhyKmCuiWg3A5plz8J5+8=;
        b=Rlm2K3O8/14BkCq+pVRARr1ByzccdPsNe6vPgJThI0M28LRDEbEa1s/KLCTzCgil9t
         M/cbYsGPY4krZLioiDeM2ml4qkpI28jwEZGLTXtZ71WsMDvUXtbFKn4KJybQ7Fb0wGGM
         P8Bko3su8oNR5OkvNyVL8axioHZYdQlimxN01ViXfZUNDClFbbcHxvcejL4dEOkXQTFg
         RKOWRepMRg3Mps9ldMx3ve5B0xM9F0hF5mK2l0qcfbudXmGqHSp4SP++Af1HaJoxakHy
         2fEf6UdoJ4KxbY75dtPfYc/pU8vCoeHoMR87VNj1hqqzlZrgPY7fMjNjUKFF0CR9AvDF
         uzGg==
X-Forwarded-Encrypted: i=1; AJvYcCViZW+aXc9TVqWKUCeyPtBrg44BP9c9E1VVyjYT8FzgAeExKXXq28fx7rd5EzwXw1SULRPL0yXsYlFh7rfNQ80xpeaXn0guqrOBgsyg
X-Gm-Message-State: AOJu0YzHEI4hTRDpeo6BFJbaWu6+uubt8q4U6uXLPowEySTbdXt6fbcH
	+MSHQ7Kh2Q9TFjgi00cTTu0ja25uCRKU2Tvrr+UXZAJvrBhZL44egdSZT4w3/ZghCO+aQS6pofx
	p
X-Google-Smtp-Source: AGHT+IFZVZrSxg89uP9Je/FmpgZThlv+Nr0TXf60j4XST0/pMpypzFZ30CE5rmjYzzIiFHdN2u8Dcg==
X-Received: by 2002:a05:6808:144f:b0:3d2:95f:da8c with SMTP id 5614622812f47-3d93c4931b3mr371575b6e.18.1720487148945;
        Mon, 08 Jul 2024 18:05:48 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff694sm215442b6e.3.2024.07.08.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:05:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: mux: set ctlr->bits_per_word_mask
Date: Mon,  8 Jul 2024 20:05:30 -0500
Message-ID: <20240708-spi-mux-fix-v1-3-6c8845193128@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
References: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Like other SPI controller flags, bits_per_word_mask may be used by a
peripheral driver, so it needs to reflect the capabilities of the
underlying controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index f4b619cc2657..c02c4204442f 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -158,6 +158,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	/* supported modes are the same as our parent's */
 	ctlr->mode_bits = spi->controller->mode_bits;
 	ctlr->flags = spi->controller->flags;
+	ctlr->bits_per_word_mask = spi->controller->bits_per_word_mask;
 	ctlr->transfer_one_message = spi_mux_transfer_one_message;
 	ctlr->setup = spi_mux_setup;
 	ctlr->num_chipselect = mux_control_states(priv->mux);

-- 
2.43.0


