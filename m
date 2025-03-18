Return-Path: <linux-kernel+bounces-567012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8AA67FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784113BBCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F41205E0F;
	Tue, 18 Mar 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH+R23br"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7AC18E25
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337172; cv=none; b=DONzYJeZpGrxd50s60zP7ZJWOSQJHhMN4bG88QSJk8v/aac/Ou9/TpwDVlU1/9WOOmwEMz3LJLQUHpMaj1zmFVI6dbENbz9KffNtfi+xkvmveHh60fIHbRRUcOIvi7tidm3Nz5cmbiUqulAaYHpQGMRlgjt8+YDkt+uenplVydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337172; c=relaxed/simple;
	bh=Zz2IldKLM9Obe+OrFKf035q1HtZbGiurWxoXFchIsvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dd3JfWzUocUl9mCPPOdJLJFlwHCJurm2eg+ACfSOlPnef03EtjymSpMADjWMc/iS3TMGGh/Bpuq/n4zV8Bs0VdRswmaa+IkBxSWPR+1GyxXjRUbU1hl6HMdArqst83uGVctigTdWRRGJGGdhFDoPT7Aj9fF2N/qQV1SV2DIc9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH+R23br; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742337171; x=1773873171;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Zz2IldKLM9Obe+OrFKf035q1HtZbGiurWxoXFchIsvM=;
  b=RH+R23brl/uQFVIawRiiHhrRBc7cG8Iahy8MFAO0PKD7lqjaf5s8uFPU
   u8aQ+/omPb4uqjitawujH7lFhrNhp/Ud8EnYDCmyMF9+H2GncuAbaWnuq
   wXjU3PayGHpBLhCUOJZS9q4oBeV6fquAECsHRUddKO264ll7miNFRGKVJ
   +fhZTlpxRBmgoWdke//hJ4VhddDnZyFi2awQV7rh/4MtPq8a6CQ12uSDx
   IByOvGdU0XlObAgXFIGKYc6yQ/o8ouLqL8aA2KRBrF0I+XGHx6bdYKhSE
   0wlhK2Bug3UCoUKH/D/LnLGleOxSIHeMRkEJQFq/v90ZQaBN7A+VJVAye
   w==;
X-CSE-ConnectionGUID: iU7gnUKtRtOIP8rOinBhgA==
X-CSE-MsgGUID: pSe/rrnqSCyNYyKVbXhFlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53718133"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="53718133"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:32:50 -0700
X-CSE-ConnectionGUID: 3VarUKRaQL2DxkW/3ySj3Q==
X-CSE-MsgGUID: ugltZV4CQ/GrJMXqsIfxXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123324307"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:32:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>, mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, David Laight
 <David.Laight@aculab.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
In-Reply-To: <Z9mqUZX4H-CzqbW4@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
 <Z9mqUZX4H-CzqbW4@thinkpad>
Date: Wed, 19 Mar 2025 00:32:40 +0200
Message-ID: <87ldt2c6lz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 18 Mar 2025, Yury Norov <yury.norov@gmail.com> wrote:
> On Sat, Mar 08, 2025 at 01:48:51AM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>> 
>> Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
>> them to implement the i915/xe specific macros. Converting each driver
>> to use the generic macros are left for later, when/if other
>> driver-specific macros are also generalized.
>> 
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>> Changelog:
>> 
>>   v5 -> v6:
>> 
>>     - No changes.
>> 
>>   v4 -> v5:
>> 
>>     - Add braket to macro names in patch description,
>>       e.g. 'REG_GENMASK*' -> 'REG_GENMASK*()'
>> 
>>   v3 -> v4:
>> 
>>     - Remove the prefixes in macro parameters,
>>       e.g. 'REG_GENMASK(__high, __low)' -> 'REG_GENMASK(high, low)'
>> ---
>>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
>>  1 file changed, 11 insertions(+), 97 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
>> index e251bcc0c89f5710125bc70f07851b2cb978c89c..39e5ed9511174b8757b9201bff735fa362651b34 100644
>> --- a/drivers/gpu/drm/i915/i915_reg_defs.h
>> +++ b/drivers/gpu/drm/i915/i915_reg_defs.h
>> @@ -9,76 +9,19 @@
>>  #include <linux/bitfield.h>
>>  #include <linux/bits.h>
>>  
>> -/**
>> - * REG_BIT() - Prepare a u32 bit value
>> - * @__n: 0-based bit number
>> - *
>> - * Local wrapper for BIT() to force u32, with compile time checks.
>> - *
>> - * @return: Value with bit @__n set.
>> +/*
>> + * Wrappers over the generic BIT_* and GENMASK_* implementations,
>> + * for compatibility reasons with previous implementation
>>   */
>> -#define REG_BIT(__n)							\
>> -	((u32)(BIT(__n) +						\
>> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
>> -				 ((__n) < 0 || (__n) > 31))))
>> +#define REG_GENMASK(high, low)		GENMASK_U32(high, low)
>> +#define REG_GENMASK64(high, low)	GENMASK_U64(high, low)
>> +#define REG_GENMASK16(high, low)	GENMASK_U16(high, low)
>> +#define REG_GENMASK8(high, low)		GENMASK_U8(high, low)
>
> Nit. Maybe just
>
>  #define REG_GENMASK		GENMASK_U32

Please just keep it as it is for clarity.

BR,
Jani.


-- 
Jani Nikula, Intel

