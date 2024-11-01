Return-Path: <linux-kernel+bounces-393008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F859B9ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FC0281CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3C1EABD5;
	Fri,  1 Nov 2024 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MNX2sM4b"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36121E7C2C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499443; cv=none; b=sZLHocXt+TjVN6x1jqe/k9YhbIdGpkGHOYYqC+uROP9duPb0vvWhkRvZ+xnfzLblm454dngJifgkeWdIhp+AZOmp4fQtFQF/3m5yu0xzC12XgF5BQ1mYlV2Ztp1WQYAeseOA75fZZZAlu6m4cQFmhDpRQQNZQOGJtaDC/2QXu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499443; c=relaxed/simple;
	bh=m1YPenGQkWl/zDdbYUdX2RWyx9UwmWv7bbCPVpnxn78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKNnDfnCfCx3weM/uLjP4WbfjSaTwh0u1untOV0MG0c1xqH8jsKuL4w+nlBkLNKdPuShMujS+Wqw6ZxybxylIjruyQrqCBAOyPbIa/4kOSGx5Oa5Oco26NbCAvQgh1kyCuck3pEfVdXhyV5NKcUeyS5qzCctMAbujVMlDXe/rrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MNX2sM4b; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71809fe188cso1244454a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730499441; x=1731104241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NG086UAVHhHYbTY4/rXpdjHhnow1FtKZ4XRiPy3fDw=;
        b=MNX2sM4bkazFk/vdMUJ5AXplFlPq8T0sNJGR9kfFrQn18u38jXHC7R8Xoiv0Dx6/nt
         5t7WDrPiYxyDKRCdkpGYorZR+hDws3idrpoUUB9zdIiCMCoqcmoilm8UfSSdMlwjj9nr
         FUrj+Hc00y5ML41t7km6XGMAfAamxctv+j4l4cqm1W7TW/E/URKhu224O6UW+8bMTvbl
         xTWg2OVxE1AEvuEnywCAZuVW1BkxXTC2c4lsgzCmlXSPeqZpR8Dr2y+Fm/hs3Y0aS0HS
         cs/uW7UtMaH0kb0vbT72Nmcb/CokP0te+jIb7NGDLLEKY2G7ZwRKa+kgPHgrkEo9cr6o
         Tx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499441; x=1731104241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NG086UAVHhHYbTY4/rXpdjHhnow1FtKZ4XRiPy3fDw=;
        b=Bm6RUDRi5jDWACYIah83WyoTZmxICmEIzqiMSff8G5k7DDfTjCUHYXbQ9ks7mk6LO5
         gQbk3Uh2ED+RJbd7flt6x4AU7PWjfk/1jeij5dYaRz0W0C0P44Uzam88xFYMuaB6vPwF
         +OqX8yEEUNsQpsrQvRQPmkxE5t80I9PmmB1R6OFUUaMWIc9r9CfxQHXaHZapxbWxH1ab
         kREX0JO5Xocn8JlgtATAa5HjWblUXysk3QCWRpvVvPRNJ0qx+rl9U98plz2X83N2Gmhl
         i8l/GYEldE6DB11QwKYG6yOfABdPXuV7f4MWAH93urpuZJ7C11X8D/sBcQD74Y2eqt5y
         Flvw==
X-Forwarded-Encrypted: i=1; AJvYcCV/5BYExK21zFmaWOwNpjcwU5CmppDT6TIjKVDgrl57dWKThFOlv32iZ9NHCCev4zOKFPWSbN7BcBdjhSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevGyO/iEIWSWb/kw0TqAl142JArr8XjamoBBOlzbSdPUVt59z
	QKxXVWGq5Ms/Fe96piXt6h6vcI5KDOcQwZmyh6fwsOBKL3n97pYBK7eu8Kg+5x8=
X-Google-Smtp-Source: AGHT+IGuiRggc/VEOXvy/hqc6GPaEDJwMTU6wKNAh5o/gkpRr3AvH9ZaGnzuQSPoyBxVCuiCZVBdfw==
X-Received: by 2002:a05:6830:4406:b0:718:8dc:a5e with SMTP id 46e09a7af769-7189b4df036mr6875600a34.9.1730499440886;
        Fri, 01 Nov 2024 15:17:20 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec70698049sm789817eaf.48.2024.11.01.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:17:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 01 Nov 2024 17:17:09 -0500
Subject: [PATCH 2/3] iio: accel: mma9553: use specialized event code macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-iio-fix-event-macro-use-v1-2-0000c5d09f6d@baylibre.com>
References: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
In-Reply-To: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using IIO_UNMOD_EVENT_CODE and IIO_MOD_EVENT_CODE
instead of IIO_EVENT_CODE.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/mma9553.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 43ba04c606a4..8536743a6886 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1031,9 +1031,9 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	if (ev_step_detect->enabled && (stepcnt != data->stepcnt)) {
 		data->stepcnt = stepcnt;
 		iio_push_event(indio_dev,
-			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-					      IIO_EV_DIR_NONE,
-					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_NONE),
 			       data->timestamp);
 	}
 
@@ -1042,20 +1042,18 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 		/* ev_activity can be NULL if activity == ACTIVITY_UNKNOWN */
 		if (ev_prev_activity && ev_prev_activity->enabled)
 			iio_push_event(indio_dev,
-				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-						    ev_prev_activity->info->mod,
-						    IIO_EV_DIR_FALLING,
-						    IIO_EV_TYPE_THRESH, 0, 0,
-						    0),
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+						ev_prev_activity->info->mod,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_FALLING),
 				       data->timestamp);
 
 		if (ev_activity && ev_activity->enabled)
 			iio_push_event(indio_dev,
-				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-						      ev_activity->info->mod,
-						      IIO_EV_DIR_RISING,
-						      IIO_EV_TYPE_THRESH, 0, 0,
-						      0),
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+							  ev_activity->info->mod,
+							  IIO_EV_TYPE_THRESH,
+							  IIO_EV_DIR_RISING),
 				       data->timestamp);
 	}
 	mutex_unlock(&data->mutex);

-- 
2.43.0


