Return-Path: <linux-kernel+bounces-375432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577699A95DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAD5283DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302214658C;
	Tue, 22 Oct 2024 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VyoiSydg"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F708132114
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562369; cv=none; b=RjZFsILZhgUnqTaI0yjmM3WZd1G/FNMcYBU7zfrKoRxCPtAt3wihNGHA/zb+au+nBFtYK93nA40ok4bJlwmiux33azKFvnzIt1m405nwCHOxNj+cUeMXgRXCkqvOLrj2VyxJwuOAPglNY6HZBuRtFgmfds6dzQ4Q9q76Mh/+IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562369; c=relaxed/simple;
	bh=81X2pPkAnK+T4NW+tJgsONRnsJlo9lmW5DNhEhbK3Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RveDefD6y6F5dmh9oe7PZ/3/JTb6MVcHmoVajbroXm0LLEi0FBJc6dBDmqq6CAVKi1hJMBZKT3111OQIULusk/owZBVA0+y2mB7oPO2tHdaL9cNwtovCivjEN72IV4OvgcXZsZjybVmRYX2X8NsD1oTJcWkD+lIhTgGmbHoHu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VyoiSydg; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-718186b5c4eso1768766a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562365; x=1730167165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpfVj+cCklKKT0meu9E3X+82meKkLqCR+uZsOKWdYis=;
        b=VyoiSydgUQvKijw0yBfUO04GtTG8YhBef5O3KOkf9MC6n6Lr1NAJUfTpfetRfdALDC
         lx3B0LsurLc1YI8u90Ng8YglP25/3pJrkACZy/PguSNtHZX3BxFFeLQVv1t9s8hs/w90
         6L+pP1q7iTdIjaScCj5L6Cimr221XEdkzzoZzx6moaFIp8crCj81DxcWfMGv2MAzZxAE
         4HCXFjT/RHPJIQzS7mkI1oBkJEYgFggARGLS5g75RnVzdTyycEo4XthcwlUBg8hK4tJ+
         HU/su/snQ3wABZgionQvcWpXMdqQwByXF7325l3Z0oa+Ixxrpm6gbsqVwWTgqzZmcFhI
         b3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562365; x=1730167165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpfVj+cCklKKT0meu9E3X+82meKkLqCR+uZsOKWdYis=;
        b=LwLn823j5/0xayH8DzYbQAuwsJfHG0gRExgmhFl6q/5gnEcjkooqHZIeAiKcZ+gZZl
         CnMagn4cUIN9t6XOgqmGCIAVliIbulcfQneB2/Gi7qxqlKkyJ1rcPT/TXQiom8R08oi6
         5kn6AL/2cT6ZbN4/i9YJGjTN2u2+YfwTYvpPx62L8qWCWVs4i/EHtcZIkR/Uu9DvZpDu
         J+wubCMY5K5DU/lYJbTQ8+tqJeD5IhsqKWgWSTy8bIpUkD3DPvJxwq+9KtFKWNmp3v+I
         Gu3lB92Jvl0kKFPDUAqidqzyJhaNLiX8p/87HXoywco9LTWkvm+BkLPeYmT5JagYN+Lo
         +fgA==
X-Forwarded-Encrypted: i=1; AJvYcCUHrG/m7lHgxe0atSBrjDlIDjMMSDJNY/o5YU/Vpdecg1VJsRlzCV7iMdEACdT1CioFGLtnl4mPDJKkh1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNs592+G2yP716QD5ewt7CHhnO1/99UccrrRA+w8xl9394nW5
	INPoeL+3YDu3y24QoHtme8B5niy/Bsxm4Yj1kTpWCZxxYSdT0T8J6FznERA8OHY=
X-Google-Smtp-Source: AGHT+IF8mODh9IAJs797PRe4iXy3b/dNIvInfpWpmRrPkiuy4gHecBRUAsqzv6T0/gnC7v7yNiNl4Q==
X-Received: by 2002:a05:6870:148f:b0:27b:61df:2160 with SMTP id 586e51a60fabf-28cb010575fmr1017968fac.31.1729562365145;
        Mon, 21 Oct 2024 18:59:25 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:24 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 5/9] riscv: mm: Log potential KASAN shadow alias
Date: Mon, 21 Oct 2024 18:57:13 -0700
Message-ID: <20241022015913.3524425-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241022015913.3524425-1-samuel.holland@sifive.com>
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KASAN is enabled, shadow memory is allocated and mapped for all
legitimate kernel addresses, but not for the entire address space. As a
result, the kernel can fault when accessing a shadow address computed
from a bogus pointer. This can be confusing, because the shadow address
computed for (e.g.) NULL looks nothing like a NULL pointer. To assist
debugging, if the faulting address might be the result of a KASAN shadow
memory address computation, report the range of original memory
addresses that would map to the faulting address.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index a9f2b4af8f3f..dae1131221b7 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -8,6 +8,7 @@
 
 
 #include <linux/mm.h>
+#include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
@@ -30,6 +31,8 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
 		addr);
 
+	kasan_non_canonical_hook(addr);
+
 	bust_spinlocks(0);
 	die(regs, "Oops");
 	make_task_dead(SIGKILL);
-- 
2.45.1


