Return-Path: <linux-kernel+bounces-539158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FBEA4A19C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133A27AA9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6C281371;
	Fri, 28 Feb 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k552tydf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30002281346
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767404; cv=none; b=eWZBRvI2Nx+OyP8GALcAP3f9Ew7RPZpLlBcs31TLzdFXLuXy/uv1TEn/EnFuCBcl9DBmKdO3Xq3YVXa/Rf7FwFhBwvVh3Or6RQuEmFVMJ8zM1yDX9kVuoLqUa+9e/pXYEL5SPp9/Jkrwum50SVW9x/gPMdltmUY5mo+3pebH+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767404; c=relaxed/simple;
	bh=yt9jreh7p8FgaxmwISqk7Ueg8wiW2YUV6rWrFsx8v5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QsST7YXpPVSBBD2HLwbt00kJ0WI45C/9f4Ek8Y+DIagODpkOIJ8jnJwvDCxIHn54NLKM3Am5RsA1556apy5R7QrLLh1DgVC+OkwANh4coaFd/IiFI138zzK/qsQhG6f8RHXAsQmjtLu8rsDrWCfs1G8caE680KimWrFvIogeCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k552tydf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe86c01e2bso5034775a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767402; x=1741372202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT9V+Abq/i2ri7sXnmoXq0qIAuHJN34FJxNuQkKtmyk=;
        b=k552tydfKm6b4JP9FkohVsAPAKJBfgN83rCMBPhFycCoVbw8Pg4nwljZbbYoHyqdoK
         DWnfcEE5OWSdC2TD0lufrYfj+ZGUn97f7CTrkaSIBK3cduh+k/FTVJRg0+8v6A+sqi9k
         yr0vVpSd2I19vmZxZMud8Yb3YvqFShtHXhso0jbyqaP0dpB8C76WF4r9ZHGls0N8XSEV
         NHdHiYeNDD+hRBeolWOk1eJKEMGn2IkpaBPidTBki0kc6zdCt3KFmCBdcBHWRvEbCGMj
         OUUzmktFbhbO+90xfy372LBH+yNoPm9bjswq4Fu4RwKsYOPJpe5vwbRWg2Pn0BKWm2Iu
         rmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767402; x=1741372202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT9V+Abq/i2ri7sXnmoXq0qIAuHJN34FJxNuQkKtmyk=;
        b=uDLEs9kbRYgg3EAvMjOmmTjlB++qLOlvKXV6+yShLMgXBNEfz3zjKZQb5KnC9y+wSu
         k8nEvq5xYK35f3vVu718dVwF6WQlBNxLsibRqSrfnXpfOCS7Pwmqo/O8C1F8WY7BoIar
         Mr0NibDg6v6ebUeQtneg/rFJW6EphGiLGIsuS6K4nJN/sNZ7mmYnHHOIAVsTnJUxMHcJ
         pe9vN9VdPRAevT6DPfrXPkZFVcA4xRZi3SEv6A+81M4qoV2RG5y8JzXwMD0PCDyNapbM
         +XyDtRUIoF/GXa7j3djlrLTIXV/reeh+gnGW53HmHcvrMiy3em+trlQkQbp1tW5ZP5fY
         2i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT74eUSoFleGTkJ8/s4o4fFilFR8OD+dgrbLDmehiDTldv2mYt10uS6KN8sqUVz+s0Izps4gHRgVA7IMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYQQ006d2LZ3gcPbK19lV7Lg/qfcVddGKILUe9qxMvdRY4Dt0
	/PE02DT+kfz8fpRVc4VR9BwxD74uLp/o/Rm5u1mGUqsi1NADc/fC00/i0v9VX0SFexe20w==
X-Google-Smtp-Source: AGHT+IEJZtJlg1nf2iF5sruFhlqBO6bDCuDixMIcx2WJKx58Jky48PZHl6y7MGnhwLHWadCWonhMeC6V
X-Received: from pjboh15.prod.google.com ([2002:a17:90b:3a4f:b0:2ea:5be5:da6])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2247:b0:2fe:84d6:cdf9
 with SMTP id 98e67ed59e1d1-2febabf1a73mr6371733a91.26.1740767402413; Fri, 28
 Feb 2025 10:30:02 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:09 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-9-fvdl@google.com>
Subject: [PATCH v5 08/27] x86/mm: make register_page_bootmem_memmap handle PTE mappings
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

register_page_bootmem_memmap expects that vmemmap pages handed
to it are PMD-mapped, and that the number of pages to call
get_page_bootmem on is PMD-aligned.

This is currently a correct assumption, but will no longer be
true once pre-HVO of hugetlb pages is implemented.

Make it handle PTE-mapped vmemmap pages and a nr_pages argument
that is not necessarily PAGES_PER_SECTION.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/x86/mm/init_64.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..6e8e4ef5312a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1599,11 +1599,14 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd)) {
+			next = (addr + PAGE_SIZE) & PAGE_MASK;
+			continue;
+		}
+
+		if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			pmd = pmd_offset(pud, addr);
-			if (pmd_none(*pmd))
-				continue;
 			get_page_bootmem(section_nr, pmd_page(*pmd),
 					 MIX_SECTION_INFO);
 
@@ -1614,12 +1617,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 					 SECTION_INFO);
 		} else {
 			next = pmd_addr_end(addr, end);
-
-			pmd = pmd_offset(pud, addr);
-			if (pmd_none(*pmd))
-				continue;
-
-			nr_pmd_pages = 1 << get_order(PMD_SIZE);
+			nr_pmd_pages = (next - addr) >> PAGE_SHIFT;
 			page = pmd_page(*pmd);
 			while (nr_pmd_pages--)
 				get_page_bootmem(section_nr, page++,
-- 
2.48.1.711.g2feabab25a-goog


