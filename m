Return-Path: <linux-kernel+bounces-308128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF4B96579C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35749285B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AD152165;
	Fri, 30 Aug 2024 06:27:52 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72E14A0B6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999272; cv=none; b=c0LLbFBwmQrPTNeDNMpmMsaidELoJDb8+NYq0Wdf3PPj+LkYWK4pvjN53K06bIGr/BgTTeXAuWA9pyRL+EcF9oa9syRe+YU+D2xNAdrWIaRjmTcLLDsKpkfrJz65QfeHAnMuZDdBhu1cXtF2wr7i6DLakx+omNIbReqTJs00qCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999272; c=relaxed/simple;
	bh=BvBr2GTcISzS6iTjVRV4SNJRaFs9svbxyQrFCITVBKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOBDtarSd/bdVOPvGvz7mLlS0MYkzRDmzwR99EFaM2pk/i80TQcNMZmzSEWsOdFC3tAR26MaQRveTaW1ua2/id2Y++EcY6l6avWmD/n+Fh+ChaFIwh4vedyYy3Oabf7bsR49YxH4fQQNnIHZ075u+udEkY8WJRrqinmdXoUJtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww7VW5ZCFz4f3kvh
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:27:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 597AD1AC989
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:27:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgDXSoFeZtFm1Ph6DA--.26548S2;
	Fri, 30 Aug 2024 14:27:47 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	kees@kernel.org,
	mcgrof@kernel.org,
	jannh@google.com,
	ardb@kernel.org,
	song@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	wedsonaf@google.com
Cc: zhengyejian@huaweicloud.com,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] kallsyms: Fix wrong "big" kernel symbol type read from procfs
Date: Fri, 30 Aug 2024 14:29:35 +0800
Message-Id: <20240830062935.1187613-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXSoFeZtFm1Ph6DA--.26548S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5KF4DAF15Jw45Ww1xXwb_yoW8GryfpF
	1rJrWqvrn5Gw1jk34UJF4UCryDJws7Wr13G34DtryfCFs8X34I9392ga429w1UJry7GFy0
	qanakFW3t3WDAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
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

Resend this patch due to no reply more than a month.

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


