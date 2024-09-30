Return-Path: <linux-kernel+bounces-343727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC79989ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501B21C21A40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF309189F5B;
	Mon, 30 Sep 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k6dWiGcQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF4127E18;
	Mon, 30 Sep 2024 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690132; cv=none; b=em5SnZTFRsbuLRvPsxSdFcym2dTV0JIJb03srJF9jfA/Ap3k3tkReX9fVOfei4lxSQLTyio8Ki0gHkuInejmEPooG/IjjS6dnqHRtuPu0v81BFiBSypdLdbZBHgx3BlVz7YFsWI+B0oqFSVVJHWLIfUdLO9p8J2J6i4ZMaNWl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690132; c=relaxed/simple;
	bh=2IUWeqUfg54ZM/aTN3euYstkCkPDbRVAH5h9f4drcdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsCoqOpKLy65bAicPeaZSYOmwxnVFbggznlLjPmJgXysCCFz2bA8cjEzwzMqy+Vszz7mubxFjKIolgzQ6knK/q8U3V9SVKu9Q3IaCGshedKzATEa3wuBY9j0QiPpzJ/te7YxUVPbW6b/l/rufbNUDI6C2VBDPTF3QDQ6bK8iu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k6dWiGcQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690130; x=1759226130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2IUWeqUfg54ZM/aTN3euYstkCkPDbRVAH5h9f4drcdg=;
  b=k6dWiGcQuI36w2mHX86jxMfUbPirripUixOyGmNJYHDdzaij4MwNG1yL
   /30Y+K3HH53+mA+VSjWyTzCSrvZinGfZPam8ppnKcGMpzY3pha/C66PDW
   61KXw6JlychJcEvqScL6aeid7AO2z2tkj56y5S9Sbvs4+eBVNcktUQ3rS
   ejncMz/ARo3GQlyId5PRH7N8VMJ9yHQj1TqZ0gb8ypa3r+kVyY2SQrayC
   hmi/6ZwcHKxwAhyiFpYZseB24w7bVeM03VMmg6M0owM2B7fX1Z8WZuCd5
   VINzwO23cW7jZ4LIya5vDqrM9GEd7A0O0c3ILZeobq8k5dlcE4USi41aM
   w==;
X-CSE-ConnectionGUID: xGA0e8NKSjGIdIb5emHvfw==
X-CSE-MsgGUID: xN753j2QRd+kvlfvg4o32A==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32997882"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:02 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:00 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 02/20] dt-bindings: usb: add PIC64GX compatibility to mpfs-musb driver
Date: Mon, 30 Sep 2024 10:54:31 +0100
Message-ID: <20240930095449.1813195-3-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX musb is compatible with mpfs-musb, just update compatibility
with fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 .../devicetree/bindings/usb/microchip,mpfs-musb.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml b/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
index 27b909de4992..a812317d8089 100644
--- a/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
@@ -14,8 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - microchip,mpfs-musb
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-musb
+          - const: microchip,mpfs-musb
+      - const: microchip,mpfs-musb
 
   dr_mode: true
 
-- 
2.30.2


