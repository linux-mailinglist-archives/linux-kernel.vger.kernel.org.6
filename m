Return-Path: <linux-kernel+bounces-556951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD72A5D14E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C96F189D2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245A224AEB;
	Tue, 11 Mar 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpvoTqWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FC1E9B0C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726936; cv=none; b=OiYYx0r09gjhiA068bSm4MpX5uCpFS6ZhNddtQAwcPue9yMoBkB2yM+uuKa1IT+crdKwLCx7lI63+BgGglPZZfH8eT/S7K+o2v0j6hPDFDVEraC4ExWq82BXwaNtzcBBdhk4RDV4mruoUAjhs/7JUH2nPT9eVyhBH4Or8/F4LT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726936; c=relaxed/simple;
	bh=bqNgkQjOZTpB7bd8OVx7GHW4g2rvXGrtTW5DxlB6vS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1XKl1CQTmoTYgqu4QeDF9hCgTHPYb+4tM3NViEp7tWWURs7frh27VfEVZNQlfC/UPu1LQpQR8wSHWv6ws/hU2T3Pj/8QDa04aWxZKuBiY8BejHkGbAw27agD/ouL+108pC/LGq06YypAfVddCu1494L2Q7nHgGzOfUznMbRyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpvoTqWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F6C4CEE9;
	Tue, 11 Mar 2025 21:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726934;
	bh=bqNgkQjOZTpB7bd8OVx7GHW4g2rvXGrtTW5DxlB6vS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpvoTqWRVQEy0nY1+hZjcU5w99s4/5imhn/5d59d3+ftN2SvFCwZZTZFnt4iR/mzj
	 tGP0sr0rSvnytBWCaXEAmBJKF/N9IpqVVFoR6Anal7g3iE1AfQ2z5wCOrCcz8bY/qp
	 PJBv2vlFQxLWLeoSV51uFVdAo0syB9gMd8VGZEgyfbyx3Cc8Etx1Se5DEhiiBZ1+jY
	 rYFJ6S4ocW8u6G4v+NHvVsVUS1qOj/r2G46mptWBENYDQz93vu7YMELDQ7a7Q61SQW
	 JMdCM77hzDWvWphfhnDQUVvGrIO4c/ve9hgv9px8g1w3gq40NVarKAgU6jtV0mwmGo
	 NVmglbTLZFqHg==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 9/9] mm/madvise: remove !tlb support from madvise_{dontneed,free}_single_vma()
Date: Tue, 11 Mar 2025 14:02:11 -0700
Message-Id: <20250311210211.85566-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <246b547e-d7ad-44c7-9652-6f5a72828b26@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 14:01:20 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Mar 10, 2025 at 10:23:18AM -0700, SeongJae Park wrote:
> > madvise_dontneed_single_vma() and madvise_free_single_vma() support both
> > batched tlb flushes and unbatched tlb flushes use cases depending on
> > received tlb parameter's value.  The supports were for safe and fine
> > transition of the usages from the unbatched flushes to the batched ones.
> > Now the transition is done, and therefore there is no real unbatched tlb
> > flushes use case.  Remove the code for supporting the no more being used
> > cases.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> Obviously I support this based on previous preview :) but I wonder if we
> can avoid this horrid caller_tlb pattern in the first instance.

I will try, though I have no good idea for that for now.

Maybe we could simply squash patches 7-9.  I'm bit concerned if it makes
changes unnecessariy mixed and not small, but I have no strong opinion about
it.  Please feel free to let me know if you want that.

> 
> FWIW:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Appreciate your reviews!


Thanks,
SJ

[...]

