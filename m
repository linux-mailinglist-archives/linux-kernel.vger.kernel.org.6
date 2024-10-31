Return-Path: <linux-kernel+bounces-390772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3EE9B7E58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029721F22368
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC731A705B;
	Thu, 31 Oct 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WGHDno72"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE61A01C4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388433; cv=none; b=p2VFQzg7OpcgK8XRMCIbxf6xrweRQzMQlzgNP5P7faAYYpK/L8cgy9BrpfWP3BQ1vjsjsoeP2NR/I3o4AVFk2v0pfpWKUuUsIxkRTBJsosntEWhWpkh6jCRMWiYKo7G3dY6GID+S8kYqCm9M+QnYQwDrAhJpYuKS11KVo5XNxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388433; c=relaxed/simple;
	bh=mCLydiA0KKmrbPKui9elDYVWFMJ0Mv3IrFxNpz1HNfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzKjtoFnpwazOmk2Vvm5vDRcmkIu3riv6AvzOhezHg48WO6sI88iTOa5hYEskY+tzR+XsMZLtB4Ypwnpq8yyaSGz6+gkFgHil4x5zauz7EKVn8IYCWthJN8q5Feo1dLPbrp2xPbkF6GtOWKWe3i5eHblpmmQFGAiKFw2oQGmvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WGHDno72; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so1256729e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388430; x=1730993230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eDKpTruMZP+IxXjbPpb2d8Qn7H2+5jIQszhP7gdxmg=;
        b=WGHDno72euIKFcMsbFXlr7hNQ1MZjakQIOy0jNMMnCVItknjymVECbmHDxQ4hSh3Ko
         CYlyYNlRZXr4lpQU2AaFlDTlgyw6ESwK45XaP93idcYt0ijIhUTHH5VBH+774Njqds0+
         Wfk1EJQsvz8MZxEiU29/1AxTryhsgNRxHQcJdMDdbzPSTehSorbuL+D7VmEfjFtdrwpk
         Glv8XhKA+HjnsXV6X4MqbsxK0PohwH3mGBDu9TmzSPVQ5dzKiCs4rZs3hiCa3DhNO1bY
         TPus4zxm2xGMC/Bm9t/hbssmeEuNrwZBIWP3M5GmPUrXcgL/WiMzLTsETPcLTjnSwMpL
         uz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388430; x=1730993230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eDKpTruMZP+IxXjbPpb2d8Qn7H2+5jIQszhP7gdxmg=;
        b=S3ezGwVihefbnnb4Nlilkaq7Qgd4o6UQcxidZ9s5ZO2fL91LTgiaMPNCqSdBLSWQxA
         c1SRHGntQBAEfP0tR8gHfY3V2Kw6dxo0sxuahI1OUukVz3mTvqNKa4zCLAV7fRXX8nmi
         kuDrm1cexP3kpil//ouDqykCUUnD3L8DOQ5HKcv7/029ObgTVW/Z911AMX/ahEqiAxu8
         xTsX/+/LnecmAZJkg8+Y/7P5URaIgs29OrKpWno6Y4X8I2rPUZOyPXCYWyZWwbVpCvaU
         hXJyFxZDONv8f8F432JTOcRF92IrZo6JsZa7b+uG/7rRbiIUSUFtgBi05lhZYphkRYjN
         K2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68sywSicAuILs22dFksRZGbloCXvY6aAhJtHkFvzUsjK0YdqaHqe1hiYBypeci01/4nSZAQJj9qAClcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvuVfSzWpG3zp3tWEwp6ex4n4wWkb95dCC2yIg7PQNjKL4P5yS
	/+PHBGphcKBduGJGMH0x9Ql8+12NwU8sBAzDRnGSFE+9LrewTIGpHEXwnB20W1Q=
X-Google-Smtp-Source: AGHT+IGjr93P1e7lz+9DxAcqNxw0ZM4hWmcWRfsYdyiLlzZAFmm8L5DUz7on0ZrmWR0iZ8h9Nc8dCg==
X-Received: by 2002:a05:6512:3ca2:b0:539:f699:bb29 with SMTP id 2adb3069b0e04-53b348c8d6fmr8574506e87.15.1730388429624;
        Thu, 31 Oct 2024 08:27:09 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:26:57 +0100
Subject: [PATCH v2 02/15] iio: proximity: hx9023s: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-2-2bcacbb517a2@baylibre.com>
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

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/proximity/hx9023s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index d8fb34060d3db88a3ba5ecdc209b14be8e42e8b9..38441b1ee040c7c26047b0cb2ac443ecb8396df3 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -879,7 +879,7 @@ static int hx9023s_write_event_config(struct iio_dev *indio_dev,
 	struct hx9023s_data *data = iio_priv(indio_dev);
 
 	if (test_bit(chan->channel, &data->chan_in_use)) {
-		hx9023s_ch_en(data, chan->channel, !!state);
+		hx9023s_ch_en(data, chan->channel, state);
 		__assign_bit(chan->channel, &data->chan_event,
 			     data->ch_data[chan->channel].enable);
 	}

-- 
2.47.0


