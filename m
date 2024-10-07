Return-Path: <linux-kernel+bounces-353316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA44992C27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C0280F79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E241D799E;
	Mon,  7 Oct 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y+a5w9LC"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAF1D5CF1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304805; cv=none; b=bcHQe5kL5gvmyFBsodLyYrXuJrkd7s+KmYdy7tueCQSq5HXBG6SUDx7KgV3HyPXuW8V4aR+oplYm5aJxwci91LGjelax5xR6+99BlCLoqw9OIvo5lcVe5LTgaWfxxpBFSQmQ0cVwTTpyCz8PRSoVJE0doYKPmnh0nMGwWg2mRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304805; c=relaxed/simple;
	bh=rKJ6g2zPe+AmVP+2VuYqwsDW7Vw/1jwj4Zek+anRIcU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmVo1PfufDk0KNBKUxTgBAAZ+MTCsmmzUHhBPP/BgnqazwzZeHgw2vXxhce+4LHcrTXtgE3TN8yEWG57Tb/fwnxI8kDQmVxQLtSbk4Q2Dd4x76vXbTUWCr3adtDY8r0bbPZduqBv+Y1ibr3vakEref7OKd+aXqxBLgCZGba1aIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y+a5w9LC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad6de2590so62796721fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304800; x=1728909600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExSdnw6SFXuTqFss0pRdd0b0/LidGX7ZLflADrh46f0=;
        b=Y+a5w9LCEkrPe/97xbWkIUVEbCJsXgQq1AclnQtmslKDC3U6uIPf+5mlE4yDFV+vNT
         tkmxVQLX4PyRWDO2CdVQgHbYoJ41yLwqsPq1OBtgbE4FhjS1E/0n1Zc5ZW97XEd1B2sy
         nFvCgIkMBdj7EhPL/a3aK7CgGef+x2sihCM4pWGQNpJa4x1fGXipZ+IX7rmjjq/HAILd
         SB0Q5+TgIfWoPkLuy5xdLM0jEIAe4n9sQy9utcc0UosmZ9381X2O3HT77CfkxJmwSOxD
         sI5yPgeAWwimWvXCo54Rd87D2w+8eaIgXUFmnBpzM6ndnXbQpCxAlwsqQ4g89VmFrj0i
         Setg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304800; x=1728909600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExSdnw6SFXuTqFss0pRdd0b0/LidGX7ZLflADrh46f0=;
        b=LHJ3ALFhogj8RiVe9SKdAZYV+fZ4EwJtiWZdmfnFheE6Bo+cXb6Gh5nunwsulSP2ZE
         2FgnSNamIUnuLpS2bdkRndVWH9R4u5r0QwP+TBp+8UvjyqYdnaEZf/9R2nMs98rJevKW
         tQSUB63ZaWD35r5uY8vfroH6jqM8HU6jEUOFS094R/GuG01hieMJ3b/bxAuXgNUSEh6E
         yHccYyfVvkDLMJEPplfwMOu2mMCvAlxBkE4/GyF2KTTc216SdSMjk8j69kzA4iFk/Y9m
         QB0fecfacBOEnwglxf79vye/mrTwgHM7JZ2GfNpOzONQOC51JudgkBi3YO0/cCYmzgaS
         wKow==
X-Forwarded-Encrypted: i=1; AJvYcCUHCQ4IA/Ad5lJLGlFq0gaQWVPKYoLA6A8+7/t7XMQNr4nNlJERmZq8c1TYuE1AFCCpEAzGuzAqKAKMBcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmApEmWVRuCUL0w1uUw6y4HJOLF0ostnzp4YR0OzbmMRaN5Nyv
	uamREpc5aMIU10/CSxjgoSxgKOvuwIQ+lMI3YCNYMdbDImckZyTmZSF+9YTVpAc=
X-Google-Smtp-Source: AGHT+IEF9XJ972EaXIB1RBwBhfHiOI0VXfiBlhriuohHhb22fhgxmRK3EvHrGiaJhb632gUnFrOgqw==
X-Received: by 2002:a2e:a595:0:b0:2fa:cfba:fb7f with SMTP id 38308e7fff4ca-2faf3d797c0mr68500231fa.40.1728304799933;
        Mon, 07 Oct 2024 05:39:59 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a3a1badsm327549766b.161.2024.10.07.05.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:39:59 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 12/14] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
Date: Mon,  7 Oct 2024 14:39:55 +0200
Message-ID: <d9326d58c310b010aad34235816598b5004e13c3.1728300190.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1728300189.git.andrea.porta@suse.com>
References: <cover.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RP1 found on Raspberry Pi 5 board needs an external crystal at 50MHz.
Add clk_rp1_xosc node to provide that.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 6e5a984c1d4e..efdf9abf04c4 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -38,6 +38,13 @@ clk_emmc2: clk-emmc2 {
 			clock-frequency = <200000000>;
 			clock-output-names = "emmc2-clock";
 		};
+
+		clk_rp1_xosc: clock-rp1-xosc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "rp1-xosc";
+			clock-frequency = <50000000>;
+		};
 	};
 
 	cpus: cpus {
-- 
2.35.3


