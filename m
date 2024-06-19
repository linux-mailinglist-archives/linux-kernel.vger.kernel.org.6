Return-Path: <linux-kernel+bounces-221369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9B90F28A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15F2B22B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741215921D;
	Wed, 19 Jun 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OljYsPa/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB2158A2F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811677; cv=none; b=HRctCULrqWUaTKGUyg+45Aj8KyLons+/VXAyY+BhAqM3BDUx0Q00uarAFm+fcH77m5hKDb6NyHXn+wyUoHhBv18eNKnMn4Ei29snjJtsv5bvPVe/lKAKQ4d+jJYjecrHJnrsgKep9NPZwY10MVl07XR5bixYpxafg0J6TWZ/mMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811677; c=relaxed/simple;
	bh=7H3ZZ/U/d5MGGck8wALvbGs4PxOtO2VkSs85+KZ1HfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfUmpxB6Z7mlyCOGcNZQngE2KpBEco2xOI/UjpyzdK1VXxxdreKoT+3ECyRQ2L85ibiItZmN0Xedl5Aj3ObKEkQnho7UaQ2Qz4a/Q4e0XuW6IOzybVGMELu7voyX3gW3wNF4KqF9cRvwui/L+T/UuBidlmbxbu529uxZ5UUaA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OljYsPa/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42479dece93so336175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718811674; x=1719416474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPY+3E4dBoFlMa6qj3x8QVsLE7eX+roIHLt6ynEnu2U=;
        b=OljYsPa/SDvi/ATMKcTp2LDXb7/rH4BLAZhBzlGl75Lnz0PJmgSpgdytGQb8wHdbNA
         64qhKqWfr6iHWEFD/iLu2PU5ZaYfqtsYgSl1HbtcIPtV2e5WzwpWx1hjH+wrGtgADRFh
         Y3i2dyLGnmbSwqUFysXUIsLZ2jgLIiIez2LShYrfGLA44ctvwfgjx+e4qtzi71scO4cy
         DYAyoBTEkBVYAvT65PMf3HQkwkZ//2UbRQszXdHLMm0LnkhZPNScRyCe6nEnTqGhwaON
         nH4rw/COVLXFJKoffe6SYV2i7gNzkZy/yCFk38dKDIDjGyBBJRvdxSuflBWSuFN5U+qy
         vQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811674; x=1719416474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPY+3E4dBoFlMa6qj3x8QVsLE7eX+roIHLt6ynEnu2U=;
        b=pYVtshGj4RE9/0CvOH6R1sL3ZEOKeu00372NYfuCHy+BAOyiaocgh/tIT4RisptOKt
         kzMBzuicE8ed8Hae1jEFP7xhM3sgOJVT/tTb4KI4Vt0isvzK/s5PDJ0RQtrt/6m3icle
         B+5jwULZ8r18Pi88oeOPFKs8irTORktJJjkPF4vJ8WKOKqbqni5NzGcViEpA224VWVOs
         5FNhF8yZLJ0CNcYbNZDqiMxybaj9CAjbUSprNVd6yTyiQYagkgdH6wRCw6vTdHinN8Fu
         /efP/cMggqd9e0jKvYl8TgJnZ+WJNa/SX5MoaK7TlziqpLfO1imsmNv5LglqVIXwUpng
         amHg==
X-Forwarded-Encrypted: i=1; AJvYcCV7cZAeW5G1PInX4nAG0PJeN+5k6rm5H3ULaKAlJklDf53hSen2f861eYLxV7oQbKwsPkJOIkpBbQjs2wLaX5qMz8s0tKqtBpV4bo+2
X-Gm-Message-State: AOJu0YxEd/MSeQvK88FccXsjB93ZsMm7zth7SDU+4S66T7WjbmfaU9In
	Eo+jlYYs/LyurwmPNb2QCahuMZq2AAdNVlF7hINkyMu00/pgLUyoZ9JvCxZVt30=
X-Google-Smtp-Source: AGHT+IHEyMK/ITgXlMXOhDLGJETYUb24IsTevTAqgLrmuWFBKFkU3n8nX5A972+nIAwKJBmfBumqAA==
X-Received: by 2002:a5d:5f93:0:b0:35f:2929:846e with SMTP id ffacd0b85a97d-363171e28demr2732165f8f.1.1718811673916;
        Wed, 19 Jun 2024 08:41:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:819d:b9d2:9c2:3b7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c785sm17392292f8f.34.2024.06.19.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:41:13 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] riscv: hwprobe: export Zaamo and Zalrsc extensions
Date: Wed, 19 Jun 2024 17:39:10 +0200
Message-ID: <20240619153913.867263-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619153913.867263-1-cleger@rivosinc.com>
References: <20240619153913.867263-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export the Zaamo and Zalrsc extensions to userspace using hwprobe.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 8 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 25d783be2878..6836a789a9b1 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -235,6 +235,14 @@ The following keys are defined:
        supported as defined in the RISC-V ISA manual starting from commit
        c732a4f39a4 ("Zcmop is ratified/1.0").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZAAMO`: The Zaamo extension is supported as
+       defined in the in the RISC-V ISA manual starting from commit e87412e621f1
+       ("integrate Zaamo and Zalrsc text (#1304)").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZALRSC`: The Zalrsc extension is supported as
+       defined in the in the RISC-V ISA manual starting from commit e87412e621f1
+       ("integrate Zaamo and Zalrsc text (#1304)").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 920fc6a586c9..52cd161e9a94 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -71,6 +71,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 45)
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
+#define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 49)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 3d1aa13a0bb2..e09f1bc3af17 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -116,6 +116,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
+		EXT_KEY(ZAAMO);
+		EXT_KEY(ZALRSC);
 
 		/*
 		 * All the following extensions must depend on the kernel
-- 
2.45.2


