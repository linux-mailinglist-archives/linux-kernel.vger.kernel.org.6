Return-Path: <linux-kernel+bounces-369872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D282A9A23E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074501C20754
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5631DE2C9;
	Thu, 17 Oct 2024 13:33:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08B1DE2DD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172017; cv=none; b=GpQxmmSj55ITnNf4+YIls93wceJyme0+8BvjYHWZ5bVD5Y0PiQj9Uxoc/3eubEqwl3iFJgSxhTgmi7Mrcc3XSR4O2JbogSGv45WLffRS7Ux398r8TxmbfiEfPeMkd17rDHZTfVB1PGM+cmSUZHi2nq/kZIXGHw2G2sY7damxhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172017; c=relaxed/simple;
	bh=QsEucQCZw9ViS0BGkEEGFfrSjiN1H+wYjHjdUicOmPY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rUqlQxdOBQ7u6iTG6GiIU5+MeldNnwSZrkc7FjFFdKy9UgpLVohaqikIn/05JjLXY/ahcbzR0N9yLeN0+tsWeVXP4W8rWAfdp5TvSJf/CEX6oBwtz7Lm1EMo5kPVt3sZ01Hx5jybOQ5/ufd+A+rwKzDeAaKELc+xNVpKQdr28MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XTpdc1s7tzcpSN;
	Thu, 17 Oct 2024 21:31:32 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 67B2D1800F2;
	Thu, 17 Oct 2024 21:33:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 21:33:29 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<richardcochran@gmail.com>, <kuba@kernel.org>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] posix-clock: Fix missing put_clock_desc()
Date: Thu, 17 Oct 2024 21:32:49 +0800
Message-ID: <20241017133249.3496025-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

After get_clock_desc(), it should call put_clock_desc()
if timespec64_valid_strict() check fails, put it ahead to avoid this.

Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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


