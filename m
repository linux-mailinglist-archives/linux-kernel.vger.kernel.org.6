Return-Path: <linux-kernel+bounces-275602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99A948781
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E6AB23F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16E0182D2;
	Tue,  6 Aug 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wt6MotrE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702338BEE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910881; cv=none; b=oZ70W8SJN5Agt1rYFdLoT5R63bjuvHyCQp7uE1Afvexqput9sXOUO8FGUKZISI01G7asC+vhIJLpUcAWVZxr2s6ZTGQgjE3DFdDMv90tQVKIrhc//r49SIoiP3dHY8wFHpiMlrbYsILYLvw12ma9v3raE4yWcwFJOwU8L/xfOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910881; c=relaxed/simple;
	bh=C7QGy1Vf+HwzWXcfDSszLITKwcLN8o7qp1Sg6Y5zZWo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hphwKF1665i283PX9iSEseEKKct312LFsCQiNVdl3x+YN8LYyJN47FE3XXEYaemeO4i88HlSqIQBtiIa7JuRJ6Rgh+FPYGUX0+RwmsU3bgfJgXTh6KtDZQFzcJR0JoD4jPGsZBmLNV2CaKLsZljoNml1wmK0G3seWfUbqFKaIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wt6MotrE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66628e9ec89so6006127b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722910879; x=1723515679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Kc8NvROSpEJ78Xe6Sx1mH5t16b+U6BnKH8GqJIoFj4=;
        b=Wt6MotrE7vffJznFSkgq/0dJhanJGYYFiOqK9sRy1wyxpk25tAws9cimyBYy773kPx
         Vtlj3CRSGo31C7ST1sy/piO6+0pSjPtjthVC1XFH093zzgt1ms+PIjQprtoyTtrGJRSq
         ycqVydX8qMdTHNswtbO2+90LFAzwIPD9MvSVT9FyIm0rISeK2azKglFxyzNWd5d8F4RG
         mrhTtWWrdgDCjcPGrNhDIP6NNaLvvbEjaWA87yYy8h3nyGfSCDcKszAEOTFyI6no3aBk
         W387hoSnE+nXyNjNBf7LGJzyvIxeUy3wtbAqKfrAGC/7CcXjp6CFEqqZKWK24RXOgBe3
         nyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910879; x=1723515679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Kc8NvROSpEJ78Xe6Sx1mH5t16b+U6BnKH8GqJIoFj4=;
        b=Qr14xgHw9VoC4Tx3u/iCZoXtBBSj+2RgINgrJj9dZAzNz7XRSZcyXg9c6PtTKwk51t
         LBP/py9mrUrcP9fLxS+GugUy5jXb/hoM904eCXfYvCmCNTlexTvo63yRTnVG65dAun19
         5OMNcqjtL+vpRIb3g0mWARUEV3TuHggsBNdM+DxRuNZp2+hmn1B6MUR/I9AO6PF2oH6Y
         W9JGf/P7RhJ9Bc6duo1snQ5davRsOdA8r7xxiG2IKuwAyTK6BfhPPwFc33Q9wIgfEWwv
         ZvqIBdENsqEr0G2E3GVjvxQOodVRCrpYXN3265lU4G1bvMxm9udW5CCa8WD6TDgthzJF
         apYQ==
X-Forwarded-Encrypted: i=1; AJvYcCULHdigsdMApVXs92eciT4DqweyZBO69+LWjSAQ+YBbgdDM+GipV5MkeAfvpAtCFiqF03vnDlgsaybESoludt5mAmYD9LMuT0Dvkb+j
X-Gm-Message-State: AOJu0Yw0KtonuZSUso0aOLUkz4mAJT7wfnwNuhbSdLiLboCL1Zxl9rk5
	T4gVov+XpsM9Ev6lfOsZUoYwmzW4fJTxnILmweq6zBVdUXw2Cly6f+zzbVJVATuERrsLrCs0P/a
	JMg==
X-Google-Smtp-Source: AGHT+IE5/NNaCt5h6Dt2X5qRoBiXQ4vsQr7fZ9vFfiahcevMcB5gDtTReZIFb+NOuG8AhBrTRmTP6C97EcE=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:261c:802b:6b55:e09c])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2b0d:b0:dff:1070:84b7 with SMTP id
 3f1490d57ef6-e0bde21e24dmr26817276.5.1722910879294; Mon, 05 Aug 2024 19:21:19
 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:21:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806022114.3320543-1-yuzhao@google.com>
Subject: [RFC PATCH 0/4] mm/arm64: re-enable HVO
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Frank van der Linden <fvdl@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Muchun Song <muchun.song@linux.dev>, 
	Nanyong Sun <sunnanyong@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
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

[1] https://lore.kernel.org/20240113094436.2506396-1-sunnanyong@huawei.com/
[2] https://lore.kernel.org/ZbKjHHeEdFYY1xR5@arm.com/
[3] https://lore.kernel.org/Zo68DP6siXfb6ZBR@arm.com/
[4] https://lore.kernel.org/20240326125409.GA9552@willie-the-truck/

Nanyong Sun (2):
  mm: HVO: introduce helper function to update and flush pgtable
  arm64: mm: Re-enable OPTIMIZE_HUGETLB_VMEMMAP

Yu Zhao (2):
  arm64: use IPIs to pause/resume remote CPUs
  arm64: pause remote CPUs to update vmemmap

 arch/arm64/Kconfig               |   1 +
 arch/arm64/include/asm/pgalloc.h |  55 ++++++++++++++++
 arch/arm64/include/asm/smp.h     |   3 +
 arch/arm64/kernel/smp.c          | 110 +++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.c             |  69 +++++++++++++++----
 5 files changed, 226 insertions(+), 12 deletions(-)


base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.46.0.rc2.264.g509ed76dc8-goog


