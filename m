Return-Path: <linux-kernel+bounces-435818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD4A9E7D94
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8697616B99B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3222C149;
	Sat,  7 Dec 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCZyEy+8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDE20E6
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733532208; cv=none; b=V6ZyDopuDaSWkLSKbaVkWlXit2CpLLHiqWjLKlJYL1s5Jmqbo3iSD1jxlZImnn3cd3BPuCD8qFA8ToA4uc5sq8O4Dj+CXcDmPPljz7+A6b8FcY+/Tv1ZT1Syg5//nJEA6UqYvRPzFDKNIDWGV9Zj6hCbBA4rjN24rUN2eImtp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733532208; c=relaxed/simple;
	bh=B8nIwxSSpIiA3mnl8xokN8PWFujmrjEE7sAlaIBR1wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wo+7pYlOlfNfiZOJJJ+re4CWxazg9kstqRggqylQ1OKgsUmZxE7QQJ0kM3SrFJD5i1XHV/LC/l9Uj8OATE/dyCheSo9qJXzVk4wc7lzomeNV7Co7BJAB6kooDEWpLbr5V7UZ2d1/K0Dh2o99z8ccWMamu0sqHibEHS4jTrXWfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCZyEy+8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733532206; x=1765068206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B8nIwxSSpIiA3mnl8xokN8PWFujmrjEE7sAlaIBR1wo=;
  b=lCZyEy+8yitQKCCNUE9zpYzcYw6Jr7AzdkXtLcNpUBXnLi3pTuzbA3Xs
   G0IXHzxvz14QhnFtpn0UKp+R2+L4fknYPEALozGHiojEJ6DuFyjxxUyZn
   C25AMqw7Ptzf9o1cQtDK66CxI+nOVReTS2H8g/qr5nH8Kjg0JIItBBC4J
   eUCmt5bhbN5PlQhakWd2lGjuX/sPwPDa362Obxuc3lS71B2LpGxaPnwix
   dnZPa439sPs4S7e+cn3p7zAXQU2jncoeQ+iXa/9Oy0ysg+AjRZ8gK8GBq
   xiX1G/V1UrCN2p1rHW76KyU0wa+VC6I2KvozuKU7VQ6CwmZOerp6a+WmP
   g==;
X-CSE-ConnectionGUID: cHtErUWDRG6uFXBcbyagtQ==
X-CSE-MsgGUID: 5lJuDakUS+eo5lEbgiG3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44573529"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="44573529"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 16:43:24 -0800
X-CSE-ConnectionGUID: XBzDGOjVRaWZ85qouDVmAA==
X-CSE-MsgGUID: 9x4Edv9yQeSOOM/Cg+GQFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="131954301"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa001.jf.intel.com with ESMTP; 06 Dec 2024 16:43:23 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Eric Biggers <ebiggers@google.com>,
	Xin Li <xin3.li@intel.com>,
	Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86/cpufeature: Add a debug print for unmet dependencies
Date: Sat,  7 Dec 2024 00:41:26 +0000
Message-ID: <20241207004126.2054658-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241207004126.2054658-1-sohil.mehta@intel.com>
References: <20241207004126.2054658-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of silently disabling features, add a print which might be
useful to users if their favorite feature gets unexpectedly disabled.

Features are typically represented through unsigned integers though some
of them have user friendly names if they are exposed via cpuinfo.  Show
the friendlier name if available otherwise display the X86_FEATURE_*
numerals to make it easier to identify the feature.

Use pr_debug() to avoid spamming the kernel log and generating false
alarms. Note that the print will occur once per disabled feature on
every CPU. Show this information only when someone is really looking for
it.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
Sent as a separate patch to make it easier to review and drop if it
feels unnecessary.

I can see both sides of the argument. The pr_debug() serves a
compromise between the two.

v3: New patch.

---
 arch/x86/kernel/cpu/cpuid-deps.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bea5c5e4fd2..c72f2dd77d72 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -147,12 +147,32 @@ void setup_clear_cpu_cap(unsigned int feature)
 	do_clear_cpu_cap(NULL, feature);
 }
 
+/*
+ * Return the feature "name" if available otherwise return
+ * the X86_FEATURE_* numerals to make it easier to identify
+ * the feature.
+ */
+static const char *x86_feature_name(unsigned int feature, char *buf)
+{
+	if (x86_cap_flags[feature])
+		return x86_cap_flags[feature];
+
+	snprintf(buf, 12, "%d*32+%2d", feature / 32, feature % 32);
+
+	return buf;
+}
+
 void filter_feature_dependencies(struct cpuinfo_x86 *c)
 {
+	char feature_buf[12], depends_buf[12];
 	const struct cpuid_dep *d;
 
 	for (d = cpuid_deps; d->feature; d++) {
-		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
+			pr_debug("x86/cpu: Disabling feature %s since feature %s is missing\n",
+				 x86_feature_name(d->feature, feature_buf),
+				 x86_feature_name(d->depends, depends_buf));
 			do_clear_cpu_cap(c, d->feature);
+		}
 	}
 }
-- 
2.43.0


