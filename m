Return-Path: <linux-kernel+bounces-195148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD328D482E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E2C28313E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D2B18397F;
	Thu, 30 May 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdO583pX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A6183974
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060469; cv=none; b=ta+XaoowZfdgYQ2IGxe9OfPgOs5b9SG28xpkeqXxBdGFNnEdknWoMSj2bzLIDjAJceRPVUJkK50Theaf2Z8ja9e0cmOlngdHsg2XN+igO3APFRr0KS/tBLWoFseXvjas4BBl3YQRycATPl4q5UH2rrpcLicWpFyePkyPsp31UKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060469; c=relaxed/simple;
	bh=qPcJ9iaG2JLa1C1oJqOGxivLSPkPSQ/sm/SWczsd9kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bp48jVLt+3cmzOucJRcTt0BoYIPm1Nsqh6U6NX7bvpevw59hZFGzEw+widjaExoWB1gFfuKxP7DXyOfaxldszhRqAkxh5VpalwjJCQAI0lwjC38RyvdILyNcjsXYb0aBQPTd6VhfWGa+enL9jgliq0UGdiLzDJHM6ZDlVd/XewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdO583pX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717060468; x=1748596468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qPcJ9iaG2JLa1C1oJqOGxivLSPkPSQ/sm/SWczsd9kE=;
  b=NdO583pX4/L///BzPekRB3ilj2XhhzQ1QCEcpAbsqwqZckJZdjeq/x2f
   4psY8SQBdehaIMbYpm6qboxejClT4FJ/b+DNp7OUvXdEfF2TDb9SzDSLn
   njgkPAW8umobmPR5fEttOC6vYvEGZebIgxGGPErChwGB+kaHhtvvWCaoZ
   B15yJlyuv/04X2Ej7grNvv3hGFav4SqSsPkZE5z981eGkVeKFwKWPbYMB
   7ymp+GJbLjl15Thwuqs/AEKAIfwkKwWiI8p8DBSBQsJYEu30yjqXqVuyI
   xMtU73vYt7N2odUGjie+5sbskzi3NYLxN095ht21hbM6jWAKMwAKwmMEc
   g==;
X-CSE-ConnectionGUID: TbhMLzX4SKuKCwHjVKx30Q==
X-CSE-MsgGUID: t/YD0p4OSMC3MV/uDZJHeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24941559"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24941559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 02:14:27 -0700
X-CSE-ConnectionGUID: difm4qKxTDm8N6CNMLbuug==
X-CSE-MsgGUID: 2K230T41TeKePi9tqS6eoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35812047"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 02:14:25 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: demote client disconnect warning on suspend to debug
Date: Thu, 30 May 2024 12:14:15 +0300
Message-ID: <20240530091415.725247-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Change level for the "not connected" client message in the write
callback from error to debug.

The MEI driver currently disconnects all clients upon system suspend.
This behavior is by design and user-space applications with
open connections before the suspend are expected to handle errors upon
resume, by reopening their handles, reconnecting,
and retrying their operations.

However, the current driver implementation logs an error message every
time a write operation is attempted on a disconnected client.
Since this is a normal and expected flow after system resume
logging this as an error can be misleading.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 79e6f3c1341febe0921b32dd..40c3fe26f76df0a5a7fe192e 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -329,7 +329,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.45.0


