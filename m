Return-Path: <linux-kernel+bounces-303687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB669613BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFC51C230E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB41CCB33;
	Tue, 27 Aug 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ARYBtGbl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D11C8FBB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775169; cv=none; b=X3eNxDSN8yiztcKqbBwrhLManYm6lsbhP/F4Pkf6FsEhTniNXznBxYY2JadDdPAmf6a/W5rcIaZXxnqstBIKRV6HebEFuF3j+iVZvKxJG9mSKr7WI1n5bpdCMcOhhYY63NHAvcdRKYTGciLygXI/MwThy8q50CqzJZm7dVfJW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775169; c=relaxed/simple;
	bh=N8froPt0rJm37xZps7WUT3OjhzdTevZM8gVoMLQJN3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VA0iVxn6+vPxq7WzcLtZKOMdL+Mead5aPqQSiVM1e1l/I7y1O4/wPEEOY+hXZ7pMFwMaZIFrmP9Ys+Co8yLtyyGo5fK2TPwvLcmhFejqXrSAY+pC68EH36LCydQgSrk2BKrwZh4ksUs6dHnPFYlEThipl4sRd5+8Vbgt97EEhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ARYBtGbl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8682bb5e79so755171866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724775165; x=1725379965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41QfeVXp3bRAaO6YVHwo1Hn8U4dlul/y2Bh2kt4jOQ0=;
        b=ARYBtGbloht3pSwNrFiUaLVV/UoUyYU8kJ44u49tNoUoa6j8f2Cpq11BG6fOth+l0X
         1ZCMlOqhH0eVpkZrCpoJvevEH0hqynYY3/f9AKWFwi3B7LqKMkz3ZZv+A8UuOlTVLT2B
         wTPK5nOm0WsVbpYBDiZI4Q/gx6IKup4iE3Te070J64RC79x3g0oy+UxykNY3zynTBx4i
         wCQjWDIjdE8nCssZpShu2/FYZqFh+L3HBi1QcxJc8ixbfqf2NwKsJGghi9z7DbNaDTnQ
         LJER1K62Wyvsmj+V87ZFCjhpWF/7n2qKhMpmpZ4NOi7HoVg3AbLq+aySRhF70qCX0Aen
         XmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775165; x=1725379965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41QfeVXp3bRAaO6YVHwo1Hn8U4dlul/y2Bh2kt4jOQ0=;
        b=TyB+msLrl1jzHEmHqV95fHkn5Hg4Jd+f+isDfjAJEi5LkTIjle9zOHGIiLusi8si/F
         6ESYQCpzvA2PYA7+Z4mCK5L3EmtFJVlqbM53IEMWEPOmhDG13e5kAWIjCJpgxdweJbBC
         OO9fWHpASQN7Yvnqq2HHqn8GtkOrosHhC+9dsN84Ef7I7FhsYQ/bbEK0Rif71V/G4guw
         ecG2/NPGM+kGEtk1lMj1jdGFO6TWg0ng6BGgxrvILWyvZVyP5k8NO2In6ebNYC7F7LLY
         ee856tapvs3acsFiLhYejQm4o95zWfgpwBvSZ/cVehAEU8mxZUM33uTKiFe8kwtSibSm
         Kphw==
X-Forwarded-Encrypted: i=1; AJvYcCUWMBMu7KH+0q3uxT5dyx7RiNnyWCMkdUobdF5TOjy7bb50QuXafAl9rAI7jNgwz/3okwbFV6c5t+CItUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Mfvp+JXkArlP1XH6/vOYVW/MerIdf5W0rIj7MwXqYEK0l0q/
	S7zx7IPjFGDpJ8LREeXWl8ZrAGBvRpmESaxE2/obnlU36tnCN4wWPKfY5p8EZJg=
X-Google-Smtp-Source: AGHT+IF7Sm59AQfRh7cKuFyeiTLq5Ik6e0LG6qqZKMbHSfWuyELRqfPU3FbNqtC11ZbZBKOAMALa8w==
X-Received: by 2002:a17:907:971d:b0:a77:eb34:3b4e with SMTP id a640c23a62f3a-a86a518b26amr1091013566b.7.1724775165553;
        Tue, 27 Aug 2024 09:12:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm127893966b.93.2024.08.27.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:12:45 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: manikandan.m@microchip.com,
	dharma.b@microchip.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hari.prasathge@microchip.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 1/3] drm/bridge: microchip-lvds: Revert clk_prepare_enable() in case of failure
Date: Tue, 27 Aug 2024 19:12:21 +0300
Message-Id: <20240827161223.4152195-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
References: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case pm_runtime_get_sync() fails the clock remains enabled. Disable
it to save power on this failure scenario.

Fixes: 179b0769fc5f ("drm/bridge: add lvds controller support for sam9x7")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/gpu/drm/bridge/microchip-lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
index b8313dad6072..027292ab0197 100644
--- a/drivers/gpu/drm/bridge/microchip-lvds.c
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -125,6 +125,7 @@ static void mchp_lvds_enable(struct drm_bridge *bridge)
 
 	ret = pm_runtime_get_sync(lvds->dev);
 	if (ret < 0) {
+		clk_disable_unprepare(lvds->pclk);
 		dev_err(lvds->dev, "failed to get pm runtime: %d\n", ret);
 		return;
 	}
-- 
2.39.2


