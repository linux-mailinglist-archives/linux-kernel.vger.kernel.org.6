Return-Path: <linux-kernel+bounces-282724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C493794E7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC4C1F239B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25915B0E2;
	Mon, 12 Aug 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="br1jNn+Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA311474D3;
	Mon, 12 Aug 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448284; cv=none; b=TwazZjqpXHaGCT569tSk9Fr0PDeGkPs1fwb4G8wRfOfIlsn/OPuc+vngcWP2b/FB2m9g66p47sXtNzVC12ZRocPzGOIBE1xt8KvPcwH3Hgjv+ZMsxJ/EluiagIbv+CZKdoTEjpej0SdLK4Qc64Nx0yQDUCOHByfr2CoH8jLe83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448284; c=relaxed/simple;
	bh=8iOrQyfc4kYlxlVzrdGYRGeLXsubI17ApcH8eYvU2Jo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jcLuUEI7efbCo+Jia8mQc/svdKiwKdKe6qkzfw7fo2waTT0iPf459NiSCLEz38+vx7zCRFsyOYn5pgmRcc4qx+J3iNeuFtFjOzLS180018FTgGsYNt8boCGyzfCNQrio0Bzl1keEe7wZv64wxNLGyNRzdsjsGTD5eFiy5Rc1vFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=br1jNn+Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723448282; x=1754984282;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8iOrQyfc4kYlxlVzrdGYRGeLXsubI17ApcH8eYvU2Jo=;
  b=br1jNn+ZrpbCzbUqfFqTtd4/0cAvkoowU+w329LInPkxXl+B/hxaTyhb
   MHNO8ogfslYApCFg4dAt7omIkeB6k+NDSGEL/fsoI34PMO+eqFT+M66TO
   Z9BSQlgRVnSjbaSSeHBXU31EiSLkiB170r40i1eSndqKlpFg7ndEpyefe
   UPAgPKhQ4xTmmB1K9LRTjKQQ+qClWqmw7/ZHULpAJ5slAa5ImcvIwI39x
   XyclWwCvi0tY4cc9zCOr66oYqqV+K8FGKaRdTWmtx+Y7bpvQJW6jY/Mel
   Jpg99yVFQIo/XAt0KV/8bZe7+k6voUFzebDcQ2i4+rcsnfGjFXiWEfWzM
   g==;
X-CSE-ConnectionGUID: p7vE48UdR4G9SpLA+cdMvQ==
X-CSE-MsgGUID: 4fL5WQn2RKOj6lwAloi3qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21687439"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21687439"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:38:01 -0700
X-CSE-ConnectionGUID: hBqTAOYySlSJiP/R3CyM+g==
X-CSE-MsgGUID: jykYGNIgQNeMcAYhOrY/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58896459"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:37:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 10:37:56 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com
Subject: Re: [PATCH v2 2/6] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
In-Reply-To: <7dc2cb6a-3b42-425a-85d3-2f3670bfd8eb@app.fastmail.com>
Message-ID: <27027d00-214d-e566-6339-95ed4397b99d@linux.intel.com>
References: <20240806020747.365042-1-luke@ljones.dev> <20240806020747.365042-3-luke@ljones.dev> <bb056dee-508c-6186-324a-d45bbd1c2306@linux.intel.com> <7dc2cb6a-3b42-425a-85d3-2f3670bfd8eb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1516454341-1723448276=:1039"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1516454341-1723448276=:1039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 11 Aug 2024, Luke Jones wrote:

> On Tue, 6 Aug 2024, at 10:16 PM, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 6 Aug 2024, Luke D. Jones wrote:
> >=20
> > > The fw_attributes_class provides a much cleaner interface to all of t=
he
> > > attributes introduced to asus-wmi. This patch moves all of these extr=
a
> > > attributes over to fw_attributes_class, and shifts the bulk of these
> > > definitions to a new kernel module to reduce the clutter of asus-wmi
> > > with the intention of deprecating the asus-wmi attributes in future.
> > >=20
> > > The work applies only to WMI methods which don't have a clearly defin=
ed
> > > place within the sysfs and as a result ended up lumped together in
> > > /sys/devices/platform/asus-nb-wmi/ with no standard API.
> > >=20
> > > Where possible the fw attrs now implement defaults, min, max, scalar,
> > > choices, etc. As en example dgpu_disable becomes:
> > >=20
> > > /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> > > =E2=94=9C=E2=94=80=E2=94=80 current_value
> > > =E2=94=9C=E2=94=80=E2=94=80 display_name
> > > =E2=94=9C=E2=94=80=E2=94=80 possible_values
> > > =E2=94=94=E2=94=80=E2=94=80 type
> > >=20
> > > as do other attributes.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>

> > > +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attr=
ibute *attr,
> > > +       const char *buf, size_t count, u32 min, u32 max, u32 *store_v=
alue,
> > > +       u32 wmi_dev);
> > > +
> > > +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attri=
bute *attr, char *buf)
> >=20
> > inline missing
> >=20
> > > +{
> > > + return sysfs_emit(buf, "integer\n");
> >=20
> > Lukas Wunner might have done something to make emitting constant string=
s=20
> > easier, please check out if that's already in mainline.
>=20
> I'm not sure what I'm looking for here. Searching my current pdx86 pull=
=20
> isn't returning anything likely and I can't find anything on lore.

I think that was done mostly outside of pdx86, here it is:

https://lore.kernel.org/all/cover.1713608122.git.lukas@wunner.de/

So DEVICE_STRING_ATTR_RO() seems the way to go, I think.

> > > + * On success the return value is 0, and the retval is a valid value=
 returned
> > > + * by the successful WMI function call. An error value is returned o=
nly if the
> > > + * WMI function failed, or if it returns "unsupported" which is typi=
cally a 0
> > > + * (no return, and no 'supported' bit set), or a 0xFFFFFFFE (~1) whi=
ch if not
> > > + * caught here can result in unexpected behaviour later.
> > > + */
> > > +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> > > +{
> > > + int err;
> > > +
> > > + err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0,=
 retval);
> > > + if (err)
> > > + return err;
> > > + /* Be explicit about retval */
> > > + if (*retval =3D=3D 0xFFFFFFFE || *retval =3D=3D 0)
> >=20
> > Please name the literals with defines.
>=20
> Should have been ASUS_WMI_UNSUPPORTED_METHOD :)

Is one define enough if you have two ways to indicate "unsupported"?

> > > + return -ENODEV;
> > > +
> > > + return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(asus_wmi_get_devstate_dsts);
> > > +
> > > +/**
> > > + * asus_wmi_set_devstate() - Set the WMI function state.
> > > + * @dev_id: The WMI function to call.
> > > + * @ctrl_param: The argument to be used for this WMI function.
> > > + * @retval: A pointer to where to store the value returned from WMI.
> > > + *
> > > + * The returned WMI function state if not checked here for error as
> > > + * asus_wmi_set_devstate() is not called unless first paired with a =
call to
> > > + * asus_wmi_get_devstate_dsts() to check that the WMI function is su=
pported.
> > > + *
> > > + * On success the return value is 0, and the retval is a valid value=
 returned
> > > + * by the successful WMI function call. An error value is returned o=
nly if the
> > > + * WMI function failed.
> > > + */
> > > +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
> > >  {
> > >  return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
> > >  ctrl_param, retval);
> > >  }
> > > +EXPORT_SYMBOL_GPL(asus_wmi_set_devstate);
> >=20
> > Namespace exports.
>=20
> I'm sorry, I don't understand.

Use EXPORT_SYMBOL_NS_GPL(). The driver using the functions, will then do=20
MODULE_IMPORT_NS() to pair with the namespace defined by the=20
EXPORT_SYMBOL_NS_GPL().

--=20
 i.

--8323328-1516454341-1723448276=:1039--

