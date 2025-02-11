Return-Path: <linux-kernel+bounces-509925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7473EA3161D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D1F1889EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FD264FA9;
	Tue, 11 Feb 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="eleVucTA"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DF264F8D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303694; cv=none; b=s/OLn7VuaHAebnMo0FjBEWZXdg/+DA56Q2VKcGbZF77e1F6ZpqyFUI0D+4KXdJBNiJ8TB9k8axsAJ+fuJMRLsbC+MAdo/pLIIwuHUskMT4psS84gVdMCQyErt49zuD+2K2r56umsJuVe2Kzl2By1QjCIr1FzQlMlVYL2NvpIPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303694; c=relaxed/simple;
	bh=xd1/gSsSOX0c4PDs8eFFwC5Q/yKRU7zGuUmYDaZ+aRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSc7HEuTMy3DS+JhBZqv1ROoLM1YY9zlTep1mT9M/zslVyn+lkbsjO05HuJgCc/Bo+2IHUjSXiaPqjDqxOzchMJIIRkHcv9SsIAsF/DAU6yBWkRBAUf1d7C6WdOrUOho2C7Xy+ijl+T4VI6aRnB2eK91WnoHQAuTQ3KDTG1mB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=eleVucTA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c1c9c+jF/PV1jw8NDHsbVdhxY5rat61pZm6lsNJS64=;
	b=eleVucTA6Y/Aq+KS/KuUhMfrZ/8vSFdBN3OlWrWdHHpBU0ghk49P3xQYdUjDxAGBU+0HrJ
	J2abXR3zsIU58AiKOvZgYMjsLdzaOfmdYmW4SV3ELBhWfTB3p/TfBIOZ8sI13LkcX4kLBm
	EZJWGlmrWK+vOnD/No3/g3Y2Dw6IvujzqRpUTh7M74Jd15+p6fis+55+5e0XuWNVJOd2M/
	TviuwO3e63iiVfBXr5xPUkfifLz1M7d48S8S1Y9kHmasxFpkyuC8MHtOAzi2SdgD6iXxVk
	0O8dt1e+2qFLlZf4G5n5hSITxwOD4lalNZqtrqGFIzrz8PxJNm2w6+e6Yw0a3w==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:31 -0500
Subject: [PATCH 6/7] PCI: apple: Use gpiod_set_value_cansleep in probe flow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-6-b60e6d2501bb@rosenzweig.io>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
In-Reply-To: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=tkJEj/YQzRh1expKxGHWwtdYnql3z/mkcCDS+zSX2Ic=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r2StvxCY5TXwIMlIs4Iw+P0DiN0ayir0EJ6
 KQ/HmRUygiJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9gAKCRD+/lBaCvVY
 DdzkD/4/L/bBMDYggvde1Eqx824QWWfDu44UG+t80LZZu/TviEIF84g+m2pAxfFuMTlnUZoDFQC
 67aPjwjeOJKhz9cUDs8w4axQz/gXMfQB98a1yoEe5TImHVKYixY2XJBVfxNrWIjPRVSNs112AOx
 dPEVRbijgncjlJU5han4ojOiqMJNAlzaTb7qGlvXsklXYx0HEUzGmEQOl+6N6/ewJdEdUUWhUE4
 it3WQPd8VLHwEvpGdKvd5NAKkL0kS0zjsRpcF6eVIPEFMDp+lB9G+c6rdaUsBT2bGDk0QZO+n0W
 LsXI9b7GVw3YaBRjxVubuX5vyRy31oL0WUo+pIfg6mdxFo+LxElJlaZY38E+FmIyyb/hl4P0Ct/
 9VINkr1gZs5U3O0YV5fiTRmlKSNmraf1M94W3SYIPnXJnpqwQlA+xpNuM0nj1eYXPFGdUPFmvJ1
 BWgFLJsIKL+Ryl4RBdSq19Gi1ePnHxj3u3QUzNEpf7KXKsD42TgjV0S+tuFbrJGik1NGblXa3nt
 Dg+QXvHhJsPEfmwaMul17292CtsQsAhnLB1YfgWrndsNWspwgKAYq0LnH3RRZjmtecMW6rNR4y2
 8lvFr1vzSeknF6ePm2IputGPoX/LIrujpVmdgFOEz9yn/74FWvotzIAzEH/HVsPquELrOygZDAn
 Qjf8FoVwZwUwoVQ==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Hector Martin <marcan@marcan.st>

We're allowed to sleep here, so tell the GPIO core by using
gpiod_set_value_cansleep instead of gpiod_set_value.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 209535db7855fa1ee0d75290b33525dce18f560d..7f4839fb0a5b15a9ca87337f53c14a1ce08301fc 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -553,7 +553,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
 
 	/* Assert PERST# before setting up the clock */
-	gpiod_set_value(reset, 1);
+	gpiod_set_value_cansleep(reset, 1);
 
 	ret = apple_pcie_setup_refclk(pcie, port);
 	if (ret < 0)
@@ -564,7 +564,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 
 	/* Deassert PERST# */
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
-	gpiod_set_value(reset, 0);
+	gpiod_set_value_cansleep(reset, 0);
 
 	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 	msleep(100);

-- 
2.48.1


