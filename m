Return-Path: <linux-kernel+bounces-216721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFE90A503
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5EE289F44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A59196C7C;
	Mon, 17 Jun 2024 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLBjSFkI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198E18413A;
	Mon, 17 Jun 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604457; cv=none; b=AYCBuUvFDFkeQVkzS22g9Rpi3FbHB0ykkjJNRMoxDySSV5tbhpbwoK0XfSTVQ1gk4NKe1Ag74bsQAtbrV6JG6s7yDlBIKD+/+gKMHHW5Awp8gbpyatInM8Z5FA027EkC691WWOdz846KPd4g5PFSAmGQqDyvhpsaAVgsGcA5tIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604457; c=relaxed/simple;
	bh=QmNts0XwHafR5EXddCWfiOq2RMFaHuzOgju0J5QxFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPLz1DfhEB+lF/9NOafw6nIns68GppNxh/w6SlO18f25K+ysKCNA45fBJQJlA4ThkmKoRUgcqKjpVrKDM0KH/QpyN5EGyfSRmPmQM/AxfVDfbqsPfuEu1OAVwetNxpWiLDtIz91/vfygNGJ1ui+ENQd0kX2behuy50/AKQ7E9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLBjSFkI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604457; x=1750140457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QmNts0XwHafR5EXddCWfiOq2RMFaHuzOgju0J5QxFvs=;
  b=GLBjSFkIXKKDhtn2Pj0NceZqsrXXrS/4Om3XA3Z99QL7CTZCyIP1nceE
   zyi8cHGVQDSDQL28pQq/QpR5nnWxFR9vQH7p+bQbaKIRcASla9q+TOT9U
   9x/Kb/gkc281UtM527txkOnqcYqtkazOIWabMTXK15d6IpHXgaYtedtLY
   SwomFTocydkWy2hQshdOfWEKNQLqmiutmaFTXJPJM3SebXCCV55QhHWPU
   VBkThZXkAF7I8YtW/v6Y+ZCpVALM8WWpYVVrkFxFmmHnrZarkFo3qsqvE
   MxYLuCouziP6JEmnJMyLiLuw4THWEUIv77ayMcKXl0GBZ3SAOcVtIE1+g
   w==;
X-CSE-ConnectionGUID: c34k0LelT1qNpLXk3GgREQ==
X-CSE-MsgGUID: pKe9F8YRR/e5eq5Psqkviw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138488"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138488"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:32 -0700
X-CSE-ConnectionGUID: 5N9ae2fOS5qnY7CHGPf1iw==
X-CSE-MsgGUID: VE5KclkzQeSCHXHXuQE7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028228"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:30 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 7/7] platform/x86/intel-uncore-freq: Use generic helpers for current frequency
Date: Mon, 17 Jun 2024 09:04:40 +0300
Message-ID: <20240617060708.892981-8-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617060708.892981-1-tero.kristo@linux.intel.com>
References: <20240617060708.892981-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic sysfs helpers for reading the current frequency also,
and remove the custom ones.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.c                 | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 9356a0f322e6..4e880585cbe4 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -76,20 +76,6 @@ static ssize_t store_attr(struct uncore_data *data, const char *buf, ssize_t cou
 	return count;
 }
 
-static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
-{
-	unsigned int freq;
-	int ret;
-
-	mutex_lock(&uncore_lock);
-	ret = uncore_read(data, &freq, UNCORE_INDEX_CURRENT_FREQ);
-	mutex_unlock(&uncore_lock);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "%u\n", freq);
-}
-
 #define store_uncore_attr(name, index)					\
 	static ssize_t store_##name(struct kobject *kobj,		\
 				     struct kobj_attribute *attr,	\
@@ -109,22 +95,13 @@ static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
 		return show_attr(data, buf, index);			\
 	}
 
-#define show_uncore_perf_status(name)					\
-	static ssize_t show_##name(struct kobject *kobj,		\
-				   struct kobj_attribute *attr, char *buf)\
-	{                                                               \
-		struct uncore_data *data = container_of(attr, struct uncore_data, name##_kobj_attr);\
-									\
-		return show_perf_status_freq_khz(data, buf); \
-	}
-
 store_uncore_attr(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
 store_uncore_attr(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 show_uncore_attr(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
 show_uncore_attr(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
-show_uncore_perf_status(current_freq_khz);
+show_uncore_attr(current_freq_khz, UNCORE_INDEX_CURRENT_FREQ);
 
 #define show_uncore_data(member_name)					\
 	static ssize_t show_##member_name(struct kobject *kobj,	\
-- 
2.43.0


