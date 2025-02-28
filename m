Return-Path: <linux-kernel+bounces-539171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC30A4A1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74ED18881F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F927AA52;
	Fri, 28 Feb 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6wcmG+P"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D97279E54
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767423; cv=none; b=Tk0urGKZIuVvdUlxrpHv0vOi4cMhxIK9+5ouqSFICZlsCIy402HUGLtLiIeP4vDw37mvxQCzS6Ah4JRi5PEF+lT93QKo0JuW7eQCkxF4fn5cWiaPiUYVNbnX4N0uk9E/u3QDBCqMY02sHs9TRU9vqNKKkyuKfvZBtddwP18GD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767423; c=relaxed/simple;
	bh=dTNP90UIwyKky8XRrOt2SvQdCW9PGMaKmirOyIMj7C4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o8YV1gqg1Gr69cLubss35FgNAf4nzsG24YkmjmEsiAWMSr/aBjV65ojcH5VOPcLHbH6mqz5kb6UWytQfeOVMKWKvH/qawJpdbgW5LMh9lM658InIv6gDgwdwlJweTBGVVlZefdmalsO3c6wvbk9Wcd6TNIwYI3q/3oJQ6aCoZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6wcmG+P; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so5049475a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767421; x=1741372221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsv/Ru062kbIZ6fLgoxLCpOrSns6HMFCNnESdSOgKyI=;
        b=u6wcmG+Pwo9xIM55vEpk9TjJ+NC0E6EEK/MKVT3qOx+rqEN/6+OZGcU+iy+a74ulaV
         YN/OKCUOYGQau7vPCb+Pvib3yJEv/QAyuAXqmByY67Mr1xz/IkstSeLdK4nSu/a/B0oh
         BRaG2R6Mm+YGP+6hkO7spZuWmilSR6zU6b48haI5xFKeMHp1WLoPtcJycQ8MEepd02ip
         5cuTWAybIGYk1IpP8x891I2rbFGFX1UHyqxHdXwmIpLGfrzYJVSgkNIzTFyFY2EwQPv+
         l27pxlheR4yxr7e6GUk5Fsku7GnFObKXrXuVE5MdVu9KQWNx3t9U9tkfSdohuFDU4gdD
         UjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767421; x=1741372221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qsv/Ru062kbIZ6fLgoxLCpOrSns6HMFCNnESdSOgKyI=;
        b=crrdsjOVjufjvCCjwn9W59L62n0f3gQbXcJ33nSYy3/jPpUJB8H41KSDCh3V3PVCLI
         XXer0Ih0Hxf8P0y5Fz8FQ9OOdoK2TDGeNcdROLWDe7vjdVNaKGZNbhOz1ofzjjHZV4eV
         uUQiSPtj3nMs+pvUSwZ4JPWVtqFkC6Z9quFfuuEx3AY0BVHjI9mxXUyVP+tUNTN4+Lug
         LJhU5h8XZ4OGiwGEhR8YdupDspdb9G0pFE69Vc8k3sHM3HlkxemHcXFdjRjKDP7CUYCv
         yItVIRmtC/7ClGUZ983EORwYPnC60TdUWExxMfDb8HM+IF3OKeXUkadt2u9jDOtFCFo7
         d2eg==
X-Forwarded-Encrypted: i=1; AJvYcCXdINL0Cc/+w//MmZ4cyM9rFMPnTL3Nkr658esP/KFhuK0WFLCIU8T/GcvqFGswpLB6y0wUmcpC3wiX23Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbz5h78Mt3eF5Nx5yHxl0uqXK7zmIUhMHRfFEhlbJCe/OG9Xk1
	Auv9nagtiFLYCD6KJdXLD/k7Nga4/g8zDHsA8DnIkzbgZBXkN9DB41/1asvoSdqWi8sXrQ==
X-Google-Smtp-Source: AGHT+IFQ+4CYaI0GArxrWm7V0AIunfjglhCLiozYOHsEzSuzY5cNohoIWVj5V0zB+hLlPEDwCz0ehvUR
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2ee:3128:390f])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c9:b0:2fe:7fea:ca34
 with SMTP id 98e67ed59e1d1-2febac10a31mr6078409a91.32.1740767421435; Fri, 28
 Feb 2025 10:30:21 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:21 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-21-fvdl@google.com>
Subject: [PATCH v5 20/27] x86/setup: call hugetlb_bootmem_alloc early
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
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
2.48.1.711.g2feabab25a-goog


