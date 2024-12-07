Return-Path: <linux-kernel+bounces-435854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86019E7DE7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966521888D20
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9AC1428F1;
	Sat,  7 Dec 2024 01:59:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5712F375
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536772; cv=none; b=BZ4XfR22BFoYokLAuybEl/RJ4ax6PBFmkiM1AIsmaHjEPBn4kdAWCM5oYDSSHoGE2tQofcULg7wOtRpk7Yi7FnpX17Ooen4zrHmQae6iVKWl5kEq4rzmYGUKq9+VkhvNf7bpcC7SKNKJUyDgsU5RLojlk/E7jvBjxW0IHsZbKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536772; c=relaxed/simple;
	bh=ZtOhJE1cTY/xHXj1EAXPWLuV43L7x8hjDPN8Z46WR28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETRXn8uCCarSAyylI3m0GNmCBYPfmYxAYmxfWcgII4EDJJ8Oit9snCp6UX+2h8xgJn5Q4ClUiK+Y32AUJo/2mRTqJcSLY5ECTN+b8b2G2jZ2HKqlW6ErncDxQzVnUFPx978gCRT4bH3eR/ptsv6v/C1gd9CSa9UauBy/otex/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxPuMArFNnO61SAA--.28971S3;
	Sat, 07 Dec 2024 09:59:28 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBx_uD1q1Nn3Wd5AA--.42544S11;
	Sat, 07 Dec 2024 09:59:28 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/10] LoongArch: Convert unreachable() to BUG()
Date: Sat,  7 Dec 2024 09:59:14 +0800
Message-ID: <20241207015915.1159-10-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241207015915.1159-1-yangtiezhu@loongson.cn>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx_uD1q1Nn3Wd5AA--.42544S11
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4rZFW3JF13tryfWryrKrX_yoWkCwcEyr
	yxJw1UGrWrZFZrAw1Utr4rWryFq3WrKFWY9wn7Zay5A3W5t348t3y5tas8Ar1ktFWkGrZ5
	t39YvFZYkw1xKosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0NJ57UUUUU==

When compiling on LoongArch, there exists the following objtool
warning in arch/loongarch/kernel/machine_kexec.o:

  kexec_reboot() falls through to next function crash_shutdown_secondary()

Avoid unreachable() as it can (and will in the absence of UBSAN)
generate fallthrough code. Use BUG() so we get a "break	BRK_BUG"
trap (with unreachable annotation).

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/machine_kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 8ae641dc53bb..f9381800e291 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -126,14 +126,14 @@ void kexec_reboot(void)
 	/* All secondary cpus go to kexec_smp_wait */
 	if (smp_processor_id() > 0) {
 		relocated_kexec_smp_wait(NULL);
-		unreachable();
+		BUG();
 	}
 #endif
 
 	do_kexec = (void *)reboot_code_buffer;
 	do_kexec(efi_boot, cmdline_ptr, systable_ptr, start_addr, first_ind_entry);
 
-	unreachable();
+	BUG();
 }
 
 
-- 
2.42.0


