Return-Path: <linux-kernel+bounces-295516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31144959C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16FA1F21934
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA518C929;
	Wed, 21 Aug 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOdaOjDE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962D15747C;
	Wed, 21 Aug 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243985; cv=none; b=g9mO2fL6EA2/Hu/+K7YJ3rb+4lLUOeJ+11d1h+aTUc47DsaVaNqDJqffkAhL2/BEbeDXVmlwpmOSlhkRwWu4h0JkrUpD53TGdSjzhTLN7C6dp0D/A/N7GRSYmnUP+Wtu18guPcRZP0JBgyq0PAw2eKmtZW/pVlhBZ5n7L9HG7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243985; c=relaxed/simple;
	bh=NjfrmnG+rsVA4QMgy4cLl38Ma8Jl15Dtx92mUADqxC8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ttKd/RqySdPKU7nJEHLgWpo5I+bc8h4i/B7gflzjxHn+IM/o8+Qfu364bzJ7hNbsBa05P4zBNcHwIMHLLPuID6b9tXaKTQWioNKor8kBaOzYgaIIjqsLTpKZvS59AfeFBfRBVTYzmtVbyqH9YWeMhRHOT2nG+GWnGV6o0G5m9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOdaOjDE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724243984; x=1755779984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NjfrmnG+rsVA4QMgy4cLl38Ma8Jl15Dtx92mUADqxC8=;
  b=JOdaOjDEU9YSs9EElzw3/hkxasC/TT1tLsj9bw1D/jci9OLbeqTVgqi5
   E87aMIwtuRB/ye8lSlsDStJeCo1aZYnlkFr+kwKCVqwOT0wvK1BSXgJsW
   nAk2xzP+yZVw3LyZik3RwsGdwtisM23KY5mIKHpgowI0HXhOBZ47rHYdi
   h0Y/R3gBkkfbiKI0thSQu5pvbFQBvD7dABsTQL+R+l9SFTnG7MXLWvaEJ
   6iADaUTLfy5emZe/pIFhjmA90RsEp1IPGIn1pjaj/dVhd0COpWyBrQT0X
   OizWafuvYcv7EstNKxY4yxye/zLPEg4fBq2Qyan652hS9Cy6s1meWlZx6
   w==;
X-CSE-ConnectionGUID: hhz0ALdoSG2Sz8UUpQhOiQ==
X-CSE-MsgGUID: fRuEHWA+QqOvFvmKz+kWRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26352204"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26352204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:39:44 -0700
X-CSE-ConnectionGUID: NRKDdXgWRzmBje+o/jTszA==
X-CSE-MsgGUID: ARFBEiimQoGig3B2Wn+fNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61220606"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:39:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 15:39:37 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 2/4] platform/x86: int3472: Simplify dev_err_probe()
 usage
In-Reply-To: <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com>
Message-ID: <7976bcc0-c15a-1608-536d-cf18423387be@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com> <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1157783103-1724243977=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1157783103-1724243977=:5260
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Andy Shevchenko wrote:

> Since dev_err_probe() ignores success, i.e. 0. we may call
> it unconditionally.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/plat=
form/x86/intel/int3472/discrete.c
> index 07b302e09340..cd0743300d7f 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -289,10 +289,7 @@ static int skl_int3472_handle_gpio_resources(struct =
acpi_resource *ares,
>  =09int3472->ngpios++;
>  =09ACPI_FREE(obj);
> =20
> -=09if (ret < 0)
> -=09=09return dev_err_probe(int3472->dev, ret, err_msg);
> -
> -=09return ret;
> +=09return dev_err_probe(int3472->dev, ret, err_msg);
>  }
> =20
>  static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472=
)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1157783103-1724243977=:5260--

