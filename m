Return-Path: <linux-kernel+bounces-511794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C1A32FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49146168763
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3D20102A;
	Wed, 12 Feb 2025 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6W3LKvR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B71FF7D9;
	Wed, 12 Feb 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388687; cv=none; b=nQWN36+ttJfLhrG+tbGHoc4l79VBjSdN4EKUlH+ZJ9f0Ut+JUjVWtmKdA2268a/Oyx/HghdneLSstsbUu/S4WvfMnlJULiqpfF9dQbExtTKdTL0uE5cy4JlY6nW6dRW8EojCXlO/00ItycBlRKMS3TQizLd8lfd7+DjiSCRIBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388687; c=relaxed/simple;
	bh=Zka1OgwBNU8gVd96R+RYcxMXujnKFe2UmvDxynnRWSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR3AAtqQt+MFz6xAFGdd10R5nFlkqR+MVKNP1F3z82sb0VCvp6jroFwVlN+xsbXcXCRzPYkvSGtGnI0Kx6B71pcSEXRPFij+HIqF9XWs19FzRZVV5NK6yvZb5ovJbweBUN+SJbGIS7KxYdHcjz8CspCs1i99xh6Cf+sDfUdQZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6W3LKvR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739388686; x=1770924686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zka1OgwBNU8gVd96R+RYcxMXujnKFe2UmvDxynnRWSw=;
  b=J6W3LKvRQpdy3PGZigvrEIcNmtSlHb0/ZC6nlfYbF2Gjj+iU+T8IY0PT
   K/zzOCOHNNblN9nTD6I3z6l10mvYUbPx8Sn1tbCl8wp8wT0o0n5B2QpsZ
   26GlNCNY52ekCfZ3uOwPtgrearlHHVYbiiJxGW24Czu4xV3YcCwt0Pp6i
   6aJLo79E2iheNLQi8it56EEstKRpqmnpX+HacZo+LxsATMsGK2IWlsERM
   d5KHJx+ITEXwwl/Uy+shDiL8m/ilrMIf7MvilAYwRgklpz94VAa2DbaIj
   tOPuY4lWw1h93FV8FwgoZFyK1L8qc2Yf9jOv/ckAHxV0FQuif8NifNN9S
   Q==;
X-CSE-ConnectionGUID: 2pufIgPvRVuHcvxTshK4FA==
X-CSE-MsgGUID: 2KjSeKFWTjqjLYKIK8iPXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50714407"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50714407"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:31:24 -0800
X-CSE-ConnectionGUID: sXj48DD0TU26vi1Z7vJOnA==
X-CSE-MsgGUID: mULhXL8bSGC45HZosk7uvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112880549"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 12 Feb 2025 11:31:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6F4682CA; Wed, 12 Feb 2025 21:31:19 +0200 (EET)
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
Subject: [PATCH v3 3/4] usb: dwc3: gadget: Add support for snps,reserved-endpoints property
Date: Wed, 12 Feb 2025 21:28:03 +0200
Message-ID: <20250212193116.2487289-4-andriy.shevchenko@linux.intel.com>
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

The snps,reserved-endpoints property lists the reserved endpoints
that shouldn't be used for normal transfers. Add support for that
to the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
---
 drivers/usb/dwc3/gadget.c | 41 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 73cebb7d90c2..f3ad8434366e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3403,14 +3403,53 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	return 0;
 }
 
+static int dwc3_gadget_get_reserved_endpoints(struct dwc3 *dwc, const char *propname,
+					      u8 *eps, u8 num)
+{
+	u8 count;
+	int ret;
+
+	if (!device_property_present(dwc->dev, propname))
+		return 0;
+
+	ret = device_property_count_u8(dwc->dev, propname);
+	if (ret < 0)
+		return ret;
+	count = ret;
+
+	ret = device_property_read_u8_array(dwc->dev, propname, eps, min(num, count));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 {
+	const char			*propname = "snps,reserved-endpoints";
 	u8				epnum;
+	u8				reserved_eps[DWC3_ENDPOINTS_NUM];
+	u8				count;
+	u8				num;
+	int				ret;
 
 	INIT_LIST_HEAD(&dwc->gadget->ep_list);
 
+	ret = dwc3_gadget_get_reserved_endpoints(dwc, propname,
+						 reserved_eps, ARRAY_SIZE(reserved_eps));
+	if (ret < 0) {
+		dev_err(dwc->dev, "failed to read %s\n", propname);
+		return ret;
+	}
+	count = ret;
+
 	for (epnum = 0; epnum < total; epnum++) {
-		int			ret;
+		for (num = 0; num < count; num++) {
+			if (epnum == reserved_eps[num])
+				break;
+		}
+		if (num < count)
+			continue;
 
 		ret = dwc3_gadget_init_endpoint(dwc, epnum);
 		if (ret)
-- 
2.45.1.3035.g276e886db78b


