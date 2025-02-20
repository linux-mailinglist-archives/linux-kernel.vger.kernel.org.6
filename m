Return-Path: <linux-kernel+bounces-523026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3059A3D119
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3533A81D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A6418DB24;
	Thu, 20 Feb 2025 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7GfD63M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0D286291
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031301; cv=none; b=Vuv24rgzyENiw8L0lDvwVfIFeVCnxRpQmFEd8bKjABlpUpZp5SWXNP91Y7z7GOEiGjyA8m2eBtY9VwmpaCg0eYcNpVu/X2W1SgMwgJyhmr/b8Bc34JpoW8Lw6lHTlRDvRVNbBe1a+BgPMT+OGEAQoqq9dH43x4Uj545jJzjmtnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031301; c=relaxed/simple;
	bh=YGlmn0WDdiWIvHNuGzTP709+dUtkq69PPMRpN5GrFBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bndOZfDFEKTiMpd7ZBn2ayPh49wkIrTaBdb6q4U1kKuuwGivx7f45j5LOm2b6Suv7g6IeaInJSMYUWkjspMB1iJvekTM5hbZ6kybUew8e6rXWO+twUPjGqbZankguV8tLOwtPzuY1ZsOtwQYDS/QRAphbRT86weJExn/BneoWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7GfD63M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AC4C4CED1;
	Thu, 20 Feb 2025 06:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740031300;
	bh=YGlmn0WDdiWIvHNuGzTP709+dUtkq69PPMRpN5GrFBg=;
	h=From:To:Cc:Subject:Date:From;
	b=O7GfD63MHdKdBcdCa0c1RhF7oes3ORVeX8pttjblSD8fYUV+oVtgrT+drQ1ldV/8A
	 kdq25aPfowgu3xjX5JDoTZu1f4corvWcvX7qsKeAD4oQZ9D/a2MgVJQrfxRoui5zL8
	 JNi0faJS5p3z0l1vDUNSqgzuW2opDpuzFmu0pCkZv0luX5jeIxY4OymvCtB248yP43
	 BiVZwUbFXQmJsJfenK8FOPba21BXDWbEBPREGfE8ZvfMS8NtsX2YAagVeqDkXZqj7u
	 z+yWdVeobLD7Y2p6Uq2c6tJcohoXZM4N31rfm7AgdOFLKA5jTJe4qFbB5C4sixnOR0
	 DLBMXpqETws7A==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: Make AVX-VNNI depend on AVX
Date: Wed, 19 Feb 2025 22:01:24 -0800
Message-ID: <20250220060124.89622-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The noxsave option disables support for AVX, but support for the
AVX-VNNI feature was still declared on CPUs that support it.  Fix this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bd84114c2d96..df838e3bdbe02 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -43,10 +43,11 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SSSE3,			X86_FEATURE_XMM2,     },
 	{ X86_FEATURE_F16C,			X86_FEATURE_XMM2,     },
 	{ X86_FEATURE_AES,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_SHA_NI,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_GFNI,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_AVX_VNNI,			X86_FEATURE_AVX       },
 	{ X86_FEATURE_FMA,			X86_FEATURE_AVX       },
 	{ X86_FEATURE_VAES,			X86_FEATURE_AVX       },
 	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX       },
 	{ X86_FEATURE_AVX2,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512F,			X86_FEATURE_AVX,      },

base-commit: 87a132e73910e8689902aed7f2fc229d6908383b
-- 
2.48.1


