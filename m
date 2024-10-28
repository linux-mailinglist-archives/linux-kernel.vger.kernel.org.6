Return-Path: <linux-kernel+bounces-385451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EAB9B3755
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2492D281742
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85F1DF74A;
	Mon, 28 Oct 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC2AYRYF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856EA1DF269
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135211; cv=none; b=uWncB44hnnPxKdhYVRZcHOU9fmJy28CiNMQ/OCmtemekdMhHPn6+6eOoRFyvHI70plg7Ra3sVTassrCpB4fZVMWYOtu3LVNG3WySKb5YTXYGxOl4pgmtWZrc9DJ05f4tChKR150GVLhalHz8SdDce5KDmYLpDkr5xx6KrapyeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135211; c=relaxed/simple;
	bh=sGBArxVersbstljICqTdSnJ/96WvUJM3UavZUhrJjdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPZyRHSknek9j1ymC7IKTM1qrOnsJa/MuvZMCwRWIfI795T69BxZ/dBuBJDV4aNkc9r08ja2z9bHvOgyRqjG/9IzJwXibhY8ZHBv6qqB4M6Ckd07aiqZ5iqzlym7pro4d7S4EoJkZEq028volxnozlnCYdOfPQ8/sNB+AXVzsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC2AYRYF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3150206f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135207; x=1730740007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm5hKqutRtVQvCC9MS5vBGgI9yFrJ3Mk+QkNmCnD9/E=;
        b=EC2AYRYFdXFptYav+eNPXVXEVkNuIeFRm97namlZLRzbZNz6RzaAfUoAy8q4UYjhB8
         qczmv74FnufezaUvS15e4e/NyKoBKQLJRnNpQ0X4EmZUbshQ18170/D3JFBWCv2N/i+j
         VXt73zcuQzbeHzb76B+eCbKkEFZxnQc5Gu3JB3+6vVcS6y6s9WlvgnOATMZULSYRmFo2
         eQ28u3nA64XiRFF0ReLXT4pQgaE5waP0/A5eeg7KWEKOPodfCpYm0jVf791fjeuIjarO
         CbB4Bh6QtlfSoAF4FvTjyG+sCCh4CuThJkhKGX0fHnteghdDe1P0ihSx59o8ADaB7KVe
         YudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135207; x=1730740007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm5hKqutRtVQvCC9MS5vBGgI9yFrJ3Mk+QkNmCnD9/E=;
        b=wSd0sZpUIv68BxOi+efqphM3shLxxA9EQXo92UeV0Bnyy+l/iH9a9FCGTtt2fGIMzV
         IeJYo9xS3LZEWy+DMtzl6AHbLoCq7ATARhwOg0MLpE9YvGLbyrGrHqhB5ZOg8kqmkuC8
         Rx55qff09S7QpvJBYbhHV5BrpQ1JvBgWhsHByZ9w+RQOphRky03o/GFx5hY7YceUYLi2
         LUh0MXrcMGX3lUO7NGMeAVVyfhdDwwTYD5bDBOTqLLmz9VSqyACXUo9rNmm60ze5I2H2
         IvtMLa9LwqMUN8KOs+TXIuou6luYnsgrIahqgJexY1fT8OgWaCA7LVr/sS40m5Y2IMIl
         85Gg==
X-Gm-Message-State: AOJu0YxGtmUReQMGl8tJYwO3nYRYpImck8snsjV+hA/Vm6c91H5rcdLS
	QrVNvMNy6p8eaHwotbRILbnjDIIfRpjXx7YwxB7QOIs4pMzFOltktNtwcQ==
X-Google-Smtp-Source: AGHT+IHsjPiri0coXT6MHNA/rX9gGKsPP2NkkI5d6G1LyBN1HIpUgjHjNBNbfFpR7u9dqmGjfRFt6A==
X-Received: by 2002:adf:e28a:0:b0:37e:f8a1:596a with SMTP id ffacd0b85a97d-380610f4d3emr7007489f8f.3.1730135207207;
        Mon, 28 Oct 2024 10:06:47 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1323bsm10089732f8f.9.2024.10.28.10.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:06:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 18:06:43 +0100
Subject: [PATCH v2 2/2] clocksource/drivers/timer-ti-dm: automate
 device_node cleanup in dmtimer_percpu_quirk_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-timer-ti-dm-systimer-of_node_put-v2-2-e6b9a1b3fe67@gmail.com>
References: <20241028-timer-ti-dm-systimer-of_node_put-v2-0-e6b9a1b3fe67@gmail.com>
In-Reply-To: <20241028-timer-ti-dm-systimer-of_node_put-v2-0-e6b9a1b3fe67@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135203; l=1210;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=sGBArxVersbstljICqTdSnJ/96WvUJM3UavZUhrJjdM=;
 b=8ramxzmDzxPSEY1BZUw7Zq3nb9FouHrp6waafExkIyUhM1BX0DtjgOUofDHtcv5exDpyfoY4F
 rzvkMKloB8EDMPhQRIo4aBkoJI3CPkDzNaxfcx4brtE9x1T8tv2nmmk
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Simplify the code and make it more robust by automating the node release
when it goes out of scope.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 23be1d21ce21..d1c144d6f328 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -686,15 +686,13 @@ subsys_initcall(dmtimer_percpu_timer_startup);
 
 static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 {
-	struct device_node *arm_timer;
+	struct device_node *arm_timer __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 
-	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
-		of_node_put(arm_timer);
 		return 0;
 	}
-	of_node_put(arm_timer);
 
 	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);

-- 
2.43.0


