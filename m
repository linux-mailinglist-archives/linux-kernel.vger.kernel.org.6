Return-Path: <linux-kernel+bounces-515436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74523A364D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC77171BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076212690E7;
	Fri, 14 Feb 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="exceKfgg"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB62690E1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554805; cv=none; b=eqKs0IFg6LlA09Wsq6fe6O8K2H5mqlOr+hGN2IbRyirTykYkC3g+vALf0saApx/aMedXIjhi2duUZtkOxkFcdFGADrnkvzQGW/n0sfninC9rngxadAqyu40DZFY/WEs1dikFUE3wTM5DP+se1VN5vq5UX+EbqgQ56nTiKFfYopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554805; c=relaxed/simple;
	bh=lsg4Fcw8VcMaHZ6PHXq4ByEugOSBshba/6E5rrl25tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTLho7B5SA/wRTKSEGrJPipzsWscpikWFM+XrZRfGXZaYGnjsBxuizEOaQYRfxM4mi43XEBpmMB/+QR52OTuB/EZ8BR6+InbfFCo7xp/bizUPx26k7a6h68yxqamKtyMytgLBhAGaD4VC3bwIe9ACxC65O4tZA6S3VlHzFWIdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=exceKfgg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fc0c06e1deso1099242eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554803; x=1740159603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucKiOpBc+S4NSSHbPlsmk0SXtuaeNxQ7iIuZM167kvY=;
        b=exceKfggvwVwPwKg7SYRopQVAV81v171osSSePbwsLvvaqGiEN2O74Ta5eWgPJIJb6
         ydBKbeI06ppsIZAD1Ki0UkNB8MWNh637z5QpZpvj/dfxu+YGJj1o8D5krc7KX/YvbYwD
         pEbVv+548KVJSjgO+jDHFvaBsQ5z48EveIyHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554803; x=1740159603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucKiOpBc+S4NSSHbPlsmk0SXtuaeNxQ7iIuZM167kvY=;
        b=GcHRdv9NqclcegfCZ8AwqOD2nyxVLXt4QOrnD6a33tMd3poNivfltvTQ4SsIW6KbeY
         Dn2BycoZOFJYL5VSRpYTv14SbQ//pslMgG9EOgHGkWnLbmN9U7mvA+rFRBDh5FRfVZCT
         clzng5TWn5ssAnJVvmzOjhQCmUhtulll1dds6TcFqRdGDgq9/549uLSPAxoFhTCPFJo6
         Mm7Gas40R2QVx3k1WewRWl0eqX68jIJyGD/pYNan2WmBEmzgxDjkgjStHlILTEjaEsRE
         rF/YI1yRfOu+cFBH4GxKTCvx1t2AcrUlY3Fovy1TOzfYJw4xGu//Rbx+DpWLsvr1Veoi
         2UGA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVxqVm57a5B87NFdKRHlJB0lp+2Z5oXmbRZ3EYgwpRLF/Uc50HctK7bca1uwXMZoRr8Rg8e9JdbqOEjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPSEoE4ol0rMn0NalnvJgmDteiISooysKz0A/wtvXCMprKzu/
	m/lnK+FywmyAsHgFl2wB9XXQeigCLXziXs2mQTAlfGFjYnFaiFkVG7tx+yvnxg==
X-Gm-Gg: ASbGnctn5nVmOgy+EzFoq6XzMW9YJRhuxCYvNSHadi26RvsWDtcmFwlBlIIy8j06Vxz
	3DaCQ5v2c7Bwyt5G0990aKpTI2bSguV9lxrFJMm6aHZyCb77CYyQ/06Zv9g8WqMvpLT3pJUI2+m
	8JLsg2yRxt5u4eryBu0pLTfvu85ecyldVe0wpayGjeV8XxQWvY3697f3fTHMvDK4P+8Q3xKkyPQ
	ylFq5YkRAIfhuATNaV42ch831mDz/+EsOeJ5vfhztV7fQFfCiNjXhFa4DaUZX25ZCG7G58trK/R
	uw2mK3V2Okw2L4n5qz6sZ5J0C95TRUDhqAXGLcYP/KpO2yU9hg4GvNQwyocNAtH++fHpVDE=
X-Google-Smtp-Source: AGHT+IEHCQouVhYnVU0zbdmV9+4+4+6gGSYlzxuVdn+GGhOSlftYZsrzvcgZIZVnH8WQyajm4LLIQQ==
X-Received: by 2002:a05:6820:220d:b0:5fc:ba35:d704 with SMTP id 006d021491bc7-5fcba35d7fcmr2395959eaf.5.1739554803022;
        Fri, 14 Feb 2025 09:40:03 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:01 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/8] PCI: brcmstb: Do not assume that reg field starts at LSB
Date: Fri, 14 Feb 2025 12:39:31 -0500
Message-ID: <20250214173944.47506-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting a register field it was assumed that the field started at the
lsb of the register.  Although the masks do indeed start at the lsb, and
this will probably not change, it is prudent to use a method that makes no
assumption about the mask's placement in the register.

The uXXp_replace_bits() calls are used since they are already prevalent
in this driver.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 98542e74aa16..e0b20f58c604 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -415,10 +415,10 @@ static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
 	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
 	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
-	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
+	u32p_replace_bits(&lnkcap, gen, PCI_EXP_LNKCAP_SLS);
 	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
-	lnkctl2 = (lnkctl2 & ~0xf) | gen;
+	u16p_replace_bits(&lnkctl2, gen, PCI_EXP_LNKCTL2_TLS);
 	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
 }
 
-- 
2.43.0


