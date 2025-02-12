Return-Path: <linux-kernel+bounces-511792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F45A32FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B716A3A8C86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCE200126;
	Wed, 12 Feb 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdbB9hGr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309D1FCFE2;
	Wed, 12 Feb 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388686; cv=none; b=JfZvmYucLlz/PskPViHuyBRx0V7+OtaqMLzsr6y6WiSZD+IBPCKMBMFsc3EUauyekwE4r0f07/FA0hHSZnBKWydfwKF//PSPFNYovuZl6T7QGHd6RhurURiha+114u/4MHsGjuWkhLraonBzPaIPwuE3f9mlgYftTY/fauzVUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388686; c=relaxed/simple;
	bh=Ze4Uk+nUu5ksQDzaMxOYhGlURLhavDr5sueanXUJg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg5I4dFV6v3apod3A4BAqvM32SsE0m2U4hlDAeg5laeg3e8bN+W0f2VGvEqNELGKNfCH+NTIwPTSjd/7XQDs/f70rE21lHszuVK5h4l4w9X9dzwO7NLI272iYzm/sKX2iNpzkRK0BCQbIq4oafrrrYrEByocNXyrToRAVj1h4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdbB9hGr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739388685; x=1770924685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ze4Uk+nUu5ksQDzaMxOYhGlURLhavDr5sueanXUJg4I=;
  b=MdbB9hGr62dMLC5uy1mEYLZzLt1zpZO+QhuqUPF3nt8XYo3P4r5uXbk0
   NzfDNv8dJrBOapg3vLHH3qqp0nzSbofYJid2WSLqL8xdkyNmB7Gg/pTz4
   qJpy53ig820H4iRF/6FLj9jWSJgPMuSLogXXqGnxGKe2Oq9brV0qU1ODE
   wxeKlY/mXHg9k8ooo82eDJuECDayjaKNAIeMdr5QdqiyFnTaGKcc+gaP8
   tWUbTTWkATZdcN9YPYhxrFKFvFVGLC0nEqhmIhYv3PV62UvSntAsO5SMb
   HsSizBkYWQTvEmNtWSIzv0lIkCSMJ/TuqUMKa3gJtdFFOu92linPtkw9q
   g==;
X-CSE-ConnectionGUID: ZMA/fwJMTLu2Q9YNEhQTKA==
X-CSE-MsgGUID: t95BTWm/QiWjouurikkS1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40183660"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40183660"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:31:23 -0800
X-CSE-ConnectionGUID: jZzIFCRWQrSRGiToBbcmjA==
X-CSE-MsgGUID: 83Ttg1O6SLC5MMotY1ehWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117542534"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2025 11:31:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5353810F; Wed, 12 Feb 2025 21:31:19 +0200 (EET)
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
Subject: [PATCH v3 1/4] dt-bindings: usb: dwc3: Add a property to reserve endpoints
Date: Wed, 12 Feb 2025 21:28:01 +0200
Message-ID: <20250212193116.2487289-2-andriy.shevchenko@linux.intel.com>
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

Some of the endpoints may be reserved by hardware for different purposes,
e.g., tracing control and output. This is the case, for instance, on
Intel Merrifield and Moorefield platforms that reserve a few and USB driver
may not use them for the regular transfers. Add the respective bindings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/usb/snps,dwc3-common.yaml     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
index c956053fd036..71249b6ba616 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
@@ -65,6 +65,17 @@ properties:
       mode.
     type: boolean
 
+  snps,reserved-endpoints:
+    description:
+      Reserve endpoints for other needs, e.g, for tracing control and output.
+      When set, the driver will avoid using them for the regular USB transfers.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 30
+    items:
+      minimum: 2
+      maximum: 31
+
   snps,dis-start-transfer-quirk:
     description:
       When set, disable isoc START TRANSFER command failure SW work-around
-- 
2.45.1.3035.g276e886db78b


