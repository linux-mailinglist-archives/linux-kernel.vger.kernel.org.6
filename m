Return-Path: <linux-kernel+bounces-519076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1BA397D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6693B6221
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39E234989;
	Tue, 18 Feb 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzKbM9s3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373D22CBD0;
	Tue, 18 Feb 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872097; cv=none; b=l/UhzwJWXloYNkyBL7A8CvvkXk84TPMMuKWBTG5mFyelQ29a4nYsKQwtvK2QfnnHLMA44T16lftITkBoQxQeq6ohqbItWwNEX4b/zWIQ3FTw2TUDBMetiD8aX+TRphC4uNA0XV+OcaindGMVsKN0khhzxzLnRivd0sScVOaRUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872097; c=relaxed/simple;
	bh=7xvR079/IqlgoT6VeAi2Rgf0rAY9RVQznBJRU/Mtjis=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMtO9szwopdR0KOH2e5q+V4tdA9/bUrE1/rpUlv05M8Mc7g/9S9s4JobTs9X7NfchjW1WngsdITEjJSKuydw6SWvr95/Xby1lYxd3BUevURSTg9jVsExriiDb6DyJJIUuoTUALOoXDwyX+z8innRmAcHnqs/1NsxX4xJtCj/L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzKbM9s3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739872096; x=1771408096;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7xvR079/IqlgoT6VeAi2Rgf0rAY9RVQznBJRU/Mtjis=;
  b=mzKbM9s3SZNW+emMq8NUBAnjJDg44pN3XHXXHOJc68/i15ByVz0xxW6R
   PCC71L6EUfkdTgxicD1zHD4UV1u4LPFEKle8y6n2iEAo1uYCwUSKwxO9S
   MrONlw7bQxxsRgAGGZpEjT1Wi4sIo66nP3tqxrjVtyb/wfkqFjELjfrTK
   DYwFbnwVMK7nN5IFD35C4IXd3LTyh6T52lFWj0QDJq46j4q0QRjdzu5+5
   4Zp8e73oPBn+G0zURUkdeT9XdyYEpBNbKqJCuWLOl56iwq+ZCEVLEDELh
   tN5hV7hS/dwRK/11OF06VcNZTpRkomJilkchR+brm69mjC6t/6/2yDk5L
   g==;
X-CSE-ConnectionGUID: RMwT4YewSMCjQXMZSd0jqw==
X-CSE-MsgGUID: rSrwvzJMTE+MHtOCK1imzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57965152"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="57965152"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 01:48:15 -0800
X-CSE-ConnectionGUID: qouKpCZ3SAGtFehp1wtS5g==
X-CSE-MsgGUID: bezJWGIRSnyYnbuGbsFsYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114213739"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2025 01:48:14 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: intel: document Agilex5 TB daughter board
Date: Tue, 18 Feb 2025 17:44:33 +0800
Message-Id: <20250218094434.3574060-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218094434.3574060-1-niravkumar.l.rabara@intel.com>
References: <20250218094434.3574060-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Agilex5 devkit supports a separate daughter board TB.
Document Agilex5 TB board compatible.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 2ee0c740eb56..c41a6d021a06 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -25,6 +25,7 @@ properties:
         items:
           - enum:
               - intel,socfpga-agilex5-socdk
+              - intel,socfpga-agilex5-socdk-tb
           - const: intel,socfpga-agilex5
 
 additionalProperties: true
-- 
2.25.1


