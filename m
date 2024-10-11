Return-Path: <linux-kernel+bounces-360574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B518999CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADF7B20FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA01F9409;
	Fri, 11 Oct 2024 06:38:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE1199FB9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628715; cv=none; b=ZTZS5RO340S0R88HJQ3ULJPcnUJxfAmLguzd0/btOctA+QUxySf0yCkDWlAE1UjZ2E439V6iI4z1j+C2VwR/i4/2A0qsy8ADXvy6f1+2HzU8OJjqWmnin8tqbMyV7TaCuZS2qZ4SISJeMxrKS6Slu3m6DBEX7pYKT6/TSK0vkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628715; c=relaxed/simple;
	bh=fjMoNkfPef73AP2qYg3hgQ+8c0vHiEgF6HH0g8UcMqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpCXUufX4vpr1S6rmeM54pUszzkDx5FrasJl45RzRWrSBXscuLeNp/THbCvQ3bZNTdf29tQOVh0xNuSDODblTcp+vJ+Zrv3StYNgoJSe2VIpvqi+69cYnH99MAHpzq28ByGAOBe9yuRscs+bcXwrisuHPxpIbZigcD0cfKt1EaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPxlR24zwz4f3m6f
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:38:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EEC971A0568
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:38:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP1 (Coremail) with SMTP id cCh0CgAHMy_dxwhnLiqsDg--.10077S2;
	Fri, 11 Oct 2024 14:38:26 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: arnd@arndb.de,
	kees@kernel.org,
	mcgrof@kernel.org,
	masahiroy@kernel.org,
	ndesaulniers@google.com,
	ardb@kernel.org,
	jannh@google.com,
	song@kernel.org,
	willy@infradead.org,
	boqun.feng@gmail.com,
	gregkh@linuxfoundation.org,
	gary@garyguo.net,
	wedsonaf@google.com
Cc: linux-kernel@vger.kernel.org,
	yeweihua4@huawei.com
Subject: [PATCH v2] kallsyms: Fix wrong "big" kernel symbol type read from procfs
Date: Fri, 11 Oct 2024 22:38:53 +0800
Message-Id: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHMy_dxwhnLiqsDg--.10077S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDKw13Gr1UKr13uryDKFg_yoW8tw4xpF
	45trZ8tFn5Gr10k34xJr48C3srXws7uF1xKr1qqr1fCF1DXry0gas2g34j93W7tr9rtFy0
	qanIyFWaqw1vyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_
	Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
	6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0VBT5UUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

Currently when the length of a symbol is longer than 0x7f characters,
its type shown in /proc/kallsyms can be incorrect.

I found this issue when reading the code, but it can be reproduced by
following steps:

  1. Define a function which symbol length is 130 characters:

    #define X13(x) x##x##x##x##x##x##x##x##x##x##x##x##x
    static noinline void X13(x123456789)(void)
    {
        printk("hello world\n");
    }

  2. The type in vmlinux is 't':

    $ nm vmlinux | grep x123456
    ffffffff816290f0 t x123456789x123456789x123456789x12[...]

  3. Then boot the kernel, the type shown in /proc/kallsyms becomes 'g'
     instead of the expected 't':

    # cat /proc/kallsyms | grep x123456
    ffffffff816290f0 g x123456789x123456789x123456789x12[...]

The root cause is that, after commit 73bbb94466fd ("kallsyms: support
"big" kernel symbols"), ULEB128 was used to encode symbol name length.
That is, for "big" kernel symbols of which name length is longer than
0x7f characters, the length info is encoded into 2 bytes.

kallsyms_get_symbol_type() expects to read the first char of the
symbol name which indicates the symbol type. However, due to the
"big" symbol case not being handled, the symbol type read from
/proc/kallsyms may be wrong, so handle it properly.

Cc: stable@vger.kernel.org
Fixes: 73bbb94466fd ("kallsyms: support "big" kernel symbols")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---

v1 -> v2:
- Add reproduction info into commit message to make it clearer;
- Add cc: stable line;

v1: https://lore.kernel.org/all/20240830062935.1187613-1-zhengyejian@huaweicloud.com/

 kernel/kallsyms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9a0ca605d4a..9e4bf061bb83 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
 {
 	/*
 	 * Get just the first code, look it up in the token table,
-	 * and return the first char from this token.
+	 * and return the first char from this token. If MSB of length
+	 * is 1, it is a "big" symbol, so needs an additional byte.
 	 */
+	if (kallsyms_names[off] & 0x80)
+		off++;
 	return kallsyms_token_table[kallsyms_token_index[kallsyms_names[off + 1]]];
 }
 
-- 
2.25.1


