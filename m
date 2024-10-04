Return-Path: <linux-kernel+bounces-350476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277439905BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21CC1F2163F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE86156F53;
	Fri,  4 Oct 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e3LuZGVT"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53743215F66
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051314; cv=none; b=hJd+yvi0R110jXXuQGb9h1ev8ZBsgWEY09bi8xLYcgzcljzDEMJTboAsStjWUD6JzKjymgTcPrex81JeyBg56o7txvl72JLzLqdGTflzzYjwH83c1tgiT1dKiLCMnKwCTXSenI0t8xFdQCZjPojYBCbm4WFuyRt4VFMoIX4mI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051314; c=relaxed/simple;
	bh=56/buuxUUwV96uAJ5cGhSg+gwr+hwgYmMymPHvGD+6c=;
	h=Date:Subject:CC:From:To:Message-ID; b=eZnGnEH3PKbwIuGU8m5fBJiCUjIENpR9njGJSaK8rBEKwir7iEsxy9Rtv/O3Bewrqzd19dOjPxIQK8WbrgvYmpXN2BlBHn3fWiM2CJPaKcgjm9uwHKzKW2y3Xiju1BBl4jtf4Gd89/GsPxlY8+d22AKdec6/6wubobngmZoqSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e3LuZGVT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71def715ebdso155035b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728051311; x=1728656111; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+q94Vokd3rjGpferr7kuhuwd/CnBEQ9OwvfEy9PEcw=;
        b=e3LuZGVTjwA03R1na/cUJFSOCbSRZtdeVWnTQxw22FaN6mqs6S87tkanR28S5Y9uD6
         lDMK+RjsuZE6v8i6jy9eO5Kt6UPdvqwmkLMi726DcvlKgDtJ5ZDfv3V6/FpDr0A/I/KX
         8/gwO72Lp3gq2FOMFgIGNE0nq4CiG4q+YQb9ELmdjg1kc4SWYScX0zC9lIbx+iXZMBVc
         uK1yt5MXor2g1m45bMITeoXlKNJg4/GFZ+UemBE1d7ysfSdbJFeiRlnOx0K7pwehqPGY
         dHDnbSmsbh5dF9VLgSzmYdb/ddXtaTgzvBGzKcnMIJsZqsO14pQOD00q5qJWDbivbaeg
         2WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051311; x=1728656111;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+q94Vokd3rjGpferr7kuhuwd/CnBEQ9OwvfEy9PEcw=;
        b=VWl5SSjHE67kcgVASjnpKOvrWD+3YIqn1/Vc0VaSPTcbATGDJt3jAZE0qwaC/LmRkq
         Kr35VskgQoGdfwXo8cTisTogVXZdQJ0d1lEyUVtSLU9YM5o8KqrTxtILRLm2mTuYmv9G
         w7PwiE2S9JjC/aFor5v6YC1B37Bq0y/ozNJHv/FJEGYjtsOyWHpYrTR7AwFPzRBMyP3Z
         j6OWPGNl43vQt4MjnBF0JVz4CXQ5C4whECf8qXgOBJpHDiNiypXNVsjiOrbgKPAT9Hr0
         Kedc9544B5EJV0ZiU6rFSUSAYJS25KxDCVtBkoI5ESkn8XxjabcxnlKQ4jJ7XV0MuQuo
         I14A==
X-Forwarded-Encrypted: i=1; AJvYcCWDG2SJ+7HpbqYkXSF7enplAoNyRk6A68k4e3TGtmrCUk603Wz9g9EloY/8Jg0xqftvfvUFbvsBuqWmQCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0Wr048qQGM3N6yYBFUFeRpA8Tspk8FVCTIA07p0F7YKswF8i
	DIWygRpaqOQZixtUCnFY7odhjVHWIe53ShMci+nKv9gbn7FXtyRL0vM/WbqziLHoVp4LVFORR8i
	c
X-Google-Smtp-Source: AGHT+IHSG0E+V26Pki2i9IHRaE836zN3/sOY9stDA2Qd5Yl2hUM6tTRVgGNAo8tJT8Zkx9iyB7Do8Q==
X-Received: by 2002:a05:6a00:1312:b0:714:1bcf:3d93 with SMTP id d2e1a72fcca58-71de239d3e3mr4429615b3a.5.1728051311550;
        Fri, 04 Oct 2024 07:15:11 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb5da23sm2182238a12.85.2024.10.04.07.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:15:11 -0700 (PDT)
Date: Fri, 04 Oct 2024 07:15:11 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2024 07:15:04 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.12-rc2
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-06f4491c-e8d5-4713-9342-3470d90d42e7@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-rc2

for you to fetch changes up to cfb10de18538e383dbc4f3ce7f477ce49287ff3d:

  riscv: Fix kernel stack size when KASAN is enabled (2024-10-01 13:08:11 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.12-rc2

* PERF_TYPE_BREAKPOINT now returns -EOPNOTSUPP instead of -ENOENT, which
  aligns to other ports and is a saner value.
* The KASAN-related stack size increasing logic has been moved to a
  C header, to avoid dependency issues.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix kernel stack size when KASAN is enabled

Pu Lehui (1):
      drivers/perf: riscv: Align errno for unsupported perf event

 arch/riscv/Kconfig                   | 3 +--
 arch/riscv/include/asm/thread_info.h | 7 ++++++-
 drivers/perf/riscv_pmu_legacy.c      | 4 ++--
 drivers/perf/riscv_pmu_sbi.c         | 4 ++--
 4 files changed, 11 insertions(+), 7 deletions(-)

