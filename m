Return-Path: <linux-kernel+bounces-520065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4BA3A533
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CF81737E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942D22F588;
	Tue, 18 Feb 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT8kO4Ia"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA11F5852
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902660; cv=none; b=REF/KnFQx8CDLpcRemimB2bMoeZlMmS+2iJblTGKOw5mVNlOtjX8tKVSGbU+e/arxWnQnCIzIEQQwoqM5ofhlf7rFrgwmXPPi6XvJqXMT+Ybi8XuYh5Tc/HerpSC/KhH4kRs+SgRjUl7RMlE6E3C90p6C4dUNJdrb3gvRrS0lF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902660; c=relaxed/simple;
	bh=QZQrf1idcipp85bIsZ8kNWpli0DtuR37z081e8hgm9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y/uTUy/HTUJzIHeFYp2ZIHCVIhtx1O5ITobbhkGSNX7JvO2Pq1dsaTRIoUbSN7OLUpoKphHzfWEe08AofvvC9K4SnwpB1oSbmreY4tmtECftQocX6ucRDx3yqPpdy6SkZp/M3+I13w16G4xwMpuEsrKnXW/aOhr/hi9PUsNPh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TT8kO4Ia; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso16419192a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902658; x=1740507458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqfUye2Gqg+na9IHa3QFjTr+lGgP+C+b59c2LGbdQT8=;
        b=TT8kO4IaphjSSAzs6798pAgz9s6RPp98zM6dW1VQEE0V107tao+b7wxF+S+chA8jHv
         P63dS0fEv2kFs+9jDvWU2KGTpe2FScM3mJ3RP/ifEpgBakYMy2CMN6W+oOwJ2aNpS/f2
         NCSjsDObA4cC8zdlNGiRiqJHHChNmk1m6SUqWC1nVwwqpjuWkJFlvSzs0UtMugZUWYis
         1Dyq0avQqhnrdu+F5b29uiaeB4NYp6q+ZFSUz6S9Ju8Lk1SE47ViV9y9NHZe1/2nmz0A
         O4x19T10YLrYS3wLgTX670dGQNxggkjTbu07E7YqGTD0/uxGoN2LYeRDEzrn8IdQ43HA
         VUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902658; x=1740507458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqfUye2Gqg+na9IHa3QFjTr+lGgP+C+b59c2LGbdQT8=;
        b=jz97dwZn4hRv05zd2dKwQ2LdWrdX7x7qWcMZAk+KizuFI7DK1L6f6AeNgGsZqwlApe
         fasr8o4uSTrCfWENv3QN5tFaiQ0Cp1vUXSnKChqphBehD5iy76i9YZ1Fs4eyUk4Mc6Rf
         aAQ2dZQa2rQ0wdH6hNXUOuDaQ3f/Dw7F1NQ0mQCbdh2OMcZ6TZbN2HHCpvRrjgKCEZl0
         54W6SWDHmWV0htyOEl0TMSaIQnMCT6Tl3tR10urQEWwKlLfhPVktUeDWy9D3HzG2hcUc
         LLDvUebuGFYc77kgYsSPf+bO4HKE2Ttqb0GJLHCGdiFrXqQDL0Q2xTS3qL0gQCIQAXDU
         eZrw==
X-Forwarded-Encrypted: i=1; AJvYcCXuRZmgMSKUNTBhATqdGHx/X2w5hmr1h2tGVchk0oC3YldPXGYxibAgO96DaC268mUTzRvkCGMqe/8skJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mdA9ph2AOAOkfu/Cxp5dj1ya5jUmbj4nZaeJax342xz9KJ2M
	5fBrnjouGVhh4avl1XRVGfOIijx26iLl7L6UfU+XhH66PMxvmsRmRnlYSrwXQ0kaeX/WCg==
X-Google-Smtp-Source: AGHT+IGT1727I8G5MvylvWz2EC9dEjwO1xfTuzAsh9q6nSIFNiBLO1VX50pO6D1H6yTl2+Ulds7JKb6Q
X-Received: from pfbbd17.prod.google.com ([2002:a05:6a00:2791:b0:730:8a55:44fd])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cd4:b0:725:9d70:6ace
 with SMTP id d2e1a72fcca58-73261798a0amr24087264b3a.6.1739902658195; Tue, 18
 Feb 2025 10:17:38 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:48 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-21-fvdl@google.com>
Subject: [PATCH v4 20/27] x86/setup: call hugetlb_bootmem_alloc early
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Call hugetlb_bootmem_allloc in an earlier spot in setup, after
hugelb_cma_reserve. This will make vmemmap preinit of
the sections covered by the allocated hugetlb pages possible.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/x86/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..ff8604007b08 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1108,8 +1108,10 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
-	if (boot_cpu_has(X86_FEATURE_GBPAGES))
+	if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+		hugetlb_bootmem_alloc();
+	}
 
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
-- 
2.48.1.601.g30ceb7b040-goog


