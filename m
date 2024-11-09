Return-Path: <linux-kernel+bounces-403014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B251E9C2F93
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9E82820BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD71A0732;
	Sat,  9 Nov 2024 21:09:18 +0000 (UTC)
Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBA2E628
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731186557; cv=none; b=ndw3rsKou70cYZZlTs/bVc2j/luHmN7JwUVbAefhrXgXqgVPx2iqoMrigMINEzj6KmsZX12CMSxUh6O3fihz3x3T+cE2l5wGoRl2SPRGHWe8Q0U0BhE6ecVYKnawdIPp8pS/j3EFk8b2vJkVN2UHSoYYTY5pE2oM384Q0v9+7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731186557; c=relaxed/simple;
	bh=WjoVoQJz/3ZZ322HTDKYLDWmAGvr2cXEClLtms8+oi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoithjKS29TeYgyehYhw8tMFyu8N08YtusXGufly5qW5KTERS+C/vHSZCnHjtpbwQMO6IYgpbZoCg0vpLM/dCuk6lTdHHZwJ40r7alE1r54FFUBAvAlJTrdHXDoe7Mo/VZ87WHVze99x1sM/f0iB9vEeJBAncfkLgH6icny/bnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.ykf.mikelr.com (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by yyz.mikelr.com (Postfix) with ESMTPSA id F09E572671;
	Sat,  9 Nov 2024 16:03:37 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Mikel Rychliski <mikel@mikelr.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix off-by-one error in __access_ok
Date: Sat,  9 Nov 2024 16:03:12 -0500
Message-ID: <20241109210313.440495-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We were checking one byte beyond the actual range that would be accessed.
Originally, valid_user_address would consider the user guard page to be
valid, so checks including the final accessible byte would still succeed.
However, after commit 86e6b1547b3d ("x86: fix user address masking
non-canonical speculation issue") this is no longer the case.

Update the logic to always consider the final address in the range.

Fixes: 86e6b1547b3d ("x86: fix user address masking non-canonical speculation issue")
Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 arch/x86/include/asm/uaccess_64.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index b0a887209400..3e0eb72c036f 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -100,9 +100,11 @@ static inline bool __access_ok(const void __user *ptr, unsigned long size)
 	if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
 		return valid_user_address(ptr);
 	} else {
-		unsigned long sum = size + (__force unsigned long)ptr;
+		unsigned long end = (__force unsigned long)ptr;
 
-		return valid_user_address(sum) && sum >= (__force unsigned long)ptr;
+		if (size)
+			end += size - 1;
+		return valid_user_address(end) && end >= (__force unsigned long)ptr;
 	}
 }
 #define __access_ok __access_ok
-- 
2.47.0


