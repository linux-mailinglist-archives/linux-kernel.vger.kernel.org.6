Return-Path: <linux-kernel+bounces-575800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF2A70752
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C69A166E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135BC25EF90;
	Tue, 25 Mar 2025 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkQidK29"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2619F487
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921348; cv=none; b=BScqK9lfND7qCpnnZ9ARr6/K6Nom2ry02tj4+LCDSwF/pxH4Aui/XutmY8u5qaufXXXlGqyrEEyezhgu8qShJEdVfCGSzYcFAPnin/wCwiZPydK6t4peHUgwLCyFY5Oqtz5XP8enhNzlFkMrs3A63gN71dw6m7uOKBbuUCPHyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921348; c=relaxed/simple;
	bh=ku0fKpm27vXNvN6wCrtYfpHif8WI/mi12b2yUnmanAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dxj2cE1m+Ym2uZGVTcD93tmtizAOffFhjBspWNr+XTf49nHX7Qhsp9whhaVieHd8ymqJIsGmwzB5Q/lFOkZJki9E80Z13FFCG1p3IP8yzDhzVGR9+JihQ4OzXT+TPsz98FOh6JPVrc+IAHtw+Snxbcldu15CJhX0uUF8qbnFYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkQidK29; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac27cb35309so962520266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742921344; x=1743526144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RseIkORBGnNKsNEWAawWrqv74R2WVBZr7m3YIK8kMRA=;
        b=lkQidK29PeevYFHf87u8FFWlT3WUdiRoILovI/WQe2oxuDvpENLs6tWSX+yX5OSSIG
         NROZFTkGIl1ITu1i0Ol6qWVQoDhOTVC+YEiQy27mvBzHYvZVt8boVy5sQE9zLFANs0yY
         4xbM4kXldGvOb1HBOLc242ttJ3QY69heiSwKrA5ZclOhoNPxjp0urSih+H/aGYmX+o/g
         8URpRqt1LHsJuIi7b3GD5c15S0bpkGOXQgi/Ij4aR0fv3J6/SDX1uQxsQ2Fmr98tdvJ9
         69ZTnAoqkptUR8KqPgGIUXGPMzVL01jxE5iHNRzti2p8rDwep8jImYxNOcMkslrYXAEF
         uYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921344; x=1743526144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RseIkORBGnNKsNEWAawWrqv74R2WVBZr7m3YIK8kMRA=;
        b=ZXgtk4IBXMR3do7NrumJnJLErE8WtKZWfP2ApdEoeYgelBMcEUdBqgpjeosgAWT9aw
         qC9Q43pWkf8qkvqEbb1mAvGdCZ1rN5InKJAfYxVqiyyBKJisBC4gfTL/CJccp7KfnLQj
         P77gcQJ48VpPvntGSzZoWaim8Q8tNjZo8xi/0EvsbUCZYfoyLugy4K/AofdC7vQKX/1O
         /o0w41eO5qJVVS0h338924UiwAgtO2VmBtQ27P0rNNK3dY+sNX+aT5tNJkFcwATlx8/r
         yqPWWF6kqRFOPmN84XoTLz9hAzO1jBdva7f81s9tL85LFRfugiflGJEgV5EUNGHCBYpK
         zUpA==
X-Forwarded-Encrypted: i=1; AJvYcCWzbIz3MhXaS43UL+oiBu/l84fn7fV++x8W3yB4sVtY6yTbC3CNHEAcRMUx/DQ2ZZDl1gr3qMvQXkTPPP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv6g9t0g6mLqmbscYzx4Jp+7cS6d8J0GG1FL/dHuLu+xzlqAtc
	y/lYqQn8Ydi+J7m5sxtgiV6cTHfB8QD4HKGib/PYmndoO4wI8jjfhzLuHNHq
X-Gm-Gg: ASbGncsks7Xcfg8HvhdEgPZRiA6U5Dyj7d0mJDD47k/dcNcI/CKba2kHSw+ym2GJd3p
	rHEy1cnMkAu6RgA56cEZRI6VQhOk/roIu7L4fxfLZufFvIq8h2wY5sQuQrtr/DFIZ20+a9YQtME
	wt3jIKsO0zgBgZj3EQ4RjKlCGpyy8Kw6HbIjpE59fWJBSsGEzfHD+XU5C0pONfkmstGMwLZWiiw
	1DS/e1e3hHrxqBsbIK94cssfn2wxP/nlUk91CuCwaEZ+ZldSOLLn5dEKF0aiZElWxVNd6XvRSGq
	mxXUXchBERjnsHLF38Uzl5MRWF6MoQ1sEYijlzcxqssXN9E6/DpJvQ==
X-Google-Smtp-Source: AGHT+IGUeiCbpyxEHRuJgx6JlxjCH7T6OBmTcFxPESfofNScsPn4wGLS1KJXSRYWwaJdySRfKRDJXg==
X-Received: by 2002:a17:907:9449:b0:ac3:5c8e:d3f6 with SMTP id a640c23a62f3a-ac3f25903f2mr1519871566b.55.1742921343643;
        Tue, 25 Mar 2025 09:49:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm877866566b.31.2025.03.25.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:49:03 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 1/2] x86/hweight: Fix false output register dependency of POPCNT insn
Date: Tue, 25 Mar 2025 17:48:37 +0100
Message-ID: <20250325164854.199420-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sandy/Ivy Bridge and later Intel processors, the POPCNT instruction
appears to have a false dependency on the destination register. Even
though the instruction only writes to it, the instruction will wait
until destination is ready before executing. This false dependency
was fixed for Cannon Lake (and later) processors.

Fix false dependency by clearing the destination register first.

The x86_64 defconfig object size increases by 779 bytes:

	    text           data     bss      dec            hex filename
	27341418        4643015  814852 32799285        1f47a35 vmlinux-old.o
	27342197        4643015  814852 32800064        1f47d40 vmlinux-new.o

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/arch_hweight.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index cbc6157f0b4b..aa0b3bd309fc 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -4,12 +4,21 @@
 
 #include <asm/cpufeatures.h>
 
+/*
+ * On Sandy/Ivy Bridge and later Intel processors, the POPCNT instruction
+ * appears to have a false dependency on the destination register. Even
+ * though the instruction only writes to it, the instruction will wait
+ * until destination is ready before executing. This false dependency
+ * was fixed for Cannon Lake (and later) processors.
+ */
+#define ASM_FORCE_CLR "xorl %k[cnt], %k[cnt]\n\t"
+
 #ifdef CONFIG_64BIT
 #define REG_IN "D"
-#define REG_OUT "a"
+#define ASM_CLR ASM_FORCE_CLR
 #else
 #define REG_IN "a"
-#define REG_OUT "a"
+#define ASM_CLR
 #endif
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
@@ -18,8 +27,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 
 	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
 				"call __sw_hweight32",
-				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
+				ASM_CLR "popcntl %[val], %[cnt]",
+				X86_FEATURE_POPCNT)
+			 : [cnt] "=a" (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;
@@ -48,8 +58,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 
 	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
 				"call __sw_hweight64",
-				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
-			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
+				ASM_CLR "popcntq %[val], %[cnt]",
+				X86_FEATURE_POPCNT)
+			 : [cnt] "=a" (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
 
 	return res;
-- 
2.42.0


