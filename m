Return-Path: <linux-kernel+bounces-565128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61AA6617B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDFE18920BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA65205E04;
	Mon, 17 Mar 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIiXyJxB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A52054EE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249933; cv=none; b=YsTyin/sn5/5qOe3W/ImhpLW9FrJps0upnvwVx9/JGR/X3bkNaYfbeR4PlZs63A/w6w/S32sONgwfpub2apifWI93uYV9AtxJVHz8zm6j+ETe1BWPZ2epRBL79/1sXHXJmhlyunmrJVC/k9+aL21OHFt4AWfItbryGgPa/dVf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249933; c=relaxed/simple;
	bh=PtmZ0e2Y6vSqIeyqAnkEOwdIvvrpqOGRYVVRQkfghTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqNfjlEXp64CWmIos0Rw6RIE+p/zT4K22LOkIeTQqIm31gkzeJUST2/UyJEf/BsNw3MgrccJOzC0pYaJnEAb5g2U9cSErU0tfE0sxjDwO4aZp1veovG3NlWUVMhtlQx+DPa2dk2EJ2csi44HIccGKDNugovPBYF+N5I+/YmkVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIiXyJxB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac345bd8e13so409447866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742249930; x=1742854730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8g4t4bHFVzGlfp2uWUN6FjECY3OUd3XwUbXMDVqvzM=;
        b=fIiXyJxBMkNKtP5HbO+7uyQJj+BdsvdBycj2hFiXDHuA6N1fWCxfqrZOLZxBRP/+CL
         fzzeldJJbCwRUQo9DnLQ7iZ6UfAd0i0dy3bjmAP/gIiFoQpAC9TO+HyCaSI4SUoOFpeH
         THz/LmrU7sSTutApY5Y/1W5DPC6I66cVSELEgjtpW/DMa16YhozutzaI9LeN9PBatset
         4c27ghz3sUpZibirER+mplSXsvpJLJPPPdpMyZZ1g1YMs1+GZlnkSfyxqptE67M1wQT3
         Y9/yi3A5ncicmDJkX84rln6q5HtlQF99pH6OzhZEq91ujpq3iXWpCbtHfee/ctN6zdMe
         hJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249930; x=1742854730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8g4t4bHFVzGlfp2uWUN6FjECY3OUd3XwUbXMDVqvzM=;
        b=c+/d6uQrzpXab0ciqG/9VHx6dqQlMGCWXYWOcO6C4MaK0qJ/JORgZ46UIOZi0VPYIr
         hqGZcs6ZVzK85x/or9g4MIobvoChWs6lVFuP2W0Uk1wYIYvq8ZRnzMj+svQZA2qepK/M
         3RwLEX4hPz+F/9MjPLzs36oBRgNSsoaUN1dKcmUnNfCyVVXfLwvuKCXg7csxyKceFwuQ
         mdHzJ9yh4dTkwe12D1J71uaj8Mj7Lwr9f5vNNB8lLl/TL3MbqVCISM7gLmVeNLosuZRI
         XcUDTf0Dvmu6GN3nU/wm9B+im/NS+MWAT7WN/CEkxDKeOcEeh0MefZmvHHpTmslYrlXo
         iHtA==
X-Gm-Message-State: AOJu0Yz0h+712oKnDFpme4Lffm7FGcp6jMslI/nmYYh1suXlMZW0a0bG
	ZywWuEUh/MQIwp3oZsPIb91VsXS/1/aCbmAAIDp/qN2H4Z9FYdaAhGowy6Zp
X-Gm-Gg: ASbGncuCJvGq6f+433VGqLWdG3KYlN9Lns1RWlOqo/G2FJ9qljEWb9KY2vu9NLRQ/0d
	cByj5Ym5q7vqO1kMjEzMikITNlz2KQPAfxmPyG0z74czPRoKY7W2874jx8LjB5Ktt5r4cC9J8Az
	IHcJ9KOBFELsZ+9Pa1jz/E9pKV+xyRHDBslKHTEFjSpEseV+7KnIUQ//88kaFhVePWSzBsUkRpT
	FQ4/JNpYSr48X8+tRXw4NxI/YiejoMK1AoJ+mqczu5ypQhp/fuJy0OsCuUV/Kt2Pm+VUAPQ38tL
	4o0chsIEGgTcZGN55X1WqXhP/wMU9PvBSdlIiUSj0lzfpksJGaC7i0qu6hiYO1uWtQ==
X-Google-Smtp-Source: AGHT+IEWtrTiiFw6qrHqtF5S8q5yIevPC2k46vTJogFNNn2xSo7P9jLxsTnjzY4N/TjphA3lhYb23A==
X-Received: by 2002:a17:907:930b:b0:ac3:8537:902d with SMTP id a640c23a62f3a-ac38d411550mr119871566b.23.1742249929741;
        Mon, 17 Mar 2025 15:18:49 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a481absm727454966b.155.2025.03.17.15.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:18:49 -0700 (PDT)
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
Subject: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
Date: Mon, 17 Mar 2025 23:18:23 +0100
Message-ID: <20250317221824.3738853-5-mingo@kernel.org>
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

Convert all uses of 'unsigned int' to 'u32' in <asm/cpuid/api.h>.

This is how a lot of the call sites are doing it, and the two
types are equivalent in the C sense - but 'u32' better expresses
that these are expressions of an immutable hardware ABI.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index f26926ba5289..356db1894588 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -22,8 +22,8 @@ static inline bool have_cpuid_p(void)
 }
 #endif
 
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
+static inline void native_cpuid(u32 *eax, u32 *ebx,
+				u32 *ecx, u32 *edx)
 {
 	/* ecx is often an input as well as an output. */
 	asm volatile("cpuid"
@@ -36,9 +36,9 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 }
 
 #define NATIVE_CPUID_REG(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+static inline u32 native_cpuid_##reg(u32 op)	\
 {								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
+	u32 eax = op, ebx, ecx = 0, edx;		\
 								\
 	native_cpuid(&eax, &ebx, &ecx, &edx);			\
 								\
@@ -65,9 +65,9 @@ NATIVE_CPUID_REG(edx)
  * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
  * resulting in stale register contents being returned.
  */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
+static inline void cpuid(u32 op,
+			 u32 *eax, u32 *ebx,
+			 u32 *ecx, u32 *edx)
 {
 	*eax = op;
 	*ecx = 0;
@@ -75,9 +75,9 @@ static inline void cpuid(unsigned int op,
 }
 
 /* Some CPUID calls want 'count' to be placed in ECX */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
+static inline void cpuid_count(u32 op, int count,
+			       u32 *eax, u32 *ebx,
+			       u32 *ecx, u32 *edx)
 {
 	*eax = op;
 	*ecx = count;
@@ -88,43 +88,43 @@ static inline void cpuid_count(unsigned int op, int count,
  * CPUID functions returning a single datum:
  */
 
-static inline unsigned int cpuid_eax(unsigned int op)
+static inline u32 cpuid_eax(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return eax;
 }
 
-static inline unsigned int cpuid_ebx(unsigned int op)
+static inline u32 cpuid_ebx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return ebx;
 }
 
-static inline unsigned int cpuid_ecx(unsigned int op)
+static inline u32 cpuid_ecx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return ecx;
 }
 
-static inline unsigned int cpuid_edx(unsigned int op)
+static inline u32 cpuid_edx(u32 op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	u32 eax, ebx, ecx, edx;
 
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
 	return edx;
 }
 
-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
 {
 	regs[CPUID_EAX] = leaf;
 	regs[CPUID_ECX] = subleaf;
@@ -141,7 +141,7 @@ static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *re
 	__cpuid_read(leaf, 0, (u32 *)(regs));		\
 }
 
-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+static inline void __cpuid_read_reg(u32 leaf, u32 subleaf,
 				    enum cpuid_regs_idx regidx, u32 *reg)
 {
 	u32 regs[4];
-- 
2.45.2


