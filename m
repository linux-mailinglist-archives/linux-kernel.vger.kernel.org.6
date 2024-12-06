Return-Path: <linux-kernel+bounces-434867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904309E6C20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F83E288400
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2142E215F46;
	Fri,  6 Dec 2024 10:18:37 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C52144B1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480316; cv=none; b=IkPgzIT+8p3ILkX76UcgFbn+mznBw03Gbef+4/V9OUSdlEL6UlzuU3c9w4N3BJCfykrmovoTMqwI0PkoYUG+HmtNhs9hVoqDwuh3mYK7yIWS1K5hqPy8uxEmli7SOkrXELO5Q415uqKVkHEe/fTnN988kx0PO97KDFmwnsxesaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480316; c=relaxed/simple;
	bh=VxaLRn3ARxNYR9P6Mzk4WJEMDHtaBCBbdJPioxFWoWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEcjg1fNUv2YymVw2P2pvYdjQ3d0vSV7zCY4AT17OuHqY/RJ0HtzE/SbMkEuOraLeOU8j0Kvb82zgqsfqsm1ljzKYBjaHIocj9xhapXdZdDb3kDvpx3A7WoVInia/rQ4eJyxK/+V4XjPulssAPrU24daGcD/rSDY1lFwvqK25tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y4RwP2rcJz1V5h9;
	Fri,  6 Dec 2024 18:15:33 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 728BD1800D9;
	Fri,  6 Dec 2024 18:18:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:31 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>,
	<masahiroy@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<rppt@kernel.org>, <xur@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <mark.rutland@arm.com>,
	<ruanjinjie@huawei.com>, <pcc@google.com>, <ardb@kernel.org>,
	<sudeep.holla@arm.com>, <guohanjun@huawei.com>, <rafael@kernel.org>,
	<liuwei09@cestc.cn>, <dwmw@amazon.co.uk>, <Jonathan.Cameron@huawei.com>,
	<liaochang1@huawei.com>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<broonie@kernel.org>, <thiago.bauermann@linaro.org>, <kevin.brodsky@arm.com>,
	<joey.gouly@arm.com>, <liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v5 21/22] entry: Add has_syscall_work() helepr
Date: Fri, 6 Dec 2024 18:17:43 +0800
Message-ID: <20241206101744.4161990-22-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206101744.4161990-1-ruanjinjie@huawei.com>
References: <20241206101744.4161990-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Add has_syscall_work() heleper and use it in entry.h. The benefits of
doing so lie in the fact that it can be used in the architecture code
that uses generic entry.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 include/linux/entry-common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d11bdb4679b3..3bb5d7d839f4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -43,6 +43,11 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
+static inline bool has_syscall_work(unsigned long work)
+{
+	return unlikely(work & SYSCALL_WORK_ENTER);
+}
+
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
@@ -90,7 +95,7 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	if (work & SYSCALL_WORK_ENTER)
+	if (has_syscall_work(work))
 		syscall = syscall_trace_enter(regs, syscall, work);
 
 	return syscall;
-- 
2.34.1


