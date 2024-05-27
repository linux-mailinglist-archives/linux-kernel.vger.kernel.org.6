Return-Path: <linux-kernel+bounces-190366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909CB8CFD59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31337B24882
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6713A86B;
	Mon, 27 May 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTd9Ovw7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AB2232A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803013; cv=none; b=EvRaCsXX0SgcMWtllasqHU/6sEnWiDA92PaLp5Xzepme2CxVfsv69QrVqa4KPKaA2XwZYdEhKNfl5H8Fh0kz5zi3p5nu8dxtMlF+y/UDarbP4ykN5nO8sNTX4CI3qR8WaNuH2HuziNzeYFKcAxPaBIZXyhJrYgjrGtpaN6DwXUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803013; c=relaxed/simple;
	bh=V7W+PZvSNN60O9e3tJb1hk9bjQ3NW3P32Xw/JTV/pUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iEsr01Eey+N6+x3RTD8EZkiWQP1zuZH2dbx8vtYNRRKykJ6DFnzAwicSqFC8Ww0ZJxnlTQB7bTxnubXZVwRW/MITv8NAQWnxI3eUtxdd5Qn/enEdSDBY9QSvsTRGKpHoOdFlrgnqRpp7Jf7tkPN2mMaWJ1HqVSWCQhbzmBWaJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTd9Ovw7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716803012; x=1748339012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V7W+PZvSNN60O9e3tJb1hk9bjQ3NW3P32Xw/JTV/pUQ=;
  b=NTd9Ovw7NLmfLq1ecFQNsFE/0AtFsx2+RCxV8ry2nU+D2e9fNiZl0ilX
   kzxnI673QTMZ9sChTpU0oElTDYiqaHCa1H1RCitDonYo2tIQWFhVZ1hUN
   UjVQ5ZXSB52tmcr1dFfknp+qTgoHfNv+SalOM4ehIy6Ctz8M2/oagYmou
   DHnGXKInJgiu5YktXSZWmB/cdCKJL81JxAP0T8bU/DWvZprZyvgi+mb4M
   4JT0WYDUD6ozZjWYYZ7m/80Ifww9DzFht2U3PizrBje6kpO2o693PN7iG
   GYpGrktKDEoujiWknNTMi526Ow81+PrIywLex+Ibq4AJmUI7TT7eAN3r0
   g==;
X-CSE-ConnectionGUID: WPpQ4NuNTbyE39ZLOYYKXA==
X-CSE-MsgGUID: sWMdJJCbQvmrATGTAlv8Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="30621983"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="30621983"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:43:31 -0700
X-CSE-ConnectionGUID: AwnyfvCXQgWn9JMdt8o7SA==
X-CSE-MsgGUID: YJPCK6WAQ8a7+D1XJxu9CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35187606"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.200])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 02:43:28 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	jani.nikula@intel.com,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 1/2] string: add mem_is_zero() helper to check if memory area is all zeros
Date: Mon, 27 May 2024 12:43:19 +0300
Message-Id: <20240527094320.2653177-1-jani.nikula@intel.com>
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
index 60168aa2af07..3da305dab927 100644
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


