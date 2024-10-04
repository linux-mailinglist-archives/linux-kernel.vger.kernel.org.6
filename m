Return-Path: <linux-kernel+bounces-350115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526E990014
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8BCB240EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86487154C08;
	Fri,  4 Oct 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIoiYscv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BF154BFC
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034899; cv=none; b=MKiwb/VgEYnvjqyD/7jgVh3iCDKMfUSqMP8yhfOC7sl0LkJR3zI0Tb83tFywXiGc7v+jLoa9+pFyC78BUf4bP6yxfGWtNQerVJR5dJlPVYa9bOE8C4KLH22DEoJJ0V0hN9SJVqb0J3jN2bhlS30VN/VD5Rox0myXlq+kk0WCrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034899; c=relaxed/simple;
	bh=b22U/HN7aCvWYPW/mcQsrxQh9V8+sebrDfBa40oOSY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbyUh675pjjBgx6xE9ZjxtitQLHNA5N7/+9MscfOKCYpDgied1fHoiBA+6QwPp265aVEF5xYTgMGi2G2vVq+V31nAvC9K+BxsaTNX83vfCOSqoCeCJBUB6CIh3IV1ry4iV4eJFxm/AW+LmKELWLQ9pAJ89Arr9mYqYwRiPcEzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIoiYscv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034897; x=1759570897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b22U/HN7aCvWYPW/mcQsrxQh9V8+sebrDfBa40oOSY8=;
  b=DIoiYscvcqKZkm5BAku3v9WrgAjDfuNEY2jcMLycfc+i1YRsPUpx0Lwx
   GxegpA3CFYqkyEEB2cDmb6ylAPhoK2Eu1Ph0kduHJ5jxxUR++nPmLopQv
   aXnzt13ruz61TRQ68ZZadNSnL7ss+KjKT5k/CNHbqaJTnxQ2/LRylig+e
   B7N4l4vcc7nYECf3VQEOdoDBiBTdIiRrOxjtlebWcaPF1GTtNDUHV1Ilz
   j0VjvvCUrphDLMVPeSYhvmEQZhKmi9Xjt1ip/4Axo/Ai3iiS4xrKzpjK1
   89uAg0coht7QrWCZXJb/ObeI7pgK7bzoYAgJW2OR8SAGIM6436FKOH+Xo
   g==;
X-CSE-ConnectionGUID: s8VL+OWbQmWLziGlfRLK1w==
X-CSE-MsgGUID: R7J26OZZSymRrT0SUeUn/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656243"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656243"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:37 -0700
X-CSE-ConnectionGUID: 4d3uv27UR9uNKQuPwBXshA==
X-CSE-MsgGUID: Xu9lpuIyTJmycfxNUlPGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975085"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:36 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9F8C311F7E7;
	Fri,  4 Oct 2024 12:41:33 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoX-000Tbb-23;
	Fri, 04 Oct 2024 12:41:33 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 26/51] mfd: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:33 +0300
Message-Id: <20241004094133.113793-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/mfd/arizona-irq.c  | 2 +-
 drivers/mfd/cs40l50-core.c | 2 +-
 drivers/mfd/cs42l43.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
index d919ae9691e2..dd15608c65be 100644
--- a/drivers/mfd/arizona-irq.c
+++ b/drivers/mfd/arizona-irq.c
@@ -153,7 +153,7 @@ static irqreturn_t arizona_irq_thread(int irq, void *data)
 	} while (poll);
 
 	pm_runtime_mark_last_busy(arizona->dev);
-	pm_runtime_put_autosuspend(arizona->dev);
+	__pm_runtime_put_autosuspend(arizona->dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/mfd/cs40l50-core.c b/drivers/mfd/cs40l50-core.c
index 26e7a769eb14..1b467d2a486b 100644
--- a/drivers/mfd/cs40l50-core.c
+++ b/drivers/mfd/cs40l50-core.c
@@ -532,7 +532,7 @@ int cs40l50_probe(struct cs40l50 *cs40l50)
 		return dev_err_probe(dev, ret, "Failed to request %s\n", CS40L50_FW);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index ae8fd37afb75..ac58ff2406b4 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -961,7 +961,7 @@ static void cs42l43_boot_work(struct work_struct *work)
 	}
 
 	pm_runtime_mark_last_busy(cs42l43->dev);
-	pm_runtime_put_autosuspend(cs42l43->dev);
+	__pm_runtime_put_autosuspend(cs42l43->dev);
 
 	return;
 
-- 
2.39.5


