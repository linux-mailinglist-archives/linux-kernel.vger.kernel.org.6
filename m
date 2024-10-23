Return-Path: <linux-kernel+bounces-378818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B69AD5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41BEB246B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397275809;
	Wed, 23 Oct 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ORrYL8Xb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D11DEFD8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716082; cv=none; b=PgwOywkGG8R6u0W7BC2Xyh5iXE94dpMDKX23OW0aZ+6S2MwoRJswhy1wJzi2mZ0aZuOkKWN7/cjXds2c+h27vrPNpb/GLmEWgYYcm0f1RLb2azZ1z1xrrrWl2wRP41z5tExQUxmUE7IDXfDuGZ8sw7F6os1E7e+derqtvkzju40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716082; c=relaxed/simple;
	bh=3JRZMNUNQedJCcz0d6X+3HKipkE+z+AGyw055WODxJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gI9lOwoUwyFfvvZMetGlIWdkFS7SgWdkhngATrQn4PIpXkPfcQe4dHbfaGJgfyobahSS6MyfGkaIt+cvCJLlvPNBXI5j1tp6H7k4x58XB+le0m9mIjucEkfnujN0+uC+vmyq8mP3LdNU8V7vhasqsmAqmt62S13FdUBfgIUDi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ORrYL8Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B2DC4CEC6;
	Wed, 23 Oct 2024 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729716082;
	bh=3JRZMNUNQedJCcz0d6X+3HKipkE+z+AGyw055WODxJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORrYL8Xb0+DKOh5QHCipmhyIA+N35jK8Ld70+mse2XqSVBdlihm+zw0iQuBbUVHN0
	 GhfZn4Hkjmnd30A+eudjOKMyRhOBzGbwiXKijtQLhn6g7cxaNhG8Z1Tr7Br2IoOLmF
	 2FTBA3TQbyxFj7DXMSk+3gtaIMZGzdCcmiFVlOQY=
Date: Wed, 23 Oct 2024 13:41:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dongjoo Seo <dongjoo.linux.dev@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, dave@stgolabs.net, dan.j.williams@intel.com,
 nifan@outlook.com, a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-Id: <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
In-Reply-To: <Zxk6bHlrP5S_0LBK@tiehlicka>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
	<Zxk6bHlrP5S_0LBK@tiehlicka>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 20:03:24 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Wed 23-10-24 10:50:37, Dongjoo Seo wrote:
> > This patch corrects this issue by:
> 
> What is this issue? Please describe the problem first,

Actually, relocating the author's second-last paragraph to
top-of-changelog produced a decent result ;)

> ideally describe
> the NUMA topology, workload and what kind of misaccounting happens
> (expected values vs. really reported values).

I think the changelog covered this adequately?

So with these changelog alterations I've queued this for 6.12-rcX with
a cc:stable.  As far as I can tell this has been there since 2018.

: In the case of memoryless node, when a process prefers a node with no
: memory(e.g., because it is running on a CPU local to that node), the
: kernel treats a nearby node with memory as the preferred node.  As a
: result, such allocations do not increment the numa_foreign counter on the
: memoryless node, leading to skewed NUMA_HIT, NUMA_MISS, and NUMA_FOREIGN
: stats for the nearest node.
: 
: This patch corrects this issue by:
: 1. Checking if the zone or preferred zone is CPU-less before updating
:    the NUMA stats.
: 2. Ensuring NUMA_HIT is only updated if the zone is not CPU-less.
: 3. Ensuring NUMA_FOREIGN is only updated if the preferred zone is not
:    CPU-less.
: 
: Example Before and After Patch:
: - Before Patch:
:  node0                   node1           node2
:  numa_hit                86333181       114338269            5108
:  numa_miss                5199455               0        56844591
:  numa_foreign            32281033        29763013               0
:  interleave_hit                91              91               0
:  local_node              86326417       114288458               0
:  other_node               5206219           49768        56849702
: 
: - After Patch:
:                             node0           node1           node2
:  numa_hit                 2523058         9225528               0
:  numa_miss                 150213           10226        21495942
:  numa_foreign            17144215         4501270               0
:  interleave_hit                91              94               0
:  local_node               2493918         9208226               0
:  other_node                179351           27528        21495942
: 
: Similarly, in the context of cpuless nodes, this patch ensures that NUMA
: statistics are accurately updated by adding checks to prevent the
: miscounting of memory allocations when the involved nodes have no CPUs. 
: This ensures more precise tracking of memory access patterns accross all
: nodes, regardless of whether they have CPUs or not, improving the overall
: reliability of NUMA stat.  The reason is that page allocation from
: dev_dax, cpuset, memcg ..  comes with preferred allocating zone in cpuless
: node and its hard to track the zone info for miss information.
: 


