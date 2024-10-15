Return-Path: <linux-kernel+bounces-365983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006299EEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009451F22B04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E51D5153;
	Tue, 15 Oct 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+saE+hY"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C761C07D5;
	Tue, 15 Oct 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001417; cv=none; b=KySc4E147+Q17FAFgG6U2GXhbwEy2nqZFPcfnm+Oxbp4BAU31qpLg/qxyGAhq33gUyFG/7dfJS8JfAubDbc1A3Kl2pW5SFzRjg2MpPnXPDA521FTY1+aNaRGuDXMQf+sf7Yrmp9FKKkUDSgrtXhDYWpEztWV89RLMIyaVX4ugoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001417; c=relaxed/simple;
	bh=OCRhYLNXOugWZzNhEPUMgUEAfnigcDm7KPLLQGKvXow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MQVdBfgNheOOYJp89BHZxI0y6aoqHwXS08HCbLO2lliuG9Gpwy6GJR2fk9sC2V1e3rnEdPfwbixeiu+J7aOFlkg60cyWHBafhDfaLH8aHbIZRh5bZp7UT9mQ01deiU85JJaRfzsyqel7sSERR4Rf+IB4PU+w+VJomQIg6H9xTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+saE+hY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso60935265e9.2;
        Tue, 15 Oct 2024 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001414; x=1729606214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0S6YMoGPkQS3jMGBGZ20kgoq+vZUxOnC0t6FsdhxLU=;
        b=L+saE+hYM8e6v0jItBvTXTFkjpxtst06ujoj2eCGHmChpRMn7JX3gljOtcMN4AFCAG
         3aId0aXDZ0EykTQXCFkJqRWFgxzCFNBD5XYl4xk2SE83SHzAwAjf8PW5b9Z/jN8+9rbk
         I5WtPNYNPeo5TLYf2K3Pj9f9GMD2TTPuJlHvX/OaYfZgm2bcQVv1YhQ0kf1W0l0qfMGC
         kbofAcwUXNQN3jP3uojyfBnfTAsmAdafwOFyJTYQvJ1k2IaprBKHybVNK5zwYEbCaByu
         bqhFzHHwrdZpeEdy1poCqsgb3vQISALt0fPsrGUoXYWk60KSwUVlMOJ1OhS8aM8MK8YA
         wQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001414; x=1729606214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0S6YMoGPkQS3jMGBGZ20kgoq+vZUxOnC0t6FsdhxLU=;
        b=kShVI4efmtyeBVyJwjMddrTsTBVJjAanGTF6j+Z3EfWs/2FPlt9XJ/DNAexhPuQQhh
         Qg47erJ0sHMK0q3/Xz71WAeTSvBNUVS0D9XgJiC+85u1b2OVpZpVfmMednACH+DiL27Z
         vZBqE0L/RhqlGe8JwgypvZTqLL5W7lQtfBCL3qmkl25CMgc8QLgkxxNn+jkJBs7XyaZG
         MDVKf2OQ6Z5xNZ2YeTpwuYzVhJ4u4bK7nYWNFLPlvvjRtb/DUdYEv7obGRX4MR9KikH7
         OcEvek+vtqpEamFpMvjTRFNczV9FN2/acVw1rzujQFWLqhKuwyo+d0JEj/aW1GCux1NB
         72CA==
X-Forwarded-Encrypted: i=1; AJvYcCWuBNvfh0AS01diyTHOicG+G/E3fd2FL9UvxyKLGUYG1hfj8lFJaYPYHpteKVYvwAswAeaVB4ef9XdNAOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4H9Swt5SnlQNlph8LNFIHA/3ETLFiykJ45kuGLVH/9stGJC8f
	JTeJ9fA5rHODHBWA5cQWo0tWPRFnG1vkrS9mjBI32WptfmDLMks0
X-Google-Smtp-Source: AGHT+IHp4e5RHLdoduJkY+KzguH7RjGzLSJHN735+mjgkEary+e1KlddLzkEUjNNgR+FRgq+djFEUw==
X-Received: by 2002:a05:600c:3acd:b0:42c:df29:2366 with SMTP id 5b1f17b1804b1-431256166e5mr131924165e9.33.1729001414085;
        Tue, 15 Oct 2024 07:10:14 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55defbsm19257855e9.7.2024.10.15.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:10:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/omap: clean up error exit path on omap_encoder allocation failure
Date: Tue, 15 Oct 2024 15:10:12 +0100
Message-Id: <20241015141012.155559-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently when an allocation failure occurs for omap_encoder the exit
path will destroy encoder via omap_encoder_destroy  if it is not null.
However, encoder is always null at this point, so the check and destroy
is redundant and can be removed. Clean up the code by removing the exit
path and redundant omap_encoder_destroy call, and just return NULL.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 4dd05bc732da..a99022638a2c 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -126,21 +126,15 @@ struct drm_encoder *omap_encoder_init(struct drm_device *dev,
 
 	omap_encoder = kzalloc(sizeof(*omap_encoder), GFP_KERNEL);
 	if (!omap_encoder)
-		goto fail;
+		return NULL;
 
 	omap_encoder->output = output;
 
 	encoder = &omap_encoder->base;
 
 	drm_encoder_init(dev, encoder, &omap_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 	drm_encoder_helper_add(encoder, &omap_encoder_helper_funcs);
 
 	return encoder;
-
-fail:
-	if (encoder)
-		omap_encoder_destroy(encoder);
-
-	return NULL;
 }
-- 
2.39.5


