Return-Path: <linux-kernel+bounces-232515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968291AA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E72D1C24072
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE6197A87;
	Thu, 27 Jun 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="nGEZVwIy"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7B197A72
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500489; cv=none; b=gbIbbmb5D3bG7cbQVSQWrLP1TVsWxh5z13mQ1bwALNJaVuJJWJjVWDd6AIvPM/ZEqY3YzJoxRP32ARmdDjj91cWabqMjom4C4GWeAxETVPHxdPOXxXphZ1SlM0u+bJojka7+g9UG+MibOsTZJibABuh3iq9pWsZEFA5+gIRh6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500489; c=relaxed/simple;
	bh=/+0HsTEIHWvC/B2RZhsHb8iwndt4VfKfMx8j4TDepXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skBbNgtojNeoskv0t9zQ5GoXYiyR0e79JOmYLL9TUVG/Ft8mKO9SfeVhWKZxlruQs4RF0G9S0XGPNg0Ue4xb2T1UX/0KfLQwkJYEy6eOvLORfUaKxq2oJNUfuZ97ida+zJpBU+n5NllVlbW4q8+WNt6usCv1Ru4Ua6shezOL3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=nGEZVwIy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d457357easo1876126a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500486; x=1720105286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a6tf/qTdWDt3Tjpej1OobYeqXk77XY7cVTYcp4zK/A=;
        b=nGEZVwIyAYTwkWcNxSi4xKJJZ77Al0psxmG2ruo5RESBCcfKs6zllLNMlTU3x5nCwc
         livdrlhtvSmFVuWU0/XkuaT14RAibzmj+puzrJbIiCB0pui0NgMnjj8GTKPSKZ32raCR
         Rcw7VSErCgZHSXNXP0WyifQGWYFLFZVUE+lVUCq34U/FMacxlg08Tjyn2RACAkobS048
         bntJCBPbErrGHk/oTaJx4d749/Ly/Zkb6xUd64xPC5se3Zabc0JzMCDhCM4WXs/FOPFY
         BnxTqoEtjLoKwHZdYuBumQ37QsotzApifF7g5oqS7V7KMvJn15Syr9M7rzQxNYPzonVT
         fypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500486; x=1720105286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4a6tf/qTdWDt3Tjpej1OobYeqXk77XY7cVTYcp4zK/A=;
        b=afWfbpPhmP3s81ZuWUjk6emouUHtgGzQgHVkdHSFb7CLjSFX1Yuf9SJZoNSOzGE/g/
         wUFvTBuUmKMH5fl7a+Jf40NJv/jolqpVU3H1le8DYI8qkIMLGVNZiK9BDck5pemHB891
         vgPeZSQVkTkD8lwJq7kBE5HA6iExRwV3cnNJ7/NnDz8WvbZ0VDe0kKbwmcg9aVExdbY7
         WsPLH12Ic6htueEmabHl548KCsTZ5gf9VAGYXpGN/xYAF2D3uLifKyPoY3Fktn4v7g+D
         WMPImhrIQSrJgZdreVvzgtEW2UeHNtMvD9ADAkaIsCgR1ldrNgyAepIVRPgK20Wc1B1Q
         sGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWS7fLqVvZQH9ax5YbpgMiWuwwVfrTaQ+kD3F5iFeSyqAjpQ3qRnn3QuJmIEPS3JdtL5DUcvC19DzGaXGHxM5kVDxBt6mFoKwTjpV+M
X-Gm-Message-State: AOJu0Yyz8rR94mpKdkNvx3S8Anr9ZyH/GkXdp+p+t/COCPHltgCpTLOW
	IgY3WEceHEBXUfFKkrFwZ8Iic2MEX8Kcc4OnCvsydbFhVvDLyWc7wtbbSxzVQ2U=
X-Google-Smtp-Source: AGHT+IFXCFq1n96sdM+EJa0YoZN/nrFqErXffElfAdyQDTZKHkn50i6FKtEEBJOwTL4yL1Vq+tcklA==
X-Received: by 2002:a17:906:e215:b0:a6f:b78a:b39 with SMTP id a640c23a62f3a-a7245b6dcafmr796279766b.1.1719500484672;
        Thu, 27 Jun 2024 08:01:24 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:01:24 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	Corentin Labbe <clabbe@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [Patch v5 01/12] dt-bindings: dma: pl08x: Add dma-cells description
Date: Thu, 27 Jun 2024 17:00:19 +0200
Message-Id: <20240627150046.258795-2-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
References: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recover dma-cells description from the legacy DT binding.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Fixes: 6f64aa5746d2 ("dt-bindings: dma: convert arm-pl08x to yaml")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v4:
- This patch is new in v4

 Documentation/devicetree/bindings/dma/arm-pl08x.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
index ab25ae63d2c3..191215d36c85 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -52,6 +52,13 @@ properties:
   clock-names:
     maxItems: 1
 
+  "#dma-cells":
+    const: 2
+    description: |
+      First cell should contain the DMA request,
+      second cell should contain either 1 or 2 depending on
+      which AHB master that is used.
+
   lli-bus-interface-ahb1:
     type: boolean
     description: if AHB master 1 is eligible for fetching LLIs
-- 
2.25.1


