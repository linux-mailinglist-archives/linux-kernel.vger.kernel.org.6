Return-Path: <linux-kernel+bounces-543584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04961A4D727
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B1E7AB000
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006A2046AE;
	Tue,  4 Mar 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gfSpJ6NY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J/tQ3cVZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11548204851
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078451; cv=none; b=WLls+kie+IV1diqfWhK4tarypZGSLNcBDnElIed7xlpGtj5HV5mkH10B/tbxnjvRCKjBZGntuRWHtF/dP1123SCmKkLcwyQ7klnoPpYa3ObQ8S540QfCMGqs5s9n9+57w0lrVQ1ImU6GwDRGjH7dCGEI74NltEXxELgPA/Q/W0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078451; c=relaxed/simple;
	bh=Zfv62AjRdsZsGNmrKpK4CzHMukrCZSEPzzu5WGKhCeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcMbwkt6XdlCuf5LY5DJotxMrCbQbGTtGgV1bliYj+yAW3EJjvONHUz3jxm/gcTopsoXv2ExXg7SDGdVxTFa6aATPi2w3a6r+hQgUInuWzU0hW+oHK3sjAX0O9RYqlqBVmhUzzJW73p3qyBvm80fiBXs8PbNDGDdpK7kwBs3P8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gfSpJ6NY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J/tQ3cVZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/CzymNKQDY6/AWVrKNmDCqqiXY5d+DZjg+XGgnzD6Q=;
	b=gfSpJ6NYsmu4hge65K3r1z++/mTyULiVPqUT1UEH0rI2JVYXAOOgXurJzWKWj/lh0/ioZ5
	0DiIULOoARVQGpHpBOCuPCcUHp8YF6VKjlRgw8vcPXwrVlUE3kd8mDKAzvyJIbGo41IcTt
	aZUuOYR9JKNcUxWgj8jUXRVMF3h7x3xFJ9jLXoPcUiEFfvw5aNNimE7rBHbSUJ4ci8mQ2k
	eIBNApkNJP7Gj1cfdlFlnsBSYHv0AySAXg4/f1m7GLFXSpnK8Blp7b+L5xZ0QKcYN1YPpi
	bFLNuYFqM7Ka6gX87DMqHaNgqH6XVT/BgpXHWVOvaGG1rYKK5wrsiOBHyQP/kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/CzymNKQDY6/AWVrKNmDCqqiXY5d+DZjg+XGgnzD6Q=;
	b=J/tQ3cVZPMDDqKuc7c12APp6cpFPp2WhEH/CXSBVdETXCv7NKr7FHs3Dp29i0UgqMkDqTd
	HqklWTCTO8LM51BA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 38/40] x86/cacheinfo: Relocate leaf 0x4 cache_type mapping
Date: Tue,  4 Mar 2025 09:51:49 +0100
Message-ID: <20250304085152.51092-39-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cache_type_map[] array is used to map Intel leaf 0x4 cache_type
values to their corresponding types at linux/cacheinfo.h.

Move that array's definition after the actual cpuid leaf 0x4 structures,
instead of having it in the middle of AMD leaf 0x4 emulation code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index ac47d1b4f775..bb934f81dcd1 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -78,6 +78,14 @@ struct _cpuid4_info {
 	unsigned long size;
 };
 
+/* Map CPUID(4) EAX.cache_type to linux/cacheinfo.h types */
+static const enum cache_type cache_type_map[] = {
+	[CTYPE_NULL]	= CACHE_TYPE_NOCACHE,
+	[CTYPE_DATA]	= CACHE_TYPE_DATA,
+	[CTYPE_INST]	= CACHE_TYPE_INST,
+	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
+};
+
 /*
  * Fallback AMD CPUID(4) emulation
  * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
@@ -131,13 +139,6 @@ static const unsigned short assocs[] = {
 static const unsigned char levels[] = { 1, 1, 2, 3 };
 static const unsigned char types[] = { 1, 2, 3, 3 };
 
-static const enum cache_type cache_type_map[] = {
-	[CTYPE_NULL] = CACHE_TYPE_NOCACHE,
-	[CTYPE_DATA] = CACHE_TYPE_DATA,
-	[CTYPE_INST] = CACHE_TYPE_INST,
-	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
-};
-
 static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
-- 
2.48.1


