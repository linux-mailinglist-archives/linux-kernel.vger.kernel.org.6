Return-Path: <linux-kernel+bounces-228356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C083915EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040841F2314F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD41145B2F;
	Tue, 25 Jun 2024 06:16:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C831DA22;
	Tue, 25 Jun 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296210; cv=none; b=nHT7XuK9nuJBcpD0kM/A2+gisgVeM6E1GtL88iFw/AVJ4UUAPgfH7ilYLB+oDrwxsiafpTEuW0t1u3SDjpQzOWivKr0qTXFQwhTlFMbLIuGp6YwdzLecZyoMdpSMb74xGYD+5YS+CNbn+CCbEWRtE7k6inAhpl1/zwhI5aFHvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296210; c=relaxed/simple;
	bh=PuPkq9GiwahvAIsNf55rCcqw5znmmdDNqoEoT17fDbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEiMLoW41YxsGPAKuQgBINea8nvoBVa4q4atzdu0cyTIf16aVgXTiCR2nJUsIDCUiFYEH5m+Vgq9VacrCtKZabmKVrKjULVUVGRy+mdKPCiYfVRLrtLKagKBRQvWMjazLIx/DkTZeq5uOIrH0/eIgbPVipS6uAQvVAdC5o0ZGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDCC32782;
	Tue, 25 Jun 2024 06:16:47 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Automatically disable KASLR for hibernation
Date: Tue, 25 Jun 2024 14:16:31 +0800
Message-ID: <20240625061631.3461764-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hibernation assumes the memory layout after resume be the same as that
before sleep, so it expects the kernel is loaded at the same position.
To achieve this goal we automatically disable KASLR if user explicitly
requests hibernation via the "resume=" command line. Since "nohibernate"
and "noresume" have higher priorities than "resume=", we only disable
KASLR if there is no "nohibernate" and "noresume".

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/relocate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 1acfa704c8d0..6834d627ff20 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -123,6 +123,32 @@ static inline __init bool kaslr_disabled(void)
 	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
 		return true;
 
+#ifdef CONFIG_HIBERNATION
+	str = strstr(builtin_cmdline, "nohibernate");
+	if (str == builtin_cmdline || (str > builtin_cmdline && *(str - 1) == ' '))
+		return false;
+
+	str = strstr(boot_command_line, "nohibernate");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return false;
+
+	str = strstr(builtin_cmdline, "noresume");
+	if (str == builtin_cmdline || (str > builtin_cmdline && *(str - 1) == ' '))
+		return false;
+
+	str = strstr(boot_command_line, "noresume");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return false;
+
+	str = strstr(builtin_cmdline, "resume=");
+	if (str == builtin_cmdline || (str > builtin_cmdline && *(str - 1) == ' '))
+		return true;
+
+	str = strstr(boot_command_line, "resume=");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return true;
+#endif
+
 	return false;
 }
 
-- 
2.43.0


