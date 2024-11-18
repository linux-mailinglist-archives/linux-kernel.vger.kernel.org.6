Return-Path: <linux-kernel+bounces-413185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7539D14F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F54EB28524
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C041A08BC;
	Mon, 18 Nov 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fkg73wde"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961E1DFFB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945277; cv=none; b=kzDsTarkgwMLcRc7cTkQUwd58rL8ujPAH2jDwmy7o5VsEG1duY14w825zNCmGHopuIbVUydkuUgJlL1yaGTwZuqpkp+8JjbbFpGVZbCTygvXmlXqne9EKc3z/ks+q0yN9b/w5TTNbxBvRKNlleNQ1KMZi6O9ndo5RvGKlf53Y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945277; c=relaxed/simple;
	bh=EkXsvnXYvHDBrDyWxzREH6UlYXBi0F9oMvLf4SjdGAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PO9nrL1+9xnEptePpHKetB7H2ni2KArHfkf5C/RLmBEDyUZsdpmydYs1BeGubbci7g+/gG34W4WNaFBGozcV2XL6VOttK3YdzmBlSaLdG3QzRtZXJ8dvOn/nzFy10FG/MdfjUYFT85BfVlzbFCBx/cxsV/2efr5KCv8NSnBL804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fkg73wde; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731945276; x=1763481276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EkXsvnXYvHDBrDyWxzREH6UlYXBi0F9oMvLf4SjdGAI=;
  b=fkg73wdeLW2/wFgkW/uHJDCvszWdlTT2fuajk0TiBfyIZttEQjF4duW/
   0yxAL0UEcd+SMVVS8ix6gsVgNMvkzh5IlcapUGPmqMNyufjTTS7Xa/SIF
   zFkVKCi6Wmmx0/l7Jj6vTRliN5AoXLEHXMomRWqcD5agKrgLH3TqoSOXk
   QSz0Z/clkRCBKgx2C3LDZoQn3ZYULqgFQfomAwxo/93lFH3i5/+RO4VCM
   Tt4WovIdP8sKwWUAjM7986ejEslsXQ0vPpWUnkB2hhMgQVOvp5OClVCB0
   nC3la6xmcl5bjxAGrRDHQrcOGeQJ6QHZrjzXYfo9O0SvsfGWZHzwrT322
   g==;
X-CSE-ConnectionGUID: qvuwS+dsTduap8NKwvql5Q==
X-CSE-MsgGUID: yVFQ8QXBQTGLlWUbI6XDRg==
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="34460916"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2024 08:54:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Nov 2024 08:54:22 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Nov 2024 08:54:21 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] firmware: microchip: fix UL_IAP lock check in mpfs_auto_update_state()
Date: Mon, 18 Nov 2024 15:53:54 +0000
Message-ID: <20241118155354.697411-1-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To verify that Auto Update is possible, the mpfs_auto_update_state()
function performs a "Query Security Service Request" to the system
controller.

Previously, the check was performed on the first element of the
response message, which was accessed using a 32-bit pointer. This
caused the bitwise operation to reference incorrect data, as the
response should be inspected at the byte level. Fixed this by casting
the response to a  u8 * pointer, ensuring the check correctly inspects
the appropriate byte of the response message.

Additionally, rename "UL_Auto Update" to "UL_IAP" to match the
PolarFire Family System Services User Guide.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index 0f7ec8848202..df1d69bdc1d7 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -402,10 +402,10 @@ static int mpfs_auto_update_available(struct mpfs_auto_update_priv *priv)
 		return -EIO;
 
 	/*
-	 * Bit 5 of byte 1 is "UL_Auto Update" & if it is set, Auto Update is
+	 * Bit 5 of byte 1 is "UL_IAP" & if it is set, Auto Update is
 	 * not possible.
 	 */
-	if (response_msg[1] & AUTO_UPDATE_FEATURE_ENABLED)
+	if ((((u8 *)response_msg)[1] & AUTO_UPDATE_FEATURE_ENABLED))
 		return -EPERM;
 
 	return 0;
-- 
2.34.1


