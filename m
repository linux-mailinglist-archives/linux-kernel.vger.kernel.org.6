Return-Path: <linux-kernel+bounces-191535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E28D10C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971E81C21A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4410E9;
	Tue, 28 May 2024 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MrQUdse+"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6338D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855276; cv=none; b=oMiU0qSTN7VvaRuQvaun2Pm+gDZB9WKWO2mOT3NkyzK9Lxz3TrF25nbYWUXK9SjxZIcL+WmqPQQ2xEPciJxfSrq3Qlo4fhvxqIMy0JzH5EiPNSXImIJB+AGQlu+Zw4ZRxMHlJ2ws9vOEm6fhdokRz/Vw5g8b7bantsn6uIDvNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855276; c=relaxed/simple;
	bh=E/egdz2CGqojoAgfoOnzR3hlfAj67B/HxDS0QDBOeis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3mwXiMka4OMyWGiBpQRQ35ONM3vDZKqNbOInq9buBaJQW+iZuuaMohz9yL9fNy27Ea/Cb+JPbIInGQXvNekJQaJkZkRtWq6JXOGPSIR7ZJ1IRcK5W9rbq+nnXz1aYpD1YtIbtnkyU+N57AEaq7LlZuxOOm7f3Ibepofdqqot2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MrQUdse+; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b53bb4bebaso150630eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716855274; x=1717460074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtU4Y/eRQ2OBmokCMjLNZWabCaVyZYO3DB4JfpF3nAY=;
        b=MrQUdse+XQP95f2tKt9tyxCqtoWZwjkR+8CuSaGrR95CXfiYs67HQKPVWnCZ1qs1LN
         V/e5qUMvwwzPwLe0nW8HvOBRmcA5Y0Km+33s0WC1VOdYQmPRuYm8SIC/wRkB4X/rObi6
         CRwK9qr0P8zgrPXKv/05StKJTMU+YbAbkAvqghOiQo6jyLsQcgznNkFMuiRnHVQZi/+c
         RdxQpKzT+kJNF4zxqOvFslEKEN/aWU0g5ti9A+5KglcwVkow+NQN73mIFfb9BRZZjkjP
         lU0y1pVk5W60wIfCshqwHcQfmFRqecrjDWAPSarMXnxhKDBKdJ6G5gTNsmAzY6ymUEQJ
         uKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716855274; x=1717460074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtU4Y/eRQ2OBmokCMjLNZWabCaVyZYO3DB4JfpF3nAY=;
        b=LjLWfL8qXJ9/lJjBCvYtVMLjlsRPQz9AepHh5WJ+ZxL3rfuiRohrZAyyzETWDeOORR
         EjpAaAWgLCBlNzwRaW+uAo3cStRgqgxFXy3vmN9vgluKxw2sBvV3sZuwlDIjPxZa2XaL
         DDuxiqrXu8TtM9J1u1sxG/7xUp4+4nCIPO2RVyplcIfC9rhIM0fd8S2zlEn9otv8JTDO
         XgyDgI1Wu8/d+jobbOdldGpSRNT3LL2XtK/gGzVJHqY1qwCvDdKHUHPbpVW0G7P2W2t3
         QiDho938dK26atnzlER4r0Oh2CfLyYRGEQAEm/zrzFCx7jKGYYnhemuhgKgTGPgJksrz
         v0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWAhtn9UyO5RVujQsY+6VkgXU3vN0MB69RtmxDGWSs7qQQGjMP0kpqi5jpK92z7X0zHYlgIlR7hMqX+Z2d3Xs4AuUGfFF4W1sMW144
X-Gm-Message-State: AOJu0YwAYh4WXGNvdOkq10CmeYwJNRx3fWl1OrgrNRoXVRHRv6kGMADV
	0CviFdbK65dgMppvxjGBPe/0p2vgxbTcd4xM2rk9NF2sUxRR+WZ9qmuYJVDou8Q=
X-Google-Smtp-Source: AGHT+IGxwhLw6BTrQ2V9xcN9eZHUbmtBeH0DBK7jsO/MxRI72pCJIA3N2I2HkR6izN4ncWAVY0y9bw==
X-Received: by 2002:a05:6358:4688:b0:192:ce79:b64 with SMTP id e5c5f4694b2df-197e50f4911mr1498831955d.9.1716855274176;
        Mon, 27 May 2024 17:14:34 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682226fc4dcsm6536043a12.42.2024.05.27.17.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:14:33 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Russell King <linux@armlinux.org.uk>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] clk: sifive: Do not register clkdevs for PRCI clocks
Date: Mon, 27 May 2024 17:14:12 -0700
Message-ID: <20240528001432.1200403-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These clkdevs were unnecessary, because systems using this driver always
look up clocks using the devicetree. And as Russell King points out[1],
since the provided device name was truncated, lookups via clkdev would
never match.

Recently, commit 8d532528ff6a ("clkdev: report over-sized strings when
creating clkdev entries") caused clkdev registration to fail due to the
truncation, and this now prevents the driver from probing. Fix the
driver by removing the clkdev registration.

Link: https://lore.kernel.org/linux-clk/ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk/ [1]
Fixes: 30b8e27e3b58 ("clk: sifive: add a driver for the SiFive FU540 PRCI IP block")
Fixes: 8d532528ff6a ("clkdev: report over-sized strings when creating clkdev entries")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-clk/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/
Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
This change fixes v6.10-rc1 boot on HiFive Unmatched.

 drivers/clk/sifive/sifive-prci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 25b8e1a80ddc..b32a59fe55e7 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2020 Zong Li
  */
 
-#include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -537,13 +536,6 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
 			return r;
 		}
 
-		r = clk_hw_register_clkdev(&pic->hw, pic->name, dev_name(dev));
-		if (r) {
-			dev_warn(dev, "Failed to register clkdev for %s: %d\n",
-				 init.name, r);
-			return r;
-		}
-
 		pd->hw_clks.hws[i] = &pic->hw;
 	}
 
-- 
2.44.0


