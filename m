Return-Path: <linux-kernel+bounces-244970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62692AC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE341C21C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18841514F2;
	Mon,  8 Jul 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t9Si7Qwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325656452
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479849; cv=none; b=pJRULCP817IFqy1ETpaPZqrB/DK0V49T25r74oDXjcozhsnv77n/rGn8s/JyfG6SiVYuo7dqq0/yVPfFnIkl8ECEFX5ooUqTBqK+XJ0+/+HhEKwIAqclMyuDzAPzPYC2FQXfgBVDwUdMJZ7XiVrc0k8XGDqESsDykcXLumhv8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479849; c=relaxed/simple;
	bh=Tq/hhqS1+OnXToUn2WEmCEW7BwxSDuDaStLoeFV6yFk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OlwD+NdPnD56V7bLsf8SK5h7Cc5i+IGuwy5NLq/QW1Pmv6Sgh6rdT4JuF6EyQ+T+/ZSuazAgKBi4W/gpOOJ6r4WhRKa98D+RipJmYyLWOQYjK59twJZcDQz3UKwuhxEzkb9sCm1w4s8VpmivyF5dLT84ZK42bUNpreG3s/jr1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=t9Si7Qwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D316C116B1;
	Mon,  8 Jul 2024 23:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720479848;
	bh=Tq/hhqS1+OnXToUn2WEmCEW7BwxSDuDaStLoeFV6yFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t9Si7QwppVqej3YsdEFVrKl5GM6emLtHJ1fJ+xuPG01qx9MyQGoGlu2mYP62tv7qt
	 PSqlT3IXnpNLcpyQDo6HlLidTBk37OUeAcPfovTBFwpT4zjtIqYB00vps1Tqc8As8N
	 q2vWJ87LBnRwBmY4iDAJN0mhCTEq+FK8ZU1QrRjA=
Date: Mon, 8 Jul 2024 16:04:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Zi Yan
 <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Huang Ying
 <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/migrate: Putback split folios when numa hint
 migration fails
Message-Id: <20240708160407.a0c51eb11d0403c161d27540@linux-foundation.org>
In-Reply-To: <20240708215537.2630610-1-peterx@redhat.com>
References: <20240708215537.2630610-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jul 2024 17:55:37 -0400 Peter Xu <peterx@redhat.com> wrote:

> This issue is not from any report yet, but by code observation only.
> 
> This is yet another fix besides Hugh's patch [1] but on relevant code path,
> where eager split of folio can happen if the folio is already on deferred
> list during a folio migration.
> 
> Here the issue is NUMA path (migrate_misplaced_folio()) may start to
> encounter such folio split now even with MR_NUMA_MISPLACED hint applied.
> Then when migrate_pages() didn't migrate all the folios, it's possible the
> split small folios be put onto the list instead of the original folio.
> Then putting back only the head page won't be enough.
> 
> Fix it by putting back all the folios on the list.

mm/migrate.c: In function 'migrate_misplaced_folio':
mm/migrate.c:2624:13: error: unused variable 'nr_pages' [-Werror=unused-variable]
 2624 |         int nr_pages = folio_nr_pages(folio);
      |             ^~~~~~~~

Worrisome.  Which kernel version was this tested against?

> Don't need to copy stable if this can still hit 6.10..  Only smoke tested.

Also worrisome.  Are we to take an only-smoke-tested patch which
doesn't apply to mainline and which doesn't compile on mm-unstable into
mainline based on "only smoke tested"?

