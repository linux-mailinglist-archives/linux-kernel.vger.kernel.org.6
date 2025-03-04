Return-Path: <linux-kernel+bounces-544870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3EA4E636
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC771899B26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25B299B2F;
	Tue,  4 Mar 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1pfoTLO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B8280A2F;
	Tue,  4 Mar 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104423; cv=none; b=MMrnqbje8xx34WjJJQok7TdxwOGAqTk9MSCFdXmkon+ofnnaojzU2cBVCaoiXyje0w+jRCAf0SruiEvVTYR4AWfDQ0q2mbjJhssytyEwP6oYAAAUjtPA6KrLTNK61aiPJonLqgi+Ua+j5mw863MG1ZlDcAUVRTpsOvERO9JOBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104423; c=relaxed/simple;
	bh=PWSYk1eyFl+4AhEp5rPIWKXzxn1GiTQ5ddVtL6TfLq0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJ9rcc33l8jAR5Q6Dmn0Fd9gB1sdSwyK2N/A2d5KBk/xN1nOtNV0XfTmFcSqFbkOqqyoY6YQnatjgPLocLXZG79LB9q17w8lwa47OFr4TDyk9lsecVF333/UpOiuT42qAKyqgvsKEWTwe8o7qbbkaOqM6cHuc2z2edPZrdbR+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1pfoTLO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741104422; x=1772640422;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PWSYk1eyFl+4AhEp5rPIWKXzxn1GiTQ5ddVtL6TfLq0=;
  b=j1pfoTLOyiaOOHxoQtgnnkUESQF7kIdeUJbw6y1C7OGUheq8yZQJVdtV
   vMNckscoW0AS4VDOZfVSqyOCpUOlXOGCHqcieMG9O/bEeHb1p6o39NSbz
   8cMopRS4o7oHlPFp13zcjmxiDMWoOThNmcN84c9DuUESNqlTsqrTAwfQ2
   VY3BYNHEfgc2QM2d5LNUcYGFzhNcIjF6cjsENrcRYwRBfeFzBC3OiUQJc
   lWVrXvxMRRfjX+KJtdjuyhbY2lPmn/fc9G1Iu4gi64b2g6XX24tl316Un
   Tvr7pnBjXvwQZXG39Pe1aiTqw9Fvn967Tb+7lvSvVpjstIwv86KYlc3d1
   g==;
X-CSE-ConnectionGUID: 4v97JDJWSLyJmryuHwf42w==
X-CSE-MsgGUID: oxPRzCyyQNmWNLBn1vivWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42154182"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42154182"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:07:01 -0800
X-CSE-ConnectionGUID: oSkf78dxSCGOsbLipRKnAw==
X-CSE-MsgGUID: SmC9qriDTvy9DTMGwpcqFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123017573"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:06:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-uart-backlight: Make dell_uart_bl_serdev_driver static
Date: Tue,  4 Mar 2025 18:06:39 +0200
Message-Id: <20250304160639.4295-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
References: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sparse reports:

dell-uart-backlight.c:328:29: warning: symbol
'dell_uart_bl_serdev_driver' was not declared. Should it be static?

Fix it by making the symbol static.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index 50002ef13d5d..8f868f845350 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -325,7 +325,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	return PTR_ERR_OR_ZERO(dell_bl->bl);
 }
 
-struct serdev_device_driver dell_uart_bl_serdev_driver = {
+static struct serdev_device_driver dell_uart_bl_serdev_driver = {
 	.probe = dell_uart_bl_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
-- 
2.39.5


