Return-Path: <linux-kernel+bounces-339250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352A9861B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB8828D81E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1F148FE1;
	Wed, 25 Sep 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GqQdF3hL"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B5146D6E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274764; cv=none; b=AbtHKkoGqKfZ0M+1nHTIFH1SYycgoO6sVODBuYN5S8siUWJoaXwh81heTSxdeIZw7+3ONLMBmRCtKR1gjxrMFIPv7tJfLnNH6Iri298OqOxuPEnOwqrcxFQ2DQS0gkNMGSRhHGtyEKicto/nOpCeV/k8J2s+fm/cLc9J8zR2K1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274764; c=relaxed/simple;
	bh=4qo+IQdmg7WiLTGP05XJImDyaP+xYUxgRZ7TdCBlsjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=usIE+noxnKeHadHeNTueXG4v0ZQwLYhLZSGSG3k1Wqee8DM433hgPt2PHtjLwS+2EEbqHaEhNrYJO6Kz04UM65sRAYWHCo/jSXOfcWejhnr9HQ8MxHotGseeDK5CPBcgdxRp4w5Ijbu5Dd91i8TF4QWLsBtiv3lpz7lojuQZR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GqQdF3hL; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BsZEU
	eQ9k4bTBrNUrJok+wdi+IT5a6ZQC1jhpS7yGY8=; b=GqQdF3hLkr7KzZSdZTBUZ
	9d+bzIYn/ORHFo4lBidHtg7U06c1aUx5kxMusvMDKjgRSNDLNBeLePQKIrGm0o7B
	iNws92aGUDW2+rTvAyPnAEJfAuE41I0RLzS4v4pMXr9/WxnNgBEGz6+LwwgCaHZm
	HOc941WvfeBp917Wfxkw3I=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn9EXeHvRmGMqpJA--.33673S5;
	Wed, 25 Sep 2024 22:32:06 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: elver@google.com,
	tglx@linutronix.de,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH 1/4] kcsan, debugfs: Remove redundant call of kallsyms_lookup_name()
Date: Wed, 25 Sep 2024 14:31:51 +0000
Message-Id: <20240925143154.2322926-2-ranxiaokai627@163.com>
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
X-CM-TRANSID:_____wDn9EXeHvRmGMqpJA--.33673S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4UCFyDWr47ZrWxWr15Arb_yoW3twbEq3
	y8Xw42qr1DAF9rZryqkrWrXFZ5W3y5JF4Sv3ZFqF17J34DJw43KFZxWrn5Kr95Wrs7Gr4Y
	k39Ygwnxt3s2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iZ23UUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0gdlTGb0HcIXZAAAsC

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

There is no need to repeatedly call kallsyms_lookup_name, we can
reuse the return value of this function.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/kcsan/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 53b21ae30e00..ed483987869e 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -181,8 +181,7 @@ static ssize_t insert_report_filterlist(const char *func)
 	}
 
 	/* Note: deduplicating should be done in userspace. */
-	report_filterlist.addrs[report_filterlist.used++] =
-		kallsyms_lookup_name(func);
+	report_filterlist.addrs[report_filterlist.used++] = addr;
 	report_filterlist.sorted = false;
 
 out:
-- 
2.15.2



