Return-Path: <linux-kernel+bounces-336519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0E983BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D731F228DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434738394;
	Tue, 24 Sep 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKou1ZkB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CB288D1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150002; cv=none; b=A5KhVxi8AgvF7ht5xwdWVaT99cn4GTzg6OOvv7hv/DsPboXFjlBUSD+ADa0tpfo4lf0OfMuRoY0ph/9BKkdBVY+tWc//y2OCZftvZnx/VjwRa/R3iktvaRcuJ9QdCPb+MK7+bHtWsP8pf3TyvjWryboY88jcJjqwMgk5NYclZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150002; c=relaxed/simple;
	bh=/3j/pCpq28nZN3hquW2t86gJEd13fvuVOsnYqEE8W14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ7XdkZIIrYHbZz9u4GB75bs8doaaSNKXSgOmFBSxoHgYGaGnAU24hdaJKCbtenfc13//Ndqmz015c8yv07GKZWxtdbetYNDqRDioWRYT20wWVhtXhMLMv+JA6AXw3FFZjz/aqaSZTegLZHTBb60BYBGDQwv/FW+wT//zuay7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RKou1ZkB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2054e22ce3fso49892045ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727150000; x=1727754800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4JDPhYLX8gOFX6qvDK3s7d/UNCPkxhxheW4+MaLpxU=;
        b=RKou1ZkBRXX6qzPUAr3Zt0mcvV/iIVD50qjivH2NITd9m3LQG5SvEldD6H1IodT23n
         S6wsKsIns4lL5PCzqcKE2SO96Cn+2qkizbDWz9UAZu6zifQpIhxAd7RvCaUI2weFYGrF
         +WMyQh9tB02p2jp7zLAJWQ5neXCiVKQyBic3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727150000; x=1727754800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4JDPhYLX8gOFX6qvDK3s7d/UNCPkxhxheW4+MaLpxU=;
        b=dbL1bixEpCnVnT9/5EMEzjEspPvDyPfYhVI5mktuyJtsbld2Fxw4yyIAR6PWueRs73
         /bWecTy5uR+oYPRgGmC3+NJlMfol4dmbmDkfGIXGTruhWYfSauKYF1mknCNonSi31w84
         etAgDTFUAMQ5XRDoj1V0W5X1Ifhk2rRrGg01+RyM0YfyhIrqjnHjOTjVxanajrkzhtdJ
         +vK4WGQbVSSZXjXqxJoMYdIAO6THbY3HBgSChlYS0KoqrjlCN8NPLOnNxTdsmCIwgP7U
         qGBgxJBwpsQ9mW0+k7mACVikoWv69RXcx5pNWt4bTj041CYgAwMmBd3e0BSvQpc/DBWV
         UtYg==
X-Gm-Message-State: AOJu0Ywn+w+jwrGQGuY6/fEKEpg70MbzwMMaHEl56HTuTet2FW0WkPXS
	Nuijo67D+BXK5fXOIBMgyFARzDeHsCveWVuA8kRxpdNguPuUPZ8i932/qkgVOQ==
X-Google-Smtp-Source: AGHT+IFLuTTEL04yCULpYt8EVG3MEuP3tIFneXOCV6K0qCW5+TTc6vxsM21BR/5fxrk7lOFKauUFCg==
X-Received: by 2002:a17:902:ec88:b0:206:91e7:ba98 with SMTP id d9443c01a7336-208d8408162mr193275135ad.50.1727149999914;
        Mon, 23 Sep 2024 20:53:19 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:727c:308e:bfa8:9ccb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1869000sm2555335ad.307.2024.09.23.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:53:19 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/bridge: anx7625: Drop EDID cache on bridge power off
Date: Tue, 24 Sep 2024 11:51:46 +0800
Message-ID: <20240924035231.1163670-2-treapking@chromium.org>
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

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 88e4aa5830f3..b4c1f00f1c3d 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2561,6 +2561,7 @@ static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
 	mutex_lock(&ctx->lock);
 
 	anx7625_stop_dp_work(ctx);
+	anx7625_remove_edid(ctx);
 	anx7625_power_standby(ctx);
 
 	mutex_unlock(&ctx->lock);
-- 
2.46.0.792.g87dc391469-goog


