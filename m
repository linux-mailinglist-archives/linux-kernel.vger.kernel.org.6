Return-Path: <linux-kernel+bounces-307336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0031964BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FA3B21446
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84DC1B5EA7;
	Thu, 29 Aug 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpqjyDpG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D318C331;
	Thu, 29 Aug 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950280; cv=none; b=qw98ZT7RkQvtsWBs1ZH2b+cvcn/lWMTbDZFGVqWUWRfKHuPPSg0ZSJCOQdeAaMli/94SlJ/6dO6w8kDklbLtI/0qHhjRAjxQAAEnXGPYvQJUiNP5eMZ1SelwUGgnh+n0VKT6eK7JCfvY2QQH1Iwt6YgujOiEuAm0YUOxInTTkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950280; c=relaxed/simple;
	bh=suEmnq7l7kBu+OuAtK7MqN9CEE/c1CjjuOo7qUnodFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOFnhKDxdcKDIzb56CXDTRy6okuMJ5v/edANvzfBzr1fAFU3KhE+oj74KVuevY31aFZXCNIjyrSLrApH+ZuWSFx7hznL0uEiDB+vQg3IctY5gPxM9yAfwUza9Sm2CCbMzzmaK+EdGMG9n7f9EaYLJRR3evp1YtU/p6uatNcdm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpqjyDpG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724950280; x=1756486280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=suEmnq7l7kBu+OuAtK7MqN9CEE/c1CjjuOo7qUnodFQ=;
  b=mpqjyDpGpuHpMP8dA2pdte9F0/UOKVTdyUwfLusnVh1ca0mcl0eFvp0G
   Mgci0JpygWKhqo6W/e/Fo9Z9dVwVqAFx19j/Z0aqI1i0dKm7+P6S9xy1t
   1B4/pKwbBvltcZATObRjde1of+JjK1Rt72D/ZMkgtw/JWFA/305Io48e9
   3cf+URLGQ28qzQpZFBrbF/4WAT3a7seuNvn0gfU7mNYDUNocA5iaxwm6W
   G38l6W12vf8FDaA5hzgB7u8/DxjJW6v7oNAl5ZIWLieLOtqwGGQ9fvDqV
   b80AzWCDvohntaEp7B8vvjGYG1ewbstFyHpc0/QBMKtWqnoNB3wTQotmR
   w==;
X-CSE-ConnectionGUID: ww8fuObLSfWiScxoHjR1pQ==
X-CSE-MsgGUID: u+V21QujQtC5D9DixzaZ9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27352517"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27352517"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:51:19 -0700
X-CSE-ConnectionGUID: FMuKukLMTuaMP2qSd8GspA==
X-CSE-MsgGUID: oKyJU16sRKyj1n4b4TQIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63958139"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Aug 2024 09:51:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A8D2E143; Thu, 29 Aug 2024 19:51:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Gergo Koteles <soyer@irl.hu>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ike Panhc <ike.pan@canonical.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] platform/x86: ideapad-laptop: Make the scope_guard() clear of its scope
Date: Thu, 29 Aug 2024 19:50:32 +0300
Message-ID: <20240829165105.1609180-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, it's a bit counterintuitive to have something like

	int err;
	...
	scoped_guard(...)
		err = foo(...);
	if (err)
		return err;

Second, with a particular kernel configuration and compiler version in
one of such cases the objtool is not happy:

  ideapad-laptop.o: warning: objtool: .text.fan_mode_show: unexpected end of section

I'm not an expert on all this, but the theory is that compiler and
linker in this case can't understand that 'result' variable will be
always initialized as long as no error has been returned. Assigning
'result' to a dummy value helps with this. Note, that fixing the
scoped_guard() scope (as per above) does not make issue gone.

That said, assign dummy value and make the scope_guard() clear of its scope.
For the sake of consistency do it in the entire file.

Fixes: 7cc06e729460 ("platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408290219.BrPO8twi-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

This has been Cc'ed to objtool and clang maintainers to have a look and
tell if this can be addressed in a better way.

 drivers/platform/x86/ideapad-laptop.c | 48 +++++++++++++++------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 35c75bcff195..c64dfc56651d 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -554,13 +554,14 @@ static ssize_t camera_power_show(struct device *dev,
 				 char *buf)
 {
 	struct ideapad_private *priv = dev_get_drvdata(dev);
-	unsigned long result;
+	unsigned long result = 0;
 	int err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &result);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return sysfs_emit(buf, "%d\n", !!result);
 }
@@ -577,10 +578,11 @@ static ssize_t camera_power_store(struct device *dev,
 	if (err)
 		return err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_CAMERA, state);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return count;
 }
@@ -628,13 +630,14 @@ static ssize_t fan_mode_show(struct device *dev,
 			     char *buf)
 {
 	struct ideapad_private *priv = dev_get_drvdata(dev);
-	unsigned long result;
+	unsigned long result = 0;
 	int err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = read_ec_data(priv->adev->handle, VPCCMD_R_FAN, &result);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return sysfs_emit(buf, "%lu\n", result);
 }
@@ -654,10 +657,11 @@ static ssize_t fan_mode_store(struct device *dev,
 	if (state > 4 || state == 3)
 		return -EINVAL;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_FAN, state);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	return count;
 }
@@ -737,13 +741,14 @@ static ssize_t touchpad_show(struct device *dev,
 			     char *buf)
 {
 	struct ideapad_private *priv = dev_get_drvdata(dev);
-	unsigned long result;
+	unsigned long result = 0;
 	int err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &result);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	priv->r_touchpad_val = result;
 
@@ -762,10 +767,11 @@ static ssize_t touchpad_store(struct device *dev,
 	if (err)
 		return err;
 
-	scoped_guard(mutex, &priv->vpc_mutex)
+	scoped_guard(mutex, &priv->vpc_mutex) {
 		err = write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, state);
-	if (err)
-		return err;
+		if (err)
+			return err;
+	}
 
 	priv->r_touchpad_val = state;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


