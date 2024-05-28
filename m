Return-Path: <linux-kernel+bounces-192939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACDA8D249C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16291F234E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331C117335C;
	Tue, 28 May 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJ8PfbFB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98C171E65;
	Tue, 28 May 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924596; cv=none; b=ZuvZs1dfb9D7qDjs2AznGu6EUusmz+l9a0aibRqUYZUGik+c3MwBSgJwBBdOgoqBTofh3oC+loukfF3OMX0jchLlIZXlfK+q1UaNiiH+cmCJX9jeIWbjplnEn1wu7/piI1URgAxj1SVGECT8e0+rxHbsIRxyALhVBuuqcdR0N4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924596; c=relaxed/simple;
	bh=jhpfqMAGii1QKtIKhhNyRYse2i/DMgLOIM+NJMRllAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozXt3B6wKvzn90FMgC4WCafdTuNI8HQX2CDTiZjvV2McyaYZBqpDeHX6GZ2Qjw1hkJkZ9BKlF2PTA1gj4IgmtkpJm3UcVnd3+kz0eS0hID47QK32Pv+TltbDj/1qxaY2UXx2cwdQk7XjqM2n9S55ZwDzQsF2Xa68n7ePtYq0dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJ8PfbFB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716924595; x=1748460595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhpfqMAGii1QKtIKhhNyRYse2i/DMgLOIM+NJMRllAo=;
  b=dJ8PfbFBnYQkyNDiarxPY3QCZOHip6+a+a8yWx5Vr89RNQmMQLot44kk
   2RIuEcQxG5zJ2Bn7Ngi2MPTGHQuAjO4t7BanMfrME99sZjDlwrch+Msky
   pQwTrdPzu5dg9MfojvRrOYq0aZdEkOUfPJL9jU/SmVopKbrF2muPAmW9T
   wX+fBvJmXHaxT2J6VCL31we5sQQ4nhLjCQ+2dkYYhIYvPGoi5ZKfu+GCJ
   g9eo6LsjQJni0yZoM40D4Vt2akXFZKkYT4YIYP9+vlQ9F0ZFTst+PE7CC
   ilBJ/ddzmK5Sr2F3pJoWbJeh+2geosgbE9A+BiQPiLneqPgGsM1kBYskB
   A==;
X-CSE-ConnectionGUID: VufqV2NoTU2/HBWAxFZoCw==
X-CSE-MsgGUID: J0ZErrkUTLqJk/iD5FWGcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24711843"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="24711843"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 12:29:54 -0700
X-CSE-ConnectionGUID: IMefETndQcyMYWtPaOeU6g==
X-CSE-MsgGUID: Qd0KmJVNRCmMoBqsIxJazA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35246720"
Received: from unknown (HELO pbossart-mobl6.lan) ([10.125.110.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 12:29:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	rafael@kernel.org,
	vkoul@kernel.org,
	andriy.shevchenko@linux.intel.com,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] soundwire: slave: simplify code with acpi_get_local_u64_address()
Date: Tue, 28 May 2024 14:29:34 -0500
Message-ID: <20240528192936.16180-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now we have a helper so there's no need to open-code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/slave.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 9963b92eb505..f1a4df6cfebd 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -97,18 +97,13 @@ static bool find_slave(struct sdw_bus *bus,
 		       struct acpi_device *adev,
 		       struct sdw_slave_id *id)
 {
-	u64 addr;
 	unsigned int link_id;
-	acpi_status status;
+	u64 addr;
+	int ret;
 
-	status = acpi_evaluate_integer(adev->handle,
-				       METHOD_NAME__ADR, NULL, &addr);
-
-	if (ACPI_FAILURE(status)) {
-		dev_err(bus->dev, "_ADR resolution failed: %x\n",
-			status);
+	ret = acpi_get_local_u64_address(adev->handle, &addr);
+	if (ret < 0)
 		return false;
-	}
 
 	if (bus->ops->override_adr)
 		addr = bus->ops->override_adr(bus, addr);
-- 
2.43.0


