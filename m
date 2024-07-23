Return-Path: <linux-kernel+bounces-259950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203693A060
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591721C21BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06314F136;
	Tue, 23 Jul 2024 12:06:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22217BD5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721736401; cv=none; b=czVJAn/T3exHVZl/lc9Ayyo5Zm4/nEReBS57gxiHEm/sPNoF6ehXwRwVZpXda7eAMm6uhhCfNFimQIkPhWQm9WaaSq1jmvYFpZLYRGRAc6Q5Uc5kIyxVHnASvFOXynyTCmoCU3HyBzD7tymm+rO9IsfLQnOiHnECv6BD8kBUuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721736401; c=relaxed/simple;
	bh=dQW+XaBjZcaSi5cw5ZlJG0hhnvdE+hp8hLfo4nhh3WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rd/X5BRwD3Jrtj8boe0NdUd0ux0c79A0Zd0gT2bw56Vs6eu+5AnTmMpwujXp0Ye5B14TYpuv4fHbvWnxe7MmtIQ6/YIHe1Gl9Wu7zUEaGDS/YK4CN29N46XuRDgR7p5IeGiN/JYourX/R1mSfB6Uf5nRA+j9jKxij0Ti8vtY/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WSwpy0lkkz4f3lg5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:06:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9D7431A0568
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:06:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP3 (Coremail) with SMTP id _Ch0CgD3BFDBnJ9mckehAw--.19976S2;
	Tue, 23 Jul 2024 20:06:31 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: kees@kernel.org,
	arnd@arndb.de,
	ndesaulniers@google.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	ardb@kernel.org,
	boqun.feng@gmail.com,
	willy@infradead.org,
	wedsonaf@google.com,
	gary@garyguo.net
Cc: zhengyejian@huaweicloud.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: Fix wrong "big" kernel symbol type read from procfs
Date: Tue, 23 Jul 2024 20:07:41 +0800
Message-Id: <20240723120741.2448050-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3BFDBnJ9mckehAw--.19976S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5KF4DAF15Jw45Ww1xXwb_yoW8Jw1xpF
	4rJrWqvrn5Gw1j9348JFWUurWkGws7WrnxKw1DtrWfCF4DX34I9a4Iga4293WUtryxtFy0
	vanakFW3t3WDAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

After commit 73bbb94466fd ("kallsyms: support "big" kernel symbols"),
ULEB128 was used to encode symbol name length. That is, for "big"
kernel symbols of which name length is longer than 0x7f characters,
the length info is encoded into 2 bytes.

kallsyms_get_symbol_type() expects to read the first char of the
symbol name which indicates the symbol type. However, due to the
"big" symbol case not being handled, the symbol type read from
/proc/kallsyms may be wrong, so handle it properly.

Fixes: 73bbb94466fd ("kallsyms: support "big" kernel symbols")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 kernel/kallsyms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 98b9622d372e..5de692ac4c26 100644
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


