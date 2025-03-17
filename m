Return-Path: <linux-kernel+bounces-565129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54768A66165
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DC7A5024
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98E2046AE;
	Mon, 17 Mar 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RATy431u"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB303205AA4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249934; cv=none; b=QJszwymVvOqiknbT7MVX0w3AFdC1y8R2l0RbDI657xHZ0U9zeikLsXHpma5X2lbHwNaUmDvpOFcDDDrmw+1C9bdbGUyr18d7ySHgsBUsig29w7T91RnVsyumVH/pjvolFxzxHC+yxO9EC4P7jv4gTTzYfP85XfRGZLrbn2/w7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249934; c=relaxed/simple;
	bh=rx0UH3de0JhT/dg5k81Mq8FsXXAMfwFbturbTRcfgmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGv4sS9mNsd0qL46DWQPvzoqCAEe75m71EdJOEwmGRyhUPMG3e8lRAl9bxmGWa3Jz2vfngMawGtD8ebQ1i3rJKbhF07tB9qXpJBUUxQ2HD1i/Q9OOCDwIYpOWjPQ9CmhqfAIvrCoT/b8G7oq2eCktQLu3Nigmd3pG+ubc/AvU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RATy431u; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbd96bef64so884043266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742249931; x=1742854731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmQuMZY7wP2XGEGMJozyD2sYjt6wO4YJjHtbWmwbaSE=;
        b=RATy431uWN4OkDH9Ax2BS5g8LV58BLS3cpUervAJNTR4kGmvJ+HdRJwjVi/lUS97MQ
         DIu6f+W9FQ48khoemrZNESiUQtYqvGCizzi3/DPLb+3KUDqyRHLjYdVzCjtvZQlM+XU+
         /AxH3aQPOLCmcvwU80PAckdq7bAdFzTRuQZJRsCQao2lEUe98D8LFJwmWULEXJhmnhKP
         sgZJEDoS3AI7IP/XH9D4zhgHgqzzHpKXdQluoScO8GQchWBq9xk413oAHFvRSouGtfWb
         4gE28AX3p2uMDr3xZx+DryUU/qX3rdOSVixN0vtszdGUeacjWJ9iDmcC+L2iCXR+E1s+
         8fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249931; x=1742854731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmQuMZY7wP2XGEGMJozyD2sYjt6wO4YJjHtbWmwbaSE=;
        b=mbaUT6P1Ujvge5CiGSMwIiVau2D7ylPtwCLS3vxK2cUiCaJonS4OeEwYWlOXF2IbQu
         osWet1dr9Mq8W+kQOkD3oQTZmKCVsGRWlvkpUThLH0ry6CCXNf6Y7Z6XOmD6G+DBEm5i
         et8xPXGJvEoCVJkuVmiEvuNph+uLTX9+f5TZ0VjOREVmilR18r+dwOU+mhwp4kagucqy
         drS7aJ0izs1YwT5ws5MONwUp0KW5hBQul/TEV2uSapH8XDtESKX/9g/ylK1oYvP5U2r1
         r2hy+9JqOrmflfPeurC8wclJYOdy7bMofa+cfJJc4oCUNeOrb8Rg/v9+FHhcHPml8lPt
         UhqQ==
X-Gm-Message-State: AOJu0YwCXgFmfDcqBKKM/MMWTn6GZaRDy6/L8tBsqDFCKbK4YZzlOmKw
	acROxRnZTBogVvetn3TWohXknijIRSvs6ve2GobFAMmR67sv1mO4YU+GIOEw
X-Gm-Gg: ASbGncu7miGJsMWjL+PzDHU26d9F+One7424IEmJAOJncdFXdYq69JtbKnTMdQT/Zjq
	+RpB/eNH3p9D3uGU56U+bz95mhdJRBABF2hE0++5K/oUig9EFZ3MKx9LU/srvDQyMlWojelqjX1
	7ncmYCWJl/uZXFfaBBTtqa8nnZ/N+4xrCGjiLmHPqvxJRI2+KKpTLtsgXhB1Tm8uz0JvaSSM+9s
	TFfL8xQhR2YQwya2La6uFgJzlKTyc4UnPdq2RjYzSDLocu34XUe1eB2JYKlh1sbhaxjG+I97vll
	6d7Qn2vDz9OgAU7E8W9LxP5fk7pm1zyn7ouIvGhaHkm7p7td6skUPKVPYeQkUWAEWQ==
X-Google-Smtp-Source: AGHT+IGW7lpg1fUM3r9sEO4rQ7bmQSgH5Nzll7V7Z4P2uxorFed1QGXXUEzGatziH9zLAl1LpHP3pg==
X-Received: by 2002:a17:907:bac2:b0:ac3:878d:662 with SMTP id a640c23a62f3a-ac3878d0973mr236237366b.9.1742249930967;
        Mon, 17 Mar 2025 15:18:50 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a481absm727454966b.155.2025.03.17.15.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:18:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>
Date: Mon, 17 Mar 2025 23:18:24 +0100
Message-ID: <20250317221824.3738853-6-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317221824.3738853-1-mingo@kernel.org>
References: <20250317221824.3738853-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use u32 instead of uint32_t in hypervisor_cpuid_base().

Yes, I realize uint32_t is used in Xen code et al, but this is
a core x86 architecture header and we should standardize on the
type that is being used overwhelmingly in related x86 architecture
code.

The two types are the same so there should be no build warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 356db1894588..9c180c9cc58e 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -187,9 +187,9 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 #define for_each_possible_hypervisor_cpuid_base(function) \
 	for (function = 0x40000000; function < 0x40010000; function += 0x100)
 
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
 {
-	uint32_t base, eax, signature[3];
+	u32 base, eax, signature[3];
 
 	for_each_possible_hypervisor_cpuid_base(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-- 
2.45.2


