Return-Path: <linux-kernel+bounces-515434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C86A364CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CCE16F34A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202D2686A1;
	Fri, 14 Feb 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AU8jaPw/"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82660268C58
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554798; cv=none; b=rb/IvjCD8F5qOa/1IMwaUYrbs4psV+h73y4ku8eGlr0AowXjqAa8PsyVZuTGSaYPsh/e4wXEUjw81WmmFUCXpTJl3lBprAl8+H0m7GWnVhGD3+furlXPcLvySQiRTKcxAN7JIPHrKjaPgZDREIScKuFPubdCe7tJTk+jw7vHXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554798; c=relaxed/simple;
	bh=wWDSiynleuPZE3S/Pww46mj6AfFqdSQeGB8YL6rAx6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAyd4Us4Sb6ypDMmh3k4GEobSqc673++C7Mu/8IRK2Md2mBERWi+4fTIU/33bzbcg5EJNpEFQzs9X2sHE0xtyEAhotDVsovz6XFnOqWPRwXKqS7nqAcK4OjugbDq9e4mW+SdM86TMk5baxZcsyMQ6sNeZGKABUGuf1UvoRFxGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AU8jaPw/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fa28eaa52cso1469433eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554795; x=1740159595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5WBjTrVITVgZYhJvGdqnlQGu4S0yfOA3QhZ3ApzwhQ=;
        b=AU8jaPw/4w+cfO+cCUdXeJEYR22BVnJrhQKfQHd+XhCNgfjJaAVs6p/j6uSHtm+VLy
         HvHefs3GA1hhAn9Bcz9SQ5zDWW0ojzXZp1qS+rzzYlcUlM3GhgvLPAk93Jvxty5UaIVF
         drPjZqtcXROzByUz/bSLYnMGqc0IYJ1kBOzuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554795; x=1740159595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5WBjTrVITVgZYhJvGdqnlQGu4S0yfOA3QhZ3ApzwhQ=;
        b=Li65u8sDBKU1eDNef57lQ0kNr7kqyGFsUHMbfK9HUEdhc/XymQexpKRUeIeQq9NwlN
         7u7jmCBrOFL6FAiRPjHSacv66EIzi9ta7UU4TxfZ0fGxnybsmJHF3KOs1IfgZh0a/rES
         t25KPn8xTAchX9d4dC73XUyuaNG/6FI5oKPWLodRPQCWkYLVhB5UPnZN2VnHJoIPO348
         IwxV/ScikrA0ozpGwjKOFRRCMleML0+v/UCxpVju6R8PgrCtiyzaxQLL7VexC5kUfVs/
         ia9HBen7W4lSyiRmPBWiROYHMNeVGhBMCM6N4G8XQzDtKGfYNQmScSlR8oruX6zdIFv8
         PDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgPSJWglPLqAhMM7XRKw4DuCzidJvEjScdffX8oZB4l18ndy5aFcR+9L6gIjqDaRhyGbeCJAiP4UVsjAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXk3gsjYra/zULyv7PR9k8not9iOLhlM/oDwJ/x0ifNINmOf5
	pfQWk4Tp7y6S4REYGYskMn43xh25y+EbcA/782eS/+d2M0b1JhrGqzsO6q/Wvw==
X-Gm-Gg: ASbGncsT470ViR2DUyljr3o/XU0uKfgz8X0iC6clYXXsSpwuIgCZXfa3FsXApppsyGJ
	u251UVXVOY11YUG4UEeeAe2XKBPvNItITX/nowkUNm1XpW3zX1FIp611+1XfwVx8KIeBbS/kanx
	Z/9CfrXs8kqUyBnKuXmJBQzkaDmk2XX8U/ff2JtIhOSi8cZJF5cD8OHWEVRYrrPTyDK0LrD5j5i
	01y51rhnBjCg4SYVEQBgvoMOg7FWl/u9OfFZhi2e/TcAqoJfhwKRIO8MnULQ+hBzn2QzOgSnv58
	7SnJ8QopUkQEMZWgiqVGO+Om4NnXUsUyAORV0EvT/k15P9OLHsa9n9ZoJCRqRZhWJoHWR2I=
X-Google-Smtp-Source: AGHT+IHHLIOPe+42yxDSEg6UPq/HyJpzpOJx8RHpCQuMziDQFg6kMun+TwGePYtgASMBwGxG/t8jXA==
X-Received: by 2002:a05:6820:160a:b0:5fc:c1c5:873a with SMTP id 006d021491bc7-5fcc54fd122mr31501eaf.0.1739554795496;
        Fri, 14 Feb 2025 09:39:55 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:39:54 -0800 (PST)
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
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/8] PCI: brcmstb: Set gen limitation before link, not after
Date: Fri, 14 Feb 2025 12:39:29 -0500
Message-ID: <20250214173944.47506-2-james.quinlan@broadcom.com>
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

When the user elects to limit the PCIe generation via the appropriate DT
property, apply the settings before the PCIe link-up, not after.

Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 546056f7f0d3..64a7511e66a8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1324,6 +1324,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 	bool ssc_good = false;
 	int ret, i;
 
+	/* Limit the generation if specified */
+	if (pcie->gen)
+		brcm_pcie_set_gen(pcie, pcie->gen);
+
 	/* Unassert the fundamental reset */
 	ret = pcie->cfg->perst_set(pcie, 0);
 	if (ret)
@@ -1350,9 +1354,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 
 	brcm_config_clkreq(pcie);
 
-	if (pcie->gen)
-		brcm_pcie_set_gen(pcie, pcie->gen);
-
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
-- 
2.43.0


