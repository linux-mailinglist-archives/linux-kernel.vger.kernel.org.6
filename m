Return-Path: <linux-kernel+bounces-228155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2502915B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E29D1F21E09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095151BF54;
	Tue, 25 Jun 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U07Mhluz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E171BC23
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278376; cv=none; b=Tczo/j+wD9nUQeLQp0EKgXj98IsB9np5NHQHt0RgaYBxs47XQPXQmP9XMRHRO160iAK+UKgktdz1T1f9JLi4OAjeIZMCR+cSvbWrgdsEDkNLtX88fiItUrUwbU08Y9fVkL4qOyxLvRIt/3YQWdxvXLorAcUijWsVSoEwcj3zLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278376; c=relaxed/simple;
	bh=hl8DzPiMZFGRhrp1WZSG6/b29WAISU6j01dVgvMW95A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/y18W2U8ywe1ucuTHeb36ITQ/9J7wGnqXksK42UumisnNrA4JD0CA7NASwdb/9GUTZNrTYRcqn778dj9jSfT0l7b8KC57a0RGydTewVcFAO3gQ5RL/mD14z2rjrSyAF/aoOMHQ4B4W2NOxaNbfsg6ZBGPWijXnNAr8YBHzPwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U07Mhluz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719278374; x=1750814374;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hl8DzPiMZFGRhrp1WZSG6/b29WAISU6j01dVgvMW95A=;
  b=U07MhluzvUmVnBEv654v2IPE+qNSgI/X8C0IVIhZgZ3eP9byZQfMwEsQ
   EjPtscxRXgJOzJJReZc4kSHi6Q9k+zFlsJmlavMrEbci/iE+tBVHajriR
   GYPXKSz++3FOj8UbkxpeQRydPucgC8wgwX0vXlLQnpxSRc94GAlxTEnU7
   EY4EdXqCgcKOsMIB4FAKX2WyHLEsbMDCVHsYKPsNuw6gVJGw9JwWE7K1f
   grTzxJiZVSuoBj0WYmgMnI7VBGkoZs3xNX9S36mRabH8fJ/u1iiKfGkrx
   tHqr01vsYKpPYi7DERJyQC2iB7ci1jLWnXIPF/pLfcR5LEcNpuPjjAxfV
   w==;
X-CSE-ConnectionGUID: QgQ57jmzQ5WfF4xYQHAwfQ==
X-CSE-MsgGUID: EKTDvjhSQLS7+ksV218/ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16099684"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16099684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 18:19:33 -0700
X-CSE-ConnectionGUID: OMweji/PSgWk3WgZadzMEw==
X-CSE-MsgGUID: 3boZ5J7tSkCy6+sc3RcnDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48437550"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 18:19:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zhenneng Li <lizhenneng@kylinos.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] migrate_pages: modify max number of pages to migrate in
 batch
In-Reply-To: <20240624045120.121261-1-lizhenneng@kylinos.cn> (Zhenneng Li's
	message of "Mon, 24 Jun 2024 12:51:20 +0800")
References: <20240624045120.121261-1-lizhenneng@kylinos.cn>
Date: Tue, 25 Jun 2024 09:17:40 +0800
Message-ID: <87o77pzuq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Zhenneng,

Zhenneng Li <lizhenneng@kylinos.cn> writes:

> We restrict the number of pages to be migrated to no more than
> HPAGE_PMD_NR or NR_MAX_BATCHED_MIGRATION, but in fact, the
> number of pages to be migrated may reach 2*HPAGE_PMD_NR-1 or 2
> *NR_MAX_BATCHED_MIGRATION-1, it's not in inconsistent with the context.

Yes.  It's not HPAGE_PMD_NR exactly.

> Please refer to the patch: 42012e0436d4(migrate_pages: restrict number
> of pages to migrate in batch)
>
> Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 781979567f64..7a4b37aac9e8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1961,7 +1961,7 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
>  			break;
>  	}
>  	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
> -		list_cut_before(&folios, from, &folio2->lru);
> +		list_cut_before(&folios, from, &folio->lru);

If the first entry of the list "from" is a THP with size HPAGE_PMD_NR,
"folio" will be the first entry of from, so that "folios" will be empty.
Right?

>  	else
>  		list_splice_init(from, &folios);
>  	if (mode == MIGRATE_ASYNC)

--
Best Regards,
Huang, Ying

