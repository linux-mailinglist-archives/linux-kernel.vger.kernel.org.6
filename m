Return-Path: <linux-kernel+bounces-261413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C20393B708
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B10328553C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303D1607BD;
	Wed, 24 Jul 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRr/9rQP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA716B3B8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847062; cv=none; b=jqR0iGO0QuOic3lV3ZXEnE3t12MXW/pb0bVFRL4zOzMKM8iWFNB8Nyul5KWsuadYo/83KI/KhQQKXgjbUs6QllRZCZVX6HsLbv92loZnWCsGkK84LPicJX2RvPRzmRUztRC5UVo4V2TJwb3iH2kv6vbIjppQ824GEHBHy49d84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847062; c=relaxed/simple;
	bh=l8wduYcpsiQ6bbIHExqPJcHCdUmL4T4BA9s89Zq1aBU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR9m/qj2pNEBuvUtTfVx4lXvPXtLpxZMMmula3KNaPFZyUVp7DgPaHaEjsjV89QklMBo+0n6Cd3Lu50+TU6+FJ1wC7NmNssQHnVlI7+spMYYuEWg7aWXe7lYuEFMUFCc9fDd41yr+irGpNxtyQ25R1jgKX0Rb2CudDLX5MsYtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRr/9rQP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721847061; x=1753383061;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=l8wduYcpsiQ6bbIHExqPJcHCdUmL4T4BA9s89Zq1aBU=;
  b=dRr/9rQPSc/PP0jmqdHFw0MWvNqhxy5SK4chgrDckUvUHtByblIR02Hq
   BOGMGVLprXavxLIwHZal78umZFexrNfx4YNQS6CJcmAZgKmH4FapHxfrY
   Vg49nsuwKtcPw/8ipJV9GM/j459HSuqbiaDZJXle4jy8xH5OZmoTFKDpc
   TKT6tWdHIz9ZgAOkQL36HUY2PqVImZeuk3iNo2sqigK4zdpvRQ4g0K2FY
   ZXIDj6A79Dx1dQoXosSrmYACDr3yNuHebPdvdmFZCxcBK1arwJG0vbyVN
   /sfE5IwLbkY739+vSmNyT87dNRuuPuLFQGoXgfK3htKMyxJJ3fpEDqVbi
   g==;
X-CSE-ConnectionGUID: rOw87nJsTvSUVKYt0eFlaQ==
X-CSE-MsgGUID: kqnQU63xSUScEANvbRdMVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23357737"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="23357737"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 11:51:00 -0700
X-CSE-ConnectionGUID: Bi1gjlNhQWCT2sK+nFJVdA==
X-CSE-MsgGUID: 2zmVMigzT2ejI97PNNfeow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="53448633"
Received: from trevorsx-mobl1.amr.corp.intel.com (HELO adixit-arch.intel.com) ([10.125.177.104])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 11:51:00 -0700
Date: Wed, 24 Jul 2024 11:44:06 -0700
Message-ID: <878qxqhbpl.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe/oa: Use vma_pages() helper function in xe_oa_mmap()
In-Reply-To: <20240724181826.3163-2-thorsten.blum@toblux.com>
References: <20240724181826.3163-2-thorsten.blum@toblux.com>
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

On Wed, 24 Jul 2024 11:18:27 -0700, Thorsten Blum wrote:
>
> Use the vma_pages() helper function and remove the following
> Coccinelle/coccicheck warning reported by vma_pages.cocci:
>
>   WARNING: Consider using vma_pages helper on vma

Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
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
> 2.45.2
>

