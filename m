Return-Path: <linux-kernel+bounces-297304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E532995B5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEDEB216CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E21C9ECD;
	Thu, 22 Aug 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZRkXCzi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0401C93C1;
	Thu, 22 Aug 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332049; cv=none; b=oVxhN5QLsIGUlmgALgUd7qH1S4Qyms+FRheJN9T+97d68AQ3cFJ3sh92SRnDBAmx9DTLur7feDStWQmZ4zLI2DnCT0Uy2idm2udHtaVGRfsFXkbHovGX36SNQzW+w0Atms31bMP4lYwzmzurvDaSxextSZ0rOlLPO3UCyS6tTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332049; c=relaxed/simple;
	bh=L2qNLRudhc0YZ2KaL1xe3yaBazItbuDfZ5NCkDGYGPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6tEfDjwNFPTORlJMcry88ZZsyPAYsq++su1bofktJlxWYD2+msHIrXvJ+XMlrzZexxVb39+ZxkAhwpWp1u/yVXTw6HSkwirHT8L6B6HIit13NoVQTnHM4UX7FkVXsYf4bGOo6Dx2MVQUyYJb0hh/avAxjokaju8PU8u3mfscIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZRkXCzi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332048; x=1755868048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2qNLRudhc0YZ2KaL1xe3yaBazItbuDfZ5NCkDGYGPk=;
  b=kZRkXCzi4chne2R8aTAUr9/mg2EM2981JQhO/F0jlXd76wYmxsoODZVg
   F9i7helZzOIAozySY90AE0SVXVDVrmJvrpiVDcSPMYs/a1tiXphty+d7l
   RZk8FVSiSD2p5P34t5G4E4COVt57sL0VkMYgAdXbfdbP3QFrtrGPZ9hWE
   diLaQURUXXupsccZP9hf/Diuco1B0Yf7AMm6Itv5iz7z7g0vuFha//xhV
   T/FJ34Cb/T7VkuZ7Wjfdr/E+KY++DNfL9uqiP4SChiPGwtpuZTRn34fde
   dav0uE2zHQlkenOzHBAHTAeoAl1FXDuN8JOpZYzqLe0L/pQPTXIMV2Ag7
   w==;
X-CSE-ConnectionGUID: wsEMzbJwTnCuAtlOuhaLDw==
X-CSE-MsgGUID: CckQ9mn3Qnm2xGcF7pWFSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22621709"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22621709"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:07:27 -0700
X-CSE-ConnectionGUID: BBM/bMR6SnSHit7w0zYy5g==
X-CSE-MsgGUID: Jqcd0QO1R6elZ3KAOEo5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66363059"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2024 06:07:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8DEEE43E; Thu, 22 Aug 2024 16:07:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v2 2/4] platform/x86: int3472: Simplify dev_err_probe() usage
Date: Thu, 22 Aug 2024 16:05:39 +0300
Message-ID: <20240822130722.1261891-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since dev_err_probe() ignores success, i.e. 0. we may call
it unconditionally.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 34db7d0381fd..29df19379464 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -299,10 +299,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	int3472->ngpios++;
 	ACPI_FREE(obj);
 
-	if (ret < 0)
-		return dev_err_probe(int3472->dev, ret, err_msg);
-
-	return ret;
+	return dev_err_probe(int3472->dev, ret, err_msg);
 }
 
 static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
-- 
2.43.0.rc1.1336.g36b5255a03ac


