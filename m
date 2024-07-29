Return-Path: <linux-kernel+bounces-266428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84B93FFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA761F2254B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4D418C322;
	Mon, 29 Jul 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KF4B+zma"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D841131E4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286246; cv=none; b=b0PGHTu/a0hms0Yjk3oR3bjGv+3ow3YJrvo17chRobStDSawsCFQVKzQNyoXNq4+67dA2KKI6R0BGFNyCmEOopyfiXQXctT+jE12EboGACRp5eY/unn3wbg+LNDukyOSeQc9MpmUYFabU7h/zvZTZZIynoPEqove50h1FSUvDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286246; c=relaxed/simple;
	bh=QKbLeMMF7mDpLciQBgmaXsS7vFL+LO6R6LtddSUAdz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1kRYN68V5FwNHgC4CpvDkxUap1wuNmPwkpyT8EEkryeqZ0Zy2H3LYRK/VWtuqbN2rgHJvq3q3kqwsrGd+gP4exAojh1WzjbxFTdEk8tvKAG7TB+F5e75IwlfBsO7xqLRAkfTdbCpn9mVUJiSANz8dP/D1x1KJYsX/WRXdytkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KF4B+zma; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d357040dbso2859142b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722286243; x=1722891043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjuJiVps1krVsumKp/stss3kNN6dUsP3Lcn41G8nO8w=;
        b=KF4B+zmapDI2ZDcrPABNwQJPca4/IoXDxx+oisDLRSzSWUeeoIRqlUu8WIZSDfObX9
         lwJpcsw2tVEUyxtQ+nkSvenwj7v9BJsXRgpPA87qRdg5zeBf6OGtHtRDgamqafUD5CyP
         02HVv5IYAM6lO99OPPs+XHV0Ft6PQOt6z6VV8/J7kaE6SaS4YUldbEd1LaNhZdjwIFya
         Zi2HXhuFpxCTVE47eL7hDyvRUkE2SE8+/W74ArED3RrkpJJXNwyD4XzmCa1g9WGrRtC7
         mrX1YU458kqeBuQFZLgKeGhAfhbzzwO1DL3yhS949VV3ZgOCFWxPYenalx2djLuv63ES
         jBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286243; x=1722891043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjuJiVps1krVsumKp/stss3kNN6dUsP3Lcn41G8nO8w=;
        b=WR6lgqtUEQevPBgvwDq7pqRME03gIykOS2fcfhK7zJ6xpowBwZ5gUGP/XnEHciwuBM
         nVoaCBRQIdbi6SeEnHAWzKQSQC3xrPJFwY2RI8PsvTQlw6sB5up8LnHelwgHBnc60hKg
         cx/efx58D3q/0Y46shTZWdxJwlrWA58J2HAvldvHzsFNnQchpZ5QHvCADjOKsFEnCGnw
         mmx/LI6kktW47w0kV0b3/mzW6zg817C4ek0v89QSiuFUoW847j2jpE3J64K7jxo66gdj
         WkYi/Q/uLdoJ0W00j6U/4ctRxO5rX2D8H3+0suT9Aciwgn22O5cs4UuZkdIL/pX71KXl
         dgPg==
X-Gm-Message-State: AOJu0YzKOtTuPsaNrDqK2FvBWMrE+PDUYpcWa+/5UYuVQPrpCKANSTqe
	WPBFQwe7u0D8k4xiP/goBKPtT0Ssmb9lz5fWdZeK/9z3g6MdAVViHIeWoLcS9X/g88F9eHfuv5S
	N
X-Google-Smtp-Source: AGHT+IEpqSsl++rfk1+CEHWhr8c9oyUyyL6jaX25l669XC3xLwKl86BtTsjs3IN8jI5Bla88QbQ4DA==
X-Received: by 2002:a05:6a00:1826:b0:70e:8f30:23e5 with SMTP id d2e1a72fcca58-70ece9fadd2mr7742896b3a.1.1722286243357;
        Mon, 29 Jul 2024 13:50:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ba2csm7454541b3a.93.2024.07.29.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:50:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 13:50:35 -0700
Subject: [PATCH 1/2] tools: Add riscv barrier implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-optimize_ring_buffer_read_riscv-v1-1-6bbc0f2434ee@rivosinc.com>
References: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
In-Reply-To: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722286240; l=2916;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=QKbLeMMF7mDpLciQBgmaXsS7vFL+LO6R6LtddSUAdz0=;
 b=DmS39ks98S5E4C7fyFQXUee4PXBbUbkym1O5X/y/kETBBNioDUh0xCScGEAxSYNTxY88MmkcI
 65hWlx6D9yrBKizG7yXcAyOKvEOsqOzs6Z0GU7bH+EeCeyfTRmJAsHQ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Many of the other architectures use their custom barrier implmentations.
Use the barrier code from the kernel sources to optimize barriers in
tools.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/arch/riscv/include/asm/barrier.h | 39 ++++++++++++++++++++++++++++++++++
 tools/arch/riscv/include/asm/fence.h   | 13 ++++++++++++
 tools/include/asm/barrier.h            |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
new file mode 100644
index 000000000000..6997f197086d
--- /dev/null
+++ b/tools/arch/riscv/include/asm/barrier.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copied from the kernel sources to tools/arch/riscv:
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2013 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ */
+
+#ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
+#define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
+
+#include <asm/fence.h>
+#include <linux/compiler.h>
+
+/* These barriers need to enforce ordering on both devices and memory. */
+#define mb()		RISCV_FENCE(iorw, iorw)
+#define rmb()		RISCV_FENCE(ir, ir)
+#define wmb()		RISCV_FENCE(ow, ow)
+
+/* These barriers do not need to enforce ordering on devices, just memory. */
+#define smp_mb()	RISCV_FENCE(rw, rw)
+#define smp_rmb()	RISCV_FENCE(r, r)
+#define smp_wmb()	RISCV_FENCE(w, w)
+
+#define smp_store_release(p, v)						\
+do {									\
+	RISCV_FENCE(rw, w);						\
+	WRITE_ONCE(*p, v);						\
+} while (0)
+
+#define smp_load_acquire(p)						\
+({									\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	RISCV_FENCE(r, rw);						\
+	___p1;								\
+})
+
+#endif /* _TOOLS_LINUX_ASM_RISCV_BARRIER_H */
diff --git a/tools/arch/riscv/include/asm/fence.h b/tools/arch/riscv/include/asm/fence.h
new file mode 100644
index 000000000000..37860e86771d
--- /dev/null
+++ b/tools/arch/riscv/include/asm/fence.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copied from the kernel sources to tools/arch/riscv:
+ */
+
+#ifndef _ASM_RISCV_FENCE_H
+#define _ASM_RISCV_FENCE_H
+
+#define RISCV_FENCE_ASM(p, s)		"\tfence " #p "," #s "\n"
+#define RISCV_FENCE(p, s) \
+	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
+
+#endif	/* _ASM_RISCV_FENCE_H */
diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 8d378c57cb01..0c21678ac5e6 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -8,6 +8,8 @@
 #include "../../arch/arm64/include/asm/barrier.h"
 #elif defined(__powerpc__)
 #include "../../arch/powerpc/include/asm/barrier.h"
+#elif defined(__riscv)
+#include "../../arch/riscv/include/asm/barrier.h"
 #elif defined(__s390__)
 #include "../../arch/s390/include/asm/barrier.h"
 #elif defined(__sh__)

-- 
2.44.0


