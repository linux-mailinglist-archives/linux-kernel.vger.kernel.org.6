Return-Path: <linux-kernel+bounces-360620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D96999D55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818DA1F22D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6E1CDA19;
	Fri, 11 Oct 2024 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kC8qaaGy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1419C579
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630068; cv=none; b=IRl1d9cpvUG/2oqIySn26UnO08HwmJr2X9DmnMJumvEeqfddIYW7rdktHQaqPOQI2r/Sf8FTK5K2kNwyQKSM6uwbkm5IqxmLZwtognq+Z3659ZR+STUj3773puTeEbQPVjvPpoiZki6T0iAtAC0QtgU7wJ+xuOAFCdxhQDiU2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630068; c=relaxed/simple;
	bh=MwumLah0heogfgY2jBbaLZlTmYy8EmATRxyZJ/sFqnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XawSfEhB/0BKxyRFtu16CwXl2gfTeppepFBlTWGEIG5FsV5h612dIDOPiHDwnp7o/fMp8FQozKOzFBYJ0gpq6qbw3Uh9TVCiWX95+hLhtE2pPH+5MkByuHRN50oFrconzc516m5pybcHAN+hb8d5BL/EWzsIqydHdL7AOg86NAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kC8qaaGy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728630066; x=1760166066;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MwumLah0heogfgY2jBbaLZlTmYy8EmATRxyZJ/sFqnI=;
  b=kC8qaaGyOiBRnNg9kfe3C4EfvV8vBfTbfPgwZUznIPUyzC6Be5qV1E93
   /+oBMMG0LxuIYIIGmsWHxLqraHCtlD8cERHpnx3msYMX+cCImZigNfc5B
   uEtHAngiSUg2gFXQ6gesbhprZ+V3RrV16bh6dgdr8N1lITWnO0WJCy2y3
   AKDxGZj0UatUV5nrybvjy9OWnlLQ0N5wuxEqPSiWpAbIgq+Si0hkq9liI
   3u6lNUXe/RYUT8WuVIcuF3fNTDEgJyBiesnotTYaG9czvsoRgVmvSX+5F
   HSRTp1sZJzjuPBHPcxCyESGNnIQ3cn16smngBLK2qXiiep0diFrla8Wi2
   g==;
X-CSE-ConnectionGUID: 792izZ3RQEeOWcmH6jjaVg==
X-CSE-MsgGUID: q6QIEy29QOmah5F4iYDQpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38592027"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="38592027"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 00:01:05 -0700
X-CSE-ConnectionGUID: C5Zp0ThHQDG41+LNjk8vKQ==
X-CSE-MsgGUID: DlKyb9KRQ3iM1eqRd2Ocrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81624165"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 00:01:03 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: <linux-mm@kvack.org>,  Alexander Potapenko <glider@google.com>,  Kees
 Cook <keescook@chromium.org>,  David Hildenbrand <david@redhat.com>,
  Andrew Morton <akpm@linux-foundation.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Miaohe Lin <linmiaohe@huawei.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  John Hubbard <jhubbard@nvidia.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
In-Reply-To: <20241007182315.401167-1-ziy@nvidia.com> (Zi Yan's message of
	"Mon, 7 Oct 2024 14:23:15 -0400")
References: <20241007182315.401167-1-ziy@nvidia.com>
Date: Fri, 11 Oct 2024 14:57:30 +0800
Message-ID: <874j5j9let.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

[snip]

> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 930a591b9b61..4b15224842e1 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -220,18 +220,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>   * Return: A folio containing one allocated and zeroed page or NULL if
>   * we are out of memory.
>   */
> -static inline
> -struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
> -				   unsigned long vaddr)
> -{
> -	struct folio *folio;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
> -	if (folio)
> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> -}
> +#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> +	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)

Although just one line, I still prefer to use inline function instead of
macro here.  Not strong opinion.

>  #endif

[snip]

--
Best Regards,
Huang, Ying

