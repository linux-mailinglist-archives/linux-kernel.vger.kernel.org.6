Return-Path: <linux-kernel+bounces-383312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD90A9B19FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7331C21154
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315B1D2B2C;
	Sat, 26 Oct 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NtdrJK/c"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52213B286
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962886; cv=none; b=gkZNicEZyKBPlFYY/LJ6xaIPHtxY1jIkdhXOHPdmZFmfHd+gwO8HHLovkrQJZDonWpvCuTbfhmuAMYpKXkwpWmZhaSWl1lr2+9wj4HYo40KAf2VS93W08jKR2uNGCSB2gHuPrFXduwEk/doayZ0iOvQu0QXb5cn3XXl13E/QbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962886; c=relaxed/simple;
	bh=Do4hRNjdtiV2ybwrDLhoo1d7VhlKUWIRUDdxd8ugKlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJEWIDrqAWNb9PyjOTlvin8ZL09Q/DteCh/MunIcGEfy9MoVqjmJtaH78GxYHbR2egJv8wWhv19mK5T3TdMxZlR5P8y5Rwtcw1kUbM56qh1AXA+DM0pMon6oLhVeRwj9Osa3HwGlZ3VNpAoNLKHJfGVuPwEu8HlmDbqipFMZpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NtdrJK/c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so2842244a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962884; x=1730567684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOSsQUnotfJnWx8MDy5AXFl+d4FZ5vHx7jUPt4EEd+s=;
        b=NtdrJK/cIv1UBzB63i73f5AEQS1dxPq+9DTgv21IloLd7Ny8LPASC81MQOvfbS176U
         cVVP3CUuxVjGBalchbl1NlRy8O6NUcDHsel1b9NcUN/wEznaUjallhdpeXLiKtz0/VjU
         blTCVQQsOOvYTP71SLeYBvPFblnsv1UGWOA1xMt+6jj3fyEvDcpiJrfypXw716CFiUqq
         kHNO2aWznPTMdu7VmtPmmxAPcCTSrMxdB4MI5OE+71hQ3xfK6a3n2Na59IHMdrcnSU53
         jILWESaSJX8TSqEpkpa6GX+L5yrULVJBjIK8KSZhjXyrjKQfZ1Fs/9MZHv/3krHbZCNa
         UStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962884; x=1730567684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOSsQUnotfJnWx8MDy5AXFl+d4FZ5vHx7jUPt4EEd+s=;
        b=cQMP6WI3Y8OLswX+2PNXQd7RXw0adByYpxTGLGK1DuKiRmfXJEc6TITMgPH61VD/SY
         wbqenVPhJWFSqixmhL1rHAbeWNKoR8MX/Z8yv2XPtC0DjNY0ffc2e0NmVfyxm2EE1BeF
         3NCw6AlEpKIw6J4hJ1Ha2hBMlNbDixzsafoKYxcfxxw59gpKZe2gt9g9aEYmIyT/wxdU
         DotLXhjVjX2yy6IRaRkZglXG1Dn3TJXqXjEWNFo2tmHmRBIvQY5LX2L6SUDBD+gDXJvk
         0qeI4hXlkJwXGgr0HmTuL39ctXHvFOpR7fM5ULjFVw7bz5ydFzEH4CvLJceDbcL8uiDw
         DhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZjj9Bm+o7joJC35c9laq4SRtx2nK1Ld8jbSWkDCUDdXJzzJ0tv6Rg39JT/b7+VdD/RGfcUCIwXuH765Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwUYDUWaxyiUsgUgPx//CCUhFM92I3oqBj/YdAuH/HSIGFmtj
	kGSUxpip6e9A0RoZVtC5NGmq71rkpkLseSXk+MCMrvfC2+gjkjQoI0OY5GhEwnE=
X-Google-Smtp-Source: AGHT+IE35+CPcVp7ILkzpFktpBD+b2eWjLqpOh7Yq/Lpl307CKcwxHI8L/rwX592Dxjn9xzY6ItOrQ==
X-Received: by 2002:a17:90a:7846:b0:2d8:85fc:464c with SMTP id 98e67ed59e1d1-2e77e605026mr14994919a91.11.1729962884162;
        Sat, 26 Oct 2024 10:14:44 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:43 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/6] riscv: Relocatable NOMMU kernels
Date: Sat, 26 Oct 2024 10:13:52 -0700
Message-ID: <20241026171441.3047904-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, RISC-V NOMMU kernels are linked at CONFIG_PAGE_OFFSET, and
since they are not relocatable, must be loaded at this address as well.
CONFIG_PAGE_OFFSET is not a user-visible Kconfig option, so its value is
not obvious, and users must patch the kernel source if they want to load
it at a different address.

Make NOMMU kernels more portable by making them relocatable by default.
This allows a single kernel binary to work when loaded at any address.


Samuel Holland (6):
  riscv: Remove duplicate CONFIG_PAGE_OFFSET definition
  riscv: Allow NOMMU kernels to access all of RAM
  riscv: Support CONFIG_RELOCATABLE on NOMMU
  asm-generic: Always define Elf_Rel and Elf_Rela
  riscv: Support CONFIG_RELOCATABLE on riscv32
  riscv: Remove CONFIG_PAGE_OFFSET

 arch/riscv/Kconfig               | 10 +---
 arch/riscv/Makefile              |  1 -
 arch/riscv/include/asm/page.h    | 27 ++++-----
 arch/riscv/include/asm/pgtable.h |  6 +-
 arch/riscv/mm/init.c             | 97 ++++++++++++++++----------------
 include/asm-generic/module.h     |  8 ---
 6 files changed, 68 insertions(+), 81 deletions(-)

-- 
2.45.1


