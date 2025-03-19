Return-Path: <linux-kernel+bounces-567580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53614A68817
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8DB189C052
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A367255240;
	Wed, 19 Mar 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRyxyYsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4A253F04
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376671; cv=none; b=H5derCNvy8zNEte7kacGsj7oPOxSbDSA8Gvdf/3cvbKJ509q5QaSOsVShzQR4scJfUqIncaNCEOfivFmKUlX8VdeaJFHLIpBr8cKxaVqF3x9tQcUQeEoqsB/bjezUzwNGo2iUAkgffMVec2r+4IZis5HzgWga2BO3P6iOd7MPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376671; c=relaxed/simple;
	bh=ZhE2RX1DzogrkLp/XQnGF8fK6IIiYf5DdB69tq+aBqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOzjwE6ccd9h7aTPqJOAOdtyWorjmEkHfx33bKAHfHgTW/fjsAoVZlPGiibyuNsB2ZHZT49JLFe3eqlSovEHG6k30qmFNjA/cm9PBpGCrVLtqum0oUZZFSlHXM0OPED6qMI4KCx36kSpBM0e2f0zRU4FWUgfgi8W7SYFSAS+onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRyxyYsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CE7C4CEE9;
	Wed, 19 Mar 2025 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376670;
	bh=ZhE2RX1DzogrkLp/XQnGF8fK6IIiYf5DdB69tq+aBqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRyxyYsr9l+WcVCxIWgYxwWPDzfPqHn2pY4ui2Pd6w3YkuxGdswrbAiNSS5k5o/Zk
	 olri7kh5KeOJZ0PoGnYaYikbaGafzSdJSeriOBmOu4BNkXTZ4+W15MgqycDBmoZS1v
	 W4lw1CpsWwgA93v8e0GiOMOp5wvsbl//ICor0BQY7+76rU3ahSF1e3XzKSE3nUEvtH
	 dNwLXYkSApuCqzhIb2hcR0x5u7dwseNWf+mJ+9oBxCvtqeNX6wkW75WXV1hnIfVI55
	 tNMdTeJMvqCAnJiaWvp4ELLQlz2T/ZBKrDXSAS55Na6/hhjL5UZbCRqwb0vshao6Gl
	 4bNu5u4wx/XaQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/57] irqdomain: ppc: Switch to of_fwnode_handle()
Date: Wed, 19 Mar 2025 10:29:01 +0100
Message-ID: <20250319092951.37667-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/pseries/msi.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ae4b549b5ca0..d8ccf2c9b98a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1897,7 +1897,7 @@ static int __init pnv_msi_allocate_domains(struct pci_controller *hose, unsigned
 		return -ENOMEM;
 	}
 
-	hose->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(hose->dn),
+	hose->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(hose->dn),
 						     &pnv_msi_domain_info,
 						     hose->dev_domain);
 	if (!hose->msi_domain) {
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index f9d80111c322..5b191f70c088 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -628,7 +628,7 @@ static int __pseries_msi_allocate_domains(struct pci_controller *phb,
 		return -ENOMEM;
 	}
 
-	phb->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(phb->dn),
+	phb->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(phb->dn),
 						    &pseries_msi_domain_info,
 						    phb->dev_domain);
 	if (!phb->msi_domain) {
-- 
2.49.0


