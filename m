Return-Path: <linux-kernel+bounces-370466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642859A2D09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966581C25057
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CB21D2A8;
	Thu, 17 Oct 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f+LyG9dW"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962D21D168
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191648; cv=none; b=X6mYQvGb81nziVbCqJScjuoUB1f8D6GxrEb5Mooss4OdZ8A4/iJR9Eq6mT0aUUESW5w9EXZXiwwn1jOa3xHba8vKIiBNAeHq5axLbWSYADBiZDe3i0FssIBZrqnq4sjQSIfe7IJG0V7F7DdGg+oU8Tm9n9RezhHXhSdGUeBUA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191648; c=relaxed/simple;
	bh=yH/Uly+RdC0wHVkXtLDoac+Dmr964WzdjVCGi++JTeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fc0bs96G3BNphIX/psZjQcCL/ydvq8ZrU9G9tl5oRUggg5XnW8tOw4iiJnebJiEfqwV+FkJsjyPWFkla03XPiFniGDTcPnqMqhaNI4hUqZkmgPIqRvbWsafLaKlLjshn9NCGbBo62yTVmZIuHvFXIV3HSiZvqcqCpI5b94qAkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f+LyG9dW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so972759a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729191642; x=1729796442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPAVzZvGNC+Cq6OJdsBvlbMk1hqGCWfC5CF15zw1LQ4=;
        b=f+LyG9dWQGenGq9M4qdfnCAho4BTRh7D3OFjoKlxqKjLRfek5hSV9iEDBXg8+A4EJW
         7iFJeY2w9qlqIXRl251UCXdXWjv9AW1MFypJCW1hiCpkvHkkIXr+JJ1fAIQv79eoaMKq
         H9bByFvvCJdf7tlkBqZIPn61JFNX9gxqy8yBbeQfcDG29tTpZ5gPtvpWgRzAdQSxS6vT
         PPCyzXx0rHdiWrObpu1SfA9Z8aF2bifE8ZOW3KkW76C0ik9UP+vZlGEdnYRZbKag+MHO
         39EF2CLcVi4qOY5jcgzE0Gzq1zd/KHT46J2xZOSgRRloq7yDrxofQFGxVseGWHoC0Zt6
         p0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191642; x=1729796442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPAVzZvGNC+Cq6OJdsBvlbMk1hqGCWfC5CF15zw1LQ4=;
        b=ThyR4C/34mmbLU9W0XijMnbHvN3ryoYIIqNGjVuNKTb8pE8N0SS2IAXFOQRvx90JaU
         90oFWelRQfoFZmT+L1rgKLuQ/qsmhKx8f3QSQIgxHQTEppXnYxMJk4pgiLJCyVO+f52Y
         MTzElUfa76ifzqQvA6UE6UT4Uijcz27hB8jAe46B8Jow4fKWQxx+vu3sAZPAIF8fZF5N
         Jg1kx1GuJbXW8ThUtlrxrQmzqj/C9MNJnipvQsMUhefTlGiJdfrf4YZumPT1yrdgyZRz
         n2jJncuiY7f37ga5Y7p4jwJzlWWHJMieh2FHzcpRHgccfYLaUgiUWMqeDy8F4k+SUHav
         aKaA==
X-Forwarded-Encrypted: i=1; AJvYcCVBjsh+D9B1bc3SoF21XsVB0ezMYqeCCg9mR7S1Rnnp95tpWVvLXuEGSWegRHn9H0NwhdRf1fjQ0UXVWn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOyjKQudsKtCOPk1BEy/e2y2LE4XkP1Co8jzjemeHY9jpm5VDb
	G8bIKBwhHPXyllOKti9XyGy5NXDmevV8e2dMkWcRUVLxX7sjb+HyuWvBdqJh2tQf/lYrjEYAce7
	x
X-Google-Smtp-Source: AGHT+IFD1K8hfsHUiXmeZVKeW3p91vhUvYABl1u9xDphtGLBC6BeVBFQofI8bMkXBvRW+A2mzRSPUg==
X-Received: by 2002:a17:90a:4585:b0:2e2:b922:48a with SMTP id 98e67ed59e1d1-2e3152eb165mr23708976a91.18.1729191642337;
        Thu, 17 Oct 2024 12:00:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7bf9a8sm217766a91.13.2024.10.17.12.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:00:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 17 Oct 2024 12:00:23 -0700
Subject: [PATCH v10 6/6] RISC-V: hwprobe: Document unaligned vector perf
 key
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-jesse_unaligned_vector-v10-6-5b33500160f8@rivosinc.com>
References: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
In-Reply-To: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=/YcsX6Aye3XfW3dwDX4ZxhR2Fq2M2Cb82ITWD1NVBc4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pg3Lm/exUD3h5QadOSa7lsvbWryzJP+451LBOPRnu9h
 ezD1ZM6SlkYxDgYZMUUWXiuNTC33tEvOypaNgFmDisTyBAGLk4BmMixfob/Ybvvu7JPbPxxakkK
 52NZoaVP+WYuZD43/8YZ27u1G2b7NzH8YnZ3CrKSLvI3Fp8iuH/Xu22zq1/tEQpnjWl99cPU7PR
 yRgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

From: Jesse Taube <jesse@rivosinc.com>

Document key for reporting the speed of unaligned vector accesses.
The descriptions are the same as the scalar equivalent values.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 85b709257918..ea4e0b9c73e7 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -274,3 +274,19 @@ The following keys are defined:
   represent the highest userspace virtual address usable.
 
 * :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF`: An enum value describing the
+     performance of misaligned vector accesses on the selected set of processors.
+
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN`: The performance of misaligned
+    vector accesses is unknown.
+
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW`: 32-bit misaligned accesses using vector
+    registers are slower than the equivalent quantity of byte accesses via vector registers.
+    Misaligned accesses may be supported directly in hardware, or trapped and emulated by software.
+
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_FAST`: 32-bit misaligned accesses using vector
+    registers are faster than the equivalent quantity of byte accesses via vector registers.
+
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED`: Misaligned vector accesses are
+    not supported at all and will generate a misaligned address fault.

-- 
2.45.0


