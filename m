Return-Path: <linux-kernel+bounces-301906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8195F72C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751341F2220D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF819754D;
	Mon, 26 Aug 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rYqooKhe"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1384917C9BE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691206; cv=none; b=nMV1nXB08q2RqBQX5jhGG2KqMSMg/CSzG87hu033p3eKxaWWoKdbFQG5JR8SyZZrMIOyLxYVsC8pAUQnPNUPX3DuRwckb1BWeyojIYYgR/A5zeFDGGTDV+H+qd6CszBBTu0Wqtd+fCCTicc91x4GOVMN8VDnE5fjSpgkzgFwtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691206; c=relaxed/simple;
	bh=rmj7shebkYHEW64ACVJMy7FigpvHmWzfZzC1lRr1wqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fGBXRuXzEF0owelaADilokeQJmpFUGKeuBWm9vl4/C8fTJmfHO1iaWRWD8s3kXb1VCdfwOdVjYxLRwiaiC+0oLTORVlG7PHe3CMxv2usVv+mPQIM95/UJxyRbsA1kWUxEoZE+Iqpg6iprq+P8jlIGEmZoVnXr/yn4gHnC00LuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rYqooKhe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334adf7249so5430236e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724691203; x=1725296003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGLsnkK9AsTIF7e3SpOMVdK9UMEpCK+HnPppRqOfRwM=;
        b=rYqooKheIlboDFdqZOJCylpHohPUAo4hIpKyIv+d0EPjD5AGZaMdKE5akqus5SZNkd
         e8dvRvunXduQM155y7hh1Ah2Bd3UKjKIhhrlPphaJuaPDbueE+tg/5YrnAWRfi1bpijX
         nw89y1cSIXQY78uLULR+VlBFugG3Q3ajNKSAQA7cq60an1AW/Yd+ETBxadPTruNz1CJM
         LcIL1eQ9esJ6+jbql2JaDmypp3EWD50wC80uIGr0oYiDzyDcRdU7RRgNH82Nv9s57OMU
         CQtZ/MMc58erHyVbfD88G2SC1hDWkPpkwOyKrOg3qtLFXzcP4dx1FA1mScgBfiUysbNH
         8SXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691203; x=1725296003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGLsnkK9AsTIF7e3SpOMVdK9UMEpCK+HnPppRqOfRwM=;
        b=vDv6rQlnttvwa2u45FlAqNRJ26V21DRxqvpN7D4NtDAlZluEg+4WtZmZ7SerlIrqAn
         LaxmwQpd1T9uNEb+/PCqwB5ONX56beNKY/WdIJeB9jLi84VoWvdoyu5EiW82lHfEpg/P
         T2ayjn5lW7NOco3gpKwAzENKpKtzy1JOyV9E5L5iu0Gc3eDZnL59p1dmALT6DQtlhhuL
         fT6gHE0Zdrm7elKhHNQoDQtE1LlxEjwAjewqn2Nnp5J31dJIHAh0YPMCYnp0T8pqUI6m
         f+cU6q2sAaeACcTScWH1xknB+aMPpbWTNZb9WX+XdLjYclkoAB/BdQOMFll9l5NBa1Ya
         nQxg==
X-Forwarded-Encrypted: i=1; AJvYcCVVjJ7Z4HgQBos3FQWVfAhTTkTSNrl3puZPogM4u+MUM8BFqmc9e2a+aR/Y5oZHLUwxh2c5+iQer6fxkCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivjheqAA3psVPDyjR1GsTyA7XpCp5V+8/BTLevJ5Z+0IxSiTY
	3ENJQUk/6Rts1pIuHz9y3SkLVgExQV/XEo2ur6I0qeOa3skzc3SQKWLp8hGGXz40FwEzYS0fBVP
	j
X-Google-Smtp-Source: AGHT+IGx1wVe6xHZoqchHEYFF0n3KqIl4XuBRIOgXSFnZw539abdTOKOAbD9JIe0sY5rs6hW/R2Y7g==
X-Received: by 2002:a05:6512:23a2:b0:52e:73a2:4415 with SMTP id 2adb3069b0e04-5344e4fae2amr4640e87.46.1724691203022;
        Mon, 26 Aug 2024 09:53:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436ba2sm681556166b.120.2024.08.26.09.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:53:22 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	eugen.hristev@collabora.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] ARM: dts: microchip: sama7g5: Fix RTT clock
Date: Mon, 26 Aug 2024 19:53:20 +0300
Message-Id: <20240826165320.3068359-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to datasheet, Chapter 34. Clock Generator, section 34.2,
Embedded characteristics, source clock for RTT is the TD_SLCK, registered
with ID 1 by the slow clock controller driver. Fix RTT clock.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 75778be126a3..17bcdcf0cf4a 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -272,7 +272,7 @@ rtt: rtc@e001d020 {
 			compatible = "microchip,sama7g5-rtt", "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
 			reg = <0xe001d020 0x30>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk32k 0>;
+			clocks = <&clk32k 1>;
 		};
 
 		clk32k: clock-controller@e001d050 {
-- 
2.39.2


