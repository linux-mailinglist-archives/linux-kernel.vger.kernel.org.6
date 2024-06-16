Return-Path: <linux-kernel+bounces-216380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF1909EB0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1710BB2107E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D4446AF;
	Sun, 16 Jun 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLiRO/PQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C643C463
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558391; cv=none; b=ZCDvInTK6yR9JwMC2lQUP68dzMdo3Z6EixxjlRjO5Q2Zaqsth/JJ9TkT5ZyxgsqCUxYW2JE/qBYtVPAuNzUoJg/uWoXKIyyM13PTqAcuYaqV4jzIH9l9jyoIAt9aAWBH2+QvtaW5fii3G2eO36C8lhvNjpusEBGP+1jQ6J4aswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558391; c=relaxed/simple;
	bh=4oPVcX+dnWixdoqxyDdXAghWvga3v3Kc2JLR+Blj82Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCnymvElhepqA/rNXTAwJLTTLpQf3tdJNjYT7BU+lPurRnWLHmjeuLhpgzQ0aKJY8YP9Fl0h51dHQRgxPCUS3MUEIKEjgNZCDf2VyCtkcAgcIm9K8+6j/PrucxvusJjOgI3QVCWitJmtg6s7zDFajGqYv9SxS+N/0+PDt/H0LL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLiRO/PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520EC4AF49;
	Sun, 16 Jun 2024 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718558391;
	bh=4oPVcX+dnWixdoqxyDdXAghWvga3v3Kc2JLR+Blj82Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLiRO/PQh7a2ZWQyfdC4US0mVkLlJ6HO5eO2UarMxrnSElqTkb/0AS8JgQyaCPhsb
	 f6Rnisd+06F259/wK4wls00MfcNsQl7NQV+Mhfnv88IgCcvrGU3EWPRqLTVQk7dVYB
	 aSa1Ei/lYBm1EJcUUArXAUixCItAFX3YYfgToXU01t7FQ5c3d5eN5w5k0PhprfrDfz
	 EtwdhL3f2ERamE7jYlaP9xncBE9/iJy0AMReS0P4PhkD7Tf12bJtFn1GRiJrMvsBcd
	 78n1RdSgzcAUv2HGdJF9Lu3B/cxSeuKOnUwNtjb8Z0Wd/djOm7Effpd6bH3OtDgeL1
	 peEGAE0Ub3qjQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] riscv: avoid corrupting the RAS
Date: Mon, 17 Jun 2024 01:05:49 +0800
Message-ID: <20240616170553.2832-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616170553.2832-1-jszhang@kernel.org>
References: <20240616170553.2832-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inspired by[1], "modifying the return address of to point to
ret_from_exception will corrupt the RAS", so modify the code
to remove the code of modifying ra.

Link: https://lore.kernel.org/linux-riscv/20240607061335.2197383-1-cyrilbur@tenstorrent.com/ [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index c933460ed3e9..81dec627a8d4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -235,8 +235,8 @@ SYM_CODE_START(ret_from_fork)
 	jalr s0
 1:
 	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
-	tail syscall_exit_to_user_mode
+	call syscall_exit_to_user_mode
+	j ret_from_exception
 SYM_CODE_END(ret_from_fork)
 
 #ifdef CONFIG_IRQ_STACKS
-- 
2.43.0


