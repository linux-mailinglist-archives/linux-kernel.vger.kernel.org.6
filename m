Return-Path: <linux-kernel+bounces-170357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0B8BD5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD341C20B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF215B115;
	Mon,  6 May 2024 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNAmYELe"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4815ADAB;
	Mon,  6 May 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024643; cv=none; b=AjNpU87Es4TOU1L8IG7q+D5m4mVgwGr9bhdbve7tfmOD8mB4X+nyrktyAGUQz1va1876TjhOYMbBoQ8OLwm76e6DI2pmILeHvsRx3YFT5fiEUt9JWudvF8KBelHbwAdfOOB+tFSQ3DBnL8QIvvLuBVz1BRvv1D+xRg5FfhujW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024643; c=relaxed/simple;
	bh=Qbc93fejeeZBPEaqXdGVDK++k4p6bvApcxXTPaLlrPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axVInxEBuUEr8q91YWJXNhsqIX46tQsAT5EDQm0sNwyiL9n/u1gNOLVlyog065TC394WB/Bgo22diTHdVMu9j/RQYHr6J5KpjG1tuJpxNxexJOsP7TkS1wDQf+YdFnnbfacm386wn7D3FP+XXnknmyqOT4Wy8RvAsBzHYbgtQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNAmYELe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5200afe39eso602682866b.1;
        Mon, 06 May 2024 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024640; x=1715629440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZPuZVUOkEjt2jKWfIEHf/5qiKMeNNTvIl6Wxm0Wr0M=;
        b=hNAmYELeL4pSpoifk9A07W9HYR5Iukuj4Y6cRxxv+TB+e6rY7QN7zmSHgUkgkGXHcC
         WXhwxCEX0ZJ7XgGvGqo1nG1ZW66zs/A6EkSmktcfGwR3fk71T0d8UY7CAfeB/UVile+x
         oSD8D/ZL4OKSgU4RdfX8YilvvXXS7EjjrgMrEKCf/EZann6KI2S+G97GSIkbhnkTtvyZ
         /tTdOB5YKvPwQr3MH+BDPFdCYWDe4NlN5S5UsG/Zyptv5oIlBs6dBxMswYXltZtPCMi7
         +G8hcJ41wtqXjzqdU6I8WISDiOeclpk1OoiFXvcdtQ5TkgyQ4ZXrOzb3gz/iwmzO7AkM
         oQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024640; x=1715629440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZPuZVUOkEjt2jKWfIEHf/5qiKMeNNTvIl6Wxm0Wr0M=;
        b=Y8k9Lw6QauertRsEjEyr5iHtFXpypSXZcSEH4oKC4IbUAYsYqkFn6WX3lEWPsQolkq
         fKBE0tD1Gm4PUVLr+/pXimLcEFJJbX4tQpju2KmefS0GupV5BExglMFhS2xCpGvnaEYa
         VfOW8GCcy11EbeROnYbVahmzZNTVmCiEEWi5RyGYhuaY4O3IMnZ62bJR5RVSAAAhrUsM
         WKg2a4PWpqcCsIZlmVJK57VFQkrdxajPEiLRYEHz3YuFiu+j1r/0PBdniaG7EnNQBmWG
         j3ncFkTA4xFj1AvMZMetfQmVcrpghEzAOrafgLhUWgw0xpXDsDHFis1X8d7+josgDJXN
         lnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3xkKU+CQ0/KwAryDOhd2iQNso27Xx+7dXNqCuDeZ0g6bXvQ9NRom+NrKsRmqj3X2jUV0dPVRkQcFGAfb76gbvd1ffPvq4s3fnCosnVZHNgPNud3x9r/WfTU2TpU4tHN1Monh+y8GdOQ5PyuxYQyxb6+xFRfHcfq/a1z//lXulAwxhQA==
X-Gm-Message-State: AOJu0YxltWA1YLQWcriAuxNk3WQhQBkRaiO6mRA8Xl2jHcia/Mz4gh/G
	ycmXGEgiWLi9izqrvle5YmDeg0ufl4smr5KPoBkBC5Qu5YKSC4w=
X-Google-Smtp-Source: AGHT+IGnSZ98ZQbdnsdJyC90pRyVt1nr5YcSW20LHXMtpRatNPwIAZ0FaJwwj91H77v0m8hCBi2Kpw==
X-Received: by 2002:a17:907:6e87:b0:a59:b9b1:a1d1 with SMTP id sh7-20020a1709076e8700b00a59b9b1a1d1mr7115835ejc.46.1715024639700;
        Mon, 06 May 2024 12:43:59 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:43:59 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/7] dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
Date: Mon,  6 May 2024 21:43:37 +0200
Message-ID: <20240506194343.282119-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506194343.282119-1-knaerzche@gmail.com>
References: <20240506194343.282119-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPHY's APB clock is required to be exposed in order to be able to
enable it and access the phy's registers.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 include/dt-bindings/clock/rk3128-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 6a47825dac5d..1be455ba4985 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -116,6 +116,7 @@
 #define PCLK_GMAC		367
 #define PCLK_PMU_PRE		368
 #define PCLK_SIM_CARD		369
+#define PCLK_MIPIPHY		370
 
 /* hclk gates */
 #define HCLK_SPDIF		440
-- 
2.43.2


