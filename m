Return-Path: <linux-kernel+bounces-283776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94B94F892
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84749281AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DF4194C61;
	Mon, 12 Aug 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fmcmtvCY"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD544194AC7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495830; cv=none; b=Eh/nudL6/vtcvnmVISi9nis8StqJ/WUvU+V4L3xoMAUFI8+qoh5hezn/hl1CRrQt0iMBT7zmUfzHery3eaYUJOPvZ0WhYKgfIX/ou+dFy6ZK8kZtDCS8rS/X6fdNV/mwudSU2WVIa0pDVb1Hwx7uvILUm023Ds2fsFSF+7I2T5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495830; c=relaxed/simple;
	bh=2ZLl7537lw7Lz84DM7nmys56YoOvTK7dPF+qlWQ7XOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0DFNiooW/L8VROa3l9IpRARMpgUQUoYsORngM2N0n0eNuECga7dqxW2gu+BTBOZrq4kEcZekvOpb1/4jhTLFdOEpnx3qtZk1v70letz0XAWkGFOBSbU5BlHEHcQSDE6FaQCVLEvK7XKcEYf6PSJMEf0BC+2HqNAG1c/vNE/3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fmcmtvCY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723495825;
	bh=2ZLl7537lw7Lz84DM7nmys56YoOvTK7dPF+qlWQ7XOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fmcmtvCY2wZtZLZ+NfIthQ0wdyxX9CUz2nlO/8ZBG8RfI+2d4ImYyaHrsLBkUiyWR
	 XdNkLi3Eiv1MJW8VnQeXzSnw6AZPB1Rx3LEuDk15IPtGRId0IKokCZwOdo2mlGORb7
	 7a95JQE/mPjuJ6L3uAQD32A/pSNuFYPk3xHpSn/U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 12 Aug 2024 22:50:19 +0200
Subject: [PATCH v2 3/3] tools/nolibc: x86_64: use local label in
 memcpy/memmove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240812-nolibc-lto-v2-3-736af7bbefa8@weissschuh.net>
References: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
In-Reply-To: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723495824; l=1104;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2ZLl7537lw7Lz84DM7nmys56YoOvTK7dPF+qlWQ7XOo=;
 b=4ZAijgmkXf1uUAE714ImrKHisGPnvNhxxCQ9lMfQApaSk9JKrlMQZhU9Jj3SWQFOfuB/whc1E
 bTEL+9CeqzvAO28Eh6oIzLKIkh7djcAz0anp+u/FL2egz56a1NVdChK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Compiling arch-x86_64.h with clang and binutils LD yields
duplicate label errors:

.../gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-ld: error: LLVM gold plugin: <inline asm>:44:1: symbol '.Lbackward_copy' is already defined
.Lbackward_copy:leaq -1(%rdi, %rcx, 1), %rdi

Instead of a local symbol use a local label which can be defined
multiple times and therefore avoids the error.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-x86_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 65252c005a30..1e40620a2b33 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -193,10 +193,10 @@ __asm__ (
 	"movq %rdi, %rdx\n\t"
 	"subq %rsi, %rdx\n\t"
 	"cmpq %rcx, %rdx\n\t"
-	"jb   .Lbackward_copy\n\t"
+	"jb   1f\n\t"
 	"rep movsb\n\t"
 	"retq\n"
-".Lbackward_copy:"
+"1:" /* backward copy */
 	"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
 	"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
 	"std\n\t"

-- 
2.46.0


