Return-Path: <linux-kernel+bounces-350118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB30990020
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2911B2853EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A43F156C5F;
	Fri,  4 Oct 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/2Qf14F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90F14A098
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034913; cv=none; b=CU+NcEzg4qy0WXACjW0xe8yu3WkpCNn3LxPzr8pqY4x2Zkn0NpzA7p9394KWvs5MTQYtwLGLvS2GDWTPHIlpxgLCAPppiyZA2LM21uH9Ce2BqClhcy1KvfbpPuIpX1DJlr1lFq7SfVf/16vNvjiInnIzWQK0WSF0KgXJJLTne+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034913; c=relaxed/simple;
	bh=Q3ReI5NaVPZWkeEE0z51IgiY3gbtCg8tB+cwRjG8aZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSGC9YugQwznMzES+gev0R07421BFm8fcflCvgHpbcCPMEOGXCfeNx64uJ8FAf/nfP7owZs0X7XeKKj83oZOJgGj+pFEhCp1I5/SgY9U3tj9WjUliReszsMToefrBYw+f/jyt8mDLURkNTrbvMuBG7qn+FftUDOFDwnIvyMjnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/2Qf14F; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034912; x=1759570912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3ReI5NaVPZWkeEE0z51IgiY3gbtCg8tB+cwRjG8aZU=;
  b=L/2Qf14FtRkkFMR6vsuFYxkogHuC4IFtqUOKU8ZDPrUzDP042OlC+n4u
   IUih8b2NXX9/dFx16j12toeBqk0AhnietUTx26e8U1MVtzANBRAdq+H1J
   aaEAoVQGbSQawPpktQnDv+60QvU5v5EVQ/IMlgxli9FPYdK0T5kiIHOle
   KQuFKNdJYEVOTYOwa+aC8ZDbWs89NPtRk3E6RYUr64ekHCWXeQ3Bxm/dq
   /uNghITdmVkcOJMuRKH736EFgCvgOPAPch7gnlAaGR0m/bABBqTatT1fV
   Snx4LGDHjpWmLdIKUeok0FbDu0dwpmXEDgo5pWaAnbV9wdz8nQlIaew3z
   w==;
X-CSE-ConnectionGUID: PSz8kxTuTcCmdbozUMUAtQ==
X-CSE-MsgGUID: Ks8Fy9EHTWOy7/+rYywD7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27136207"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27136207"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:51 -0700
X-CSE-ConnectionGUID: hlv4MqAvR2mIaNDSeVHqcA==
X-CSE-MsgGUID: /mx/EbG1Tnq+4wvkhAlIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="105492092"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:51 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 5AC59120E62;
	Fri,  4 Oct 2024 12:41:45 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoj-000Th5-17;
	Fri, 04 Oct 2024 12:41:45 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 46/51] w1: omap-hdq: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:45 +0300
Message-Id: <20241004094145.114133-1-sakari.ailus@linux.intel.com>
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
 drivers/w1/masters/omap_hdq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index d1cb5190445a..b7e87a3ef62d 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -446,7 +446,7 @@ static u8 omap_w1_triplet(void *_hdq, u8 bdir)
 	mutex_unlock(&hdq_data->hdq_mutex);
 rtn:
 	pm_runtime_mark_last_busy(hdq_data->dev);
-	pm_runtime_put_autosuspend(hdq_data->dev);
+	__pm_runtime_put_autosuspend(hdq_data->dev);
 
 	return ret;
 }
@@ -467,7 +467,7 @@ static u8 omap_w1_reset_bus(void *_hdq)
 	omap_hdq_break(hdq_data);
 
 	pm_runtime_mark_last_busy(hdq_data->dev);
-	pm_runtime_put_autosuspend(hdq_data->dev);
+	__pm_runtime_put_autosuspend(hdq_data->dev);
 
 	return 0;
 }
@@ -491,7 +491,7 @@ static u8 omap_w1_read_byte(void *_hdq)
 		val = -1;
 
 	pm_runtime_mark_last_busy(hdq_data->dev);
-	pm_runtime_put_autosuspend(hdq_data->dev);
+	__pm_runtime_put_autosuspend(hdq_data->dev);
 
 	return val;
 }
@@ -526,7 +526,7 @@ static void omap_w1_write_byte(void *_hdq, u8 byte)
 
 out_err:
 	pm_runtime_mark_last_busy(hdq_data->dev);
-	pm_runtime_put_autosuspend(hdq_data->dev);
+	__pm_runtime_put_autosuspend(hdq_data->dev);
 }
 
 static struct w1_bus_master omap_w1_master = {
@@ -626,7 +626,7 @@ static int omap_hdq_probe(struct platform_device *pdev)
 	omap_hdq_break(hdq_data);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	omap_w1_master.data = hdq_data;
 
-- 
2.39.5


