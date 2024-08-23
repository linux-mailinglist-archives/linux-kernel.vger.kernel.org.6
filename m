Return-Path: <linux-kernel+bounces-299240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161295D1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02611F218B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378F18BBA2;
	Fri, 23 Aug 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUkCJBXu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CB1885BE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427799; cv=none; b=Gziex9UHkoA+ro0iUGBpQC1bUIsRGTM6uGF7Crf0bsQxy9R6oIW2jfCgRfaYBNt3w8BYF6uR5p+BpFJEyqyCP3ZpJEkBA7UvVJyEwgY42qtNmyahodCzBwHqt5JZqOSQvSub010s72HnaGZTDEIzImn92g0W24kPeQgz9S4SYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427799; c=relaxed/simple;
	bh=bmF/l1LbHdLeJhEhwamKHcjNbTSX7NoZJ8UiMeN7k2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVg7PAmMlb75tBljhtcObysRHpAWrWtRTfFgsC9p7nTYE+9zCgeRQFobWs2q8auk3pt/V275lr+E+j+dbZgxvfsX8xIaxw4ha9dviYqV9J7jcL1vsSZHAEXzf3eyNvRiNPk22oTCtcQxup1Ss6Et0UUgkUIGNfUwDCck8JLoPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SUkCJBXu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371a92d8c90so1058944f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427796; x=1725032596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBhWwm4oydvRBZ98sd3zd4gjG27RDsuzgB7f2d5Wo+0=;
        b=SUkCJBXuD2vzhMyFuuuJYkF2hiPDX69yMTOF6y7oVlrPa+QdXIXadtWOMPDeWgUFFB
         h53AWiDUblp2yZBB2qAzhwQCGjEtE1yns4x5R/e4xWaa1oyR6VLVJxQHjEwyxU92oy5N
         W0mrd022AsHMMu23PD35ZdJeuu46alnMrBBx6bFeUDfPk57XRYU1iBlm1RhggnLZduWM
         DIykJsOxhydAL0y5FCWqhBdsWyy9U/09VUwXzyYyMcJ9kVQrcZYKiGBfKclL9XcD8sJ6
         EdSLDRlLjo1OpzCRzy1YmUKIYWwtX6jB2UtuC1yZrA3dBVcsc74fF8kC7sg3FA/dG8Fq
         jFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427796; x=1725032596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBhWwm4oydvRBZ98sd3zd4gjG27RDsuzgB7f2d5Wo+0=;
        b=E/3iRfnrXv+whLnwDOkSBA+y9z5n7Tc2P+NeDen8FnxstfDcglv5zNNER0C/XJ7Rji
         YjknFSSuXAzWDG0U8MDSHlFVEdut7ITDx/nXCYXwZx1HeaqWTjc/RYS5L5aZ8/r0b0ql
         ACjB+UhEXxCj/I93cjYewBCnq8LGAGcmnbKu7uPauVMIUvP+ZGxLztacFyqB6mKpBdeC
         4g2zqu6fKLSCsKNDU4+i0MVuwMr2HR68fbaNJr0E3EQZ4C3bnfDFc2++zT5dsO01be3y
         JbavYDf0RFuUxmCIyIiYCtlgTvwr7hRW4LG1j8+Ol1L7ZYH6hP46cTe2jnvhHYSC50Ne
         4FlA==
X-Forwarded-Encrypted: i=1; AJvYcCUcU4nZKREOrMhtQZvg5bR4jt1EuUtOGPLIa0pU0hI4fgUBhPBG/trxwkvaObBhErfn1tsgOF+BHNRdZKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4acyZlnfG1bDZVN8zjOkyh5G+sYGUEqfIhVmoldAxbFR0dWN
	ZlAEmZcrjVjS/g1D1bh5UnDZjdgQBtC/XYSvg/qZBPyZDSTQvveXvJIdOhYH11Y=
X-Google-Smtp-Source: AGHT+IGz70GF2Iu66e2l7biNRmD2tbKn60KoDEtcX1G/RoEp/vFk39D56AkjZrEkceT8P0IZPwgJ4Q==
X-Received: by 2002:a05:6000:18c3:b0:371:a8a3:f97c with SMTP id ffacd0b85a97d-3731185234cmr1517567f8f.6.1724427795530;
        Fri, 23 Aug 2024 08:43:15 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5b8sm4395891f8f.85.2024.08.23.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:43:15 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Garcia?= <jgarcia@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 1/2] thermal/core: Use thermal_zone_device_param
Date: Fri, 23 Aug 2024 17:42:43 +0200
Message-ID: <20240823154245.1553458-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The function thermal_zone_device_register_*() have now a significant
number of parameters.

Simplify the parameters by extending the thermal_zone_device_param
structure with the parameters usually used when registering the
thermal zone.

With that change we have a simpler function:

     thermal_zone_device_register()

which can be reused in the different drivers and replace the
duplicate thermal_zone_device_register_with_trips() and
thermal_zone_device_register_tripless() functions.

Cc: Jérémie Garcia <jgarcia@baylibre.com>
Cc: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c |  9 +++++++
 include/linux/thermal.h        | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e6669aeda1ff..5869562caf9e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1390,6 +1390,15 @@ int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
+struct thermal_zone_device *thermal_zone_device_register(const char *type,
+							 const struct thermal_zone_params *tzp)
+{
+	return thermal_zone_device_register_with_trips(type, tzp->trips, tzp->num_trips,
+						       tzp->devdata, tzp->ops,
+						       tzp, tzp->passive_delay,
+						       tzp->polling_delay);
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b86ddca46b9e..1681b9ddd890 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -174,11 +174,45 @@ struct thermal_zone_params {
 	 * 		Used by thermal zone drivers.
 	 */
 	int slope;
+
 	/*
 	 * @offset:	offset of a linear temperature adjustment curve.
 	 * 		Used by thermal zone drivers (default 0).
 	 */
 	int offset;
+
+	/*
+	 * @trips:	a pointer to an array of thermal trips
+	 */
+	const struct thermal_trip *trips;
+
+	/*
+	 * @num_trips:	the number of trip points the thermal zone support
+	 */
+	int num_trips;
+
+	/*
+	 * @devdata:	private device data
+	 */
+	void *devdata;
+
+	/*
+	 * @ops:	standard thermal zone device callbacks
+	 */
+	const struct thermal_zone_device_ops *ops;
+
+	/*
+	 * @passive_delay:	number of milliseconds to wait between polls when
+	 *			performing passive cooling
+	 */
+	unsigned int passive_delay;
+
+	/*
+	 * @polling_delay:	number of milliseconds to wait between polls when checking
+	 *			whether trip points have been crossed (0 for interrupt
+	 *			driven systems)
+	 */
+	unsigned int polling_delay;
 };
 
 /* Function declarations */
@@ -218,6 +252,10 @@ void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
 #ifdef CONFIG_THERMAL
+
+struct thermal_zone_device *thermal_zone_device_register(const char *type,
+							 const struct thermal_zone_params *tzp);
+
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
 					const struct thermal_trip *trips,
@@ -281,6 +319,11 @@ int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
 #else
+static inline struct thermal_zone_device *thermal_zone_device_register(
+	const char *type,
+	const struct thermal_zone_params *tzp)
+{ return ERR_PTR(-ENODEV); }
+
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
 					const struct thermal_trip *trips,
-- 
2.43.0


