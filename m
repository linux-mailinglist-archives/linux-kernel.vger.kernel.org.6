Return-Path: <linux-kernel+bounces-423830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496E9DAD56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE5F166313
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4022010F0;
	Wed, 27 Nov 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qBdWizEb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193A13B2A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733284; cv=none; b=f7B+PD3fQJevuVKF+osE6yts7N5/my478ZvM0edWtnioX16g2/oBBHedTIByJBx8ZddtsVlExWEdDOAUQB8Dk/b2iLoUt1evL41ZxgDer9PxKU7uIUXCaOAS0rv9B/KV4QDgSZbhyjOQhhDTLLwEWeK6OxBYMB9dhA0a9wuNATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733284; c=relaxed/simple;
	bh=NRkynitJcItte924uDQklomHInx09SX2d6xRgfzqXGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mA5tywGHoy0o3a4vGWzKj/to/uifL4+fAtaqmWybuNf5wduP7pzV/qWmuxon1WkoAVe+3Tf5r1zgnHeAbv4ElqhRoOLV4uHYFu5ESh6tD0nmEuLxnjvxTylhOG/iyryT+ZhGIQpNMCu3q2i6iW+iS8l6fzVtBdIl9dkvzuvO2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qBdWizEb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d866f70fso64628195e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732733280; x=1733338080; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcpw02mhb64jdwB+dNNvFHOzRMCWmmfGsK3Mw00EgFs=;
        b=qBdWizEb7/PmB2KYH0aKUsVMt5+xEV2kXU+eBfT4gkxQf9V6fwJxlaI5DlAODFuI8U
         JIV6GDa++/pVOKHk8QojSbyLl218mMGbS2x9Z59XJ6QihIqOwM/b3Dxof/4TfdCnepQU
         HOiHVPbUXb5hvvxhEjOcKiYyCfa53VXOZjflpUFiS2yNT0FTZ9FmHBmY6a9IX7LYGef4
         9njDh9Rn8mAc/Kj2dlYunXBKCIDhvPcoJxUaQF9ZEWNapO4baUDvLXNw1QS+7OHUirnm
         S+YjOgKdphsPSeAz8F57drzIkHgDS1Xcl9/+Uzc2FwglrXCO0I57wn3YklomGx1oz2Yh
         zwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733280; x=1733338080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jcpw02mhb64jdwB+dNNvFHOzRMCWmmfGsK3Mw00EgFs=;
        b=UN0Y6O/bi7SqA0jsTGKwdEDmcpp0PwN1wFVzWRxjC1brxWKjXbZz5EuAhRHlNTNdVR
         WQ2MtLiLFeDS+p0hsut2XiMdsHe3qX6ZGkt4NGiSy6SStnanZcZq5PUYtXhcs/cMd+Bw
         M51B3LcL6mj7+IHKDL4WFgiIIgwLl55HDKKKoZLLBZVkU41DlS1+GKrwCJ9MKipLMK2a
         p4ftdWwpjnm9LS9k3g5XC06NYIpLpS1AU5RpevbQka+KhQldkCNOBZLh8fPJv/4XrDaI
         PmQteKMuMbOAcQg2MaFK7WSTqlJiF/X0kQOIhxSJQFjsyS7mBmAUF+askUwcPSi0kgDW
         sq0A==
X-Forwarded-Encrypted: i=1; AJvYcCVUYN18JHyNmgP+Z43WNPsTaB+V12lvWKPVHMtTrdShfw2jqqsp/oO6tzA7u/N74MrzXP71yxMBYm7ANl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+7nIUJqZpaNmE91LlHTD3nKNkBl4ox/2vPYlFBsSDr+CjPiK
	mI1WPdbJ1zbOnc3yVhVFy4LFmPY2bQ+tcwbsv3KzemBn7PiwFg95eiRqJHexfs0=
X-Gm-Gg: ASbGncvq/CCyQ+Pc1Gbxesl0FdFirhKxpy1Pq162A3t3cmPLLqtw2nwV5po7I5SFCH9
	Nznhx14U2sd7sXJJEzrI999IhGoCe+3zaKfWatn21vQyuBjYR1fzkAE8g78Ef+EDo5/W0t6rHrb
	Ow6iWp5Bj2mO+a3u/kIplmbznHu8+3eTzPw1bO+6axjoIrGtPy+Qkc1Xif82CnIG+Ty/L6M1EE+
	Jn0tnU6EopR/VXjrbj3OGRIISGnTZGXQmY91TFEB8Jw9XUD2h/u9jgzVjyaEQD7
X-Google-Smtp-Source: AGHT+IGr99n2pgmmmlqNTfnISk2hQpeyV5JpHyTyMj3WvVC6iQOTmJfEucqeLNOUYv2B6leOlv1B8A==
X-Received: by 2002:a05:600c:3b88:b0:434:a765:7f9c with SMTP id 5b1f17b1804b1-434a9db839emr37961625e9.6.1732733280392;
        Wed, 27 Nov 2024 10:48:00 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:e571:5afe:4e1b:8936])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa7cd343sm28854325e9.22.2024.11.27.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:47:59 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 27 Nov 2024 19:47:46 +0100
Subject: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFFpR2cC/x2MWw5AMBAAryL7bZO2xOsq4gNdbFDSRSTi7hqfk
 8zMA0KeSaCKHvB0sfDmAug4gn5q3UjINjAYZVKtTY79MmN7Wt5w4Bu9HLiyCLsRVVeozBS2TNI
 OQr97Csr/rpv3/QB9Wvy8awAAAA==
X-Change-ID: 20241127-clk-audio-fix-rst-missing-0b80628d934b
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=NRkynitJcItte924uDQklomHInx09SX2d6xRgfzqXGA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnR2ldNqnF+hCENTkKMXcIyoeqe6vo64sANMP3G
 v8+TpjiOVeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ0dpXQAKCRDm/A8cN/La
 hSHeD/wMqPZGojSkTOSnh93vp6D1DDTdHNlEehKY7SxVGlFjp1RIE64G28ltFd5voZCdRTuaaRG
 E7Log9CTOmBf0nReg2WINO1FfRKR0AC929HkeUFdKngXVIBSieROtVjvz2cRJJ5AAVFs67a3g22
 cFaPyFy1rdmlP+rqcA2RyfjXtFohm2WsSKtUrColYXMr1FLcCwvjWrX/KFUQTeol+pAwtk0YjMr
 MGn6ucKC8BmGeLn/AIsUjy9JJJSAt8EcB8X0q0+6lgIpOIjm0R8Lcc9RnFdBbHVb/Sx87xHWoNV
 chtT31Nt7LScLqDuUJOOyZCUPhFQ1WuF/SzPK/l9AjXBW9S0s2tPEsG7AMV5Jl6rlEdKRTuhT+S
 MYRfsbw7uLbydPEDIY9g+NjUBdnpPOYqFqrcwb/pJKqAq4vu7bKaYrvZoeew/YFho1WMB9gZMCu
 DObmWT5CLGisIXCmqTfsI7oJM3n8RwRHjxXrkYGl3M/IMiItcT3pi4o7jEzko+wlO1MqplRrrPS
 NN64QqczvMiS90HpiHmFxyTEJshpkD3x2l0HXE5dmwkcRN/A8xczzcuTU54dL66wNZFXhwcJ5hI
 GkGP98Y/CD4Mb/BTFu/UZrpZ12QdJTqzWMaXWCjtE1BYTnHwGK/SarH7xJJht27F/rdqDsSY/Sg
 i5TH5EzTDzIOlWA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Depending on RESET_MESON_AUX result in axg-audio support being turned
off by default for the users of arm64 defconfig, which is kind of a
regression for them.

RESET_MESON_AUX is not in directly the defconfig, so depending on it turn
COMMON_CLK_AXG_AUDIO off. The clock provided by this module are
necessary for every axg audio devices. Those are now deferring.

Select RESET_MESON_AUX rather than just depending on it.
With this, the audio subsystem of the affected platform should probe
correctly again

Cc: Mark Brown <broonie@kernel.org>
Fixes: 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency on RESET_MESON_AUX")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Hello Stephen,
This fixes a problem introduced in this merge window.
Could you please take it directly ?

Thanks
---
 drivers/clk/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index febb5d7348ff07c2da0cb5fd41d2ad2607e5bd5d..ea16bfde0df2d7bfebb041161f6b96bbb35003ed 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -106,7 +106,7 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select REGMAP_MMIO
-	depends on RESET_MESON_AUX
+	select RESET_MESON_AUX
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.

---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241127-clk-audio-fix-rst-missing-0b80628d934b

Best regards,
-- 
Jerome


