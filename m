Return-Path: <linux-kernel+bounces-356478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF79961A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781651C247AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7D2F46;
	Wed,  9 Oct 2024 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPsRv5Eq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF413A409;
	Wed,  9 Oct 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460848; cv=none; b=oBz/HO25k07bnN1Uc0VHQ+INka4Sau/Y/2hSKUpkMkfPoXh2OGG+AHvn9MRfWg9xsKujDnZIrxI78+8pmZ63Y3WueEHsMnmkM82MzJI3y9d75P+Cl1Ohlvtf5c9mFWfnQ3I1U6LFyh0hnf7dEg9YlYYYco3p+/C+b5eaVD0sy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460848; c=relaxed/simple;
	bh=X5Dfbqv7Nkw22/0CScbgBIGsF0hB+LEpROaW0FgeghM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZeTr9X1uDl68aKjPBntuhuU1M38k0wmkR7Ovf4I7fJLrEhKgKxlTIx1AFdxWdRDIbuuyaA9V6EYevyEIFV9HDJ+9F2dO1eCv2wJw++6PF4z1aYRDhlWHfW91KnqUZHDqpr+TVf7KQkSrGSg47rTltoSVQYxolO28ZyqEUZRyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPsRv5Eq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728460848; x=1759996848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X5Dfbqv7Nkw22/0CScbgBIGsF0hB+LEpROaW0FgeghM=;
  b=BPsRv5Eqf8dQGGT3gi/zHeWfwfeB6FWlOSg7KK86zoh7tkrcEY+nQMiB
   oL9WP7DmfiGpTy3/hvDOE1kHSAylTn/5RrlDvK92GwrXUhpnZiv8L85DI
   FZdTjo+rUGGn7XncYSBDM90oHXlqFIAIGei+aj2R8NYwajxJvB15aIEv/
   p/q95O7bb6d1aSRfDz9hQg4uvVMg2SxIHimrCboYK/p460urMWhQ6nKq3
   ygg0f8rR71PwT7z0k+aaI/5xOOB1Of/Xfpm86Q5b9GVgMzMHhAPGJru7D
   DQN/Bndeb4r2OgGBLanCDfRcpiCWp2gPw3vUbUsaTW4jHKxD3aZzmHmiz
   g==;
X-CSE-ConnectionGUID: P4QTZUUGT5WkkdGFA1V/kA==
X-CSE-MsgGUID: qGz7ZnZXR/eaBlMCrAJiAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27694024"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27694024"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:00:47 -0700
X-CSE-ConnectionGUID: K98xMOjVSFOEkwHLmsYsCA==
X-CSE-MsgGUID: OR7jKexLTJuREao8BW2T6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76989952"
Received: from yarbov-mobl2.ger.corp.intel.com (HELO [10.245.131.59]) ([10.245.131.59])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:00:41 -0700
Message-ID: <a156ef31-2614-41c9-9df6-acd6d2fcf6cb@linux.intel.com>
Date: Wed, 9 Oct 2024 10:00:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/guc: Fix deference after check
To: "Everest K.C." <everestkc@everestkc.com.np>, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: skhan@linuxfoundation.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241008205352.4480-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20241008205352.4480-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/8/2024 10:53 PM, Everest K.C. wrote:
> The `if (!snapshot->copy)` evaluates to True only when `snapshot->copy`
> is Null. Thus, derefrencing `snapshot->copy` inside this if block is
> equivalent to Null pointer derefrencing.
> The `if` condition is now changed to evaluate to true only when
> `snapshot->copy` is not Null.
> This issue was reported by Coverity Scan.
>
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

Fixes: d8ce1a977226 ("drm/xe/guc: Use a two stage dump for GuC logs and add more info")

Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_guc_log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> index 7fbc56cceaba..4e1a5e8ba1e3 100644
> --- a/drivers/gpu/drm/xe/xe_guc_log.c
> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> @@ -122,7 +122,7 @@ void xe_guc_log_snapshot_free(struct xe_guc_log_snapshot *snapshot)
>  	if (!snapshot)
>  		return;
>  
> -	if (!snapshot->copy) {
> +	if (snapshot->copy) {
>  		for (i = 0; i < snapshot->num_chunks; i++)
>  			kfree(snapshot->copy[i]);
>  		kfree(snapshot->copy);

