Return-Path: <linux-kernel+bounces-565126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C3A66163
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35F9178C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB25204F9B;
	Mon, 17 Mar 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFL+OB8U"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3C2040B7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249929; cv=none; b=oaHyI5baewOiilokTvF3zSYlGkKr2LQWuveVgOEarHu1gCojRuRc294f/hKRitmMtcMkFgl7DhZcRA8TEZcHYOT7XlCgRYdtoTWGu8iZC1P89enHCzM5IlF52crdak/Lgfez1NdsOu1XO73N3Y8Qc9iGlcRBh6NVI1LFbOjB0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249929; c=relaxed/simple;
	bh=3XtREF1KRyHr7r2A8W/kBHu37fjo9QX1shsUsVhiIkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ0k9sQ63X3acH8qnFJ4f5eOiR4+rT4uNXRy1yE+vrX5bwCuPvjX6T36s4AUhKDIh9pBIrMx71xJh4P5obRf4yVTu8LNleSN5fskFu2wZ1rTwq/sxeKiQKsfEX9W+RYXfpV3vl4oJmsTxDp51LuVlTeDP/XwmAF/Bb1mrJRNyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFL+OB8U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2b10bea16so351826066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742249926; x=1742854726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaMO2x9PhDqccZ8XJQRrT65SV5IUJDCFSLKnMbdH/3Y=;
        b=TFL+OB8UcigJqg2rp3sLb5k0QF9iGEC8gA+K9wyLZzEXEbvtvw2bgdZkiJDfFdnWRd
         g7m4kIwcEfv/Tc1tV/hACOMepvMbojm0fQMXnn5z6puDEVH3MRCGstgDE8C7OBHN6HTI
         BilGD/fWyhirvIodiVdmzzVjzWX9BWuZA36FEBjYjyK79UXnhiwfoU/AxdUUMyHZpg82
         aiDosz5mlYhgRNH0nXcLvXhYaOYp6QZeX1HBoMigo749Nwb0uBB8jw74ZYvH+h/yOyHx
         WnRH8WGiXdv3oUhmHKIU6fmMxPfzLELTD/FUp4GOOPpcfT4ViQ8q1BMsWfzl8nFkqHAb
         YSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249926; x=1742854726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WaMO2x9PhDqccZ8XJQRrT65SV5IUJDCFSLKnMbdH/3Y=;
        b=NsQuo0QnYQrQWO6BpXgUlBzIpWbxP+TmPHbJYYHJMXvYiD8JLmc3bkSTvc2gTEGyPx
         /GRr+fZww9DyKd0YRhUQhD+VQsgj8uYpUgvA7GGw1ibr9TAF58qlO4qhrdgF8BXNAAnK
         YJhDYfmzDFj6LrH7ByL9XGlKGjz6s3QSKl+oWuB40WyVqTzw0aJkan6Vuy+psZ06ylVS
         Ll+g6NNa5XPvujfBqAn/9t7vsljlBnhbyYQ7EyOggFc75+KTu8dUklutfHkxNYKXbTnS
         H0fMUIORYqSDuVhoBiDeKnyprxmLAD/GNoGaYTIYlSHlhkEj1/BNUSJhkvbDx+dFsnEA
         +iOQ==
X-Gm-Message-State: AOJu0YxOviXPc7R+68Q8trBsKAyZXUfsO2n1eNAUwURa90wLbTbaqnDB
	QI8tUlUU/L4NN3/p/hQSLjDvKCx9YShVQcyHr99NgOUuKAUPICSwY0PLh/d5
X-Gm-Gg: ASbGncuZ2+06x+v6zkq7HN5kQ6mYIxNjPUq4MJ7+IgAyiYe/Mw06nUzMMN18HWun3sa
	rUH3x3J2YRDhHBt1mkmFESQxRfYnRBA9uyiYPguGveAhANzW3iiHaSq3nwDsm+6qvGhhNesbBjz
	IpLUA9VXpeI7zLiApnPGa6NBggl/v5OPFcqBVZpLEvwmUprNgUNhkPvGRTsRLExW+JWYDJ9q2RD
	gXveSdi1NfQ5AXcsM1DIWT/aAfsNGvy4UWJ+qbX1VSonTJG+Lnv7oS/Q2/O9+EiFHxMWY2A7cO/
	t9Seb9vd/T72d+R1ZitiPj6Okwb4kgL3pvh7ddnCLRHPpSo5444v2YYn+5n+rKOfDQ==
X-Google-Smtp-Source: AGHT+IHfagJawbGkp6AmMrhC7sQVRzn4HkZNoiFJSc4Zg32JaOfjgmvBqu9ILOLMemnC2vFWxHdI3w==
X-Received: by 2002:a17:906:3409:b0:ac3:4229:91da with SMTP id a640c23a62f3a-ac342299440mr1122675366b.16.1742249926127;
        Mon, 17 Mar 2025 15:18:46 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a481absm727454966b.155.2025.03.17.15.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:18:45 -0700 (PDT)
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
Subject: [PATCH 2/5] x86/cpuid: Clean up <asm/cpuid/types.h>
Date: Mon, 17 Mar 2025 23:18:21 +0100
Message-ID: <20250317221824.3738853-3-mingo@kernel.org>
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

 - We have 0x0d, 0x9 and 0x1d as literals for the CPUID_LEAF definitions,
   pick a single, consistent style of 0xZZ literals.

 - Likewise, harmonize the style of the 'struct cpuid_regs' list of
   registers with that of 'enum cpuid_regs_idx'. Because while computers
   don't care about unnecessary visual noise, humans do.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/types.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 724002aaff4d..8582e27e836d 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -5,11 +5,14 @@
 #include <linux/types.h>
 
 /*
- * Types for raw CPUID access
+ * Types for raw CPUID access:
  */
 
 struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
 };
 
 enum cpuid_regs_idx {
@@ -19,8 +22,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_MWAIT	0x05
+#define CPUID_LEAF_DCA		0x09
 #define CPUID_LEAF_XSTATE	0x0d
 #define CPUID_LEAF_TSC		0x15
 #define CPUID_LEAF_FREQ		0x16
-- 
2.45.2


