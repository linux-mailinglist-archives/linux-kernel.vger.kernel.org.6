Return-Path: <linux-kernel+bounces-558421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5174A5E5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F043AF35A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892E1EE019;
	Wed, 12 Mar 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tgg/XahW"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976D1D5147
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812838; cv=none; b=CNRY2QeVs/Fw8vZxgLjVa9x1jwyusfjyEojSboT4s3sUZxbkq6p+NPF3aZZmxVE42dxhYBw5ivTDsQwEPkLbggKtbVIrSuUNdUOlPtlkLuVDfsdgMk5l9N3wgjSoI/4JKxoqdjBfgk9GZ2TNF4lrFP4PHrK4slbRftNz9lYRAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812838; c=relaxed/simple;
	bh=/MmbwkeQUGVmncJhsUXNKhoSFEvo3tM9yk1Ot5QGVgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6ZzmTiCcLDLE1kc1DBErkIJx85WLbzvXmfFB9fnRjg/hG4kSDXmUokTLkEXq+8JBUhMXsPcofqeubQ9A72ppVHgGmw0w11dPCPE/crGitBXwK2oMNaZTkV9772YmjrpknFfDLFRvXoYDgMwoMymLv6c2p3JPW1HTwxAqsJyfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tgg/XahW; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 13:53:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741812833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/7qKXjq1jb6VK7u4Z6HuBd4o/fi6UtMIfLBku6uB6tQ=;
	b=Tgg/XahW8A+ZXHA6Q01CcAsuTheua57rrHZJGbdUooMcC2WMG2WDvvqbiUunRTp1IXXdxx
	rbbtEb/mnNXT/CPDF0FUxByqQLHoSURNqp9GrSz/i2ynwpoAjwBVERMsGLbqUeO8YsS4bR
	Qr1RuChCWSP8SCtc2te5EH1KlWyFuZU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <howlett@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/madvise: deduplicate madvise_do_behavior() skip
 case handlings
Message-ID: <2wyjtg6vj7ubyq3l5f7vch744xt67oorj7ywujvjwzscckrsjp@37z6d3zj6crw>
References: <20250312164750.59215-1-sj@kernel.org>
 <20250312164750.59215-4-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312164750.59215-4-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 09:47:49AM -0700, SeongJae Park wrote:
> The logic for checking if a given madvise() request for a single memory
> range can skip real work, namely madvise_do_behavior(), is duplicated in
> do_madvise() and vector_madvise().  Split out the logic to a function
> and reuse it.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

