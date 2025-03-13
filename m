Return-Path: <linux-kernel+bounces-560167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E54A5FEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE419C0BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45D1F192E;
	Thu, 13 Mar 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFWvTbdF"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0A1F130B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889516; cv=none; b=uFtZ2oGm/W6aVvwWuOA1ySA/BST7OVhahByPeT8HcIHDvxcDZ1G7WGSeeSLQvA1yF4qY5Cbbi4BVGB45KzXf5ev10CNw2BCiKS8FziFMWbXdxPgqA/Gl5wYBiIDkRx0ipXCWKGKJPH4z7Gcb6XjTV9etfzlhh81/NwEDoOW6unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889516; c=relaxed/simple;
	bh=MsTi0WCWVUenFgw7wL5/5lBWJN3wIK7wvteAaC3Fi60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B5cOq3GIByudbsEweg2ND9w9kp8Z97R80VsSAvRnPusqWN+IfPezrHAwzPU/Bw2LEANOEMq/8uQ7zUxHXlpBP9EEq51gUoRmeJxhgq8sctVLWW7zBHrsyFlL9LmxhRo9OSZZIQLSaGviLT+l8vnFs9LRac0vWjctcWsI9IOxKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFWvTbdF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd8fd03a2so7350695e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889512; x=1742494312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6roQ0y9HMVWb0fLuDGnNUraXTJD3yygGf4+oRkUuB18=;
        b=TFWvTbdFq9oqlwun6t2NWRXsClii6rGePwCzD0ZWuP+hGNGBZqvzyAnKgNgThOxPxO
         i/BwOesT9gweuFXEIq5kjoOPMfsBTpcPmw5F466t4PPzCjrVtmzHiwr9CHxQ0qIhKo0M
         jpEwTHBD6yl7cshuTxk6cTy5czKrMMfEqalRfjSWmg6BsmCJRIZ+A+NbY+du7CSIN33/
         DHNJPzj5S7aroILiTT7zKlTf6VQWJDxpom8bRr5BryxzjAbpKYFEScUQtcRVYsCz0Vdc
         QNjmQKNAJnT5mK/O6+wba0u+a5xBsljIoLmwHiUxuaKyDiqDVEhrrfDptoRTZ0V9Q3E5
         RYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889512; x=1742494312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6roQ0y9HMVWb0fLuDGnNUraXTJD3yygGf4+oRkUuB18=;
        b=U85E50nWc6ewihlS4xEJQ0IYEcpXxmsoCAAbA/6gzVZb1n7AwfCTSA6q9RdC6nrDCD
         KOGi/dmBZbfrZqUOH68hEIIyvwM3geX1hqzQZay9LNVy69wGG4na/Zfer44e7YxEUA9h
         WYzAduhYsu6QJLkLTAZpGWwjZly5S6K4KWDDTf0JbqLMh//jzui+dMMGx23KqkeSQJKG
         zsp2MCqWuET+2wIg9fxbN0OgRxBy3cvZEsv6ElxLnTeV8z0+dlfa7t0qf0un/9ecIF2J
         MP3g7+kZTKkkdWI871x2FNO/krwISbJBUYXtoBBOQI5fchmeuqN+7HRWUCQT464WsHL5
         AtxQ==
X-Gm-Message-State: AOJu0YzjaTm9Fo+E8eiIoSSa9JwvT6GFps6RPE9hsewfIf9PY6IMHjFO
	tUKZenUtk9iWF+NYXZTYTAF7+XoSnbf5OM0uITdq4LgGdeTPG8kpIY7uBTKiil9Hcw6h+XgkGbw
	FntlCTz3jdA==
X-Google-Smtp-Source: AGHT+IEIusjvqc+xKBD+wnnYFxl05hffn8LYeM0xBLqlMTC3EbbSvCojjd4lwP+OgtLOTfROmKsVm430j1MBCA==
X-Received: from wmrs15.prod.google.com ([2002:a05:600c:384f:b0:43d:c77:3fd8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8b:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-43d1d88c5ddmr6267935e9.2.1741889512673;
 Thu, 13 Mar 2025 11:11:52 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:25 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-6-04972e046cea@google.com>
Subject: [PATCH RFC 06/11] mm/page_alloc: Add __GFP_SENSITIVE and always set it
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

__GFP_SENSITIVE represents that a page should not be mapped into the
ASI restricted address space.

This is added as a GFP flag instead of via some contextual hint, because
its presence is not ultimately expected to correspond to any such
existing context. If necessary, it should be possible to instead achieve
this optionality with something like __alloc_pages_sensitive(), but
this would be much more invasive to the overall kernel.

On startup, all pages are sensitive. Since there is currently no way to
create nonsensitive pages, temporarily set the flag unconditionally at
the top of the allocator.

__GFP_SENSITIVE is also added to GFP_USER since that's the most
important data that ASI needs to protect.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp_types.h | 15 ++++++++++++++-
 mm/page_alloc.c           |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f9053c701e24bdcf1dfe6afbf1278a2d..5147dbd53eafdccc32cfd506569b04d5c082d1b2 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_SENSITIVE_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,11 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#define ___GFP_SENSITIVE	BIT(___GFP_SENSITIVE_BIT)
+#else
+#define ___GFP_SENSITIVE 0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -299,6 +305,12 @@ enum {
 /* Disable lockdep for GFP context tracking */
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
+/*
+ * Allocate sensitive memory, i.e. do not map it into ASI's restricted address
+ * space.
+ */
+#define __GFP_SENSITIVE	((__force gfp_t)___GFP_SENSITIVE)
+
 /* Room for N __GFP_FOO bits */
 #define __GFP_BITS_SHIFT ___GFP_LAST_BIT
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
@@ -380,7 +392,8 @@ enum {
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
 #define GFP_NOIO	(__GFP_RECLAIM)
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
-#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | \
+			 __GFP_HARDWALL | __GFP_SENSITIVE)
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c9a1936c3070836a3633ebd32d423cd1a27b37a3..aa54ef95233a052b5e79b4994b2879a72ff9acfd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4686,6 +4686,13 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
+	/*
+	 * Temporary hack: Allocation of nonsensitive pages is not possible yet,
+	 * allocate everything sensitive. The restricted address space is never
+	 * actually entered yet so this is fine.
+	 */
+	gfp |= __GFP_SENSITIVE;
+
 	/*
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.

-- 
2.49.0.rc1.451.g8f38331e32-goog


