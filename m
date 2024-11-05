Return-Path: <linux-kernel+bounces-395919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C339BC503
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D2D1C21635
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D961FEFBF;
	Tue,  5 Nov 2024 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr/ZZ76y"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B71FE11B;
	Tue,  5 Nov 2024 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786053; cv=none; b=SBVgudNQF3n9WPSelqDgv7dz6wDWhpXrrd013SAfGM+O+scyeGmr0J7qoN8jChNL5KciRK3Qn0StKx4GldIXSqTSZNqmng+7ZJZpAes1xyocNM9b2062zlx5Q2m39Jw7X0Y03XI7pgAsaEySwSH1xnJmabW0zt4CSBD6XgIStSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786053; c=relaxed/simple;
	bh=7+HyGNsKNOa/i4wo6zv8/HhEvfChxke98+WMoTeP3oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDDcYp7oHxjqxbQtaJgWpjwdlqhPJEMp0v6o7UBNjnWaBpBtQJkjG2cbhhFPo/r+Or4OsBSBzCUSgX653i3wQlKrdazFaYjFJtNPgs0bL5jPen/J831cqoyKz5v/4DP6j+vmmhD4UukpKA3j2VIAWJODdNGDlwUwXPPnaBm88ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr/ZZ76y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so3598865a91.0;
        Mon, 04 Nov 2024 21:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786051; x=1731390851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqWywPOux7fqYBvqYq3BCUnN8cTvh6z1oVaGkKCV3Z0=;
        b=gr/ZZ76yjxyM1P20uocfY0wO7sG4Wd957I8/CnKCWV2r5Lcn9lXFXLZQNBHN9OL5Qx
         V4lI4RtLKZEcRW6fH2lfMYTcUj3KhxZDuq/4uQPxDUJIAqm7AMcKB43V7CQDk+imoZnb
         rltz8A1S67dyi2m7tzD6rcAlLc1Iu3dgF5FIwNr2juWkpE0wBhO5HqfkrBwpuKxh6GFS
         uidzr99rxIn2hOV1DpVz45FrUbP5SCs3GGvah0GMxbljcilxQx5du59O8/961JoyMRaj
         nB4DAd8irT3U76FD1W08IfLhokHtzBQaHs3paBORYADcErWd9Ggmogd7X2xl4vZFbC3Z
         OEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786051; x=1731390851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqWywPOux7fqYBvqYq3BCUnN8cTvh6z1oVaGkKCV3Z0=;
        b=tyfkk6uuRgGOUbAAd7IOn1OuuwJu4OZ+s0yCwrmjd8mzoNMmNOg+ULSSv1AbuEbg2q
         zo8HiNEJeWbN6WC2JiCp2NRDzmXiu6SrnN2MYACME5orC2DiRIPba9KAPtQDq1N46MmA
         y38tnAL0RqWnvfJorU+BiXSPGu54k4Qe2XWRBAxus9XfgA0fm/1bIBpCc6btl3OGFeL/
         nFTrgrr2ruMgFD0lhkaegjGNEWXRvBgaUnLZoyv0eyUJm3ZklO11TFAR5GtGJefYXesC
         QrF1UZceRsfiVMzhimLZ8TosL2suIsXn3XK1hQkSRmGOWdBu+GWvgrFN/fN/qb1ziJEY
         xPxA==
X-Forwarded-Encrypted: i=1; AJvYcCWAIefRv4OxAsXYke8fxV0o1zXHzDL3qgWSAHLbqIoVQxvjWxOsLwDpefJe2xWUwSxqMKuC9/3FFcHY@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrGesayYzNr8NnOdrL/3F5AOOXTOdivdgyLDk8AL4CHr25tyr
	MqbCpEP3nWiqeYuThcv8H0XlAlfv+nHr1FaTbDcYkkjLcG0p2sG4SKQXuzu7
X-Google-Smtp-Source: AGHT+IG5o3ju0226IekHiik9p3aigT44lyf9BFM2fSX/r2B4qqsGKRgWfSSjNoQR5pAezQYfIFsAmA==
X-Received: by 2002:a17:90b:1b44:b0:2e0:7e80:2011 with SMTP id 98e67ed59e1d1-2e94c21cd58mr24157797a91.16.1730786050963;
        Mon, 04 Nov 2024 21:54:10 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:10 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/7] drm: panel: nv3052c: Fix size of WL-355608-A8
Date: Tue,  5 Nov 2024 14:52:31 +0900
Message-ID: <20241105055239.1577275-4-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105055239.1577275-1-kikuchan98@gmail.com>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is 3.45 inches in size (diagonally).

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 2da1e924177..2f3a8eaade4 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -906,8 +906,8 @@ static const struct nv3052c_panel_info fs035vg158_panel_info = {
 static const struct nv3052c_panel_info wl_355608_a8_panel_info = {
 	.display_modes = wl_355608_a8_mode,
 	.num_modes = ARRAY_SIZE(wl_355608_a8_mode),
-	.width_mm = 150,
-	.height_mm = 94,
+	.width_mm = 70,
+	.height_mm = 53,
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
 	.panel_regs = wl_355608_a8_panel_regs,
-- 
2.47.0


