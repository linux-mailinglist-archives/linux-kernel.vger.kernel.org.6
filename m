Return-Path: <linux-kernel+bounces-211858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14A490583C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9EAB2A409
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABBE1822C2;
	Wed, 12 Jun 2024 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C/wojmib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD51822CE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208041; cv=none; b=cYsnuqKAGqEzXq3zzJkw9h7IqOkt+JXqpqgw3EcCItzIhDkZtM8hCbwh5HxyN9yQoGLF5P1X1OaxCiqGzFd7znqWNjIlTzcojKyQ8IluRDAUpFw7dHIp3Mf/vP0qE3xIF0NUA2cYZaGgz7GX6OHKX2ouz2PGW4yZM8fbkVZlZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208041; c=relaxed/simple;
	bh=6Dj6THRj+i4dDXGDhbJq/b5ZEprPGb16YF9d3o2hP8U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YBmUft258sd772bODfTsMc5uMVjHJJTIFxnyaVve7pixehsZgfyCX+KihDjolxxxJXOetZQ1V+jzzbjBFnzE6N6TmqW33YGgd20ziqbp6W75/a3uHxM8vhMhtsOUgMbTCJIcjuoFzh+HpMa/K20WMprvmjyrZTNmTmHezllVHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C/wojmib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40796C116B1;
	Wed, 12 Jun 2024 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718208041;
	bh=6Dj6THRj+i4dDXGDhbJq/b5ZEprPGb16YF9d3o2hP8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C/wojmibINCCfGxwyxeUp3zJk5SwfhlMG5IVAwKr2sxAjndRyFJ0ovSt9K0X9her0
	 iRnUdvQ2Z0IG6DKVJb97ZCWStxgzKOwSkW4blo2IOW150aAyUwWp54TTxjPzDcQRX2
	 irTHkYc9JpXxJ+C+dF4itzt/MYtrD1CpOBvLDFCs=
Date: Wed, 12 Jun 2024 09:00:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/migrate: fix kernel BUG at
 mm/compaction.c:2761!
Message-Id: <20240612090040.090c20a398f3e9eb550e1a9d@linux-foundation.org>
In-Reply-To: <c3136c09-5120-1ca3-3470-0c947605a816@google.com>
References: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com>
	<87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<c3136c09-5120-1ca3-3470-0c947605a816@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 00:11:44 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> > It appears better to add
> > 
> >         stats->nr_thp_failed++;
> > 
> > too.  Otherwise, if migrate_pages_batch() is called via migrate_pages(,
> > MIGRATE_ASYNC, ), nr_thp_failed will not increase.  But if
> > migrate_pages_batch() is called via migrate_pages(, MIGRATE_SYNC*, ),
> > nr_thp_failed will increase in migrate_pages_sync() via
> > 
> >         stats->nr_thp_failed += astats.nr_thp_split;
> > 
> > That is, they are not consistent.  The issue exists since commit
> > 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split
> > list").
> 
> Sorry, I'll have to let you take over and send your own patch instead
> of mine - thanks. Those stats, and any attempt at consistency there,
> is way beyond me! I thought consistency was impossible, unless all
> the numbers were changed to order-0 counts.

I'll add this patch as-is for now.

