Return-Path: <linux-kernel+bounces-203215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6838FD7F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5C2894AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08515F311;
	Wed,  5 Jun 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SrPdoyMx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8629AF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621022; cv=none; b=o1xW3mfvxOSK1gDAfZPHL7v57f2ZXcum1grrtuCmRCDKF1QUT0ed05GOTtfBgnW7N8HaMJ3wPtAkqmtWl8OQALsv06BuRRaLew28089pDV5HSe0xsfzwbx85KE1iHc5BUBHZWgGP3J/ivqfV2j0WCZFiRnGzCcvkbwU+KVW0KfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621022; c=relaxed/simple;
	bh=TaGElk/hpAq3VO9VslRc+/HRzTC0o9ENFqw8n9czgjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IY/9rltPYQuYrqpy2C4qPFwu/qt2lfugS2GpIuvghE31N534WbRvOg+GLKyiiWe/BpEGdiKoV657FY7VxBIHwVEySf6YR+v+r3PESfm1xHR28x48G1j1Cu/LZBLBMm7IFa+wIf8DYjCX5T0Wl09cS5XKbffZsBwEiaK9FfT0pXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SrPdoyMx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f62fae8c1aso2301115ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717621020; x=1718225820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSwHeh/cECdPEg7QzwSf8DHXKuWQgQmqUDB+TvkoQ5g=;
        b=SrPdoyMxm9nzsaOUitjGRh4P/NBnex1Rqd/c0XJpzredS7/OkVvzGkYr5IMBXjL5YU
         DjfXv34tPgd16PRQojsg4+JuJAVtWp3Z7nqpsz9qWfoCacN5td5LdxJBLiH4g+oxYbgP
         vztjybwEU/T4eY4p1nVWqQshQJ7V9foG8ZoOUr9TLHRfGUJ50Xu7O2vQAIpNaQzLyWUG
         TX+F8cBDL4eBZWaUNVogkLDbY83hJ+ZHSH1glE+IiwS4kx4AQVmaC7Oo1nJ6y9TN/DQ+
         9dzIr5yU34qeEta+280thn611gjcuF0nGYdkBtUdJjU1M5CI6nv6GDx4ADFitAyHnEId
         zM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621020; x=1718225820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSwHeh/cECdPEg7QzwSf8DHXKuWQgQmqUDB+TvkoQ5g=;
        b=WM04w4JD+SbkzHXwuxBhfuHqHGUj6ZyZkZo2F90n3YJ0Xr2RnwxwVohAGYGbsvaVOI
         jGR0dyZeDRn05WLO2rIS6nbbjHrqTogvHkiP/kiRd41UKBZtUmBU3+G2tuOYo2DBczUS
         cwoh3got6iSMFyfL8o8AF3a2wunda9TvMshN6s9yeYA6wUUppO1ZJQNnl2NeXZTNi4nF
         3Hrwuv/gytpFB+JNk5vfmdYuXsi35BR1Nl4KQJzXoJN9nLwZyCnVOQO831BN1Z6Q79gu
         Zt5oD9MEwNHYQ9/UfHfUBPvrVejXw31plMKRkhBm9EbI3WVscpHzxIbc0vUO2QA/ckkt
         A3yw==
X-Forwarded-Encrypted: i=1; AJvYcCUHjhtwwHyPRLbhiDrMgPUFA18XHASEwfe9i2a8fwcsge1U+fCFNhIxk85Vu7ODfrh8iPU7a/K3sspeWri0YGhrEe723wHi/EyZQJ3p
X-Gm-Message-State: AOJu0YyEVguAc5weC5X+khTdsnqzprUwKHbFDLuI9qH0E3X8evEximEW
	Vdo82ZfDkqo9XaZJv3/R88APnIBGrliJuHCuFN5pBLiGmRovrDagIZyaEDAi7/U=
X-Google-Smtp-Source: AGHT+IGePo3BDC0qz3V3MiLBGg319aXXwMiH9g1VClqu15DTduRfVwhFhsVi7a+ByKzjEQ4pwP0uKA==
X-Received: by 2002:a17:902:e811:b0:1f6:6900:5946 with SMTP id d9443c01a7336-1f6a5a7b559mr39401645ad.66.1717621020437;
        Wed, 05 Jun 2024 13:57:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd86esm107332135ad.121.2024.06.05.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:56:59 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/3] riscv: Per-thread envcfg CSR support
Date: Wed,  5 Jun 2024 13:56:44 -0700
Message-ID: <20240605205658.184399-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series (or equivalent) is a prerequisite for both user-mode pointer
masking and CFI support, as those are per-thread features are controlled
by fields in the envcfg CSR. These patches are based on v1 of the
pointer masking series[1], with significant input from both Deepak and
Andrew. By sending this as a separate series, hopefully we can converge
on a single implementation of this functionality.

[1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/


Samuel Holland (3):
  riscv: Enable cbo.zero only when all harts support Zicboz
  riscv: Add support for per-thread envcfg CSR values
  riscv: Call riscv_user_isa_enable() only on the boot hart

 arch/riscv/include/asm/cpufeature.h |  2 +-
 arch/riscv/include/asm/processor.h  |  1 +
 arch/riscv/include/asm/switch_to.h  |  8 ++++++++
 arch/riscv/kernel/cpufeature.c      | 13 +++++++++----
 arch/riscv/kernel/smpboot.c         |  2 --
 arch/riscv/kernel/suspend.c         |  4 ++--
 6 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.44.1


