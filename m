Return-Path: <linux-kernel+bounces-317136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858D96D9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380B5281EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA019C56E;
	Thu,  5 Sep 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPytj8+Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203A198E84
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541574; cv=none; b=Uui68M94J83V5W3ck8DOdlMubtHsLmiHSXbcg/K/oGqeU/6cvByAIH6Y1C9Hv9gG1oeUYTFb2ATKvn3duqr+jOGXhz+saUJ0htdY0QnjVfSFLNGEAKu1XcOoTitaIbuhR69zLD6yxDGxvLxqdoJdMjlf4I99wWK4NXHTIco59/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541574; c=relaxed/simple;
	bh=g1SQN7j55UMlCekE8jx808qYJxlM2mhzf/HdquuSpmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LeW/Az/Bg4HaRUAMvbz1qlu+2RTZEehIluZpFFWVC3kp9PRNLOvkulQrUglqiI5m2VRrFQEdncB49L/0EMJJcuCoNTiFl8aEcHNJiC6ONrd1C1rYLdeOPns6mmZ1Kor3Y8R4cL2T7GlzqJpoWmboNuD5qpTOYyfYxSxnT6kUIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPytj8+Z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725541573; x=1757077573;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=g1SQN7j55UMlCekE8jx808qYJxlM2mhzf/HdquuSpmo=;
  b=DPytj8+ZrQj+66sfTsEowfNnDrBEWzdiuDML8jRrY0aiUnSdWpmvECfa
   BQgbPySGNC6lNtmq4GufQuLHLsnbDUv/rvMNN/X+0/c6sYppyt/1Gtvi9
   5+QtufgFdGFiM8f+rMaTtjUzdAkPUrBlIy+trA610rSrnmikAg8ros897
   FhHyI+JJCvS3asXt9OIG4AFcXsk76vEHCB9PjGYakxWZaaU413+lTPaUF
   WDSn8/DSNUhO+o5MfvBlVlmiLVP4iKlN9McEh6rrWyfssdjD7OBOHpJkM
   BhDJ7p4SSsbbgXpBx5SQZP98nMDDcLe05XOt+xpItt5hazG/vO2psPMmi
   g==;
X-CSE-ConnectionGUID: hhIJnHdzT5ioyINstPFiIQ==
X-CSE-MsgGUID: u7W4Xw2QR8inv58B6e5WUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27177037"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="27177037"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:06:12 -0700
X-CSE-ConnectionGUID: D6YR5lCgSHyhMajcqYWpcQ==
X-CSE-MsgGUID: ARXOi5PXRXiTHFtQOtIKOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70210401"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:06:09 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/18] drm/i915/selftests: Include <linux/prandom.h>
 instead of <linux/random.h>
In-Reply-To: <20240905122020.872466-3-ubizjak@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240905122020.872466-1-ubizjak@gmail.com>
 <20240905122020.872466-3-ubizjak@gmail.com>
Date: Thu, 05 Sep 2024 16:06:06 +0300
Message-ID: <871q1yqmgx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024, Uros Bizjak <ubizjak@gmail.com> wrote:
> Usage of pseudo-random functions requires inclusion of
> <linux/prandom.h> header instead of <linux/random.h>.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org

LGTM,

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree suits you best.

> ---
>  drivers/gpu/drm/i915/selftests/i915_gem.c    | 2 +-
>  drivers/gpu/drm/i915/selftests/i915_random.h | 2 +-
>  drivers/gpu/drm/i915/selftests/scatterlist.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/=
i915/selftests/i915_gem.c
> index 61da4ed9d521..0727492576be 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
> @@ -4,7 +4,7 @@
>   * Copyright =C2=A9 2018 Intel Corporation
>   */
>=20=20
> -#include <linux/random.h>
> +#include <linux/prandom.h>
>=20=20
>  #include "gem/i915_gem_internal.h"
>  #include "gem/i915_gem_pm.h"
> diff --git a/drivers/gpu/drm/i915/selftests/i915_random.h b/drivers/gpu/d=
rm/i915/selftests/i915_random.h
> index 05364eca20f7..70330a2e80f2 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_random.h
> +++ b/drivers/gpu/drm/i915/selftests/i915_random.h
> @@ -26,7 +26,7 @@
>  #define __I915_SELFTESTS_RANDOM_H__
>=20=20
>  #include <linux/math64.h>
> -#include <linux/random.h>
> +#include <linux/prandom.h>
>=20=20
>  #include "../i915_selftest.h"
>=20=20
> diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/d=
rm/i915/selftests/scatterlist.c
> index 805c4bfb85fe..7e59591bbed6 100644
> --- a/drivers/gpu/drm/i915/selftests/scatterlist.c
> +++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
> @@ -22,7 +22,7 @@
>   */
>=20=20
>  #include <linux/prime_numbers.h>
> -#include <linux/random.h>
> +#include <linux/prandom.h>
>=20=20
>  #include "i915_selftest.h"
>  #include "i915_utils.h"

--=20
Jani Nikula, Intel

