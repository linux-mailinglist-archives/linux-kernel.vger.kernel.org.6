Return-Path: <linux-kernel+bounces-200307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FCD8FAE51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A32841E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF659142E89;
	Tue,  4 Jun 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ri+XiH/t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAC14387B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492061; cv=none; b=nHIdsmXALzgZZLbw7WAgS+Fz9OJvUXvi7U9IH+yMP3PYDEpXg4ieF0t1vcY6saFZEhgorL+ef+Ty0i1ZhdHurbeMQc62ZFp/f9ZmXgia00MGHaoqEsDAJt5m2aDSHUmhrL3je/8JYxUgqXV000IHUMJ70BK4yuuVwNHnHH+niKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492061; c=relaxed/simple;
	bh=Lg5u4c0tRIh9NSOUkB/ULuSZ635Lp4C1Z4dfnzEz0qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVLppq0TV7gZSgJj7JTFf1euN0g9ZQGeVNKfg1L64c9RWliZCQwzzxEVNC04yRdPPvtiD5fBpHoAyrPUdThDv8ECwhGPJZXf/KExOUk7i8tzaKAsKLIhZy011/0JxRXZY2FbEsIhfLA1f4TgNEm1b7xqeKOmM1ZkjxreVTl36j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ri+XiH/t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717492060; x=1749028060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lg5u4c0tRIh9NSOUkB/ULuSZ635Lp4C1Z4dfnzEz0qU=;
  b=Ri+XiH/t6AgJ8zv52uxdu6QDAtCpX6BHvRw8T14l2fc/uKVkdBpDDBVq
   Q75a9XD2uA1VpW49Yh7kxQAf6SEYhYirFbC5FzLqC+1ZD4E7/6yanvUSH
   WjJo0hj+bJ6mRt1r1Xk7QAieErs8NUpvlIaoChqvQrFH7hdhB1KSGCD7H
   /sijwNY9wK1P6G+XZZX2v3s3+nbJVP3jJtcWcddtOk0j8FY+f0xTQMQC8
   7ULCT8M7lTX4dQe3dse4shTsyGza2KTIIUDxfCSjdEMgGCBtSliaBZKdx
   SJRf/u+Rs9AGEnzuY823+YDpKH20OkY3wA+TvLHlDsAjBHVp+2iqH7aQk
   Q==;
X-CSE-ConnectionGUID: 7vFx354YSlW5CvJlZqnbYQ==
X-CSE-MsgGUID: EIGRMJE8T4iNJChnCGDepA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24688785"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="24688785"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:07:39 -0700
X-CSE-ConnectionGUID: lT5fEjbnR7KP1GhED5RQJw==
X-CSE-MsgGUID: KgsRUWxiS4qm9p5fpOozMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="68342875"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:07:37 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>,
	stable@kernel.org
Subject: [char-misc-next v2] mei: me: release irq in mei_me_pci_resume error path
Date: Tue,  4 Jun 2024 12:07:28 +0300
Message-ID: <20240604090728.1027307-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mei_me_pci_resume doesn't release irq on the error path,
in case mei_start() fails.

Cc: <stable@kernel.org>
Fixes: 33ec08263147 ("mei: revamp mei reset state machine")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: add Fixes reference and target to stable

 drivers/misc/mei/pci-me.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 7f59dd38c32f52dccf632fb4..6589635f8ba32b35fd28876d 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -385,8 +385,10 @@ static int mei_me_pci_resume(struct device *device)
 	}
 
 	err = mei_restart(dev);
-	if (err)
+	if (err) {
+		free_irq(pdev->irq, dev);
 		return err;
+	}
 
 	/* Start timer if stopped in suspend */
 	schedule_delayed_work(&dev->timer_work, HZ);
-- 
2.45.0


