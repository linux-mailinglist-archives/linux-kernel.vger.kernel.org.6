Return-Path: <linux-kernel+bounces-443809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7179EFC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0097188C551
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD219C543;
	Thu, 12 Dec 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfo7eVSg"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A35189520
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030466; cv=none; b=rjafgQrrqwuL1k7wwTRpEWBZ78yO4jhl9Ah3hjtN16TD/8yBksH+/4r9l6MlWuZO9frA+kXb/TAax+aNl1VBSU6pqqwCqXRrD6ruh9aNLFmvjiYUTENYWBrbVNeEaQp5A8kG0ZCYo4X1DmZ9AtOthJB5a+E02y/qfy8FejenwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030466; c=relaxed/simple;
	bh=T7EmwOm+5QAq3VwZ2pscSRpuN5xU6tNaMs3NfT8sSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALwOAhjr9XzA3DvQJavsqWCbFzwp7eC/HJJGmzjxFkkmmSf7pwaeHjkaCKZzRBIIMeDA+dlGEjFDxUy0SlQ8+EqjmYc1+TkEIT2/PBGLYRudMBvhhVWHsuvdrrToX+xxWNExRCUa8R0SbakS8Ngry9Kw3KgbaAVajCh5+amCEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lfo7eVSg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863703258fso1288437f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734030462; x=1734635262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GlbsAVW8lCP//800lKz1P/SW6I5QfvrNa4yDeu8gbJA=;
        b=lfo7eVSgaGgorly8dVbXLz99l3P7dJlsgPRS5KvyCaOFAQxAEetsHrUlMUFF12cERz
         CRacdjdwocknMk/gBPR3p3HHJY7gpqgI6Je+PRqbTNi7YNuYDYkw1Ko5AoTby4bg0SiH
         X3+N3Tj8UzcBqvwyrwVw3P3vPk3O2Oc/jrnJzin1Iue4b+eO+6o9SGIAV1fq3MxZVeP7
         hAJGroOwsnm2d4OpnMEx2atChsUy3/gM9aJaCniaw0l5TQ4LhQrnlw+O/lQDx4iWkaG6
         q4KiWNrYaOtnQDV51O7dt1ifqmCh2/hIVhuz6nsQIT3mMQ0wORPTpGoqNhQ4b42llD2g
         CujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030462; x=1734635262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlbsAVW8lCP//800lKz1P/SW6I5QfvrNa4yDeu8gbJA=;
        b=bVVNkMNcjviWQBReoszCJkBr3A8kKqKHrZ0N5Y+k8is1+2gHt/OuQouQmLB4PejF0h
         uWjUB9i+7HPIeRmmBqhYwAaV7WXXYk8ZZPC4DYneqWeHIWJ2UnQh1Ta3mf98SnDBS+HM
         qqt0poNIzeocg2bxvVG3aJC70UmnfQaqvlys71TC4QJ4xPLoYi1uebvy9ZuNtiXvwF+W
         mgmTaWeelc7d7wROgME4t1MYEvp3kZp9ZW9+wxmG14jadKJvnQRDpJm6s+uIqPUqPG+K
         Hnzmby0qF6toXnd3DUMAt8kEEBB8E2o87L0B82usX+KjivMvBzzOzoPNf1vLO5oCkMsq
         RI0w==
X-Forwarded-Encrypted: i=1; AJvYcCWbBvC9+mT2llEzUleU9syk5Yv/CESI4TRZD8dIi/aVFKQsLN5rHn/yrLMZoHjU+xgwkuIG64j+KhXGyog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwCUwELFYvlAxicSdRyaruIMqHWhwDxLLE8XXyZRmcnnJ0Eg6
	pqomTQjGevMnQ4JKa8ujeiK5sVwmwZrKSqeLwaM0a9A/WdZnRUS1E1MLheBgh0c=
X-Gm-Gg: ASbGncvNWQYFocV7Yyve/RXHDc++noy9AWP7E/uOvE+N4FEBgoHl1EznxPju+oL7gRR
	xe/5bqSOe9oJh/TGU3GD6Jq5SGUphBPUTMdv9IW5paJABuZBtjZusEVyFjI9eDKTglYU4QS7HNv
	KgJbKF36f86aLujWw78uUJwpZp6+x+SBFu9vgUXiGNViSjtHeuhT07b9dast3t2CNVnMzhP5zGP
	+ufEZYJXpfmDRvml/vNhs7+2iC5dI45AHoSNCl9txur1OmeBaiP8IWl/EX18OYVef+vZRXY2vJE
	i0mRxlk=
X-Google-Smtp-Source: AGHT+IEMmb9t6PGdS5PoKr867mn9VHlZ8lICzDvFeUaKJtxwimOog2NMetPxeIcTVA8sTcncAD35Iw==
X-Received: by 2002:a05:6000:2ae:b0:386:3c93:70ff with SMTP id ffacd0b85a97d-387887df1a0mr3843306f8f.8.1734030462343;
        Thu, 12 Dec 2024 11:07:42 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bd990sm4834365f8f.46.2024.12.12.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:07:41 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/thresholds: Fix boundaries and detection routine
Date: Thu, 12 Dec 2024 20:07:36 +0100
Message-ID: <20241212190737.4127274-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation does not work if the thermal zone is
interrupt driven only.

The boundaries are not correctly checked and computed as it happens
only when the temperature is increasing or decreasing.

The problem arises because the routine to detect when we cross a
threshold is correlated with the computation of the boundaries. We
assume we have to recompute the boundaries when a threshold is crossed
but actually we should do that even if the it is not the case.

Mixing the boundaries computation and the threshold detection for the
sake of optimizing the routine is much more complex as it appears
intuitively and prone to errors.

This fix separates the boundaries computation and the threshold
crossing detection into different routines. The result is a code much
more simple to understand, thus easier to maintain.

The drawback is we browse the thresholds list several time but we can
consider that as neglictible because that happens when the temperature
is updated. There are certainly some aeras to improve in the
temperature update routine but it would be not adequate as this change
aims to fix the thresholds for v6.13.

Fixes: 445936f9e258 ("thermal: core: Add user thresholds support")
Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # rock5b, Lenovo x13s
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_thresholds.c | 68 +++++++++++++++-------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index d9b2a0bb44fc..dc2852721151 100644
--- a/drivers/thermal/thermal_thresholds.c
+++ b/drivers/thermal/thermal_thresholds.c
@@ -69,58 +69,60 @@ static struct user_threshold *__thermal_thresholds_find(const struct list_head *
 	return NULL;
 }
 
-static bool __thermal_threshold_is_crossed(struct user_threshold *threshold, int temperature,
-					   int last_temperature, int direction,
-					   int *low, int *high)
+static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
+					      int last_temperature)
 {
+	struct user_threshold *t;
 
-	if (temperature >= threshold->temperature) {
-		if (threshold->temperature > *low &&
-		    THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
-			*low = threshold->temperature;
+	list_for_each_entry(t, thresholds, list_node) {
 
-		if (last_temperature < threshold->temperature &&
-		    threshold->direction & direction)
-			return true;
-	} else {
-		if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
-		    & threshold->direction)
-			*high = threshold->temperature;
+		if (!(t->direction & THERMAL_THRESHOLD_WAY_UP))
+		    continue;
 
-		if (last_temperature >= threshold->temperature &&
-		    threshold->direction & direction)
+		if (temperature >= t->temperature &&
+		    last_temperature < t->temperature)
 			return true;
 	}
 
 	return false;
 }
 
-static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
-					      int last_temperature, int *low, int *high)
+static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
+					       int last_temperature)
 {
 	struct user_threshold *t;
 
-	list_for_each_entry(t, thresholds, list_node) {
-		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
-						   THERMAL_THRESHOLD_WAY_UP, low, high))
+	list_for_each_entry_reverse(t, thresholds, list_node) {
+
+		if (!(t->direction & THERMAL_THRESHOLD_WAY_DOWN))
+		    continue;
+
+		if (temperature < t->temperature &&
+		    last_temperature >= t->temperature)
 			return true;
 	}
 
 	return false;
 }
 
-static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
-					       int last_temperature, int *low, int *high)
+static void thermal_threshold_find_boundaries(struct list_head *thresholds, int temperature,
+					      int *low, int *high)
 {
 	struct user_threshold *t;
 
-	list_for_each_entry_reverse(t, thresholds, list_node) {
-		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
-						   THERMAL_THRESHOLD_WAY_DOWN, low, high))
-			return true;
+	list_for_each_entry(t, thresholds, list_node) {
+		if (temperature < t->temperature &&
+		    (t->direction & THERMAL_THRESHOLD_WAY_UP) &&
+		    *high > t->temperature)
+			*high = t->temperature;
 	}
 
-	return false;
+	list_for_each_entry_reverse(t, thresholds, list_node) {
+		if (temperature > t->temperature &&
+		    (t->direction & THERMAL_THRESHOLD_WAY_DOWN) &&
+		    *low < t->temperature)
+			*low = t->temperature;
+	}
 }
 
 void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
@@ -132,6 +134,8 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
 
 	lockdep_assert_held(&tz->lock);
 
+	thermal_threshold_find_boundaries(thresholds, temperature, low, high);
+
 	/*
 	 * We need a second update in order to detect a threshold being crossed
 	 */
@@ -151,12 +155,12 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
 	 * - decreased : thresholds are crossed the way down
 	 */
 	if (temperature > last_temperature) {
-		if (thermal_thresholds_handle_raising(thresholds, temperature,
-						      last_temperature, low, high))
+		if (thermal_thresholds_handle_raising(thresholds,
+						      temperature, last_temperature))
 			thermal_notify_threshold_up(tz);
 	} else {
-		if (thermal_thresholds_handle_dropping(thresholds, temperature,
-						       last_temperature, low, high))
+		if (thermal_thresholds_handle_dropping(thresholds,
+						       temperature, last_temperature))
 			thermal_notify_threshold_down(tz);
 	}
 }
-- 
2.43.0


