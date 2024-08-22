Return-Path: <linux-kernel+bounces-297305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA295B5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E099B1C212A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADA1CB15A;
	Thu, 22 Aug 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef19BmNW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A11C9DE6;
	Thu, 22 Aug 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332050; cv=none; b=cGcoALjrvicl0TG0lI0YzOyQA9B6YiDmqbzE6pk20q42wOTZrMMlLkuOQxZBaDkOoV1WWQCvq4Ijk166Uyflog//QYjAmfH3juwfK0r+FcGJ75dyY90p1odQxU/9D2YHHvWOtz7gssdUZByhAtTzhMP302zbuS4tBo0YE19EEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332050; c=relaxed/simple;
	bh=/rlxddwbYicul4rBDo1BXld1UO+9xY/hxGIyhvivpHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ugt9BwXh31aYBGWLSFdKasj/AKCgtuD2MSqT4GnTuLUsF0zlglyw0ak7A3M1vglPtApYVnvl6+ZMoD7RN2nhCmHUyhSjZr9hnvIfUQhtGcRvOuH3hv+VlvNXl3+EOMw0tjtQ0ZYTUmmtt3f5QmlE1CdYhLI/aXOgW8af/sPN3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef19BmNW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332049; x=1755868049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rlxddwbYicul4rBDo1BXld1UO+9xY/hxGIyhvivpHc=;
  b=Ef19BmNWjOqXwKD9+Lyg/IT/tW5nlvBEeCjKfIK8MYvK8XtM4pCu8kr8
   nZcA+ECPF4nrwS9/m3NGHXkLXFD5qFvGPIPPJFFPp/RIC+0azKS8uT0Jc
   vK4TtPT4braVpbkiusBE0HNrZ1WU2yJ0Ooeovr4y5eiJK78pBAeTQwle9
   jiU7B2+UBM5EBTYpEg8nWSXGn27MBoaipeOiH2ykyis+0QvJzJHbNp/gG
   lNb/acjVvXNy7qBRjv8dbGmAoiZq/KPqpwrefKqiGL7F1AGZLKpd++eNa
   fYG6XVd3uAR9Y7UeNuHLXzx8w6qusgsw3IlzpZXniy14M2gfKNQ+YFKwB
   w==;
X-CSE-ConnectionGUID: BKz+GL+/TRm1ijO70zu2jQ==
X-CSE-MsgGUID: RfopBOBkSkaAwxBL0GkvhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26538871"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="26538871"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:07:28 -0700
X-CSE-ConnectionGUID: oK4VI3y9Sx+6mcSv+c49ug==
X-CSE-MsgGUID: AHJOpWE8RqeEb+0L8vqJFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61146771"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2024 06:07:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 83AF92AA; Thu, 22 Aug 2024 16:07:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Date: Thu, 22 Aug 2024 16:05:38 +0300
Message-ID: <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
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

In the similar way, ignore 0 error code (AKA "success") in
dev_err_probe(). This helps to simplify a code such as

  if (ret < 0)
    return dev_err_probe(int3472->dev, ret, err_msg);

  return ret;

to

  return dev_err_probe(int3472->dev, ret, err_msg);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4bc8b88d697e..830a14084bf6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4987,13 +4987,14 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * This helper implements common pattern present in probe functions for error
  * checking: print debug or error message depending if the error value is
  * -EPROBE_DEFER and propagate error upwards.
+ *
  * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  * checked later by reading devices_deferred debugfs attribute.
  * It replaces code sequence::
  *
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
- * 	else
+ * 	else if (err)
  * 		dev_dbg(dev, ...);
  * 	return err;
  *
@@ -5003,12 +5004,16 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * Using this helper in your probe function is totally fine even if @err is
  * known to never be -EPROBE_DEFER.
+ *
+ * NOTE: The message is not going to be printed or saved in cases when @err
+ * is equal to -ENOMEM or 0.
+ *
  * The benefit compared to a normal dev_err() is the standardized format
  * of the error code, it being emitted symbolically (i.e. you get "EAGAIN"
  * instead of "-35") and the fact that the error code is returned which allows
  * more compact error paths.
  *
- * Returns @err.
+ * Return: the value of @err.
  */
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 {
@@ -5032,6 +5037,10 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
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


