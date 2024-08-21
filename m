Return-Path: <linux-kernel+bounces-295488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A831A959BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6138A1F217CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4F192D84;
	Wed, 21 Aug 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEsD6gHL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE717624C;
	Wed, 21 Aug 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242961; cv=none; b=k1VXNwW4JRGokfmZ9EMClfx9k5ebXNO0ghDmPVFv9JSCRayWZQb+c//+PAZpFT4HvVdHOqzMNa34uAIlQDIgQigwvPAxEc3R9rzfHXYnLro0EOrRpcrKRUzmksJTdgOwbS9uud+r6Vol8JhXqRto6wpTQ+6GSBdpvjelRNdpAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242961; c=relaxed/simple;
	bh=lWiTuHHwy9SIEGdoXAjbdCv7EnBQf/U2g2vjrdeRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMdZlGLZ/b5Sk2yk3/bnLeTgnOmhJ5KDtDAE9hk2x15i/LNR5w1aHZ4Qo1ERsBCfiAWxVnInJN5kK67q0stzP8eiWHgEYV9srm4GCZVwday6d1wumGr0uhuwsqGh819gT5us7KPceV9F7X0RzMBcMiH1C0RGqXkJB4DlBZwJrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEsD6gHL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242961; x=1755778961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lWiTuHHwy9SIEGdoXAjbdCv7EnBQf/U2g2vjrdeRBqk=;
  b=NEsD6gHLqR8q3JttmxPf3MPk39qLs7Gbnm/53Lp5mbYrGoQeUnQv/m/g
   fsZeoT9C3wIoYTGbMXTCIikQIe3jrQUQNOUCfgqddpEca0RkmfWYXulnR
   wBfLQC3awnGFiu/Ts7MmSWlSPNRpk/DWt9oNgziqHWaILO2nwuhRQrMxW
   oj6T00bCEbH6chmiALLACvAEL5JYCnKBSlgcXfXv8SR82McCiTERXeVe8
   u3WNt9IHikvPfm1wfxHI0pccxr7tzbdMVJyT+rFjHjAwHVLDjeQ8M+MCj
   QjEq9EzBm19QZXFBZiqZZfAhRR+a08dp4L9SvbHY3hNKifJfw3XWBAch1
   g==;
X-CSE-ConnectionGUID: yVss2iB3TQ+TPSWqRXFwsw==
X-CSE-MsgGUID: hahX/nSOQXGqVpT4DCxSMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33166200"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33166200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:22:39 -0700
X-CSE-ConnectionGUID: lttx9TOrQxqeL+LW57GxSA==
X-CSE-MsgGUID: 1qydYSMrS+mGpPJw7HIBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66035954"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 05:22:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0D7F6644; Wed, 21 Aug 2024 15:22:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 2/4] platform/x86: int3472: Simplify dev_err_probe() usage
Date: Wed, 21 Aug 2024 15:20:41 +0300
Message-ID: <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since dev_err_probe() ignores success, i.e. 0. we may call
it unconditionally.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 07b302e09340..cd0743300d7f 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -289,10 +289,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
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


