Return-Path: <linux-kernel+bounces-201590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C428FC088
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B41F21934
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF7125CC;
	Wed,  5 Jun 2024 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B2FO8N5t"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DFEAFA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547066; cv=none; b=aEemLnrBE99jzdDp7+Cc6ZXMGUCco8PuLfyTOJclDYSb+or/5pnm/ORqj5ZmoBEZpcAubE+ViClUFftV5ScmxFwhqrna9fasvwuO5waNSORpq1U2bHVGjSm4zS4ZSidqERyUn1xro4juHnY59fTeNGnS5joXxzn97gcRTkewCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547066; c=relaxed/simple;
	bh=PuPvW9S3Ct7nj+DWpsKp/UBw0BJInGtZwK+xlTrUxiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbrx/QJZHAAU8p1lxjNchPSb3edD8W3dguiKf/B1vv5cFBZV5wuX2XLv0ztsaJANJ5BOVxZ8piss9MhDfsQmf8NcLwCfzXL7hLr0Xh2WaqOAaU+t/aOxNSGE7jd68VUvBJ08Ke3/MQe2RvCVS7+KJWuKWiGVa+gzbh3dLVzsnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B2FO8N5t; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6d4bf8eb8e2so771549a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547065; x=1718151865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1A9rs7TtWcsH1JSfCCKsqVamskJmPgnyBU2yqNCV6s=;
        b=B2FO8N5tCcpcN3EitYUgwZUfs+5dtaK1c7t0EJM3wqkLcQbcQ25TZY9JmT2OEqFqpZ
         e1M1SMJPgReX5d37tlMEKG9JY8lasyKNCXsRXFZ4HqozeHJFCYFrAD/oiX9VYgWNKVt4
         /e3OPRpbCM/DrGDe2AsVvRXVgXLksoBtqxXPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547065; x=1718151865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1A9rs7TtWcsH1JSfCCKsqVamskJmPgnyBU2yqNCV6s=;
        b=VTFVcZCADzUt4cAMKJFpwpp1WdJ1CHQnZXqtCjk4KbsHzUXnRo+jvFaFmwNQERrkSm
         gPP3/ZH0DvVV5Xaa7ZRH1Lrm/vkoj7nfk5NJfMq66zl0McicF+xKEuP7vNe59vZklHfG
         4/C6hxW6kobZpduorZ04lY8UzH5o8/m3KdnTHgrxrjIZ1q6MfN5XiKKgm5JqcFJeqsQR
         dHF/fWOOy7ujc8twq4RmavDO6w3lPoGcxB28pPQ0y4G9JN2qNth8dgbzPRY3FZNDX4be
         WBZ88uOS+53qhi4I5JGoYljIL9gCOK2S1glzWexc8x8pXUaHbrST0ZkoKs6uv4h5L6Q9
         5rFg==
X-Forwarded-Encrypted: i=1; AJvYcCUMAdWBlthIUZ8Dofdo2YYJLn+eY+F/a8PbOiKNlgi1LmBmQV99t60Z+nZyeu6OvsnEa9twEEWURYaI8e3r0Nk+CjZeaDdGhpbJFuYa
X-Gm-Message-State: AOJu0YxUhxx8MFcXZhcGGw9QXRM6noN+wUSEXuxsIXyF7pMEsk3xOuld
	H8odB7msyb6No3EAmpkMdWee3wkChiAF3RPh5tO/23T5t570pRcXVqj+JLSQmg==
X-Google-Smtp-Source: AGHT+IGG+wEJhjmnOFnR17XFhvwO5ykeAXaDODSuz04Uiik7Ku3I2gOkgMKqETtCi2Cc8JKNST2MxA==
X-Received: by 2002:a17:90a:db81:b0:2b6:7e55:2aad with SMTP id 98e67ed59e1d1-2c27daf65c1mr1092784a91.7.1717547064767;
        Tue, 04 Jun 2024 17:24:24 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:24 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Stefan Mavrodiev <stefan@olimex.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/24] drm/panel: olimex-lcd-olinuxino: Don't call unprepare+disable at remove
Date: Tue,  4 Jun 2024 17:22:52 -0700
Message-ID: <20240604172305.v3.6.I4c79deffb7551ecfb0378302f8dee1275fd1c060@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

Unfortunately, grepping mainline for this panel's compatible string
shows no hits, so we can't be 100% sure if the DRM modeset driver used
with this panel has been fixed. If it is found that the DRM modeset
driver hasn't been fixed then this patch could be temporarily reverted
until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 8a687d3ba236..94ae8c8270b8 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -251,9 +251,6 @@ static void lcd_olinuxino_remove(struct i2c_client *client)
 	struct lcd_olinuxino *panel = i2c_get_clientdata(client);
 
 	drm_panel_remove(&panel->panel);
-
-	drm_panel_disable(&panel->panel);
-	drm_panel_unprepare(&panel->panel);
 }
 
 static const struct of_device_id lcd_olinuxino_of_ids[] = {
-- 
2.45.1.288.g0e0cd299f1-goog


