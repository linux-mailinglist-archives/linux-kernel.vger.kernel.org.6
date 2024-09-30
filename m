Return-Path: <linux-kernel+bounces-343849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212898A049
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EAE1F21DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65A18FDD2;
	Mon, 30 Sep 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="POKTrwcU"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4A18E36A;
	Mon, 30 Sep 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695305; cv=none; b=pktuz9GV90bIX6ECFjD3TXTJEiaB5aKKU6SVttIlSPwnJTU5irAIqpmHga/X5wUiIFHyuhmOrin3ydhmVgNPWFp5YVjgBapuL3ILuywq7+mZZWPMzj0YrOTMaqnI0N4H52h6b7Z/B0GUcZEFTtkI71n8Zzp0T54SqDpwH71EaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695305; c=relaxed/simple;
	bh=r1TOoO18QTeynpzBRxTXnpPJtNsE+hAAnVbDN3vVOw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdEozSSOcwxi7NLzr20fC+YjNek1+Isb8qNEyXKggW3WPOlXOfHtLsFe0WJ2LOPxWfVPJbBluBz/QwNBFO5l5EnrKYbaW+Q4CD911o81YAlyrl1GPudZPk/GL8SIJTPdmMRlLH2XWkvJMRy48xgIEEtWayfHerWii365DvTGceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=POKTrwcU; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaBKHddTICTKiGHnZubTWvkK0E5wtTgvSmQ4wWkyAmw=;
  b=POKTrwcUC6O7gf7n5schmL15OxR0TGfzdq2ToAtn9GL5sPgNhomVDmR7
   Di2zK2Q/Ly6f61dXi2fFt1MopMubZi0uyM2kqGga+kgx1crmo2LIbq8ru
   xdEqgK/YYzbv6mRwClBDMg9XlwyAjYGvdFvnTWvHdAd1Dx5NOiqdrx+P6
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956874"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kernel-janitors@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/35] libnvdimm: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:51 +0200
Message-Id: <20240930112121.95324-6-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/nvdimm/dimm_devs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 21498d461fde..8c35502638e2 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -767,8 +767,8 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 
 /**
  * nd_pmem_available_dpa - for the given dimm+region account unallocated dpa
- * @nd_mapping: container of dpa-resource-root + labels
  * @nd_region: constrain available space check to this reference region
+ * @nd_mapping: container of dpa-resource-root + labels
  *
  * Validate that a PMEM label, if present, aligns with the start of an
  * interleave set.


