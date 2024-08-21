Return-Path: <linux-kernel+bounces-295515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B31959C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0013E1C21707
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29195190671;
	Wed, 21 Aug 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhAB/Smb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6515747C;
	Wed, 21 Aug 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243959; cv=none; b=S7vX7x46lPsIKpSFUONEIwNBtc2HIpCZztDwExVscrZAOyJe6MFhST8WYuc3vHKz4lxtKlGb+/rih4Y2cx6XD13i6uKgcN0wDDDkT6slPltTFk1aWAL64Mxxt21VIum/pOqCA6HeQ/cjOX4EfBk2GFdcb+bCtvoFc6wT/DjNU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243959; c=relaxed/simple;
	bh=+IJ21bhHC5iv2MtYyqkrN+bITIKUSrwGRzrFcddkxD8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AWlnOzD+zk23+pziWPFMNxyhVg+cLSnLGFGKH4zhj8c/6ARNm14vBIvVNwxSyQT8mdJ65BQH6Icbz3tS2cF+nRNibeOCYqmPwaL19NhxZiE7J06jjEjvXKZ3Eq/7EWlnMk18HP/qjtmz1RZoG6ELEIoOL6EaLwKfYxZ9sB018CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhAB/Smb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724243959; x=1755779959;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+IJ21bhHC5iv2MtYyqkrN+bITIKUSrwGRzrFcddkxD8=;
  b=NhAB/SmbE4oAPuACJD/ncVbk/6JbxcPntENyKk3kJhAcI2K+PG3Lw4q9
   fKnAc6C2jldww5JsKx/kJBDihuj6qentqSBxUUHp0Wn41ArE1xT1cfvGR
   i6sxgmsG36eXGdOkMRvB03FSf9okJAyBkY+B3642zP4Py04xkzoJY93ji
   yYn4PLiDr8RgEk1fmyI1eqRA2oBtcM4+vAnlzf7KCyluR+TZKP0/ZQv3C
   VNlI60xX/WI5qtwrU0LC6S0uC4usvljGGf2rrxhBkM2fvba9W2TOzVPAE
   hLPgMrT1FwSJzAyq7ZU2J4xkCOmZZ+eun/WkTI3xicLa7/ycmC9Udk1DZ
   w==;
X-CSE-ConnectionGUID: E40Yl/3iTi60bYbUmCVSlQ==
X-CSE-MsgGUID: zgkZ69EtQYu/dqQIei4U5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33984372"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33984372"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:39:18 -0700
X-CSE-ConnectionGUID: 3v4o5APERQyovMsJACsDqg==
X-CSE-MsgGUID: wtO+vFeGTZeYIUzQhX7bvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61616738"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:39:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 15:39:10 +0300 (EEST)
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 2/4] platform/x86: int3472: Simplify dev_err_probe()
 usage
In-Reply-To: <a096554e-fdfe-4deb-b19b-500c86beec98@wanadoo.fr>
Message-ID: <b9504b3e-5657-5c0f-7ded-69474a9e5647@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com> <20240821122233.3761645-3-andriy.shevchenko@linux.intel.com> <a096554e-fdfe-4deb-b19b-500c86beec98@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-716048583-1724243950=:5260"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-716048583-1724243950=:5260
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Aug 2024, Christophe JAILLET wrote:

> Le 21/08/2024 =C3=A0 14:20, Andy Shevchenko a =C3=A9crit=C2=A0:
> > Since dev_err_probe() ignores success,
>=20
> Hi,
>=20
> Does it really?
> It does not seem to be the case (at least on linux-next). Or I miss somet=
hing
> obvious?

Yes, you're missing the first patch of the series. :-)

--=20
 i.


> > i.e. 0. we may call
> > it unconditionally.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/platform/x86/intel/int3472/discrete.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/int3472/discrete.c
> > b/drivers/platform/x86/intel/int3472/discrete.c
> > index 07b302e09340..cd0743300d7f 100644
> > --- a/drivers/platform/x86/intel/int3472/discrete.c
> > +++ b/drivers/platform/x86/intel/int3472/discrete.c
> > @@ -289,10 +289,7 @@ static int skl_int3472_handle_gpio_resources(struc=
t
> > acpi_resource *ares,
> >   =09int3472->ngpios++;
> >   =09ACPI_FREE(obj);
> >   -=09if (ret < 0)
> > -=09=09return dev_err_probe(int3472->dev, ret, err_msg);
> > -
> > -=09return ret;
> > +=09return dev_err_probe(int3472->dev, ret, err_msg);
> >   }
> >     static int skl_int3472_parse_crs(struct int3472_discrete_device
> > *int3472)
>=20
>=20
--8323328-716048583-1724243950=:5260--

