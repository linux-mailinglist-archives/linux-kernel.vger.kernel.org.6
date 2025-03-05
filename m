Return-Path: <linux-kernel+bounces-547039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B56EA5020F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C611888173
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6F24BC07;
	Wed,  5 Mar 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btCVSJQl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3281624D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185201; cv=none; b=PHMFlU6ZmBAKavSwFqkGV/zWhhM8ulBFx5b8DT3oCEd18ZzMWWDkHrnKJHX0wR+5sRa3Vrj4ybZWzr1/Mf0KKq94t+g/gsczm/OUwUk0O+6f3zltwMn+8uOnCQ56l4q5wC58KumfcAdR6W0hsB3Ld/9cUiRt40h8yAt45hV2ANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185201; c=relaxed/simple;
	bh=aDUAPighDp4zM0XbtF56C1kMT3vaVg5/97zk6xCyweQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYil3r6Xkma90pnpoXXmPI17Y9CNEVgtnkgeE0MOJ13L7FaDnYRWTQP6w219wzLSpNXA41+w2G4Lp0IvzKpbUPKQK799v3RUChLz+pkBfo+ekC5y+CuZohD+84QhTITYtZ6+F66etAtxajGdpGaqc+WASspzmVb8uOL+Aq+RWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btCVSJQl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741185200; x=1772721200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDUAPighDp4zM0XbtF56C1kMT3vaVg5/97zk6xCyweQ=;
  b=btCVSJQl74YQTn+fe22XhdO32eXj1FVGrjm0FrVjNU5wOj0NR0KsvFQk
   a9+Mu9YH5Y6n2jfYjjo6U3ox6Xn7yAvunPMXpd2tOa45ipMjB911K209c
   vRe09/H35ytjpzxW0wZ60UluSB/974pjUjAIB3ABqeTGkkk8wfmdgVO3l
   gXYTi31eHP6tMcBZSGlVyJ6O3zq56++9Go1svsDDQGEEXtZcv0nlnnhjl
   g/WEqWhYoEuwxdbihPAXsYn+gOBbT6LKprAa8FbJfVWMKWOcxuw3IKr/a
   AAe2XxXQGUwhXiaplzTOSNO0X6auqDZD6NbFBs4Dl4Ug7e+FeTsMVR9xz
   A==;
X-CSE-ConnectionGUID: JMmQaV1lRTuYoUw7cx6jYA==
X-CSE-MsgGUID: GBhoDVrCSwe+UnJ1x5eoEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46076708"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="46076708"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:33:19 -0800
X-CSE-ConnectionGUID: T4jUIqHuT3e+xjbhrzhN6g==
X-CSE-MsgGUID: olBUWtLgS6apQPLQQ/7Bsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="141949942"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:33:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tppo8-0000000HR9s-1j0V;
	Wed, 05 Mar 2025 16:33:12 +0200
Date: Wed, 5 Mar 2025 16:33:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mailhol.vincent@wanadoo.fr
Cc: Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 4/8] bits: introduce fixed-type BIT
Message-ID: <Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Implement fixed-type BIT to help drivers add stricter checks, like was

Here and in the Subject I would use BIT_Uxx().

> done for GENMASK().

...

> +/*
> + * Fixed-type variants of BIT(), with additional checks like GENMASK_t(). The

GENMASK_t() is not a well named macro.

> + * following examples generate compiler warnings due to shift-count-overflow:
> + *
> + * - BIT_U8(8)
> + * - BIT_U32(-1)
> + * - BIT_U32(40)
> + */
> +#define BIT_INPUT_CHECK(type, b) \
> +	BUILD_BUG_ON_ZERO(const_true((b) >= BITS_PER_TYPE(type)))
> +
> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b))

Why not u8 and u16? This inconsistency needs to be well justified.

> +#define BIT_U32(b) (BIT_INPUT_CHECK(u32, b) + (u32)BIT(b))
> +#define BIT_U64(b) (BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))

Can you also use a TAB between the parentheses for better readability?
E.g.,

#define BIT_U64(b)r	(BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))

-- 
With Best Regards,
Andy Shevchenko



