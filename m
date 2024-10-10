Return-Path: <linux-kernel+bounces-358640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB019981F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863AFB2CD57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A31BC9F6;
	Thu, 10 Oct 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlhbXJRY"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD771BBBFC;
	Thu, 10 Oct 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551658; cv=none; b=GIh9PtP+dXWjviGAVfIDvzlMu9DQNayvLsNZQFNfO0E0GlRizRjFAunVkne6jR3Zi070dWSwiIkarT10wyEH1GfLoUlPbeKl3tRJTgmBp6qnokbO+eQYzOQX2VsDoexZ426Vljqf4uooNv3W+E2QpWxxqws6mbyQ5smdsItJE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551658; c=relaxed/simple;
	bh=7B20H6vzZwQe2Z6A8FZLKo4P5HOumDTuAH51dHchgrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bqRv5aUGHrha3f2uOwW04jnVAze56Wy2qkM0LZMjC77EXiBUyy5qaoy4BLMk2p9mNjJaSMOEe/xZ+gYazImHLcqbDvrEFC2xWD22qLYK2gNunssAA8rSWnlMmHTEzXjND0mXuxThDGnIwQezPMPlrGOQtzHD5z2u9xplpcsXEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlhbXJRY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389917ef34so720714e87.2;
        Thu, 10 Oct 2024 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728551655; x=1729156455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iS1oowt3gWPxEnT3I7D8ZHwjyqV0wJkTaD5F8v/SXSs=;
        b=OlhbXJRYg3CzEnwzoLXccBedyD1Xs+hyPE0+7616uQbT0+pzGAKfEmu2j1RY1Cn7bA
         CXsIURzlvNaMOtEwh4GA8FzW4obP7fH484a2fETCvVxGDqH12fY/It89y74nIS/h6E+7
         o0bQ9SEPmPs2YEZcrv+VyMXVmHQUcG0ZXuUE6pLLIDT9XyiyZU4m4aHz6w2cMZy48+nI
         C77KuosHqF8ai4kzNTlF1sBHjYN/pk3deuEcQeq6n/GuMR46VA68wf+fFtXmTXpJIQH3
         GXhW0jfHSvyDaWkfWXc42lhlvHQuM40iEO9jHIi2Ip6VAuHPFy82hvS11+6YVaXtkCHg
         bHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551655; x=1729156455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS1oowt3gWPxEnT3I7D8ZHwjyqV0wJkTaD5F8v/SXSs=;
        b=PpBkd4wzljO0XYkAEuDy46v6QQAFOxM/1xH5735VX2f2W2meWSymWF9qVlZcsXu7ig
         tYAfnpIczPiNaN8jTIRWi+3/uBO3jrrotb2EAX2XXQ48SGRjPMXQ7cv4FSATyeb6oxwp
         sK8CKwIH8035bo/HQsvu8woMtsygQUlSAG4KsDw1eE0eMkJxiOQriFh2ADlodVGPwdQw
         TS4UcvtVUNtkaEWYNFlMb3K586KAZMbdU1xQcoal1tXm4wQhNyVMAX9zoWvuzqEwoCJ6
         QVMyOfuytmxpduM7+c3p1g7SBbsqHyVOI7ocwv4qyyu85p8lSxxsVv5frMjVShemkhUJ
         Cvcg==
X-Forwarded-Encrypted: i=1; AJvYcCVcQOKIjNYsnsMUy3swU2Ys71j+YgIKCnTT/hbrfYypmvM2k7TWtl74N+0uDwG2hfaHPGmFL2AikOPKcAvPHDI=@vger.kernel.org, AJvYcCWE+iF9BNb8O6P/HQu7KpNzo4pLX4ZMLwR8V9+P+fAe29v19bzy/1qKz4JfXcJcMY0PU9iUP2DD2xOgBxSI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JsX3maBwv+DiM6Q5vLl5CEM2CQCcFvjBIDdUZgC4ahqJYKhw
	3Vwn46U2CZkl6KWtJhGKHevtdt2Cixbg4SiNXkNa2flAcrpsdlMO
X-Google-Smtp-Source: AGHT+IEabdPS/80LwHHvN4O9JjXcErRt0X3jKi/SEPXwMmL1sjvbwwX0uamKQJdfuWuquTPkH2rYfw==
X-Received: by 2002:a05:6512:104d:b0:535:6cde:5c4d with SMTP id 2adb3069b0e04-539c48926bamr3578673e87.3.1728551654907;
        Thu, 10 Oct 2024 02:14:14 -0700 (PDT)
Received: from void.void ([94.230.83.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748f0a5sm42337895e9.48.2024.10.10.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:14:14 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] phy: sun4i-usb: Fix a typo
Date: Thu, 10 Oct 2024 12:13:55 +0300
Message-Id: <20241010091355.8271-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments: wether -> whether.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 include/linux/phy/phy-sun4i-usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy/phy-sun4i-usb.h b/include/linux/phy/phy-sun4i-usb.h
index 91eb755ee73b..f3e7b13608e4 100644
--- a/include/linux/phy/phy-sun4i-usb.h
+++ b/include/linux/phy/phy-sun4i-usb.h
@@ -11,7 +11,7 @@
 /**
  * sun4i_usb_phy_set_squelch_detect() - Enable/disable squelch detect
  * @phy: reference to a sun4i usb phy
- * @enabled: wether to enable or disable squelch detect
+ * @enabled: whether to enable or disable squelch detect
  */
 void sun4i_usb_phy_set_squelch_detect(struct phy *phy, bool enabled);
 
-- 
2.39.5


