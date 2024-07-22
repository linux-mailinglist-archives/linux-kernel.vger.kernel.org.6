Return-Path: <linux-kernel+bounces-259425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F269395E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606B71F21EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6B83CCB;
	Mon, 22 Jul 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wAIV6Gh6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962D6A339
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685508; cv=none; b=gHNEiR6pYe3ono1amfWCwRvz+GKEXHFc6V5/UQ/wV9vOQXy8irLrlWWthJTGZyRRjKsWhC9WfrUL0m1kl/ZZl+o69NFI6xAfYGSR6XPDZdqdYrFk0cwRgnQ8kjfBSc9sWSUAVLGdGh90dLSpkvLfY0pbkdOwRSc9jvHSRXVYPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685508; c=relaxed/simple;
	bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaJmyCFRL0G7R7v0/VnU5eb9mMTjMCfDKc4zxvb5mJKSoTCsHHUrDFDLodmFDpX9dpydm1c8MNER5gQZzA4strsPZ2MXFA26C+yiiDT7/+s0PngyZqt1QzbLu12OZK4VAYwZgIb+Bhka0KGhMG+2xshE+uWoDlX/z93pLG8id/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wAIV6Gh6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5549788eso36622225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685506; x=1722290306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=wAIV6Gh6IyCg6aHC98bxC5muRWXa4ja0gHiWodDHiWRbrAsAohgjDdjhbbvNsAJ84o
         llRESt3buUyOsHyci1PmdnKTexTgTRgPYUcCf/glJvwKRSLH0YMNl8xrgGSYECaS8pC9
         3XHDapoTjPSTyTY3Rop1m+DSJ1IGiqslKR5CtnDYWCSC2Ca3/d8JVfNUWYtv1bpfrXQA
         p+hi2RSPotiTsfX9sz6fq8K+6b/Q22Gy6GhU/EkxC2+bsD0cHKs2b+k0YGnqJ+kwAZOR
         vBXE36B4VwTxixmscGtC0owxfTntrbmeWnt+xMxpAQvMJblCW0iYKwe7OUDxUrsbJc4+
         4Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685506; x=1722290306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7liFIbqG3XLVQtLXjuEuZ9H5FIup228+UAuRj2s502A=;
        b=Bl9hq0cpOaBnFS0qFLoknG9Oz1oBTPOh43ceUIZ83T8sIwGoCFg82MX/UP8Iaw2Zlj
         8scjOsCQgqcGSKEuD8L1LwRRnSAR8oib6P+2VxdVfehyDP0oWGunvvRwBwCPMwAkoSd4
         y1BKq4lzsTdLfZSzZ9tJRYR9ihuwhO71q0XNCDp0OcMrKY5P5nLhFU8eFly4gQaHRZDA
         nBwD8MR/ZnMWJXTMARx08kIx+XYjGq1i/dWshzZ4OI6VAqh9+ZyBUDT5OVJjL9rkbYPP
         iMP9Hbd9eRZhHdx8Bz5X5uFWUP5REceiKV7+Ci8FkHf/7uQdj5JIYVEPoLIp8+4RxVTd
         HnnA==
X-Forwarded-Encrypted: i=1; AJvYcCVSfjntOnKMNKaIDA1c92TmKILZR6k2Cc4B+yZmgs3UlXBSWPAXMzW0UmmLPPF7NBrgxxKKGrfplwVnmunY7Uv24Z3bsQe6Qm162n1P
X-Gm-Message-State: AOJu0YxWD4gQ082vQUcw5vt6QkvZIA+wlhKHpVDpNXWzrwbaryEMXXmB
	0Mu53RR1jlu+/AiCIvrAc410X+nYXTsCl0I9iQW0KwmAyA5/DL4XSFMiCQFJq6g=
X-Google-Smtp-Source: AGHT+IEhQYp1BZWLj9eFDI4F+59SR/8t3UUInGJ4gX5TJPVL1PbpSo7Q3rXHcGW/E8u/+YVve3sRYQ==
X-Received: by 2002:a17:903:18d:b0:1fd:9fd8:1b2f with SMTP id d9443c01a7336-1fd9fd82008mr51936315ad.8.1721685505924;
        Mon, 22 Jul 2024 14:58:25 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:25 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 22 Jul 2024 14:58:11 -0700
Subject: [PATCH v6 07/13] riscv: csr: Add CSR encodings for
 CSR_VXRM/CSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-xtheadvector-v6-7-c9af0130fa00@rivosinc.com>
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=1045;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/awdvkpT37Pcv9l+R6WHhK0Ytr8TrWH5wurC23dujZY=;
 b=HkA9GryhuoQSbrAEZ95j95Hqi2eIuaKpw8ZKsmN39SZQzbRBNWPE66zVFn20eiWNCV9omY0DH
 m+/5MZAQ7RODwQ/ViRBSsCcS8JUhXwkT+4tZRvwC/Z2ygfj/aiygn8J
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 3eeb07d73065..c0a60c4ed911 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,9 +300,14 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
-#define VCSR_VXRM_MASK			3
-#define VCSR_VXRM_SHIFT			1
-#define VCSR_VXSAT_MASK			1
+/* xtheadvector symbolic CSR names */
+#define CSR_VXSAT		0x9
+#define CSR_VXRM		0xa
+
+/* xtheadvector CSR masks */
+#define CSR_VXRM_MASK		3
+#define CSR_VXRM_SHIFT		1
+#define CSR_VXSAT_MASK		1
 
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150

-- 
2.44.0


