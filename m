Return-Path: <linux-kernel+bounces-384234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E69B28A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374B1B21BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD918FDC9;
	Mon, 28 Oct 2024 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXSyhIrN"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798611917DE;
	Mon, 28 Oct 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099901; cv=none; b=M2FRqQ0P4CY0/ji6R0A4hv+ujk/98Nx2v2AJkCh2oN8WcnhgT2QJ4+WhSNqTqn7S4fk0e+BEUF7sBKb8Ak6zrA4cZMWpRdOqvfWITD+C0Tkka3A3O/re1pl0IIIoufRChKRmHe8IHUhuTV0iLdhVoQesM5cIq3XOyDIDwSn3pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099901; c=relaxed/simple;
	bh=oOXwulWu7DHoLTysca4CnqlqJ0RQXfR+t0fEwS1LUus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8xky5EkjzdSFLZtBFXeQIepotIUEITu3dSZtBM9RAKgFdr5TGHb1ORmTHTXYnktfnSxWlawy9+a+i/FAZq/ncTI//v2SQ1kl7o4Sq2k7kyB1gn1hLDV5xUeycZp9h1iTTcLUhXRTOsP52zwojfAQ8cw90RNpEiweJLRDvOstfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXSyhIrN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c803787abso30437935ad.0;
        Mon, 28 Oct 2024 00:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730099899; x=1730704699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAmlP3w7cbuw4vs2LRWu6ikJXLe5vZx2U9ot0QY3nzg=;
        b=lXSyhIrNrcrw6YfO6Vme38JKjklDbrdu5C9DSWiWH0zEVSDUiG7JxdPRvwevgvpFHL
         oez/mfen8RfSv9aQM6Jbb/mncuKBh5xPsQvBS/Qk/hpDJgT2tWgPO78BF3yfPOcg/Zjt
         ro4xL+6nfVhHgyNDcceDxtCoH1Q4+JfA5Fl/2E0DVmqsGp3MLXGIcI26mHJMlK+3+y4w
         r2QVF728Vts60x6spbA/apWzJsENpq0NvM5Tt578tDDANVYMKiLjmsN7K1j1htRvGmc5
         /R342EqCrfvVwKMpxGokuF92shpdKf2BtOxQ9wlmm1L0dhoaKdxKiLvLVaEHvHfInQvR
         b41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099899; x=1730704699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAmlP3w7cbuw4vs2LRWu6ikJXLe5vZx2U9ot0QY3nzg=;
        b=suKBzDAS646hIBCdVANpEoQli8bGF9K4liO+FhE0ksdsKirR4r85KnG+FkmwtvwdBV
         B99ym8JF6nIABqPCPjJiet6bF8ihRHIjKlOGogoVzIy3cS5xDYXCuh/EvNY1G0MxRmgn
         qFPqi4B3s4bh+hu7d7zsHQHTYqn1JO0aQ9tjXAnxQ7xaPlfnkxQZCshfEQ3b4icdRwX1
         ASFHq5YjABU6sg6dEW3d83AARv6erxCoNCoC6wcsSYJ8ttgEcyLQmz6OBYEsYWS30DYu
         vEruC5ZbAqO+iQ0rpGKHmyTcnYNAALxmZ6g01VTus1Hc+spOdzE+ylmrFrEVGNPxzsTF
         pnUw==
X-Forwarded-Encrypted: i=1; AJvYcCUezZfZf/CBfB0fdEJZuIYqiQPqNfrw0zaM7yFKPisruwk+4URzsX6jYNwJfePm0MH7G8ZlIA+W5awo@vger.kernel.org, AJvYcCXT1ZZN9W1ZbhaoY9dhFGUtX05hIgZWK3qcV0Gx44kSE9esWDmT/t2q7T/BcsdaakcV/OGv0KzFM+AxdsGu@vger.kernel.org
X-Gm-Message-State: AOJu0YycMKiskiUdLmTJKt9ufkInYhcp4ZaZ4CgRNIMMsMNLTJjC43oH
	RRMvwTB77hMpZyakrEXPY2LsCCW6kEaJKpSRhw66Wprc4xK2IOwb
X-Google-Smtp-Source: AGHT+IEUoa5ZbRgyUDvT5sSSexEjNU5hWJ5BN3DtO5DSUyaxLGN5Xl3CDpjSkdhit0QPMLIFVQ49lQ==
X-Received: by 2002:a17:902:ced2:b0:20b:5aeb:9b8 with SMTP id d9443c01a7336-210c5a7154bmr120474645ad.24.1730099898614;
        Mon, 28 Oct 2024 00:18:18 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf44550sm45265605ad.14.2024.10.28.00.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:18:18 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] riscv: hwprobe: export bfloat16 ISA extension
Date: Mon, 28 Oct 2024 15:17:43 +0800
Message-ID: <20241028071746.869740-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028071746.869740-1-inochiama@gmail.com>
References: <20241028071746.869740-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 85b709257918..8c30dd06f3c0 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -239,6 +239,18 @@ The following keys are defined:
        ratified in commit 98918c844281 ("Merge pull request #1217 from
        riscv/zawrs") of riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 1e153cda57db..95d00a065b4e 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,9 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 51)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
-- 
2.47.0


