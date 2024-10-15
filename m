Return-Path: <linux-kernel+bounces-366767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B964799FA20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D2C283CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CF2036EE;
	Tue, 15 Oct 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PGA6R1BT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03371CBE8A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028028; cv=none; b=cgfFA3DO8j8xN2+acgIejcMqKjzJquWTRE+qnEi7WERb0yv6CHAzFIviWxmGFlLnFPnuWTYbrujDFSVQk2XmLwzGtnue0TeZ/8lE7TAv0e+urEdyn8gvLfD9IEGvYRwBHAKLTbrbyvASHvoyvDa2bd0NzjraV5WfRXXDUB45Mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028028; c=relaxed/simple;
	bh=nE5kzkgxlW3mWKMfOxkbRz1342Bww304gNX6g00214U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e21bHJMaQcneiRIuNEmNVGORAxPqlwyNyi/Pafr1g3u2cQxPFc4E5I8ZVwdb/S0IuEEhxxXYCbigMMqsiJPu2uzH7V/K6JiIGpU4+ZgtpIXx9RvBdVlc+jZJq7b1Q0Tg6Iavr5m5EuWtG9pUXWwIQ+NYDdEg/6pyoNj6GJjcRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PGA6R1BT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXPCB028091;
	Tue, 15 Oct 2024 16:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729028005;
	bh=FyOwZ0vkZR3VUSG5bnWs+lHeIc2qBlsGjbbcrAj+bnE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PGA6R1BTEdYUHwiYAIuUBo33yLXeWQHjphHEwGBmW/7EmnQ9p7McqjFAtbCPs/oWR
	 WkOUG45HVnRlNIpDcrEP9T/xDEg+Pdn2hI4ZV/AkG9UntUlNnozo3Z2fHxELGGjZRY
	 X3DH9i5N3wS6SBdeKrsWSeq0UQVmiU0SyBAD5xl8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FLXPlH086613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Oct 2024 16:33:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 16:33:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 16:33:25 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXNBd038888;
	Tue, 15 Oct 2024 16:33:24 -0500
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
Subject: [PATCH v2 2/3] mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
Date: Tue, 15 Oct 2024 16:33:21 -0500
Message-ID: <20241015213322.2649011-3-afd@ti.com>
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

When OF support is disabled the of_device_id struct match table can be
conditionally compiled out, this helper allows the assignment to also be
turned into a NULL conditionally. When the of_device_id struct is not
conditionally defined based on OF then the table will be unused causing a
warning. The two options are to either set the table as _maybe_unused, or
to just remove this helper since the table will always be defined.
Do the latter here.

Signed-off-by: Andrew Davis <afd@ti.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 9d2d4ff6cda40..8eb8df8d95a4c 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -920,7 +920,7 @@ static struct platform_driver ti_msgmgr_driver = {
 	.probe = ti_msgmgr_probe,
 	.driver = {
 		   .name = "ti-msgmgr",
-		   .of_match_table = of_match_ptr(ti_msgmgr_of_match),
+		   .of_match_table = ti_msgmgr_of_match,
 		   .pm = &ti_msgmgr_pm_ops,
 	},
 };
-- 
2.39.2


