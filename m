Return-Path: <linux-kernel+bounces-568869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477AA69B76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2614826F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB1221D8D;
	Wed, 19 Mar 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BCBLDxTS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBF1CAA89
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421104; cv=none; b=kUXwXPMmA82liagOVE7PLxze77t0tSRa8zplaLL48tSmtPQ6CSDACrYEun9FbFzboF3vqB/le9xJfluVY+uIYKLol+XEGnLCi6TN1LaNsgGDLtC4itSfnOy6ueTGnVX6nlHmRAxrMy/bgXef+6gGhYMHGZW47F0C9ed763OkobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421104; c=relaxed/simple;
	bh=VtQ1ljfmYtyXEA61aEiaZEeKdDz/H5SMisehIOwJ9No=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfTT0Co6KGgVw6Yzsre8H0AAM6qn0YsfwZLyknkhbpQAD5Q+AL87PuOMSq5ffSJMFE6s4f3Jqgo1C5lbMzHCBMsv1pEzLtMxlJMtArhqBGcxnKiriPoIxIQtTB8ul3rCilcGpft+RxtiTv4JA4/5RhGePLoYCKlxwYCzCFaprTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BCBLDxTS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so27940466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421098; x=1743025898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB9s9VPJvR605hRqbfbYWWEdTsjP5s3VD85/JJVm1e8=;
        b=BCBLDxTSCQT4MxWH2kbXJnfyq6M7A65z9TGlIyVlrP8ebPzdIzyFe8K8N/p8gWMTOE
         sXDt0mdr0+wB3B6u4ZR4NAUPVF94C5D/7UNGstLrZfA4YEZVQ4cPxciITIZdUqTRju6r
         iIRrzAhT0zE5BPt7PVVIpPiobTuwn4ho+ybGoBeEJ5ghO05+5VoxDxRxYHsKlJ6FTBJg
         S8LtDc4SoATPzBxYCn9N0/vOqdPx0KKkmjeqF9Iv7H1BTM6LgOx4zTzpOrntnQqYseKg
         1ETxAPB/5yEYo+Z6uXwS2QvMmmzgAvd7940+BO8Twu3ajlC/A/bA3CHvH9R4/fSFjlk+
         SGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421098; x=1743025898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB9s9VPJvR605hRqbfbYWWEdTsjP5s3VD85/JJVm1e8=;
        b=v35/5Ft4WOQYa6zPnMIfYKaAceucm6faaKvSaEZJHP/pQud34U4XsZFIqksc/DDXw0
         WHp/kRLQYBUBz948PAU9jcH4ypM2958sDExbwZESRCjVgVU9mlUnBJ2yeYyEPK0My7Tr
         Bu518C1P54hc9aADGtV8Wh1ltsPrPMl10OV0Sq0R2kkiADhHiuhG0ZsVYv/RRozA4KtW
         4Ym+lPEfmVUYyUHCZxTKdmniiY38fyi9aovNco7GBVsQoafz5YW7WBaTgdRmwQ9skH5d
         EeU2Z/HePwm0/Pfl1lx4l8VtXTaP1tAaV375NzdxWkAcdyN7j8ZGXNJzS0QKGhnI0YPX
         z71g==
X-Forwarded-Encrypted: i=1; AJvYcCWhPlYKtsmph2DbyKcTWmtGUf1gB9T3hDLQ0WKvGucRX6I0rP4MGOue5Cz2Im+u3jnurXrBb6iRP62qMNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxznj7WpOKahDFofy8ZUWgbLqV6lum5L4bbc6qhZdZjD9gqRr4z
	ctUzyG4Xo0IeW9Pi0eRDn87IPdgT5T5dY4GgfWNpe1Oeh8O35Xy0InRaGWgcJxs=
X-Gm-Gg: ASbGncvRPzNjWKSwfH0t/h6AVA8qAWSbSc3tMGGT6Q8KI7+rPCLfjLaJvJYfd6T1Sro
	KQW6xjBqrH08Sw3sg0D6Ak8OP8zLfqOq7EuzzDemC/wnJr0PZ56gu6b5anBsAXB+MshsyKnM6Iu
	BbPQBhb4NXQfP2XDCOEjmsPJkPboQSNEvP4orTUGJyM1ZICqXYXbwpoZvOEhnGffjBaRJ8dYapp
	tGx6vcH8sgdgcueulpw/5jpUJ39qjFvZrKy/j1o280ZHLc3t/YuHS3QicwcnV/YFVen5cjdr4cp
	hwJd/4jMn+yKi1QI0M9YLHPdRh+iK7RjdZoUdCazsIglmFn3QnWFD+ZD/GarnJd8Rj00reV20iQ
	A8jvh/DnMsQ==
X-Google-Smtp-Source: AGHT+IHsXCV0Z4XO+FTHe2MtBSqBnvYKMJqwPN2z2yjiElWrSE6yFE9vrDz/hzrfrSjNw1oWh2GCjg==
X-Received: by 2002:a17:907:86a1:b0:ab7:bac4:b321 with SMTP id a640c23a62f3a-ac3ce064603mr127290766b.29.1742421097635;
        Wed, 19 Mar 2025 14:51:37 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aecbasm1051077266b.37.2025.03.19.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:37 -0700 (PDT)
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
	Krzysztof Wilczynski <kw@linux.com>,
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: [PATCH v8 11/13] arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
Date: Wed, 19 Mar 2025 22:52:32 +0100
Message-ID: <7c26a0b52e00a39930ba02f7552abdd1be4c828c.1742418429.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1742418429.git.andrea.porta@suse.com>
References: <cover.1742418429.git.andrea.porta@suse.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index fbc56309660f..1850a575e708 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -16,6 +16,13 @@ chosen: chosen {
 		stdout-path = "serial10:115200n8";
 	};
 
+	clk_rp1_xosc: clock-50000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "rp1-xosc";
+		clock-frequency = <50000000>;
+	};
+
 	/* Will be filled by the bootloader */
 	memory@0 {
 		device_type = "memory";
-- 
2.35.3


