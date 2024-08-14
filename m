Return-Path: <linux-kernel+bounces-285975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C94951511
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E9E1F21B95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B113AA36;
	Wed, 14 Aug 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mM4rHg8L"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941B77F11
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619673; cv=none; b=uk/72XosOQl/2lyIi4YzMQTTEiEJHnQYeUgCVLMTMYLF5Z3oGwyrbR0YiySLd3EPtbFNQ1Zxn9O8oJUQwg9228CQl7d2lDy6vq4EAhg1vT0JyuOQl11iN7Js1BkMpOSx4y2QK+2TOlPc7jC16YfUsTrV/55hvQ8TfN3exY0yroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619673; c=relaxed/simple;
	bh=brPAjMdAxyVmTtvLRIgAXuSdAuoKek9fo+ninmBAJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVxnOKbTuGVvOlsOsXsa2TfWUAV9cIlHwREvnMyPSf0S/a3C5R/91CCKJBdRVQ4jKpb0g2SLJzeKHL2AX9jqiM1yu5pOmrUm9R71qAVmuuUHqIPtFKwogerfJheplp0vfWYlYl1S79DaV8/PlBZwuyJ7VlopH8pQSf44dAM4Wqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mM4rHg8L; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14cc9066so4184211b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723619670; x=1724224470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwReknVIrDSfw0EPNLA7Z9rOAS1qkGFQa9Wg0CMwvkc=;
        b=mM4rHg8LBJJ0dGlbU3RSKAYUnHCOdik2y0Z6E3RYL0yuzsIV/A+db3cruBzjJPzVPS
         tMv+jQdlxhxvmHKbjcSjbsfXkw0pdHOrJnjNyKw/6pYHQJnukWVIsdJAOeqrMooPemXZ
         GdUmJgqRkQddJ0O0bw0b2KAi2+gqpGNQAZs2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619670; x=1724224470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwReknVIrDSfw0EPNLA7Z9rOAS1qkGFQa9Wg0CMwvkc=;
        b=vTTYUBdiIXvulu638sLjwFMATeAHb3BIBX+jKTdTf2Pd4tEkRB0qHI7a5nsmeHVw1F
         wwK1DpfaL/lwdnYkDEJPtIUVnuaf3ngvtJ6gl0DMavoaYSzppdXwG/665TjyN0OW4qbX
         8wNBGbE6BZwAi0zDEuZROmY3zSMNXoY3/2cqToIldEBhYMtPzmu+dDRSAKj5ACxuxxkc
         UrC7VXiyW+w5ZKVgDkEnJygkIBjiOFL8EeYmUetNRwSkComgqfA+x5JuVMwp2NhfqlHM
         Q8qVEhadgv0y1hYSpJq4WEQOOODUThQyIPBnBGWuaKZOMig5yHFyKuuz2eA/syrLdJ3r
         CUZA==
X-Gm-Message-State: AOJu0YypZZQTiDOSj8Aq/N1o8JcFkA4DyVIDXACb60/2nsePu7Ljgsj2
	v5mvUsVR1RB6I86cb6zjm9Y7fCZSWWmKwqOV/IyQ5z43I8rz4ZonS4DfYqcirw==
X-Google-Smtp-Source: AGHT+IHYwRGCLISGoy8hJhOKkAgqX6DtlBOZAVZZqhX4BMHm8h57bmHw97vihcaDfkE2jw2NCAP0Jw==
X-Received: by 2002:a05:6870:3508:b0:268:9642:aa08 with SMTP id 586e51a60fabf-26fe59da324mr1981775fac.10.1723619670385;
        Wed, 14 Aug 2024 00:14:30 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-710e5873ad4sm6962870b3a.15.2024.08.14.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:14:29 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	jeffxu@google.com,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 0/2] mremap refactor: check src address for vma boundaries first.
Date: Wed, 14 Aug 2024 07:14:22 +0000
Message-ID: <20240814071424.2655666-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

mremap doesn't allow relocate, expand, shrink across VMA boundaries,
refactor the code to check src address range before doing anything on
the destination, i.e. destination won't be unmapped, if src address
failed the boundaries check.

This also allows us to remove can_modify_mm from mremap.c, since
the src address must be single VMA, can_modify_vma is used.

It is likely this will improve the performance on mremap, previously 
the code does sealing check using can_modify_mm for the src address range,
and the new code removed the loop (used by can_modify_mm).

In order to verify this patch doesn't regress on mremap, I added tests in
mseal_test, the test patch can be applied before mremap refactor patch or
checkin independently.

Also this patch doesn't change mseal's existing schematic: if sealing fail,
user can expect the src/dst address isn't updated. So this patch can be
applied regardless if we decided to go with current out-of-loop approach 
or in-loop approach currently in discussion.

Regarding the perf test report by stress-ng [1] title:
8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression

The test is using below for testing:
stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemove 64

I can't repro this using ChromeOS, the pagemove test shows large value
of stddev and stderr, and can't reasonably refect the performance impact.

For example: I write a c program [2] to run the above pagemove test 10 times
and calculate the stddev, stderr, for 3 commits:

1> before mseal feature is added:
Ops/sec:
  Mean     : 3564.40
  Std Dev  : 2737.35 (76.80% of Mean)
  Std Err  : 865.63 (24.29% of Mean)

2> after mseal feature is added:
Ops/sec:
  Mean     : 2703.84
  Std Dev  : 2085.13 (77.12% of Mean)
  Std Err  : 659.38 (24.39% of Mean)

3> after current patch (mremap refactor)
Ops/sec:
  Mean     : 3603.67
  Std Dev  : 2422.22 (67.22% of Mean)
  Std Err  : 765.97 (21.26% of Mean)

The result shows 21%-24% stderr, this means whatever perf improvment/impact
there might be won't be measured correctly by this test.

This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
And I reboot the machine before each test, and take the first 10 runs with
run_stress_ng 10 

(I will run longer duration to see if test still shows large stdDev,StdErr)

[1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
[2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c


Jeff Xu (2):
  mseal:selftest mremap across VMA boundaries.
  mseal: refactor mremap to remove can_modify_mm

 mm/internal.h                           |  24 ++
 mm/mremap.c                             |  77 +++----
 mm/mseal.c                              |  17 --
 tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
 4 files changed, 353 insertions(+), 58 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


