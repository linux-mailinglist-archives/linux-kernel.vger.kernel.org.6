Return-Path: <linux-kernel+bounces-238004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B6692420B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E389B277DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A61BB6AA;
	Tue,  2 Jul 2024 15:14:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE371B51;
	Tue,  2 Jul 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933268; cv=none; b=fIzhvenqvoRBYWku+usKf5BevWTTRwEOce8TZYF/QKqwtjUIAWTIkMf57ZCcXdw1AVdT17AxQoUNeNml2qhNfxR/YPeHDon5tg1QBUi8aOmLZ6RX8URaNISh/mhFbp+K8ZX1S5YRwXXhszT9N3ikG5E9iTZ8ZFYCRiOdpRg3iE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933268; c=relaxed/simple;
	bh=Zo9CB+pznKodLNYJMJRXIQ4bz6Q5UrlUI+rwerwj6eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKToP59tj2/2yQTDzeBdQwzTEGnVk6aixrPuUR64Qasdkpf67zGkgs08TRq1k3C2VcD/5CfTqjla46y5CZcZ0un8CnB7+h+e0FQwJ6q1r1SDFayClPwudbAyHV5rwIgObPDTlZQRd2kOwg3SeIHJQwg2JlqWxpEZVUIL1GItD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB76CC116B1;
	Tue,  2 Jul 2024 15:14:25 +0000 (UTC)
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
Subject: [PATCH] LoongArch: Use correct API to map cmdline in relocate_kernel()
Date: Tue,  2 Jul 2024 23:14:15 +0800
Message-ID: <20240702151415.1160566-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fw_arg1 is in memory space rather than I/O space, so we should use
early_memremap_ro() instead of early_ioremap() to map the cmdline.
Moreover, we should unmap it after using.

Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/relocate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 1acfa704c8d0..0eddd4a66b87 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -13,6 +13,7 @@
 #include <asm/bootinfo.h>
 #include <asm/early_ioremap.h>
 #include <asm/inst.h>
+#include <asm/io.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 
@@ -170,7 +171,7 @@ unsigned long __init relocate_kernel(void)
 	unsigned long kernel_length;
 	unsigned long random_offset = 0;
 	void *location_new = _text; /* Default to original kernel start */
-	char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
+	char *cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
 
 	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
 
@@ -182,6 +183,7 @@ unsigned long __init relocate_kernel(void)
 		random_offset = (unsigned long)location_new - (unsigned long)(_text);
 #endif
 	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+	early_memunmap(cmdline, COMMAND_LINE_SIZE);
 
 	if (random_offset) {
 		kernel_length = (long)(_end) - (long)(_text);
-- 
2.43.0


