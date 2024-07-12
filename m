Return-Path: <linux-kernel+bounces-251098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DD93009D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC051C217F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA339AC3;
	Fri, 12 Jul 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGohTt/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AF34CDE;
	Fri, 12 Jul 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810466; cv=none; b=c7W66MUMYpCxhMJBWFtZarO3GTTvDBhgU0oT00YhFRsx00Ccdh3L2oq8wGvm7Q9jzM6QcPPZubsKfIK+mTnEjXaAEtMVQ6dD4FBoFu+G1nsX2yOG/QjCzSLNQIyGV3yQ8DkHuLpAclFDDcBRb+bmB2t8BAyAyAI+Zl1vDFG4nBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810466; c=relaxed/simple;
	bh=J1DNbBBTExsAUZSMBP3xp+b4hG2tRJP8mnBGnoOsLo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzB0NNINk8Vpc6ALWW3sZIMRpQ8OuQDQBlk5JEtVhYn4DGbvYCPhseGQt9NLcbNplS5s4Hm+QKm6iEtLYPes6c3cDGcsYFdWjvFeDQqePrKkjkE6+w3rDbiAHWletPChAW73mkuGLKKyB1OFVXOibbVqq5hkkToE7fBr0mm2T3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGohTt/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC0BC4AF0C;
	Fri, 12 Jul 2024 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720810464;
	bh=J1DNbBBTExsAUZSMBP3xp+b4hG2tRJP8mnBGnoOsLo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGohTt/hD1qZY9CVG/KMkv+ywhnivo/vy/94wkGmblTIds+xUoliAN5351xZXQmbz
	 vJbJho+CmpIUZd8Oc9Y0lrvjxwyCQQzAFeKc++wSiW9cb7cE3ei4qtF/X/cWRfFTqN
	 vJxw7o/if/Pxd+Mf1bApjFV0kswkzogp60UW+6k+yDuykz56XPHFyldOYt4d6x3N/D
	 WYQZ4Tu90jj4Ql/GhnBKU84xJFX1UuU+VBfbEjgZlSypmYitMiGsbIHFcg0pKaMGil
	 c7Dj0+58d10D5G6SF5UcrwpomWWc1L5gTWjYeaCvfBwvjtVGGMHo7EMScUv2wmd8fl
	 FJD6bqO3uzlGQ==
From: superm1@kernel.org
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
	linux-kernel@vger.kernel.org (open list),
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	mika.westerberg@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] xhci: pci: Put XHCI controllers into D3hot at shutdown
Date: Fri, 12 Jul 2024 13:54:18 -0500
Message-ID: <20240712185418.937087-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712185418.937087-1-superm1@kernel.org>
References: <20240712185418.937087-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A workaround was put in place for Haswell systems with spurious events
to put XHCI controllers into D3hot at shutdown.  This solution actually
makes sense for all XHCI controllers though because XHCI controllers
left in D0 by the OS may remain in D0 when the SoC goes into S5.

Explicitly put all XHCI controllers into D3hot at shutdown and when
module is unloaded.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 4408d4caf66d2..dde5e4a210719 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -667,9 +667,7 @@ static void xhci_pci_remove(struct pci_dev *dev)
 		xhci->shared_hcd = NULL;
 	}
 
-	/* Workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(dev, PCI_D3hot);
+	pci_set_power_state(dev, PCI_D3hot);
 
 	usb_hcd_pci_remove(dev);
 }
@@ -882,9 +880,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	xhci_shutdown(hcd);
 	xhci_cleanup_msix(xhci);
 
-	/* Yet another workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D3hot);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.43.0


