Return-Path: <linux-kernel+bounces-385121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413719B32B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C516E282E57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612D1DE3D0;
	Mon, 28 Oct 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fwly0pM7"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F81DE2AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124447; cv=none; b=IdoiQLSNCHhgmJx0DE0H4LZ/IGiZ0S3dpBOlYXkvazePbssIQdDoU5kpGYGwpk4JfiMnkZ89+HVyvHi2IWZqjuF8vrAeu9IMOCW7uh5gt7fhV2KdAyGb4HCme+/AK21Igtba5jH858zcduBO0isOi9pGX6QRxYQ5Je6eBRB73NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124447; c=relaxed/simple;
	bh=GYXHeaG8wpR2BIrXpx816pDyYa9dHkRtT9dpld+pBs8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Syq8s4yM26ftEWdHJXINbq6YI00VTxynMHFs9oGDznNE/8KF35fr5qPvJGWL7eKkDbY2CF4D8Cdi4sljUph2fKtgTU9PKoh3jRM8BykLegKreKkNcXxdCi1AZ6xcicxrpZbvNLM891yEEALSJJNAKDV0EhXUyK+lJ6qhu0vBj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fwly0pM7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso587623866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124441; x=1730729241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW6kvc4ZbQp7jOxwPlUXi8bHuXjPpwn11nTKKI/C1qY=;
        b=Fwly0pM7JZeed2l9/IOqhf6VXgJap3Odnu14FTJlEGBK9leaUm/+lGtlw51jL14whJ
         i+96cfa8Z4i6HCXX39/mC2MOE0yTiM6KxGDt04DB4uXFpN5bBhDU/ZNHXxQv7JnGDOci
         9C1mnU2yr7Ll0ONE/+Y5jxfxWJyMI3SFf8aF72UmQ2RVjc6m7pljGOyy7QMKqX3OEtyy
         WMwgTYTXUKvRNbI2mwd5YI3cPDfjraeyiPVSd8RaeZsm8V9FriEF/rjx9rl9O8Gxmcby
         RYJwTD7UbCHUCJqzx/nIjP3mI9pWXWDN+rV/u4dodCc0YBzdGZGafCzIh0sSTkw76M0L
         D8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124441; x=1730729241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW6kvc4ZbQp7jOxwPlUXi8bHuXjPpwn11nTKKI/C1qY=;
        b=HeloSJWrGw32CUrBqkQoRTqQ9yuSCvuvh+nreVfrPWgyoqCvxQhyZDwwt2wpqrJHep
         AHkgrd0B+PnMfWzg63SNNMWt9usZXzEcmNxTvQe0In+KvZFsksqGNpV7kvoJqBkCjG9n
         zlAYLd3puZRQzOJ17wd8LLgNWdYnxQr6qkk6AA2O5QCGJyi6N8RSpyvgx+hcNTpwIBTX
         khQwlk7rsk/BTR1gOmtiqhbgYy6Hv1u26hQUKkPhthpXSLA0s93oPga83QZl/2UGmD+C
         sY1TVYDD41XvioFvnwYvtp6C2mB7uHg75LtvLX+H+dg7zUwvlq9Mkre+sSFoZmKMNb5F
         u3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWgPHsb15bQPLnAzH6DfArg0Sorgox0S1Gn86ydfk1rfb4InkRXO49904UHnxWdg9hAEigBh13BOifnI30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8ao10tLVgfy0LtmGsU+JCf+9I7cK1dJXkNCNO0zQx5oG3Ala
	si1eILaO2+/hprp6/w+pRzO4mJdYOqrOewsu3nM83dWhntZlchbGq/2TZrpAgs8=
X-Google-Smtp-Source: AGHT+IE5csQvNeeQQV2TiEg3S3V6yZpGcfTplYGENkEB1u6HmkJa4la0HF/+Zf2tdkb6gQWZYObepQ==
X-Received: by 2002:a17:907:9452:b0:a99:fbfc:5ff3 with SMTP id a640c23a62f3a-a9de5ce1611mr802908466b.18.1730124441130;
        Mon, 28 Oct 2024 07:07:21 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2982ecsm376935166b.106.2024.10.28.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:20 -0700 (PDT)
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
Subject: [PATCH v3 06/12] of: address: Preserve the flags portion on 1:1 dma-ranges mapping
Date: Mon, 28 Oct 2024 15:07:23 +0100
Message-ID: <3029857353c9499659369c1540ba887d7860670f.1730123575.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
translations. In this specific case, the current behaviour is to zero out
the entire specifier so that the translation could be carried on as an
offset from zero.  This includes address specifier that has flags (e.g.
PCI ranges).
Once the flags portion has been zeroed, the translation chain is broken
since the mapping functions will check the upcoming address specifier
against mismatching flags, always failing the 1:1 mapping and its entire
purpose of always succeeding.
Set to zero only the address portion while passing the flags through.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/of/address.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e33..72b6accff21c 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -455,7 +455,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	}
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
-		memset(addr, 0, pna * 4);
+		/* copy the address while preserving the flags */
+		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
 		pr_debug("empty ranges; 1:1 translation\n");
 		goto finish;
 	}
-- 
2.35.3


