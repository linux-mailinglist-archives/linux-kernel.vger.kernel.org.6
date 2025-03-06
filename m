Return-Path: <linux-kernel+bounces-549706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB2A55633
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876653AA46E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5AA26D5A7;
	Thu,  6 Mar 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0N1vktV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB025A652
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288227; cv=none; b=L3S4TNqhOiFlE8sfiu1q2vMSEsYd2/2uZLh/svv8HFU8Ff9npcK9A8hQq2JuBPjnZ9x6PnLlxq/EqmyVuFlB5Kp/1wXVvlULY+HRkm7YitL1qEm1eHEooMEep9tEsnS3QqIKFfQr80YS7LonFfCJviXPHn5FcnygOv8Io7bf2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288227; c=relaxed/simple;
	bh=orwaiUZYpxojOQ8liv3YM5LpFbMZEiHn83hNoRuAd6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTvNlXWtq4y+RbjBE+DppGbm8zbIK67xkxJViKZ7A+k8bzMAsXcRaWJPCrrkg/jNLczZkIHLyiliBsk6en7hTKQDGlvjaRDK1Ud1Bi3e9P1MEDqt/hgN+KqWcRLkjsqRgH8GgDHXjwIaRlk3WSpY/scsIzCVr/zZRfvyhB+iI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0N1vktV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6543C4CEE0;
	Thu,  6 Mar 2025 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288227;
	bh=orwaiUZYpxojOQ8liv3YM5LpFbMZEiHn83hNoRuAd6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0N1vktVB6dEMhF1ILKu5KYjotqzNtSTVcL3qLO9JHQxJOEy7YtOoDDjtiMf9r1sw
	 1fgucxNcc7SRkBmLQE30KLqUtkjuvXOpM7idXPzca9gKmbX65wExi3aC40k0cigOS4
	 d4sqj0KvpYJKJ7aYRJCQzF9r2zwN8uvit4CgevzxAKdQEpgxxx8PfaKi5EzSYS90EA
	 +XcZVoXZ5bAwahwJIHBM+Ewg8Pez9DtzuCC8SMWBmz0OlNWKmZ9mC/n+EvkYBWPTs2
	 c/OdKBCslb98ggF7yvnDKnwig1+WJeCDSVzQO2uPI9/SA8wDfSfjClHxqJ8xwCSNct
	 owFFW3Fai2EjA==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 10/16] mm/madvise: let madvise_dontneed_single_vma() caller batches tlb flushes
Date: Thu,  6 Mar 2025 11:10:23 -0800
Message-ID: <20250306191024.842888-1-sj@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <hacxdm53iyd3xevvzcap65mtg5rgtwlpzur3q4lj5qjeejcht5@rnhloth5o3c5>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 6 Mar 2025 10:36:08 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 10:16:05AM -0800, SeongJae Park wrote:
> > Update madvise_dontneed_single_vma() function so that the caller can
> > pass an mmu_gather object that should be initialized and will be
> > finished outside, for batched tlb flushes.  Also modify
> > madvise_dontneed_single_vma() internal code to support such usage by
> > skipping the initialization and finishing of self-allocated mmu_gather
> > object if it received a valid mmu_gather object.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> Please squash patch 10 and 11.

I will do so in the next version.


Thanks,
SJ

