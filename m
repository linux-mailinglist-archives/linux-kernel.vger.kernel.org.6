Return-Path: <linux-kernel+bounces-538073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1324A4944E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F07A2AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37841256C7C;
	Fri, 28 Feb 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQnEKnQ5"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60322580CA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733290; cv=none; b=fC82yj+YNeHdnReZd1xODcV8pIm9vi85/0M9c1wDFHKMgUAV1e+ZgJXwPLAGJJ0wfmhTRudGbngo/fPJ2woOZTVFYVkyqTiNJ0j5Sv8LDhUQ27JCgU8ByqmMbo+EP1yUGndBSPqH+LJ/CL0KLbHl8FotPrRtyKwN53zbguTkR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733290; c=relaxed/simple;
	bh=P7Irf1sb72m7M+wDMPQxtmBPtVt1VYdKd795BUkun2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7hYRG2iO0E9s1sReED7qlasRFmMJXwesX1Vv95Voqs1jcdqX5N2EBmEZYnL4o+Jst6qOQTI7kFLM/MPVa4lgCr8duhuoJlxjDS4V4+QrtDJsIHKQv2prKl+HBKYsk2Ws3hjAa+Gz1K2kpiDhVgzenys4cjDw9gOeJL85+EeFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQnEKnQ5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbac134a19so283605066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740733287; x=1741338087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiR3Q3Hzx+LFjLqooUrXeDrXwUS05trGGD2104VPDY8=;
        b=OQnEKnQ5Xe4BvyUNf/rKzb0/bQiqlugzXo03qCUFxrpvvWFXErXnDIOHCQQsriCVLU
         t5Pngg/kdKeftig8e0JRSWk/q9LKswHA+BvYXEqeY4ZB+K0cA11cz4jm8DDQdhEKX5th
         cHwd5sMATZibFf8PTNTwO8By8naVp21GxSV3SJ4rKk5HjFskXf1ME80JmR0BegQVpk81
         7g1c1DualHRelGBQ8iAod/S13NCxQmcjw3Qvvq73l04FCGfx35/ePo5MtMq+lyknQkWS
         f2eiUprgxnSEdieqfbe1HITMVfgztiLquEVMILC8YVdEhwrubn5HhaJl5hJH/PZrM8dK
         FVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733287; x=1741338087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiR3Q3Hzx+LFjLqooUrXeDrXwUS05trGGD2104VPDY8=;
        b=hMo+x5qkVET0A4mrDYmNC0Rr3PQXQ4Hez5QtCQvNvGKd8B0PeCBbrJklZRLXMiY5d2
         kp8STBIUDA+qffjbI6MsizlJUtyzau8L3YKR8Cnb6igwvP4ZbPCeble5urSfV8ZBm/V1
         JilHxmbjL1xSZQq46LzRx+EVe86XQ2cdw+NwrlBdmumA9T1yQaJatLYOYO86D1lLjkyN
         RVN/USloCsk0vd8tNf9t7MU0xxpC0lPRU5X9/RCzFEciBZSRrlZ5BIvQe4rqzIXfYZ6Q
         ik6OOWaWvzbQOGF3zTXOTSKYW44DAC+1eeZQOaARL893WODQFMx0/f5MwwbzIluvbO9C
         Se8w==
X-Forwarded-Encrypted: i=1; AJvYcCWYoprl7qoX3FJKOtznQlTNnvsmrxadqYOuU1+4VkAcVqzXzTg9stsa1rwHd51mMlNpSyjxTBlsQ5oP/GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49D9JQZDPryQwRItrjC2JNtGIhkwFJZ9EDI5XTtB+EizVh5CM
	ebhQXVp9kApWJZttxSW+EoxpSaIDUmF6DcvacFOl6XcyBvjlwieq
X-Gm-Gg: ASbGnct1rH9JtmttupSQ3oHEIbC5eI0nmxOp/LjcyjGou1BNNVBh3Ikqje9Q8lq4uwC
	kx5LRjKbJBjJKkML3Fp/f0HoMRGIgZsKQoTjULG8XA7EulrgfMaLItDDok17lt1cNmHBi2+MP3L
	o+Zzs6me8nnkxtHaCLMZexVfW56XNG0N2KUYIPgwrj9rih70Bbla4FFVPe+b8OwVnyOGKObKP7K
	SCQVHRQw7J7HjOBH53aCg2oXMjwOriq2PzLoiIbjtdumJUwg4Kbq1puVcqktGb2gnm2DPmbm5n0
	+Gbb879GOyBNaJMf0Q==
X-Google-Smtp-Source: AGHT+IH7wl9bSRrHP5kWST85mxMZuYKEPvcz8cnXAvDNj4PvbvFgz3YSLxbx/1/EH0xeGLaoKUTfsw==
X-Received: by 2002:a17:907:2d90:b0:ab7:8930:5669 with SMTP id a640c23a62f3a-abf25fbb482mr252696366b.18.1740733285896;
        Fri, 28 Feb 2025 01:01:25 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd9f1sm261651366b.62.2025.02.28.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:01:25 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] um/locking: Remove semicolon from "lock" prefix
Date: Fri, 28 Feb 2025 10:00:08 +0100
Message-ID: <20250228090058.2499163-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "lock" prefix, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "lock; insn" as two
separate instructions. Removing the semicolon makes asm length
calculations more accurate, consequently making scheduling and
inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving lock
prefix. Trying to assemble e.g. "lock andl %eax, %ebx" results in:

  Error: expecting lockable instruction after `lock'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/um/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index 4da336965698..b51aefd6ec2b 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -12,9 +12,9 @@
  */
 #ifdef CONFIG_X86_32
 
-#define mb()	alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
-#define rmb()	alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
-#define wmb()	alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
+#define mb()	alternative("lock addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
+#define rmb()	alternative("lock addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
+#define wmb()	alternative("lock addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
 
 #else /* CONFIG_X86_32 */
 
-- 
2.48.1


