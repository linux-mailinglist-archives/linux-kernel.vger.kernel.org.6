Return-Path: <linux-kernel+bounces-340222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF0987023
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84637B25766
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4217C9B0;
	Thu, 26 Sep 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NOTlu3H1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684701AB6E4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342982; cv=none; b=IvtWgaAutuqAROu2WVI9ZSPB3tiZ8ozb+R5gXMTvIDckiK1UMEk+dtfKGhIwpiK0ubYWPNGwl3xBgGlD7VW/mPUNtoCfeMn6I32MuInYSRbRHh9LcsLfKaAGw9NFazVU/70Rai9giz4cQZISKgrjwJbOa7MlNK798PAEwiFf4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342982; c=relaxed/simple;
	bh=tceRt2G+y4WaDcfTHX1urDzTFuHzkPAJeqFAeugwTiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgrk+6cwfYOUhDhvsKQcJHkxkYDFK3LKgmDHecPs7lRTRxbDW3Zghtz+rPWyg2jfS9Nf69Le3JrWYpSUXgBjq22bCIOgV3dqOBg2SWQhJKdcJgWFljKPyJarB/v/HRuG/M5w7iOee7CdHrWku453jvNbpCk85eh4s8FPuxt4P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NOTlu3H1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2055136b612so8973865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727342981; x=1727947781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nTlJ8reywH+UC/jgM6J/PkAv8gFWsekGW6wrV9sFl8=;
        b=NOTlu3H1/ABJUOHh68V3Ts+/xP+L0PBvUa3yFO7HP1uVwmrL3po8ZASpvsN6I3SCeN
         UC6Aozkts/1LNpzay/P7phE2IMdXrz6esgMTN+sgl5+gBMoPVWVV0R4tsmwITVvef8Ur
         VN6hmsPtqF6rlrAo8wtue0peWAG+CKEVVts8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342981; x=1727947781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nTlJ8reywH+UC/jgM6J/PkAv8gFWsekGW6wrV9sFl8=;
        b=IVM/JG9Zo69qSPzKbv1N/RBg7k3vEUsegCb3xWhIxwSzlYEeyb3BOl/88rn9uc2wzc
         jnLoJiwp8EtcnDY4e+KIJK3kDyFQ6cN0TTwn7blwYf9lwT2stVI6nkm6pc0i/n9m5K1P
         5FyOBq6kWu6TrvO1FQ7HvbeQXgrrXS27HWb1LFe2NBZDlTNfhS+LAPbXwpJZo5MeBGWW
         29sRJumb9P6uCZ5Ui6SCZLQeKbhXGDDqJU8TU0qehBW/HRtWxKEBtSHPExM7hs+bmleU
         tnbYwIGrWa52pRY3aGnxiBz8W3oVAAnIB89oDAyso65MHiMIF5uNvRXvBaEnkmO5CFJQ
         LzHQ==
X-Gm-Message-State: AOJu0YzjDtUJpNJf9Wudz5ci2f8A35x1bmL5+621EzVdy/WKUQP02qi/
	d2HEyN41jZGWO1RtVORSrdRSyipnqSyErOuJ/r8EnqAtxzH7hUXo/pKVM7DqYw==
X-Google-Smtp-Source: AGHT+IEJGdzaJvD2oLJXYm0GdTv7+DhwanIXJf+yHPiigY6DhQrpoz5uhLKvyVCzsX1nrFaQy7M1XA==
X-Received: by 2002:a17:903:2bce:b0:206:a239:de67 with SMTP id d9443c01a7336-20afc435afamr79921955ad.18.1727342980725;
        Thu, 26 Sep 2024 02:29:40 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4234:cfaa:3b83:d75a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1720b00sm34819105ad.64.2024.09.26.02.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:29:40 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Xin Ji <xji@analogixsemi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 1/2] drm/bridge: anx7625: Drop EDID cache on bridge power off
Date: Thu, 26 Sep 2024 17:29:08 +0800
Message-ID: <20240926092931.3870342-2-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240926092931.3870342-1-treapking@chromium.org>
References: <20240926092931.3870342-1-treapking@chromium.org>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Changes in v2:
- Only drop the EDID cache for anx7625 when it's not in eDP mode
- Collect review tag

 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 88e4aa5830f3..5c6bd7be25c0 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2561,6 +2561,8 @@ static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
 	mutex_lock(&ctx->lock);
 
 	anx7625_stop_dp_work(ctx);
+	if (!ctx->pdata.panel_bridge)
+		anx7625_remove_edid(ctx);
 	anx7625_power_standby(ctx);
 
 	mutex_unlock(&ctx->lock);
-- 
2.46.0.792.g87dc391469-goog


