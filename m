Return-Path: <linux-kernel+bounces-197130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F9D8D6699
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FBB28B938
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32415B128;
	Fri, 31 May 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5s8ydkP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52622086;
	Fri, 31 May 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172245; cv=none; b=CcaTqW5tKxrB31TxPMH4eGxXFiEuXHLZ4hj0cqGG4MZwHHoUf3DCd6X0F+zRU8NSy1uy7+Ry37tvMMpmdXcGRbqigFSwYknhUXPxJp1YEuHGYPg9xohu0YZZZAnKeuqIMot4HOLJUS1NsuPFMbRUhWFF2vHhmm8mZ7PDyU/vB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172245; c=relaxed/simple;
	bh=Qj5PMqOEJ9ehUcWnvpkBhqYbFsxb8Di1pGvsaRY0QhU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WCBjGtULi/bFmpnDH7/kM82qulFkRS3ucpK3281i7ts1KJqBaAHKmx6czOijMYC9SHgr0uR5lZpBbR2gF0FpPb8lDoJH8lLN5b45lPQSuBvl0kaO70SIPmj1x9U2DWKE9A9i3JEc5KE0ngr/9HP9nGhHJovH6fKmPXYiENrL740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5s8ydkP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717172243; x=1748708243;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qj5PMqOEJ9ehUcWnvpkBhqYbFsxb8Di1pGvsaRY0QhU=;
  b=g5s8ydkPrG83YFnPvcDE5/1oAu9j1UWJh7L/QjdE/SUrW46llKk3CBSJ
   wBM5VtoWpRafGJFacY6D3PB6tWDbCRNgB3WocSpMCLh6/kH0YN6oMnkM3
   t3XkmvDY5a8p19as0tksSYUkMzgB6hvyUGhLup4NO5vffBtyDT7tNPwrG
   j0w3JMJVo7lVAZPYv7Y5jE1wR7CL+oZYgW3R6ZfWsIDTJOSXdHrZisWz9
   tIR0Pdlm6toZjpIXCFwtPxVHfxB2mqZnqPbHO+8OOG955Bo4abRTtnmFH
   eTMepv5qhli4xPnIIq7px/CEYDaLq8uPITQjVTLcXWHoRlHdtF+Wbk/fA
   Q==;
X-CSE-ConnectionGUID: Mn/N04YZTluX9wuJLxUOPg==
X-CSE-MsgGUID: 5e9RcGxfSkWEBSBjBVP2Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17569221"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17569221"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:17:22 -0700
X-CSE-ConnectionGUID: I4vuSRq7Ria3JI+BQ8oUmg==
X-CSE-MsgGUID: EE5X3AJhRoWuSwvXsZK5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36825404"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 09:17:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 31 May 2024 19:17:17 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] platform/x86: dell-smbios: Fix wrong token data
 in sysfs
In-Reply-To: <20240528204903.445546-1-W_Armin@gmx.de>
Message-ID: <d7e5e821-b102-307d-5dc1-9e6b4d226f80@linux.intel.com>
References: <20240528204903.445546-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1504077243-1717172237=:8458"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1504077243-1717172237=:8458
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 May 2024, Armin Wolf wrote:

> When reading token data from sysfs on my Inspiron 3505, the token
> locations and values are wrong. This happens because match_attribute()
> blindly assumes that all entries in da_tokens have an associated
> entry in token_attrs.
>=20
> This however is not true as soon as da_tokens[] contains zeroed
> token entries. Those entries are being skipped when initialising
> token_attrs, breaking the core assumption of match_attribute().
>=20
> Fix this by defining an extra struct for each pair of token attributes
> and use container_of() to retrieve token information.
>=20
> Tested on a Dell Inspiron 3050.
>=20
> Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface fo=
r SMBIOS tokens")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v1:
> - remove style changes
> - improve sizeof() usage with pointer targets
> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 92 ++++++++------------
>  1 file changed, 36 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platf=
orm/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..86b95206cb1b 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> +#include <linux/container_of.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/capability.h>
> @@ -25,11 +26,16 @@ static u32 da_supported_commands;
>  static int da_num_tokens;
>  static struct platform_device *platform_device;
>  static struct calling_interface_token *da_tokens;
> -static struct device_attribute *token_location_attrs;
> -static struct device_attribute *token_value_attrs;
> +static struct token_sysfs_data *token_entries;
>  static struct attribute **token_attrs;
>  static DEFINE_MUTEX(smbios_mutex);
>=20
> +struct token_sysfs_data {
> +=09struct device_attribute location_attr;
> +=09struct device_attribute value_attr;
> +=09struct calling_interface_token *token;
> +};
> +
>  struct smbios_device {
>  =09struct list_head list;
>  =09struct device *device;
> @@ -416,47 +422,26 @@ static void __init find_tokens(const struct dmi_hea=
der *dm, void *dummy)
>  =09}
>  }
>=20
> -static int match_attribute(struct device *dev,
> -=09=09=09   struct device_attribute *attr)
> -{
> -=09int i;
> -
> -=09for (i =3D 0; i < da_num_tokens * 2; i++) {
> -=09=09if (!token_attrs[i])
> -=09=09=09continue;
> -=09=09if (strcmp(token_attrs[i]->name, attr->attr.name) =3D=3D 0)
> -=09=09=09return i/2;
> -=09}
> -=09dev_dbg(dev, "couldn't match: %s\n", attr->attr.name);
> -=09return -EINVAL;
> -}
> -
>  static ssize_t location_show(struct device *dev,
>  =09=09=09     struct device_attribute *attr, char *buf)
>  {
> -=09int i;
> +=09struct token_sysfs_data *data =3D container_of(attr, struct token_sys=
fs_data, location_attr);
>=20
>  =09if (!capable(CAP_SYS_ADMIN))
>  =09=09return -EPERM;
>=20
> -=09i =3D match_attribute(dev, attr);
> -=09if (i > 0)
> -=09=09return sysfs_emit(buf, "%08x", da_tokens[i].location);
> -=09return 0;
> +=09return sysfs_emit(buf, "%08x", data->token->location);
>  }
>=20
>  static ssize_t value_show(struct device *dev,
>  =09=09=09  struct device_attribute *attr, char *buf)
>  {
> -=09int i;
> +=09struct token_sysfs_data *data =3D container_of(attr, struct token_sys=
fs_data, value_attr);
>=20
>  =09if (!capable(CAP_SYS_ADMIN))
>  =09=09return -EPERM;
>=20
> -=09i =3D match_attribute(dev, attr);
> -=09if (i > 0)
> -=09=09return sysfs_emit(buf, "%08x", da_tokens[i].value);
> -=09return 0;
> +=09return sysfs_emit(buf, "%08x", data->token->value);
>  }
>=20
>  static struct attribute_group smbios_attribute_group =3D {
> @@ -473,22 +458,15 @@ static int build_tokens_sysfs(struct platform_devic=
e *dev)
>  {
>  =09char *location_name;
>  =09char *value_name;
> -=09size_t size;
>  =09int ret;
>  =09int i, j;
>=20
> -=09/* (number of tokens  + 1 for null terminated */
> -=09size =3D sizeof(struct device_attribute) * (da_num_tokens + 1);
> -=09token_location_attrs =3D kzalloc(size, GFP_KERNEL);
> -=09if (!token_location_attrs)
> +=09token_entries =3D kcalloc(da_num_tokens, sizeof(*token_entries), GFP_=
KERNEL);
> +=09if (!token_entries)
>  =09=09return -ENOMEM;
> -=09token_value_attrs =3D kzalloc(size, GFP_KERNEL);
> -=09if (!token_value_attrs)
> -=09=09goto out_allocate_value;
>=20
>  =09/* need to store both location and value + terminator*/
> -=09size =3D sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
> -=09token_attrs =3D kzalloc(size, GFP_KERNEL);
> +=09token_attrs =3D kcalloc((2 * da_num_tokens) + 1, sizeof(*token_attrs)=
, GFP_KERNEL);

This isn't actually required for the fix since it's in practice just a
syntatic cleanup but then it is harmful either.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>  =09if (!token_attrs)
>  =09=09goto out_allocate_attrs;
>=20
> @@ -496,27 +474,32 @@ static int build_tokens_sysfs(struct platform_devic=
e *dev)
>  =09=09/* skip empty */
>  =09=09if (da_tokens[i].tokenID =3D=3D 0)
>  =09=09=09continue;
> +
> +=09=09token_entries[i].token =3D &da_tokens[i];
> +
>  =09=09/* add location */
>  =09=09location_name =3D kasprintf(GFP_KERNEL, "%04x_location",
>  =09=09=09=09=09  da_tokens[i].tokenID);
>  =09=09if (location_name =3D=3D NULL)
>  =09=09=09goto out_unwind_strings;
> -=09=09sysfs_attr_init(&token_location_attrs[i].attr);
> -=09=09token_location_attrs[i].attr.name =3D location_name;
> -=09=09token_location_attrs[i].attr.mode =3D 0444;
> -=09=09token_location_attrs[i].show =3D location_show;
> -=09=09token_attrs[j++] =3D &token_location_attrs[i].attr;
> +
> +=09=09sysfs_attr_init(&token_entries[i].location_attr.attr);
> +=09=09token_entries[i].location_attr.attr.name =3D location_name;
> +=09=09token_entries[i].location_attr.attr.mode =3D 0444;
> +=09=09token_entries[i].location_attr.show =3D location_show;
> +=09=09token_attrs[j++] =3D &token_entries[i].location_attr.attr;
>=20
>  =09=09/* add value */
>  =09=09value_name =3D kasprintf(GFP_KERNEL, "%04x_value",
>  =09=09=09=09       da_tokens[i].tokenID);
>  =09=09if (value_name =3D=3D NULL)
>  =09=09=09goto loop_fail_create_value;
> -=09=09sysfs_attr_init(&token_value_attrs[i].attr);
> -=09=09token_value_attrs[i].attr.name =3D value_name;
> -=09=09token_value_attrs[i].attr.mode =3D 0444;
> -=09=09token_value_attrs[i].show =3D value_show;
> -=09=09token_attrs[j++] =3D &token_value_attrs[i].attr;
> +
> +=09=09sysfs_attr_init(&token_entries[i].value_attr.attr);
> +=09=09token_entries[i].value_attr.attr.name =3D value_name;
> +=09=09token_entries[i].value_attr.attr.mode =3D 0444;
> +=09=09token_entries[i].value_attr.show =3D value_show;
> +=09=09token_attrs[j++] =3D &token_entries[i].value_attr.attr;
>  =09=09continue;
>=20
>  loop_fail_create_value:
> @@ -532,14 +515,12 @@ static int build_tokens_sysfs(struct platform_devic=
e *dev)
>=20
>  out_unwind_strings:
>  =09while (i--) {
> -=09=09kfree(token_location_attrs[i].attr.name);
> -=09=09kfree(token_value_attrs[i].attr.name);
> +=09=09kfree(token_entries[i].location_attr.attr.name);
> +=09=09kfree(token_entries[i].value_attr.attr.name);
>  =09}
>  =09kfree(token_attrs);
>  out_allocate_attrs:
> -=09kfree(token_value_attrs);
> -out_allocate_value:
> -=09kfree(token_location_attrs);
> +=09kfree(token_entries);
>=20
>  =09return -ENOMEM;
>  }
> @@ -551,12 +532,11 @@ static void free_group(struct platform_device *pdev=
)
>  =09sysfs_remove_group(&pdev->dev.kobj,
>  =09=09=09=09&smbios_attribute_group);
>  =09for (i =3D 0; i < da_num_tokens; i++) {
> -=09=09kfree(token_location_attrs[i].attr.name);
> -=09=09kfree(token_value_attrs[i].attr.name);
> +=09=09kfree(token_entries[i].location_attr.attr.name);
> +=09=09kfree(token_entries[i].value_attr.attr.name);
>  =09}
>  =09kfree(token_attrs);
> -=09kfree(token_value_attrs);
> -=09kfree(token_location_attrs);
> +=09kfree(token_entries);
>  }
>=20
>  static int __init dell_smbios_init(void)
> --
> 2.39.2
>=20
--8323328-1504077243-1717172237=:8458--

