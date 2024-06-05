Return-Path: <linux-kernel+bounces-201927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46318FC564
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA3282126
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85C18C356;
	Wed,  5 Jun 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cylr0XoT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFC18C34D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574910; cv=none; b=SNCJwYR2Xnnix3emXb0a4H3MPKQ/RDeZxYjmZzoZXZehBISU225mfKQQYwHXidhiVYHlFppUHMTWswyfvKZt0IsxZeuofeoteneULdQq9abxc0PczTpktsYHi4ICyW2ol5RRapj+FQoHjAqHvZ/ia5r10Qy52yxHug5GAxPwlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574910; c=relaxed/simple;
	bh=2V6xeoSGk1ub4DiXjTFFRTD5i1/BCv57Wy1KYqhsyFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swA6+Qa0vaXYUPZPNTCo/0EmAZJVCltwYkiP4ueSvdk5oT7oKT8OWKcNByEQ0+Z9n4ltILeVSEUkOMp1H10dlMSSxzE3nxdCn91V96PhhbwHqvOmaHXBxiupFqBnM24tXHZbsicxBVGXtMy4QX2UfjZ6hprE81Qhz5i+uAotqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cylr0XoT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717574909; x=1749110909;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2V6xeoSGk1ub4DiXjTFFRTD5i1/BCv57Wy1KYqhsyFU=;
  b=cylr0XoT5P0qPJtYBu0K2eIirfAJnBtLQpq4JEofxBtrKRGn4CkHW2PD
   oc7DPgWfQwzq8wk96m9I9zIKfy4RG9TI3M8s5P7nvWFbFb5od+NM7/EUj
   eXVVyFDEQRN9hRy7dlH4A3KItV2qYGiNLbSpFkPqUhUcaNzUCxBC3vqV/
   zLVxoFmgz54PuMmyja2/X/Gntl9RCe4OGXkXKwc501YHW9bID63Jg0gFs
   sc9IpjU9KNG1VTTRyE8q1bDu1DiIvtiVYgDL1XW074AthOEyY5Df3B4ld
   u+vdtILFThtudkli3RqhL2cUeCtk5/VTdffWct3CgMzoCyFGnKvAfl9wu
   A==;
X-CSE-ConnectionGUID: WloDFkA5QXqd2iIJoKcmjw==
X-CSE-MsgGUID: qyz2Uu7qTVSuxbnQBuMWUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25276044"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="25276044"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:08:28 -0700
X-CSE-ConnectionGUID: JiJLu5YeQACz341zrcmUwQ==
X-CSE-MsgGUID: S5EEev3ASfm6RchQitZp2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="38151310"
Received: from sbutnari-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:08:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Update Xe driver maintainers
In-Reply-To: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240602190959.2981-1-thomas.hellstrom@linux.intel.com>
Date: Wed, 05 Jun 2024 11:08:20 +0300
Message-ID: <875xundd6z.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 02 Jun 2024, Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.co=
m> wrote:
> Add Rodrigo Vivi as an Xe driver maintainer.
>
> v2:
> - Cc also Lucas De Marchi (Rodrigo vivi)
> - Remove a blank line in commit the commit message (Lucas De Marchi)
>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

Already acked on irc, but FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 572be0546e21..8f9982c99257 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11037,6 +11037,7 @@ F:	include/uapi/drm/i915_drm.h
>  INTEL DRM XE DRIVER (Lunar Lake and newer)
>  M:	Lucas De Marchi <lucas.demarchi@intel.com>
>  M:	Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> +M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
>  L:	intel-xe@lists.freedesktop.org
>  S:	Supported
>  W:	https://drm.pages.freedesktop.org/intel-docs/

--=20
Jani Nikula, Intel

