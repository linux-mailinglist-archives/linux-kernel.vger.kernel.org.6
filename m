Return-Path: <linux-kernel+bounces-200671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5338FB334
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4A1284431
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A639146592;
	Tue,  4 Jun 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVBaTXJG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14721DDDB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506696; cv=none; b=Se9/rm9N9rzbUUHxW8iO3SAq0WxufJGzpJoMt4Z/rIELZdAuP/v3jwuLUckkTSC4LaZdnirpjvdlIGaerIaX+6+hS1bECypxT9Qlp8lfCYb/JSlfuNMHL3KrNhHDOQum81AgT4qeAXTn12h5CAPW/82xwqM9B8bA7tLaBTJkhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506696; c=relaxed/simple;
	bh=D8+B4VmmUKjGstm5zExU8LIljI0ZjbY6sHA78vNJcW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHlpbzn9XKlAfkAQJOB9Y3jgqbMw2nxnjeht425fvmK+zceizSeuHKQ4OpXCnobDiOt5RdKUFhGiNvIS9ie5/Ve6ng8mYsKOjIs/sxOdrgZLMyNnMWhvPGsXFEgU4Y4/hV0q2V7Y9kVngGrfa0B0EISqj/aUulGfftYvrYcxjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVBaTXJG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42139c66027so10121195e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717506693; x=1718111493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPJonIEuGmGlQs1GGHFwUCHmwPCfTUCdx095z5ehb0s=;
        b=LVBaTXJGjivlnzpiEUs4N1FwvWnQHgMZ8JDiJQrFFkgWGFDtgd0qAoTJyeIB3xa9Ni
         PCH07Y0mJ1PVXgbOZ2z9x/sXgJqGzr/xLHhbPeTpfg7AHZXdk4QeCvVwGcK6+b5ltjeO
         YhlriAJnMENVvRYfp64ohDKDSIO8VP6+BvcTr9Q1OkGngwutb7ug/qSKrZpksovOpMgl
         mJW+Ku70+K+0QM+sKGtoP0teLH3eulX3JtoWuOpzTFtBBdVLubnTVNyOJlHxN8Fgov00
         DjaVCq55KEBtOa2w9z/ln5tSH7V5Pek96QgUOcsfDMJsS/vi20Og8RWcZyIjRIjeTpy9
         pXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506693; x=1718111493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPJonIEuGmGlQs1GGHFwUCHmwPCfTUCdx095z5ehb0s=;
        b=eXBwbNAztSGUv/8YsKecQVO04gMaHbrsHzWButXROl3EfK2HPYjp2wxw0JQXq+Zucu
         ckGWSJOjXlRKBIyTgr8IEEknMUPAWK7MMdQgnUc54Hnlp4qf6xpOf4gSYZ+DJEDBvGN7
         /YpH44QgKqZZiVTBa+GX1teZZD65kKSFQol51fViPpw7ANkmnkKaBYGxHQshv7v1FZdO
         Ix9vGnmlTgFLb8eRLLVTfZpDPoQhOTsHogIlNGr2fB683nCo8tVjGWcTpaWaE11Z/vti
         Gi6gCv6DAFV9NK6YJntS2YxsBkeDEsBCElQuuEa7sk0q1YeZ9yF4TFhhqqdwj8soVmfp
         Xivw==
X-Forwarded-Encrypted: i=1; AJvYcCWQmhzTrnecwM0rwQJNzgBuars0c9GuzvN7pP3TjbMownkkS5InRV8WTHR/haBLStR8OvKlzSp7RXaCD0Ru+8b+EJfK7frwMJ8fK0UL
X-Gm-Message-State: AOJu0YwitnxuLIsSJMKIhfj5hzUUS9wN6jtyehs+WwVuI15O99VWOsB9
	keuPJlVKYNO5654NFlby6QHW9PZi6GX6o0jJuavZr7+iXAR+erJfDVqRnbHdsNc=
X-Google-Smtp-Source: AGHT+IH+/usVFBeoh+wIT79xCMgURUIgCCMPyCo4UNbGGkw4O8nLArXyKvbDCf5Fohur20sHLnXY9g==
X-Received: by 2002:a5d:6a92:0:b0:351:d9a1:503 with SMTP id ffacd0b85a97d-35e0f271624mr8835715f8f.20.1717506693247;
        Tue, 04 Jun 2024 06:11:33 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062fe96sm11495387f8f.67.2024.06.04.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:11:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] drm/exynos: dp: drop driver owner initialization
Date: Tue,  4 Jun 2024 15:11:29 +0200
Message-ID: <20240604131129.193972-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index f48c4343f469..3e6d4c6aa877 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -285,7 +285,6 @@ struct platform_driver dp_driver = {
 	.remove_new	= exynos_dp_remove,
 	.driver		= {
 		.name	= "exynos-dp",
-		.owner	= THIS_MODULE,
 		.pm	= pm_ptr(&exynos_dp_pm_ops),
 		.of_match_table = exynos_dp_match,
 	},
-- 
2.43.0


