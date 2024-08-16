Return-Path: <linux-kernel+bounces-289655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79619548CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8041F24B89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A019DF4F;
	Fri, 16 Aug 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iU3/pKSe"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C461B5820
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811528; cv=none; b=BlnB6MJ8/tbquqvbJEgv0JH73pUKb3VdbG2KNr3GuopXLmppnb/1d2RUPksg738lLsT1F41G3mUdOBVaG+N3oSVdjqHgYO1ZuMPn3YN+L59ulU5tFiC47siBcllwB9Ejg+8Zcy9nGqVYK9x5mmjL1AQhducsT5Q5akEVfEBEKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811528; c=relaxed/simple;
	bh=t0EHg6F/f2g7yIhpSYl+j42nBCmMMjiSjxuqYf5Mqqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMcw+QUUKC9KIez0zG/zlrCPVcATJcmztnsUujYWME/d9V6WbOIhn97lZWvo7GtcsfzZ0q3MWrFivfTf0R3jxoWZSvjOLL2Oy1DATn1gjeXJIasm00Uj72yu7Kf97QzmhowSqtDo9AXCffU7NPhNIx4xf4XlNqu/u8CSxIyJyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iU3/pKSe; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-709339c91f9so976924a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723811525; x=1724416325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTE0ZAwpLEek+mC97zOMxZoDXTrbmisRlZ9024oJ1x4=;
        b=iU3/pKSeL6Gv/q9j4X/OpEipj8b+fOJw5SfJQ0NcL7QsdxE4RiqYoJTQ7Ys+/M8ZU2
         C9SJ043k+nGp7UWlNVo8m6YmLHo49f/lWRDarhJ/XJMN8gKDhCsB+MHosCfyO9al/fJA
         X8xTartc/DoqoCINIRebDJRvkkIbVreItH77w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811525; x=1724416325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTE0ZAwpLEek+mC97zOMxZoDXTrbmisRlZ9024oJ1x4=;
        b=a/h7+bjxg5aKq8dCVAVNfNic3HwY6we8moSqq7YXicK80gCjrH4nkXeq6XFzU9/ay0
         8UsdrLUZExws+FoIUek5Kb1JTeMzR6Bm399qdS1qB/8PW6cgqgPNLHTCVWDIHmjjXAMg
         egGme1WgM2Gyc03E5WE87jXkyzlKrUFyXSLpi+NjZaVsnepY2g3gXMBzCpk0pV5ht9Wg
         wDaKva/ZyKaaDt+us/4ps3BNWgVdoGAD3KB/wApMz26XUTkzveBgQSZUtaFnjbtpkckc
         GHFazVIh/KiEx/TVuU8hpWZIDqWNDqJeW+euzIDoHrY1kESGQ/FBfF+Tf7FFkB2WZQrg
         ohww==
X-Forwarded-Encrypted: i=1; AJvYcCV+AFmpYphJQ7pvTE/iwY+CLxZO3eldFM16DUaNCLgCWMs/hNaY3koHsxdFunwSMYkVl4MKcR0aU/eJj8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsIeMmMRRcgUavxN5dDoam77c5G6J0pE01ZCHyD0++R4mQR4k
	D2SHBl5gU0zEKANizI4TNvODqzTxdDf3+aT79ovaJbpOk4u4Jt/zrssty9Ly4g==
X-Google-Smtp-Source: AGHT+IF/lV0FO6kyi+dWBfhad0hlEJtndvHJ5Sx3xQGXBIEu/XLpM3FeOaUjff8fbn0cH1v4QPeYnA==
X-Received: by 2002:a05:6830:3109:b0:709:3462:a4b6 with SMTP id 46e09a7af769-70cac84216fmr2835025a34.9.1723811525644;
        Fri, 16 Aug 2024 05:32:05 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3107sm16881426d6.121.2024.08.16.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:32:05 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 16 Aug 2024 12:32:01 +0000
Subject: [PATCH v2 3/6] media: i2c: s5c73m3: Move clk_prepare to its own
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-smatch-clock-v2-3-c63105db07e8@chromium.org>
References: <20240816-smatch-clock-v2-0-c63105db07e8@chromium.org>
In-Reply-To: <20240816-smatch-clock-v2-0-c63105db07e8@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Smatch is very confused by a clk_prepare_enable() being called in an
error-path. Fix this warning by moving the clk_prepare_enable() to its
own function.

drivers/media/i2c/s5c73m3/s5c73m3-core.c:1425 __s5c73m3_power_off() warn: 'state->clock' from clk_prepare_enable() not released on lines: 1425.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index e89e888f028e..7716dfe2b8c9 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -1392,6 +1392,16 @@ static int __s5c73m3_power_on(struct s5c73m3 *state)
 	return ret;
 }
 
+/*
+ * This function has been created just to avoid a smatch warning,
+ * please do not merge into __s5c73m3_power_off() until you have
+ * confirmed that it does not introduce a new warning.
+ */
+static void s5c73m3_enable_clk(struct s5c73m3 *state)
+{
+	clk_prepare_enable(state->clock);
+}
+
 static int __s5c73m3_power_off(struct s5c73m3 *state)
 {
 	int i, ret;
@@ -1421,7 +1431,8 @@ static int __s5c73m3_power_off(struct s5c73m3 *state)
 				 state->supplies[i].supply, r);
 	}
 
-	clk_prepare_enable(state->clock);
+	s5c73m3_enable_clk(state);
+
 	return ret;
 }
 

-- 
2.46.0.184.g6999bdac58-goog


