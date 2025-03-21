Return-Path: <linux-kernel+bounces-571557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A0A6BEC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC348512F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F0227BAD;
	Fri, 21 Mar 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVN5Edjg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D01E8350;
	Fri, 21 Mar 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572313; cv=none; b=bgzXwYHZitsJHEmU18jWwIkC7yPsG2pVeOTZ3Dy1hkUaP/CL2gZm6fDKIUfVhT9m/5sT8y3vfMKlkI19O5wiZTjZSyh6tBGq/LyKwVp7MCmLVYCH9rfFEghUB9/FXSi40AlqDeBGe+r5xJzeC+xVs/oOZ63Jb22maZYqsulkzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572313; c=relaxed/simple;
	bh=0Cm6pafO2L0gqrWabYSVxmX7EwBuZJkktwdG17E7o00=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BibQWg81ZYbjhmAPGTWudwTu/OxU599FwN3wOcT7olHvDkTv6GY1ExuS1+bhNFkCRfFHx209xF6+/dIMvLa2nxZ+OwFSjy9W2mJrot+yZPdeJ0S0IPE/K4oA7QOTmPlR1JfogYT0AxHa8c6Q6WPBBxzKmgClFwAhF7X+g03lGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVN5Edjg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742572313; x=1774108313;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0Cm6pafO2L0gqrWabYSVxmX7EwBuZJkktwdG17E7o00=;
  b=HVN5EdjgvpiWRqkYknhbm5P6/Su6b9iun6liLnE3o/1zaHQ65foC64Aj
   jHILjvgAwIvTB4zsB1kE9RyaB7hSqhXRDitqiaPB43ynticAUoIETKmbs
   G8V2xbdVR/oW3zmIB5StrGz9WZsPcdcFsDgV864dlgnOx0Zxfr1LiIgie
   a31q7fkBjxb70lms9Kh3O116vnUXkI/or/6v7Udlt8330AjzEoql4TENA
   B9DI8RDBv57CI0qlSwA91NwulzsRa7ibV0xiAMI5XIl9dR8mqlnDU2aDW
   iXKqLLs2kbCNHjkshs4OU2eBk9lntHUq62Lw/3zeNsq/etLvQO9yMyuLK
   Q==;
X-CSE-ConnectionGUID: ywLEa+0KRGCqQqaR6ODH+w==
X-CSE-MsgGUID: KyArbh0GQqqkaktWbKIm5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61237020"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="61237020"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:51:52 -0700
X-CSE-ConnectionGUID: AXGlNay9REyTkdbSY0/yhQ==
X-CSE-MsgGUID: IWIRh66rQzqjZ9X+76XWyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="124384210"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:51:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 17:51:45 +0200 (EET)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: tglx@linutronix.de, maz@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 31/57] irqdomain: platform/x86: Switch to
 irq_domain_create_linear()
In-Reply-To: <20250319092951.37667-32-jirislaby@kernel.org>
Message-ID: <d623f8d9-d772-6418-a420-019472742ffa@linux.intel.com>
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-32-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-823517355-1742572305=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-823517355-1742572305=:931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Mar 2025, Jiri Slaby (SUSE) wrote:

> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
>=20
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: "Luke D. Jones" <luke@ljones.dev>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org

I've applied this now to review-ilpo-next, but I had to remove lots of=20
unnecessary details from the commit message as here the first arg is NULL.

I'd also prefer to not have long is of Ccs before --- line for changes=20
like this (more understandable if it's some problem/fix related=20
submission). Wouldn't they work also if Cc: lines are put below ---=20
or is it that the tools fail to preserve that at some point?

> ---
>  drivers/platform/x86/asus-tf103c-dock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/asus-tf103c-dock.c b/drivers/platform/x=
86/asus-tf103c-dock.c
> index ca4670d0dc67..f09a3fc6524a 100644
> --- a/drivers/platform/x86/asus-tf103c-dock.c
> +++ b/drivers/platform/x86/asus-tf103c-dock.c
> @@ -856,7 +856,7 @@ static int tf103c_dock_probe(struct i2c_client *clien=
t)
>  =09/* 5. Setup irqchip for touchpad IRQ pass-through */
>  =09dock->tp_irqchip.name =3D KBUILD_MODNAME;
> =20
> -=09dock->tp_irq_domain =3D irq_domain_add_linear(NULL, 1, &irq_domain_si=
mple_ops, NULL);
> +=09dock->tp_irq_domain =3D irq_domain_create_linear(NULL, 1, &irq_domain=
_simple_ops, NULL);
>  =09if (!dock->tp_irq_domain)
>  =09=09return -ENOMEM;
> =20
>=20

--=20
 i.

--8323328-823517355-1742572305=:931--

