Return-Path: <linux-kernel+bounces-562206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D40A61F35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FEA188A6EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73180200136;
	Fri, 14 Mar 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM6Z7RYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A01C84DB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988514; cv=none; b=bQI0heObcGocOvjq6/uQi+w6ib++EMxuPiNWblt0RDhRaI7/jhktBNz/JMwhKYIKY7IfShldr8qM3uGalCibwqypEfHrYWOYeIwi6o4XQC5ST/HEpaWBb9Mtg+JX726D0cW1x8WeHuKRUQsDg0q1bRFxctbwbFWzB4i6d2jGEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988514; c=relaxed/simple;
	bh=BcqivIn8p3FYfH6sqm5193ZXxD/fpGc7Hbkw4bAp4g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOZH1nl+c97NUw5KMqaoFIp8ow23RTYyr3kJ54S8xfdNdYWd4vAahAI+seuu6BFGbot0Dywlt+/swtJwW/+fibSqutPVrzaVpSLDrXHLnWAIsuQfzBlIDUcloiqZtuY843YhzHztJTCTxBna+5Q9bJX0pMAMikA9amLBA9kthSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM6Z7RYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4993C4CEE3;
	Fri, 14 Mar 2025 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988514;
	bh=BcqivIn8p3FYfH6sqm5193ZXxD/fpGc7Hbkw4bAp4g4=;
	h=From:To:Cc:Subject:Date:From;
	b=CM6Z7RYxn3Vke+cHy8S9Shtg39W6mzGW45vVtYM/LQ0keoG2hbMIsF7/G2BfbaXcw
	 QJeO7/g7/Q3Qd/60xn7gWnOgbI0dtDah1LHdpJdCKASH+X+UQdb1/JLddZ4bAqf8Yc
	 XPxmvy4ssUmekJaIjNp25w6qJHm2Rq62j38KOT0T2pbanX2QiuvPs9yuggpPrFzXUK
	 3WGqs8U/ie7ZtcnBk48GvQoXxnK9GF7ggMIFjYmWRrnLlRTuvEGksXjmXtrQo2QZ4P
	 yI26H/G8QG3/IPNAPitIN8PhqYhFswoREC5yr4UNsBDxTRgBjUc4qCwQohSpZjtgWx
	 q/EbQp4gqpN/g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 00/20] x86: Cleanup alternative_io() and friends, prep for asm_call()
Date: Fri, 14 Mar 2025 14:41:13 -0700
Message-ID: <cover.1741988314.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the alternative_io() interface more straightforward and flexible,
and get rid of alternative_input().

These patches are a prereq for another set[1] which will get rid of
ASM_CALL_CONSTRAINT[2] in favor of a much more flexible asm_call()
interface similar to the new alternative_io().

[1] Additional 20+ patches not posted yet to avoid flooding inboxes

[2] ASM_CALL_CONSTRAINT is semi-broken with Clang+KCOV+KMSAN.
    https://lore.kernel.org/174108458465.14745.15292444415957816824.tip-bot2@tip-bot2/
    https://lore.kernel.org/174099976188.10177.7153571701278544000.tip-bot2@tip-bot2

Josh Poimboeuf (20):
  x86/cpu: Use named asm operands in prefetch[w]()
  x86/apic: Use named asm operands in native_apic_mem_write()
  x86/mm: Use named asm operands in task_size_max()
  x86/cpu: Use named asm operands in clflushopt()
  x86/asm: Always use flag output operands
  x86/asm: Remove CC_SET()
  x86/alternative: Remove operand numbering restrictions
  x86/asm: Replace ASM_{OUTPUT,INPUT}() with ARG()
  x86/alternative: Simplify alternative_io() interface
  x86/alternative: Add alternative_2_io()
  x86/alternative: Make alternative() a wrapper around alternative_io()
  x86/cpu: Use alternative_io() in prefetch[w]()
  x86/alternative: Remove alternative_input()
  x86/barrier: Use alternative_io() in 32-bit barrier functions
  x86/cpu/amd: Use named asm operands in asm_clear_divider()
  x86/cpu: Use alternative_io() in amd_clear_divider()
  x86/smap: Use named asm operands in smap_{save,restore}()
  x86/smap: Use alternative_io() in smap_{save,restore}()
  x86/uaccess: Use alternative_io() in __untagged_addr()
  x86/msr: Use alternative_2_io() in rdtsc_ordered()

 arch/x86/boot/bitops.h               |  2 +-
 arch/x86/boot/boot.h                 |  4 +-
 arch/x86/boot/string.c               |  2 +-
 arch/x86/include/asm/alternative.h   | 31 +++++-----
 arch/x86/include/asm/apic.h          |  7 ++-
 arch/x86/include/asm/archrandom.h    |  2 -
 arch/x86/include/asm/asm.h           | 21 +++----
 arch/x86/include/asm/atomic64_32.h   | 93 +++++++++++++++-------------
 arch/x86/include/asm/barrier.h       | 23 +++++--
 arch/x86/include/asm/bitops.h        |  6 --
 arch/x86/include/asm/cmpxchg.h       |  4 --
 arch/x86/include/asm/cmpxchg_32.h    |  2 -
 arch/x86/include/asm/cmpxchg_64.h    |  1 -
 arch/x86/include/asm/msr.h           | 13 ++--
 arch/x86/include/asm/page_64.h       | 16 ++---
 arch/x86/include/asm/percpu.h        |  4 --
 arch/x86/include/asm/processor.h     | 22 ++++---
 arch/x86/include/asm/rmwcc.h         | 24 +------
 arch/x86/include/asm/segment.h       |  5 +-
 arch/x86/include/asm/sev.h           |  1 -
 arch/x86/include/asm/signal.h        |  2 +-
 arch/x86/include/asm/smap.h          | 18 +++---
 arch/x86/include/asm/special_insns.h |  9 ++-
 arch/x86/include/asm/uaccess.h       |  1 -
 arch/x86/include/asm/uaccess_64.h    |  8 +--
 tools/arch/x86/include/asm/asm.h     | 10 +--
 tools/perf/bench/find-bit-bench.c    |  4 --
 27 files changed, 153 insertions(+), 182 deletions(-)

-- 
2.48.1


