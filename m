Return-Path: <linux-kernel+bounces-548402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED8A5445A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283D018929B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A51FCCF3;
	Thu,  6 Mar 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWVAESq7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4961F76B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248781; cv=none; b=TCFrNHtm3kNK4jdZu/BURH6hxm14Zgw8KIO3SRqN26oP/nv8b40IIbkYlV3Y8J5m3KoyIDPlG7eTX2E5p0/mWcfkXdBfUJAcStb+8hCi99i2mOsBW8SqMMCWFw/7J+3dO99MZbwS1hnz2aNaRUnNq5WHNTvZvfj3k9OPjtDgWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248781; c=relaxed/simple;
	bh=cFU8Ql1QJlSlC8kpfnJhkc2MMeegxCk0ZbejIwx6MAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LAUtrvZZx3+n6qkU+7k9VuWefDGac8ZNCW2IdyPZ5ngFJq1zPDuPv64Oyy7bZpnvt3gflGO1salzBAnwneoMafcZJjKPXG/JNXKdAKGAeAj1G1BZy6eDBA7e+x3llaNL75PSq5ryn5D2E8a+CVmiL9gmCvnIKzJq2HHc1edXmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWVAESq7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741248778; x=1772784778;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cFU8Ql1QJlSlC8kpfnJhkc2MMeegxCk0ZbejIwx6MAM=;
  b=dWVAESq7pmf4LLm+7so/Q7xt65tmIDqhnHwBXOyfz+Ld0Pc8Ob/p7iAU
   GUXus6HnPQ4u/s5xqcLsezXktbswFbmK/stuccjuqUVG8yGhmpv4dfuns
   RAIF1yMrp6WsZ5s6X+Ll2FdCkCH+Up/LaxK2FiQDZbFsXf2Q0Kfhti8M6
   qAJouHEnTSTy6oENYUwOnpO7KDeXV5r/dcnl8dKb3Ov28S4PXy/pHr2l2
   F0rly1sMh1mUlE1FJbE57+UhOcrxspWQwQm15q4kJp2zuUoo5z0PN0UU2
   YtEcgwnByKtWd97c6LvrS4K2mJKfBiuLX47VECTjrnZcuRTvEtSqm3Kkk
   Q==;
X-CSE-ConnectionGUID: qkPsHbAlSNeNOI838o0pNQ==
X-CSE-MsgGUID: K+PDmZi/ScmAh7FUdVYYDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64693473"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="64693473"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:12:58 -0800
X-CSE-ConnectionGUID: ADzbJ8gKQlirm/Zs4gccwA==
X-CSE-MsgGUID: YKZ/Fy1oTpyRI/egBsy9Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="124052123"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.135])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:12:52 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, David Laight
 <David.Laight@aculab.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 4/8] bits: introduce fixed-type BIT
In-Reply-To: <20250305215027.5d9be1fa@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
 <Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
 <d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
 <Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
 <824dc1d1-14f0-433e-aa3f-679527b87077@wanadoo.fr>
 <Z8isZodEqhZw5p7-@smile.fi.intel.com> <20250305215027.5d9be1fa@pumpkin>
Date: Thu, 06 Mar 2025 10:12:49 +0200
Message-ID: <87v7smwpa6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 05 Mar 2025, David Laight <david.laight.linux@gmail.com> wrote:
> So it is even questionable whether BIT8() and BIT16() should even
> exist at all.

If nothing else, they do provide compile time checks for the bit being
0..7 and 0..15, respectively.

BR,
Jani.


-- 
Jani Nikula, Intel

