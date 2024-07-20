Return-Path: <linux-kernel+bounces-258022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5A938243
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A441F21913
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB901482E2;
	Sat, 20 Jul 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeT5VKlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FCD13775E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496082; cv=none; b=F+uS7ULmf4kkBfsCWoaZruyXvcD0S8Ny5VgWt3sAJnytr5kg5/66A1X4cbX8xLTpqLZP6wzO9nYRLhf7YWZT9GOzsMtryFa6vvukt+Ihkfm9G5qcJCOkbJ0QsomoZIJtTXgXABzig0ezdkT+2vNJoBcxTt4uv2+5HjJO8UJc/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496082; c=relaxed/simple;
	bh=367A27lSeXo8TqISrQnpweAqbo/A/tUIu1oOBk5HfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQtFD2wAMhOsAzcRaYk4PFdg2ntzkAFnxaCltw1QV42ioK3aqlMquQUykJmPyjg+pIyTFeUq7q6yObwaGNQx/0Bvox83nbc6p4zD1TZlxwuufeyz/v0mD3U86lvIJ+odEFYa2NyNmUKx0vW55LND9XxLiA07lJnwIzl6G8a67IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeT5VKlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2041C2BD10;
	Sat, 20 Jul 2024 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496082;
	bh=367A27lSeXo8TqISrQnpweAqbo/A/tUIu1oOBk5HfDI=;
	h=From:To:Cc:Subject:Date:From;
	b=oeT5VKlZLlYV4yW7bijIgfagrp5YcPf+Eneb7F4u/O3MEmnpPIVHDgsQE1puEB84f
	 pHAFMEHd7sp2NpNzNFftsfznN9APIKq/ig7WDra6jEDo6QKLpu7NwsbpR8m7TLDwaW
	 FN2MiKCKTwrd2CCaJs1TRvm9QTGhxCipAt3wNy6qcmOWjJtb8xDHJH3DysqBqWdqzP
	 k4mXOhPEEUmsIUelI1CeShWyC1wK4U0RTuJmf8TfhLYcXZdU8WaBTJJk4CtCzx7cbm
	 CIsYBnsko+HSBbyP/TSDkmYOQYlrAhszyCd0mNsE8NDlObuIiy3KEZIyGNYwwMFfR8
	 mHkPy6ZrqEwQw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cyril Bur <cyrilbur@tenstorrent.com>
Subject: [PATCH v2] riscv: avoid Imbalance in RAS
Date: Sun, 21 Jul 2024 01:06:59 +0800
Message-ID: <20240720170659.1522-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inspired by[1], modify the code to remove the code of modifying ra to
avoid imbalance RAS (return address stack) which may lead to incorret
predictions on return.

Link: https://lore.kernel.org/linux-riscv/20240607061335.2197383-1-cyrilbur@tenstorrent.com/ [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>
---

since v1:
 - make it a seperate patch
 - modify the commit msg, thank Deepak
 - collect Reviewed-by tag

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


