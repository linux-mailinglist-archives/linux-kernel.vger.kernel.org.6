Return-Path: <linux-kernel+bounces-366794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85A99FA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD19B2224D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBED1D63FA;
	Tue, 15 Oct 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l6Y7b7UO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B84185B47
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028784; cv=none; b=LfmHLX1MDtVXOv2ijXoeLCBavrjLWGgBwcbSHNVZyufumfwSLzELGVTPaAZXN/viZc8QNLWgiOA8axLFP5KcyT0Sno3S2DG1CGH3HF0xxSJYN5T6oYwwThqdt9w45FqmpQEpJRF6kGvUOQMvzH4IrrMxkjnkq0xNKfEi42UIK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028784; c=relaxed/simple;
	bh=Dc+Pn/A846DbmhgiRhcst9s4RfQ3zyv6mTqrUPUeMDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGw4Q7pSxaPvyymoVKC4IQmvffX2jbDP1pMVWrizg1swq4ku6YFw7q4QDUEDofg6whnFWSrMqsR0qCkt9oQA4GIquTlaCntf0IH5jtGnBIUsIwQl81xsGLt4Y7pBthm0/sIMEDMwYvPsozmmHqKMQIJc9LpJf1Sw0N507ml8jCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l6Y7b7UO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXOu2113399;
	Tue, 15 Oct 2024 16:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729028004;
	bh=kgqvnYCulx5GrBUNkm6dbN9z/AMn9nhQtJVyer7NG/k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=l6Y7b7UOlbfa49Ikd6d9jQL6LIyzk0tS3cK5/T8yuGm4jk5FOkchM+GLqjIqfs66v
	 JZF2b9lZOTJOVQaD9Ja33rNV3gNgtned9ib1n4FLk0HdLQanMSKn8X6f+WU/yHq3ZH
	 QWPM3Zrg3RIWhTh4Cf6xJWmmQrQF9ynteMUxqAzI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FLXO2c038573
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Oct 2024 16:33:24 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 16:33:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 16:33:24 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FLXNBc038888;
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
Subject: [PATCH v2 1/3] firmware: ti_sci: Remove use of of_match_ptr() helper
Date: Tue, 15 Oct 2024 16:33:20 -0500
Message-ID: <20241015213322.2649011-2-afd@ti.com>
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
---
 drivers/firmware/ti_sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1fb..6a6bf7a2d1349 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3421,7 +3421,7 @@ static struct platform_driver ti_sci_driver = {
 	.probe = ti_sci_probe,
 	.driver = {
 		   .name = "ti-sci",
-		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .of_match_table = ti_sci_of_match,
 		   .suppress_bind_attrs = true,
 	},
 };
-- 
2.39.2


