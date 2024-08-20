Return-Path: <linux-kernel+bounces-294244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C7E958B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1162830E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF3196D9E;
	Tue, 20 Aug 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vE4hmdCw"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4A195B08
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167497; cv=none; b=aWs4/UWGH6lx+UIOpgR1Wav36RKtfp0E6rCAM/Rl+Tt0mqqTEX4MUpj3DoafJdASlglYBqm6YWPXry41cALPmxAkA7lBpMZryunB36TLi+owyXMRlLb9E1qL5jIFE46pmT8E3pzd3QqQP/j5XD8WjF4eqQkZjveWL8u4o09+G24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167497; c=relaxed/simple;
	bh=5IrSzO4NK/egoPWEpij4VPue9Dvq4+IjNrpVVyKy6PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH3OCeGVasjQRFC9iRlZ4zLmJvlqSXkjYq75N9znsWcDsiy0kBer4OaKGQ77GWHDkOb8e/3c8UMKjbrktoyik+sPY0B6jjqHk3eUQK3zu7xAqT3zxHY2a7GHe5AWHyH+x0CtnrzTqfZ0rhfT2gmuks9w9G2TRW8h34B+oQqDv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vE4hmdCw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so3912600a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724167496; x=1724772296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9yIy6nc3JckPfgq1SVS1dt/ubbPwao76sjUpFJbUU0=;
        b=vE4hmdCw6asCkj/eoSUDZyyql82iSLSrYE4zYJZZIfB30hIweA1oom04xEUSd4RgMI
         6nG1SBqpcyY5Aatcrwkmx00UIJdn8ckGJorSmOKxhX9QZW4Ic7hIslvLgxBd2U5pLmga
         3LpQoLsdMMzx/PXEwcU4zAtKy2IvYsCgWiRPYf5OSwP8zLOx6GWhB7b4uFecemYwFUHx
         In+urh3VA558N+DdSA0pvoMUktpUG+84SJ1lLJTvODK+LLncTsKCCGJVX7yq1swiqV6I
         kL/6ZwfyRkKM/cKmeZWp6JXLQYHEHbJBGCcqiTpxvkazNyrLpjEpQecctFFEhM+qbgYR
         rjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167496; x=1724772296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9yIy6nc3JckPfgq1SVS1dt/ubbPwao76sjUpFJbUU0=;
        b=JTEPqIvfzJgk/pkk+C4v5fD8A8HsGZsa/8sNC96diS73DCA4qii3jGExT0Jp+iyu3O
         gBIWZK/btoYT0fQ/40P8vp1KtKt2Mz3kQaiw3SDf0YUkTFMP85Feua/cGsKSOu94xiwU
         Kwbzj5qhgbSks51K9BQs2zvvksdG/lXXo/+OLe7pm3ZNcX9AaAH4vyx39uciWcy55US9
         xNH3bz6k/wBhzvPlgN69fUaHn/Ki3u9rrGBM/v6VGY18FRiPkCaaa6ezlii+gzatf8fR
         je2A5n++eZ6CHIUz7xqp2obP8AnwAID86Sxx4XUuDVzp3NCyZ95DnXr/QMs34YNAtnGD
         Unfg==
X-Forwarded-Encrypted: i=1; AJvYcCV14x6mrF35IvJu5GMEQtmxLJl9SWsJOqBEuKW3FYw+UsniPrE30xQk2Y+NBIH61qf6GSq+NMq22p1TBbh13IxjGx1/c31viyQMIkrm
X-Gm-Message-State: AOJu0YyK4O+WR/prb5oXGXYBoadthK+AqMD2AXnMshU/W1jEc8cbBxFb
	NpxwOXvJCjSCej2bM1hHBSPLvXuYGbV35wIiMCL9PBuOq7nI2OOQv4r1UXu8THOfuiPN/juRsGl
	D
X-Google-Smtp-Source: AGHT+IFjpFHeANOi3RNiE4tvCPPb8ENoVMI5hfDn6rIWfrZrc5je7gBHKyKa1cngmecZurzkCscwrA==
X-Received: by 2002:a17:90a:1bcf:b0:2ca:f39c:8d76 with SMTP id 98e67ed59e1d1-2d3e03e8cb9mr14580242a91.39.1724167495634;
        Tue, 20 Aug 2024 08:24:55 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d40bea7cb3sm7258157a91.25.2024.08.20.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:24:55 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v9 6/6] RISC-V: hwprobe: Document unaligned vector perf key
Date: Tue, 20 Aug 2024 11:24:24 -0400
Message-ID: <20240820152424.1973078-7-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820152424.1973078-1-jesse@rivosinc.com>
References: <20240820152424.1973078-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document key for reporting the speed of unaligned vector accesses.
The descriptions are the same as the scalar equivalent values.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
V1 -> V2:
  - New patch
V2 -> V3:
 - Specify access width
V3 -> V4:
 - Clarify we're talking about byte accesses using vector registers
 - Spell out _VECTOR_ in macros
V4 -> V5:
 - No changes
V5 -> V6:
 - No changes
V6 -> V7:
 - No changes
V7 -> V8:
 - Rebase onto fixes
 - s/RISCV_HWPROBE_VECTOR_MISALIGNED/RISCV_HWPROBE_MISALIGNED_VECTOR/g
V8 -> V9:
 - No changes
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
2.45.2


