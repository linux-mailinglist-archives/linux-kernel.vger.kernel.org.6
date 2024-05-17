Return-Path: <linux-kernel+bounces-182644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38228C8DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F24285CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6D14198E;
	Fri, 17 May 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0uJCF4t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E921140386
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981859; cv=none; b=aiGUxrTGJA1AcTmR40VVhJdX7nD8wzQ9CnJIUTmBGSFFyXuzVN5OblW4wB6+RnaIE5l4BZ7xaXl5wUn0Jow/Zh2D/8Ex/d1GYjYgKVNz/jyk2hYClKkYR7LTE8QtOi6EmwkGXagH+cWDy40Gsn7GsaB0Yw/S4bTm3aammBn9kYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981859; c=relaxed/simple;
	bh=NFKnwk8YhaKiKsasz2Pc1QstgQ3vuU/bihNQbDltpio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my1qq0B3JXRe2ZLucKBoclMKRF/YRPGiEzP/dRpUQCbM/6rAgvJlkUP4dSwMu55Ehhw2+rr8n/90aXBPWTTMTBrzgSL9jYCacrUtWAAkLBgTtpYMF+PpTXxdZUKffcsiJQVTy17BDg0++WO9mE6XMSI2abeV0T8xfWe9FUQgnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L0uJCF4t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec486198b6so20808025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981857; x=1716586657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eNLlQcUGr08ustxm7tjWdAeIcGj6aFrRwLzzw2mxSA=;
        b=L0uJCF4tnJQTmB2oP9nepc7lJwa6ikUmwOzeasaArBqpimF8qvJHNLEM+dEMFo4JgG
         nNwMowETyyypstAhK9+oBbcqwYasj2rwemFser/XQImMwm4m0VWW2i1+/Ed5sL3JD04H
         a3cVFu404VQcf9KxoNphVUVQpm4VH74i1TwVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981857; x=1716586657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eNLlQcUGr08ustxm7tjWdAeIcGj6aFrRwLzzw2mxSA=;
        b=C542jcBNJFv8RiNFb1wor0LkWyqexuHOXAmjSFk8v4QMqtYtC8/j+Ow0WoJGxkk7sp
         ZlfORer2WjA07webil22+HK+hXP5MP0ddvuf0Q6GaZ/atd22w74No5fRYBrjP+42CQMS
         Rl5yjsqDl2k+Te3654fbbvzLd1ba2CFHJ+6zjpp913gdlKTRnKHDoNrHxtNYM41FY2ec
         /OcWcbcuBLLAzqjYJfVIRS6n0AlIxlls5EF4N/IlLKQv6ebeqf0cKKDd2UCkHEY8/2Qs
         o5lSBsleIYw0BmQ/OOU4Al5HYBC+MCn+Oq6ddsEe3AlltT72HFvjlKq5guyQvnG1qDPY
         NdOA==
X-Forwarded-Encrypted: i=1; AJvYcCXtkpb+V7qffRKVfMDgrNHtgBCzSzTYhOaURv1XFKbJ5f0zQ1v17LYiT3oORymgkmZmX2qgBoE8xGVdpavHdo3LsCQpX8BJ9lKsuByi
X-Gm-Message-State: AOJu0Yz5/JQJgkQM+gMh0LBQZf4HLxS0vC5E4jlhd1/UoXoEeHIArBD1
	lLpPO+e95YgD0DPUyKfaV3+kfvfuu2Vf320ilOaf8YBrV6Uu7hwGSY/4xsbySQ==
X-Google-Smtp-Source: AGHT+IGbq1YgMmj1OEV+ca51a5Lig67cuHTnRuhRUs861294NoqU+mz1Ch3XQAPqjZMe6AS7fFAHkQ==
X-Received: by 2002:a05:6a20:3d81:b0:1af:e649:6f4 with SMTP id adf61e73a8af0-1afe649086amr21555290637.57.1715981856849;
        Fri, 17 May 2024 14:37:36 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:36 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	=?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/panel: himax-hx8394: Handle errors from mipi_dsi_dcs_set_display_on() better
Date: Fri, 17 May 2024 14:36:36 -0700
Message-ID: <20240517143643.1.I0a6836fffd8d7620f353becb3df2370d2898f803@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mipi_dsi_dcs_set_display_on() returned an error then we'd store
that in the "ret" variable and jump to error handling. We'd then
attempt an orderly poweroff. Unfortunately we then blew away the value
stored in "ret". That means that if the orderly poweroff actually
worked then we're return 0 (no error) from hx8394_enable() even though
the panel wasn't enabled.

Fix this by not blowing away "ret".

Found by code inspection.

Fixes: 65dc9360f741 ("drm: panel: Add Himax HX8394 panel controller driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-himax-hx8394.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index ff0dc08b9829..cb9f46e853de 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -370,8 +370,7 @@ static int hx8394_enable(struct drm_panel *panel)
 
 sleep_in:
 	/* This will probably fail, but let's try orderly power off anyway. */
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (!ret)
+	if (!mipi_dsi_dcs_enter_sleep_mode(dsi))
 		msleep(50);
 
 	return ret;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


