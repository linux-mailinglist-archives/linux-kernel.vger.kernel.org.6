Return-Path: <linux-kernel+bounces-213598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B8690776E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0DB228C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD614A62F;
	Thu, 13 Jun 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7XhJEk0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3E12FB02
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293485; cv=none; b=PygqZvYyvxxkRKr16D8bnXHpT2arnLslrBJk6BeL5aJoV0fIfjtplOZLpxvC2S7nF/FZbDiglZECoRk0bTDPoqQSRjxZ4VMb2Eg6fALs1596fWxgi3nIEbvKQAtafMOsSGucXr470YqVJy7hIsp0Io13X0ZEobwgET2F0Cw0Ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293485; c=relaxed/simple;
	bh=xoQncLJpBbEP+zyVvrGyI0JKEvpDoHxLakEhQebTzf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/bqMzrGwAR+CrcTvXiDgwf3oTmpZEJfE5+4ShrOZKaBL88ylZ72XD6a08+wXGYxg+n5gPz4HRFRqesUqds53R0D38YBPdAiKS+nfM32iePJVW6L1iSt+MBqQnq6B+NHhHrzQO4Ii+Dn5RFMEbWQA6Xd0zEC40PUjMHIt4igIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7XhJEk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B4C2BBFC;
	Thu, 13 Jun 2024 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293484;
	bh=xoQncLJpBbEP+zyVvrGyI0JKEvpDoHxLakEhQebTzf0=;
	h=From:To:Cc:Subject:Date:From;
	b=k7XhJEk0iETmlFTsANemqhR3QEGu7+9Smi6jDNrqKVGHJJ/wvPqLv0VROmj/MKz8b
	 y79srEO5mcmfg0I/HlckIYSPxFi7b7RZp5Uk5Vt0knBXJ7YXeOtY3dGso4drrziSDR
	 uJL1W1eTOOAoVMaofkVfHV8wi5nswuAISbeWYgqCPLG50OizYnmfZCrIYFU4N0OAOX
	 F3Wox1BWhKmox+t7Crl4lt/ASkuFStI/NbGGvf9Ag74v2wurZ+09NIxyhNSL+mC4Ab
	 trLvs5KcDYL4p9odKyjnPfLfFLrzUgrAF3Ehvb4V1YMJ15DGkGmeX9dm3iYXwHaS1q
	 cZflr6aaCxl9Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH RESEND] riscv: boot: remove duplicated targets line
Date: Thu, 13 Jun 2024 23:30:53 +0800
Message-ID: <20240613153053.3835-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "targets:" is duplicated in another line, remove the one with less
targets.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 8e7fc0edf21d..e051c677f6c4 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -20,7 +20,6 @@ OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 OBJCOPYFLAGS_loader.bin :=-O binary
 OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.* loader loader.o loader.lds loader.bin
 targets := Image Image.* loader loader.o loader.lds loader.bin xipImage
 
 ifeq ($(CONFIG_XIP_KERNEL),y)
-- 
2.43.0


