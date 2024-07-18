Return-Path: <linux-kernel+bounces-255811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1E934579
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E2283350
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31272AE95;
	Thu, 18 Jul 2024 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eZQkTRmf"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB328DA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263714; cv=none; b=VO0dhLsMdEz5pqbVFH2v0LDNf/YJTSevoCyf2qQFA2pqfop7Xafr/5KQOBkj1gZ33zG40NWL5KNZJGpoPydgo/48Y0oV+wZee2uDFT5oqqlmm48kcLVecQzCQfqZvpe+g+e2qVB6knwBbgHkuUV2u2D8AX256n3ajI5YQXUZm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263714; c=relaxed/simple;
	bh=mVpAMZOxZRaMygvRVPZ0YfDxNCfQDT4Eh/pn82L2cnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y78YUdkJN/mPF1eDmC+fVuaa0gpM9ay8mFbwrQuJBNxejaVgzZpS7pM4UJtI/VjGIxbr64oqfRXI/xVQAUfWc9bPJ4JrgqWg7MEYlz/hrNrz0eMWzF3/siavt0ijhYWtvfKDbcv50NVM14Kx1tgcdbmJ/woMIfncaro5x1gdedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eZQkTRmf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d6301e7279so185972b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721263691; x=1721868491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yO8u7feQtTPE3PCvQPR4qbXkbE2vIT4Wuff8+z2M0YI=;
        b=eZQkTRmf2nnWiXS9jzLUpuS6Dnpz7OXW5j6acZfLKk2Pp4v6W6Ctw2Mble3Ol5Eda3
         NpqAtoq4SW6pxhe4/h6bGqthwlvhb77vphwZi1uVHnkiiRXOUxSV77Zz1lkjt1DFBIBb
         94EEEMnLVtG402048wI1vPxwHzFf8To/RU33Qm9J2/3FKSgEPPEM14yz+7czj28joOzf
         CxW0DPc5qIt1A5fKkkgf1F/5p9WNnrQkE0eCKJa5KBTf6kRELCa7Hi9MFqPtvd7nbDhV
         3Q2mk964w+y5/EdXhfaq8o9EeJR6yqvm/hdlQf00R58J5zRntYMYNmTuX9aFellB72hK
         hS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263691; x=1721868491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yO8u7feQtTPE3PCvQPR4qbXkbE2vIT4Wuff8+z2M0YI=;
        b=kSGNMC2aV7NeIQhGMpfDWs4N/WQ0sgdCmGNo0J9aLNOZysiczCao4vmf1TuIRFk4G/
         Ttdbtz84BtJD/MA0h3AAzELMjJI13DRImhDXWJ4BRDuitPy8hmhEFdVqkYsVB3o38rjw
         kOvbWICoABqP9SalNT43utXvSQybWQuqkhhhUNkp8Oxb88qFL4A0wjbDP7+z42FngoT+
         q+a2L3/OlIwAyWGekUXa/9oa9UZNsgTdcScLgBooKIar/+R/WRauE2v6QWPrrxnbalkB
         YObLNJ94by6Ym/dqZYSiUhcsc/CER1Ft5BYhzuk3S7HBEnRCjz76xCD2qwsArwa5BEHG
         e/yA==
X-Forwarded-Encrypted: i=1; AJvYcCWGZwVX8Qw5Ruy3Lte6LfBziIGUjToIbT0f6S0VVMt8AFJ/7ewKgzjSWdEvAdocz65HuluhxNPgFgVsoSGXOk48yRkARRAC5iYu6h5g
X-Gm-Message-State: AOJu0YwSM7CAPa+YCwmmzJE8YLe5UMyQ+O5T97zUeBpj+eAgHwtF3VSU
	IFq7NJzJoKLZqDKYti9EZ+IdiM3WKFLjA9BCtJoPTGC3VpSWDDJ98zg2h0KqfdY=
X-Google-Smtp-Source: AGHT+IG8Db+vpjTLP5x2kBGQGwCa7A9kOBQT1MH6jTIi/txDh7CI6c9ITvdZY9lwnA4eek8sZRMj8w==
X-Received: by 2002:a05:6808:152c:b0:3d9:33d0:cc4b with SMTP id 5614622812f47-3dad1e3eca4mr3653854b6e.0.1721263691639;
        Wed, 17 Jul 2024 17:48:11 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e386d53e4sm5694300a12.70.2024.07.17.17.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:48:11 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Guo Ren <guoren@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v3 0/3] riscv: Per-thread envcfg CSR support
Date: Wed, 17 Jul 2024 17:47:53 -0700
Message-ID: <20240718004808.2246354-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series (or equivalent) is a prerequisite for both user-mode pointer
masking and CFI support, as both of those are per-thread features and
are controlled by fields in the envcfg CSR. These patches are based on
v1 of the pointer masking series[1], with significant input from both
Deepak and Andrew.

[1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/

Changes in v3:
 - Rebase on riscv/for-next
 - Drop use of __initdata due to conflicts with cpufeature.c refactoring

Changes in v2:
 - Rebase on riscv/for-next

Samuel Holland (3):
  riscv: Enable cbo.zero only when all harts support Zicboz
  riscv: Add support for per-thread envcfg CSR values
  riscv: Call riscv_user_isa_enable() only on the boot hart

 arch/riscv/include/asm/cpufeature.h |  2 +-
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/include/asm/switch_to.h  |  8 ++++++++
 arch/riscv/kernel/cpufeature.c      | 11 ++++++++---
 arch/riscv/kernel/smpboot.c         |  2 --
 arch/riscv/kernel/suspend.c         |  4 ++--
 6 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.45.1


