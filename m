Return-Path: <linux-kernel+bounces-174570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DBE8C10EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834271C220FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF00B15FA69;
	Thu,  9 May 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLP1ffMg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3115EFAB;
	Thu,  9 May 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263625; cv=none; b=FuzBtFIHynWFGDsfG2ppPzN3TXCx70+uEUwK1N91TQlYbrPE19K71caKVbUqWoLNfC7UfYlGSVf2KryIBI0BLLrYv7zz4U88bJfJaX8KAMeUxFBa0+lMbX3v3I2LKZYFj6hxAdiDbKC62DhsE07AYMSKMgKKI8T1cn46NU5H2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263625; c=relaxed/simple;
	bh=Wa/CC5sxZ9kY4yNvSPynmLSupvk0jkdpLrwDD+8O47c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvbvC8A8sXDiI7xcOY6P4uMq3pB+6+XfpKCZxfSK2Waw1MnmciGMgGWe74he1d6IvUsh/ScLik/8KmUPR1I3tCqJ98HTOD/33TpkY9F4+g8e6+GZgx7IXDAAV/tUoN/QiErgmVp4uUj/HLblusuFgMj6dBTfAPg7PtX+GV04hzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLP1ffMg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so725665f8f.3;
        Thu, 09 May 2024 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715263622; x=1715868422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7sDaxG0HvtHzdSFKGwBhhlzSS8/ejghi2usyHe6yIk=;
        b=jLP1ffMgfLVHvSo5N5xjWrLjsQLQCnL9Lgn2kUBWFYfgzQqnpxH5MJZA+/oP/HO5a1
         F8z12Ol9YJitKQhwfT/b9cHnI8zlugsmTTTzbQ1tdVbqOTU3P3sPzw7dyVuKSHLvca9m
         6Zb7EqdXhI5VHbn9AcePwlLe/CvRfWJF5r2iwgLSWoAP5W3/oKYgSY5zK2bpZEf043xa
         Q2ztDcO8szB/tpFfycMDuAD5BPkF2ZcwNdUBbjBx7o+1rAMgrddrPEpiVrbQpurzjd+p
         a9NYbEnQK9yIixwWsx3JoVL6AZFl/9K/5cG49WzUW/qHDvZEPAa1OXiiHYm6UFj1iqgY
         RK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263622; x=1715868422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7sDaxG0HvtHzdSFKGwBhhlzSS8/ejghi2usyHe6yIk=;
        b=SUdDuDUUSNFeIpxmHHykxtS9/IUJr0epePHc5vDchg04jB7p07dujXI06fwtQdXyH3
         xwKbkHmLOS+ujKm212CF3gbnI1AFwoJYtNKDB7ShG6wxGMKB7ezzueOZj8/Veyv2VJkQ
         JQINHxf5OnG0O165wF8tnB9vkOcIr6k8KAB3Ck+MPVXBxyejNlNMTySSZHw3lzlw3c+K
         753AUPG3MCdc8gflVmNyGQqOWo6hgidgruUZ34SIBUxfvNiCEWbtnM7Wgs16Ilj6KxOh
         oQ/yz7BW3yF1cVbMCDiymZqVaOylTfl5QEsmfeYJpPK/XFgc8ugYx/LVdaYMdO8THgQI
         PejA==
X-Forwarded-Encrypted: i=1; AJvYcCXvTvUvXd9KScQSrfMWbin9kLvzAgxoo2osYCG03sHy+ZNk7i3mfS5SY1XNSjkw1ueMfaz9Vi4yUq1BA2EZD4pnt5RGoJlYGSEWi5BUt9Tn7kXeNwc7T6XS7efIOPg2pcjPEZ73zfRKJBfy6TlRauaCkKAMbwZDtuHCWUViF3YDplTD2w==
X-Gm-Message-State: AOJu0YwR5q6slP+0vud+yix68ODIszwvUmaBjjwoyTlXfqmW+hkygsXH
	pIoToitpKtbttNrBbpHsMasGB4WLWU9cIdvohp+KMqjQ7pXDB2U=
X-Google-Smtp-Source: AGHT+IFljPNeI2NnGG45C+k3hGACkIN7MrrcjptnJgVqnmjgLGPcaqegGP1B5NCUyh20R+F22xanOQ==
X-Received: by 2002:a05:6000:120d:b0:34d:8fac:9540 with SMTP id ffacd0b85a97d-34fca80df25mr5625135f8f.59.1715263621985;
        Thu, 09 May 2024 07:07:01 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm1793311f8f.66.2024.05.09.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:07:01 -0700 (PDT)
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
Subject: [PATCH v3 4/7] clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
Date: Thu,  9 May 2024 16:06:50 +0200
Message-ID: <20240509140653.168591-5-knaerzche@gmail.com>
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

The DSI controller needs this clock to be enabled in order to be able to
access the registers. Make it critical for that purpose.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - dropped patch
 
changes since v2:
 -re-added patch

 drivers/clk/rockchip/clk-rk3128.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index a20d1fd25e2a..d076b7971f33 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -563,6 +563,7 @@ static const char *const rk3128_critical_clocks[] __initconst = {
 	"pclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
+	"hclk_vio_h2p",
 	"pclk_peri",
 	"pclk_pmu",
 	"sclk_timer5",
-- 
2.43.2


