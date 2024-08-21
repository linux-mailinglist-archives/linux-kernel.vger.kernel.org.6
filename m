Return-Path: <linux-kernel+bounces-295487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF3959BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951412831DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1E192D6A;
	Wed, 21 Aug 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ01oDMR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CC166F26;
	Wed, 21 Aug 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242961; cv=none; b=C+xR5VWNWYdDachoznB633XHIioHSLNrDA+/9dEmUUEE2JAJL1ZkYW4YUm6E4DR5I2RkzjgAvJQGN+BWKPGTyyzxuSp8NslqNW58BYmUEqP96v7elK6SmRkBcF6fNubpDK/LqZqUuCSewg/o8YM9GwPY/yXJKtuaq8iKFcydE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242961; c=relaxed/simple;
	bh=srOvWJfBcpoG46ZqWIBdQAKX1Z+0rG2opwsVOdyMo3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5aX/wNM4M3/STHTk81jh1hCAhsape9FRDFE0ha5dYaR3QrwG/EO3ww3xhwvRJdD4jRrrktX2uMEh/Qc1jBv010gBBvQyIpQVjGF0WUckmmrJ4w/lL8Cx94SDgRJb+RCojcwOGAiyN1b5ENImCmJop0KkwVrOLwyu1hp6EfU53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ01oDMR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242961; x=1755778961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=srOvWJfBcpoG46ZqWIBdQAKX1Z+0rG2opwsVOdyMo3Y=;
  b=iJ01oDMRl93CpBoNDzNxe65I6zmH9WJUHNQ+1AwDE21p/N4AHjF48hRG
   JroD/0Nr6TecTguJRllz/PKuNS4MGHkMoen8qkQfjuLkNDFmvnZ1y3T3A
   TFohKkrwd931kK29RWwd3CY7hbc/wCmW8N1nf82KJu3EOicFQAaKniS4t
   ssDw8c47DOjM1Zwu/K7WFOq1kcVYMto8xoZkZInmXJtBKL/cnK67AyBl7
   O2izJOnTKmAj4gV7wmuHpGujp5Y2XpHNRXcCcBe0FJnaw9JPidFKnsexW
   sRVrtgqLRnDZTmm7KSlKf41VYDvEE7c5YFkSp8CxM4MhbQJu2vwtbj3GF
   w==;
X-CSE-ConnectionGUID: BufpH5vRTZeKzSvwN2L2JA==
X-CSE-MsgGUID: 2aYhTUDBRnO16hbT2wbZVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33166193"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33166193"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:22:39 -0700
X-CSE-ConnectionGUID: 3+d6/uLYR/2wq83njxTkoQ==
X-CSE-MsgGUID: zjuTrsiqSAWvi8+cNg3WEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66035953"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 05:22:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EF2B2268; Wed, 21 Aug 2024 15:22:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 1/4] driver core: Ignore 0 in dev_err_probe()
Date: Wed, 21 Aug 2024 15:20:40 +0300
Message-ID: <20240821122233.3761645-2-andriy.shevchenko@linux.intel.com>
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

In the similar way, ignore 0 error code (AKA "success") in
dev_err_probe(). This helps to simplify a code such as

  if (ret < 0)
    return dev_err_probe(int3472->dev, ret, err_msg);

  return ret;

to

  return dev_err_probe(int3472->dev, ret, err_msg);

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6d3897492285..144cb8c201fb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5046,6 +5046,10 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 		 */
 		break;
 
+	case 0:
+		/* Success, no need to issue an error message */
+		break;
+
 	default:
 		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
 		break;
-- 
2.43.0.rc1.1336.g36b5255a03ac


