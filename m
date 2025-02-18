Return-Path: <linux-kernel+bounces-518835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0DA3952B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3616A1896FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE4F22FF41;
	Tue, 18 Feb 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxwnY7hL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1A22B8AA;
	Tue, 18 Feb 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866632; cv=none; b=L6Y8RC2MCt8khTuwfptYH6Eih8ql3O/Q2fu5DuojkqVqJTHMHxlq4TDu15mkJZIPOPy1BzusM2MDdEuexnFz2Cy4LjJPD8ixlSB+9lopoRebH9sRQzNs74TEvoNGvv4E9FfvadLFc+arn9oe5rsegBQFCJwU0njfPVNVvV4xzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866632; c=relaxed/simple;
	bh=bXO9RjmvEI/gGPfc1eFRDuxO1uk/Wq+sbi65zILen0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7FbDnaFPxDpPg+g9dAHrcH9C3T0C/J6xwhSOI+dAaNHEI6fv5ffluZKMGOid/XA2GKFBl70dkdQOEw5MeyEMNHJLnGsgdfaD8bML7IAs1tDju7MVlt0t/Ms/Ob9Nst0+na4F/8kdxGIXv6NJ92/K6C6L/7V9Z/h96NEl/vSPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxwnY7hL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866631; x=1771402631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXO9RjmvEI/gGPfc1eFRDuxO1uk/Wq+sbi65zILen0w=;
  b=jxwnY7hLXuHxZPdupZWqAMiRDDrtq7PdETdOABTGS1zO3GywvTfeIVos
   F4wZpo4+hFxfmROOJsSP9E6Py0VivkO5VPyuclWbcYb/2vJvnpeTR00gZ
   NL4yq1qsYQcQMtyo7PPjSkMnbVg+yjXA4YqEflI4p0AwY/J8PIMKr79dy
   sqk5hPfsAMJxj6cmPz9NUN8co09z35vxyBGTpwaVz6eoI3pX0coW3h7mK
   ghpriLdgB58O2J6N90/33Rb9IgIyGbD2kak+gHfmd9+0kYTpGPLnaZFci
   Iz8VI55bM7SnVrxN+hlXWqNS3vy8K9ic4NMmKxKoIDMTXNH0bzf137ycF
   w==;
X-CSE-ConnectionGUID: 1cLuA88WSjSG2nwpCnVEag==
X-CSE-MsgGUID: g59I/MRCSsm+9+jGW3NBXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28150092"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="28150092"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:17:09 -0800
X-CSE-ConnectionGUID: +HOO78zjQVWglPzSMQGDaA==
X-CSE-MsgGUID: iC+fl3UpTo2a4V5pAf6vOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119247460"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:16:49 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: kees@kernel.org,
	julian.stecklina@cyberus-technology.de,
	kevinloughlin@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	justinstitt@google.com,
	catalin.marinas@arm.com,
	wangkefeng.wang@huawei.com,
	bhe@redhat.com,
	ryabinin.a.a@gmail.com,
	kirill.shutemov@linux.intel.com,
	will@kernel.org,
	ardb@kernel.org,
	jason.andryuk@amd.com,
	dave.hansen@linux.intel.com,
	pasha.tatashin@soleen.com,
	ndesaulniers@google.com,
	guoweikang.kernel@gmail.com,
	dwmw@amazon.co.uk,
	mark.rutland@arm.com,
	broonie@kernel.org,
	apopple@nvidia.com,
	bp@alien8.de,
	rppt@kernel.org,
	kaleshsingh@google.com,
	richard.weiyang@gmail.com,
	luto@kernel.org,
	glider@google.com,
	pankaj.gupta@amd.com,
	andreyknvl@gmail.com,
	pawan.kumar.gupta@linux.intel.com,
	kuan-ying.lee@canonical.com,
	tony.luck@intel.com,
	tj@kernel.org,
	jgross@suse.com,
	dvyukov@google.com,
	baohua@kernel.org,
	samuel.holland@sifive.com,
	dennis@kernel.org,
	akpm@linux-foundation.org,
	thomas.weissschuh@linutronix.de,
	surenb@google.com,
	kbingham@kernel.org,
	ankita@nvidia.com,
	nathan@kernel.org,
	maciej.wieczor-retman@intel.com,
	ziy@nvidia.com,
	xin@zytor.com,
	rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	cl@linux.com,
	jhubbard@nvidia.com,
	hpa@zytor.com,
	scott@os.amperecomputing.com,
	david@redhat.com,
	jan.kiszka@siemens.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net,
	maz@kernel.org,
	mingo@redhat.com,
	arnd@arndb.de,
	ytcoode@gmail.com,
	xur@google.com,
	morbo@google.com,
	thiago.bauermann@linaro.org
Cc: linux-doc@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v2 03/14] kasan: sw_tags: Support outline stack tag generation
Date: Tue, 18 Feb 2025 09:15:19 +0100
Message-ID: <20f64170c0b59cb5185cfe02c4bc833073a2ebe6.1739866028.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel.holland@sifive.com>

This allows stack tagging to be disabled at runtime by tagging all
stack objects with the match-all tag. This is necessary on RISC-V,
where a kernel with KASAN_SW_TAGS enabled is expected to boot on
hardware without pointer masking support.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 mm/kasan/kasan.h   | 2 ++
 mm/kasan/sw_tags.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e64..2fb26f74dff9 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -636,6 +636,8 @@ void *__asan_memset(void *addr, int c, ssize_t len);
 void *__asan_memmove(void *dest, const void *src, ssize_t len);
 void *__asan_memcpy(void *dest, const void *src, ssize_t len);
 
+u8 __hwasan_generate_tag(void);
+
 void __hwasan_load1_noabort(void *);
 void __hwasan_store1_noabort(void *);
 void __hwasan_load2_noabort(void *);
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a37..94465a8a3640 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -71,6 +71,15 @@ u8 kasan_random_tag(void)
 	return (u8)(state % (KASAN_TAG_MAX + 1));
 }
 
+u8 __hwasan_generate_tag(void)
+{
+	if (!kasan_enabled())
+		return KASAN_TAG_KERNEL;
+
+	return kasan_random_tag();
+}
+EXPORT_SYMBOL(__hwasan_generate_tag);
+
 bool kasan_check_range(const void *addr, size_t size, bool write,
 			unsigned long ret_ip)
 {
-- 
2.47.1


