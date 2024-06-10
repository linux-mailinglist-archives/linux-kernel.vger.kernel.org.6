Return-Path: <linux-kernel+bounces-207619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D09019C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505EC1F21D04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B11AD5A;
	Mon, 10 Jun 2024 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WPKiQxrU"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0857F9F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994062; cv=none; b=grG2YRCKcqy6YTR/lp/xAefJWqQPZsHSaN7LCJ+oS4NHJyC9a65hcI3jkntdYr7dhDnVdbgClpjzrkiu3Mxkcx/tB9KN3k+wr9mzSZN6I4n4OMvutB++QC0K/HVrA3XnYv2+I8sCqySp4fs9Ug/rgNtAVs1QVIv4RH7gP+teVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994062; c=relaxed/simple;
	bh=/afvdwdS5T+JmlJvh4qFW+jrHrs9DRIpURfuaIzUh48=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HUwZk/OVTVat3dU43x+TR6BnuyF1iF9gIdsn7nZgcanomLqEiRWysieiRTcGFtrDmvrBT5vIovwWcCa7id4fHIIrTaXtQkc+t4kF8wUNwjxOWL6uqKvdbO9yUiSKYvZksp/OGE5vjTlIfm2SoRpVl1Y5gWIPuphzPDNKyi4HfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WPKiQxrU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70436ac8882so543783b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994059; x=1718598859; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr3eTbiGcT0MgumDiK+9BwQOfWnwY8ez4n4N4g+wa1Y=;
        b=WPKiQxrUGZ8HEJV3OAhPHURlUl4HnYEk+PHRxqFF1UZEm9yaDYwqf2yZqRFJOVS1mm
         CtHteistJkRcPIoMNsKHSoF3dKiSpper2eo7SX24gyrFC5aCh0mwUtmlhfmjqD8C/qjd
         0AFVq/uct4Nv0nh6clUjcp23LUTjjmDQbIdh2CDCfK5EvRzXrfpFRs5ztqDwIcLb/p38
         C9mFQpD9+9Lvx8g79tcDX7I/qgkI05FgSzq51j/Eal7amcRoAtmlvUGHA5h4drm7OQvl
         mSysEdBMMOWqkwslMvb/Evzev9gJQLEm0S1DLbzALUpssiUVp8qAM5GXUZp6ozjFbw9U
         qFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994059; x=1718598859;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr3eTbiGcT0MgumDiK+9BwQOfWnwY8ez4n4N4g+wa1Y=;
        b=nIuWS5PRpPiSr7LdOzsVcS1qp0AFySq2HLUrPrF3MgveU+dhsIJIpAM9jpeulu+Voz
         aQhvDHmHSDplFH7KM+MPhGWQXBi/4Zs8J3dSmpgQU4kMj5KKtm7DPavyuM3EPok8eVzX
         zf4mfXrFEe8YDQwBFR3My6/ofZMYOFu65oDO/ZYAmVS70UNjOBbrlWF9yBoZxLIrptYr
         mwa87P7mR0iFneo6sMqAa7OnrYYEVcuBJCO6/dKkT0SZflBJPw/pLAR+Y6SCTQeG8/Rj
         6wlSAiyhFCvXd2m9HTJu5fqyiefcV9tyGLqCLRlLYum2zNLlfyCeRNs8ZvhbMVgQfoqw
         duwg==
X-Forwarded-Encrypted: i=1; AJvYcCXHCGv45wwbdBvErktYIxoXNZ2YLldK9uPgqQfGH/3CZ9U+5A7jwJqKOUn6FnkFgNA35Kl7u4Ni82FoGHKX/Ii3T8H8fbLMN8PS2ju/
X-Gm-Message-State: AOJu0YzMmDfWmt8QhmZj6XZ+t+TtKxON8gj6V9zEVJiGTJLLUK2sUEVw
	alSTVXxqqZHdPRIYq9kW7KwRcL902EX2kB/Fch1ulF2JH2xBZkTFGkRQISd3MR4=
X-Google-Smtp-Source: AGHT+IHq6A+UIx3IEQBSKTe7GgL5CzygT7cxfhkVnFAgZMvsLgLzmjkayawaDxFpTlt1bDFrNXhHtQ==
X-Received: by 2002:a05:6a20:4307:b0:1b6:db6c:11dd with SMTP id adf61e73a8af0-1b6db6c1300mr2423830637.9.1717994058870;
        Sun, 09 Jun 2024 21:34:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2fe295cf5sm1894756a91.47.2024.06.09.21.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:34:17 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/4] riscv: Separate vendor extensions from standard
 extensions
Date: Sun, 09 Jun 2024 21:34:13 -0700
Message-Id: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWCZmYC/42NQQ6CMBBFr0JmbU1baSSuvAchpNJRZmFLZrDBE
 O5u4QQu30/e+ysIMqHArVqBMZNQigXsqYJh9PGFikJhsNrW2hmn5DNNiec+YwyJe1xmjLskyvt
 GG6uxthcNxZ8Yn7Qc7bYrPJLMib/HVTb7+k81G6XVQ7sQHPpraMKdKSehOJyH9IZu27Yf0mnBI
 cUAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994057; l=3754;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/afvdwdS5T+JmlJvh4qFW+jrHrs9DRIpURfuaIzUh48=;
 b=lAT+wDc6icEbmsxxl5zqmyAhQNHCOxSxTmEr68cJziEzvXcUocaHykHQaiGGdyL40vDp0QK61
 pH5gFFP/f77DUf81W3ARk/2aWgOVnkFO0AvnSLnd974MUCcd6idR4fz
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
To: Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
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
 arch/riscv/Kconfig.vendor                        |  19 ++++
 arch/riscv/errata/andes/errata.c                 |   3 +
 arch/riscv/errata/sifive/errata.c                |   3 +
 arch/riscv/errata/thead/errata.c                 |   3 +
 arch/riscv/include/asm/cpufeature.h              |  96 ++++++++++------
 arch/riscv/include/asm/hwcap.h                   |   1 -
 arch/riscv/include/asm/vendor_extensions.h       | 104 +++++++++++++++++
 arch/riscv/include/asm/vendor_extensions/andes.h |  19 ++++
 arch/riscv/kernel/Makefile                       |   2 +
 arch/riscv/kernel/cpu.c                          |  35 +++++-
 arch/riscv/kernel/cpufeature.c                   | 137 +++++++++++++++++------
 arch/riscv/kernel/vendor_extensions.c            |  56 +++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |   3 +
 arch/riscv/kernel/vendor_extensions/andes.c      |  18 +++
 drivers/perf/riscv_pmu_sbi.c                     |  11 +-
 16 files changed, 438 insertions(+), 74 deletions(-)
---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240515-support_vendor_extensions-aa80120e4230
-- 
- Charlie


