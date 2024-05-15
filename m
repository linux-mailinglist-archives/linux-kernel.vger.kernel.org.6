Return-Path: <linux-kernel+bounces-180383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A544D8C6DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49291C221E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB715B541;
	Wed, 15 May 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fnpNW8x8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BB1FC4
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808391; cv=none; b=DotXaCuamZENGTcgizpLn7a/WaPgTnI5k3aHtNcSqLrrRoxMOqkW5QABJV6He2CKtp4IqGI1+PuDKheSxL4gWbGGtvy7uWoVfFdUM+SJ0yGsY/El7Xb5omDUxk6oVS9My5Z2+CrZzhrQEh13QuSsnOVXBK7aXF3MZEIIo2m2Gno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808391; c=relaxed/simple;
	bh=KgtJDY4MmMjQZ2oDl1XlntkBINAq3AfwA6pN/nCVnCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qHsPJxvRGnomUBA/B3TYcn4R+DPKHJ2vnin+3uwMmL63VQjyx+vwJ+gX6sCnh7vD6wNOI6bmbCqjIR6YkD1sCaDPW6MPlad67hC4dQo6Bs0k6iwrAiCR4vhCN1MnBcB4EsA91V1j17pxpHndmoq4+RMC9OtagRAofr3+Lo71dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fnpNW8x8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f472d550cbso5965308b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715808388; x=1716413188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XbT7INwutGKZuD03WNtDt+9MBwCLATnSj4l3KyTbIE=;
        b=fnpNW8x8Y/mDcZA9fCL1giWtRP4LoKPJNgsXJThPnWv+qFWpFqiy7mnqXs5YNRjLK9
         imEW0r7ofJx0epyH2/RcA78ek+/P3EDH99pdBZusynFD8rAa/krdTVyc72VttW/+2uWJ
         z1wJ8pqB+y1JDdp6JUIl3t12c9LJPkCfLDvLNHjOWIwhrsIV34we8POd7SZc7FEI1EsL
         1xRg5FGRFDUdnrQTQ+QvxLFNC0gDGF3UklxlJaqq4lHaiOlJbYpN8F4rQ2KXC28Nmz2a
         cLmWhN5hXDj5ffLmKLrzE6O2VKuCfUCf+iKs4R+NYQGEFFinHfHYwPxNluG8/LlB+xLK
         k16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808388; x=1716413188;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XbT7INwutGKZuD03WNtDt+9MBwCLATnSj4l3KyTbIE=;
        b=XQs7n5YKVug3QJOf3xmN5DsUwOiaNYJm1qt+Gv6xPLajybam6LAy3LktkEdzGCv2hE
         hSW07RzUjVxxxuqlhudNdes4o6np4Y4+yRrx0FMOUQPZiZatjvw3eZYwwVKLJ06v8lIn
         tl56koZi/WOy0ec7atVAeRz009UFCVgsjzGf+FcAylBzgt9r+Ai3aS9IZWyfO60C3+a+
         QYL4ZZPDfI1PrMw2M+l35jr2o8MaoTuwWgI3eA8nwIgrd7EUMwe+0YVIBnlC47E5qsOx
         +Gnjt0lKx1KFdMOXXI1saoAS5TUTjYWl1giFpYxatbu9+IZB002pHwchGY+NARXG9u5a
         ZDSw==
X-Forwarded-Encrypted: i=1; AJvYcCVD+IEtfCFISrhmfGvxKci0SwdVb3jhnCc8CVA0W3EbfQEVW4WZJBTLMfC2aO3/IcR4FSYyEsTWBLwxmXF1LYjI/Og2eGIVWfBfKctO
X-Gm-Message-State: AOJu0YznxfuXy3Ma84CRCUUCfvTKr9rzg/a7rcPs76ArHN052IUovc/R
	ivBmoOaEV9hv1BlTego8Zt2aK4GL7NQs3V1IGKv1kcbYYpmoELyJw44l215qwsc=
X-Google-Smtp-Source: AGHT+IHCAPxdikYmujdZmy8dZ7oFs1KG2bKARYuL/xs52ASQFKHNbJ9CgqCWeRa/YbLbE0ZSup5txQ==
X-Received: by 2002:a05:6a00:2e8f:b0:6f4:bbba:1155 with SMTP id d2e1a72fcca58-6f4e029a21emr27755612b3a.3.1715808388378;
        Wed, 15 May 2024 14:26:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b30sm11970243b3a.146.2024.05.15.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:26:27 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/4] riscv: Separate vendor extensions from standard
 extensions
Date: Wed, 15 May 2024 14:26:12 -0700
Message-Id: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUoRWYC/x3MQQqDMBBG4avIrA1MUoXSq5Qiof7qbJIwoyKId
 zft8i2+d5JBBUav5iTFLiY51fBtQ98lphlOxtoUOHTc+97ZVkrWddiRxqwDjhXph8zF+GQfGF1
 4MFVfFJMc//f7c103bFmr7msAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715808387; l=3345;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=KgtJDY4MmMjQZ2oDl1XlntkBINAq3AfwA6pN/nCVnCQ=;
 b=AxcTBgTejyl75LE7zsplxZGT/C+vsiy+w5Marj3ZYgRQqiAw+EW+/tLQzQtaZ5A3LuVAEm4gU
 A6nqJX4xQAIBW4XHMWfOS5R96bGTC14zKzpldrvZJ/sYSfMIvanIxKJ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

All extensions, both standard and vendor, live in one struct
"riscv_isa_ext". There is currently one vendor extension, xandespmu, but
it is likely that more vendor extensions will be added to the kernel in
the future. As more vendor extensions (and standard extensions) are
added, riscv_isa_ext will become more bloated with a mix of vendor and
standard extensions.

This also allows each vendor to be conditionally enabled through
Kconfig.

---
This has been split out from the previous series that contained the
addition of xtheadvector due to lack of reviews. The xtheadvector
support will be posted again separately from this.

The reviewed-bys on "riscv: Extend cpufeature.c to detect vendor extensions"
and "riscv: Introduce vendor variants of extension helpers" have been
dropped in this series. The majority of the code is the same in these
patches, but thead-specific code is swapped out with andes-specific
code. The changes are minimal, but I decided to drop the reviews in case
I inadvertently introduced issues.

The alternative patching code from "riscv: Introduce vendor variants of
extension helpers" has been migrated to "riscv: Extend cpufeature.c to
detect vendor extensions" such that the andes patching still works in
that patch.

I also fix a bug in this patch from the previous series that the Andes
extensions were not being properly enabled due to the manual alternative
patching not incrementing the id to be greater than
RISCV_VENDOR_EXT_ALTERNATIVES_BASE. 

To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Conor Dooley <conor.dooley@microchip.com>
To: Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Charlie Jenkins (4):
      riscv: Extend cpufeature.c to detect vendor extensions
      riscv: Add vendor extensions to /proc/cpuinfo
      riscv: Introduce vendor variants of extension helpers
      riscv: cpufeature: Extract common elements from extension checking

 arch/riscv/Kconfig                               |   2 +
 arch/riscv/Kconfig.vendor                        |  19 ++++
 arch/riscv/errata/andes/errata.c                 |   3 +
 arch/riscv/errata/sifive/errata.c                |   3 +
 arch/riscv/errata/thead/errata.c                 |   3 +
 arch/riscv/include/asm/cpufeature.h              |  96 ++++++++++------
 arch/riscv/include/asm/hwcap.h                   |   1 -
 arch/riscv/include/asm/vendor_extensions.h       | 103 +++++++++++++++++
 arch/riscv/include/asm/vendor_extensions/andes.h |  19 ++++
 arch/riscv/kernel/Makefile                       |   2 +
 arch/riscv/kernel/cpu.c                          |  35 +++++-
 arch/riscv/kernel/cpufeature.c                   | 135 +++++++++++++++++------
 arch/riscv/kernel/vendor_extensions.c            |  56 ++++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |   3 +
 arch/riscv/kernel/vendor_extensions/andes.c      |  18 +++
 drivers/perf/riscv_pmu_sbi.c                     |  11 +-
 16 files changed, 435 insertions(+), 74 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240515-support_vendor_extensions-aa80120e4230
-- 
- Charlie


