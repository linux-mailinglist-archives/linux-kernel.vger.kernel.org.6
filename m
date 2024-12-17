Return-Path: <linux-kernel+bounces-448984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0FA9F47FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B51888A67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2EA1DF73E;
	Tue, 17 Dec 2024 09:47:36 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A61DEFCD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428856; cv=none; b=Zb7befU/RgM1tq4oWUp+jBCPHimgrulMcDCpDxuMXNr1+H/mSJA8KYDCI3uAlUbkMe42j88xSOecI26PoDM+zTd5Ff8rSUpFurpNtxaf1g1nD5ltt0TKDgKyxgO0P/KEOuQV9Gl24X0tLY2v1hf9ZXoHXGJrJh2YljHM8ibUUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428856; c=relaxed/simple;
	bh=p8DpvzbfqeDTJMffXQkLLbTD1b0QmlbYpI6bUc0ip/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NjxQvZUcbEVbrcSCo5fmMArYhlQGDxs6XIyoZeKAiTrcIQEtc0e/dxjXXOjMLpVvUTvaPhgCrXC8hVquv2ts1G75CDI1TjjJ9pw9zHBsbIfl9wrJg37BdEm/bALV6lLykMNmXflWJ+qz17d9dOd8hKFKlcOLUi9DAuP8Tdx9fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2676147f4c8f-70cd2;
	Tue, 17 Dec 2024 17:44:20 +0800 (CST)
X-RM-TRANSID:2ee2676147f4c8f-70cd2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9676147dd28b-72ed1;
	Tue, 17 Dec 2024 17:44:20 +0800 (CST)
X-RM-TRANSID:2ee9676147dd28b-72ed1
From: Zhou Ding <zhouding@cmss.chinamobile.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Zhou Ding <zhouding@cmss.chinamobile.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86, boot: Fix missing `has_cpuflag` prototype
Date: Tue, 17 Dec 2024 17:43:50 +0800
Message-Id: <20241217094350.1166239-1-zhouding@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We get 1 warning when building kernel withW=1:
arch/x86/boot/compressed/cpuflags.c:4:6: warning: no previous prototype for ‘has_cpuflag’ [-Werror=missing-prototypes]
    4 | bool has_cpuflag(int flag)
      |      ^~~~~~~~~~~
Add a function declaration to cpuflags.h

Signed-off-by: Zhou Ding <zhouding@cmss.chinamobile.com>
---
 arch/x86/boot/cpuflags.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index 475b8fde90f7..fdcc2aa4c3c4 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -18,5 +18,6 @@ extern u32 cpu_vendor[3];
 int has_eflag(unsigned long mask);
 void get_cpuflags(void);
 void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
+bool has_cpuflag(int flag);
 
 #endif
-- 
2.33.0




