Return-Path: <linux-kernel+bounces-211570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECA9053E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239501C20D49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551E17B511;
	Wed, 12 Jun 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSwoOzXB"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9416F0D0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199428; cv=none; b=CwlFHRmSmKxVxsJ/Cq8IxfmKYTMPLnYJGTN7R85ILHfpEeC/v6D2CJuPq2vx7oieD4TG+NY4z3NqLfsa+UgysSLKl2YCK79704D7GnRxuh7NgmkDnPg7t8VVHN9P7Qq3A4ArrECHlRAg/Pkshc4J+JAr69LZsX6v0QmxojS1LJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199428; c=relaxed/simple;
	bh=GFsMcBMoylWGTX0MPT2kFGiqHvgCA2BZtYfK1BgDqqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8/Ung2VDZFli9dITgrvKsf+uOgGvmwRl3FUEme+0oBM+4rKXNU+jrh6iUhj69kN+yH4i+H0gENp5vHTb/mEPqYcIVl2SYIidVO3NHW7y6eODWivi1mtwIKlrOR+q6ISEhvip93itEQXEc8SIf9YGY0dRG2gc2fg6r1J7Y3GUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSwoOzXB; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e57506bb2dso1815189a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718199426; x=1718804226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWKGCz3EWFmYzxcw2AH10wBEqhDAZAXMwRxOW8+/rNE=;
        b=bSwoOzXBmfJVXSQk7E19kUl/gcbPNxR6x5J7y/Gg/xdPqTMv970vE2F6GiIruaIBAd
         koASniU0AGtIV7Mz0rD8dxqqRNtcm0wqOwSk7NTxcZ4QHROX5mLjoptAZEwP4MCv3CMi
         48YwmME1MMaEwXjyG8fhLq7+iB1ZMUHtswgME2gX2ZOmMoYKGQhhNoG6riAFHpRnmS2C
         9XgcvHgoeE11Sdq5VjExoZhW1LwHwv+3utLZrgWoZ/gGshlIhSBJyp8eQ1SOEz0zMhqn
         UNF3pyBKlgoFAi++YDR4eva6JHV1UuGOUQ0p1Ze9XfQfN6+iBMVhAZKopSumw1gR4RUg
         LWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199426; x=1718804226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWKGCz3EWFmYzxcw2AH10wBEqhDAZAXMwRxOW8+/rNE=;
        b=hKp+Q8RNhzWOCjglKl5nGBCjHHgpech+ULjoH6NCqC/iK03hAxaT0Gz44ybgUOfyAI
         5LojpdAg+8NKoVf6dTX4S6uOiKqpSdioDJnsckvkGOFj3QdyAdoSTHHunZHY7tivKp/8
         PC7pCPPtnlsY8QuHZySzNpM3UcEgRr++Wopx+aAsQiZyoJyr+de/geHbT/1rM5ZV6AjH
         CRw5ZA6kLUrIr/GuxUnJHmdpcLDKaRp52wdocal627ko3+Dvu5uDBI0K8VZxJOPJh2VT
         6L94EZw/STPBy2Tg/hUIsdOEJMiEg3igy5YZNj4sqqZblroUrUZs+xO2DJ5m1VRtDGA+
         w7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOvfjyF2Xm94nEn3JCCjj2BqW3gE1ZJelOOsEuiezMbEGAJQFwejlhqS6cBtXuNaQfVpbuDRsgCBmmL05tLuINJ0uxeWU6nsZpjOSc
X-Gm-Message-State: AOJu0YwYwPJiqnAD4ajcIGTiQo6PzcCjAuR1XB4jE+sMtEjNa5iBC6DV
	dnVMEeAI5DDCDj8RKyj82clfOMiP4Uy+QvEw8010VQhLJPb835aL
X-Google-Smtp-Source: AGHT+IGk2WNb7MVw3PvR+Dd5n5F6ztFXUCd2N90utcqQ6HM1yzqO4d0rKoJRZPGLEL6Elpt27tujyQ==
X-Received: by 2002:a17:902:d4d0:b0:1f7:e32f:f057 with SMTP id d9443c01a7336-1f83b5f7b15mr20751715ad.34.1718199426278;
        Wed, 12 Jun 2024 06:37:06 -0700 (PDT)
Received: from distilledx.localdomain ([103.246.195.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f845e0ca86sm7291815ad.0.2024.06.12.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:37:06 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: Tejas Vipin <tejasvipin76@gmail.com>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linus.walleij@linaro.org,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/panel : himax-hx83102: fix incorrect argument to mipi_dsi_msleep
Date: Wed, 12 Jun 2024 19:05:42 +0530
Message-ID: <20240612133550.473279-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612133550.473279-1-tejasvipin76@gmail.com>
References: <20240612133550.473279-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mipi_dsi_msleep should be modified to accept ctx as a pointer and the
function call should be adjusted accordingly.

Fixes: a2ab7cb169da3 ("drm/panel: himax-hx83102: use wrapped MIPI DCS functions") 
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6009a3fe1b8f..6e4b7e4644ce 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -286,7 +286,7 @@ static int boe_nv110wum_init(struct hx83102 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
 	hx83102_enable_extended_cmds(&dsi_ctx, false);
 
-	mipi_dsi_msleep(dsi_ctx, 50);
+	mipi_dsi_msleep(&dsi_ctx, 50);
 
 	return dsi_ctx.accum_err;
 };
@@ -391,7 +391,7 @@ static int ivo_t109nw41_init(struct hx83102 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
 	hx83102_enable_extended_cmds(&dsi_ctx, false);
 
-	mipi_dsi_msleep(dsi_ctx, 60);
+	mipi_dsi_msleep(&dsi_ctx, 60);
 
 	return dsi_ctx.accum_err;
 };
@@ -538,7 +538,7 @@ static int hx83102_prepare(struct drm_panel *panel)
 	dsi_ctx.accum_err = ctx->desc->init(ctx);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-	mipi_dsi_msleep(dsi_ctx, 120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 	if (dsi_ctx.accum_err)
 		goto poweroff;
-- 
2.45.2


