Return-Path: <linux-kernel+bounces-390785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310649B7E74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A830B1F210DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BA1C9EDE;
	Thu, 31 Oct 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ksjhb90W"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3621C4617
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388446; cv=none; b=HZ1EuY5QsjZgTF2vpecHkDG7dkkkGaCoxsKBMNNith6zwybXu+/egjOewB12Vty98msYu65gDwrVzbbOQhuPHdRpOsHQ6j8kErKw8ATKeIETWU2u9qQDyHLtmrW0mIHb4034/3HDtGqgsMo+uzEskeCMLxg4q1fN79WrP6mvAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388446; c=relaxed/simple;
	bh=eZtGUx42EcD+JSWC+NT0I8Ira/ZgQWDva53H8CbTnwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rzAnQLp9brDGUwuc/jj0i7l5BcygZJozs5bpPYzAPMKSXgbiczLQARiO2Sfub0DmimX/EKFPOhfkEXxIC/C46T7rSKpE2dzZPkPaBeyaH49BaHPTPKVv+/cNcDqeYbBnQRe/wHMUjcBlNt2pmH5Ra5qSbMJ2jtn1dhwGXtX51sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ksjhb90W; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1350954e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388443; x=1730993243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eFpuHm2y8IhduDZB/M513Whn86C6+1mG/A5c4wAVb0=;
        b=Ksjhb90W9x9fcnb565brMFwWOzi05NnG3IldWok9uQvp5OMQI6xUmilMxBr4hgbQf1
         OLuYBIyBHptwCdCXVwNHXpatKzaLO3NYMFa2UuvYDVx/MdU0Xlk6kTywoEzxE+Elaskc
         PNJW5gjivvyL4jnuCYGwDl/qXWSeL3ME3iyG0flR4vpwY958+ywf687b96PJ/glD1Plg
         dHKH05dyoeg3AK9Ws7Xl4Bk/1fWJuaRgLJlbRF88B8PGjU4A/sg52MYZBV47h1AGL0OI
         qsZfJ4FDYX3z7133eTkeMjs86dLKL/IDbDPx+DqZQEGib3nfyUICEmvmCeTM/8qW5GIu
         q/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388443; x=1730993243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eFpuHm2y8IhduDZB/M513Whn86C6+1mG/A5c4wAVb0=;
        b=auqm3F5iBkOdD6nopFx8W6LnoD8uWpblqh3tyvkXIOA9FUR4aKgzgGcfOxHDce5T/X
         /JD3jX4I+UjiVFXH3PGcWwqPDF8YSd4/6SazVO6eHgqRCM2j6iILDNotIG8WenUwrj0G
         limrBqkcV4hbnDPtRfuclcmTqimrS8rIg+HLHfSBXLMPU0J5RST8zAlB9lA4VEOSQ99r
         BedTGuC+sAhFQie1RBKnIJcp42yNLYJZaRXlZ/Jgqk/lQeGVFJPtlzv+rqBKr0jmMLQp
         a1Olu6iHlkf0TZ9ok16lslxf8dAAfJwrb/MjZjuxMsmwHvKXtDELwHrrtnry75eovoHg
         jHVw==
X-Forwarded-Encrypted: i=1; AJvYcCXr8T0qeidSiUq6rICtK/tNZQJ5ifYcbPXnuTkx3+7t9fEIdiwjifEcjFUIANe2yk3+z5WOR2YZTU2jyLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtd0SejHVZ4EI2CJUFmntEDlfCC05Dp7/FpLZ5Ad8yL85FLg/4
	LoXOnQ/Zg2uCsX7q1DpSwW7dtzEwNNqbgeNvNwq31EvVLK62MNKrmRWC8FmHi1E=
X-Google-Smtp-Source: AGHT+IH9GtPIDfEpLZ8dUQUUPpUuX42GuH32Iyi1Pg0JcJazEapLSrEjVmA9nEmKnKLQDMdChJoKlg==
X-Received: by 2002:a05:6512:2341:b0:536:554a:24c2 with SMTP id 2adb3069b0e04-53b348c8978mr10450230e87.13.1730388442599;
        Thu, 31 Oct 2024 08:27:22 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:10 +0100
Subject: [PATCH v2 15/15] iio: light: apds9960: remove useless return
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-15-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
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

return 0 statement at the end of apds9960_read_event_config is useless.
Remove it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/apds9960.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 7b3da88885693c488807da459ceaa1cbb3881bcd..d30441d3370309fce9d6c717d42b829ff1db3174 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -749,8 +749,6 @@ static int apds9960_read_event_config(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static int apds9960_write_event_config(struct iio_dev *indio_dev,

-- 
2.47.0


