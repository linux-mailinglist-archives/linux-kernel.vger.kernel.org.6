Return-Path: <linux-kernel+bounces-174568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EC8C10E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856F7283AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A615B120;
	Thu,  9 May 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2hVylKv"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394315E217;
	Thu,  9 May 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263622; cv=none; b=YpwVrNA5vbI+Gw4gAYYph5TvLXxiQOUBBNzpSHQ8I6z+yNT+bh3ADiobnjNM48HzCAu7YpagV5vrWCnEo0JJ0egRoTogQLoSj3ntm9z4v6Fxqx8r05YLACWFTm5K2w0a7WVsn678/bgx6EH0v8dAJ3S86fhttaFrLtVLu/AvB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263622; c=relaxed/simple;
	bh=SPjxVKOID7XKwG5rve07qItfubtI8Vzo5fgKLdhrNVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8h1SVE8Fc5gTZ9sQd5oymlnQAu86mo3OzsKtnPTynlY9k+W4fjxI9tG+/Y9KxFLUwSf/pSM90x564+gCcvKeBbqDinAEvhEO5UAUwhIlj2HS6VgPXJnK1stXYdDOBjriAdBxSXStKb8qQkV6eEQ8W+mXmJqJ6n4xKVjeHTwdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2hVylKv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34fde285fa2so664120f8f.1;
        Thu, 09 May 2024 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263619; x=1715868419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkypWPW9zjRDxFdsbSAq2JqA2c+afHrqHIvisMDjIts=;
        b=b2hVylKvoGviCuMGRn8xhYUHAlEQGlrYvfn0cS37HogYTcmLXn5VhHEQQUT974AnIH
         mPkQP9kdrmImtF9TprYqO+gZahEH1a8AKPDRkHdkxtT0J2TqWbeIcGGAYbBoHD6RPkWW
         1qXzWRqbbH4d6xm9cieh3vAFF5SQwB0AMepV2y3wtaakmPSFVA4FieknlOlXN5JHAwLH
         1pRUP6aCByLxrKV6pRCbizRRBK8yGm6QMQ3bTiAUU8UvGZiLmeCC0+1fS7pmsnsfUZOZ
         54iVIncUqsQiII7t7WMgHmGSk7+gtZQBMm7ELKke7D6BOwOrSLTCApMrrK0BnWHpx/HP
         1YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263619; x=1715868419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkypWPW9zjRDxFdsbSAq2JqA2c+afHrqHIvisMDjIts=;
        b=xGPtD44Z1cOF4Xn5tdfk3fo8ZW3/jMh4arIf/Nsb9Fwu83gY9fFbSELFWDKnH711Gj
         c3IRwg3D9oPxMgCfeB+TPN7QmyRSyKzF5DTN7mBjUKi1QP1Xel4V5+bAyxkjWELmdiaF
         nm0jHQZES9F8uVvYTWfMs4ShSGiHos/jaFJt5HjY3q3DJkywXRJ0iDVZSo0akQmNGBv/
         V30uSpmh1LWiphGAVyewUYAAXzFzEvprc+F4u5RDyAdv2cMjwCuNisqucTueGbgpVDx1
         yk/VXdBetpB7zIHyy2oFVr9zSaJwOlYg9N29qh4UXqza/nzRDGJ2e9NyYN3W0iUh0Lnw
         2OmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrKguegGGFwaMLJFTL8glNhH0FJMylAyxRboSKygOdNhM1NOw07Hkkn7X6mxhOpmuahv1EMrUZikLOMQJv+w5u1/k8cNPoo1nqoGpHIbBZA6az9va4KSeRTsMfv8dJrJNT5klH7SDp120GavVhx/toOb2SO8GGxxtqHi/XlUuaqjUJGQ==
X-Gm-Message-State: AOJu0Yykuc+iNWovqkZOXD7VKvtNlD60yJb0otDOR9zbHavMeKJeSAzl
	hesotkrk/QwTPdDuMPJ4oz40/8Na3iTNtgH+BK4oHxtW1syXQv0=
X-Google-Smtp-Source: AGHT+IFqb5Butmg/XL3s32gTYjgv+S8OXC4Ust9AbxM9joeLAhE7w7QJYm4NxRM4exE+Z+nqR7jOZg==
X-Received: by 2002:adf:e904:0:b0:34f:7788:37ef with SMTP id ffacd0b85a97d-34fca244116mr4586628f8f.29.1715263619359;
        Thu, 09 May 2024 07:06:59 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:06:58 -0700 (PDT)
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
	Alex Bee <knaerzche@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/7] dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
Date: Thu,  9 May 2024 16:06:48 +0200
Message-ID: <20240509140653.168591-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509140653.168591-1-knaerzche@gmail.com>
References: <20240509140653.168591-1-knaerzche@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
changes since v1:
 - none

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


