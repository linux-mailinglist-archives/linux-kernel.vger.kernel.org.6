Return-Path: <linux-kernel+bounces-192151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41978D1926
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78760287273
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AC16C451;
	Tue, 28 May 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOiFBoIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413D13E039
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894681; cv=none; b=D2nnNiZ3YRHbW21/fNYPAUFXaaGRJWiYJVnDtH7vjYqvQ3pl1aMcqyPMyYDKzsYDtLiwpJx5myRxJBwvW7Vpho9OvUE5kCvEsTy93bdZiYMwpVws+816ybs4FhyvQza5Zr1ZVc2RWOA7NLiWD0xe0mfoOm8hQ0DNINfl6QR/Ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894681; c=relaxed/simple;
	bh=cKGaioffc0Q77ot1toCJrXdGDgZ9fVMzBNzKB36rtK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lzvrzV2cypOq7AtWtFsGc9WkQh3IhLhIfsCaIaVkI9MbbTNnDhpPsE1rKzgpQOyu5jgPGEWg7dCRc8VxtlAXlBadEn6/jEfcrCOBvYCMnTMnwcXAI/clI00VGKQoGUbOaLLhosQ1CRSBGKB4Z1u/3yKcY9aGTlXIgWA5pOFH3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOiFBoIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A539C3277B;
	Tue, 28 May 2024 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716894680;
	bh=cKGaioffc0Q77ot1toCJrXdGDgZ9fVMzBNzKB36rtK4=;
	h=From:To:Cc:Subject:Date:From;
	b=SOiFBoIgSeVBUoAwAmQjlszsZycBgxh+XfHcXW1x2KnRZrsLpV/TGYJLzk9nS3JML
	 jUrg2oGmln3rXw9060MyTP8vBMtC2LKbh2A81ssqdBnU84aL4Hxx3r7HZtfITDH4VB
	 PLRwitCesYWHTaR5Wh3MCs11J7dB2au+nqCe6npmnGqAWjX9+CucMXklyQK/BvFMnD
	 s5tBGPa9p45ncJBB3ozsYvH6FpwRne3qWJKaK5KG9CM4ALQP3Qwdh5fSwNb+5+ABZn
	 DFYIvBlVnDJxhStA0KrlfvrxPLtaOKowBmwQm/S5azcASUWgLIQzlKfvCYJ0IeR5qJ
	 dbg+S8941O5cQ==
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
Subject: [PATCH v3 0/2] RISC-V: clarify what some RISCV_ISA* config options do & redo Zbb toolchain dependency
Date: Tue, 28 May 2024 12:11:10 +0100
Message-ID: <20240528-applaud-violin-facef8d9d846@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1kEWWyZ2wsVqGe6WsVsrxjZSumjIl+7jmavXm2F+fzk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmhuy+I3IpxFD2g9DyeecmdO8uPVJ7ad3qm9ybpq8V7z 37NN7aJ7ShlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEel8xMvR+dJa/pXxWOeLh I3uzTOtX6h4n7iqvdakLzZYsnnR6Xw0jww3d9ENuz2Tn1SaWNYkt1ClwqAz32tB1ilVEXbrjXzo 7GwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Since one depends on the other, albeit trivially, here's a v2 of the Zbb
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
2.43.0


