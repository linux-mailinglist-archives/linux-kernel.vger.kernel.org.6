Return-Path: <linux-kernel+bounces-190391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400908CFDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2B1280A95
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54713AA44;
	Mon, 27 May 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+qgYEys"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C32DDAA;
	Mon, 27 May 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804214; cv=none; b=KsWltvWaqeDBZJUmTzDMWbgcSPqPjs19xDhM4yowOlZJ5FWcYSRVjUkXj00vmBEZOZNFuEdkDfzVe+Nv82vozzu9chrZ/Kn5ccfMamE9n0D2KWCNiv5YVs+JsypvZdSKUcik7F0+9JAop/eDDAC5o/OrMW2Y/YJuD1v6caNcM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804214; c=relaxed/simple;
	bh=/NkZKccaFTYck5P2WLpFcN+o1INoVuLcZYD6FaPdIn8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AMFPkZXwWnJH41px/rtwu2VbabeJfLa81ZuVdZUB23EggIsAJueySuTt65JOA09vGZhNBgs0CMpEgsOH3zPGM8X6yI+1ekfgNhibUb3u6hPQJASlOtOIxd+sewBrEqPMhXzwX52fLFR9NN1rQe+v6U3D4+mOCDN03q3xywFoaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+qgYEys; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716804213; x=1748340213;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/NkZKccaFTYck5P2WLpFcN+o1INoVuLcZYD6FaPdIn8=;
  b=G+qgYEys8q6pJrM/zjFJH7fN9HIsBPHQqNXfdj3An6vkAKswj53FjEJ6
   KIyVqKI8jHUhEWcVd950P+LLsDB3XgCcQSovLST6mvQ28Qr4MWWnVJn0v
   EjYJrRu3zFmRvWKdtAWH/KhAi3W9ojcl2cTN9rYGYN4ZwbqMUQr5n9mPl
   qnbROtzsrLr52iHGgGKxX4ix2pi5P0uHKDqOefz8Ga/K09Y/ys8DHucix
   gIedYn3QLhK1tpS0vDi0jrtrUmG/JatJVhaZGns6p39zpJeUZs9psWS1j
   wH5xL+lJWugwQnyGxK8YmgxClZTeKpxaUttStMghT5rS6BjQ1un+qbZj/
   w==;
X-CSE-ConnectionGUID: ASF1zPqIRwq1ywT72dnLEQ==
X-CSE-MsgGUID: 6cBcKasARMasFNXkvavpkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12980193"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="12980193"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:03:33 -0700
X-CSE-ConnectionGUID: z3aO6P5/QGevYqfWN6U9mg==
X-CSE-MsgGUID: wDHjezFaRTy0GPWV/6zZAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39557475"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 03:03:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 13:03:20 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: ISST: Use only TPMI interface when
 present
In-Reply-To: <20240509230236.1494326-3-srinivas.pandruvada@linux.intel.com>
Message-ID: <d3e92568-3440-cb45-e6b0-90133aa8a9b1@linux.intel.com>
References: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com> <20240509230236.1494326-3-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-357872044-1716804200=:1006"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-357872044-1716804200=:1006
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 May 2024, Srinivas Pandruvada wrote:

> When the TPMI interface is present, use this interface instead of legacy.
> On some systems legacy IO device is also present. Using both interfaces
> together is confusing and may set the hardware in inconsistent state.
>=20
> When TPMI interface is present, don't load legacy drivers.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c =
b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index f886f9369fad..6283af37e73b 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -775,6 +775,9 @@ int isst_if_cdev_register(int device_type, struct iss=
t_if_cmd_cb *cb)
>  =09if (device_type >=3D ISST_IF_DEV_MAX)
>  =09=09return -EINVAL;
> =20
> +=09if (device_type < ISST_IF_DEV_TPMI && isst_hpm_support)
> +=09=09return -ENODEV;

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-357872044-1716804200=:1006--

