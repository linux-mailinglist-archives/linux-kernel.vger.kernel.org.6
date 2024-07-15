Return-Path: <linux-kernel+bounces-251980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37CB930C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BCE1C20C38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD75234;
	Mon, 15 Jul 2024 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G+VxxD3X"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7033FD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009448; cv=none; b=bVBVypL5TG/19FwN7IOMJSEb2hj7Rl/W/IUx5uv6bB0/qOex+ek2rY1UkLQF4eLW0U6vXkoV/meqxhp8yG5Ajo+epcYALt2kt+soUmxgV4mbsRlQu+f1uksbOrXJwq2i586LUl+nW4pl6HRTuKB+WdF3CyOnjgR3/3P1VsNGkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009448; c=relaxed/simple;
	bh=G4mzLKgzP0chr+4VbEtyCBLf/eVfEdJRPTczMQAfuf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ar3loJDCBB7/chtTgx/pY9W9vQIxWK779eQvTzGp6fnRHi9YEEFRvmBNF27uz8zViXQI1Kg+qZ6PH2D27q53kTcpRBqrFza2frAeBg4FCDnn0bCTd7OjU0XZT8i3rk6B/HB+NW1xs350zvH4P0mGBnovcULYEsTnCAwg40BU664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G+VxxD3X; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721009438; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mOeyWGSqltDKYSREtaKmHh7sxtGzpkXxUNzRN8qtkQ4=;
	b=G+VxxD3XX7qycmlEvJKrjtp5mI+elbUELHIsLMgpLo2J6MYxHEmCZ01y7chWaNiQFYaBgU5NyFk3/fSiYfH+6d54/606Kfj5il4aVXXhqBr3by6QK4vY5FuQWdDYMfEbNG+SuYXW2WX1eWXS/OF6sKo2GplsfKwx+Gr6cWnhCj8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WAUs-h8_1721009428;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WAUs-h8_1721009428)
          by smtp.aliyun-inc.com;
          Mon, 15 Jul 2024 10:10:37 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: tj@kernel.org
Cc: void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] sched_ext: Fixes incorrect type in bpf_scx_init()
Date: Mon, 15 Jul 2024 10:10:26 +0800
Message-Id: <20240715021027.77700-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type_id is defined as u32type, if(type_id<0) is invalid, hence
modified its type to s32.

./kernel/sched/ext.c:4958:5-12: WARNING: Unsigned expression compared with zero: type_id < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9523
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f4a7abcec793..7ddeaa43b63d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4952,7 +4952,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 
 static int bpf_scx_init(struct btf *btf)
 {
-	u32 type_id;
+	s32 type_id;
 
 	type_id = btf_find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
 	if (type_id < 0)
-- 
2.20.1.7.g153144c


