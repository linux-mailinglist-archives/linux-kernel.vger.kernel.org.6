Return-Path: <linux-kernel+bounces-379549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082149AE048
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38FC1F2318A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEDB1C07CD;
	Thu, 24 Oct 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1NmFT0VQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AE1B6D1B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761176; cv=none; b=kXnz1sC6JD+ToCT241Bz1arj40pH7rgKcGa+t6kEeDQScd5UjGULlb4qCq6kulEywHWVTkx9B17+tBDUkCj8Dn0ZCAEdxh44BIs8M4U186mZ39oXodcFZ41+aXcCX3HQfFGBlr/NTVLv3R4jKti3g1RNIfp/tUhrzOVzfxmQb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761176; c=relaxed/simple;
	bh=n6B+DjS2nlSaMuuYUonULXAepr11BX8wK2roVoPsJ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfHFarzw6sN0SKsZvatCydIXHxOnd/B4pLYQsJwNNRGgU1NC9Jbi+Fblc6x5IiLB+SL25w68d/ymUIoHlM4YVDHxEr7cRMEO3QG+HDX3NbPXe44ZJmtPQ2B15b2Ip0tmJ+KdwKOmKMZRaNrHMscbs/VDmXJ3+rBEXD7Av+hXqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1NmFT0VQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so8872245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761172; x=1730365972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPO7uddPmJGeRvDQ4DDNm675wgeGPQg+TX6wZtIY7Fc=;
        b=1NmFT0VQLB3HRxKOzIOz3k83izXhUrDPgdUuVCnisKTeieboFDcCb4p+7/VdFIblbZ
         mRyLklBao9aleVeR2yTyQ4bJE8+KOAb8JJRZG5krEpPWw9APxA2To09rjf43l7Du1/XX
         DgT+pBaT/bayqqVU32riMajVRrFG91Dd0tGo+Cr4CqsC7I1POL8OvCuClHN+JjyIdx3a
         V66rvF/7Arl05uqnwWt8KtQPyhQfTj0RmpH8xEyzHoTRRFACuUpOohx/fJoLP0bvH0Kh
         e/CBK/BOMUkek/uFj32IpjF0zL60jX8cvYOoaw+h4sRAH02Cn+4D5LH4maIBbcnQz213
         JvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761172; x=1730365972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPO7uddPmJGeRvDQ4DDNm675wgeGPQg+TX6wZtIY7Fc=;
        b=nij41+q9rff6z1WkvRJK4fhN44+Tw1ZZWeT0BXbxM/7ZTotsNWdocGpRs+sziXkBqF
         J0/uW8Imdup4FXfbfa4n9Hw78xUZOxIRvCNLYWJ8x19n5xvn4LdceYp6Ktkqu41c63a6
         iwheh9x3g3xYGFvL0GJufj5gxq8lax3Fn8YIlh3Z9h8oNUUGujZMnhVXyGIRVUroF6kD
         9Y87J4RoyvrPkcCNb0GYHTxmUTTWSo2v4p0EqUTi7pEhWUBkEyK8OXaflzPXyGxsbaPH
         LHKMbcJNACqBp/0wx4Pa9ml7w46kF6kzYkI+GCxxqm+5amVVxh/JwTNDe4j/SsWNDzDI
         xHiA==
X-Forwarded-Encrypted: i=1; AJvYcCX1eeSWPp2jwf4ylrpgPhkFPmcDPEUPwtQI/mjoFHx5Y4grrT86R3QTP/EsgwsWUjUf7i9PUpF5LkxXG/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4QbqLRcl93MZiONvsqOR/uDIaAazcOUm4dRe65kIB6PmQCMV
	1vgqUjmDq19TqVjojV8Ucc+SinBki+Ac2p4RgJcRqe6eY0Ymn3RoYTCfElLnBpk=
X-Google-Smtp-Source: AGHT+IGaN73d/bgLeVCGlsGNxd+TOv2AHPR97BWrXwTr3MwJBwZ4zF+VJDI71VQ8iFHk0s2jf5QZwA==
X-Received: by 2002:a5d:438d:0:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-37efcf06011mr4293964f8f.22.1729761171775;
        Thu, 24 Oct 2024 02:12:51 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:26 +0200
Subject: [PATCH 4/7] iio: light: veml6030: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-4-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/veml6030.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index d6f3b104b0e6be8e095a1ad9f20acb81ce492630..95751c1015909cd80543a559673f435d1a168f68 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -826,9 +826,6 @@ static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
 	int ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	if (state < 0 || state > 1)
-		return -EINVAL;
-
 	ret = veml6030_als_shut_down(data);
 	if (ret < 0) {
 		dev_err(&data->client->dev,

-- 
2.47.0


