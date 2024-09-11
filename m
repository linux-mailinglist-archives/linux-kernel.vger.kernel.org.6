Return-Path: <linux-kernel+bounces-325540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8E975B02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C5286C12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742571B81C3;
	Wed, 11 Sep 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt3+3B+0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA41BA896;
	Wed, 11 Sep 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083993; cv=none; b=Ea4DttH0gRrDxQJ91yKjtYkQ7Xxz7Y2fVVMkhSMrE0syWuomdPII0AwZ5LOtUwFjJTq91XFH+mqdcgErHvLHAcgi+10oN/bBP7SYJpg/ocP7j/A936XPOV6sKxUHnmRO0/f2YArp39J6aNAiG/olAB9Ms83O57Ye4vOzUpZ5Lvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083993; c=relaxed/simple;
	bh=xCm3C/dDioJY4tnCnDIAGdRJ+YFyfHYkEXmvf5ojfa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHbxmnutVv/zwvAuBLi7GOhTDGcWShVoLq9AmeTqqELNunfLBnftd03bk+Mk3tHX3NDmf78zDe/4VEOVmRKQgmjQVXMqv9vEyaNyI9nIPWGK8xLzvlk7dwF0jfSylNczL8ygOqjJM7DRDL+NYcq+vtEaWQOpg31AEQyzRuuFqwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt3+3B+0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726083992; x=1757619992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xCm3C/dDioJY4tnCnDIAGdRJ+YFyfHYkEXmvf5ojfa0=;
  b=Vt3+3B+0WLW8fuGc7+lyu2YJsxP1cOroll5sMff+ZSTm1oljwIKZ7x37
   kiwVN71RwrWvhyRDPS4R0m7U6uOukWzUABqWP9HedFb7QGGzLqPJOHETr
   iwLQ820YSxCNLqhGtgSFRAS1Tq8TXjoGxS8rPlsj2FFvgeh6d7HAbOdye
   9cAV8IushDzaKgW7Bk07189XxWOFOczhMu8k2+vKcnowiDa91Zk+ZQ3SP
   xU+MnH7fr93Zw3cmuPohWM7QETVjp40Ps8eGreoBdVh45+z+g/Rc9ZH2Z
   K8K4qyCStMBq+Oyb9/RY0zxYVG3ffb9l3TTDzbxVdbE9KUjpDYzuZloYW
   w==;
X-CSE-ConnectionGUID: ba6nAqETSDObt3Xhv6u0zw==
X-CSE-MsgGUID: oZiXK5mASKu71i9Q/rDRjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="50322298"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="50322298"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 12:46:32 -0700
X-CSE-ConnectionGUID: 5q4OtbreQeSiLZNTq+b2IQ==
X-CSE-MsgGUID: +udLxop0QuGNYswPbf4Niw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="72243727"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 11 Sep 2024 12:46:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B490C170; Wed, 11 Sep 2024 22:46:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] hwmon: (sht21) Use %*ph to print small buffer
Date: Wed, 11 Sep 2024 22:46:27 +0300
Message-ID: <20240911194627.2885506-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/sht21.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index ad1b827ea782..97327313529b 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -199,10 +199,7 @@ static ssize_t eic_read(struct sht21 *sht21)
 	eic[6] = rx[0];
 	eic[7] = rx[1];
 
-	ret = snprintf(sht21->eic, sizeof(sht21->eic),
-		       "%02x%02x%02x%02x%02x%02x%02x%02x\n",
-		       eic[0], eic[1], eic[2], eic[3],
-		       eic[4], eic[5], eic[6], eic[7]);
+	ret = snprintf(sht21->eic, sizeof(sht21->eic), "%8phN\n", eic);
 out:
 	if (ret < 0)
 		sht21->eic[0] = 0;
-- 
2.43.0.rc1.1336.g36b5255a03ac


