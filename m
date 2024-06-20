Return-Path: <linux-kernel+bounces-222402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2FC9100F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DF8283D07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483C1A8C18;
	Thu, 20 Jun 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y7ebcpOn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D551A8C05
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877515; cv=none; b=m421zrjSCNfd2d+XOA0oUSsMJbMvXlVr/wma3kRM7YDIg/1FZBNQhfJ8oucFyPiSVGqd0ei3TF6SLlNIcEJLknKSOb4tWouhphNonSYUlMAr4wshv7Tczc++WcQduuz/ZM+vc0Dx2CQj0xxl3owFpaewj5qGpFkXAjMxbnOt7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877515; c=relaxed/simple;
	bh=JsDkBa8BIU8kt1tFosPylwKEidocTtesbost8Ep5hjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gAvsAMP0jje5rOCosHlMtRoNzGDwgfpHaYKidRp4TIy+dTUnOBUubyL9NKTZH3EJDfDhtbL3+Bx881oZHFqtJTxGsDEQYu6oTjU7KExUs50S7gMc9kl/J96lzLk2E8fwt+5vUU6jpVfp8UfWTo1Lq/WZupW0d7wo8Upwd9HKork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y7ebcpOn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718877512; x=1750413512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JsDkBa8BIU8kt1tFosPylwKEidocTtesbost8Ep5hjU=;
  b=y7ebcpOnkmLp/Wvb4bM29UNjAM6EH0VPMkhYXAVFRRI1gCJQ+ndgv3Nl
   KYRpmLHBI+If2Q3l8dTGOWMYgK49Z6laS/zNpyTRs3edJurekexRdYH8w
   LU8SewdjG3dX3q9VUfliLil4PV5GiW/wld7XAuPGmRYWznwwYkfOSF4d7
   +3CG33NWSDn2T3hPqN/f9c0kkvgxkYz4p4pzzCmflZZL478TrUhMcyEhe
   C3lg5kr3Q2vaS5cPzd+vJKdDoLIbuJzx08BRSOr3q5Oq8nNwDM7P6XQbl
   4ryijpcpZuXJlTNjZxrBgBalX4FRX3m094mDiz0A4GN2oykQVDvpTk6/7
   Q==;
X-CSE-ConnectionGUID: xMJ21LrvTXOs5KEZiuh2KA==
X-CSE-MsgGUID: 9oDDM3BQRcSi06Ooessizw==
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="259152117"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2024 02:58:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 20 Jun 2024 02:58:18 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 20 Jun 2024 02:58:15 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: <Hari.PrasathGE@microchip.com>, <Dharma.B@microchip.com>,
	<sam@ravnborg.org>, <bbrezillon@kernel.org>, <nicolas.ferre@microchip.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH] MAINTAINERS: update Microchip's Atmel-HLCDC driver maintainers
Date: Thu, 20 Jun 2024 15:28:56 +0530
Message-ID: <20240620095856.777390-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Drop Sam Ravnborg and Boris Brezillon as they are no longer interested in
maintaining the drivers. Add myself and Dharma Balasubiramani as the
Maintainer and co-maintainer for Microchip's Atmel-HLCDC driver.
Thanks for their work.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1566c647a50..8f2a40285544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7290,8 +7290,8 @@ F:	drivers/gpu/drm/ci/xfails/meson*
 F:	drivers/gpu/drm/meson/
 
 DRM DRIVERS FOR ATMEL HLCDC
-M:	Sam Ravnborg <sam@ravnborg.org>
-M:	Boris Brezillon <bbrezillon@kernel.org>
+M:	Manikandan Muralidharan <manikandan.m@microchip.com>
+M:	Dharma Balasubiramani <dharma.b@microchip.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.25.1


