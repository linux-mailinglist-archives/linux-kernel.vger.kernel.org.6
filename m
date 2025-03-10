Return-Path: <linux-kernel+bounces-555268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40561A5AD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F577173D03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFD1221708;
	Mon, 10 Mar 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+DE4Vt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00831B6CF1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649235; cv=none; b=KAIKwORBkq1niACSvu5A/i2hhfKd9ZX/3kdJQpt8RoEN2tLooBpwvPRXDZ1BcJq++bEuo08by5kJ4hh1hukGz/8/qD5WSs05JuSgXblILtYxzS6Glnb/vvKDzv3UVOre+HVVhVtY3IiP/2GWJiWk1jcg/92RU7JM+4OILa8Czpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649235; c=relaxed/simple;
	bh=47EISXtRQqop9PE2MAv9beMudQ9S+PaE967CyWdD+Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iukrTwIHwbfjl1qRl/UkJ+cqOJ+FIjWBEw4qZKLEznP4tPWrzV8egp5f5SZhMPzk32UQxJP8cG0/7wlIcllXiO4tPjr4XGHwYs2Py/hGvc2DkCFYFL9sxLSWWAsWuvB3+1rF+zkxRBWXhStKxVREXQAX2QklglPhtnbosoEwj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+DE4Vt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9A0C4CEE5;
	Mon, 10 Mar 2025 23:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741649235;
	bh=47EISXtRQqop9PE2MAv9beMudQ9S+PaE967CyWdD+Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+DE4Vt7oLaN9yWsBHFZUHJrHSqOrTISWwaoiY+WJC4+0RTkXcMLoS+saITHKWfe8
	 ANTVwN6/0nemk9HH9gPrm1wkAZ6M8GD5cVcQMFjAUakZanDt1jxN8UMLDef0zTxwUT
	 ms+z7w1w5MDCIYxEDza1aCsqKAbW2Vo6vNVLcb32ZMloaHUOT77Wqp3Ju/9jA1g3nY
	 8xyVjpC0EC/zmQauK3qYz/xhsrnosth+fqNo9lK/qeC7ECEWONBiKm0b/bJEhcJ/4h
	 +RgPZD55Sw+rU4nEyVMGs0jjwxbRSSgt37HPXREBdyek5rxyMLRP33TJR5POPzSIKp
	 SthCViD//oVVQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Mon, 10 Mar 2025 16:27:10 -0700
Message-Id: <20250310232710.74733-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310153921.47d390c637105e3ad6fc49c0@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 15:39:21 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 10 Mar 2025 10:23:09 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> >  It is unclear if such use case
> > is common and the inefficiency is significant. 
> 
> Well, we could conduct a survey,
> 
> Can you add some logging to detect when userspace performs such an
> madvise() call, then run that kernel on some "typical" machines which
> are running "typical" workloads?  That should give us a feeling for how
> often userspace does this,

I agree that could make this patch series more informative.

> and hence will help us understand the usefulness
> of this patchset.

Nevertheless, what this patchset is really trying to optimize is not the
madvise() use case, but process_madvise() use.  I believe the usage is
apparently common, given the vectorization based semantic of process_madvise().
Jemalloc is also adding[1] that kind of use case.  And the benefit is clear,
given the microbenchmark results that I shared.

Also, this patchset shouldn't introduce new regression to madvise().

Hence, I think the survey can be interestign and helpful, but shouldn't be a
blocker for this patch series.  Coudl you please let me know if I'm missing
something and if you still want the survey?

[1] https://github.com/jemalloc/jemalloc/pull/2794


Thanks,
SJ

