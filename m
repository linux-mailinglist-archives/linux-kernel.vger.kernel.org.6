Return-Path: <linux-kernel+bounces-395761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989039BC289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503FF1F22F56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1407B1CD02;
	Tue,  5 Nov 2024 01:27:13 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD411CA9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770032; cv=none; b=AzCg8jHVP/xlpcNO/CkTtLuAwlPjC52cUHqF2mgOaqgjyijsD4o/UXb2gz6OKCNnE3ENIehWsN4MFQnwPLvfv/s8rhvpoGk6bXg8aj/YkmMVWXpKxMbSHhqKJSxCRCLIWwfSUtFS9eNN4N6ukFa5kqMonopFlcvOGMHii2ggiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770032; c=relaxed/simple;
	bh=lN2uE1K9qAc18/gduVxEJq69tYljSyoL2t5EPfd36XM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8/Ysso2mPH6+twbWddMi2hZFwKKK4FbAusRLyJU9dOeJgywVJFCzGn1I1GTW32r9h4cV51sYL4hQP59lJIQEuPOyjjAj7mSpgGkjLzXEgDUKPAG6iaDBpJeYMiixW4OvtZu+Fi6a3RgJPb5SIoTx0jg8B8czkxI3qf2478+13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2672973b1cb9-05cd1;
	Tue, 05 Nov 2024 09:24:01 +0800 (CST)
X-RM-TRANSID:2ee2672973b1cb9-05cd1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9672973b0c69-c9c3b;
	Tue, 05 Nov 2024 09:24:01 +0800 (CST)
X-RM-TRANSID:2ee9672973b0c69-c9c3b
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: bp@alien8.de,
	tglx@linutronix.de,
	x86@kernel.org,
	darwi@linutronix.de
Cc: x86-cpuid@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] tools/x86/kcpuid: Fix the wrong format specifier
Date: Tue,  5 Nov 2024 09:23:47 +0800
Message-Id: <20241105012347.201782-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use '%u' instead of '%d' for unsigned int.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/arch/x86/kcpuid/kcpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a95..b94071ec0 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -117,7 +117,7 @@ static void leaf_print_raw(struct subleaf *leaf)
 		if (leaf->sub == 0)
 			printf("0x%08x: subleafs:\n", leaf->index);
 
-		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
+		printf(" %2u: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
 			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
 	} else {
 		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
-- 
2.27.0




