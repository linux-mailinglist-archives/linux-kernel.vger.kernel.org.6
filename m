Return-Path: <linux-kernel+bounces-235740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D6591D91F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A41B1F21D28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9C6F2F1;
	Mon,  1 Jul 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA42ONo8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029425028C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819498; cv=none; b=Z1+ktvcuGIIotb2RwOaQFzDt+S5XSPUjTq//S2/LL1rkROlJdthk3Ry/NsIHovXet/dBk9tFOPUsyVRrTBfZ3RF0h52Qxt5b90oR29b2Rk3ImXCEvctW12T8e3HCZpzLZux9/6AkrL7q8wvQV47RESxvk/eDQoGrsUaiKCi+Rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819498; c=relaxed/simple;
	bh=facbaRCnbSQSPEJ4NU4guvxeVPVmZBrJDP2YaKOJGH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wca3z9sxuxwcvpN4gAzOFDsPqHUwYAWgGWd+AHr5dPMb4xE8OjPzKcGEoAWbEBbbKTAegeyQOEPll0CeUGVrlfRWAWjajhk/B0y62mAq+reCZ6lr295yoaKpmjOUgkh+cNC7Z6Xnn7uXiWjECKOuXpeGJyqPlAvu2Y+xnCUmO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA42ONo8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719819497; x=1751355497;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=facbaRCnbSQSPEJ4NU4guvxeVPVmZBrJDP2YaKOJGH4=;
  b=LA42ONo8Sw28x88kMe15MWmRBarMHLH2rssD8TdjXWMRtA/TiJAGVtOP
   mQlaPGZk/9EdDz9wIxL/qpUUnOpPkKkYS9k+WxNyoTDusskPFX8A9Cbjb
   m7qwwYxaORVTGT5vgW9V8n0B37b1gOJExU8HAy+CObR/7sqXe9L0eaT9k
   l8xCCqm9uSGXiTF5WyX5S9NNwmLl4fIzZ9rCpjb/TV9tE+9wMkBqSq5IS
   mqtOvzmzRW2prQZy2xxeAWrrHLbCuLDewxwd3RofgyB8GvMx4VVzICg5X
   dOBgDNL68qLMkweDBD4KWEVK9mR06tpD+tzSJ8TXtB942lYlQhfvCdjUh
   A==;
X-CSE-ConnectionGUID: +nQJfwG9SROuLIhTszIDcg==
X-CSE-MsgGUID: ox40AmOxRAiugmyNbVOJtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="28324752"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="28324752"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 00:38:16 -0700
X-CSE-ConnectionGUID: GB8kuVrgQeCem9zhK20QJQ==
X-CSE-MsgGUID: JTvTZ1kXQOG5KpD8ugvahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="76610300"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 00:38:15 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/2] mm/migrate: make migrate_misplaced_folio()
 return 0 on success
In-Reply-To: <20240620212935.656243-2-david@redhat.com> (David Hildenbrand's
	message of "Thu, 20 Jun 2024 23:29:34 +0200")
References: <20240620212935.656243-1-david@redhat.com>
	<20240620212935.656243-2-david@redhat.com>
Date: Mon, 01 Jul 2024 15:36:23 +0800
Message-ID: <87plrxo96w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> Let's just return 0 on success, which is less confusing.
>
> ... especially because we got it wrong in the migrate.h stub where we
> have "return -EAGAIN; /* can't migrate now */" instead of "return 0;".
> Likely this wrong return value doesn't currently matter, but it
> certainly adds confusion.
>
> We'll add migrate_misplaced_folio_prepare() next, where we want to use
> the same "return 0 on success" approach, so let's just clean this up.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 5 ++---
>  mm/memory.c      | 2 +-
>  mm/migrate.c     | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0fffaa58a47a..fc27dabcd8e3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1652,7 +1652,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  	int nid = NUMA_NO_NODE;
>  	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
> -	bool migrated = false, writable = false;
> +	bool writable = false;
>  	int flags = 0;
>  
>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> @@ -1696,8 +1696,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	spin_unlock(vmf->ptl);
>  	writable = false;
>  
> -	migrated = migrate_misplaced_folio(folio, vma, target_nid);
> -	if (migrated) {
> +	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>  		flags |= TNF_MIGRATED;
>  		nid = target_nid;
>  	} else {
> diff --git a/mm/memory.c b/mm/memory.c
> index 00728ea95583..118660de5bcc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5354,7 +5354,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	ignore_writable = true;
>  
>  	/* Migrate to the requested node */
> -	if (migrate_misplaced_folio(folio, vma, target_nid)) {
> +	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>  		nid = target_nid;
>  		flags |= TNF_MIGRATED;
>  	} else {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 781979567f64..0307b54879a0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2629,11 +2629,11 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>  					    nr_succeeded);
>  	}
>  	BUG_ON(!list_empty(&migratepages));
> -	return isolated;
> +	return isolated ? 0 : -EAGAIN;

Is it good to use -EAGAIN as error code always?  At least if
nr_remaining < 0, we can use that?

Otherwise, this LGTM.  Thanks!

>  
>  out:
>  	folio_put(folio);
> -	return 0;
> +	return -EAGAIN;
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>  #endif /* CONFIG_NUMA */

--
Best Regards,
Huang, Ying

