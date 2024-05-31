Return-Path: <linux-kernel+bounces-197136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E948D66A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FABF28D614
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA831649BE;
	Fri, 31 May 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWdnD4LA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F17158DD3;
	Fri, 31 May 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172360; cv=none; b=OChN8/gfezcQdcBxN4KWeNTx6is3G5dav7G9UwFn84QIl3qQ9o/g/h81t/ebbSIFJDJSQe6q5dwOLdMCl8nw6y8Zaj5qdj5TexDpGVXde4zoR8r4GNvn9W2a/YLw8Uvtb/7gv5ybnC5ggaEqsk6jDN19WL4EvEoXHeJW6sbxrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172360; c=relaxed/simple;
	bh=aG7/jcewM8OFtTtVBndt67BCf3fYwlgZkSDr9Umy1oA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BKFcvSe1u9iReLR0fErl3G9nKm1Sx+2H3V3WewpymK8dNAIlfo/Zkfy/GM77RYpgPZGE4h2WAruWAbx+fJcRehr+gqjXaS2Btc1v2hwmTCKKIdMKH9DhdbOUsWC0PC0B51KtdbZmL7ziCXahIsVA63f53ACCyrCWA81mTH/lHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWdnD4LA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717172359; x=1748708359;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aG7/jcewM8OFtTtVBndt67BCf3fYwlgZkSDr9Umy1oA=;
  b=XWdnD4LAaf4A7KKIprI1n8iU8WD8P/A2gXlW5lglHsrqSIjNqP8KHO/t
   OPMYPPYStLSX0oEtHNhCHno3qzva895mvka/+oxCLq4VSbQ5+vrsd9FTg
   KauPfpqllr3DREkGIsEeTFlTEQSeugJcsss9zh65DDgvav9tjPg7JJHtI
   C1l8jnO9ITM1TW9BYBdysR98MmyxDr7FXBTeA1P1sCaH1rUr4WAuycxe7
   qZ3O821EAMu+wCgVIUYUVV7AH1g1KLNlQUenjXJt8RA8ra+fz+NTHKU/v
   U6aqLQOJ5X7hhpYudjkQE2lsQHuSi/X+Ar5OALyVpfhKjaSFcwz+vzjwp
   g==;
X-CSE-ConnectionGUID: Y7rbXHlVTzqWXToZsyzkVA==
X-CSE-MsgGUID: xTg6s/bKQSiBFAHq4E+8ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13917234"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13917234"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:19:18 -0700
X-CSE-ConnectionGUID: oO43TFx9QlijRuLnBNoxFw==
X-CSE-MsgGUID: 5Ji/2YY4RCGej7BRwnaaKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36790294"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:19:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 31 May 2024 19:19:12 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] platform/x86: dell-smbios: Simplify error
 handling
In-Reply-To: <20240528204903.445546-2-W_Armin@gmx.de>
Message-ID: <8353e3d0-7553-50f9-160b-fa8b6df2f067@linux.intel.com>
References: <20240528204903.445546-1-W_Armin@gmx.de> <20240528204903.445546-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1046594730-1717172352=:8458"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1046594730-1717172352=:8458
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 May 2024, Armin Wolf wrote:

> When the allocation of value_name fails, the error handling code
> uses two gotos for error handling, which is not necessary.
>=20
> Simplify the error handling in this case by only using a single goto.
>=20
> Tested on a Dell Inspiron 3505.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v1:
> - add patch
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platf=
orm/x86/dell/dell-smbios-base.c
> index 86b95206cb1b..b562ed99ec4e 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -492,19 +492,16 @@ static int build_tokens_sysfs(struct platform_devic=
e *dev)
>  =09=09/* add value */
>  =09=09value_name =3D kasprintf(GFP_KERNEL, "%04x_value",
>  =09=09=09=09       da_tokens[i].tokenID);
> -=09=09if (value_name =3D=3D NULL)
> -=09=09=09goto loop_fail_create_value;
> +=09=09if (!value_name) {
> +=09=09=09kfree(location_name);
> +=09=09=09goto out_unwind_strings;
> +=09=09}
>=20
>  =09=09sysfs_attr_init(&token_entries[i].value_attr.attr);
>  =09=09token_entries[i].value_attr.attr.name =3D value_name;
>  =09=09token_entries[i].value_attr.attr.mode =3D 0444;
>  =09=09token_entries[i].value_attr.show =3D value_show;
>  =09=09token_attrs[j++] =3D &token_entries[i].value_attr.attr;
> -=09=09continue;
> -
> -loop_fail_create_value:
> -=09=09kfree(location_name);
> -=09=09goto out_unwind_strings;
>  =09}
>  =09smbios_attribute_group.attrs =3D token_attrs;

Good cleanup. Using continue on the main level of a loop is almost never a=
=20
good idea.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1046594730-1717172352=:8458--

