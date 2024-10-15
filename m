Return-Path: <linux-kernel+bounces-366766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B087399FA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41341C2202A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6EA202653;
	Tue, 15 Oct 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YpWeCW4x"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB647202640
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028027; cv=none; b=J28+AMfxORbkY1zrXvP2fAPymZisL9jZBaFisYOXVPKYY/uY2xWhFMwcEJc0rizNnCDSswWbualSDaBnunvhE++ZiaLuCjaut+SOf0VHUGTb7JqljKfcbuR6baq9TswlGivQlU2bTljy7fjEBnqzUyALlMK5Lkwo448iVVgxf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028027; c=relaxed/simple;
	bh=yif5WGdngIm9HjD6DlYBoXIhPMqEFaBqxwmPjDbql7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqBABY9RQ5SyV2jhwEBQPhlPxFSJRdvnMSBZt+Cvw3w0PXtAWW6pR2VTtg/yjAy7D1rGx04mbgf9pqA+nGfWdl4ZijP3z7b+NrFuS7CvnYVlZ59N5cHc6iAskiJIwGin8YIVIlZlrASRvlsukRM7igyjC7xMSxVB6iKZUkPyr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YpWeCW4x; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXPXN025915;
	Tue, 15 Oct 2024 16:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729028005;
	bh=QvnFcob+2HOivdOzFJ/ecoS+EXmlRXVsbJmIgJJMYlY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YpWeCW4xl+x2cVyRI07AIIE6ri17ufcsopX3qzE/GGM/+wz7qDSPCftGiVHuSW3B+
	 nG1bO/h3Gnf9qo07uyhOedycIMYbM6RcUuzu/7bC5hO0gvHW7qSB40bVt4KgmPSVnu
	 5SQOo4sj70bY0+FFGXsVTfKQE7EUQgrsP0F8UdYA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FLXP1C038581
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Oct 2024 16:33:25 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 16:33:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 16:33:25 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXNBe038888;
	Tue, 15 Oct 2024 16:33:25 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Hari
 Nagalla <hnagalla@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 3/3] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
Date: Tue, 15 Oct 2024 16:33:22 -0500
Message-ID: <20241015213322.2649011-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241015213322.2649011-1-afd@ti.com>
References: <20241015213322.2649011-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The TI message manager driver can be compiled without ARCH_KEYSTONE
nor ARCH_K3 enabled. Allow it to be built under COMPILE_TEST.

Signed-off-by: Andrew Davis <afd@ti.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 6fb995778636a..af721d769fdf2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -127,7 +127,7 @@ config STI_MBOX
 
 config TI_MESSAGE_MANAGER
 	tristate "Texas Instruments Message Manager Driver"
-	depends on ARCH_KEYSTONE || ARCH_K3
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	default ARCH_K3
 	help
 	  An implementation of Message Manager slave driver for Keystone
-- 
2.39.2


