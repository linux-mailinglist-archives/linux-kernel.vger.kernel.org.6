Return-Path: <linux-kernel+bounces-373624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772B9A597C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19FA1F220BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD61D14F4;
	Mon, 21 Oct 2024 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRFKlVCo"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD571D12E5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484559; cv=none; b=SVZTe/YFnIUW12Z81C3q53oRYA7cVIeUKnAQvhbamBxDOrhNpRql9WYVw6Z+3VZVUJy/148FvjAzwmFlb39PaQsHmcytvDy1dvnotQiNdzEoj6+faKWws2Jr7uFq8N2nU9200k3uCcodtLupmo4qaQTGuaCsRfzK4U++uztkAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484559; c=relaxed/simple;
	bh=iO3OI/1zN6TD1V0JjPsN855BFkMCfNnKpuMNvwgj78A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFaFGHqpW8SsRLCBalJT2G2kVepLdAMzsZifPRBjH2iwdlBkUWCp5NiHThLE06rsiRXxeOYmOWXaMi9ajcVjeIUwAW8fE1aMxhkJ/W2gfZODrEj260eQT2F4pGB3mOc22mIykGsjpSzpqIrEMZY/7of/fanjGLI/NhSJ2x7QmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRFKlVCo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290222fde4so5385545276.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729484557; x=1730089357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qOoUc7S7Ph4MJcNIkBb7u3tw8zxiypBu0RBb7iGSGQ=;
        b=TRFKlVCo0jtTjmLZ4N8fhPzMJHA19kG7VJjQy1LD2NAyCetdKgrbvNO1xxs/4QgF+z
         ymKjPoWMj4JEV7YeD4g5St4QPwjHcrBUV6rHsPElKLB2bCc4fCkCsyRYad31RztN4jRt
         hPa0KSOmRKXUau1JKCP0ARmh0V10fnExGO0Zcer7UrKxYETL9Q9uJofeBmyhcPRaExgR
         N2qrQJT2Md58j+iHUqfhr+FUH1wA9q/vHP6ptcORieMJ0VPnHggigSMT8YuMqT7rC2mq
         9GgTL9FbN/fAduHrY563hjvUi37+QxboTrbsnb88b+vqdx2fY4YfO+3gTIIcDGMInA3v
         bV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484557; x=1730089357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qOoUc7S7Ph4MJcNIkBb7u3tw8zxiypBu0RBb7iGSGQ=;
        b=SKn42tvg/EN/yeIDRYhzT+0WINVSO8rEnJt87KxqzdjMNIEnoz4OGDEOmQOM7zbpkB
         xihytAoG7tzFtqPFjRoy/nIpitFTne1gihxBEAAxSA12npsoncPX8zpo1Phc4RlU9ujH
         EiOHiWdw8FSntRQY1qxr/pdber/bKdGdR9rC9JgNDHCdfxh0tBZ3R36fkuOINMreuCpC
         lZoHvH5a1C2yXfKt3y3RijV+8xPQ3hht0HCIZrYNGGzOOyBLOExGgsTvuQ67jRzgnLkp
         qnDVTTjMN+DPzUxQUjGQdtWNTK7Xo7Bf6uraI9yVX4EXzfptGwAGpL56gT0glq4wO3RJ
         znJg==
X-Forwarded-Encrypted: i=1; AJvYcCUEVXgAdlsh7S08ge7Bm769RDDiiiw9UINb9PdTh4AlM0p+fFZIqS1B10wdzHLBTUSdFfcApHM2xmKMIxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysSmWUm6dBSHEiHM0q9TUDluBQoAcb+cKz6LwscKH2vCpf/Wxh
	MveqevvUNCtoNOwVjcMK+tZ3cK/EPypend8Cbd8NgLMm2zd/e2pe8lA1W8cUe+XqSI+ZjW8Bs6z
	QSg==
X-Google-Smtp-Source: AGHT+IHT0kbssKqnqvzVXYJ6z8GdpmqmvaKobmcxDyj7IjWvvjuKhF8UkhPdehMt/EKyLWoXTgeCtaMmNCE=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:1569:9ef4:20ab:abf9])
 (user=yuzhao job=sendgmr) by 2002:a25:c781:0:b0:e29:7cd6:593b with SMTP id
 3f1490d57ef6-e2bb169afa4mr24157276.8.1729484557262; Sun, 20 Oct 2024 21:22:37
 -0700 (PDT)
Date: Sun, 20 Oct 2024 22:22:18 -0600
In-Reply-To: <20241021042218.746659-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021042218.746659-7-yuzhao@google.com>
Subject: [PATCH v1 6/6] arm64: select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

To use HVO, make sure that the kernel is booted with pseudo-NMI
enabled by "irqchip.gicv3_pseudo_nmi=1", as well as
"hugetlb_free_vmemmap=on" unless HVO is enabled by default.

Note that HVO checks the pseudo-NMI capability and is disabled at
runtime if the capability turns out not supported. Successfully
enabling HVO should have the following:
  # dmesg | grep NMI
  GICv3: Pseudo-NMIs enabled using ...
  # sysctl vm.hugetlb_optimize_vmemmap
  vm.hugetlb_optimize_vmemmap = 1

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd9df6dcc593..e93745f819d9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -109,6 +109,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
+	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_EXECMEM_LATE if EXECMEM
 	select ARCH_WANTS_NO_INSTR
-- 
2.47.0.rc1.288.g06298d1525-goog


