Return-Path: <linux-kernel+bounces-426965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD199DFAAB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1580B2128D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 06:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4141F8EEC;
	Mon,  2 Dec 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O6hoMdSA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABA481A3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120698; cv=none; b=IaBo3Iayn4Y0HnUk246RryExbgiWC1LA6a+/Stw8HxjAe0QQs91HktwuWiUHtLe4f6ICeY0zuab2+2h5/q2plOQY55LspAMuIIlDboatZuimLQUQbu1kdawuxl78bre/aO3slwXGWQ5dG7RV7r6gU/W2VCWOqVl6OphCA5c3L5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120698; c=relaxed/simple;
	bh=D2QfGm0TybOV12AXlJpJDajwsegSn2+DS2MJmRfRr/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpWjZzaBdo2rIkdsGnCsSoUEBnDb9jTiTCbtURr5RuiMybycOmCrRI1UG/JxMONoi/1YpJHFwlN68FgZ7GIANbytDTcaFl+gNPcos85R23OnCLire/Mj+kf0obqW1B1KYm3ZKYcG/QuNThvDcanCnQjUWbLoad+G0ozPAV6efa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O6hoMdSA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21269c8df64so32763985ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 22:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733120696; x=1733725496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDOn1kgP9dyN0sCNSB66ae9hZxj03s1PKGEuQOpzwTg=;
        b=O6hoMdSA43V2G+40N5mLCF3zaGWAqzFQlvZ26wCaUFzawRyQOM/iWzoodiqtqObwQh
         gnsCpqkmAOqC52cyTKKqgyV1UioW46UpIACsWSTuaa8n266DAme0S2wzhEWBgR+/7psG
         R8YG7FyptXW4zSupH3JOTetDiguJmCR3ypgAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733120696; x=1733725496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDOn1kgP9dyN0sCNSB66ae9hZxj03s1PKGEuQOpzwTg=;
        b=D62ENPr2G7MZ5CBksAm940wC+oMJhzcWv+wXzP9fnOCU3jHSzVViW9qQwLqB/wCtk8
         vd3gM5p+9KJOGM3rlSWr3hj/7UIMZuEh8HOk9+ls/7iPywk8XebmxTItlRcpZmBcTJr4
         e16meBPtFAaqrxmn0I4zqTsBmsKrnia9sttmDQMDlMCVUFVE7AnRBsStx55spJeV8f6u
         5h5GaNj1P3ucw91wkuTPyNy1epSVYoe7Rt/b+XccyYZRM5MJ4GXJWzEdh/zVsXdLqea4
         gtJFZ+5vIiggMe+40e+1WYT6YUVvtWsVtjqAMLA626wC9bncbUQukgRZA4v73kANJ///
         noxA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Tpl35y8rs67dJ2qnNj1ZrUKh+RlFKIONKcDxWVidErWYZFBtxv8wRJUVixdce+owZt858sEWxhsHKT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLx9Tu0Ot3Sio1VwXKnjFuNNx1V6tp0f8Ic4YxPG+5R+dkGh6e
	Z9tzlwb8Qdd672+ZT0VWT2To/2D8RfKFMB2+OweCClkN+NKdQrvo92cdLyxjcA==
X-Gm-Gg: ASbGncsYURlJL9qVvOFYUgat0matxTeQFPJs0xfcZxEaB7E1XDnIO8dTLp1kknyMNK1
	u4b178lyC5WRLQeP+7OxMeFX7smaX3h3/Jgyqv8fEShu9EL1sSrSG2vU6IsUTyjUqD4Q5/b1Gkf
	r1D7jfAMm+gW3cWJ1nBxRtdtKemGX9jFjEsPhy0uLAb9OOEZWCvjRTT7qgkTMTRaqXp+22pHtEP
	K/glfvJ0JXPz6qbYdmYFqG83dejxE6DOaOHqg/KAHrecIAnfeRYMeJUdFnoDc1MhZjj
X-Google-Smtp-Source: AGHT+IH19cjrOJsKhhiX1zQY7ljL7c7Kq2UdIjzaEbH/YJzqCavSW6LNG02QJO6bH/EaQUV6TDaNAw==
X-Received: by 2002:a17:902:fc8d:b0:215:5ea2:6548 with SMTP id d9443c01a7336-2155ea26782mr107540785ad.8.1733120695956;
        Sun, 01 Dec 2024 22:24:55 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155337b660sm37724055ad.69.2024.12.01.22.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 22:24:55 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: visionox-rm69299: Remove redundant assignments of panel fields
Date: Mon,  2 Dec 2024 14:24:48 +0800
Message-ID: <20241202062449.65593-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_panel_init() was made to initialize the fields in |struct drm_panel|.
There is no need to separately initialize them again.

Drop the separate assignments that are redundant.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 272490b9565b..1df5303eb57c 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -193,7 +193,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	ctx->panel.dev = dev;
 	ctx->dsi = dsi;
 
 	ctx->supplies[0].supply = "vdda";
@@ -215,8 +214,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_init(&ctx->panel, dev, &visionox_rm69299_drm_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &visionox_rm69299_drm_funcs;
 	drm_panel_add(&ctx->panel);
 
 	dsi->lanes = 4;
-- 
2.47.0.338.g60cca15819-goog


