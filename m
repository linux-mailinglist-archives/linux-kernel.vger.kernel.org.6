Return-Path: <linux-kernel+bounces-524302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C364EA3E1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CFB703F32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A0214A7B;
	Thu, 20 Feb 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vR7l+TDF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zjXn4G4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vR7l+TDF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zjXn4G4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68A214A72
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070359; cv=none; b=uePjsQM6leyl93qye8uXPwO8/95EOurfuuuNMirKkei8cVZdevHZ4NOqHbAkT8SqpsRdE6r1mBCNc+DNhOxWkM3+4+Y24otBWUHqMyJUEFUYW1+y1z5LXx9tDxKUdMQm9jSEw1ECt1KRv5e5L1IUYlCTRvaqgIsHiX/UI12erWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070359; c=relaxed/simple;
	bh=6ZGEY1CUTUb9hIZs02aQ9APntILoEmml24syPbtm05w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3bzZNix9TkSCZwGpW8KpZYHCPTg5+D9SN0CqqpdLZ17KLpDIhYIMNyuN47H+/w5UBrM8aJRQDKx/D1hru2a5c89h0P/DB+4mmkuaJCR6qWsSiUcjbEwI9YyOY2yBS7l9XFBp9yTPgOS90cRymg9NDmhW/dd3h+26upYosSmQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vR7l+TDF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zjXn4G4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vR7l+TDF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zjXn4G4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id B9A6221186;
	Thu, 20 Feb 2025 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=vR7l+TDFHoQkJcuzxpxWN12po112UZHuh6/OAATx4v9jBC9K9qy6mIAmm+LWAuBAK82iFZ
	SwDNsyO4jC7Rk/W89RhamlC+MXPERH2UtMnj23slI8py9ZKNqSDanS1JQYb68bY82WOuHp
	dTaoB8ckoNaLpJYYbytYXiuFO+N8hpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=7zjXn4G4ZCuWjVS5/GJCXpVdrmZ3Aa1fUFf1swFrLtFv7JmkHLXPMd9XuUUBr1+M8LQeKn
	DjLfbLTdD0epgKCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740070355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=vR7l+TDFHoQkJcuzxpxWN12po112UZHuh6/OAATx4v9jBC9K9qy6mIAmm+LWAuBAK82iFZ
	SwDNsyO4jC7Rk/W89RhamlC+MXPERH2UtMnj23slI8py9ZKNqSDanS1JQYb68bY82WOuHp
	dTaoB8ckoNaLpJYYbytYXiuFO+N8hpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740070355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hH9uSFhc8XNqgswkvUUEW9uh5z40NPrJwxzIGYRAvqU=;
	b=7zjXn4G4ZCuWjVS5/GJCXpVdrmZ3Aa1fUFf1swFrLtFv7JmkHLXPMd9XuUUBr1+M8LQeKn
	DjLfbLTdD0epgKCA==
Date: Thu, 20 Feb 2025 17:52:35 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v2 2/5] kdump: implement reserve_crashkernel_cma
Message-ID: <Z7dd0_XLzmb1tBUk@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
X-Spam-Score: -4.26
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.16)[-0.776];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,localhost:helo]
X-Spam-Flag: NO
X-Spam-Level: 

reserve_crashkernel_cma() reserves CMA ranges for the
crash kernel. If allocating the requested size fails,
try to reserve in smaller blocks.

Store the reserved ranges in the crashk_cma_ranges array
and the number of ranges in crashk_cma_cnt.
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
index e72a9c897694..d71aff19a28d 100644
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
+int crashk_cma_cnt = 0;
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


