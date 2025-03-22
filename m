Return-Path: <linux-kernel+bounces-572427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1787A6CA3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2EA17C4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2CA214A7A;
	Sat, 22 Mar 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw74U9zP"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103641DEFE7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649538; cv=none; b=RjTy9j4jQ/jCSQXjMmPg/soCPc64/fu52nCohS5N91Y+4kxxF3PC2h5wV2yRollRjtW6JAaF89RW6LSCQDo3y4Bsg0iH8MvIUjA6ZXHVgTgIFBeC3vGwf6Z7S1G9/8luJMtxmF6fUZooBYeBXr/g57+FS54kHRcWsfzuD/TM8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649538; c=relaxed/simple;
	bh=ILCuVKSOTBP79PnFCQ3Cyhks0aKrZLJDaSr6atJRR/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+UiLfWcRQJ6L5NPzNF+ZIg/t93W4WbpldVz+hIfT3jRhBT9ZxhWP4TkGnEwK/qnSUCtfhPIo7gijJHF5QRGwG13qSie6hj1PAV9iGr8Hgx0vMp2kNgpbS2zIR6v8wTv2ZDd0a6f3rF4tWFlXip0sHABsUOj9+kKC9TK230GBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw74U9zP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2239c066347so67036855ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649536; x=1743254336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JyG3zo+vFR7f6YerLE6AKOm4hKRWC9oAJUiqrkXH91Y=;
        b=bw74U9zPPSqZkMV4OvWNCtirxfNwV1bjsa+aK/7K6fcSHnuMzPxUEq1sw8DCZ+6g80
         9aJQ7T0kYxdxvHDHw6FHwIUhVXNPi7Pa+u/LfEGKK3xZQB6MH4gVEcsaxx37XvUUkqIT
         Hx/ovSvghURvNzw9zblFLDo/ijVKD5p/BbRShLAhnZIO0ZY+p8+G5/lc5Ke93sVXVIAR
         NCyMpPiXj2X7HLSYoz7OS+TNN7GWF+FSrRNOYnwNuJSgrq5HfdM9d22kFHXTFuiRAA4q
         PgDeuA5VtQTXmpPGlSPYhOojxUKahfgEpV4LYB8N/sR82ivVHbxHMp0VV4fqWtBbkrhE
         5SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649536; x=1743254336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyG3zo+vFR7f6YerLE6AKOm4hKRWC9oAJUiqrkXH91Y=;
        b=fWrsV7NY4B8WmNjbCJhKh5wI17KMGzLvf2WPfIlQsQH7BvmunxcnQ0Zkw4s80AsXk/
         Sdeck0Ga3qFhJYESL49i4Jh6SnLww/KzLx3ZgUlWSV9Fpg+Vkw+hWOJ6u0D6B4L/QbUA
         TiYlvA61LoZSHsI0AotHLPn7S1FirdPTSIwKK4QyDAlR1ROtkOgYRAC78W/OtDVdXA9V
         2m8ygmH5hsJQgLih85AZP/dLK4Ke8xoESgMEkkcFIr/3ZY1TPI/2d28qn7zFrd3uwkwU
         PEZ09Zkxo9mJlUZzKcvD0D0deHGDAK5lJlBCg2euNwGQN41SmQHOMSbZMud3kbRvYj4f
         oYnw==
X-Gm-Message-State: AOJu0YwDPACMJgrRI5RdNP+kAhO4gSMZqPFN/EyOropKI6pF9jOKFuhI
	nm6AUkqU3KEWiTBzAR2XKdzYARu4qw2EHs/x/eZUEF0CduLsyOhY
X-Gm-Gg: ASbGnctKD5bn3IweA+AbKmJ9ylGp0eYaAP83T/CEv0vEDd86h/uxo6W3TIaMqf9Hpfe
	0XOsUWuGeAZp+vT1pWFKTnFwzoWvnaX2JfIFSS1Cbp+r85t4muwHoAzwiC3bz15TAM+MPWEo5Uo
	OtiBZEObNH+eeEzX7o2Jwy3GeCOXluoLt5BssvnM4Bn3urfD/6J7P4FDI7mYLpZW+Z6Y3y9Z5fK
	DiNH2Lr5xPEHATxik1/gJzLz9shomswsHE+6u5XlZgiK+P5yWoHR3NLdo52EzWD/fGtFgMUjvON
	fJnTFpsVry42Zil8pZk1d9JIoMTsTzlg2baV0MTjR21r32DpuCO9dXzz8Cuiqd6FqltlwaXTFnx
	8xdVYyefa/062GA==
X-Google-Smtp-Source: AGHT+IEDhR2fDkvf9/6Xm+Kiiv8KkExPS9/jfEokltp1cj6oglViHFnvlzl0RGVQ9EerZq6uh7BwJg==
X-Received: by 2002:a17:902:f645:b0:223:f408:c3f8 with SMTP id d9443c01a7336-22780d8c2c6mr130115555ad.14.1742649536085;
        Sat, 22 Mar 2025 06:18:56 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:215:18d5:84f8:e760:1d0f:700b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f60b919sm4053035a91.27.2025.03.22.06.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:18:55 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: Peter Tyser <ptyser@xes-inc.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] mfd: lpc_ich: Fix ARRAY_SIZE usage for apl_gpio_resources
Date: Sat, 22 Mar 2025 18:48:41 +0530
Message-Id: <20250322131841.31711-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning detected by smatch tool:
drivers/mfd/lpc_ich.c:194:34: error: strange non-value function or array
drivers/mfd/lpc_ich.c:194:34: error: missing type information
drivers/mfd/lpc_ich.c:201:34: error: strange non-value function or array
drivers/mfd/lpc_ich.c:201:34: error: missing type information
drivers/mfd/lpc_ich.c:208:34: error: strange non-value function or array
drivers/mfd/lpc_ich.c:208:34: error: missing type information
drivers/mfd/lpc_ich.c:215:34: error: strange non-value function or array
drivers/mfd/lpc_ich.c:215:34: error: missing type information

Use of the ARRAY_SIZE macro on the two-dimensional array apl_gpio_resources
led to incorrect calculations of num_resources, as ARRAY_SIZE only works
for one-dimensional arrays. It attempts to determine the size of the inner
array but does not correctly compute the total number of elements, leading
to incorrect indexing and potential out-of-bounds access.

This resulted in incorrect resource allocation, causing errors.

Replace ARRAY_SIZE(apl_gpio_resources[APL_GPIO_NORTH]) with ARRAY2D_SIZE,
which correctly calculates the number of elements in a 2D array by
considering both rows and columns, ensuring num_resources is assigned the
correct value.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/mfd/lpc_ich.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 4b7d0cb9340f..f0b8ff9ed177 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -187,32 +187,34 @@ static struct resource *apl_gpio_mem_resources[APL_GPIO_NR_RESOURCES] = {
 	[APL_GPIO_SOUTHWEST] = &apl_gpio_resources[APL_GPIO_SOUTHWEST][0],
 };
 
+#define ARRAY2D_SIZE(arr) (sizeof(arr) / sizeof((arr)[0][0]) / (sizeof((arr)[0]) / sizeof((arr)[0][0])))
+
 static const struct mfd_cell apl_gpio_devices[APL_GPIO_NR_DEVICES] = {
 	[APL_GPIO_NORTH] = {
 		.name = "apollolake-pinctrl",
 		.id = APL_GPIO_NORTH,
-		.num_resources = ARRAY_SIZE(apl_gpio_resources[APL_GPIO_NORTH]),
+		.num_resources = ARRAY2D_SIZE(apl_gpio_resources),
 		.resources = apl_gpio_resources[APL_GPIO_NORTH],
 		.ignore_resource_conflicts = true,
 	},
 	[APL_GPIO_NORTHWEST] = {
 		.name = "apollolake-pinctrl",
 		.id = APL_GPIO_NORTHWEST,
-		.num_resources = ARRAY_SIZE(apl_gpio_resources[APL_GPIO_NORTHWEST]),
+		.num_resources = ARRAY2D_SIZE(apl_gpio_resources),
 		.resources = apl_gpio_resources[APL_GPIO_NORTHWEST],
 		.ignore_resource_conflicts = true,
 	},
 	[APL_GPIO_WEST] = {
 		.name = "apollolake-pinctrl",
 		.id = APL_GPIO_WEST,
-		.num_resources = ARRAY_SIZE(apl_gpio_resources[APL_GPIO_WEST]),
+		.num_resources = ARRAY2D_SIZE(apl_gpio_resources),
 		.resources = apl_gpio_resources[APL_GPIO_WEST],
 		.ignore_resource_conflicts = true,
 	},
 	[APL_GPIO_SOUTHWEST] = {
 		.name = "apollolake-pinctrl",
 		.id = APL_GPIO_SOUTHWEST,
-		.num_resources = ARRAY_SIZE(apl_gpio_resources[APL_GPIO_SOUTHWEST]),
+		.num_resources = ARRAY2D_SIZE(apl_gpio_resources),
 		.resources = apl_gpio_resources[APL_GPIO_SOUTHWEST],
 		.ignore_resource_conflicts = true,
 	},
-- 
2.34.1


