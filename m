Return-Path: <linux-kernel+bounces-255531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89BF9341D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFAE283BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB36182A6C;
	Wed, 17 Jul 2024 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f3vmhvEu"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B61822E1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239656; cv=none; b=EvcE3wsPcSiaLNE33kcEwIYs5EZrMoPkR1LP9ItEp6KOu3U7tonDRCdMlqb5PXaot610RFSjcn4Y9VrdQW4U6Br6Lv2/B5qg//SBPG1xWRu864gV9GcfmK+v7rEQFNRJ7o7hXgoLPkYC10o9wOjG8U3fiGHt8QKpeovLzzkvIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239656; c=relaxed/simple;
	bh=cX/HYhhasEuFJwnG1YqRdIVoDeWNBrAYfRpYXvHUq88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+b+LJl/73r2NuwDA9xopd6nh6NaTrw1CJVI2zTkEbG6hmjVP2QwWTfbYzpHiyU69dgkba5oLcm15eUEYC7Wdb8t4WSlN95LA//PDlFSHJUzyhxJw3hfxDluIW1nGGAFNr47+17nQNbajikjo/hPEGPIOJ7mZLOi/4qTK7oh7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f3vmhvEu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so868307b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721239653; x=1721844453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+q85MMx8ReifEh26OnOcH4ON5TNG8DhWzEzhvIX3E4=;
        b=f3vmhvEuV9hZ6eBRfW81eq0kOEX31ItFTX5n3XPMXakB7a46CBwjfxB6tHWkZMBmw2
         xUpZw1m0IImnBkTPoanIy3Davd7AFJJzdkcpf6MwIoQGa3AH530ZVTrCG2QZbCCGH0SX
         xfs8LL6hTGaZ0XdkAJr9QFNNKzooOEaEhwydAji/jOQfUtzPLDcdqQj30TGWFDllnktn
         4eSJtHChCENFjlI6FJSW3CuiJ4xc/igjps9mk6SX9daQyiM8Akc+d/ZLBNB5tJCztPat
         d15kxn8/xZy9p874S0aqPsHiCATn1Y9sAg+9BF4Kcax/klN2OvdJrQPRCw6K/KuIy2vu
         MAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239653; x=1721844453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+q85MMx8ReifEh26OnOcH4ON5TNG8DhWzEzhvIX3E4=;
        b=CDPCJa6iCvdLEDZIi7OlBwN16or5b3NPLAA/MAn4BwXQn+e0KX8lUDrC4gtfWt9A37
         iNf4x+/JMLUtd+MTUPSBfcQgHS0VrJj6SaGnbztqswq9gpJK4oySH6yyqNUnucGh0OT1
         UwuUc1+6Diywu+z68+I4gi1W97HktMHwHOz8XdrwGFVDdUbTHB4OwuIElnOjhXDHDazm
         x12kM+PA7I0Q8/wcMuBpQhLHXRCru2tJZpiCtknSXt3P0gAl3TQeOrKIjf3e0BGEhWer
         E2CRst4T0cpMfYKhrYQP080E6aXiSKCInIFxpeAgqjvkyJV+MGeUtfyOa3FtQF755suh
         o43w==
X-Forwarded-Encrypted: i=1; AJvYcCXvpe8QtYmW3TnOC/OoWoG2NF/nfluQrURpjIODbtLU6pGcvBk8j4PO+6et5EFwW16foLtE2ALqQoFJbrm74m2FrhvAv4Yf20VSGo5q
X-Gm-Message-State: AOJu0Yzz+7BpJ7xnYgzBbhlmuVUuMkQFvKg5ijZUnP8Q7hj8sqKjKkTX
	+C4Fp9dQEX77Z5/McPHsrI6nJivyQhKUkClGUcLhQCkEIJDqshCV7pP89rgmNpg=
X-Google-Smtp-Source: AGHT+IEM7NbPBiq56WjI7wp5uxcZnnktec6blz44hAygeP3ZH/gozFqg+Zse6oBeox6vYNKlbyAg5Q==
X-Received: by 2002:a05:6a21:329f:b0:1c3:b20d:ac33 with SMTP id adf61e73a8af0-1c4077ba37emr758100637.3.1721239653262;
        Wed, 17 Jul 2024 11:07:33 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c969sm8432332b3a.35.2024.07.17.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:07:32 -0700 (PDT)
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
Subject: [PATCH v5 0/7] RISC-V: Detect and report speed of unaligned vector accesses
Date: Wed, 17 Jul 2024 14:07:20 -0400
Message-ID: <20240717180727.4180475-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for detecting and reporting the speed of unaligned vector
accesses on RISC-V CPUs. Adds vec_misaligned_speed key to the hwprobe
adds Zicclsm to cpufeature and fixes the check for scalar unaligned
emulated all CPUs. The vec_misaligned_speed key keeps the same format
as the scalar unaligned access speed key.

This set does not emulate unaligned vector accesses on CPUs that do not
support them. Only reports if userspace can run them and speed of
unaligned vector accesses if supported.

The Zicclsm is patches are no longer related to this set.

Jesse Taube (7):
  RISC-V: Add Zicclsm to cpufeature and hwprobe
  dt-bindings: riscv: Add Zicclsm ISA extension description.
  RISC-V: Check scalar unaligned access on all CPUs
  RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
  RISC-V: Detect unaligned vector accesses supported
  RISC-V: Report vector unaligned access speed hwprobe
  RISC-V: hwprobe: Document unaligned vector perf key

 Documentation/arch/riscv/hwprobe.rst          |  21 +++
 .../devicetree/bindings/riscv/extensions.yaml |   7 +
 arch/riscv/Kconfig                            |  57 ++++++-
 arch/riscv/include/asm/cpufeature.h           |   7 +-
 arch/riscv/include/asm/entry-common.h         |  11 --
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/hwprobe.h              |   2 +-
 arch/riscv/include/asm/vector.h               |   2 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   6 +
 arch/riscv/kernel/Makefile                    |   3 +-
 arch/riscv/kernel/copy-unaligned.h            |   5 +
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/fpu.S                       |   4 +-
 arch/riscv/kernel/sys_hwprobe.c               |  42 +++++
 arch/riscv/kernel/traps_misaligned.c          | 134 ++++++++++++++--
 arch/riscv/kernel/unaligned_access_speed.c    | 148 +++++++++++++++++-
 arch/riscv/kernel/vec-copy-unaligned.S        |  58 +++++++
 arch/riscv/kernel/vector.c                    |   2 +-
 18 files changed, 473 insertions(+), 38 deletions(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

-- 
2.45.2


