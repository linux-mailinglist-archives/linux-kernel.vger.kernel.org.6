Return-Path: <linux-kernel+bounces-371427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D59A3AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA7628483C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6A20110A;
	Fri, 18 Oct 2024 10:08:42 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36840201103
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246121; cv=none; b=azKulvGwx0k6R0yZPl9UGDrNohnRPEqmAFcMXIEoljlJr2DKBC48e6/yokipjsSOGU53M9TBXZ4Y9ps9GVKzCGu2rYivlt8utGZwnHj4Y5KpmfPYv/zK8ZQlCEVQYLE21goUYELR2n3TuPv6xCvLjxH3jn2QiNUTGIU3ZkzHA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246121; c=relaxed/simple;
	bh=5AaJVWCvpsgC2thALquLh9TSVm3lksuVesnha6tcz98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=beamyUL2+1OwMMXyfldjmWkygbLeWNLJtG/ky5VJAhou7pLGnXuhApEMr0B/L3LvGhxyIZ2C2sWScPQXrTQSaxifTtTJxDwU43rfCDReO3xC5IIAXeB2I+092a8uTGZaBhz+aACWLJX/j4m+Z+g3E+RB3wFhiETHB9UvXDZoeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XVL460xqKz20qbq;
	Fri, 18 Oct 2024 18:07:50 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B6FA1A0188;
	Fri, 18 Oct 2024 18:08:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 18:08:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<kuba@kernel.org>, <ruanjinjie@huawei.com>, <richardcochran@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()
Date: Fri, 18 Oct 2024 18:07:48 +0800
Message-ID: <20241018100748.706462-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

If get_clock_desc() succeeds, it calls fget() for the clockid's fd,
and get the clk->rwsem read lock, so the error path should release
the lock to make the lock balance and fput the clockid's fd to make
the refcount balance and release the fd related reosurce.

However the below commit left the error path locked behind resulting in
unbalanced locking. Check timespec64_valid_strict() before
get_clock_desc() to fix it, because the "ts" is not changed
after that.

Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- No longer against -next.
- Update the commit message.
- Add Acked-by.
---
 kernel/time/posix-clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 316a4e8c97d3..1af0bb2cc45c 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -309,6 +309,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 	struct posix_clock_desc cd;
 	int err;
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
@@ -318,9 +321,6 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
-	if (!timespec64_valid_strict(ts))
-		return -EINVAL;
-
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
-- 
2.34.1


