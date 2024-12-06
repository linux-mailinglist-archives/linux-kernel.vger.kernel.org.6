Return-Path: <linux-kernel+bounces-434863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB79E6C24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AF6163A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C85211702;
	Fri,  6 Dec 2024 10:18:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7D212B32
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480312; cv=none; b=kVYfMOh6oElNSUpfqqVFc8QEOR7cMKth6iWj+Y8lugJGntcgK8gpVYIh3PKeIs7G7CaM9K4WMJfsyzd/Z9/eItR+TioMHhKJdxevjym9YfPxbjsO2DQerTHjOLzlO7s4UEhMXfj5Iqq5sVWsY4TXM2fqbstLHvM5zp+Txg6T/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480312; c=relaxed/simple;
	bh=+gLFti/3mLJXuSrrgp1/CTOIQla4r+7KOhnM62CIjYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHzae7o53R+H3zlVbCirvKeV/G10ZvZW4H5fFfS0x63CBktbbx9CH9z2auiHQ22k4ch+VHQGVhFzz7bLfHueUcgo44w22w6C3rM1oikD9GUKeZ4PHR360Jkqy74l/r6FcE81hkH2HfIXJvf4HOmQdE/YdrTgfpGb90DmXpm/5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4Rx553lHz1kvW2;
	Fri,  6 Dec 2024 18:16:09 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id DBC6A1401DC;
	Fri,  6 Dec 2024 18:18:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:27 +0800
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
Subject: [PATCH -next v5 18/22] arm64/ptrace: Expand secure_computing() in place
Date: Fri, 6 Dec 2024 18:17:40 +0800
Message-ID: <20241206101744.4161990-19-ruanjinjie@huawei.com>
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

The generic entry expand secure_computing() in place and call
__secure_computing() directly.

In order to switch to the generic entry for arm64, refactor
secure_computing() for syscall_trace_enter().

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b53d3759baf8..c0c00e173f61 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2368,8 +2368,11 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
-		return NO_SYSCALL;
+	if (flags & _TIF_SECCOMP) {
+		ret = __secure_computing(NULL);
+		if (ret == -1L)
+			return NO_SYSCALL;
+	}
 
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
-- 
2.34.1


