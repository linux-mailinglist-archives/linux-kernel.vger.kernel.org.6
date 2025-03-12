Return-Path: <linux-kernel+bounces-558462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E48A5E646
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327667AE951
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921681F09A8;
	Wed, 12 Mar 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ItjU3FFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqJs26uY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ItjU3FFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqJs26uY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E01D5160
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813538; cv=none; b=AMQwT27u7p7gcOqCt3L9S26PlORPnClq2HnHnE+yQAZV0zPr9BrcE2ZxH33TVLala4Bf4tuGoxZ94n0mqShns+eGasQjBzqznyW3hLFjJFcvLavym+28AbIhk1JxZ0DTTNGmZRmfjGquMBViFlcKtP/S8f3Rtna9lt3zqTOj2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813538; c=relaxed/simple;
	bh=L5b1D6TYJmrcirdRDXeL6oPNjbgb5hY7R0NAnPP1gXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk5WNzQ/8LR+G/7RT5FECxRVgPh1qbIhAl2+tYMYO44+Gy3DaZBc6Dm3p2Bs5qs8sWi7ywRPJNhCz4MQvlVb7vspUQ8S5RlHNmwmhERvDyuO4SXKUHwwaFYo71JGAvbRbsfpVX0jdctvzlGDQnXnnFIPFKTXAHbZ+pw+kaif7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ItjU3FFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqJs26uY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ItjU3FFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqJs26uY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4184121169;
	Wed, 12 Mar 2025 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgwdaiGrUlctdcj6fv/5v5nJ5M1ZA0uA4RV22Jpwxwc=;
	b=ItjU3FFMnsbjIZz7O0l1thN6lna3mhz/0MBviz4CY1MEWCX7VPUdAP19LhBbfa7YCtkxka
	ddlpmCUj4T4VBpJAUXcLbGRiEEUIwLiAzvR3czSBugvKIkUhg5UQiYWL+ns94QLLYBeF7V
	M/CBE1vbD5TVqIaBWjdf8gryJGGONVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgwdaiGrUlctdcj6fv/5v5nJ5M1ZA0uA4RV22Jpwxwc=;
	b=qqJs26uYe0Yj9Cb1joXDW6mSq2Y9K0M9K12prbfEKWUzcEetq21jhdAEytQE1KN7er6L3Z
	L+/+WMwTs+z2EOCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgwdaiGrUlctdcj6fv/5v5nJ5M1ZA0uA4RV22Jpwxwc=;
	b=ItjU3FFMnsbjIZz7O0l1thN6lna3mhz/0MBviz4CY1MEWCX7VPUdAP19LhBbfa7YCtkxka
	ddlpmCUj4T4VBpJAUXcLbGRiEEUIwLiAzvR3czSBugvKIkUhg5UQiYWL+ns94QLLYBeF7V
	M/CBE1vbD5TVqIaBWjdf8gryJGGONVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgwdaiGrUlctdcj6fv/5v5nJ5M1ZA0uA4RV22Jpwxwc=;
	b=qqJs26uYe0Yj9Cb1joXDW6mSq2Y9K0M9K12prbfEKWUzcEetq21jhdAEytQE1KN7er6L3Z
	L+/+WMwTs+z2EOCw==
Date: Wed, 12 Mar 2025 22:05:35 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 2/5] kdump: implement reserve_crashkernel_cma
Message-ID: <Z9H3H04VX0lfKhGz@dwarf.suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[dwarf.suse.cz:mid,suse.cz:email,localhost:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -4.29
X-Spam-Flag: NO

reserve_crashkernel_cma() reserves CMA ranges for the
crash kernel. If allocating the requested size fails,
try to reserve in smaller blocks.

Store the reserved ranges in the crashk_cma_ranges array
and the number of ranges in crashk_cma_cnt.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 include/linux/crash_reserve.h | 12 +++++++++
 kernel/crash_reserve.c        | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/crash_reserve.h b/include/linux/crash_reserve.h
index a681f265a361..97964f2a583d 100644
--- a/include/linux/crash_reserve.h
+++ b/include/linux/crash_reserve.h
@@ -13,12 +13,24 @@
  */
 extern struct resource crashk_res;
 extern struct resource crashk_low_res;
+extern struct range crashk_cma_ranges[];
+#if defined(CONFIG_CMA) && defined(CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION)
+#define CRASHKERNEL_CMA
+#define CRASHKERNEL_CMA_RANGES_MAX 4
+extern int crashk_cma_cnt;
+#else
+#define crashk_cma_cnt 0
+#define CRASHKERNEL_CMA_RANGES_MAX 0
+#endif
+
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, unsigned long long *cma_size,
 		bool *high);
 
+void __init reserve_crashkernel_cma(unsigned long long cma_size);
+
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 4969d60c00d6..3d35d90dde38 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -14,6 +14,8 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/cma.h>
+#include <linux/crash_reserve.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -470,6 +472,53 @@ void __init reserve_crashkernel_generic(char *cmdline,
 #endif
 }
 
+struct range crashk_cma_ranges[CRASHKERNEL_CMA_RANGES_MAX];
+#ifdef CRASHKERNEL_CMA
+int crashk_cma_cnt;
+void __init reserve_crashkernel_cma(unsigned long long cma_size)
+{
+	unsigned long long request_size = roundup(cma_size, PAGE_SIZE);
+	unsigned long long reserved_size = 0;
+
+	while (cma_size > reserved_size &&
+	       crashk_cma_cnt < CRASHKERNEL_CMA_RANGES_MAX) {
+
+		struct cma *res;
+
+		if (cma_declare_contiguous(0, request_size, 0, 0, 0, false,
+				       "crashkernel", &res)) {
+			/* reservation failed, try half-sized blocks */
+			if (request_size <= PAGE_SIZE)
+				break;
+
+			request_size = roundup(request_size / 2, PAGE_SIZE);
+			continue;
+		}
+
+		crashk_cma_ranges[crashk_cma_cnt].start = cma_get_base(res);
+		crashk_cma_ranges[crashk_cma_cnt].end =
+			crashk_cma_ranges[crashk_cma_cnt].start +
+			cma_get_size(res) - 1;
+		++crashk_cma_cnt;
+		reserved_size += request_size;
+	}
+
+	if (cma_size > reserved_size)
+		pr_warn("crashkernel CMA reservation failed: %lld MB requested, %lld MB reserved in %d ranges\n",
+			cma_size >> 20, reserved_size >> 20, crashk_cma_cnt);
+	else
+		pr_info("crashkernel CMA reserved: %lld MB in %d ranges\n",
+			reserved_size >> 20, crashk_cma_cnt);
+}
+
+#else /* CRASHKERNEL_CMA */
+void __init reserve_crashkernel_cma(unsigned long long cma_size)
+{
+	if (cma_size)
+		pr_warn("crashkernel CMA reservation not supported\n");
+}
+#endif
+
 #ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


