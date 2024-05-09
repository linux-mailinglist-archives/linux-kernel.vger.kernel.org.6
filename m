Return-Path: <linux-kernel+bounces-174469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B4B8C0F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266AC1C2188C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9FC14C58C;
	Thu,  9 May 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAD4/EBG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A814B06E;
	Thu,  9 May 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256446; cv=none; b=GqGXBG9v75gESlnVjoXjep3Roc829H+ZXKknTULZcndZztSLLOQAh0KvfVDZCCLv34mIDNTxLiE/vfmqN17MG5gsPaDOvrfwNOS1mrV9HePtGorlQqz10T+leAYybHqE8s7yjn4mSkQy8c8mhXYzbVixA2T0R/adF+ukFiWNtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256446; c=relaxed/simple;
	bh=SPjxVKOID7XKwG5rve07qItfubtI8Vzo5fgKLdhrNVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYNvHSnX3HCarvzwhKe35gdDC16dV3IoY8b7kyiMSilCTv/MWZyjT3mGYOa+KBhoCKzHOWhffzP9SVGcAHAWvkJOKs/qxKBB4kBGB4WseJzs3rmfPyOw9yPwXHIydSwiJ8EyLUH+41n0xuFrivD978Cp64jTGhwceJkuaCj4TXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAD4/EBG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f3761c96aso999148e87.3;
        Thu, 09 May 2024 05:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256443; x=1715861243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkypWPW9zjRDxFdsbSAq2JqA2c+afHrqHIvisMDjIts=;
        b=fAD4/EBG4M1oAqPbz90CFjFcsgHyhcEe1im77rt4ZiNKQ1bPLs+MuHmCIWbdZJlzYD
         UCoR3KURHWjtqsdtsxIxoo54lx1EW2LaGUo0qhdO+jSaomfXS+PolFzz4CCgcru5+mGs
         1VNsCn+8cV6AvEXS2u41LUNAAjBxB5cK3NodMQkQkf8+xYbDiAr9GBfFUwMlTtIt7XfW
         k5KVzdRy4p/yv8aaj+2niZ0yU/vD26U0sd4AsESboisaKh/n0Fp1txYgBfSWLBXDMC2H
         C+1k22tysP9bOA2pODD7EctFGOdXqvryjIlB6kC0owetEx1ydSZRzCESDn3iS68vuGP+
         Pz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256443; x=1715861243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkypWPW9zjRDxFdsbSAq2JqA2c+afHrqHIvisMDjIts=;
        b=rRnHx6MbTlFrWb0JlvzwWtkfsYgdUewnFHuNp6hdbLRNOf5DmTFmV5FdJpbUkQUj0D
         lEYfTv8s3E32VrMyj4kwRpc3pc3IRQZee5hQB6CyJIwe3XgS1BzGMadN+Xk19dJ+7ohB
         Sd47hC+ziNyDboAhmNWO6usTXKSaKRqkZoDOlDm39WMeC/Lc/iS8HO09sZSeEeIHi6TP
         QD9QkV7QjHG+dXwv63OUliBc7KvheqJ6ZOb09krvvXrFsDpO1cxrdRW3qo7LKM5g/nao
         miQafjRj6uChFYg0GVrVAwz9O9dQDzV+LmQqgR9GFIa8qT0XqLcNAo2pSn5q7CXZNrus
         qy9w==
X-Forwarded-Encrypted: i=1; AJvYcCWakojoWshwBr3b/YN7DL219NA67ROzf/MnwM4Bgx9ZOvajhP8zaEJWPrhS6ZGlQlgbYAzWhdtZYOY7XpXGD/mpdoixEPYUthQIpfFdQ0HV6ZnEuU7JPnsC5aa5ZZnqyNQdetWP6ZiAt1OZptEBBrC0ft9eHNW3kXHg5eOxrG2OoVscOA==
X-Gm-Message-State: AOJu0YxXiVGBx1pWaerZM9dH49QIiaOOqAX56WCfHd5Oj4MZusZIoXLl
	FBULkB2PYnypT8Uj4Qd2aMdZbqtuUDQmKNYZRv7nS8LCiMNJpkQ=
X-Google-Smtp-Source: AGHT+IHys9c5rfgObjKdpLe0taBmnOFFOHsrH8dMTFsMSmyd7UfuBmkk0BjGCiFKBOXChJJYLuzTew==
X-Received: by 2002:ac2:5388:0:b0:51a:e305:eb20 with SMTP id 2adb3069b0e04-5217c567012mr4863974e87.17.1715256443303;
        Thu, 09 May 2024 05:07:23 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:23 -0700 (PDT)
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
Subject: [PATCH v2 2/7] dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
Date: Thu,  9 May 2024 14:07:10 +0200
Message-ID: <20240509120715.86694-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
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


