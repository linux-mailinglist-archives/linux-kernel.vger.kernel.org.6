Return-Path: <linux-kernel+bounces-170358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A668BD5A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33884283CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170E15B14B;
	Mon,  6 May 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnhVr/2h"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3F15ADBE;
	Mon,  6 May 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024643; cv=none; b=eCfKLudvBSXeTeGc3CnEFE4pcqF5sntMnLo0UjrE7QQRX/A319XmclSQ1QvBLiZUM5q+dlNIlIjGmWX6i47LKKnsVKuIFFV/A9ejthtVjSk829V25GKJ8memfI78i+GH3P+RZN1Eo3o3fHJkct6OVzvjJRSSDonDmrTtj1mIRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024643; c=relaxed/simple;
	bh=dI/u3g7LTMAIjInR6B7zv39It4pPEM6pc2Vvis9c1Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgnvyGZUe/GfeURd1kCv7YLQJx8wK+3lSUG3qnOkr43/MrC6fflAK8iLpp/u7OtmAvKdhwL9DJwjvqQeKP2Zyw89bg+35YBhXhEQ3xXFWTGtCrJfHPaB15Icbme16NHVMTsY5gLxjcjt69kulk8WCoTSZKkRYe8bEB6rSQysAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnhVr/2h; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso380248666b.2;
        Mon, 06 May 2024 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024640; x=1715629440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLmJpQfp0i8fR/OZHQc7F6SpjNiFbXRgibuQG4wYtJE=;
        b=dnhVr/2hTe4HuK8QrOMd99sfx//u4BAqb2WYJ99n4aSAKKAL85zEHLXw2aIoh0cBhB
         1jNQE1pskEfTiDt6QqqaHod4ahffvBa4UY7BYMl5uUj6h1Sa67EPyLhg/jcZOush1mH/
         ziTzdOIi0UyMlyw8mfhpjzcN/l6LynP2Xv6fdI3vm3TqPJAx9So3X7M+NK9qmN8HBrLO
         ZmfuOOfBLNd0L+zVN/gKhdcY3mkWAaz5qDaGn1quEOrCwuYvxFdYVmPsWJ0GNzRVjgJ8
         qWbjqf2y6L/7re3t6oVFeH/auV4MHz3UZxPhxFDTpPyNAdXQeMzPcs+DmRVNKyxDiCLo
         IWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024640; x=1715629440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLmJpQfp0i8fR/OZHQc7F6SpjNiFbXRgibuQG4wYtJE=;
        b=ACekcqziCxpGZ643gvY/v0U1gUcvxQqbG2QZ6WWZ0mBnkroycEPm8Ly1LGY39Cnell
         8EDzQH7ocQloTji7S/8DqSncvaOJvC0zAPtdCDWeM79k1FMk9RDDLhl9eIqDFvQa5Nxb
         6qZLdlmLw8IzG7pjCSWND/RZjAoKPlJJHPI/D+8nSGjhn4zI+cXnJ3Io5Mf8ERPe34Sc
         31cG2IbSJ9i5AlkYf8jEGbD1/+ov1JwlPDFP03WJglyjeWorS5phYQk7bh6RyXSCEw5l
         7afKiH7G5bXfYqWMX236edCAdlb7HONaQXjGhSKAEyTwW/xUVWDTtePf5xN4kzd3/scn
         5VCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQQ4s1atK//KKNgJIRWfnsQB4XaWYPUV+i4+c504HoWS/PLZ0AIfB9CzceGzEEk44Jj1f+r0iBzkOIXYyvuGgQ21Ms7eqeuU6S3guawMfl3a1EcNr1z0B+zyyRtrQazkPCiRUHAlj/OFqHhcNERGFtHayALf0EMXQZByhNglXyOYgJZQ==
X-Gm-Message-State: AOJu0YzBkcpskpdZOAqbzdLMPnUND3l1i00yhAmPByiyrLvBHjY9EJqa
	Xuk9nSy3aX3OStWTnPES/cb6Ak6RMv075afpy+9RfqGMOHx/Jw8=
X-Google-Smtp-Source: AGHT+IGDj+tvzGciAi1r06OdYCZHDNbAHnwx7wQTTzXXKYnWB5EWtuUN/+YC062uYGlKprlYMawinA==
X-Received: by 2002:a17:906:65d2:b0:a59:a727:1e8a with SMTP id z18-20020a17090665d200b00a59a7271e8amr4215668ejn.8.1715024640454;
        Mon, 06 May 2024 12:44:00 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:44:00 -0700 (PDT)
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
Subject: [PATCH 3/7] clk: rockchip: rk3128: Export PCLK_MIPIPHY
Date: Mon,  6 May 2024 21:43:38 +0200
Message-ID: <20240506194343.282119-4-knaerzche@gmail.com>
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

The DPHY driver requires to specify a pclk so it gets exported here. I also
dropped the CLK_IGNORE_UNUSED-flag as we will enable the clock on demand.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 75071e0cd321..a20d1fd25e2a 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -526,7 +526,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(PCLK_ACODEC, "pclk_acodec", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
 	GATE(0, "pclk_ddrupctl", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 7, GFLAGS),
 	GATE(0, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
-	GATE(0, "pclk_mipiphy", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 0, GFLAGS),
+	GATE(PCLK_MIPIPHY, "pclk_mipiphy", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 0, GFLAGS),
 
 	GATE(0, "pclk_pmu", "pclk_pmu_pre", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
 	GATE(0, "pclk_pmu_niu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 3, GFLAGS),
-- 
2.43.2


