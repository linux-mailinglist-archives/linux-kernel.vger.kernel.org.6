Return-Path: <linux-kernel+bounces-511349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7F1A329CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01227A137B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7221148F;
	Wed, 12 Feb 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPEfQ04X"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908A1D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373721; cv=none; b=AQGFiQBbxMhqhyLbc3Lw9yFgh4aP+AxqbsdSoMkNacmlPB0myM1gAdhkGCM4kKxksCyTgAB4K7PEv/XenBiLzsgUNdSmnmTMLBB4nxOh8UQj/3V/qV2RWcDp/5yRYxEEPWpxLg0EUf6lr0fVvXBWqHaTljq/SlVKjhr2mSvviHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373721; c=relaxed/simple;
	bh=+vis7gN36TN4bXpmmqFmcfJP/4FjM9SrG05t3JKRUgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QdVODEqmMN4hT60OwmY6kY9hWvOeryZlDOKFXhXVscDnbasAPAKImcrDmKSf5BwVV8T8FbHgNWgf52rUkbFL/GjD8UAFyyjLX7Dv0ngxFTthQHEnCyMJ209t/4gorDacFLxBZc060ljzje/s6bvkdHV587/pSrmulbbECDPq9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vPEfQ04X; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de6e26db8eso7497068a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373718; x=1739978518; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwGlsFsWUPCNdb5OIVhsjIxoKbJw6k+Z7M2gkvn8C+8=;
        b=vPEfQ04XOzZt+HWY7f+A0E0Ek1Bhumv5FOOlwVq8EZMwqq/O3SdOdDeBNhfxmykB+n
         I2t2fM3TNdyQg7+rHNSfVjzXvJvUeKVyya03xAn4l0KAg0VzwMZbYg+9UOmXa6Zh0Ehw
         M+x5TDdsIg+5hnCK1RNuvWWeaowAdbbf7GHzgYy5EyJlsyBiCARM19J8CT45x3cVAcRb
         Dza16wfoDKTjUjWGAsN88p0rrRMpy796tO1fb3GuvSe9Bfo+LBMomvDK4NWD2R//vey8
         cY1RO2osvhL7e6iMokBGrGKkoRtvipU4KAl2gEMKJXjIv1eN1coJpHtOg2xNQRLeah87
         JQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373718; x=1739978518;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwGlsFsWUPCNdb5OIVhsjIxoKbJw6k+Z7M2gkvn8C+8=;
        b=VYpTyhw2QoHy5rlvvaG0dH8M5A3m2ItnnCv+84LkolBQHmPBxhrbjC8qfp5fhc5FLP
         Aa5PypS7shmzvVTQtI3TlT9O5GhDR2rPr6z8Th5pOsXCH1Sp1neZUZM2Lub4lj4X+WLh
         p7cHlv7oT5BlPRJFCuwAE/qLvi7Ojv4PRfoODRDlfankaevEhDjXQVVriw/6VaZK2hm5
         Hg38JMPjwN+C9zZ6G2mC17BQEqfnXMzlu0u9R4wdTmUgXaQbvz0PCfLDCqyXXc5K88x3
         ZL/2QmkcVKETEY38QxJa8fX4kxf5/pwashWSIu1vl/Ioue3x5imrRdn2qixUI3FbSjyq
         bL4g==
X-Forwarded-Encrypted: i=1; AJvYcCV2RQmqo5MRK812+UeXDPoq9xhhtfa3TyVUOOMb4mz49Xk4pYlfTzpb2+P5AgoTAITnRnFjyx7rdiPfm6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONocpHvtTVKK9IRCw5sIThGCQ5Q5fswZyANcV9F94WYtQMTLl
	h7dhtjRcPx0y2thUAvuQx2l7CJAoNHDdCOsepRpjSqht51vE24T2Ex/BioyZKKA=
X-Gm-Gg: ASbGncufyhfQgJzyZMZ9XV0Smt0wz/3oDGPDM3JqCT3oyqG7+rou2chz+8h7+QOG/7b
	zTGZstSDFVKifCrtALfvkSnZYdYsqNHrxsc8WmjlOU9ttMltmAFhJgturgbJpQekzMAIb5XfT2M
	E2bFuYEcvRUhBoJ77vP88QzsEsUo1oJMmkCqI9f+ICVyAvsx/hyNymTFRQJVqys33bnu/fNfqYQ
	vGbEvkXPSyx2sS7duWhoBUH7+YcC3qweVMrr9rLDmrAvbtF5vY+IETrnADDkxNPslxLeS+IzmG5
	pNZazpcGEXwK2Fx4Sc6V
X-Google-Smtp-Source: AGHT+IGrvoP4bSDwTvQHGL/gEOxz7a6wXG7ax2H/r1PattdgMpthlmvIy2+tyJ3Lf5q4y3T8TLELBw==
X-Received: by 2002:a17:907:3f0e:b0:ab7:8079:78ae with SMTP id a640c23a62f3a-ab7f347db7cmr349736966b.44.1739373717663;
        Wed, 12 Feb 2025 07:21:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7dd77c151sm374431966b.57.2025.02.12.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:21:57 -0800 (PST)
Date: Wed, 12 Feb 2025 18:21:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank van der Linden <fvdl@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] x86/mm: Fix uninitialized variable in
 register_page_bootmem_memmap()
Message-ID: <1aa70a33-2acd-49fb-8049-a20dae40ecba@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that "next" could be uninitialized.  The "next"
assignment was accidentally left out when we moved these lines to earlier
in the function.

Fixes: bdadaec1526d ("x86/mm: make register_page_bootmem_memmap handle PTE mappings")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This goes through the -mm tree.

 arch/x86/mm/init_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e7572af639a4..6e8e4ef5312a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1600,8 +1600,10 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd))
+		if (pmd_none(*pmd)) {
+			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			continue;
+		}
 
 		if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
-- 
2.47.2


