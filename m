Return-Path: <linux-kernel+bounces-211571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DAF9053E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719C81C21C66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05017D355;
	Wed, 12 Jun 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP6MbhX7"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3917C9F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199432; cv=none; b=TmAyKeHQsHZ7KAz1atev/+Wwn64ecaRBDZUluBpigXrj0IlHiGxuBlS/zKCSkPdObQyHqqbe6fzq7ZZJ42D8hSg6kh2OBF+4GJYBRa18whAW7PV33S1zdSx5MsLAeKhwD6wC2JVISSMjGBSb+22UQioytBAO8dKcIUKinqU3Ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199432; c=relaxed/simple;
	bh=ZBa7BSruQYc69oMtdtEp/dyK2qiYEo1o7+5F9JmxO6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q27QmkwnNHJ921On6J/JMcCxZ0QWSDTJnRUwySAPdEx8yifOWamJTQtp3k3tocZ4g3axdWZ9UVHaphCu4ntuYBsegVkpHe/NMUrEZmG24EIbKL03tjhhuHH+b32FjjCq4KU/PLDZtwy695FlP+LVVby1deF4bVHVQYLJim+tdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP6MbhX7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f32a3b9491so51074925ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718199430; x=1718804230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/n0skyDCqk0A4g17wGPYh0p/6wetdSwsLx+Vq4wTy8=;
        b=LP6MbhX7OkwxtXvR0HdFkgSu9YkndIFhgRhqk9L7uK2avB02OQXG9k93OBgTPVFaEN
         JbkG4PaPnGO8dYDuuIDcaDm4maZES7cQT6BYeDzaiVE17TGyOFxzwKtmLBNXTUGxUCtk
         uvq/3h+wO7OBdniAZTqvAsSMPIl+7KHPlUdwUUyj5SGmAHwBiM0q/Y3dNvHaxYET7J97
         8Y63eFPJjgEYxD//IZoWGH2tGI+BgrVgptsDqQZewlkVoZr3MTWQK+rhrjsNwkhHusgZ
         qSLIYzF+w/k7OhqNR3juj6KvA0ILb+OQhcK16gQ6nQApH/i7NkjSAwyj9kuUJp2RWB7a
         +YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199430; x=1718804230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/n0skyDCqk0A4g17wGPYh0p/6wetdSwsLx+Vq4wTy8=;
        b=VPtKL0xxDWbHGVH3mklIzONQGH5wTAxHf0cJ383JGCCJ+WnGIDvE+UVUB/JPt0B3tH
         iW/8tVhRfqHJ+FhGaZl2eXbhDiLUm0kb9AhTonE4IAqAOPiOyg1mOrCA8eZ006Tq13XQ
         FVtCkJuvIyZ4ufRpDW9ESg7W0vzrmSPKf/oXdlPjr68mGTjc1qepuPxfJ4+JcdphlxSe
         ROy5rC4vcMHUPyI604yveNF8LyeMhXYFBcm6wtt1mokxtpo9TuMyHCa2loubrKPg7i6f
         zLNpdCQIiQatmvNbQPJETpC9YIpkXKhHVq9bw+QBPpAuMvg9T9P8aLBX09UJ9z6o/3IS
         QoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIiNC6vcBGlWvIDYachU828fYBIxHI1cOpLckHkRhFUmBaq8CgHaOwsm31n9w+FDz5UpZTRWwb0d8EKOlL9CSc493ZOOzJFqwRuAAn
X-Gm-Message-State: AOJu0YzQ34luYuzdo08XKv3oC9ZvMq1mty7CdsSOZ+dKE470QMYyqzPI
	eemDPFx/WhS9zcL9X1YxvXIYMzSUfOGr3zC3n75nddWgIFYwOp67
X-Google-Smtp-Source: AGHT+IGcY5lrA68E4+hHXL1ibBHgiWf7Aag49KQay59rhRT3xV22h/I+PhvUY5tYGnv77TorH4ctkA==
X-Received: by 2002:a17:902:dacb:b0:1f8:4932:2f05 with SMTP id d9443c01a7336-1f849323126mr6170465ad.64.1718199430429;
        Wed, 12 Jun 2024 06:37:10 -0700 (PDT)
Received: from distilledx.localdomain ([103.246.195.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f845e0ca86sm7291815ad.0.2024.06.12.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:37:10 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep
Date: Wed, 12 Jun 2024 19:05:43 +0530
Message-ID: <20240612133550.473279-3-tejasvipin76@gmail.com>
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

ctx would be better off treated as a pointer to account for most of its
usage so far, and brackets should be added to account for operator 
precedence for correct evaluation.

Fixes: f79d6d28d8fe7 ("drm/mipi-dsi: wrap more functions for streamline handling") 
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 include/drm/drm_mipi_dsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index bd5a0b6d0711..71d121aeef24 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -293,7 +293,7 @@ ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 
 #define mipi_dsi_msleep(ctx, delay)	\
 	do {				\
-		if (!ctx.accum_err)	\
+		if (!(ctx)->accum_err)	\
 			msleep(delay);	\
 	} while (0)
 
-- 
2.45.2


