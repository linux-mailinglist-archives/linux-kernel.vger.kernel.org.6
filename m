Return-Path: <linux-kernel+bounces-208051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE1901FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561451C2157D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A17E0E9;
	Mon, 10 Jun 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xETDXGlT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777967AE5D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016635; cv=none; b=thgAmTcVZzPXhIy8wnu3RgPd+fWQk4MthDUQZ9YkBkTvJAhiJDG09K9ARsjfOKa5I5TxeEEaUkTgovepHNttpbF6eoZOq+Lee2d64F/1GzsMRGNk6uSkBnKdHx/wyAIABRdW9HHQBPTSSSRzotkcrUcuQ/FrfmO8lNQvd2/R+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016635; c=relaxed/simple;
	bh=Sg3ds86uJlZ9Fjh6Z62xIF+ArwgyRqSRqRnY79JLxqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vFn6qruD/bri4XqA9pCba96pdcUkvp8eOKQpkeVoI6qPGo/VK8yCr+cb3sUAAn4iM4D48iBcg1bjRblR9cpj3uwUjpARfpASRuLizkzwI/bpdPJ7qfujReP59cItoKeUjZFXkyqs1wSz0Q0v0oQCM8X60VbkLBOqFPEGp80NgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xETDXGlT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217136a74dso20710365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718016632; x=1718621432; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT5iagNMZP1SzTVgA+EQJW3bWeimBmBcx/H3HKT9wq8=;
        b=xETDXGlTTPRRYRDj7jynfP6htitalt739a50lE746PgOUn7x9qqwx4M7M4OffFLoN7
         gqD4XEeeTCxQmSQWcdTOKntME4uXfKnywE2+OsxT/04n/fxSvR+hDLF3QtFskVNJAnjN
         3I7LusEkvc7uWhZL4f3gLpc3BlMfBzztwrkAOog6EDI+in/d2y/jJT1rpVP2gJt7BJH/
         BuJ+UBgVKCfVCm3JUf0L5Y3w3Hn0ph6rE1dBhLUysyL8fZ3316QokAq1XXlJ0H0+lfhZ
         +QBzSQwYOZK+OI/wQ7UiqAN5ZCegLtZznWWn8smezf+K7Ntxa4gK2olStR3ZtGbUD58U
         HF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718016632; x=1718621432;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT5iagNMZP1SzTVgA+EQJW3bWeimBmBcx/H3HKT9wq8=;
        b=n/1QR9FioYb20jKARh9Lln9BiWMaHWI6mnrIMo+Op9sbx+Nb1vRIRW/DVvsfdMy4Hy
         fJPkaSrLQJK/G+5WDGlRmK8xyKJTHYGOhCM/Vn+cgjGKPYZigT3tVUfLGcqbar0EmIKk
         HRMl/8WnqoKi7LERcoKB01CTi2CvDqd7mlVkeVmBrnuyn+n/JzsUOBy7YzjKFdHL0tVD
         QRBTqmmilRgfFRS9UprqCeEgAW+xqk7K5v/a52Czwgszzh0SXQYt8BB02p5z7LlyDUSL
         yx8bSw0CoFCRlpQOl144ORvQtQngA4cfFYJaHPpJQaRdVCPlLEWA3cMd0CgwcJQflm0g
         PEQA==
X-Forwarded-Encrypted: i=1; AJvYcCWdz30o26omHnl6eOA4TiQNjWoHS5VI0xXf9lrnGtQXh7rb8ss9NF+4dnb38KZkjXA692+YitW8FLiJytM6cA9kggxducEjBTxXIGZP
X-Gm-Message-State: AOJu0YywWZhwA52SA7r5k779D7rmmNY9JGnQSACfmeXOpw7XMH/6Cmbh
	h4gcRdhXGWM9g/G7b+zgv/e61MemecOQ5rrDpPMH+lDebWGEMVhCua2cr8Xmfzs=
X-Google-Smtp-Source: AGHT+IHy2dL4U+D3GW1eATnAreZXXx7GxaYyjTMqfB6akQaoOCuuGo/C5XmhD72mhm8FU0n2CPVWnA==
X-Received: by 2002:a05:600c:1988:b0:421:63f7:7e13 with SMTP id 5b1f17b1804b1-42164a3aff5mr58486555e9.39.1718016631618;
        Mon, 10 Jun 2024 03:50:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2169fc45sm3270994f8f.10.2024.06.10.03.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:50:31 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:50:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] drm/bridge: it6505: remove unnecessary NULL checks
Message-ID: <6c8c6746-34e2-4a97-9dff-622ed29071e9@kili.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains correctly that the NULL checking isn't consistent:

    drivers/gpu/drm/bridge/ite-it6505.c:2583 it6505_poweron()
    error: we previously assumed 'pdata->pwr18' could be null
    (see line 2569)

These the ->pwr18 pointer is allocated during probe using the
devm_regulator_get() function.  If CONFIG_REGULATOR is disabled then,
yes, it can return NULL but in that case regulator_enable() and
disable() functions are no-ops so passing a NULL pointer is okay.

Smatch is correct that the NULL checks are inconsistent but the
fix is to delete the unnecessary NULL checking.  Do the same for
"pdata->ovdd" as well.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: In the first patch, I added a NULL check but that wasn't necessary
    or correct.

 drivers/gpu/drm/bridge/ite-it6505.c | 43 ++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 3f68c82888c2..d89d1bb9a8ec 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2566,24 +2566,21 @@ static int it6505_poweron(struct it6505 *it6505)
 		return 0;
 	}
 
-	if (pdata->pwr18) {
-		err = regulator_enable(pdata->pwr18);
-		if (err) {
-			DRM_DEV_DEBUG_DRIVER(dev, "Failed to enable VDD18: %d",
-					     err);
-			return err;
-		}
+	err = regulator_enable(pdata->pwr18);
+	if (err) {
+		DRM_DEV_DEBUG_DRIVER(dev, "Failed to enable VDD18: %d",
+				     err);
+		return err;
 	}
 
-	if (pdata->ovdd) {
-		/* time interval between IVDD and OVDD at least be 1ms */
-		usleep_range(1000, 2000);
-		err = regulator_enable(pdata->ovdd);
-		if (err) {
-			regulator_disable(pdata->pwr18);
-			return err;
-		}
+	/* time interval between IVDD and OVDD at least be 1ms */
+	usleep_range(1000, 2000);
+	err = regulator_enable(pdata->ovdd);
+	if (err) {
+		regulator_disable(pdata->pwr18);
+		return err;
 	}
+
 	/* time interval between OVDD and SYSRSTN at least be 10ms */
 	if (pdata->gpiod_reset) {
 		usleep_range(10000, 20000);
@@ -2618,17 +2615,13 @@ static int it6505_poweroff(struct it6505 *it6505)
 	if (pdata->gpiod_reset)
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 
-	if (pdata->pwr18) {
-		err = regulator_disable(pdata->pwr18);
-		if (err)
-			return err;
-	}
+	err = regulator_disable(pdata->pwr18);
+	if (err)
+		return err;
 
-	if (pdata->ovdd) {
-		err = regulator_disable(pdata->ovdd);
-		if (err)
-			return err;
-	}
+	err = regulator_disable(pdata->ovdd);
+	if (err)
+		return err;
 
 	it6505->powered = false;
 	it6505->sink_count = 0;
-- 
2.39.2


