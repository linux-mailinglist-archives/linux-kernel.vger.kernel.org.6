Return-Path: <linux-kernel+bounces-338333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4398568E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923762823D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF815CD55;
	Wed, 25 Sep 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FWJxi/Ie"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5915383F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257336; cv=none; b=V2q/gJvAl666Toct/dq5hHQ1aw8wiDvRZ1xavCsq6TBFgg8J/eO36GibWSiABtOHtiVIsotp0xtn8DtM5+LFbVYp1IJ8uMftfaknTNrbn/aLU9a7fY/3XUB8zdcLadqC6qGEdiZrbMRCD6/BADQEtNww4+Rh7z2I3LnKMO5baYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257336; c=relaxed/simple;
	bh=kq/AyZVGfErRQFM5o3wcewf/LfTWWwC08Cz+1zsriXw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YeKcRRKh8sTd3sIwngPG/LVOB82k2ALiMxBOzjI2Jlv9VUwMc0numbW0PqKpalxCldcfunEpUFx/VBYGXjTjqj8I23OUlsun1UG/qd5nszwISB3jtYxRirvO15IUojBxAlmD4uHom7ao6vQzxG0VLvosrV+HyAS9P6YyHHV6ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FWJxi/Ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E775FC4CEC3;
	Wed, 25 Sep 2024 09:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727257336;
	bh=kq/AyZVGfErRQFM5o3wcewf/LfTWWwC08Cz+1zsriXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FWJxi/Ie30ZxGjuaPvvaqSiXc+e4sKNQAQD4Urxd3bLdKRJVOa/DV1k4Z67fFhssQ
	 Yim1Hsp15cLLwLAHsOYUiY7nBw2977NuRb26X06vx9BIGKHc5/bLbGIPgmcpKT1HLy
	 9Lw1oHQol0X5ZWvgMVBlLa/x8bqFIVEAin2RzCJc=
Date: Wed, 25 Sep 2024 02:42:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 <steve.kang@unisoc.com>
Subject: Re: [PATCH] mm: migrate LRU_REFS_MASK bits in folio_migrate_flags
Message-Id: <20240925024215.265614f6839e752882b1c28b@linux-foundation.org>
In-Reply-To: <20240925030225.236143-1-zhaoyang.huang@unisoc.com>
References: <20240925030225.236143-1-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 11:02:25 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Bits of LRU_REFS_MASK are not inherited during migration which lead to
> new_folio start from tier0. Fix this by migrate the bits domain.

I'm having trouble understanding this, sorry.  Please more fully
describe the runtime effects of this flaw.

> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -291,6 +291,12 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
>  	return true;
>  }
>  
> +static inline void folio_migrate_refs(struct folio *new_folio, struct folio *folio)
> +{
> +	unsigned long refs = READ_ONCE(folio->flags) & LRU_REFS_MASK;
> +
> +	set_mask_bits(&new_folio->flags, LRU_REFS_MASK, refs);
> +}
>  #else /* !CONFIG_LRU_GEN */
>  
>  static inline bool lru_gen_enabled(void)
> @@ -313,6 +319,8 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
>  	return false;
>  }
>  
> +static inline void folio_migrate_refs(struct folio *new_folio, struct folio *folio)
> +{}
>  #endif /* CONFIG_LRU_GEN */
>  
>  static __always_inline
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 923ea80ba744..60c97e235ae7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -618,6 +618,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>  	if (folio_test_idle(folio))
>  		folio_set_idle(newfolio);
>  
> +	folio_migrate_refs(newfolio, folio);
>  	/*
>  	 * Copy NUMA information to the new page, to prevent over-eager
>  	 * future migrations of this same page.
> -- 
> 2.25.1

