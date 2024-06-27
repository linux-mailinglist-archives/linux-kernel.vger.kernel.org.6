Return-Path: <linux-kernel+bounces-232519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E314991AA33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F931F25E70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F8198841;
	Thu, 27 Jun 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="YxSf7E1T"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1C13A245
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500561; cv=none; b=sk6sBGPy7m3oxkqlx9eauFwD3jniuLBHeLLPjNF5aLsiQY6hvtbTJOwz08bZFnd7ud09okfrieZZJ7WTGiBPMd8nwEJz0GmkJ0nEeOJf6uP7jQp41KY0NnaFSwcRty75hCMQOE63Bta2NMtQdT1y6QHRH88CZPEyj3yQ1TaX94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500561; c=relaxed/simple;
	bh=8swFldKlKLstLXY6Asg2tgwwu4NDMzYCnaw9E3FvaAg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAAboCBclZEviy7GcX5FAsTJxXsThtfVvtZWGXn8pICCs6MzCuwrwyQHciPs4dWDmO6nw3YYW7dXlS2RL+axodBrAeoLoSF1Y3lcDGwlejeLVanAjoAkDK2NXt4nt0aAqtsTYjamSSMsSfE/IQeJucYuhjLvDHCaPbGqqji6wlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=YxSf7E1T; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a72517e6225so642731266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500558; x=1720105358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9ppopi9ppNssy3Y6kMvZbEvjKhcjUNqGrL0dAUL4ao=;
        b=YxSf7E1TQ2QCVud/qcFgSbt0Ks5V7IlA1YBkTSCJ7Hxv9usyITi8yY/Nc4wruyEmfA
         kE1ceJl7uIX93gmUZPwuMKqcEbBB9S++h3HBtoE7WNCFgfQa/vfDjuT/j5Zfo5T4aRpB
         5nIEBW4n5WVqgOhmlY05cLCCF9ZOe3r+TIVH0FnE0jD0AqRCQnB6RVONso0ugsZra30Z
         Epwj68m2/rogO4qKGYQGqiNvE0uMLA9c2Bxgv3hLwVCjidlH5UXbT8jZ4wsmkz5glCVP
         mgbb3EPMLpuL/+JnET9mz+7B+ye3/zQUT+hgThUM7IZs0kWIOj1gSkhc4FxhO/KC9YYj
         BV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500558; x=1720105358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9ppopi9ppNssy3Y6kMvZbEvjKhcjUNqGrL0dAUL4ao=;
        b=jV0oWHNqdzuJXEYJY2eOlxKtD3TO8MJ1YiIb44f4THDyIOeM1zaDo0S4K0gNqEDCfu
         gCjLbU1pRtvcO9yKeENMnxMks7KO6jAglXSlhfRwcmBjjdVg5VfbN1e4jsHFNMvE6DZM
         q8hBelnDDhX/Z2zJlTGV5upuVDD3+cOCda91KRtMQUgNvmfjnh2R4jJ2cpYYV0n0GlIH
         KyeTYMePs1WIDL4GzoimfXjD6D6iuzHBDHnSWBpZXwU1PWMgn12iLG6wEcET+aDOKejE
         KpREbiQetvN24gkR70BM0VjZV1dUPDuxR6gJ04J/nSASjV6pu6AyFpq/Ms4+jf/eWmFN
         FCeg==
X-Forwarded-Encrypted: i=1; AJvYcCUm9kcFF9vPYeIwGWi4k8CRiPjE1QqxfL1QELDWNAhnGG3EbVzL9BibMWGRBdv5MER/mtOXmj2f74SQsAv2+5TRvdhCyrwFaldeHQUZ
X-Gm-Message-State: AOJu0YxQMwoC1gwIZRgXiNAJW0t77HuJ8jWxBmffscxOfpIqzVOqYugo
	0be7p93AhrM2OMNRSXDcPPgWnl9FQs8wBmha2CCDs90IYaMOXLvD2/ljaEhs7ME=
X-Google-Smtp-Source: AGHT+IHNxN4PmRPFk0RxdcCHSntPRfVHwfmOqM6zTS7G+/s/UPca4WGfngbQvLyYCR5O6HreQqUr+w==
X-Received: by 2002:a17:907:6a0e:b0:a72:8296:ca42 with SMTP id a640c23a62f3a-a728296d1cfmr421637966b.49.1719500557261;
        Thu, 27 Jun 2024 08:02:37 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:02:36 -0700 (PDT)
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
	Yangtao Li <frank.li@vivo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [Patch v5 04/12] ARM: dts: lpc32xx: Use simple-mfd for clock control block
Date: Thu, 27 Jun 2024 17:00:22 +0200
Message-Id: <20240627150046.258795-5-piotr.wojtaszczyk@timesys.com>
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

The clock control block shares registers with other Soc components

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v5:
- This patch is new in v5
- Split previous patch for lpc32xx.dtsi in to 3 patches

 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 974410918f35..8bf88d141e5b 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -312,18 +312,17 @@ fab {
 			compatible = "simple-bus";
 			ranges = <0x20000000 0x20000000 0x30000000>;
 
-			/* System Control Block */
-			scb {
-				compatible = "simple-bus";
-				ranges = <0x0 0x40004000 0x00001000>;
+			syscon@40004000 {
+				compatible = "nxp,lpc3220-creg", "syscon", "simple-mfd";
+				reg = <0x40004000 0x114>;
 				#address-cells = <1>;
 				#size-cells = <1>;
+				ranges = <0 0x40004000 0x114>;
 
 				clk: clock-controller@0 {
 					compatible = "nxp,lpc3220-clk";
 					reg = <0x00 0x114>;
 					#clock-cells = <1>;
-
 					clocks = <&xtal_32k>, <&xtal>;
 					clock-names = "xtal_32k", "xtal";
 				};
-- 
2.25.1


