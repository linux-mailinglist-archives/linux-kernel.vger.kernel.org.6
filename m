Return-Path: <linux-kernel+bounces-385120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316719B32B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E57282F76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143571DE4E1;
	Mon, 28 Oct 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BomfZmJl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5C1DDC16
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124446; cv=none; b=Lq5gApRPSSao1Q0qWObMg+qFL4KaOHj6Ug3QoIvrzt/feKjcJmwUn3cTIj0yRTpCT+idsTU+FlJY2MXYuXNOv/AdNQc6sSjO7YynragS2QhAGKFalfRoadixsWJMJqpX/gtSw30NFdMYVIqRsDVVDQvJH34oI/9Q6OjP41nSO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124446; c=relaxed/simple;
	bh=bBaN0X0jScd/15W+2/fScdw6Spc8ffLYU0CeQxKdTas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvIub3LzDT+8okgGvXYlwyxzVPdRp6361wLrtAj0yAjwxs4xpry2BiiO2qe+wvpfSf9jtWVo4+oGJH77a5fURzdyW9+eOqsO03c+mBEnv+PIKSJI80oSdBsgxbwqMKRYzWWAt8qmgWC0GpNWzBVKFQIjIoNgJYDNwqN3IBEwCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BomfZmJl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso5049342a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124440; x=1730729240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqh56MHAf6NGyxNJb5XjKGyAFS1Pm7/dh/+rsUlSsqw=;
        b=BomfZmJlug7ZwpBY6Rw8s/hVg8VMdkshumj8yk04yvy72sDEPdWUREZq2Hhg0S4M8u
         gDJLYX5zIJAZF8guDj4/4a90eBM3JPx9O0eCsZcovLXelDNFW8lhr1XuhO+f5Gvoq7g3
         2RdzF8Kxnj7MBV34UnZqFH2k0c+uRLezZBRIdtqqBM/tm9eFS1sZwatTjloHuVjTalmY
         zWOifKCEMs/rR3S8FsrgqmN4a6oOLrCl1Kij/mBRZAeQtNAhcyiw67Q6tS/z+fQ2avFr
         Ez9u30lvsd49FVcTxDrg25C5V4aYUUTUIBTe9iCyGrwRcaxRllKu5u32vLi7PRUTt0BG
         +OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124440; x=1730729240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqh56MHAf6NGyxNJb5XjKGyAFS1Pm7/dh/+rsUlSsqw=;
        b=kjJMi/aC/+3L/DPSODdXZxukviIGbPGHS2q3ZHYhszLlvoq4u/nTBWaQq3pK/VD8q3
         dADib2wn4L2knQ+Io8UOgHq/Sz6uD8FFyzy6bUH81BXCeD9fgENasmhD+VNLqyPJsWM1
         /PAZm1QdEe/c1Yitgyxbq9L3EYXgn20TnMr54wyV6sXi2Lr6U6z2Sv65nc4CXdwbG3hE
         RteCEQuUnGr0AYpMRRHxnzO0K0DL4C8HqTE1kD+OwZYyo2kihjTq7SrAtdJ6RhRIvzfL
         nUk3+Ji+Dx68sUBKsL9bi5+932WXqTuASAAhqIAuttxoVFn8Da+5pqJ3xwtb542aayfL
         LeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcTCsw/qj9oOIu+y8NWlMKeicIMuEFy8pDgQK3wWZgSxLsss/Rt7j7yb+d9vjpv20E8U05r+uoARJLAoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAH5dJwp0g47DTnu2KrGJy30wIXCoa8KlmACTmbF8xkrl4funP
	2PPIooh6HMGaB9WVsWOscldsOnyWJlctsTFAMvZ0LPZhOkIWsuuMYLOXAjghgbU=
X-Google-Smtp-Source: AGHT+IEJsXz3JLUo8t8BMAbJDLTmQNDfk74M3MzGZPfukI0B32f64s3so2uEdukAd0Pl42XLPpmBkw==
X-Received: by 2002:a17:907:3e1a:b0:a99:f4be:7a6c with SMTP id a640c23a62f3a-a9de61669cdmr835551966b.52.1730124440047;
        Mon, 28 Oct 2024 07:07:20 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b32455a14sm388970666b.178.2024.10.28.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:19 -0700 (PDT)
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
Subject: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus address to dynamic bridge nodes
Date: Mon, 28 Oct 2024 15:07:22 +0100
Message-ID: <f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com>
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

When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
bridge, the window should instead be in PCI address space. Call
pci_bus_address() on the resource in order to obtain the PCI bus
address.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/pci/of_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 5a0b98e69795..886c236e5de6 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -126,7 +126,7 @@ static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 		if (of_pci_get_addr_flags(&res[j], &flags))
 			continue;
 
-		val64 = res[j].start;
+		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
 		of_pci_set_address(pdev, rp[i].parent_addr, val64, 0, flags,
 				   false);
 		if (pci_is_bridge(pdev)) {
-- 
2.35.3


