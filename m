Return-Path: <linux-kernel+bounces-257475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC58E937A95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C2B1F22AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816852231C;
	Fri, 19 Jul 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jiw9aIlM"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C00320E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405739; cv=none; b=NE7he+e37Ze2E9TOgH3CCekm2IFD+AJDUe6nhCbg9W6Mzlbeoxr9NQrbVbSg4dbXmhLzVT4w2P3RWpyY+EVPK7ZMAK30Kyk+VsM04AKn5e0sbcbyPltj/buR0Jy/l9/osJ8lSzD6Dz9poupXLViq/MNOhvc9nF4K1qSNlX7L+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405739; c=relaxed/simple;
	bh=T11RUDtdZrxQtRlAe10gZYbTABjz9NhpNEYG6ImKGDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jfbVGJZVx8PpqsYrt/oVQXOS3Q5CR5NWANqwYNWVY8oC+mtdpGCehkp/TgUzvH7ofAfsiKWl6kS6RUL/ojsC6wNREYjAjsOLkfVtpudpQazoamsPudiYd5vssGDpQNK+QroN+SQdMOrig37UrPJRxKR1PmIk8BsS6s9APLAzsKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jiw9aIlM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-75e7e110e89so1298884a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721405736; x=1722010536; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gu/A/EzVLKnX0kLY7e25xig89MWGfDHaNY+F522h6y8=;
        b=jiw9aIlMZjhS7rNUQIVrz7s7y9484L+yHXztFtORKiDABCi3obNYtKvJOQ0Mn/BaTJ
         bsen1MQbnH+tcCdbZBb2EU6I7cE/imQ4W0tjLHPKxX8Z4/pCVNRwpmqO2r3pr92KMvku
         JlWTKrcMwGnQ04GCm/dXx2taurXqxX7u3YRTuzTe43BdaSj2gM4oL5+9wvwHhZ2RuLc1
         ZXwmcLuYkqBMHPVWXOyX7BpnpGXb5lHrnbTEAKPyk3bA8wt0JqiqHm5X0f1ADcgaiwP9
         govrtwcP8E5Ry7esK5QBSW2QCbC/bvOoTElxVo6invZZe23Wd6KmHXkpQS4x19VOGCQB
         lGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405736; x=1722010536;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gu/A/EzVLKnX0kLY7e25xig89MWGfDHaNY+F522h6y8=;
        b=LhHVfk1KzVQGki0+diifl2RcODKCpszqXel8QukRA5MS0qLBSNmDDilNfKVIinG6Q6
         NaE30idm3W8vzmarcpkjrkTGRRKpj6Z4yWplKQn+tfn8X/dogpLizGBPamyrUyBFgscF
         VUylbfoquLH58cl3T+l80mbtFQY0F/UKdtJ0skWn9aRbyIYJuuWRgF7oyppP5Zsq3eth
         eNozEb7GVG16Ii4JVsIFonok0gAXDWZBGVd2z9uqX/fxpGsjayntBMo3b983ye7oliwI
         gFda33gPHKHKZ5gPW9WY3+5bv27ZBZUsXoLRarE5fj/JhSkx5Vb7x2iTIROFYCpXmJ7q
         OnJg==
X-Forwarded-Encrypted: i=1; AJvYcCX7SAD5ZrnWu/gK3405yodc2zfC6Qbzm8yLRbshqORbPlfqjt6RHMMhgwMndDWm0izZcbWNPf6ogTXbM7B5Xoh72pHtbzhfHTycbHxn
X-Gm-Message-State: AOJu0YxEXLrwoktIlIqmf9JOSI2KXzARTwA48UELv8KkxDUXOTOPJ30e
	ssAO51hT4WlZ5+XLLQOkl6j4kUqRWaCTkexQ3B0NKJcvHpzCNT0bXRyv0F7Mwxo=
X-Google-Smtp-Source: AGHT+IEgUUMEN1HusaJe9qHUVarUdtVNZbLhHSO6lGUy4RRuiPTCm31oa5fvNvfmg+Hszf/UGe8rYA==
X-Received: by 2002:a05:6a20:7495:b0:1c2:8904:14c2 with SMTP id adf61e73a8af0-1c42299d86bmr666535637.37.1721405736589;
        Fri, 19 Jul 2024 09:15:36 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ad73cc4sm579589a12.29.2024.07.19.09.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:15:35 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/4] riscv: Separate vendor extensions from standard
 extensions
Date: Fri, 19 Jul 2024 09:15:17 -0700
Message-Id: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWRmmYC/43NQQ6CMBCF4auYrq2ZFqrgynsYQ0o7yCxsSYsNh
 nB3CxsTF8blP8n7ZmYRA2Fk593MAiaK5F2OYr9jptfujpxsbiZBlqCE4vE5DD6MTUJnfWhwGtG
 to8i1rkBIwFIWwPJ+CNjRtNnXW+6e4ujDa3uVxHr9R02CA29BWatQn2xlL4GSj+TMwfgHW+EkP
 9gR6l+YzFity6ITnTVtW39hy7K8AeEP0PcSAQAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405734; l=3549;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=T11RUDtdZrxQtRlAe10gZYbTABjz9NhpNEYG6ImKGDo=;
 b=YvM9kd3OhQ5dtUus6JjV5CxJNsqvgUI1okaBNI9QJlEuXWV8kW1hmrx8FCnHiXN7zEdgcshu9
 Y7CG+SY0/UnANmLoJxkLgj2l8dWHDO8uvmFMETOlRa5c4Z5oUuYgzI0
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
To: Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Changes in v3:
- Rebase onto for-next as there have been a lot of upstream changes!
- Link to v2: https://lore.kernel.org/r/20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com

Changes in v2:
- Fixed issue in riscv_fill_vendor_ext_list() that initalizion was only
  happening properly for the first vendor. Add is_initialized field to
  riscv_isa_vendor_ext_data_list to allow intialization to be tracked on
  a per-vendor basis.
- Link to v1: https://lore.kernel.org/r/20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com

---
Charlie Jenkins (4):
      riscv: Extend cpufeature.c to detect vendor extensions
      riscv: Add vendor extensions to /proc/cpuinfo
      riscv: Introduce vendor variants of extension helpers
      riscv: cpufeature: Extract common elements from extension checking

 arch/riscv/Kconfig                               |   2 +
 arch/riscv/Kconfig.vendor                        |  19 +++
 arch/riscv/errata/andes/errata.c                 |   3 +
 arch/riscv/errata/sifive/errata.c                |   3 +
 arch/riscv/errata/thead/errata.c                 |   3 +
 arch/riscv/include/asm/cpufeature.h              | 103 ++++++++++------
 arch/riscv/include/asm/hwcap.h                   |  25 ++--
 arch/riscv/include/asm/vendor_extensions.h       | 104 +++++++++++++++++
 arch/riscv/include/asm/vendor_extensions/andes.h |  19 +++
 arch/riscv/kernel/Makefile                       |   2 +
 arch/riscv/kernel/cpu.c                          |  35 +++++-
 arch/riscv/kernel/cpufeature.c                   | 143 ++++++++++++++++-------
 arch/riscv/kernel/vendor_extensions.c            |  56 +++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |   3 +
 arch/riscv/kernel/vendor_extensions/andes.c      |  18 +++
 drivers/perf/riscv_pmu_sbi.c                     |  11 +-
 16 files changed, 456 insertions(+), 93 deletions(-)
---
base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
change-id: 20240515-support_vendor_extensions-aa80120e4230
-- 
- Charlie


