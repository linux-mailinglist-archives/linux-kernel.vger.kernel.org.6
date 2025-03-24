Return-Path: <linux-kernel+bounces-573763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116BCA6DBD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DF3A63D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358125DCE8;
	Mon, 24 Mar 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMh0D3r8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127625E460
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823720; cv=none; b=Umw0P8jEfahYgk4xGNxqg3Vf1ZaOlPoszjaiK7+PsHRWvZh6QEwxhm3j7O3IPMsipaEHkr9hdMP22nahUdmyTyi1eXsf082lU4wJdN/tvfmB6uWVUHFmCk4q6BBIErZOzMvAMrYGXQmKMzUr8Dsv3jP31lIzeK8j5DICnnVbP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823720; c=relaxed/simple;
	bh=NsI6Dxa1q5L/jpZAovfLjCzZY19BKLCx/YwxouL5alM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyrjfVY5VcpfZw79Ks4EjzA3LdrnwggcOhCObI2QLVfYI8MzMDTNuMr7FdXNidpJylkxI/4tsps3gQ2ACqP0OA694vltHkGSsUEeaOnfb0UUYA0kyinWCDSJiLXkNqSBBroofmW/qdFkU1rcrZMNn0vSiTXOV7KQgzAI6U4lxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMh0D3r8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742823718; x=1774359718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NsI6Dxa1q5L/jpZAovfLjCzZY19BKLCx/YwxouL5alM=;
  b=hMh0D3r8II5Ejy10488GClWP73po5RK9bY2wGaZq08B84rve1wnlc6d1
   VyOSqfoERCyliPa9pQJh89Mp2UMtzLlegrxnbUg7l5esUA3arfRv7KG5m
   Mjh+xq5bLYRABFP5CLyNAkChmU+laODuPzSo9dpdQyvq14UDQp//wiVbJ
   67S+potqUZ7BAxLS8n7b7L3gmCX5gkyV0Rd5bjqf7//ZqmdJp28E/vnh0
   V5JeJo+WtlFzf/G1zTL/Bcd2U6anYFVzUBYNHlwq9sf8/xyTTT8EgZchO
   70GWX2Nk7BVVB9y/050SsFOK2TeU5ThVFUomNI2M3rMIbYLTo/BFTE7ej
   g==;
X-CSE-ConnectionGUID: ZG/n5A0PRwq4/H5jB6l+Nw==
X-CSE-MsgGUID: hmpmDONYRRCgeOoAzjTo4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61549749"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61549749"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:41:56 -0700
X-CSE-ConnectionGUID: BlrzRQovSKW6jnXBdZUqmg==
X-CSE-MsgGUID: 6wpqHdQwSGu/dRvMG7AmWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="125000100"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:41:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twi3p-00000005SSH-2oSy;
	Mon, 24 Mar 2025 15:41:49 +0200
Date: Mon, 24 Mar 2025 15:41:49 +0200
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
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v7 2/5] bits: introduce fixed-type BIT_U*()
Message-ID: <Z-FhHRWtaYgTbILa@smile.fi.intel.com>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <20250322-fixed-type-genmasks-v7-2-da380ff1c5b9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250322-fixed-type-genmasks-v7-2-da380ff1c5b9@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 22, 2025 at 06:23:13PM +0900, Vincent Mailhol via B4 Relay wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
> 
> Implement fixed-type BIT_U*() to help drivers add stricter checks,
> like it was done for GENMASK_U*().

...

> +/*
> + * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
> + * following examples generate compiler warnings due to shift-count-overflow:

"...due to -Wshift-count-overflow:" ?

Same idea — if you need a new version, since it's just a nit-pick.

> + *
> + * - BIT_U8(8)
> + * - BIT_U32(-1)
> + * - BIT_U32(40)
> + */

-- 
With Best Regards,
Andy Shevchenko



