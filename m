Return-Path: <linux-kernel+bounces-380472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26929AEF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1918CB215EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1052003A6;
	Thu, 24 Oct 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYnTDA9t"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BD1FC7F6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793186; cv=none; b=lwBdjLAKdC57U1tgMLAVXQ2uYsc1HWuBBA02mqHPvNKwxYPFMSVAZXbHsXHmWzwvntjnnSoJsYmoQ7sun/YB9yUU01z5HJmRu5HlFDbeinSkwZG2JGGCE/VldS14ix0PQnNGn9Gb6RqRKiRKdELRn3MElDPXg1hGtoY0cbVkHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793186; c=relaxed/simple;
	bh=XTfYP/1zJrFaZAO8H/3E5awreJVbQT1zR8b0lhpyDRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuADodbzx+4x6k1gaxMIgUVlCFNiqWd0M2+S2w69bE5Tg3R/HQYfSjfi0Pol9tJzGorgViRkgjJQCM2xrmpzYk4eB8pRROI9f2h4eOvHDfh714K+07CCB7bAbJvZasrpKfl8OjLMrGzsuqs5Z+fsQhM/F+wSodp/emb+FaRFGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYnTDA9t; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9acafdb745so245392066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793183; x=1730397983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tZywrGtXElGXGCeWkpe4e06z9iVPQ8bc7Gm5OT3UMk=;
        b=IYnTDA9t8T62BSfCPGj63Ve243CnEnkKT+mLrptEwfk61pE9ps29XwJ+YXf3Bl+GTd
         rasuZfSJxnO17Bc5ktan6b15Kj+3HPhQJNEeLvhnarz6lQcVT6qOc33i0S2XBZwNYoyT
         tAhBAlN3GdootK3Z2F569zWk+6hy+3XeyJqVLyBCwEKNyg/nXyFbWnBaaCg02zx4XFpP
         BxnGb4oWAH08FDUfy9+RtG9k63tuRbxhMumf1gcrYCgRW0gajrm6wx1r2ZqTe7Bc4RiQ
         GgPybmdilKkWcGmRMiuUD/t3aLHhMH63urAPMq2optjioLLVt9waGl9FX4wnjxOYA6oT
         PP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793183; x=1730397983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tZywrGtXElGXGCeWkpe4e06z9iVPQ8bc7Gm5OT3UMk=;
        b=nqzJ3pHcVSnEtRt4gzKCp+KXqQBN+Z4S7hn9kpxCYGebvrYHK6AfuOzHRtt4ddD/JH
         jrHn2OntdAzImgoPSrtKwNBsjrAO5xWFxRCae9PynkFThq1wPpxm0m+7nFHgCfQLHzGo
         lgKqhDTU3H/Wl8VToKV2h7nqp0LPDdqIB9+aT5ZNjljfiJq9XGawo3v3ItGBZJlOa18V
         l9FTZVw1i3VtxSZFTuqEu0kErsmrns0rL2gg9xOT8ZSPjWwyN40gjYIXXd29Z7UkLDvZ
         IVrGfN0biXFdVbV0omf280Wufpx21D6K0W9LJ4JEz1IidwHj9XkaZB0nR/v71sHEu/2B
         hlQg==
X-Forwarded-Encrypted: i=1; AJvYcCWdl/eARBFSD/oT0BFigrOIZs2d/GHrFcv/gPolxOX3A0hBSFJZ5at3DJXUz9lUpOAf8iGmLd3OZ6BrkfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNRYMmk4EfcQhw2v7WQhq+W5phyDp4anAdtR2JPpjhzwNaIXh
	r7YynU9cwEn70xLUL/XgMGTs35mpPPG2KJhurxhVnPu9g5VfI2vs
X-Google-Smtp-Source: AGHT+IH/bJovAi1UYFhsfPPprIuvcm9G4w6PPfY0zfqmKh5eXH/haSbjxEpYkMVqPYZzvffNGDC0NQ==
X-Received: by 2002:a17:907:eab:b0:a99:3db2:eb00 with SMTP id a640c23a62f3a-a9ad1add979mr325340866b.28.1729793182440;
        Thu, 24 Oct 2024 11:06:22 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571ea5sm644337466b.160.2024.10.24.11.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:06:21 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] locking/atomic/x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu()
Date: Thu, 24 Oct 2024 20:05:14 +0200
Message-ID: <20241024180612.162045-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241024180612.162045-1-ubizjak@gmail.com>
References: <20241024180612.162045-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86_32 __arch_{,try_}cmpxchg64_emu()() macros use CALL instruction
inside asm statement. Use ALT_OUTPUT_SP() macro to add required
dependence on %esp register.

Fixes: 79e1dd05d1a2 ("x86: Provide an alternative() based cmpxchg64()")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/cmpxchg_32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 62cef2113ca7..fd1282a783dd 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -94,7 +94,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     : "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
@@ -123,8 +123,8 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+				     "+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
-- 
2.42.0


