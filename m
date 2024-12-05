Return-Path: <linux-kernel+bounces-432584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0729E4D45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B94166E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB255192D65;
	Thu,  5 Dec 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IhuvQarZ"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118B12E5D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733377182; cv=none; b=QmK93LMs8LAIWvOWz2CtBPaTHNZNTIrLTX1kNIgl3oHG5j0PX40p0404dQiQVcuX1YlqBzhy3CpCifo2QPcIlxp+xzPVYHi6agtCbh45gblwIgOYas5dmcEIVgdiBCu1DlKW9czIHkAr8/ycLfWBV63qMRGL172Bz363b/ZWIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733377182; c=relaxed/simple;
	bh=mm0MEPOq1k0gynXGuVfK9pMtBp2DC1z1hepqT1jCM9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTd+3JikRi+cXE/GD2T1kFtlA6Gi5iWXJCCh9LsxZ6ZyMJAOOVpMz/kymRrQ8/ZcqxROzvb046yJidZQRBIZU+dVeOeh1NbXQc4LtUm5ePC5ZOySTu6bLiQJt41mHRnNWZLOaJILYIOXa0tuguoKMVgRrCUS3L1lsSD171pNzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IhuvQarZ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733377170; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=eYNEZCdVidziIIvV5kKqn2NJL7IZHbjwLcQvEW69ZS0=;
	b=IhuvQarZjuEw1rGBU45w4SSPgJ3TOXbWvOlQoy45jhp5Es/HWn1ZDFXRaSgfSVzh5udySJL+BDnFvogVvkhg+Q1Pf2prDp/fCB28h1xjvG33hvMTzHYuga1HDmrq4jNtGONQtY6fONtq/XJBCgm+1i1RGJlzEvwsZ/9xJLZNnlg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WKs2Vyf_1733377156 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 13:39:30 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org,  21cnbao@gmail.com,  david@redhat.com,
  ziy@nvidia.com,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: drop redundant anonymous statistics for
 file folios migration
In-Reply-To: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
	(Baolin Wang's message of "Thu, 5 Dec 2024 11:53:48 +0800")
References: <d5e191ae02c2ab63c70cdf44877fe14fc69f5ae8.1733368611.git.baolin.wang@linux.alibaba.com>
Date: Thu, 05 Dec 2024 13:39:15 +0800
Message-ID: <87v7vy7kos.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Commit 5d65c8d758f2 ("mm: count the number of anonymous THPs per size") adds
> a new anonymous counter per THP size, however, when folio_mapping() is not NULL
> during folio migration, it means this is not an anonymous folio, so remove the
> redundant anonymous statistics in this case.

They may be anonymous folios in swap cache?

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e9e00d1d1d19..d7fdfdd23fd0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -523,8 +523,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>  	 */
>  	newfolio->index = folio->index;
>  	newfolio->mapping = folio->mapping;
> -	if (folio_test_anon(folio) && folio_test_large(folio))
> -		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>  	folio_ref_add(newfolio, nr); /* add cache reference */
>  	if (folio_test_swapbacked(folio)) {
>  		__folio_set_swapbacked(newfolio);

---
Best Regards,
Huang, Ying


