Return-Path: <linux-kernel+bounces-331563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DBC97AE49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2521C20C04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B78215D5C5;
	Tue, 17 Sep 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OGKi1MPR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6B159571;
	Tue, 17 Sep 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566844; cv=none; b=MY3cU4sF233vh8ecKIDQdvZ7CHMM/qN/4LeLZspYV8UpboMqT9TvYFcAL15VvSL+VrdfY0sC3KlbWm9oEtOCapqUAvrhLY0xKgu0DrufvU9ckCgmsMjal2EH4O5E1Js8zwvXklzhGnd09GGn52I+bNJXNVo9PsxK3UbeYWfN9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566844; c=relaxed/simple;
	bh=Knr0oz1eQjbz+tPKBtBrMJW5eGNSdwYGIS4Zj8zkcZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TK1ABtqMNFIAJwqxZqNkMeTmy3ZrbWKCTnHe+C7wVBIeMltsNGGfESfKfoOK5GnBsDB/av4LaKefmPpuzUVi5xhTV3JA+u8pDtK91DmM2/ckzllo1xGA8i/pVGM16kGoOi7MYWN+BB86mUFbNhp3v8GKOKShbvHTGnOyxCtpJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OGKi1MPR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726566842; x=1758102842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Knr0oz1eQjbz+tPKBtBrMJW5eGNSdwYGIS4Zj8zkcZA=;
  b=OGKi1MPReyZlfCMMuRuQk9sg46n8Pp5YkvYmC5reZRJqdz48v0nrNZW+
   7Wd6WrQodLjKo6J8KN5jXg9iTaWX/ZcHw+WRWsUIODPDHxybIxA1SODPq
   6lucj/iUZS1QwZtbYCUhcoOGh8SesawGT+w03tkw2WOPFKmIEUZtUngsr
   MAc+Gil+sPHIBTSCVL4A+KPiXXQSDDkUr0+6vADcXTmY9VElSdzI19CVw
   /pmGJGqDoPLPcGCGvSyIXEuSdUfKfOjXnM7lV2xN28XZAmUabcPeHCmZs
   0xZmsnGARG9VLtpuOwUyv99mCBnzvWlydb/UQBmjCLUNtXXZndE21Kt9l
   w==;
X-CSE-ConnectionGUID: Mdul6PMYQfWPexUkUfCh/g==
X-CSE-MsgGUID: 3SiWlWyIRI230gpDrSVBCA==
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="199320851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2024 02:54:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 17 Sep 2024 02:53:45 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 17 Sep 2024 02:53:40 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <sam@ravnborg.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 1/2] dt-bindings: display: panel-simple: Document support for Microchip AC69T88A
Date: Tue, 17 Sep 2024 15:23:29 +0530
Message-ID: <20240917095330.267397-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add Microchip AC69T88A 5" LVDS interface (800x480) TFT LCD panel
compatible string

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b89e39790579..09911b89d140 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -200,6 +200,8 @@ properties:
       - logictechno,lttd800480070-l2rt
         # Logic Technologies LTTD800480070-L6WH-RT 7” 800x480 TFT Resistive Touch Module
       - logictechno,lttd800480070-l6wh-rt
+        # Microchip AC69T88A 5" 800X480 LVDS interface TFT LCD Panel
+      - microchip,ac69t88a-lvds-panel
         # Mitsubishi "AA070MC01 7.0" WVGA TFT LCD panel
       - mitsubishi,aa070mc01-ca1
         # Mitsubishi AA084XE01 8.4" XGA TFT LCD panel
-- 
2.25.1


