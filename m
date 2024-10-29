Return-Path: <linux-kernel+bounces-386405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507229B4309
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163072836BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0F20262D;
	Tue, 29 Oct 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="PxiYcBfN"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751D2022DF;
	Tue, 29 Oct 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186695; cv=none; b=Yhus12AoHIlPPf55yKvZsRy8lXK8fma2e7uC7lk0QkuUHBXfHKpmLDHa3UHWTWfCQ+1Po4SIOTVJf15rp6spExfEdp+j1AO4+Hwqsj7g573OYnbxSx5O4nKX2U9nejG/0oIu+AEhYQNMgKh0a4lQKpZLI+qWkhXG8lTFzZv/olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186695; c=relaxed/simple;
	bh=bujN33g16oHNeeyO3ZGbViJYxBOYuYTm+DxN3be+hS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGmZ7Z36nrLF2CmVpNBaS8QfnXFNTWLrkVfhQRAN4It/iTkZfhDEQLR5s2JGKOt7e8IRHIbSbdXnlBSfGjXDUeMXPoBthazFCNooEcFZBXHKPgiSpHdc9yng+c6wOoxELHeGLKpu6kiliu/tV7dOGmePMZ4btLr080kBIfDin0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=PxiYcBfN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EDDC91FA13;
	Tue, 29 Oct 2024 08:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1730186690;
	bh=y6XwsU0U/5vhJTZLKZbpSfkUbG50QcLapUoV17QlMjw=; h=From:To:Subject;
	b=PxiYcBfN5S2vXfEE5CaOZ3S/wt/jww6iSYozhth0QP0jxRRQxJFgek6C7my4O14wf
	 jcn5FgjCe7cik5V4cb7b0SPhsKoY9bz254AzsqndPLwC98EQxdwnTKGMII7v24YTbz
	 ixPGNpoIUmDWmwhuIqIU6nca1Ss+FgqhjLWYsuM/B+Orz0z6X8SMMsFke5Pt+hlOWR
	 GuUAMIe+YEhQ2472j3BAejkXMDkrsEbrIurp3ar9Gstk96A+aPY/WKvChjAwCuEFer
	 I+omolGMhgoDD+i57vYLTaKy2o94hIqKiePsOMoPfhHvQdie4j90c3JmgGuezcR40x
	 WV4bknbTrVCIw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] USB: xhci: add support for PWRON active high
Date: Tue, 29 Oct 2024 08:24:44 +0100
Message-Id: <20241029072444.8827-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029072444.8827-1-francesco@dolcini.it>
References: <20241029072444.8827-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Some PCIe-to-USB controllers such as TI's TUSB73x0 3.0 xHCI host
controller supports controlling the PWRONx polarity via the USB control
register (E0h). Add support for device tree property
ti,pwron-active-high which indicates PWRONx to be active high and
configure the E0h register accordingly.  This enables the software
control for the TUSB73x0's PWRONx outputs with an inverted polarity from
the default configuration which could be used as USB EN signals for the
other hubs or devices.

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v5:s/ti,tusb7320-pwron-active-high/ti,pwron-active-high/
v4: no changes
v3: no changes
v2: s/polarity-invert/active-high
---
 drivers/usb/host/xhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 91dccd25a551..39456ec268f5 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -641,6 +641,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
 
+	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
+		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
+
 	return 0;
 
 put_usb3_hcd:
-- 
2.39.5


