Return-Path: <linux-kernel+bounces-379695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C089AE25E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308061C2164C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED921C07DF;
	Thu, 24 Oct 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OchkCHrk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FB16FF3B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765199; cv=none; b=vCOOCDunHyewMeI6u6S9aH7FIsoR84QGpoFp24K/EoOeOwNknMumCovW0D+Tr6xaztUqEi9qUAcqztwlBSbZ1h0s8QvG6LflPmJuxCKcgYPm/hWMVr9tH4Q7QNFD7uOFwRdj13ZEWOJxwVUaZi2NYVV2NYYW07WbxwlBeCiyjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765199; c=relaxed/simple;
	bh=1eOymLXp8Il5GG8XBWYJ5u7O1358IpUBrRLlLzVG6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fWSZgfBKAd3MAi0vfPKozqBpMz/DCOLl4E5XGgPrEdsMZuUHKpGdt+bobJuOrhOMOvxg3qsG//jlyXUU0X9rXwiNC4yKn8PFR+FDi2D6Y88NaK04Kkk6HCYKbZTczQo202VkXZFIC8IjL9hoXpwUhERjH+dtnPcVC0DkJKXbuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OchkCHrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55805C4CEC7;
	Thu, 24 Oct 2024 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765198;
	bh=1eOymLXp8Il5GG8XBWYJ5u7O1358IpUBrRLlLzVG6p0=;
	h=From:To:Cc:Subject:Date:From;
	b=OchkCHrkdOP4TCE7IstWNbHLx7hok7P32qyw6l54Eq7OCuqbqYe2N1iuqHTAxvviy
	 LVQJqiSIWLinZ0bO7EiF3SlczA6fbf3UG8W46t4hxGVYtJKBgNo2N8No/+qa5JV+Z9
	 FKZSz/UuXrBgpWLrOheUR0wlO18QB1PJa/LMc/TMxSVovw5noSPiIOJqeOfxnJ2TeA
	 NB0TajSgTE4QMjGzbPz/DSaYJr1ECtsyRLuMubUhiq/PVUX7IHZ1J5mDMkfin0bjSB
	 qF0sqgpL+4C6qu0bzKwenKB4xzehTFee3ti36QCSazbpjW4jZtKGlvvOuHdWlR1bwr
	 xMR/z6ijIIXaQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	xiao.w.wang@intel.com,
	Andrew Jones <ajones@ventanamicro.com>,
	pulehui@huawei.com,
	Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v4 0/2]  RISC-V: clarify what some RISCV_ISA* config options do & redo Zbb toolchain dependency
Date: Thu, 24 Oct 2024 11:19:39 +0100
Message-ID: <20241024-aspire-rectify-9982da6943e5@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=cQHZLXl0Lem86H8PfivnwWB967sopbzxoPR7jwhqlyo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlS8vaSm3muyWy+r7A4Y2WLnfXsf42ni84encV7PSX7B Vv2fYaMjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEeTcjw2LbyeJmR9wkz6W8 S/fhCDju+/TsFpGvs0/HLb+yc21axQyGf2oPJ3veY9ERllqm8iB4VXCf1k6FKamLma8cin+1vTt GmQ0A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Since one depends on the other, albeit trivially, here's a v4 of the Zbb
toolchain dep removal alongside the rewording of Kconfig options I'd
sent out before the merge window. I think I like this implementation
better than v1, but I couldn't think of a good name for a "public"
version of __ALTERNATIVE(), so I used it here directly.
Unfortunately "ALTERNATIVE_2_CFG" already exists and I couldn't think of
a good way to name an alternative macro that allows for several config
options that didn't make the distinction sufficiently clear.. Yell
if you have better suggestions than I did.

I am a wee bit "worried" that this makes the Kconfig option confusing as
it isn't immediately obvious if someone is or is not going to get the
toolchain based optimisations.

Cheers,
Conor.

v4:
- rebase since it's been a few months
- change some wording Alex wasn't fond of in patch 1
- remove a left over CONFIG_RISCV_ISA_ZBB_ALT from the v1 implementation
  in patch 2

CC: xiao.w.wang@intel.com
CC: Andrew Jones <ajones@ventanamicro.com>
CC: pulehui@huawei.com
CC: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
CC: Samuel Holland <samuel.holland@sifive.com>
CC: Pu Lehui <pulehui@huaweicloud.com>
CC: Björn Töpel <bjorn@kernel.org>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org

Conor Dooley (2):
  RISC-V: clarify what some RISCV_ISA* config options do
  RISC-V: separate Zbb optimisations requiring and not requiring
    toolchain support

 arch/riscv/Kconfig                    | 38 ++++++++++++++-------------
 arch/riscv/include/asm/arch_hweight.h |  6 ++---
 arch/riscv/include/asm/bitops.h       |  4 +--
 arch/riscv/include/asm/checksum.h     |  3 +--
 arch/riscv/lib/csum.c                 | 21 +++------------
 arch/riscv/lib/strcmp.S               |  5 ++--
 arch/riscv/lib/strlen.S               |  5 ++--
 arch/riscv/lib/strncmp.S              |  5 ++--
 8 files changed, 38 insertions(+), 49 deletions(-)

-- 
2.45.2


