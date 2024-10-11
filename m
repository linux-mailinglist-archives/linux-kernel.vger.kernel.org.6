Return-Path: <linux-kernel+bounces-361064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1177499A2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4211E1C22AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56867216A0B;
	Fri, 11 Oct 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4g3wEPh"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC1717D2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647172; cv=none; b=DJ8e+b0ubyNFKV2cLtfcM3Dy6OHCXgu04bgSuj2C15GGbxqGkYZw4FzCO1EjQ9EemurV9OndnQMF6MoMNCY+ox+VZj/6yLl6Tx18gzjLoa1zy6P/E8PcobRytzNdTW0bIHRH6jqvCbEh0hw4Wlqe4HtECESjrdUe45qVj7trq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647172; c=relaxed/simple;
	bh=q9JaW72xhNQODHCW8uPiP8ifxJeQ4I57PtepsnhlQCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVdsbTDmlas/7/aJboyoZQD3rr+IVSoeriYqkyqNiboxD7uYxs5EqQXiOlqw6OBiqR3udg35tcsbAUyh/TMwhVtLPX5b5rVGSVQ9v3KLBCUCdrLcHfCU0FuvrkD7fGJKEXt/nLj5nDq2zEVfYu1/qyLEk86nIaSynQxUZFwnzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4g3wEPh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so320331a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728647171; x=1729251971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dh0JsT1PknEj7URfHm3XckV7bx4afAgP2FtAaB0E9bA=;
        b=F4g3wEPhUUvdga/uKkYQ33Vmm1fHl0xBZq3BhATmKRUL66bPIEc6ppbocCLgZiPkiZ
         ALSii5shqcDlu3MeWVe9Y0xoUqKX1EFzY6mVitSOsaEJg0Eyn/Q9cgKEdxBw0M2gytcd
         5iVKW44f3Q3wEepFS+i9vEi31wXuvuT/A8Wi254jbW6XaPxJDBhL2fx85zZjRuzvVqhK
         +fOHq6vgxyaQ6ZS4lmcEUcc/H9Axqbd3OBHzKHDa/moeSuXhgASm1qS2PrkxxCECIrwd
         uUt/7HN93BB2jSfPjvZNQQ26d2Cv3+ru5iSc1bT2RvM9BOiAsgVjprBsWqIlvG1D9Mzc
         lyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647171; x=1729251971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh0JsT1PknEj7URfHm3XckV7bx4afAgP2FtAaB0E9bA=;
        b=lknNIRS4Jl8N8cedOnCqLXxbbnPWsrCgWwFDl4m9VELJE6P+nvfnrlghZrWNj6SezX
         G2IVGHP1BFPDsou+38KGPvowoE0RVjsqUVuCMEWpdSYdmD8+1rlf6t8gwYt41tgJ06Ev
         VNWjKIo2q6m3vdqL3I5S1t4KWE/RgGmFKEPUlym1s+puHDQ1e8PW/v8TKxHEv40SZo+R
         czgNM7ho+aFpysbiPxeNEdhHQPNP0TqPGsY9jPK2Q6/yDR+jtpP91ZHHJXHoACr9m6O9
         5y2B5JYaMY3o11WcBewj8CRtc4r6GBF14yxLm/hpn+nSBjH8sPiI9zXVsKEJbyKCX4l1
         LXPA==
X-Forwarded-Encrypted: i=1; AJvYcCXB1+UqY6GUW9AwjEeNNFWX0B/uMtRRodB7lkuZcghIWZQv8tbqqB6kNyRaRyqim1QnI8lCA2E2EVeoOIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5y24ZsciiW7rGu4X/DdJOFu6IEU4JSRbQqqUQqlpOvMaQKImF
	2udIXSWHSHnnSNZrJr0UxOwq0ZjRSVBLuDyJLC0ALIxKy1T4xy95
X-Google-Smtp-Source: AGHT+IFUfBiftskmge97vNioQrB9NznTrJWcEA4rGHaYPM1pLAobyBMBxiXwmUDLrdbEl6ptsCd8Vg==
X-Received: by 2002:a17:90b:3509:b0:2e2:de92:2d52 with SMTP id 98e67ed59e1d1-2e2f0e0403amr1317867a91.9.1728647170482;
        Fri, 11 Oct 2024 04:46:10 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2f6e9ec0esm1106025a91.28.2024.10.11.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:46:10 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] mm:kasan: fix sparse warnings: Should it be static?
Date: Fri, 11 Oct 2024 17:15:38 +0530
Message-Id: <20241011114537.35664-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, when making the global variables kasan_ptr_result and
kasan_int_result as static volatile, the warnings are removed and
the variable and assignments are retained, but when just static is
used I understand that it might be optimized.

Add a fix making the global varaibles - static volatile, removing the
warnings:
mm/kasan/kasan_test.c:36:6: warning: symbol 'kasan_ptr_result' was not declared. Should it be static?
mm/kasan/kasan_test.c:37:5: warning: symbol 'kasan_int_result' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
v1 -> v2: Used the aproach of making global variables static to resolve the
warnings instead of local declarations.

v2 -> v3: Making the global variables static volatile to resolve the
warnings.

Link to v1: https://lore.kernel.org/all/20241011033604.266084-1-niharchaithanya@gmail.com/
Link to v2: https://lore.kernel.org/all/20241011095259.17345-1-niharchaithanya@gmail.com/

 mm/kasan/kasan_test_c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..7884b46a1e71 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -45,8 +45,8 @@ static struct {
  * Some tests use these global variables to store return values from function
  * calls that could otherwise be eliminated by the compiler as dead code.
  */
-void *kasan_ptr_result;
-int kasan_int_result;
+static volatile void *kasan_ptr_result;
+static volatile int kasan_int_result;
 
 /* Probe for console output: obtains test_status lines of interest. */
 static void probe_console(void *ignore, const char *buf, size_t len)
-- 
2.34.1


