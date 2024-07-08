Return-Path: <linux-kernel+bounces-244720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2492A871
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEB1F21E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE3314A08D;
	Mon,  8 Jul 2024 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UnL5EEnt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DCC1487ED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461196; cv=none; b=n14SQIoGeyAmPWIvjMMJNY4LHJIFtfi6DyJPiXtHkX6vVLOj7/1hLAB0/FUmNL1AxQKloi1TLwaxbCZ0pg1fWoONBetZ+jn3m8tmYB5HbJ+b7dLe5ydnbiVY4payZTLlTyamjpOPURt6pS8pp25X6los2N8myU1ivvdkvy577vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461196; c=relaxed/simple;
	bh=39EmKo6+oHW5UEs7Vadyrjy8hS/9NYPYOUNpwl73Ff4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX72+nD50FDB5N1Jr0zqp100Jh8HnGEVauyPC1q5M6IKkPgzakR7HVGOU9H4y76QD0jeFcFyWFFcvLtyx4JIT2gKbia4xXTZaunpWsaew3kiC3zoGA40QTeYfu8ybHTkRP+ZXbwIlNv+pthKPq1Fxxe/7GS5SeId3tkEaUE4ClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UnL5EEnt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb0d88fd25so27288495ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720461194; x=1721065994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9BjDRQX7kj+10HbtsCDkp5kJ5lKfYRGsbWpWcg95/M=;
        b=UnL5EEnt9LEgwd0WcsGA1ddQXX+kqPIhRTtnYp8Z8ilb9hLPDjJEz3dEFrUOFMd7RE
         0sDV7FaY8Tk/wDHStPqjwXDNMj0a8+KV2veLhh55OskOXOcNz93zAA4koOfGFcCqj7+r
         8GFupiDoaR88DJXhG/uQM6ZnPXLrj2CuuycSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461194; x=1721065994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9BjDRQX7kj+10HbtsCDkp5kJ5lKfYRGsbWpWcg95/M=;
        b=BThHrKuY2zMsVqbVk/Q2quFa4vlp/dm8eUWAdEwU0/gRikxgjQHDfwNttS0D9Hoq4U
         bp1QMf5dcG99RBR9HOPWalh4gXuFuxrSUj5HxDMHXkCmf5GPj4U3ZiUNQlZsV2pINrwl
         Chk90qbT3Lt3fE1ZKT3nrWZzX6GTKeIxbJ+bUkoB/s0zHeDurt9/hq0rALrGfqQZPpVG
         6CQvftcD8axCQf5+P4lg0clC/i9D9eyVsvL9KZD6sYwUU20OF46H3KJ1zvLaHXJsWilI
         4JH9BMF1OkyeWuqoe3Ph8EyFkuzgjvVMqTG53cleD6KyqQ9IopVtd7Ft9KIkAfZuRwgp
         g7XA==
X-Forwarded-Encrypted: i=1; AJvYcCURABdbvmrd3/G05jA1yqPxMs0hVhqoAWDXIUT0w/V/FH+PBdTkHssVeE6gtEBk0Ul4PEyu/re281Rx+su+kvUUsJ8uuRD59ABqEiPY
X-Gm-Message-State: AOJu0YyVtmgryExWTIrKKIJChlj3m7faQQ2eIZSxm+iA5wsjNVALXpzM
	qd5LoFzHXtdF7TV+G7lw1YXBUas7udY+0h7W3iso3c9PLvvGMe+l7msARLQAKg==
X-Google-Smtp-Source: AGHT+IHPFw3gZqk59xHeov3I6X4Z0L3gagGKfy7AhBoV0V+C3PC9P2uqs2UeYxrwQRh/JJc7gzOsvg==
X-Received: by 2002:a17:902:ce8a:b0:1fb:3263:2e60 with SMTP id d9443c01a7336-1fb37046126mr172139675ad.13.1720461194560;
        Mon, 08 Jul 2024 10:53:14 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:45f:e756:a603:fedf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a3132csm1415315ad.112.2024.07.08.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:53:13 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Thierry Reding <treding@nvidia.com>,
	kernel test robot <lkp@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: sharp-lq101r1sx01: Fixed reversed "if" in remove
Date: Mon,  8 Jul 2024 10:52:21 -0700
Message-ID: <20240708105221.1.I576751c661c7edb6b804dda405d10e2e71153e32@changeid>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d7d473d8464e ("drm/panel: sharp-lq101r1sx01: Don't call disable
at shutdown/remove") had a subtle bug. We should be calling
sharp_panel_del() when the "sharp" variable is non-NULL, not when it's
NULL. Fix.

Fixes: d7d473d8464e ("drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove")
Cc: Thierry Reding <treding@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202406261525.SkhtM3ZV-lkp@intel.com/
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index edc9425bb143..a0d76d588da1 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -362,7 +362,7 @@ static void sharp_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	/* only detach from host for the DSI-LINK2 interface */
-	if (!sharp)
+	if (sharp)
 		sharp_panel_del(sharp);
 }
 
-- 
2.45.2.803.g4e1b14247a-goog


