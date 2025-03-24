Return-Path: <linux-kernel+bounces-574521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC846A6E65C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C874E17593B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9CE1EB5DD;
	Mon, 24 Mar 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbIJoFtj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C117BED0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853791; cv=none; b=dyQJ2od86ON7Mv52ljdAAfy/+VueXygIQcblSGfImO3YKt/K3Q9nLZTitQezwqPG8NXJTtBv8qUuFq2lWgYNR8h8J94c4XZdUjJSd8s8lv2NDUq5VKGHFL6QO8GgZE0CwzAJAmco9hPYRIhBqKF3JnXn7Rtw5CEyiu1vwr08puQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853791; c=relaxed/simple;
	bh=0ZTznosOtnIFd3piZ+2dM5WQ3/TYsB7SFS1/yhuUZEg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XylrsACMZMLNhdB47nq568XzckvqWpwd6WERnjhzgqcks87rA/od3qiwoXRYhDI6OYRiRxp3VH27bMNB/6ibkfJ0obmfYeTmqixqG5jumMsjAyYamNWB25wmESmvc1GrxrUmUmsWav09D4vz4bx0H0cJ3PU8+2RbwkLVxWh763M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbIJoFtj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a960f9cso78185415ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742853789; x=1743458589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+jlhSt+zRcHOT32K00fMqybrca9+pySYTa39BSZD5ZM=;
        b=cbIJoFtjWF9ZBEobTVHd/x3j6a0Gp9Lc5+AEXkNbip6pyJDH0rSPKPLn38aTSYtWEp
         g1mr3JjltevQuzZbgAX4neeAz0jBn+TA8LHuttm2LQYejtRxiSwdtlzVIG8HhFCeBCRq
         i6pjzHjP6W5Lt93E989TMVpdoe9RbgOFBNxPcO6bH6YBOk0S0m8xyHn4R4tH4lJ5sCB8
         4+viiAo7hCz4/3XK2eDdHnqjDb5KxQ48fj91pdZfVRbKss42N41z3WEp34qsAvA6dY01
         0cr9d1DLKCh+5+mPO7nTQ8uDbRz45LvDqj2lnH2TE44AW1GVew73+F5RVCjxsfyizOOA
         dTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853789; x=1743458589;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jlhSt+zRcHOT32K00fMqybrca9+pySYTa39BSZD5ZM=;
        b=I61m+tEc+tUUWtmOmGS1xHMNwzp8jDp07IDpFi8T7kx20GNRPOW2lHzOuqFJDMgPko
         rrcuhI9nTH3NZKoD/yxFR3gzD8iPuHksoPpUtTSNvk0dmzxoBkWaB49XFJpDOub540qM
         FSG5+Eu8b5BJ8ZZDEOdVmlJ8fGZtJ0gr1qFq5wPQtNrJa1oAnATSbSGmBrNuAZtW6+OA
         NhocnrKedZjMGStyqhY4CxYmRTf0x6RQD7mB00qGU8oXz+iB93EXvuPhBOx4WWhfjY72
         jXfNgXNCqwcdECryoNdsYxJMyYmihfLLWjAjc7YZ4oq0ZRFmfIkM7vJi8wCrMmeF78A5
         Hd7A==
X-Forwarded-Encrypted: i=1; AJvYcCUTdwLt7xyV2xXovTWh8eoo7GwXmwsI9Tmv1dszqEOQVTeP8UhNfQc/bsQUR5SrE1D+rGoDYImIeW9DWto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbFvUlSqc/uK5HvL+JcNltsvmLKPBykK8U2s8g0zBspk31m+C
	/fhxMlDC3edhZSHgcbuonRRwDd/S2jryvBK54+0j8XAdbFFSZIEULlB3T8v4hUfBpS2Fn1BuJgm
	WeyErxMdY3w==
X-Google-Smtp-Source: AGHT+IGeOWd4IKU9kpcYW968CJzfD+7iaIXBkGZ1bvW2+ksZHg609U5g7s06PktVFz/qvmogxyC5p6gWhF2UFA==
X-Received: from plxm1.prod.google.com ([2002:a17:902:db01:b0:21f:40e5:a651])
 (user=kinseyho job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e549:b0:224:194c:694c with SMTP id d9443c01a7336-22780d9bd43mr266827275ad.28.1742853788991;
 Mon, 24 Mar 2025 15:03:08 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:02:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324220301.1273038-1-kinseyho@google.com>
Subject: [RFC PATCH v1 0/2] mm: multi-gen LRU scanning for page promotion
From: Kinsey Ho <kinseyho@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: yuanchu@google.com, AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com, 
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org, 
	dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com, 
	gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com, 
	jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com, 
	kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com, 
	liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com, 
	nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org, 
	raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com, 
	rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	hyeonggon.yoo@sk.com, bharata@amd.com, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a software-based approach to identify
hot pages for promotion in tiered memory systems, particularly those
leveraging CXL-attached memory, by utilizing the Multi-Generational
LRU (MGLRU) framework. This method is designed to complement
hardware-based hotness detection mechanisms like Intel PMU sampling, AMD
IBS, or dedicated CXL memory monitoring units, providing a more
comprehensive view of page access patterns, similar to kmmscand [1].

We propose to utilize MGLRU's existing infrastructure to provide hot
page information. A key benefit here is the reuse of the MGLRU page
table walk code, thus avoiding the overhead and duplication of effort
involved in implementing a separate page table scanning mechanism. The
working set reporting proposal [2] also reuses MGLRU's infrastructure,
but focuses on cold page detection. It provides its own aging daemon,
which could additionally provide hot page information by integrating
this proof-of-concept.

This series relies on kpromoted [3] as the migration engine to implement
the promotion policies. This is just an early proof-of-concept RFC
posted now in the context of LSFMM.

Kinsey Ho (2):
  mm: mglru: generalize page table walk
  mm: klruscand: use mglru scanning for page promotion

 include/linux/mmzone.h |   5 ++
 mm/Kconfig             |   8 ++
 mm/Makefile            |   1 +
 mm/internal.h          |   4 +
 mm/klruscand.c         | 118 +++++++++++++++++++++++++++
 mm/vmscan.c            | 177 ++++++++++++++++++++++++++++++-----------
 6 files changed, 267 insertions(+), 46 deletions(-)
 create mode 100644 mm/klruscand.c

-- 
2.49.0.395.g12beb8f557-goog


