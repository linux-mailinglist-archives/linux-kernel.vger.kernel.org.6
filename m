Return-Path: <linux-kernel+bounces-440329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F429EBBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D456A281EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545C232370;
	Tue, 10 Dec 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeBhSeey"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5F13049E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866263; cv=none; b=OrcX11r7/arpxLJcJ6y+tTwthJklq9RAU9G9LKucacwf7yzcJvF9j7K8WBWyvpXST66CdpLukTwS4/PcnnYJ0GTcnENYBTe8+HK7b7+0svvmSGTaM+YA4Q2P9tHI6zQ418VoCoEI99HEOs9zPdplzFDuXkgmlZrXh3wHCOYoXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866263; c=relaxed/simple;
	bh=AVRyJxcMcPWnEchLu69pxtbUa06QeiBdsGB7SRVtcqw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fvtjik4AcTHYYazTP5H3YCteIRyRZNfomGKWEzsIi5YKouem1naekrCXg69LsQ33Kq0tm15H1kQopDGv3rl2LR8DEBVJk3d7V1tUVZAhzQX8PW4dkJnqnYoNMeJ9QtpjzZW2+W/V0vFKdBIQFBgDduMxdQCGDuvi8tDulfaO0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeBhSeey; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6d0ac78a9so469298885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733866259; x=1734471059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7dIOJwpIK+DMFQ8hJv6bbV8boeHzOxcNBeXs7z7ZtQ=;
        b=xeBhSeey0zXlNe1NjTUz5ZaukbJCB+k8CtnEsATM7MFTV9ZIho9Ic8avo+7USlh33e
         MdvrwWzWKvtVvHNRrbM0//5ujszF9kgskX5mqLKFvEK7iXIm9bM0Tn1k82IZdyDCxL8S
         eZDDY4i8LAer9Fa8ugOUPrFAaPV5or10BFuxC4ytoezCvc54mhpXIzxMoKOlhcsvLtWi
         i0VMhZqFMSGspK2KN8KYHP+LyQp8cyix3DGuyDF3nUIJYxmfqe9laRaWLBk6vySpuDta
         knKyJXkJeip2tRYOrKlXzsxrRiw+9XfvO7PGSUsKR8t74yBz8D9f9ctpHlEtYHZjea4g
         TDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866259; x=1734471059;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7dIOJwpIK+DMFQ8hJv6bbV8boeHzOxcNBeXs7z7ZtQ=;
        b=s73S4df6JOiuDLlt2g9LBsqANw8oKXN6CosFWm41Avpx1nDh8IYxCf4VPhk0P0KgK3
         r9+/X1GP6d2/4NpOcK7FSkUz3MDdoZggkHSb2y2FNzJhTYkEVk2QLlLy9M6SygdsVaNL
         RPLa6FD03V1vJkQkKH2R4v2bXQ4VJm1iV3IxjFzi9NjdkafxmDL+kHzxir89lHVXD0Hr
         bLvmDS0aKZTL9ehmlSL1pUR6uQx7T87WNAUPHdeYWJtzHfpG/HMmGRRduazdpXTI6ite
         ogGlSJskHm2BBi62V5Pr4XWHF+6vIzutr5wwsmuV1A/Ku7rNOw2R3DVOAm5z0Pfaxpc2
         wjcg==
X-Forwarded-Encrypted: i=1; AJvYcCUpXmAeEZz+ftVXW/Pl4LcmewI8xHS4JnV/W571WI1MGN1pVY1lo89Q1KcTeadM1hwR7a5eWZgKrKbVmi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysU1dZuyI8T5esU+QwRuV+WS6pGe4S2sikJruFuKQwE/nsiQ3A
	9GZQinAUgP5GV4sicEUmHA47eNgK3EB9b2Zf8yvk7a9XjsWH9jbHCFZt6oox5R8ezIiEbYNOCjr
	D4cm2LA==
X-Google-Smtp-Source: AGHT+IFAIU7f+wfqSacMneWm1FlqBYTn2gwv6AQPmqTyEeVFWqYtuzWyChRfemA5F0mctYYZSfHkc/RQodwH
X-Received: from qkww8.prod.google.com ([2002:a05:620a:948:b0:7b6:ce2a:2b71])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4809:b0:7b1:161c:ef58
 with SMTP id af79cd13be357-7b6eb487beemr98918985a.28.1733866259591; Tue, 10
 Dec 2024 13:30:59 -0800 (PST)
Date: Tue, 10 Dec 2024 16:30:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210213050.2839638-1-bgeffon@google.com>
Subject: [RFC PATCH 0/5] mm: Fix mremap behavior when using addr hints
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

When MREMAP_DONTUNMAP was added in e346b38 ("mm/mremap: add
MREMAP_DONTUNMAP to mremap()") we inadvertently allows for an
address hint to be specified when not using MREMAP_FIXED. This is because
mremap(2) with MREMAP_DONTUNMAP it shares a code path with MREMAP_FIXED
in mremap_to(), which means this function can be called in 3 different
scenarios: MREMAP_FIXED only, MREMAP_DONTUNMAP
only, or MREMAP_FIXED | MREMAP_DONTUNMAP. In the second case when only
MREMAP_DONTUNMAP the new_addr is passed to get_unmapped_area() which
behaves like a hint as it does with mmap(2).

Glibc now expects this behavior so it would seem it probably cannot be
removed [1]. Additionally, as Jann Horn pointed out Debian apparently
has tests for this odd undocumented behavior [2].

This series attempts to reconcile this situation.

Patch 1: Will fix the checks that should only apply to the MREMAP_FIXED
case, so that they don't apply to just MREMAP_MAYMOVE.
Patch 2: Addresses an actual bug where we can allow a hint which is
lower than the mmap_min_addr.
Patch 3: Since we're stuck with this behavior we might as well support
it for mremap(2) when MREMAP_MAYMOVE is specified.
Patch 4: Self tests for patch 1
Patch 5: Self tests for patch 3

I will mail man page updates once we finalize on the behavior for
mremap(2).

1. https://sourceware.org/git/?p=glibc.git;a=commit;h=6c40cb0e9f893d49dc7caee580a055de53562206
2. https://sources.debian.org/src/glibc/2.40-4/debian/patches/git-updates.diff/?hl=22820#L22818

Brian Geffon (5):
  mm: mremap: Fix new_addr being used as a hint with MREMAP_DONTUNMAP
  mm: mremap: Use round_hint_to_min() for new_addr hints
  mm: mremap: Allow new_addr to be specified as a hint
  selftests: mm: Add a new MREMAP_DONTUNMAP self test
  selftests: mm: Add selftest for new_addr hint with MREMAP_MAYMOVE.

 include/linux/mm_inline.h                     |  14 +++
 mm/mmap.c                                     |  13 --
 mm/mremap.c                                   |  34 ++++--
 tools/testing/selftests/mm/mremap_dontunmap.c |  41 ++++++-
 tools/testing/selftests/mm/mremap_test.c      | 113 +++++++++++++++++-
 5 files changed, 189 insertions(+), 26 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


