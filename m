Return-Path: <linux-kernel+bounces-372599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977669A4ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C656E1C21039
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6291BE241;
	Sat, 19 Oct 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1GEIIsX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CB1BDA9A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729301388; cv=none; b=Y9+RTGFyiUN32aGHKI9HrfRzYX7LEEKVRwWu1m1JzNX+mqQZvIDFjNQVio4raKbKDYUlYoGt2fVEt5bfFS1waSQBsqp/s7kUC7SEVrNS5f278k9sJKHvSv6HJ9M1m2kJWS6YHDPMYYnkSdnBM+iXxdNmSWd3nw+WfDEZ8m6G1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729301388; c=relaxed/simple;
	bh=3mtGNq9cGSGYrfQFZeSpQbC6OnKLuvDcJ3My6WR3hg8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C//amlKmNe0YxZHVU9ED8HKFzA60hdh3rFkWAJn4oJIya+1aq2EuZ195kpeUWwe3RO+wqK7Lz6rGEf0P6+POKqfXk6AHGn7bUdDg/5q8ZtxyExhAETwLO0O3v7QRpaQ2LxW76p46WToQ6bUVLonhVN+ljafXShkgQk4d7lLHdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1GEIIsX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e297a366304so4358515276.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729301384; x=1729906184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuCuzNJhXO6NMFow4//rMdfOZm/3Ta56iibLMueqV4o=;
        b=C1GEIIsX0Grr6+TDcrAUL+w5wqRsARy485p3C6OArX6GycOuzV9D3kU/6WDhVX/HVS
         NGDfPC0NGKlTATdn5A+4L40gdy/4Xpu85Q+0P6qICzVwyLLsnz2Wmr+K7ffPyncmoEct
         g5Ctj6/bHQddFexJUt775QlZ6tBjJtIPGBNCvQ11gZv6EdwOMA1U79XEsw2dHQMYL6lK
         kmjEk83BsSTycScO353qcGOnlM2rU+hLN+hzZlyHFYCFW0A7hnV0HE6+qsfgyVNFi6OE
         1wlurTQgF4YiQDtyYBB2ACM5XOtRqANIg7frtm37pT3TJXOtn3KJuPb/GETdaMlCTGTv
         A74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729301384; x=1729906184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuCuzNJhXO6NMFow4//rMdfOZm/3Ta56iibLMueqV4o=;
        b=qh9GNlVb9eA1HJvnjzw5/ZBOAD30gkXsxgp9z4b1AQGL/qWcSDhtZZhboiLVFdfMjs
         UiJUoE3saOnCAWIN4ErPaRYEutCexpb7kXzLWSL2y/iI38gAAUs5wsokoDsLUaJ/iy+X
         GuNn+1ICppcJz3iVFDWCTC1EXqte0Sf8wMhtAFrCsK7sSQ/2qx7Xv50wlHCtM5qfftFj
         gdKshohOa7o5rnidpy7QeOB0OZAYHio0lvalG3U2jaSYhU9B6VnmDOrH43CbBS4HifXw
         a6xxNch8JYJMGlgaDkh2nOiHXLH+9ZRyUpz8pzFwNP5q9aTJaQwDL5JgHLnntRFqujNW
         sBtA==
X-Forwarded-Encrypted: i=1; AJvYcCWIqh0UifZ7EEPrYospzD+u/kIjxOIrD97K4a9spuM0p3ul4InrYm2f4vcO2+AFQ1NyL21Ir3uCJvjaGO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHIwDb5qa6nrhGIlfkGHobkcHwUjVypHb6txYxmJWEnuI1pTU
	l9GNy3agJtdZ/zQ+Wg46KqJoDfy8MuL9vfxyQODTVdyFreLQhAph+Ye3YXxjjOIwwHx9J1SV3Dv
	MKMRJSgcx0KMSDoDfXQ==
X-Google-Smtp-Source: AGHT+IFmq0/1EPi5496WrRokUU9WA5t7S1WG8rkiw/MIseZ9iZLjY0dGBCILI69xXidmtmdxWEdpgYhtiPqAdLd2
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a25:81d0:0:b0:e28:eaba:356a with SMTP
 id 3f1490d57ef6-e2bb16d53e4mr14075276.9.1729301383632; Fri, 18 Oct 2024
 18:29:43 -0700 (PDT)
Date: Sat, 19 Oct 2024 01:29:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241019012940.3656292-1-jthoughton@google.com>
Subject: [PATCH 0/2] mm: multi-gen LRU: Have secondary MMUs participate in MM_WALK
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Houghton <jthoughton@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Stevens <stevensd@google.com>, Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Today, the MM_WALK capability causes MGLRU to clear the young bit from
PMDs and PTEs during the page table walk before eviction, but MGLRU does
not call the clear_young() MMU notifier in this case. By not calling
this notifier, the MM walk takes less time/CPU, but it causes pages that
are accessed mostly through KVM / secondary MMUs to appear younger than
they should be.

We do call the clear_young() notifier today, but only when attempting to
evict the page, so we end up clearing young/accessed information less
frequently for secondary MMUs than for mm PTEs, and therefore they
appear younger and are less likely to be evicted. Therefore, memory that
is *not* being accessed mostly by KVM will be evicted *more* frequently,
worsening performance.

ChromeOS observed a tab-open latency regression when enabling MGLRU with
a setup that involved running a VM:

		Tab-open latency histogram (ms)
Version		p50	mean	p95	p99	max
base		1315	1198	2347	3454	10319
mglru		2559	1311	7399	12060	43758
fix		1119	926	2470	4211	6947

This series replaces the final non-selftest patchs from this series[1],
which introduced a similar change (and a new MMU notifier) with KVM
optimizations. I'll send a separate series (to Sean and Paolo) for the
KVM optimizations.

This series also makes proactive reclaim with MGLRU possible for KVM
memory. I have verified that this functions correctly with the selftest
from [1], but given that that test is a KVM selftest, I'll send it with
the rest of the KVM optimizations later. Andrew, let me know if you'd
like to take the test now anyway.

[1]: https://lore.kernel.org/linux-mm/20240926013506.860253-18-jthoughton@google.com/

Yu Zhao (2):
  mm: multi-gen LRU: remove MM_LEAF_OLD and MM_NONLEAF_TOTAL stats
  mm: multi-gen LRU: use {ptep,pmdp}_clear_young_notify()

 include/linux/mmzone.h |   7 ++-
 mm/rmap.c              |   9 ++--
 mm/vmscan.c            | 105 +++++++++++++++++++++--------------------
 3 files changed, 60 insertions(+), 61 deletions(-)


base-commit: b5d43fad926a3f542cd06f3c9d286f6f489f7129
-- 
2.47.0.105.g07ac214952-goog


