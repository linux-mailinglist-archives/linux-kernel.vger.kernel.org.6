Return-Path: <linux-kernel+bounces-261401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9D93B6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA591C23B84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1116F844;
	Wed, 24 Jul 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qYfacdvw"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC916F826
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846214; cv=none; b=GnrWUrCOlTDMaNQe2B0asQUbBc+dmC64s8sDU48YrMMC+e85p7qSZWep3xiua79hUmw35HDwtH9YbbdPmPoKSsXXnJBZTa/DQ/MNJuLD09zTsQZ3tsD4+UYRsyFzQ3jKxcZub+swYEpZFNY+cgvyN1naPKaxV7QJ6DJM4rXb8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846214; c=relaxed/simple;
	bh=a1/mTzZfYWixOKvw7hZJPsNckjOGKvrprzOVGR3f+AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbYZ0uXlJ5CYxjcfExINJT2twxT3rLK0gbZ8yReIjjW1aRlybeWdL6agZ/RMqUHpOsyfiR1k3gxAEmIMz05cw7JFXG/UBiiT3O8TYRm4ap2h3oKN8m3i5G+PDVLxgKxjYesyDIczN+mxqaxc2RFdJncqjfKM4Y5Qg1uZv0bcPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qYfacdvw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so864504a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721846213; x=1722451013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB5PDESy6Qo0Jcu13SGskHFDRhed/H4Oxxes6IQLnyg=;
        b=qYfacdvwxE87alPlFYRl6yItQaO4caMDifwmP+517389oqUxGCNsdUkE+8JSaN5+C3
         wvWGzt7C6TyJDszw1Vd2l8gBjNS+cBO9GXr1yL80nT0sRbc/iC34TW3h1NMBeNzOmFGE
         Cnjnp7oYXPvxfPiEggxyET+RR/PaKNniMPcOQ7H6I7obUHWBdQ5EGR+o3HG2zLe8ZO71
         1bn7dT3XsT4DXRkmCYA9rzt4yly0KkDGleP0QWqU3NoCPhM97UPffFaok4SZgFS4ohPQ
         TzR/9uHIKCMGSVjyeJh+C2KcBBt5T7UsGQ50auRHwDvizGB7cvo/q0lEUM0dGeJMhVcF
         DItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721846213; x=1722451013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB5PDESy6Qo0Jcu13SGskHFDRhed/H4Oxxes6IQLnyg=;
        b=SHhPlwFozHMoESLtYBCKfuxX7Q++1V/ufRGaXgS3Tp6ztRjAWx+ZnZvXu/nFv3Q3cO
         ywSFsq/kL6U5NOUUXxtWzwZ1djOH2KdmTuP7y1mczdA3AbbUXJVaTC+fngEqAvTJw238
         39lKd1X5hfzIbK8DkYGdRYikHPvmcgC71h5IcIK8RyyFzQ5yKy7uQUnBnMbK5pgO/rDQ
         z2+hN7V6pIHCQQl8vWrHfZBUw+lIhWRgNclXYsIj+ZWRMBNmHLosOQ+802cB94NWtJua
         oJ8G1Y8GonmYD7Q8hNEkqdE/pZMMSQ6GFrhDw1FBLNJFJY8dM9q9NYXt936Q5bImR+MX
         J3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU61P4KhQSMAHyDfCLs81MasrygUrEAh9V9Ydi/vIm3XH16Bs48nSI9VLYdEJkGL/W8IrxxspBlPkHjfXd2XUbLDGQucfTMvoaR8R6G
X-Gm-Message-State: AOJu0Yxfuzp+055xzCAq+pLNYNQsmFa5gQaA21UgIgj6/DOYO61uEPjF
	x/hqNFFayOBL/GovqdkthM1b4FvxRkl5wt+C/RGQHXichsKDM+QeyB/E/+KoFy0=
X-Google-Smtp-Source: AGHT+IFVaKgpzXil+XU1Q9k4O5zrYBjVM25TgY3w5TlHHmjl9+GYW2Lt07senY0UmNriHZYrgPG/Gw==
X-Received: by 2002:a17:90b:1b06:b0:2c2:d6ca:3960 with SMTP id 98e67ed59e1d1-2cf21f48eaamr801050a91.17.1721846212621;
        Wed, 24 Jul 2024 11:36:52 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a189esm1997830a91.2.2024.07.24.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:36:51 -0700 (PDT)
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
Subject: [PATCH v6 8/8] RISC-V: hwprobe: Document unaligned vector perf key
Date: Wed, 24 Jul 2024 14:36:05 -0400
Message-ID: <20240724183605.4038597-9-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724183605.4038597-1-jesse@rivosinc.com>
References: <20240724183605.4038597-1-jesse@rivosinc.com>
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
---
 Documentation/arch/riscv/hwprobe.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 78acd37b6477..f83a13dc4cbc 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -238,3 +238,19 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VECTOR_MISALIGNED_PERF`: An enum value describing the
+     performance of misaligned vector accesses on the selected set of processors.
+
+  * :c:macro:`RISCV_HWPROBE_VECTOR_MISALIGNED_UNKNOWN`: The performance of misaligned
+    vector accesses is unknown.
+
+  * :c:macro:`RISCV_HWPROBE_VECTOR_MISALIGNED_SLOW`: 32-bit misaligned accesses using vector
+    registers are slower than the equivalent quantity of byte accesses via vector registers.
+    Misaligned accesses may be supported directly in hardware, or trapped and emulated by software.
+
+  * :c:macro:`RISCV_HWPROBE_VECTOR_MISALIGNED_FAST`: 32-bit misaligned accesses using vector
+    registers are faster than the equivalent quantity of byte accesses via vector registers.
+
+  * :c:macro:`RISCV_HWPROBE_VECTOR_MISALIGNED_UNSUPPORTED`: Misaligned vector accesses are
+    not supported at all and will generate a misaligned address fault.
-- 
2.45.2


