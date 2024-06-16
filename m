Return-Path: <linux-kernel+bounces-216378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D5909EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FCC2817A0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE21D54F;
	Sun, 16 Jun 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpyj3l83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A012E7E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558388; cv=none; b=P4qV/nhmDLJ0XejUhF9fKasF/OxFN+iS76uzI8h0Dnct09rIxjjsCs/mwZ/7JHy0KTNCDZGHNfIWlfD4k12f33kK3yyXan2LVcCUGawbWYWp+23YM1hj8+8Le88X9SGe9xuNGVbNPZXliEUAcAZy7k0v7N/3is5ndl+G/q2B8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558388; c=relaxed/simple;
	bh=UYoijwXTiDxnM0ft4XaNfqY/HwhmegABAhD0M3CJA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAF1tiatIXnUAQNgjiN9TLqG2r6gj5uZ5AIJc5p+8L/8YSZposTE+v3ILzwo6QH/ZL/4sH6UUd/Q1qQWsmvbGBDYjHWk4UGAVk/LRmhVLB/Z83ZFEKGKZy689tToQUxpqzDtb35/D8SVQ2Z8W6HGykbLSm/r9g01E4bpNZ6Qc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpyj3l83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA39C2BBFC;
	Sun, 16 Jun 2024 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718558387;
	bh=UYoijwXTiDxnM0ft4XaNfqY/HwhmegABAhD0M3CJA4o=;
	h=From:To:Cc:Subject:Date:From;
	b=bpyj3l836yaIF7YuMjTlKCDrRY4jfD37pFIo52sY+o+sig+QVCZ3RepeJ36N+UyXD
	 qTaVuIOHiPl6wpUR6NB6Bk5l05I6EzQqNEGri5hmSbkyEBd8WFPeIXlLW0n31BfhC6
	 ghYTZHUEnUOaUNHrsuruzSpuUdd45G0b5wDUvyDe9HH5sgcrSO/ndl8DBEqlvY3zON
	 kFRgENJx7/KUg7zoz+nG1Xd4OT+oMwCoG7BlTi3gFtez7T73eKWcNe522s1MkrrvXL
	 FKSAR1NNB9R01lbllkyPkvCZ75PGAypsOqLkdQFJL8sdF/bpzUu2JHmYPxfQuPwkhG
	 S0mUMx7NnYDgA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] riscv: convert bottom half of exception handling to C
Date: Mon, 17 Jun 2024 01:05:47 +0800
Message-ID: <20240616170553.2832-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For readability, maintainability and future scalability, convert the
bottom half of the exception handling to C.

During the conversion, I found Anton fixed a performance issue
and my patches will touch the same exception asm code, so I include
Anton's patch for completeness. I also cooked a similar patch to avoid
corrupting the RAS in ret_from_fork() per the inspiration.

Mostly the assembly code is converted to C in a relatively
straightforward manner.

However, there are two modifications I need to mention:

1. the CSR_CAUSE reg reading and saving is moved to the C code
because we need the cause to dispatch the exception handling,
if we keep the cause reading and saving, we either pass it to
do_traps() via. 2nd param or get it from pt_regs which an extra
memory load is needed, I don't like any of the two solutions becase
the exception handling sits in hot code path, every instruction
matters.

2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
alternative mechanism any more after the asm->c convertion. Just
replace the excp_vect_table two entries.



Anton Blanchard (1):
  riscv: Improve exception and system call latency

Jisheng Zhang (5):
  riscv: avoid corrupting the RAS
  riscv: convert bottom half of exception handling to C
  riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
  riscv: errata: sifive: remove NOMMU handling
  riscv: remove asmlinkage from updated functions

 arch/riscv/errata/sifive/errata.c         | 25 +++++++---
 arch/riscv/errata/sifive/errata_cip_453.S |  4 --
 arch/riscv/include/asm/asm-prototypes.h   |  7 +--
 arch/riscv/include/asm/errata_list.h      | 21 ++------
 arch/riscv/kernel/entry.S                 | 61 ++---------------------
 arch/riscv/kernel/stacktrace.c            |  4 +-
 arch/riscv/kernel/traps.c                 | 57 ++++++++++++++++++---
 7 files changed, 81 insertions(+), 98 deletions(-)

-- 
2.43.0


