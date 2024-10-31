Return-Path: <linux-kernel+bounces-390775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E39B7E61
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E22856D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741B1A01C4;
	Thu, 31 Oct 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oIgFdBSv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AF1A2554
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388436; cv=none; b=OZADqaC7tHzFQFd2P48qFQSQTDEx8B3ibeVGCQAQV2rK1qpyAkSNqegtwQYTLl8dmHX8HXHf9B4WTt/GAQpgjerGHyZhH6/c9U44gTAEjpd6P05p+xz+nun3JKNfY5PeGJrYRk9wSljHy5QGLoTA7dPh2wx0V0VdvNMlwWs8frQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388436; c=relaxed/simple;
	bh=yJ57w0VUTH3q0i2oLjf3xWbfCP6jGNPoSNnROEqxxw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rS4/xWFCFCBb/FrD2MowQKwL8X+mZ9ouFHPHqhkEE/H6m5iypJGNqAdSjnf8qy704BZ1W2fWqpScF86MZXXJlDNkYM+yoeyTnoU1cUX5D6X0enTD2pBmyT28qFFeR3A1Ldr/B334r6GEklZVgICZWBvNA6YKYBP9HC7CHOQXwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oIgFdBSv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so9521455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388433; x=1730993233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynbTz0mAIREWX9DSd8GtfjNx2HTiawNK3KErRQuBlPE=;
        b=oIgFdBSvUBVPwsxx773tttclxToNf3svk1jjsiVhqVOv8NEtNiQ4C09n9V1ybhygAF
         EyWsFPayHwAm/fe6RRzMiKL4wTraaRBM4ShN/h/TZb35w5YRTSapkl3mEJqsxkclxRe0
         YqlzQrqt0k6sDEDG56n8q9bEv5kVNDfJbltgdE+ml/guHc2r+6hcyJNNuvnqt4MPSBVM
         SjP2LQneJg5CAK0xqziLDPdmlxAOF5/BsHoxDo2O96aRIinrpi51iRD3P483s6DBVfGL
         wTkONBPBQNoS2fNZUjevLmMgLPVKuLghmWTEiHBvbdOyLSxb0va5X9wb5SDO11v0+Q7L
         MlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388433; x=1730993233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynbTz0mAIREWX9DSd8GtfjNx2HTiawNK3KErRQuBlPE=;
        b=JLVe/RnyDVRvW80daG/+szZ+CfhYQauGa/oXfs7B+OG4Tsw/HPEgBY9ULTjInlhZoD
         HmzQi2F4y9RsNp0/Nuxy5LlBHQeVL+aaqUxLjYE8p1s8tl+Q07CeZ4mPkfpG7D6NvLPe
         IH8faUC96NuW62K/29K4dEJQM4L0OyOmjdfRm5sMIegtuTXKwEKOUvIx/kgpCJAsSSJZ
         ZTsrOXufgeYOG4+DptcFOeEgQUmekKidGW24vhgd7KQeS/kF0F8qnaxjJBSrYaPlnC96
         m6svc8CC/S+T5d+AocqnPE6gmdwIWAX7xKf5Ze/5DEnvq4NJZYizDpMVxIv1rgSrUhaY
         JYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVldjOaFfHtWatMGx/acnl5DUKtilH2zPbA5DR23y0uGu6lxvGbn+mIUSbP1ej2RQiTtopIijAmMaOUx8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57uhZFoe13gK1DroNwD8pVrSTh7NkoR/3B4rdkmxktGJzP+5f
	tXhhYvekXSP4TyDzge9VgWZvaZPa2aETJUd8gibGkObMaLg45qpn1yqugN4kzhE=
X-Google-Smtp-Source: AGHT+IFcDhwM/WUu2euAD7a6xckHNF1ZKNFT/G1Ed5VwyVng6DCbMufZzTDi7LNt16ADIplrfYs/Hg==
X-Received: by 2002:a05:600c:4f04:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4327b6f9574mr33906995e9.1.1730388432612;
        Thu, 31 Oct 2024 08:27:12 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:12 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:00 +0100
Subject: [PATCH v2 05/15] iio: proximity: sx9500: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-5-2bcacbb517a2@baylibre.com>
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
 drivers/iio/proximity/sx9500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3f4eace05cfc6a4679fe82854dc059aa4a710d6d..e3da709424d5b2bd4e746df7adc4a4969e62f2a6 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -551,7 +551,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
-	if (state == 1) {
+	if (state) {
 		ret = sx9500_inc_chan_users(data, chan->channel);
 		if (ret < 0)
 			goto out_unlock;
@@ -571,7 +571,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 	goto out_unlock;
 
 out_undo_chan:
-	if (state == 1)
+	if (state)
 		sx9500_dec_chan_users(data, chan->channel);
 	else
 		sx9500_inc_chan_users(data, chan->channel);

-- 
2.47.0


