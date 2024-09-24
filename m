Return-Path: <linux-kernel+bounces-336520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E71C983BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3041F229B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B940879;
	Tue, 24 Sep 2024 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B56kVVHC"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA333EA83
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150005; cv=none; b=U8/HSuRLBLC84JsVZNLeVBTvT9ccsdp6sh7XlXpc9By6606LGWShSq7U7tyST1RcAKRzkMLNM5f33didkBNztzN0UPI73dp1CglpNFZaOlpGFnDLYaDasOcdD4CTMiH3XiozfKZWdfstzlYU4fGlZNT9r4oD0hpaL1pxhMvLvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150005; c=relaxed/simple;
	bh=iSAqQGIZodJwGsbb4FUO/Y4DNHUOBX1zdtXH4DlnWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt7soi2kqco8ps30Rke1Bl4TTcKrG1GMR8HNjHKvGLbOr/dlY01R6gLeu6I6AdHWgFF1Z5/AwYQFX2t+eilhPma/bFwhD3ksqnYL9ZeLSqppkzOiu+pzSN0astik6BbgvkbDv03FZ/0WbKsnnb2EzXuMmrJQpD98zyqzYBcLyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B56kVVHC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206b9455460so38305915ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727150003; x=1727754803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zn7NLLo5vu43wPcgUUT5FAE6ycLFHPC4WAcceh7PLg=;
        b=B56kVVHCHGUFnCoOwG+fpz0KAvDdI76yMnM0zR6V5IN4tjoU8XUzi6d/dUKSsSPrk6
         eb7bo1gc/EsLKDjBXxu/5KX7/+a/vGFkbgfJKh0uZ5rzA6uwpl/b3xw1hyEr4cukM+yS
         aUvPlDNlfSVRLHHeGK/5znXFGf9rV8MY50HHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727150003; x=1727754803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zn7NLLo5vu43wPcgUUT5FAE6ycLFHPC4WAcceh7PLg=;
        b=vTcBmbe2VyKTyXJH9CKh45jU9BrY1nTHU2UYg50DwSVEyyxlPgShxM1V9klf4Dk2pQ
         RDwn3kRR0S78iFE8uvgld09YiFwl6H8zNxqJ3mC1e2UQkvDdczDFf78ZUsiO8bV18qS0
         liJjXtbqGWnQ9ffO/gPiNvsw7AJh//xl3DIZPBb2na3uvuIqvRmRQDtixyFjb5klBX8J
         3e3QMBUWED12T2WefZJ1cMeIErqeUoHE7xaz68aOeHqbCfV6FGrBnPataEdfnEEj5Uji
         JPm8PY5v7WG4C2JnG0xmjwBx1K53eOzkCITb66yw0zlJJklIkOiy9++fnuC2Q9ERbAw4
         r35w==
X-Gm-Message-State: AOJu0Yz5cL0AoQWF4XIwI/Dx8SSqOALPIPQ9hHlkwKpqUK28i/dMs7+F
	lUweTj3pHKk/Jddh8t/pHlMHCKv232LdL3+6Jc1bZGt+yfgXH+rlawSSz7OD6w==
X-Google-Smtp-Source: AGHT+IFX6kIi8aI27QC+U0PJmuzc8q6Ze0ZE/jdApjgn9l0PmrsjgyTyMjAA5F8RaDDP42xYMp4DKA==
X-Received: by 2002:a17:903:1ca:b0:205:753e:e2e6 with SMTP id d9443c01a7336-20aed0c3544mr23884325ad.16.1727150003606;
        Mon, 23 Sep 2024 20:53:23 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:727c:308e:bfa8:9ccb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1869000sm2555335ad.307.2024.09.23.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:53:23 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Xin Ji <xji@analogixsemi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	Pin-yen Lin <treapking@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/2] drm/bridge: it6505: Drop EDID cache on bridge power off
Date: Tue, 24 Sep 2024 11:51:47 +0800
Message-ID: <20240924035231.1163670-3-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240924035231.1163670-1-treapking@chromium.org>
References: <20240924035231.1163670-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge might miss the display change events when it's powered off.
This happens when a user changes the external monitor when the system
is suspended and the embedded controller doesn't not wake AP up.

It's also observed that one DP-to-HDMI bridge doesn't work correctly
when there is no EDID read after it is powered on.

Drop the cache to force an EDID read after system resume to fix this.

Fixes: 11feaef69d0c ("drm/bridge: it6505: Add caching for EDID")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/gpu/drm/bridge/ite-it6505.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 1e1c06fdf206..bb449efac2f4 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3101,6 +3101,8 @@ static __maybe_unused int it6505_bridge_suspend(struct device *dev)
 {
 	struct it6505 *it6505 = dev_get_drvdata(dev);
 
+	it6505_remove_edid(it6505);
+
 	return it6505_poweroff(it6505);
 }
 
-- 
2.46.0.792.g87dc391469-goog


