Return-Path: <linux-kernel+bounces-339381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E198643D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B02B1C26874
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346FF199A2;
	Wed, 25 Sep 2024 15:56:31 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6131A29A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279790; cv=none; b=D/i8R7rbPfjIitQQteNrMk7udKpd7ssBVxMNkiCLQr3ZydEWCPvX4jj7sweyeG0Ea9BfWJdIlUiuppmhCuKAfK3NGRxGnbpqcFP0vkF5yXMSVHKMMmY24ZJKNSAx1Ar+OFCazIbZh+aVfRQ1WQjCV26J9q626chDttH1ub9wU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279790; c=relaxed/simple;
	bh=CIp/l6tYI+u7YR2VJVBHZwHcYbvsSX7uJzRJO8fWMt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udNlPAKu8M3gcub6O6EXpDu/egoauedopDU3ao7HosR2rLU555boJ41JjKw3GvWsS5u7rU0LMBY9nAuh+5txfEqkCFZ7ywf2BzyZaxK5E7CCnbxbdX8ui5wk3Ln8yFRp8WFTZT4jTuFpnQAYSVvnEyeEJ7mk4lEO49+KOl/BK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71798661a52so70610b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279788; x=1727884588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EGKCLuEpsZX8eShN6EA6IJ5o9oCBmRtPZ33EEovFzc=;
        b=uhDE1kJCIyJmTDgwZXTcJ0uUWQOhDzYsBC07t3NBhCVrr16MMC0dMrp4DVS+rkjjoT
         922t9w1P7w4s0qnXpMJdbw2dg8jgWbMPjYmHvE1asw2ISfDafHUrLJWdN6UI12C89M6F
         swz2zkKL6T5Kl9USym945Enc5cHRgFXWUcd/orZtaTwQt0zc5pscQyu9PdzUxJOrHzY1
         8PZRA3vsulxvVDkjVh0qab+8npAQ3/tcCRDj/F1gOhPY9WrLPqBSzLWuFOHyIbKEh/jz
         IB/p88t07s2H9G7z5Ow03M6o3LFB9RMy7TyMMHmFxEPomHAmpzLUSqvOY/YRM/5PeokI
         zHjA==
X-Forwarded-Encrypted: i=1; AJvYcCW8AhkAmtZVpwYY3pLuAgwCS0R5ItduvFyioQDHKaFRdJiAukcRAa1FqqIMwHKO7ocaWGKOc0GyxpzxyGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+u4oAdrSFTyfcOTGEe2jjgZvonlyWWf4ODNJfKe4MCsich4mN
	FlIDAa0vWGYMdXVCxwjcSrQiLytEReNcvklEmJZ1P9sc5ICbG/NO
X-Google-Smtp-Source: AGHT+IFfjaADO2ScvbyWwiOLTtmupiLDz5RwaOB779NvMl7Z1bVFoWk8AH6+X/sXpaD7Q1r9lnG0BA==
X-Received: by 2002:a05:6a00:3d41:b0:717:92d8:ca5c with SMTP id d2e1a72fcca58-71b19250df2mr168153b3a.3.1727279788055;
        Wed, 25 Sep 2024 08:56:28 -0700 (PDT)
Received: from localhost.localdomain ([1.213.237.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc834fdbsm2932222b3a.20.2024.09.25.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:56:27 -0700 (PDT)
From: Leesoo Ahn <lsahn@ooseel.net>
To: lsahn@wewakecorp.com
Cc: Leesoo Ahn <lsahn@ooseel.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmzone: remove redundant exception handler on pfn_valid()
Date: Thu, 26 Sep 2024 00:55:28 +0900
Message-ID: <20240925155540.4087150-1-lsahn@ooseel.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1). It can ensure the upper PAGE_SHIFT'ed bits of PHYS_PFN(..) are clear
by the C11 standard:

    6.5.7 Bitwise shift operator

    ...

    The result of E1 >> E2 is E1 right-shifted E2 bit positions. If E1 has
    an unsigned type or if E1 has a signed type and a nonnegative value,
    the value of the result is the integral part of the quotient of E1 / 2^E2.

@pfn parameter of pfn_valid(..) is unsigned long and PHYS_PFN(..) makes
the upper bits clear(zero) always with it. Otherwise, the result of E1 / 2^E2
doesn't make sense in the document.

2). x86 instructions

The following x86 instructions are the part of the redundant exception handler:

    ...
    movabs  $0xfffffffffffff,%rax
    and     %rdi,%rax
    cmp     %rax,%rdi
    je      22
    xor     %eax,%eax
    jmp     __x86_return_thunk
22: push    %rbp
    ...

%rdi would be the @pfn parameter of pfn_valid(..) and -1 assigned to %rax.
'je' always takes place by %rdi AND and CMP ops with %rax.

Therefore, the exception handler is unnecessary.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 include/linux/mmzone.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..164ae80977d6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2028,15 +2028,6 @@ static inline int pfn_valid(unsigned long pfn)
 	struct mem_section *ms;
 	int ret;
 
-	/*
-	 * Ensure the upper PAGE_SHIFT bits are clear in the
-	 * pfn. Else it might lead to false positives when
-	 * some of the upper bits are set, but the lower bits
-	 * match a valid pfn.
-	 */
-	if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
-		return 0;
-
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-- 
2.46.0


