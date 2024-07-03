Return-Path: <linux-kernel+bounces-239355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3338925C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1EF1F21108
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D67180A8D;
	Wed,  3 Jul 2024 11:05:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F217F51A;
	Wed,  3 Jul 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004755; cv=none; b=Sq+m+xopqvB0zfKhtsOyX2wlI6dlDB65ha0SQ01YtWeIQt6OGldrnDmGJlatZBXNQtwZ+nhjyO7mCv6IRzgez5ncmBYZNYu+wLDNf0r5C8NBNjYIXFKSMa9/daY+K8EZro6LqKgP6KZI0sl7CS54qqchkOCjzl+D9wMstbxnhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004755; c=relaxed/simple;
	bh=Nt6ZuaCko+BArRXXU7JkXLT2e8uK2t+eKVQDm+MzM0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7TD7wTA9dXspNTUx95qjCvgYqV7rxLLXbDD6bvWcpjhc6SSO6P8tBcvzkS23zkY+R5Fo0RdXzd6D/DQ2gSWrGG0qrqwlDvABsm8jY0RWSAlieyzTXE2JLx15oq+rH4MomzGNtBQUjGg/M0WoDv8aUwHUgtZz4rv2//fhjGQkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.22.233.190])
	by gateway (Coremail) with SMTP id _____8Cx_vCPMIVmaX8AAA--.1818S3;
	Wed, 03 Jul 2024 19:05:51 +0800 (CST)
Received: from lvm.. (unknown [112.22.233.190])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfceMMIVmHIU5AA--.3488S2;
	Wed, 03 Jul 2024 19:05:50 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Xi Ruoyao <xry111@xry111.site>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	loongarch@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: rust: Use rustc option -Zdirect-access-external-data
Date: Wed,  3 Jul 2024 19:06:24 +0800
Message-ID: <20240703110624.1301830-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxfceMMIVmHIU5AA--.3488S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruF48WF1rJFyrJr48Ww15trc_yoWkCrX_Wa
	13Jw48Ka1rWrs0va15Zr1rGrn7C348JF4fZF1vqr9xJryYgry5trZrGw1fZrnaq3y2grs5
	GF4xZasrZr1UtosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

-Zdirect-access-external-data is a new Rust compiler option added
in Rust 1.78, which we use to optimize the access of external data
in the Linux kernel's Rust code. This patch modifies the Rust code
in vmlinux to directly access externa data, using PC-REL instead of
GOT. However, Rust code whithin modules is constrained by the PC-REL
addressing range and is explicitly set to use an indirect method.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 arch/loongarch/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 8674e7e24c4a..ae3f80622f4c 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -105,7 +105,8 @@ KBUILD_CFLAGS			+= -fno-jump-tables
 endif
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat
-KBUILD_RUSTFLAGS_MODULE		+= -Crelocation-model=pic
+KBUILD_RUSTFLAGS_KERNEL		+= -Zdirect-access-external-data=yes
+KBUILD_RUSTFLAGS_MODULE		+= -Zdirect-access-external-data=no
 
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS_KERNEL		+= -fPIE
-- 
2.45.2


