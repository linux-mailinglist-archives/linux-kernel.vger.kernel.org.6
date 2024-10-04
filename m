Return-Path: <linux-kernel+bounces-350307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D867990337
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365841F245EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB751D5CD9;
	Fri,  4 Oct 2024 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="tb3R/Xa1"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B91D6197;
	Fri,  4 Oct 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045938; cv=none; b=s7tAPEK7CFqrfp502CcMi9LIc0OQEJGsO31zz12uYn3IP7Nqh5rjEBoGGqLs1lX82llrqCoE1tdmkMctuBrxMc2hda37MnPgGXqHaGP+4s+tweGu/MC8IQlweRUwzchV0y2wegnLewEhmu8GkZGxKgwg0r9KQYvirQoT6hwfLs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045938; c=relaxed/simple;
	bh=42HoSz2AfmGoTyZq4d/ndu2ofmWwkQkQvP2LRD4siaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlkpv85ZgxnzNZpJ9wHFHeR8CdSXND8qAiQNVYGoAESiRCy9AMkDKc7nG2Ywbt/eUalwzK2UbhDSqQewPERSA6rZ2ojn/svg2Gzgxge8xISmDUB//HrONdAcLwNWfqR8z36zrdM4Jd7o/7QBPXPyt+gMB4tGOkysC0izYNa5iCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=tb3R/Xa1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 83C7120B47;
	Fri,  4 Oct 2024 14:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728045927;
	bh=6gGuuLrXc63nCI0Xf49TprKeyCrdpkYefLbM+viavLs=; h=From:To:Subject;
	b=tb3R/Xa1xFLH8U6Ly91Dj2hrGuuz0azFSVMQHqosx3cFandR5FUOsb3aHnB/Gq015
	 dz0iY4D2ss3d8TCzHNvLONcm9N/7avZ6xYHdVNTr+ExwQVgtN9DlDncPcsj7xg9PK+
	 b7tNi2La/yazFsjM7xCgH0BcV9GqEYiIibccnJoIrMkOXHuFVmRT5j2iJqOvFSb9kc
	 emgE8xeG2uYq6hbpJgpJxaesX3zc0GgmLhBK6IElH1lXcE1l0EgRtVvKwAp2fonLCU
	 sM+WvoIsQ/6kqGMv9wapB9WNhFff0feQ9ArkgOVKpJMtlokMyCbeY+CUFxfJf1RvjB
	 kDwpqC2IMVW0w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] USB: xhci: add support for PWRON polarity invert
Date: Fri,  4 Oct 2024 14:45:21 +0200
Message-Id: <20241004124521.53442-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004124521.53442-1-francesco@dolcini.it>
References: <20241004124521.53442-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Some PCIe-to-USB controllers such as TI's TUSB73x0 3.0 xHCI host
the controller supports controlling the PWRONx polarity via the USB
control register (E0h). Add support for device tree property
ti,tusb7320-pwron-polarity-invert which indicates PWRONx to be
active high and configure the E0h register accordingly.
This enables the software control for the TUSB73x0's PWRONx
outputs with an inverted polarity which could be used as USB EN
signals for the other hubs or devices.

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/host/xhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 91dccd25a551..440fbaeeaa3d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -641,6 +641,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
 
+	if (device_property_read_bool(&dev->dev, "ti,tusb7320-pwron-polarity-invert"))
+		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
+
 	return 0;
 
 put_usb3_hcd:
-- 
2.39.5


