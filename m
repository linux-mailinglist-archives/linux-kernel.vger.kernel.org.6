Return-Path: <linux-kernel+bounces-339253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B59861B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642591F2B910
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ECC18C348;
	Wed, 25 Sep 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dfL9K7oa"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5518C004
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274772; cv=none; b=uT4nQY2+7C6iA49LO/e8/+pcsudzdY9rKFEM+DI6MDtrEXyHEylrAG6728LZfBhH+t9pZV7/deqHWZJ53m2Q49B/sZmD7s5nvFoYNVjlLclA2BCXV2n+yaD0NcrPVfArJgESuPl7TSuyBgLTdexyEgKFYlvBRIKRsYbeS+P25sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274772; c=relaxed/simple;
	bh=9hXniMzHG8iE92aMEhzcFR7plZHS0qL/TXHqDgDnhPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnVQpsUB+xXTIXHY9FGmrnyrb0p5mjjLuJARcRdkwMPui835xYGlLuhFPbC0nZXPjL9ePLi6osOVOgT5gVFRCRIdS1ZD47IOlGAsWWA1yhb6k7veyqdHX1YTDRZgIDBv2k0GSarLzvUIybPL+jbfcHa5JTY5eswxCR8vbmehlzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dfL9K7oa; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7/NB/
	v2fjTsmnyeIo9rDAFMjTCqI92mCnWuv5aDhiWo=; b=dfL9K7oa1gJVJZ2PTUQ5e
	S9Ae1QsUA8CShbWVfOoA2vmfEkzF+wbGMDdGlNJhmpkM4xqrf1Mo6JzsDc8gCLys
	+tVC1kCtNqdJXYKO+Geb7Q825dXpBQxK3GuHDdnqycdIn9K2TD1TIR7IgGwU8vlp
	OFgVbNWGRjKUiiY8VLlnQM=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn9EXeHvRmGMqpJA--.33673S8;
	Wed, 25 Sep 2024 22:32:14 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: elver@google.com,
	tglx@linutronix.de,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH 4/4] kcsan, debugfs: avoid updating white/blacklist with the same value
Date: Wed, 25 Sep 2024 14:31:54 +0000
Message-Id: <20240925143154.2322926-5-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925143154.2322926-1-ranxiaokai627@163.com>
References: <20240925143154.2322926-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9EXeHvRmGMqpJA--.33673S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3Cry7CryxtF1xuw1UAwb_yoW3CwbEq3
	ykXay8Kr45JFZxur1v93yrXrsYy345AF40va4fKa47J3Z8K3ZIkFZ3XrWqgrZ5uFWxGryr
	A3s8Krn8WryftjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU05l1DUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0hhlTGb0HcIX-AAAsF

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When userspace passes a same white/blacklist value as it for now,
the update is actually not necessary.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/kcsan/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index d5e624c37125..6b05115d5b73 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -142,6 +142,9 @@ static ssize_t set_report_filterlist_whitelist(bool whitelist)
 	old_list = rcu_dereference_protected(rp_flist,
 					   lockdep_is_held(&rp_flist_mutex));
 
+	if (old_list->whitelist == whitelist)
+		goto out;
+
 	new_list = kzalloc(sizeof(*new_list), GFP_KERNEL);
 	if (!new_list) {
 		ret = -ENOMEM;
-- 
2.15.2



