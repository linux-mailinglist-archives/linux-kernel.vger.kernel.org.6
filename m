Return-Path: <linux-kernel+bounces-350111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298298FFF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C995E2813C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317091494AD;
	Fri,  4 Oct 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNJ4U4UV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EED1487E9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034880; cv=none; b=VJj1g+jZmhyzWNByPEd3bzEwrqESR/5zucIRs4aUIHDr8UAb9cPKHYpj3dugGygcOTaUcVyknYjN1alEBJIGI5frpydSdHiatQSatmzq86O7ziob9Lbb6sh9Z71aFKDNjAoCmDKxCzc+lmIkwQLTnBV2itTaS9QqARpi5q2A0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034880; c=relaxed/simple;
	bh=czlynBkkE6U5jwCqe3Ca2o1Zzq5oAmrODP34bJ3eMq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/JCeCnfCL7h60QoR7ZJW7p3CH0K3AdAqpIhKsammdt75HehPgmKQRt0CalytI4N6GQDj5BWVNRrGzPYFi8ZrF2taOidl+ogd3RKDWDH0+ug3vOn/Zi9EKiqOYaUBuK+5eo4DnnjqlP4kM/mTXIxn80DdgCPpXlvZ7fsqBYiA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNJ4U4UV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034879; x=1759570879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=czlynBkkE6U5jwCqe3Ca2o1Zzq5oAmrODP34bJ3eMq4=;
  b=LNJ4U4UVVsRmRraTDOgTahusjmYRvEnWT07byvVC9wxMBa8OfG+KghnF
   1mMgaKZZfOXpOOyYq8vxnwk4j5kvNyS2GcsC1aKvh8g+lveNERzP9ye0m
   FEVNKpltj1u/n1fTiwlmc5olXp9lbWvB0Na3ErBcHeHTyYvm1CE3SUx4c
   OmQcZUjTeRC02hfLxQi2dFZZ96P/5aVNsAOAgd1LO9VtL8QjGkg6mM+fd
   V7c5mkrqQR5iDcfmPOaBDA3Jn0cq0283+EBACO7Hej0BDrq+/yfzfBmcg
   dwxxVbHwtDDV95u/GghelCYQ79wq7/w6t6b7sYyjzSx8vNTlzM1KVwZ8q
   A==;
X-CSE-ConnectionGUID: NeqcdZMnSl+B/oafWZXdZQ==
X-CSE-MsgGUID: gieIqOnOQ3OZuOEjgSufuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37856177"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37856177"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:15 -0700
X-CSE-ConnectionGUID: eqasqgjbSo+uKqAzThNdXg==
X-CSE-MsgGUID: 5FoznjgvQhi+kKP7MA2rOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74331919"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:14 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id BB28711FA2C;
	Fri,  4 Oct 2024 12:41:11 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoB-000TVI-2Q;
	Fri, 04 Oct 2024 12:41:11 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Tony Lindgren <tony@atomide.com>,
	Qiang Yu <quic_qianyu@quicinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/51] bus: sunxi-rsb: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:11 +0300
Message-Id: <20241004094111.113402-1-sakari.ailus@linux.intel.com>
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
 drivers/bus/sunxi-rsb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index a89d78925637..f33d18f1cf48 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -374,7 +374,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 	mutex_unlock(&rsb->lock);
 
 	pm_runtime_mark_last_busy(rsb->dev);
-	pm_runtime_put_autosuspend(rsb->dev);
+	__pm_runtime_put_autosuspend(rsb->dev);
 
 	return ret;
 }
@@ -418,7 +418,7 @@ static int sunxi_rsb_write(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 	mutex_unlock(&rsb->lock);
 
 	pm_runtime_mark_last_busy(rsb->dev);
-	pm_runtime_put_autosuspend(rsb->dev);
+	__pm_runtime_put_autosuspend(rsb->dev);
 
 	return ret;
 }
-- 
2.39.5


