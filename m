Return-Path: <linux-kernel+bounces-448414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED139F3FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19111890E11
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA114A85;
	Tue, 17 Dec 2024 01:09:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770F146D55
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397763; cv=none; b=GIxRvJlztYmnJ8JaYEA8MitkNwyn4h/U67/T6cU+QiD0LoSJdglX7I/U49oYYi98iNO73WEW98U2hXeqn+SbGV80z+QViNFa+eGJjrJ+s1/mB4G01GdcZw8eIEFn4s0qZ0yPX+9NrY0D5bJ8JDkvGcZKvnUBm6N5wWH9rn1yp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397763; c=relaxed/simple;
	bh=ZtOhJE1cTY/xHXj1EAXPWLuV43L7x8hjDPN8Z46WR28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTumahCKpsgEBR4cKSvJXcbfaIN7xUSqL/LJZCZQP6FqCZIfZ7dzfJtScTUEGE2ArX2+95XZqGNNjnKn1nScBHz6zUNnDexzCJ8BF41/mUsj96Mid2rEjQwP5rqrmtD3tIOHEPLq6teopVFUuWeL4ttrSZn4rj6xoSrlWrh4e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuuA_z2BnS5dXAA--.41412S3;
	Tue, 17 Dec 2024 09:09:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S10;
	Tue, 17 Dec 2024 09:09:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] LoongArch: Convert unreachable() to BUG()
Date: Tue, 17 Dec 2024 09:09:04 +0800
Message-ID: <20241217010905.13054-9-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPEcyz2BnXNeFAA--.16436S10
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4rZFW3JF13tryfWryrKrX_yoWkCwcEyr
	yxJw1UGrWrZFZrAw1Utr4rWryFq3WrKFWY9wn7Zay5A3W5t348t3y5tas8Ar1ktFWkGrZ5
	t39YvFZYkw1xKosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_
	ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3ID7DUUUU

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


