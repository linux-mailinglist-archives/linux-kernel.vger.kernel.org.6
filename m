Return-Path: <linux-kernel+bounces-293484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88440958063
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6532837BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A618A920;
	Tue, 20 Aug 2024 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEKAvVa8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF839189F54
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140478; cv=none; b=kH6a2upaM/XqHv6A3OAP49RQ50FdailtHXgPyiqQu3y/cnpojLCWYRtwfiRcVD506PwU3S9hI9GobKAAI4skkQvmIpjQfxiQO8I1s29VOJCijjz5NzBdH6P0g7n342mdTX2howZh/rSyxhzvs677vW3yfHyhV/X1MmUg41uluzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140478; c=relaxed/simple;
	bh=hck3bHzWx7WDKLDaFym5HQG2fFAzrpjrjVnA+2HCE6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I7Ytz46ceL8UIV69too3/r2W3DZ27PctlNra3NlDh725jVxh1oR2oFz7gpp1l4BuIqz/1sOdMn/D9MVQq29PYRM+7akUb8cpMxpo0d0z5pB7hhfYTZtRrqe4r/oimtdsgzvabg5wcbLximWm6lmjYNdowFqMcOVCvJNgd0cPRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEKAvVa8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724140476; x=1755676476;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hck3bHzWx7WDKLDaFym5HQG2fFAzrpjrjVnA+2HCE6M=;
  b=jEKAvVa8JimHUhyPHouPLsyTs33QaPoLUWYOp/PrlQz/KS78K4uPafBE
   ebn4I5tf0+QVN1a8KEWZOe/HijfcPu03Idn/Ifz51rQ6Ob2VL9/FIXhc5
   hW2mupCrBW80nlUx7Ww7Nvw4oGQ5aPoD8cMZpdkA2G/GhLTc79LvGG5aF
   55bT24KCVVi/kSdtz2PNmpOPAt9uBA5Pps6Zk+JsIMgEaPPzYBVnP3Vgx
   ZB5sTNmus1WGsNjUo3/NPafOVPl+evFlgnX3dNukPTOp3kwFmHfdzl3X/
   tcNpsQgR+Qf7DFdkk02rk/0mG/DDGyEu/ha7lpwgatMSJsrS1HwEqZ56L
   g==;
X-CSE-ConnectionGUID: I79Lt51wTheHQOhiLGSjfQ==
X-CSE-MsgGUID: A5m8nfACTMG9dkLWIC+Jqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22560103"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22560103"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:54:36 -0700
X-CSE-ConnectionGUID: nmdr6myvTq+QbC84Wmiwxw==
X-CSE-MsgGUID: 7+H/mZ6KSsGJNaxQKbftSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65592139"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.184])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:54:30 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, Michal Mrozek
 <michal.mrozek@intel.com>, Gustavo Sousa <gustavo.sousa@intel.com>, Lucas
 De Marchi <lucas.demarchi@intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Shekhar Chauhan <shekhar.chauhan@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com, Yu Jiaoliang <yujiaoliang@vivo.com>
Subject: Re: [PATCH v1] drivers:gt:Switch to use kmemdup_array()
In-Reply-To: <20240820074505.2728118-1-yujiaoliang@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240820074505.2728118-1-yujiaoliang@vivo.com>
Date: Tue, 20 Aug 2024 10:54:27 +0300
Message-ID: <87ikvv634c.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 20 Aug 2024, Yu Jiaoliang <yujiaoliang@vivo.com> wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

For future reference, please look at git log for the file instead of
inventing subject prefixes.

There should be a blank line between commit message and trailers.

Other than that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  drivers/gpu/drm/i915/gt/intel_workarounds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> index 09a287c1aedd..d90348c56765 100644
> --- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
> +++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> @@ -111,8 +111,8 @@ static void wa_init_finish(struct i915_wa_list *wal)
>  {
>  	/* Trim unused entries. */
>  	if (!IS_ALIGNED(wal->count, WA_LIST_CHUNK)) {
> -		struct i915_wa *list = kmemdup(wal->list,
> -					       wal->count * sizeof(*list),
> +		struct i915_wa *list = kmemdup_array(wal->list,
> +					       wal->count, sizeof(*list),
>  					       GFP_KERNEL);
>  
>  		if (list) {

-- 
Jani Nikula, Intel

