Return-Path: <linux-kernel+bounces-292921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A355D95767A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594C7285DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41D15A87C;
	Mon, 19 Aug 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GvzmeBqY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAC157E61
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102775; cv=none; b=E6DlCpkJuG0bEGnkZ6oWwJYelO/opVpyOZD5s/rgocsC08Wqhjxp1zE5GcNeY76nk00x8ioTSM3JFhGDJlCGTLmwuI4EIhAMaWSb3jMFnzhZMkSYShgklE8vy8aAqiOJnVmrhX2iX4M+7mXFSmzjp6CVTj3bOMXyfHsi4aUpVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102775; c=relaxed/simple;
	bh=JLqoMip9XKjZebRJAwAYbMNLU8bRcSzSaKdnqlzivPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlvOetjLMRwoi1j6cyC3UDkFmBtrVyvFOCQ0cAzZDx550yHmxQqfaYH7NWW2W4tUgCByT64UapDF3RdL2gACNp+FU8gt1H4EIAgucPGqy2grhl+IEo5e/CSUDfj6ECPmXuYnJt8BbKmK71XAscdsSWr9oQBCfJxDs45xu7puD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GvzmeBqY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202089e57d8so20553535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724102771; x=1724707571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9OfmERMsrZNq8P77Fjit70ippOj9+Ox6UHTCVXlfO8=;
        b=GvzmeBqY3cMWA17ZmPWC9OIL0GGI3zUSuY6oVdUSi3UVmlytPNJfImS6+VI1Vcowp9
         NSzAixC+6cLobrRp3OEtl+JfP4FdUSKxbOTWydkC0u/rHM6q5FIixBo1Pl9iro9lPMQs
         IKEY2lZpv/z2q/hjWFyJYWzbbwfmXGAwYXcyI2aV+jRoGST8T5C18R9FbgEMNEcHoi/J
         S0QAtX1vwnv88S7dJ62r6d4ydfUde4nisoNsq4wRDJSWut95B//uPrQDabWiakDB5+UK
         Bc3RQUdvmWGHRh9k9skvyvKwhvfUJsa+TrOg3uMq1zAxBy9VxbjO2mQOJI4XYEm9fpgl
         sP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102771; x=1724707571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9OfmERMsrZNq8P77Fjit70ippOj9+Ox6UHTCVXlfO8=;
        b=sc3GN/ANj0MaFHewxcxrIkY7uXw3hfg4rs2hw2jweqB3qeMkv/f1YHLYaOVnkjbthN
         hSaFU2/K1SqPlhpbP5ZsijiduXzW+pUpEr/SVYqXL/mxiVhLSehQ99qZn1AuXbR/Q7a5
         As+jP1PqODDoIFVffBktlfRRSSf7IETnMwzpWdECk1TbmTc0x3HgaVtn9W0X9L8tW4wu
         y8p8ZYaUTpOWVuyrjLO4hJN96yd7xkeLR6urUyr3uXy0SnJyvauyeC6ENOO1LWxoCY2B
         sjUm3lkGTtR62q0SScoEXLHznRSnAXhnuHlMR4AULwQq7+bacE6PPdc0LAL0WTSlpDMv
         FEmA==
X-Forwarded-Encrypted: i=1; AJvYcCWjITAG1wJbq6iFEo0WE3OfZmjxn7TM8r7+1L09Equz+CGYzft7vLPHEL3jS4PzohrdgaV4UzXs6e4DbwldyckUFoo4AImyK4MXZTo/
X-Gm-Message-State: AOJu0YzaVTiEBc/e6b74dIQRQTuDt7p8PD2uvsXS/DBmpO68VrE2wkJB
	1/bdTO+813qe7nL49weHTh3ljDR0x1UW5InhQnvcdYRkljqvLnJHuvMGT42RDQg=
X-Google-Smtp-Source: AGHT+IFWdnJy6AnvrDBgMG+5m5iERxX/4Mb0i6suVZLV9/Qrn/VsQrVH+R+ghxL/IzVHWzB07ePziQ==
X-Received: by 2002:a17:902:cecb:b0:202:562c:f3dd with SMTP id d9443c01a7336-2025ef684d9mr12058455ad.3.1724102771442;
        Mon, 19 Aug 2024 14:26:11 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61e7bd1sm7004694a12.53.2024.08.19.14.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:26:11 -0700 (PDT)
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
Subject: [PATCH v8 0/6] RISC-V: Detect and report speed of unaligned vector accesses
Date: Mon, 19 Aug 2024 17:25:59 -0400
Message-ID: <20240819212605.1837175-1-jesse@rivosinc.com>
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

Changes in v6:
 Added ("RISC-V: Scalar unaligned access emulated on hotplug CPUs")

Changes in V8:
 Dropped Zicclsm
 s/RISCV_HWPROBE_VECTOR_MISALIGNED/RISCV_HWPROBE_MISALIGNED_VECTOR/g
  to match RISCV_HWPROBE_MISALIGNED_SCALAR_*
 Rebased onto palmer/fixes (32d5f7add080a936e28ab4142bfeea6b06999789)

Jesse Taube (6):
  RISC-V: Check scalar unaligned access on all CPUs
  RISC-V: Scalar unaligned access emulated on hotplug CPUs
  RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
  RISC-V: Detect unaligned vector accesses supported
  RISC-V: Report vector unaligned access speed hwprobe
  RISC-V: hwprobe: Document unaligned vector perf key

 Documentation/arch/riscv/hwprobe.rst       |  16 +++
 arch/riscv/Kconfig                         |  57 +++++++-
 arch/riscv/include/asm/cpufeature.h        |  10 +-
 arch/riscv/include/asm/entry-common.h      |  11 --
 arch/riscv/include/asm/hwprobe.h           |   2 +-
 arch/riscv/include/asm/vector.h            |   2 +
 arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
 arch/riscv/kernel/Makefile                 |   3 +-
 arch/riscv/kernel/copy-unaligned.h         |   5 +
 arch/riscv/kernel/fpu.S                    |   4 +-
 arch/riscv/kernel/sys_hwprobe.c            |  41 ++++++
 arch/riscv/kernel/traps_misaligned.c       | 131 +++++++++++++++--
 arch/riscv/kernel/unaligned_access_speed.c | 156 +++++++++++++++++++--
 arch/riscv/kernel/vec-copy-unaligned.S     |  58 ++++++++
 arch/riscv/kernel/vector.c                 |   2 +-
 15 files changed, 465 insertions(+), 38 deletions(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

base-commit: 32d5f7add080a936e28ab4142bfeea6b06999789
-- 
2.45.2


