Return-Path: <linux-kernel+bounces-251097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C6593009B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912DCB22DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F702E646;
	Fri, 12 Jul 2024 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCQZWp4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1B241E7;
	Fri, 12 Jul 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810465; cv=none; b=bn7dgYvW82AtEX7YB0ygFSo5lpWNEYVTXEjrzHxWgX7LVAOCuVDLNVeECQCEf6gyfdqLFJ9GfeHonkxL7IgUt6EtO5Dun0MuQGvxdFoWyi1MD0wb1A4OzO75dxTF8xCd2mH+DLnJySBqrYqAAKOhvQVpDYkvTEhVtYyqK4jq1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810465; c=relaxed/simple;
	bh=fG9IiyCcL3Ebv60rQWnWxvQudEMjgzV3wRXhFlyF4fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MutV/kJXmksrvS/iFnPKCXooKpIVJBeQxe8/YD4ram1dwkxbO5B1XAU8jzm5wSMvyh2HCQoq1CqAu9qD3m/rZGL1xoy6gU1MtvuKhboNNCfOXai8+G5sXTCd4D19xmt0QN8/WRyknkzVOkdu0o1E9lNxhY1iiGIR6mHqTicJUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCQZWp4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DB6C4AF09;
	Fri, 12 Jul 2024 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720810463;
	bh=fG9IiyCcL3Ebv60rQWnWxvQudEMjgzV3wRXhFlyF4fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCQZWp4q/kdtgklWXIkvqgYLNZD5vBWcfmK46Xyfzpx6ErYgOTOQPXqWZhpvIX8NY
	 czxSHS1wh7Rz6Bw+ATdlqGJuosihI8ST7lU+bLmKA6R3l5ALYbIRhagQF7BmXuefk+
	 9rj+fhIBL1hoGsA/8XhIihxFYxxjEZRNDsQGHiI8cucvyZJG0FyYqUZVUQg9TRlMl/
	 yDzAQOeXIq1hmnRHR6TTbrJZDAnNi9zryu5NpQhu/i9FLKZPoj491C3dc5itE0CoK1
	 mi1+N86JeDRqD94bMVY0uAOonHvzYkQNiA9dmJjzcr9rLYHH08UeNSxnqXL9mYgNWH
	 lMRy5oFl8rfYw==
From: superm1@kernel.org
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
	linux-kernel@vger.kernel.org (open list),
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	mika.westerberg@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] xhci: pci: If no ports have wakeup enabled then disable PCI device at S4
Date: Fri, 12 Jul 2024 13:54:17 -0500
Message-ID: <20240712185418.937087-2-superm1@kernel.org>
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

If a port on an XHCI controller hasn't been marked for wakeup at S4, then
leaving it at D0 will needlessly consume power than necessary.

Explicitly check ports configured for wakeup and if none are found then
put the controller into D3hot before hibernate.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 05881153883ec..4408d4caf66d2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -823,6 +823,7 @@ static int xhci_pci_poweroff_late(struct usb_hcd *hcd, bool do_wakeup)
 	struct usb_device	*udev;
 	u32			portsc;
 	int			i;
+	bool			wakeup = false;
 
 	/*
 	 * Systems with XHCI_RESET_TO_DEFAULT quirk have boot firmware that
@@ -860,6 +861,14 @@ static int xhci_pci_poweroff_late(struct usb_hcd *hcd, bool do_wakeup)
 			 port->rhub->hcd->self.busnum, port->hcd_portnum + 1);
 		portsc = xhci_port_state_to_neutral(portsc);
 		writel(portsc | PORT_PE, port->addr);
+		wakeup = true;
+	}
+
+	if (!wakeup) {
+		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
+
+		xhci_shutdown(hcd);
+		pci_set_power_state(pdev, PCI_D3hot);
 	}
 
 	return 0;
-- 
2.43.0


