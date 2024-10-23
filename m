Return-Path: <linux-kernel+bounces-378527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756F9AD1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4816E1C2518A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9E220822E;
	Wed, 23 Oct 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="bL2DrpR/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9CF205AD5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702256; cv=none; b=UjBwKK0vVd/kXmrBe73C3+1Kwfq+ZuRXbMRjVcbx11rDI+PRE0P9dwrZyMAoeuKqAntxBeUBOJjYkYH4SZ3buYz+J+wk0GVIZjfiGwu4WJdqP4atJ/+pxREPwra4Awa5OHJ9c5g3yP91oVnGP7n2m5K+8EuR/PceLezKRWvSm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702256; c=relaxed/simple;
	bh=h60g8ThwYT/UJQE4G2CP6rUIno0KoMdhzemrzgI+AYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtoZ3eKC+LgX1J3CodCy1/AUzJQzEkCoswA03dYGvxUi5I9BR7I6ofMvJmtTNPi+CTUK54IqDAb32oqOoGu/WgsA+TzwYm6VibafF7Eqx/Qf3yO/zj9iXHPp/BGmXB3awDhJd/UJtWDSOqC1Lq/56yymuyJ3nmAp9N8jwL7MJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=bL2DrpR/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so77557895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702253; x=1730307053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9MiZUhuAcE+DC6JkjBsIZrkLkLAyStuyfWQoaNqfXQ=;
        b=bL2DrpR/FWJvjVHisJX0luDsjeVwtalgpvJdWsZ+637rtRRezTKHRugwXfdQ5bf/+y
         uiqlIT3FA0kmVYEA7kMVrRN6QnUPNoFuTfEQvSKB4QeY1EaMmOP14jpQ1sCjLjp6XG9j
         O8EPae4nTBvCJTUxZTiHeI1ndfQxE3+hcyWQH4QRa92YrkJz9ZxX2NTo4hfeUjuNBKlv
         UPfQlQpYrJp7KaxsDXY49plKI9POTVha/1Cv0HMY6xFqTl/Qnpyid/8wYQnXRKoKyl2z
         y+s4TBiCEi4qkFmmQkNJpubQvFxgKMRb2gxTpIZ5yLv8VqQqYBO7Q/0AdpdJ2V2Yedr+
         f3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702253; x=1730307053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9MiZUhuAcE+DC6JkjBsIZrkLkLAyStuyfWQoaNqfXQ=;
        b=ltIUvMdbL62MZNexLgt87BgFZDcQvTFFRtmTkuO1Kh/n/RxM4vkOzGmC2HG3O7GZHT
         QdeFoLX4wUVwTboRhKgRREl9fKfpU+wVazmkHThQCA9MBFLVJEd5DJ88+P10xfSzS303
         mrV19KR5Hfi0zkOd/Y/qb+5P8fv94dnL7go5/BPQBprJX7IpsHVBbbSHLiaLVkqqncha
         LxP2AM9SlXjl5bGL0fWbpwJoeLxKwgZhDVSHy3VMCsh8CBhM15sfCltn2zXol3TjXhe1
         s8dMy43hmJ6EKqQdaU2cIipAot+YLQ6vPtZV+SDj7DJIjpe+18IMf4zY15laEvh7n25+
         7jCw==
X-Forwarded-Encrypted: i=1; AJvYcCVoHMOcXWX3pxARtkDtnIhFCrfYdcRRtmhIUyn0ZapfHhgTYszkBkk0iVrZHIWhu5kP+DyjxNwHCGf1mf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMYgSEbZIWZDribNRMtLfVIN5eHglLvygIF1VdpGJAJTV3WMa
	IOAI40Gc0Ughe4vV2Wh1vqqV6oxnLzay6HoYYpHJXqTkTw9YxA4y9QcZV/wvAMg=
X-Google-Smtp-Source: AGHT+IH3dVyDZOxIVjZAcfUl+JwKCM4Z59KdfEHOCGa0hmLNiw7CjeLKq/QM+g/Vjy8Ji+yxUeCFow==
X-Received: by 2002:a05:600c:45cb:b0:431:44aa:ee2e with SMTP id 5b1f17b1804b1-4318413209emr25331625e9.4.1729702253413;
        Wed, 23 Oct 2024 09:50:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:53 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:30 +0100
Subject: [PATCH 33/37] clk: bcm: rpi: Create helper to retrieve private
 data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-33-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

The RaspberryPi firmware clocks driver uses in several instances a
container_of to retrieve the struct raspberrypi_clk_data from a pointer
to struct clk_hw. Let's create a small function to avoid duplicating it
all over the place.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index fd7ae0efcf07..89e2c0241ff6 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -56,6 +56,12 @@ struct raspberrypi_clk_data {
 	struct raspberrypi_clk *rpi;
 };
 
+static inline
+const struct raspberrypi_clk_data *clk_hw_to_data(const struct clk_hw *hw)
+{
+	return container_of(hw, struct raspberrypi_clk_data, hw);
+}
+
 struct raspberrypi_clk_variant {
 	bool		export;
 	char		*clkdev;
@@ -177,8 +183,7 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware,
 
 static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 {
-	struct raspberrypi_clk_data *data =
-		container_of(hw, struct raspberrypi_clk_data, hw);
+	const struct raspberrypi_clk_data *data = clk_hw_to_data(hw);
 	struct raspberrypi_clk *rpi = data->rpi;
 	u32 val = 0;
 	int ret;
@@ -195,8 +200,7 @@ static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 static unsigned long raspberrypi_fw_get_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
-	struct raspberrypi_clk_data *data =
-		container_of(hw, struct raspberrypi_clk_data, hw);
+	const struct raspberrypi_clk_data *data = clk_hw_to_data(hw);
 	struct raspberrypi_clk *rpi = data->rpi;
 	u32 val = 0;
 	int ret;
@@ -212,8 +216,7 @@ static unsigned long raspberrypi_fw_get_rate(struct clk_hw *hw,
 static int raspberrypi_fw_set_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
 {
-	struct raspberrypi_clk_data *data =
-		container_of(hw, struct raspberrypi_clk_data, hw);
+	const struct raspberrypi_clk_data *data = clk_hw_to_data(hw);
 	struct raspberrypi_clk *rpi = data->rpi;
 	u32 _rate = rate;
 	int ret;
@@ -230,8 +233,7 @@ static int raspberrypi_fw_set_rate(struct clk_hw *hw, unsigned long rate,
 static int raspberrypi_fw_dumb_determine_rate(struct clk_hw *hw,
 					      struct clk_rate_request *req)
 {
-	struct raspberrypi_clk_data *data =
-		container_of(hw, struct raspberrypi_clk_data, hw);
+	const struct raspberrypi_clk_data *data = clk_hw_to_data(hw);
 	struct raspberrypi_clk_variant *variant = data->variant;
 
 	/*

-- 
2.34.1


