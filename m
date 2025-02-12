Return-Path: <linux-kernel+bounces-511793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C3A32FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4CA3A92DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E04E201015;
	Wed, 12 Feb 2025 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WA91HEYO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF031FF7C5;
	Wed, 12 Feb 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388687; cv=none; b=I4+1EA+wNdC5c6WVwpZlUqiCuf7XWY034S1ZT70z4vmdVxftWBlYlIzr/+cgFQYZhKW4sXLUYt15ZT8tD5A/J6WkYPoa46fxFoPhsTHEqu0vpgO0kvqb+1HfssvH1rnKnoVFMgSu4jyjQr/4Y2Qpip2ykrZga/TGvqMrUSdwnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388687; c=relaxed/simple;
	bh=+FRVcY1Tt72AIJLpVcDlD8+93uIe9Na4ePbTNtvgCDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nooDAbOeC2OtYsRjkTodVYgCTETB+PqNFi4YsE2ZAN+Tsgsr4CQyQXQ7u+ioLuhOg8H9022Vc6tPoV8SDIUW3IAQAcPCNX7G8/VxPvJ9Uftb4KwfHXhRfo2he2fDKFsZHaqwsP2TqpgYmMY8uH/K9IbYO18H2TCRmqW455Zh7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WA91HEYO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739388686; x=1770924686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FRVcY1Tt72AIJLpVcDlD8+93uIe9Na4ePbTNtvgCDU=;
  b=WA91HEYOzd+9Go/9K4FSCdJ728CpPJ+JfleDuqAHJIT4zbbIzxLiaKe/
   L/FrM1U7yupytI138Ko/RXe0EXpJsNF21e7MSNxGRYX/2Q6BsmmL0IvKq
   13wvClwp/yYrKYwPHnT7iJCqhmroDcQ8lf2RgwMIqauAqCZCxX449ppz4
   IuxUf50LnW4PSQ1tyekMET4rf1og7IIRqDa3ndbLm4WC1SuCYU3LjJMPN
   UiOKEALKVxYGe0hJcwVLCLFPmHbiykXy1hhcydTPjgI/pNPt5arnAphVU
   3VqzTiR9ACPQpexZRG4qlMpV7TjorTwwWeyyIC93ahMriyn0G0OSMfrVT
   Q==;
X-CSE-ConnectionGUID: 4cr8yDuNQtOxlvtUnnOCfA==
X-CSE-MsgGUID: rLaqWmk4RtOxl5yZCfEs9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40183664"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40183664"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:31:23 -0800
X-CSE-ConnectionGUID: OSrKSwJzSryo7GTuTIoVUQ==
X-CSE-MsgGUID: FnU14+NaTN+T3xBT0/W1+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117542535"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2025 11:31:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 637211FD; Wed, 12 Feb 2025 21:31:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 2/4] usb: dwc3: gadget: Refactor loop to avoid NULL endpoints
Date: Wed, 12 Feb 2025 21:28:02 +0200
Message-ID: <20250212193116.2487289-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
In-Reply-To: <20250212193116.2487289-1-andriy.shevchenko@linux.intel.com>
References: <20250212193116.2487289-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare the gadget driver to handle the reserved endpoints that will be
not allocated at the initialisation time.

While at it, add a warning where the NULL endpoint should never happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
---
 drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d27af65eb08a..73cebb7d90c2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -547,6 +547,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -563,8 +564,13 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 		return ret;
 
 	/* Reset resource allocation flags */
-	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
-		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	}
 
 	return 0;
 }
@@ -751,9 +757,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
 		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -3669,6 +3677,8 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
@@ -3818,6 +3828,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
+		return;
+	}
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
-- 
2.45.1.3035.g276e886db78b


