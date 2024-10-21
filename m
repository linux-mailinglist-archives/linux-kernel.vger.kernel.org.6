Return-Path: <linux-kernel+bounces-373617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F279A5973
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216521F21EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87B192599;
	Mon, 21 Oct 2024 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRTeENji"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478864A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484545; cv=none; b=p0slklW/frr4mO/3ZOxhPuYZfCrJ0Z+PTU8qJc4G5ZRJAOHhmp7RR7FFLQWINaoNo+mbELtv7K608sOJwTtEX01YDbxwZ14loK4Y+Lfw6+L3Be/FFW8AHn/OCCjOAPfvs23O51T9nEPdv1fjyoqjn4J9VgswERqSjtLhjNi7r6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484545; c=relaxed/simple;
	bh=PQ4ICM7TuLpEFyIvreG4TnkbUFSmCmlT50vM5eQMcLw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R1rTplSJ2H3ru5CF+Avic+4xXXJlsc/y322pnWmEZUKy4rvVnEibSE96cWqbnwoRq7gWrXkk5R21xp3EIRoRmevFpruFHeDudEsu/g7Er2RoQwxD6EzFKx3tlMUpI4gRv+ipBsmYR1XepVIVRcVlp5Olyo1WWThOUXU207Z1nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRTeENji; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2946a143efso5294066276.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729484542; x=1730089342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=djmWeapaSQGC8nHmrg76kCEnRDM6khIeNx/vxZy7BEg=;
        b=jRTeENjiZFOy4zC8j3HVyuwz0cGcmt4mIGEqnsGut+V5Gi+YZPd4Hgyny11ZIFqAgj
         /W0+R73kP8JvumGygtru+Xik3m7rA5HkNF1OPZhbcYaJ02jgT8YpyFpcVIDB9jJD0z1e
         bf3f3c0i5mshlHBebh/brWdbytFrBGPUUwJp25ef3E+H9WDuLLPCzEgSGYVAWbLNFhvl
         66buMdyKNyQdZCZ4/yjFJKjlWMNJTmqNrd8YZl5fqZ8+7jHuwHiAiYsEolQzXs5oal2p
         I5nyvN7H+jGx3VCIZlvosWfiMqyarDdz31ezlWzqHse0BzJgOIkarNu1CDhqDvMJYS3o
         aEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484542; x=1730089342;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djmWeapaSQGC8nHmrg76kCEnRDM6khIeNx/vxZy7BEg=;
        b=offPgl7AZc9FnhflbODHCPPWBx6DzgnKLVqJc94eYQSFqtNAaYOhVLFFAX/qvtVJGW
         LXBExyaiCHL5C+3/gm/fnPquZUjBB33eqbDNwXDMd9BOLMyZyFJR0Uy5PD9MAheNOBPn
         JfRY2M9DnU8/01DbTZZ7S5tOcfUd2Ip2CjQ+fYp1cbvt1UfFAQjwBFcQWjYIs16G40He
         97gYGV/aE1qJNZT93aHtBBODIyD5ZHR4u/omJl4ZiGz+yDXcJP4HfPnZzOtQ8FrmD4yH
         VXgiYGbE0pJY6soea/f5uqbR28TYsITgNA0ueO+FYfS8eQYDivouq/VLyt+bzZZURekp
         S4yg==
X-Forwarded-Encrypted: i=1; AJvYcCVIcFVaLcb5drnC55L3f0m2RE/Vehkfp543Ema3kLn4dos6G+uf27dj4v9Owa5UOBHM+PsVCwnuOdE5KsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAzl18W2qcDGNfJ0p94BfOfE12cBjeSa8Q2kEfh65+6OeagDp
	tRU5ru4ywOQ4v0neVlu6A8vHBZpXGN6tr+ydN5OCG0kvimZMJXsFtix/FhNzw9Z+jxQhIEFfpbt
	4PQ==
X-Google-Smtp-Source: AGHT+IGG1IXCwOdLAyki3IzhZW4dyFxYFnYAhLqXXbmqpD2Dv/xXTcGUjx179gaMsBuxYaYLTRxOt7OLXTk=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:1569:9ef4:20ab:abf9])
 (user=yuzhao job=sendgmr) by 2002:a25:72c3:0:b0:e29:ad0:a326 with SMTP id
 3f1490d57ef6-e2b9ccc8449mr48383276.0.1729484542310; Sun, 20 Oct 2024 21:22:22
 -0700 (PDT)
Date: Sun, 20 Oct 2024 22:22:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021042218.746659-1-yuzhao@google.com>
Subject: [PATCH v1 0/6] mm/arm64: re-enable HVO
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

This series presents one of the previously discussed approaches to
re-enable HugeTLB Vmemmap Optimization (HVO) on arm64. HVO was
disabled by commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the following reason:

  This is deemed UNPREDICTABLE by the Arm architecture without a
  break-before-make sequence (make the PTE invalid, TLBI, write the
  new valid PTE). However, such sequence is not possible since the
  vmemmap may be concurrently accessed by the kernel.

Other approaches that have been discussed include:
  A. Handle kernel PF while doing BBM [1],
  B. Use stop_machine() while doing BBM [2], and,
  C. Enable FEAT_BBM level 2 and keep the memory contents at the old
     and new output addresses unchanged to avoid BBM (D8.16.1-2) [3].

A quick comparison between this approach (D) and the above approaches:
  --+------------------------------+-----------------------------+
    |              Pro             |             Con             |
  --+------------------------------+-----------------------------+
  A | Low latency, h/w independent | Predictability concerns [4] |
  B | Predictable, h/w independent | High latency                |
  C | Predictable, low latency     | H/w dependent, complex      |
  D | Predictable, h/w independent | Medium latency              |
  --+------------------------------+-----------------------------+

This approach is being tested for Google's production systems, which
generally find the "con" above acceptable, making it the preferred
tradeoff for our use cases:
  +------------------------------+------------+----------+--------+
  | HugeTLB operations           | Before [0] + After    | Change |
  +------------------------------+------------+----------+--------+
  | Alloc 600 1GB                | 0m3.526s   | 0m3.779s | +7%    |
  | Free 600 1GB                 | 0m0.880s   | 0m0.940s | +7%    |
  | Demote 600 1GB to 307200 2MB | 0m1.575s   | 0m5.132s | +326%  |
  | Free 307200 2MB              | 0m0.946s   | 0m4.456s | +471%  |
  +------------------------------+------------+----------+--------+

[0] For comparison purposes, this only includes the last patch in the
    series, i.e., CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y.
[1] https://lore.kernel.org/20240113094436.2506396-1-sunnanyong@huawei.com/
[2] https://lore.kernel.org/ZbKjHHeEdFYY1xR5@arm.com/
[3] https://lore.kernel.org/Zo68DP6siXfb6ZBR@arm.com/
[4] https://lore.kernel.org/20240326125409.GA9552@willie-the-truck/

Yu Zhao (6):
  mm/hugetlb_vmemmap: batch update PTEs
  mm/hugetlb_vmemmap: add arch-independent helpers
  irqchip/gic-v3: support SGI broadcast
  arm64: broadcast IPIs to pause remote CPUs
  arm64: pause remote CPUs to update vmemmap
  arm64: select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/pgalloc.h |  69 ++++++++
 arch/arm64/include/asm/smp.h     |   3 +
 arch/arm64/kernel/smp.c          |  92 ++++++++++-
 drivers/irqchip/irq-gic-v3.c     |  20 ++-
 include/linux/mm_types.h         |   7 +
 mm/hugetlb_vmemmap.c             | 262 +++++++++++++++++++++----------
 7 files changed, 360 insertions(+), 94 deletions(-)


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
-- 
2.47.0.rc1.288.g06298d1525-goog


