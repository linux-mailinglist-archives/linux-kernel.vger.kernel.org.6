Return-Path: <linux-kernel+bounces-576686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E5A71309
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D743B911A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0451A8412;
	Wed, 26 Mar 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCJ4vgjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B01A4F21
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978886; cv=none; b=if91jzV729JAwXfjaHXbUz1ThXGLHqf2oq52SyBWCN0A+5Zzf2Nq+Rsfnv0SLTTkp9+yTHvgWeIvAIKVuK1TApAJoGIrtiZZiIgGp+1rdPND60B08Fg4EbfjEwke73ld45ZaJo5WM34at5aa1GJKVkDe2HYW9/4dZNG038WQ4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978886; c=relaxed/simple;
	bh=/rS5pVho0QtfCxm0/PsZq0BHiFHCltn4BrsMWAHguTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npAAfBplEfs+YDgOMXQSGbBwjUtmBCvwa23UMkDF1Y4UjAOw5KHsHIL+SSTaJjsWwYxS5m5sfjsI59YDHNo+s4VmgtptwN0xpyxMTF6p64XrESplLF/wzm3A8LIr6UN5cqR0nCVy7GOw+e+ctcnt+3VSM40TRb9mn/2Q4X7pdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCJ4vgjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFB7C4CEE2;
	Wed, 26 Mar 2025 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742978885;
	bh=/rS5pVho0QtfCxm0/PsZq0BHiFHCltn4BrsMWAHguTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCJ4vgjTl6aRSJq7u4bJ0HRq3lI0CMWnW4KUparyZ7dlg82GmBln+dCdY0dXlrv4G
	 ZVS8PaiKQHfr5NeCk6+TyDq3jbV3/1ID98JwZub8QjA2dNB/v2ykU7wHzmtkxChfpP
	 Q8oGkWGUfjZfF/eofkBy7Q+6XTWh8Qq9TH91KNx0vCut9No0j1yXizE8EswRT3DrLm
	 T2OlHExoFPw3ZlpxWzDBGtTwMif0ROn7xYIeHaEPI05l6keid0dXzuh/PbKsC9qa3M
	 nlhdWG5gNF3M6DVAH5RltkbAaGtgFRnngdmRg5PBnJCp3jvmYMz8cKgZCuNGFtSGb1
	 o0eKnfMM4Wzvg==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/5] bugs/core: Pass down the condition string of WARN_ON_ONCE(cond) warnings to __WARN_FLAGS()
Date: Wed, 26 Mar 2025 09:47:47 +0100
Message-ID: <20250326084751.2260634-3-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326084751.2260634-1-mingo@kernel.org>
References: <20250326084751.2260634-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow architecture code to print out this information.

The format of the string is '[condition]', for example:

  WARN_ON_ONCE(idx < 0 && ptr);

Will get the '[idx < 0 && ptr]' string literal passed down as 'cond_str'
in __WARN_FLAGS().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index af76e4a04b16..c8e7126bc26e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -110,7 +110,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS("",				\
+		__WARN_FLAGS("["#condition"] ",			\
 			     BUGFLAG_ONCE |			\
 			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
-- 
2.45.2


