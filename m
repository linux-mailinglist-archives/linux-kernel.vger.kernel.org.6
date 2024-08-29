Return-Path: <linux-kernel+bounces-305973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E031963746
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8051C2239B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290BF3FB9F;
	Thu, 29 Aug 2024 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eOoTGU+a"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775E4E1CA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893329; cv=none; b=B/ZSwP8DrLHhR6mVoOdG/jSJlZTkh0mmT6wpJTBk9/HquCXaF9ppcjx9FDjgJP16tGgHH4Z0V2bNBErhAu5di3jUeAHQ+yCIliVQ7Mh/0Zyc2+6OcCNamL5/jx/h6nFk6p6X4/LVIGQ/FiD60BRvlh4B4AOwaT/ObFJIUMB8vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893329; c=relaxed/simple;
	bh=+scFAUbZj8sK364kS3132r0hQe6Ylfl4c9kSHDThWLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7VxV/faovwxhXe8LF3G8gO4TZrX8IQilfXYR6AvHrIifhxyJSrjdyMk5ssyWxS+OniHUYWo5YQ66udehwVn5QhBmoCUx0ejcpue1yuRJjoSfupBGWBctHS3Gx9fr7cAx4B6VReA06CXwfmFu343KHNEUWPDI6xisp+bbBkUJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eOoTGU+a; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714226888dfso128414b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893327; x=1725498127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fidSIArz80o0wKmWpcFbdk3lLWLuSUf3Uv0hxlg4FbY=;
        b=eOoTGU+alQFtXtQ+WPkMf6NIk8WCPDB5VtQK5YtuXH8CpdEjDXE0x7hIEQl2ohoJDO
         LU77iaPGwZm9D7XP7pQAsE/n2Y17bWXtwGVDaZ4aGO2txwlVJm7QBO6So8HHjw+OqEfd
         NoBLYc0fKLh26TiP+8nCIURnUcyAy78nIaJhf4ErSCJAJfT0V0BPZMvoYjiMAJZmfaMV
         mYjx4qtSmO8t8cdE4hFb1beY1/pJxWSPauW44M8Vctkx/KnSliKhwuuVoLZ7JKlFSONc
         0Lcnys9SmleYqi09FaPL1k6F9YL2eGVKiUQOteIXTjAbC+BnRF51Eb6mBGi/q2NbQub0
         EFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893327; x=1725498127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fidSIArz80o0wKmWpcFbdk3lLWLuSUf3Uv0hxlg4FbY=;
        b=MSa8uMagM+28wEP/KDxNvYj2mUIWAniq14V2TT8k2hf8pu/HN+21DjvMdpzrnIydtJ
         x12u23HrIq3/vMrW/FVKeBRIyX90JjAgz+MWMvHjhll34CrSp4r7zJiDybVTXF8xZqx8
         eIgNcZpb1k4x2v3HNodtqIoopJvyVhBvsBTqHq170zzm79Gu6CUVoah44jp5IfuYLtIx
         mTURUX/d6zcvs4VKUkRxn8BBcE3rXpD1SDxczMMg3inP8aBaiJny/zcUEFNKs+cQAOo4
         Cc8geBkVHkuT10Afm8JWrm47l00DdSDbhQaV2uT2ZcHkRdfXpWbJIU82sDn4Cau9FbQE
         JGWA==
X-Forwarded-Encrypted: i=1; AJvYcCVePxNWgj07hdFWRvS/vFEGqznZQ3O+llJR2N9FLjUjtyc33/RKuIm1kOHFtjVACiI1MjfdXVhNfFno0dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKcpOIpO/6sGgBiS2d3guofY/ooFWbRJ+v3n3R7LJj1qG2dvd
	iSNfGdi2i9PakNdz7erN5qOMZoLVNLDv/y8A+3o0HAO5icmbtpENS8V58mtP1Bg=
X-Google-Smtp-Source: AGHT+IEBNQtiCiCgVLUJ84PQe0m7uIiW6abUHQVzRmj5lhZHlZn1YYt8QBg0ustTrLy0CYAITZNs+Q==
X-Received: by 2002:a05:6a00:198d:b0:714:21f0:c799 with SMTP id d2e1a72fcca58-715dfb26b96mr1439189b3a.12.1724893327118;
        Wed, 28 Aug 2024 18:02:07 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:02:06 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 08/10] riscv: hwprobe: Export the Supm ISA extension
Date: Wed, 28 Aug 2024 18:01:30 -0700
Message-ID: <20240829010151.2813377-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240829010151.2813377-1-samuel.holland@sifive.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supm is a virtual ISA extension defined in the RISC-V Pointer Masking
specification, which indicates that pointer masking is available in
U-mode. It can be provided by either Smnpm or Ssnpm, depending on which
mode the kernel runs in. Userspace should not care about this
distinction, so export Supm instead of either underlying extension.

Hide the extension if the kernel was compiled without support for the
pointer masking prctl() interface.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..a6d725b9d138 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -239,6 +239,9 @@ The following keys are defined:
        ratified in commit 98918c844281 ("Merge pull request #1217 from
        riscv/zawrs") of riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
+       defined in version 1.0.0-rc2 of the RISC-V Pointer Masking manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index b706c8e47b02..6fdaefa62e14 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8d1b5c35d2a7..b6497dc0e7f1 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -150,6 +150,9 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZFH);
 			EXT_KEY(ZFHMIN);
 		}
+
+		if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
+			EXT_KEY(SUPM);
 #undef EXT_KEY
 	}
 
-- 
2.45.1


