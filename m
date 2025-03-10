Return-Path: <linux-kernel+bounces-554183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F4A5941D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC3B3A8348
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23D22423F;
	Mon, 10 Mar 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNOzLOAN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602A846C;
	Mon, 10 Mar 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609333; cv=none; b=rWkHOrI+GlzITWOwa02bOeGyaWCJjlLGa1SV/6WKxl83okEF6TIt69LgjfZWc3bftC3Atu0VU0fH7cttFmiE6dkoDyZfDazX94Q7dkf3ROSdd5RKjXp1ppZXFrEmbpsku11VMAuTw/WJjhBybBL4jGM74pFkpzuYfp6rS80L9Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609333; c=relaxed/simple;
	bh=kucwRgK0Q6QDXi6eMR5O/ZtqTcMKZMkw+9Ax5UdHVVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D72wZD6PRbmVVP5JF7BPJ7I044ei4rDwfCHrEua86Z4dEhG8tj1CKsfQwtfQyl84muheVdMljU3K0cUFYbVCjRkFF0CkkbYLKVMBMJjSYqBo5gwQ2LnGNHCFKyXx+QODIql5iAleongMV1Zp+i67jclXGXox9CfPf00fOYjTX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNOzLOAN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741609332; x=1773145332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kucwRgK0Q6QDXi6eMR5O/ZtqTcMKZMkw+9Ax5UdHVVg=;
  b=mNOzLOANC5mjZLjI1+SbQHYPOElXJuNFi2W+VYz/a/3UA1pLJYX/Z1xM
   EDGKG14c9MW71SInMMytsF1ydxaQOxsDOhRtKqovs93FU0ZKGNRLKGEwj
   1M06xyZEsZCe5hVmcdFJwm8RP9DzDWqA64hkpl1Fel8pYVPDQU4Z0yI7a
   E4tiximN9uSAgJdrrkrghctggLfOU40ZPKE46og8ex1YL4ua2xR6l23mu
   ZnpqDYUHJtWHMVfvvVrbK4Gg4VJjuVM0CiaIPUbjEewcBuBuzVFbvGHOx
   LJm45CNPR3b8Ou1AYwcIV75teZcw7yExb0dW0pC+Q4PvmWqEneHN1VbEH
   w==;
X-CSE-ConnectionGUID: aNL6KkBYTVmVkFYcKNlnTw==
X-CSE-MsgGUID: pUveWg8BSgG/0BQ7yzauGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42737000"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42737000"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:22:10 -0700
X-CSE-ConnectionGUID: XD4ayhunSSm8YCF9yfjRMQ==
X-CSE-MsgGUID: 7C1oBs/jQEeoen4G/0yEyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="157182871"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:22:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ingo Molnar <mingo@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 1/1] cleanup: Fix sparse complaining about passing iomem ptr to no_free_ptr()
Date: Mon, 10 Mar 2025 14:21:58 +0200
Message-Id: <20250310122158.20966-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Calling no_free_ptr() for an __iomem pointer results in sparse
complaining about the types:
  warning: incorrect type in argument 1 (different address spaces)
     expected void const volatile *val
     got void [noderef] __iomem *__val
(The example from drivers/platform/x86/intel/pmc/core_ssram.c:283).

The problem is caused by the signature of __must_check_fn() added in
the commit 85be6d842447 ("cleanup: Make no_free_ptr() __must_check") to
enforce return value is always used.

Use __force to allow both iomem and non-iomem pointers to be given for
no_free_ptr().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403050547.qnZtuNlN-lkp@intel.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I've no strong preferences through which tree this patch is routed.

v2:
- Rebased & updated line number to match the current code.

 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f7af2b..ee2614adb785 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -212,7 +212,7 @@ const volatile void * __must_check_fn(const volatile void *val)
 { return val; }
 
 #define no_free_ptr(p) \
-	((typeof(p)) __must_check_fn(__get_and_null(p, NULL)))
+	((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(p, NULL)))
 
 #define return_ptr(p)	return no_free_ptr(p)
 

base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.39.5


