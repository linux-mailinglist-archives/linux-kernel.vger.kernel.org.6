Return-Path: <linux-kernel+bounces-390773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2C39B7E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE951C212DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900A1AFB36;
	Thu, 31 Oct 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iZnpTdUo"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D31A2872
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388434; cv=none; b=S48bPqDAR7eTdsXwZoUHWniH01zg9joFiXE4yuZeXnUOnzRIhIkabF7oaDmdo2wjKBF3d7HWmLUHnhdMTedXFTFwbq++I+SlCnwZNQKgRNV3Fa2A4nZGyOoJvTnJ60MbTdpX0epQKNeUPBZGHLclBYUDgJJoKJfa1/KVQwohWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388434; c=relaxed/simple;
	bh=kZPeAfwjTX0nVtcMBAGwS+F+aIcqAWknmwxu7TyCEZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stAIrIJkLSqM9IMyewWPk4H4209QPBXLQS6jT2iRcuDczwXuPs1ClBMjyqF7o3M2iwTLtqgER9OzCMXjmk46CdDs/3Z6HI6FNg+7/27uJY3dCo8Tyxg7b3c4Ol+K1wH+gBA5VuGfcIcaEIRAIybMBaAy5NDml0JLtVDOsTILJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iZnpTdUo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1350725e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388431; x=1730993231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfayXnl3KgVE68uldd/53FtSQhtptu319uaFu0iSbt8=;
        b=iZnpTdUotOj6isFpfV6eOCGETfcxxQJO75xu7iXZHX8ECgHrgSaNtXQDTaNmpVEZv8
         5U/imwLPNsrWa+bPbbQN7JcgECKU1UAP0y0fT9VwP5GpsgctTstFwowMHusPDEU4ISuQ
         4tKqTvPUlZybOG6lwjR+imap//Frp3xQqJbgdODLX67eLmq/XSJtazKIPNKepQ/3S7Zi
         1r72ZqNYJvEFCJe+7VTduv+ioEO3kEzNnM/D4izbVg2UyJkyujFXNNlr3FvTAJLqu/iO
         WLqg3x/6VkYlDhQhveU1woVSOPhTuNXj057agW+gLrEJU3PnAjTD4YPwUwAS+PBJJysE
         uR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388431; x=1730993231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfayXnl3KgVE68uldd/53FtSQhtptu319uaFu0iSbt8=;
        b=PPX3VIJOKNqTgvtqYxVzCeqLQ58I51AqJymvCs/vbkI9GqMP+lx1wn2VGTqAv3Wpzo
         E7lxa5aHFP03WQeCWl1E0qvTE/Itjp1hBq2fCQOH8PuKLunLxGGeTKNGjNau+wa40nnq
         mPA7BtWS+wed89qP+hs7mxZcO579UXuZHwwhxpF5+DQYhg82pfmIa5Zaxosc3J5jZ+Fn
         Z3JA0BuMfWca7weBolM94MvYi3qYS2LjJ89CjBivbILWssfLHT/ve3SP93xA+WFxOqAQ
         l+cDaAah889kMSGMrMio6hDHTBSJkzR+FVNj0XN2vmrbQ1KqBP80Hgik2Dcm7SoPuRBf
         s5zA==
X-Forwarded-Encrypted: i=1; AJvYcCWAEZAP9RDLEk89R+JdtqOOY1bkfZ5246f8j9iXLlEf0ad1HKpVziJmQoDHV4zgCS+b2HXMj2IYtduxEvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfEN2n+YnqwKrM1TdD2GacPsI+veSbInjomPqBgS0WQ1lxE5Y
	IapVEH6wmxJPrssXW0xakLWTgnQek31sc8Trt0ZTBHXA4al8E2G9msYHNUn/iec=
X-Google-Smtp-Source: AGHT+IGh99tSGgSkk7UO/iFz05CAdTlnzxIFxRiRB1z7ObMWAVrMO/9RIhKBJVpF/cTnncS5M8FTQA==
X-Received: by 2002:a05:6512:2341:b0:536:554a:24c2 with SMTP id 2adb3069b0e04-53b348c8978mr10449686e87.13.1730388430582;
        Thu, 31 Oct 2024 08:27:10 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:10 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:26:58 +0100
Subject: [PATCH v2 03/15] iio: light: tsl2772: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-3-2bcacbb517a2@baylibre.com>
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
 drivers/iio/light/tsl2772.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index cab468a82b616a23394977da1d8822d29d8941d3..26082f239c4c3aeabfe73ed100d6e885f5266329 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1086,9 +1086,9 @@ static int tsl2772_write_interrupt_config(struct iio_dev *indio_dev,
 	struct tsl2772_chip *chip = iio_priv(indio_dev);
 
 	if (chan->type == IIO_INTENSITY)
-		chip->settings.als_interrupt_en = val ? true : false;
+		chip->settings.als_interrupt_en = val;
 	else
-		chip->settings.prox_interrupt_en = val ? true : false;
+		chip->settings.prox_interrupt_en = val;
 
 	return tsl2772_invoke_change(indio_dev);
 }

-- 
2.47.0


