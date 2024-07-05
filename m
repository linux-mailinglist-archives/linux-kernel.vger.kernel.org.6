Return-Path: <linux-kernel+bounces-242769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0D928CEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CA1F25A34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0739149005;
	Fri,  5 Jul 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sarjax3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501A433CD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199440; cv=none; b=XF89tdhx9HWl+XVYWPB6pY4W8ZaVn6yFswe9B2bjHKPxYtD/PYxGRP0Bwx6lFzCo6CmVKfGeAB3L5/9lffuXuC50c03vhobwsWR9muO5NSscl2/6X5KUNBr93A9Kzu01FlYPRS+FWp8j7HVY3xOHUNA5T9KPijO6+hjozKdDEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199440; c=relaxed/simple;
	bh=rt35NjUgW/C91Lz67ZKBNDSx0DfEz1EQsLfxcW/ZjQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afK6vQTbNKsVbtJn4vX5YMmhY6UCx4kByl6CFhBxKnwbWHxHMYzmltu7w3tKrkV5UpYgHla3Y5fdfnaU6xAkDjnl1tovf3C8c84mEyTzCA13k4r0OumDCM0xapR2+MOlbrm4FNgvy5eX/Xd/J69ItzZPTRwPrkCS4lkSOZUXj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sarjax3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6DEC116B1;
	Fri,  5 Jul 2024 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720199439;
	bh=rt35NjUgW/C91Lz67ZKBNDSx0DfEz1EQsLfxcW/ZjQk=;
	h=From:To:Cc:Subject:Date:From;
	b=Sarjax3uiZjlafHM4fgMvJ9iCO3kpJVODA3vdFT2ITpdaBX4x9i2CcihQMDyOCPJ0
	 oU4mQvvqrRmidMRnoeKDkHjYDCH7xjZWjMH6i86oRiOjaDSwfhCsetdP0LwBbyQskV
	 zDPq3tyhBR1O7NvL943OeGrjXFG8I/5YDTYBjMnaiALxNVRVN7IsuKewy5YKrHqtFT
	 bsv9vHtPLDJ6GaFA+DyA9ZayRpEFX/AnvjjoMqCw+ZZKsC4eJOs1Sn7MrCNbvIL+lk
	 ct4z0PZM+/U7917VDEFWLb9cgWAhjrb3e27/E24mwIGMQc3wDhGx9amsZzk2+zci9e
	 FqwTohwX4Rgxg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: define ILLEGAL_POINTER_VALUE for 64bit
Date: Sat,  6 Jul 2024 00:56:32 +0800
Message-ID: <20240705165632.3216-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used in poison.h for poison pointer offset. Based on current
SV39, SV48 and SV59 vm layout, 0xdead000000000000 is a proper value
that is not mappable, this can avoid potentially turning an oops to
an expolit.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c51b32a8ddff..c992eabbd002 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -313,6 +313,11 @@ config GENERIC_HWEIGHT
 config FIX_EARLYCON_MEM
 	def_bool MMU
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	default 0 if 32BIT
+	default 0xdead000000000000 if 64BIT
+
 config PGTABLE_LEVELS
 	int
 	default 5 if 64BIT
-- 
2.43.0


