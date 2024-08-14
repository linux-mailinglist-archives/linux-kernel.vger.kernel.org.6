Return-Path: <linux-kernel+bounces-286223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C50951838
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08411F23AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3D1AD9E6;
	Wed, 14 Aug 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxiTa8MA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C41442E3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629654; cv=none; b=UR73ccCN6wu51BtVRsj5rXS73/ExjCSFOdqaxptTVZEzz8GE7Da7W+6ApR29Wi0xx5EjZOMZrNzRW4qUEzO6y7pEZB1edeF7q3QWtgzJ0RnzSFDsrT8FtlXZb1AwGh7RkJcbTTzJjiFHfwmXdChwbVRI0eHcaedRFhR6g3AZmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629654; c=relaxed/simple;
	bh=+3bm3qAXRhIk14a/ZVhcXtY4VT/IWncFvTwGUHAz/Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XXgJjxgdxT1QACZ26Mu9rGjkBLZNCC3cXVqybHyN5d0OmfHOASdXoAsPLiyVm3bHcCNZjvf0RPjzM17zIQl549t081HMnhwldEpKpP4pYDnsGcwnXnVxcBi8OhkpTH23+bD9DHEqDFuQNF90r8F/yIeLAGObwZDFM1J0Xsnh0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxiTa8MA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723629650; x=1755165650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+3bm3qAXRhIk14a/ZVhcXtY4VT/IWncFvTwGUHAz/Wk=;
  b=cxiTa8MAmuypfbKMcU4tuIaO0P0uILqcfggGHI4o8WrVJ1fKhYOLjmRv
   oPejx8Wq4hOGlm/ytuCuMd2o0ChWVJRdQYZ7vqnDY6motjZIWTbf+oi9j
   yVnuOar3kv9+bHmbJFMtRzas4MH73KnyVpsrrJJd1W9Qxm1VZWpPfXLRm
   W2foFWvuydei9W9MNLnlGguRS7iB8uOvLvyLdc5P4iUBYXoE3CerPCjq1
   9K49N8jbHsyFeG0D+IjS9tw/ezPdjeFUsTeGeL0HprExFaHUj1iyVgMCX
   aUBTCjfW/mgaGvYCGH/okyeN87yG5B29WcsHLOfVjygFtGkTtVbZoNzOk
   g==;
X-CSE-ConnectionGUID: kCOJnuNmSye4Oy5KNyF+Uw==
X-CSE-MsgGUID: d3iz3Bz3TKiVlEHt3BZfGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44355140"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="44355140"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:00:49 -0700
X-CSE-ConnectionGUID: GONln07nRUaVUHd6sNRnTw==
X-CSE-MsgGUID: +qU923aYRgKL1ChpRIvXBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="58922107"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.65])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:00:47 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	jani.nikula@intel.com,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 1/2] string: add mem_is_zero() helper to check if memory area is all zeros
Date: Wed, 14 Aug 2024 13:00:34 +0300
Message-Id: <20240814100035.3100852-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Almost two thirds of the memchr_inv() usages check if the memory area is
all zeros, with no interest in where in the buffer the first non-zero
byte is located. Checking for !memchr_inv(s, 0, n) is also not very
intuitive or discoverable. Add an explicit mem_is_zero() helper for this
use case.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>
---
 include/linux/string.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9edace076ddb..5855c5626b4b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -279,6 +279,18 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
+/**
+ * mem_is_zero - Check if an area of memory is all 0's.
+ * @s: The memory area
+ * @n: The size of the area
+ *
+ * Return: True if the area of memory is all 0's.
+ */
+static inline bool mem_is_zero(const void *s, size_t n)
+{
+	return !memchr_inv(s, 0, n);
+}
+
 extern void kfree_const(const void *x);
 
 extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
-- 
2.39.2


