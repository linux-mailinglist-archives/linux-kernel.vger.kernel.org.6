Return-Path: <linux-kernel+bounces-371542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D59A3C74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CF9B28CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215B209669;
	Fri, 18 Oct 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gTk/UKHT"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0A20126C;
	Fri, 18 Oct 2024 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248919; cv=none; b=Qz4rIAKeJU5Vi8cksiZsNzzMjcGORmrj68ncy68qZ1jKYF25sWp4TVS7e/1IrTebBUXE3XuExQvDEntNbMEqg5PtGs8DozxUOSBSVBoHDs/L2w27CgjssXwsrZpUP3IhKjI9upsayjDCiVamZiuJDtpNT2DL63Vo56wQiioR+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248919; c=relaxed/simple;
	bh=quj8FjTxjqN+y+sLiVFeNkUTAZcXKlYLPFq3FvBLbYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8p0pmYij1bHUF8rE7xL16o1H2H1N9mD6lGiyuQeF/JWpkT5FuomSxSrQHO6dPNAV3ixcZETMIjapoRD/dC5LDME2EwaaE1Bj2odsy22QPnCo7qfLvHToxbHtzuhuIDkzHesei6tpIMl6OySE/gsMs3kYxr8rZWxAOTDmBaiiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gTk/UKHT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 792D51FAA3;
	Fri, 18 Oct 2024 12:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729248911;
	bh=iSaY+IMAdbcVrCBA/bzFCudL7efxUfpsvzsS6r/mj8I=; h=From:To:Subject;
	b=gTk/UKHTC/aLIiWwegR1Nln850g4cjIp3sS0pFf+RJ+MMw7rPn64doComXl0AIgiY
	 ytXYq+mVGzL/nZzDqjogMKqVQmoe4D/C3/NJJG+604ZkG/t/vTQa7UxWy+6qkzgi0N
	 BbFILnbpJKHBoyR7F5bE3IGv/e2b1DkPVQDS6wf5xCO08W+tAB4EkDOngjvmp0cBD4
	 mOpHz7oiz0ECtr3FYoEU0Saex361MImHyZMjFq5D46NPoMSPt0Pss/jzWglq8XX54m
	 9G0lA0eQ1Z9HYb9HvhBMJZzx4466Uu0h9Kj5V5DHgkpsEumF53+R/8kYGP5ILjOwTG
	 54pRgoX2gG5dw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] USB: xhci: add support for PWRON polarity invert (TI TUSB73x0)
Date: Fri, 18 Oct 2024 12:55:03 +0200
Message-Id: <20241018105505.28005-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The TUSB73x0 is a USB 3.0 xHCI Host Controller Hub using a PCIe x1 Gen2
interface. The TUSB7320 supports up to two downstream ports, and the
TUSB7340 supports up to four. It includes a feature to configure the
polarity of the PWRONx# signals, which are used to control other peripherals.
In some systems, the default polarity needs to be inverted, which is
supported by the hardware through software configuration. This patch
series introduces TUSB73x0 PCIe device tree bindings and modifies the
USB XHCI PCI driver to handle PWRONx# polarity via a device tree property.

TUSB73x0 datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf

v3:
 - Correct the compatible string as "pci104c,8241" (uppercase hex to lowercase)

v2: https://lore.kernel.org/all/20241007093205.27130-1-francesco@dolcini.it/
 - Change the property type from bool to flag
 - Rename the property as ti,tusb7320-pwron-active-high

v1: https://lore.kernel.org/all/20241004124521.53442-1-francesco@dolcini.it/

Parth Pancholi (2):
  dt-bindings: usb: add TUSB73x0 PCIe
  USB: xhci: add support for PWRON active high

 .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  3 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml

-- 
2.39.5


