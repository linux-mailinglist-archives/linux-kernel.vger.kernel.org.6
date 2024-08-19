Return-Path: <linux-kernel+bounces-292305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D554E956DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871C21F21C54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B39173332;
	Mon, 19 Aug 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4YSnrJE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C8173326
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078802; cv=none; b=FU+KvQVfENfn1U88nflv2k7DIncup5m3+q/ii8/xK4hi7P0uR3QtRFtOkdc0zpOYu1Q8w4ZQJazRApTjYIylWgLHHjmxgCErXykXymCeNpeSGIRWk7W6+s7bbfXJxgO4rcqBY0mqDlpW775ZZBcrDQgqKXsIZOZq6gSPcspv6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078802; c=relaxed/simple;
	bh=dXCbV8piiQWmpeCw7SmqLNnEnUsqlk0VIhuEgQxA6PM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI+LAf5wCb6pbUutaF/PBOnCdybwx7XDP1OV0oRlg7YZ4SoQ0FzOEf7K0Yfw7Kzck/TaHslYqodRDeYcqch5EYHAZLwB3UoiMu+uh/DT+43nuChfbWwp4BYHnJb5hwpqVStGv1NJbYly9LR7mCNvV8HxwMutbOruhwpaQ2kmpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4YSnrJE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724078801; x=1755614801;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=dXCbV8piiQWmpeCw7SmqLNnEnUsqlk0VIhuEgQxA6PM=;
  b=a4YSnrJEx6FWkQMET7JfryaAP2pJajXivVbRbMLtNCBPBg/qm2O6zjZZ
   s6an1dOOP23D3UAKnESv1pZc+uQwDeSdw8HvZxZcSUV+C/7+2L038i+L8
   MLoPXJp3w9p/tAvXqZpoffcKKNntkVgQRDAu94ABeOET1QuarsSCHCAw3
   wMnVJRbco2nlWDNKABkcWybqmvb2Zi6mAcbZpHKccR3W7AahNtLTbeOlc
   9yaTN4a/sNyb3DrNGUXTlxmcyppelKLuGi/2uPhIYNTaslFQpKFsS+tYo
   VHAOn7ph3KbnGqTqlOw+r/kAzxifxmY03uSdlJbwFEzmZaGBo8YI79HmH
   A==;
X-CSE-ConnectionGUID: v6yroeNiRXmYWDU/kZajQA==
X-CSE-MsgGUID: gLt2iLzeRZuCKrxwotHXPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33486458"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33486458"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:46:40 -0700
X-CSE-ConnectionGUID: YjRvIG5vQqm1nA1Q9yWRug==
X-CSE-MsgGUID: KVivW2jVSsWN+Vtoldbyvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60975171"
Received: from peterval-mobl1.amr.corp.intel.com (HELO adixit-arch.intel.com) ([10.124.114.37])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:46:39 -0700
Date: Mon, 19 Aug 2024 07:28:45 -0700
Message-ID: <87le0s8u3m.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drm/xe/oa: Use vma_pages() helper function in xe_oa_mmap()
In-Reply-To: <20240819095751.539645-2-thorsten.blum@toblux.com>
References: <20240819095751.539645-2-thorsten.blum@toblux.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.4 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 Aug 2024 02:57:52 -0700, Thorsten Blum wrote:
>
> Use the vma_pages() helper function and remove the following
> Coccinelle/coccicheck warning reported by vma_pages.cocci:
>
>   WARNING: Consider using vma_pages helper on vma
>
> Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Sorry Thorsten, looks like we forgot to merge it last time. I have merged
this just now. Thanks for the patch.

> ---
>  drivers/gpu/drm/xe/xe_oa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 6d69f751bf78..133292a9d687 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -1244,8 +1244,7 @@ static int xe_oa_mmap(struct file *file, struct vm_area_struct *vma)
>	vm_flags_mod(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_DONTCOPY,
>		     VM_MAYWRITE | VM_MAYEXEC);
>
> -	xe_assert(stream->oa->xe, bo->ttm.ttm->num_pages ==
> -		  (vma->vm_end - vma->vm_start) >> PAGE_SHIFT);
> +	xe_assert(stream->oa->xe, bo->ttm.ttm->num_pages == vma_pages(vma));
>	for (i = 0; i < bo->ttm.ttm->num_pages; i++) {
>		ret = remap_pfn_range(vma, start, page_to_pfn(bo->ttm.ttm->pages[i]),
>				      PAGE_SIZE, vma->vm_page_prot);
> --
> 2.46.0
>

