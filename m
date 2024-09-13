Return-Path: <linux-kernel+bounces-327805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27381977B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D191C21440
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AA1D6DCD;
	Fri, 13 Sep 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQo35OAg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C091D67BB;
	Fri, 13 Sep 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217058; cv=none; b=eIr9TlMv8rz9lk7cJe1qOHsWjPMchT+Zg+FFpKEqd6lycJbl5DOj5ttii0cXrrTUK9V4vP4p7SSPOSAlRRqk9U9ODyxzze7AfVYhdAG5NGlzyEicKcA2PmdAKquLsAOYnxiG+QxeDjCpz5QlSfX0qWolqozza0cSN3/AvpkiycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217058; c=relaxed/simple;
	bh=VZv+g4ycb9SHp8LMXT/zOQuWQNIYLK7wWpgcqBz2fm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQFiOg3j6mbKb6SpJU+ckCuO/3GcJYGQpN6rbJM2qLrBnMJMGxLGmHlikF5nWSHAcw0fbdn1LAOcB7TPi7F0p7zMqYr3aUF6O1DYkRa/C+bbJr5IXDhvip340QrK4S6Wuyf/Xqygat6lBw9+60OUWBPk193uRpIzGzuEBUwl8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQo35OAg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726217056; x=1757753056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VZv+g4ycb9SHp8LMXT/zOQuWQNIYLK7wWpgcqBz2fm8=;
  b=dQo35OAgSDkeHF1z+DVjLrxKxB0AgNL+R1qPaOXv7T+/d5j4JS5psbe0
   DhUZrtHgPrgCriAuuqZazbtdA9HFKRCxzgGN9VNa45uX2tqDBZu60XQV0
   2Kdt5OSGT/ar+UCLEnWdYOiLursC5/1DAd5M2JRP/UVdaYa8CS/8YAJOc
   A3rFi0snfmAVXt8MxIqviqslcF7xRHQsRi/hjK72sQhGWNE5o+UsCft69
   e9EkJhwcUZrBsmfK+QQsNEM7HIJEufHgTyIRRTaI3ksrG4GzCKdqIquiI
   rChpvSU4av4f/cX6xmIR9kvziCmltmq4uRabH56286X+TIk2boj5IVNfb
   w==;
X-CSE-ConnectionGUID: cEJYyF/sROOjPH4Xvci/TQ==
X-CSE-MsgGUID: RKHbab2UQ3uGGYCO/A4m+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="42618548"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="42618548"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:44:14 -0700
X-CSE-ConnectionGUID: OIyMSdHnRlCbVaZRLPZJ2A==
X-CSE-MsgGUID: Ebf6Jc+dSfeuffh9Iwkd8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67953669"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 13 Sep 2024 01:44:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 83C5E32A; Fri, 13 Sep 2024 11:44:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] xhci: pci: Use standard pattern for device IDs
Date: Fri, 13 Sep 2024 11:43:37 +0300
Message-ID: <20240913084411.3309911-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
References: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The definitions of vendor IDs are follow the pattern
PCI_VENDOR_ID_#vendor, while device IDs — PCI_DEVICE_ID_#vendor_#device.

Update the ETRON device IDs to follow the above mentioned pattern.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index de50f5ba60df..6d9eb2b031e2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -34,9 +34,9 @@
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
 
-#define PCI_VENDOR_ID_ETRON		0x1b6f
-#define PCI_DEVICE_ID_EJ168		0x7023
-#define PCI_DEVICE_ID_EJ188		0x7052
+#define PCI_VENDOR_ID_ETRON			0x1b6f
+#define PCI_DEVICE_ID_ETRON_EJ168		0x7023
+#define PCI_DEVICE_ID_ETRON_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -388,12 +388,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ168) {
+	    pdev->device == PCI_DEVICE_ID_ETRON_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188) {
+	    pdev->device == PCI_DEVICE_ID_ETRON_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


