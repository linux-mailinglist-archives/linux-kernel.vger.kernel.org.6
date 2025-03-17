Return-Path: <linux-kernel+bounces-563245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69168A63AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888E3188D915
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3113C8F3;
	Mon, 17 Mar 2025 02:04:16 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2114A24
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742177056; cv=none; b=Ark5Cej6JICHqRC5YIHP/kReM5493XHP10luY6LdffspB0GFVC46tIZD3KNM6wrm9q47VBLefPe3TEWwSbOLPcGWVrv+xNa2JAaL3aI4KQ0VZC7MJv8Z1mqj/NXFDVK9l0jFvF5F9GzrESmGqFdOCqT4TFSpmc+R6VUS6BXAmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742177056; c=relaxed/simple;
	bh=GDjFx2ZSW6UlP+/snnNSPHU7c4PhpKJv6NxFtV6RBNM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=A24n7gwyId48SRKtcD3It8DOkLBfnoef49Rl35QzVcdAwib4D86p1xp2dWU49te5HRKes2e5z36hMynNOXX2M2oRBMgvj1KZxrpTcJJEfvkXWPLsMdJzdrq9mX2OL/X8+fSwP91npSi01Nul6Iczl/P1Ipiohq+9U55c527wcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGJDq4Wdnz5B1Gr;
	Mon, 17 Mar 2025 10:04:11 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H23bl8092409;
	Mon, 17 Mar 2025 10:03:37 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 10:03:39 +0800 (CST)
Date: Mon, 17 Mar 2025 10:03:39 +0800 (CST)
X-Zmail-TransId: 2afb67d782fbffffffffd21-03382
X-Mailer: Zmail v1.0
Message-ID: <202503171003390456Yg6kZ_SCP4juDHanCR7J@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <jbaron@akamai.com>, <jim.cromie@gmail.com>,
        <linux-kernel@vger.kernel.org>, <xie.ludan@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkeW5kYmc6IHVzZSBzeXNmc19lbWl0KCkgaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H23bl8092409
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7831B.001/4ZGJDq4Wdnz5B1Gr

From: XieLudan <xie.ludan@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
---
lib/dynamic_debug.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..83ce3f310ab9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -795,11 +795,11 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)

case DD_CLASS_TYPE_DISJOINT_NAMES:
case DD_CLASS_TYPE_DISJOINT_BITS:
- return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+ return sysfs_emit(buffer, "0x%lx\n", *dcp->bits);

case DD_CLASS_TYPE_LEVEL_NAMES:
case DD_CLASS_TYPE_LEVEL_NUM:
- return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+ return sysfs_emit(buffer, "%d\n", *dcp->lvl);
default:
return -1;
}
--
2.25.1

