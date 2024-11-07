Return-Path: <linux-kernel+bounces-400585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85579C0F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9873F282CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA9217465;
	Thu,  7 Nov 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xX25A/Ui"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B3188CC6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010840; cv=none; b=VP4aUulZcZvkWUQxmWKNV+kjyFOX4/8n2z703AWOsGZLQBgkCdR0DGDYehnOm0Zn05F/PLzBMclAAV4lfcJDps1AUluUDwN1hCZ8lJ5ML61vuJOLwHeuCGU8s0Sh9vyksKhVVzTAJ9/abT1z7Bgi3t+gNLG6XtcNC2VDC+ua6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010840; c=relaxed/simple;
	bh=ZD6qPDNUJtjrg71OowXUHm7PHycMBu7HRnTUKeYnO1I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ua+I1YVKOpJfDdaL8gnUzyqfIDkvQNqEwJzUMa36C23wVmv6jaTeaLNLWPUNr9XQEin2BjmcIwFSZA4jgm+EJDXKJqa1om2zJCWrF9Oh6MV/SWtH2m+W1iYrg/NOAZP+pffJptmxcmCpYASxOdM8VfZV0azLHp67qzWN+d8DiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xX25A/Ui; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3314237b86so2434165276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731010838; x=1731615638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7+Mjo89P4AdQIIV//Uu9js0oVBe923zMULMp7p6G5Y=;
        b=xX25A/UiunUaa+yK15c1P/2OTsII3rT1f78XB+h7IFT4XJHTA9WWrF3kxGPtegUmgI
         KN/fgBzjsf7IZz8pqhqKpezOLXtnkdt9DPAui42WjQdqi9sqVHi+WKELiKZxkrAlTvAm
         3Imb+8Z2UfI6+rl8RbsNANsyZh/DTjDe3dcclOTh3g9ZjkNpN7MmKRMa3mMOv1O02rKq
         uFghxhmfNsHBjOzIjX6bspuMxlcyD8v159UJj4X0/Lo8bQzZVBY6D3u4ABDWwdHpVv/T
         9MRFSVxy1Oo8cwJfr2vYJ0qo9NPXZcZvUyb5Ixj5opKZNVE1EtRScC9FAoSwvQIWwRxX
         uGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010838; x=1731615638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7+Mjo89P4AdQIIV//Uu9js0oVBe923zMULMp7p6G5Y=;
        b=Rk2iwly80UgFdTZ0+rRgmba6V8UZxEX9XIDiYH67/4cE+WfsAhlDbnU9tpyVjWXDPd
         CXTpVLtljNbtI48lGOM5s5i1QZPcgbxWVLowHuSIExqAf3EVacGPXme6gVQroRM29vun
         BEd6ajydECM1IIHPg/gKK966JNlUmKuENzwvg7RNCLNeCl0AhohtYnIrLnH1TG3cCDsv
         KjHP7sJLVQfD5Ca+vm0L+vPNExcOYnHbC99MIg+AxeAzL5vrKLNBWvVXfY+mA0MsSyGH
         jfdRbGXEWTBlrKX2zKX9gIfmZBWd3w/uDa5RNgi18zqt58qdMx9Xe3xz1UZrLLBvcfLM
         WX0w==
X-Forwarded-Encrypted: i=1; AJvYcCWF0X5q6HcX6V8pncF8nycHhuzAmr5XQlhst4DHQxgOQzk5XpWVqHyFMcenOwESbJmrtRRUVAjkaFfST9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTaiB/6Mofk28Hzz6EEGccCw9fZ5OK/ooAfIqp8tZwMJLa7sY
	cjXAh7WAYP4Ihq2E7wz/O1mdJA5KW3cN5lBv+2j65Wcgj3oSOKbfECp0A7WjiJZ8bHoHYKhOHtA
	Bnw==
X-Google-Smtp-Source: AGHT+IGMlauM2Ccm7lpcq+NmFLTze2u+1oA+ThJ4YgG3NG0DPe4hsPEtWI2lkBjtgT/O9I9Gq0F9hjCGH4Y=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:a4c0:c64f:6cdd:91f8])
 (user=yuzhao job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr193276.6.1731010837952; Thu, 07 Nov 2024 12:20:37
 -0800 (PST)
Date: Thu,  7 Nov 2024 13:20:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107202033.2721681-1-yuzhao@google.com>
Subject: [PATCH v2 0/6] mm/arm64: re-enable HVO
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

HVO was disabled by commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the following reason:

  This is deemed UNPREDICTABLE by the Arm architecture without a
  break-before-make sequence (make the PTE invalid, TLBI, write the
  new valid PTE). However, such sequence is not possible since the
  vmemmap may be concurrently accessed by the kernel.

This series presents one of the previously discussed approaches to
re-enable HugeTLB Vmemmap Optimization (HVO) on arm64. Other
approaches that have been discussed include:
  A. Handle kernel PF while doing BBM [1],
  B. Use stop_machine() while doing BBM [2], and,
  C. Enable FEAT_BBM level 2 and keep the memory contents at the old
     and new output addresses unchanged to avoid BBM (D8.16.1-2) [3].

A quick comparison between this approach (D) and the above approaches:
  --+------------------------------+-----------------------------+
    |              Pros            |             Cons            |
  --+------------------------------+-----------------------------+
  A | Low latency, h/w independent | Predictability concerns [4] |
  B | Predictable, h/w independent | High latency                |
  C | Predictable, low latency     | H/w dependent, complex      |
  D | Predictable, h/w independent | Medium latency              |
  --+------------------------------+-----------------------------+

This approach is being tested for Google's production systems, which
generally find the "cons" above acceptable, making it the preferred
trade-off for our use cases:
  +------------------------------+------------+----------+--------+
  | HugeTLB operations           | Before [0] + After    | Change |
  +------------------------------+------------+----------+--------+
  | Alloc 600 1GB                | 0m3.526s   | 0m3.649s | +4%    |
  | Free 600 1GB                 | 0m0.880s   | 0m0.917s | +4%    |
  | Demote 600 1GB to 307200 2MB | 0m1.575s   | 0m3.640s | +231%  |
  | Free 307200 2MB              | 0m0.946s   | 0m2.921s | +309%  |
  +------------------------------+------------+----------+--------+

[0] For comparison purposes, this only includes the last patch in the
    series, i.e., CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y.
[1] https://lore.kernel.org/20240113094436.2506396-1-sunnanyong@huawei.com/
[2] https://lore.kernel.org/ZbKjHHeEdFYY1xR5@arm.com/
[3] https://lore.kernel.org/Zo68DP6siXfb6ZBR@arm.com/
[4] https://lore.kernel.org/20240326125409.GA9552@willie-the-truck/

Major changes from v1, based on Marc Zyngier's help:
  1. Switched from CPU masks to a counter when pausing remote CPUs.
  2. Removed unnecessary memory barriers.

Yu Zhao (6):
  mm/hugetlb_vmemmap: batch-update PTEs
  mm/hugetlb_vmemmap: add arch-independent helpers
  irqchip/gic-v3: support SGI broadcast
  arm64: broadcast IPIs to pause remote CPUs
  arm64: pause remote CPUs to update vmemmap
  arm64: select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/pgalloc.h |  69 ++++++++
 arch/arm64/include/asm/smp.h     |   3 +
 arch/arm64/kernel/smp.c          |  85 +++++++++-
 drivers/irqchip/irq-gic-v3.c     |  31 +++-
 include/linux/mm_types.h         |   7 +
 mm/hugetlb_vmemmap.c             | 262 +++++++++++++++++++++----------
 7 files changed, 362 insertions(+), 96 deletions(-)


base-commit: 80fb25341631b75f57b84f99cc35b95ca2aad329
-- 
2.47.0.277.g8800431eea-goog


