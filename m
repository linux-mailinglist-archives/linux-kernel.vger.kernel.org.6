Return-Path: <linux-kernel+bounces-400591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A289C0FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85B01C2302B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E8218D8A;
	Thu,  7 Nov 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9T2jNdZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14512218959
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010854; cv=none; b=mVcPbtUO5FvFk7iWevyuxTSVC3MFhEZZVYOi9CjttG5MvGfFncu+Q+cAUD8YAYGDGMD0qWdh41m7s84Q+KdAk6xP2itM8OjqMzxvvJrowreagTauU3AjVwHmrnqqT4up65ILYUFa78UgkPZW4oWkRKwl2at8TFvIUbVI/2mLqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010854; c=relaxed/simple;
	bh=++i2s5A09QlZdar7/X8Vm+Fem/4jpzHHFur9X36Ee/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BU9LfORSuhqnGZ8HMqCshmr7MkQhIqEa7IqIRGteJxsSMvFYrfuBN/8RxtgFy5iCazloHcsYA/KD7YWMXHaJZ04tNr2QRSU8nRsXGiJFjZey2cMDmXAaavuyXawuDsi9eomxRhkSlp6Lul8eN3ml0ksi4j54A1Zrivb40rl/2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9T2jNdZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eac7417627so25725887b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731010852; x=1731615652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYMFXTGWFxXGTBSXbf4RqlCV7Y4+WKb9i4kIMpLBOpY=;
        b=W9T2jNdZbjcxkoYhy0mFMWp1tQnt5SctGVmFLC2/H/t8TaPkNQMK+I8GKNHtQG3LB1
         ThH8sLIVIQxpKqnrN9aXzZ4eGFmeoV6eXG+AObQyZWF74rcj9cBZQw+ALmdLnbPSsevG
         aSJRKiEp0gqZuADzGOG4ddPahtNI8oPva9HuSRqH7HKZ75a4fZsPONFUdWVzAza93z5N
         +i9RCl0fRJp/fgNDTWvFfvFlMkoS0bGyF3CRX7WG6vxSFyvMU20fwhq6kILb6WP9aDLJ
         xWsAZno0mMn8hZl37J+6GwVucZgukhyGTBMEEOLs9e9ndyvwxGDXevaLYPYt7WiI6/St
         BiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010852; x=1731615652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYMFXTGWFxXGTBSXbf4RqlCV7Y4+WKb9i4kIMpLBOpY=;
        b=U6yEnwdeb+kuMfXWjawc5Sk6cV0z8S/2Dv0+pmm4GCw7X9AbS7FaTaBxQJwNxO0/jX
         OacB7giOMgj4F8acrNaTH9cDmINrUfu2QB+sIzcFgWrJYqqukD9T8QH1BfTfsBNQgosc
         qen5sLwJDyppTuUzJDQj4qr8fB9ZxJvbmN2BmcfRYHBpjvYYuT6GygBxtB2iYYvl2StC
         Wu7pNG7tD5fleqtpzKztsEi1BWzUoPY2ijxwPO9+PTJDOpGsaPt0Nw4fgbxOBJ2xoIih
         A4RXgiSzxfSw1Y0WpBxw+ngc/H2vv6bnag3Fx7EJQMoRqwzM53166MBg2JJ29pB6F2iX
         9EFg==
X-Forwarded-Encrypted: i=1; AJvYcCWW+dEqSG+bah3T9ZEo7WzN6iIr/RHd134eG6xNi5qsz1Iv6Rt2mM84c9Bb2/6MclsW6z0zelC2/Bw4IPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ph739Zl5JhY7HkupU1wxPt3BwcwGWxH8E+hCY2Cn5SIoTZ7V
	DlcaIm0dI8dwStAcP5Q4Fe3D1TUREWdXFGDPSt+/5M8G+MYM4JqbB00X73hGhKUXQiBkX1KwZJI
	9eQ==
X-Google-Smtp-Source: AGHT+IHlhijSC9zoCXOj87mpdA8tF9p5aSLV/movLFpBkBVUAVMMT2gDU4exk7NlnuXq35RVmXnfaJPFwyA=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:a4c0:c64f:6cdd:91f8])
 (user=yuzhao job=sendgmr) by 2002:a5b:809:0:b0:e2e:3401:ea0f with SMTP id
 3f1490d57ef6-e337f8f63a3mr313276.7.1731010852085; Thu, 07 Nov 2024 12:20:52
 -0800 (PST)
Date: Thu,  7 Nov 2024 13:20:33 -0700
In-Reply-To: <20241107202033.2721681-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107202033.2721681-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107202033.2721681-7-yuzhao@google.com>
Subject: [PATCH v2 6/6] arm64: select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
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
runtime if that turns out not supported. Successfully enabling HVO
should have the following:
  # dmesg | grep NMI
  GICv3: Pseudo-NMIs enabled using ...
  # sysctl vm.hugetlb_optimize_vmemmap
  vm.hugetlb_optimize_vmemmap = 1

For comparison purposes, the whole series was measured against this
patch only, to show the overhead from pausing remote CPUs:
  HugeTLB operations      This patch only   The whole series   Change
  Alloc 600 1GB                  0m3.526s           0m3.649s      +4%
  Free 600 1GB                   0m0.880s           0m0.917s      +4%
  Demote 600 1GB to 307200 2MB   0m1.575s           0m3.640s    +231%
  Free 307200 2MB                0m0.946s           0m2.921s    +309%

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
2.47.0.277.g8800431eea-goog


