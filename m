Return-Path: <linux-kernel+bounces-374013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503B9A609B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46841F225B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02F1E3DD3;
	Mon, 21 Oct 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="US+5GZTA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C911799F;
	Mon, 21 Oct 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504157; cv=none; b=T+NMl9yBhgQd/x1W5LXB9TOw9jmpAPz+kYvchMQ3NEqmUYe3X4zrMFVIcY4+nURiz9SmajNQHviT7CyjCKlyvdaIXKYAOnW1Wyj5EsnbpTKx1UFhuDOw7l18kx2wp4Ezlri5zh8zh99cSIavvoqLfXFxNJeZQAge1zV270yLB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504157; c=relaxed/simple;
	bh=LVlyh6gWyKin0x0BUybEyhwr2ToXpCky2JG4EsFXQJE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HLic1A2v/XxA9ctxQLQMJrYixOfPiVUwL9sy/HztpzhOHGc2S+J9JAywDSOWbl5YLqYg1n2xADmW0dKcOr0IRYXHbMXb3IROpPXqRU8uqBPUi1An7GMxD0kEM4wyBrcUkoPP7CA0gDqNt+vLKUkipHyII90TDSTPIEdjJuNutZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=US+5GZTA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729504156; x=1761040156;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LVlyh6gWyKin0x0BUybEyhwr2ToXpCky2JG4EsFXQJE=;
  b=US+5GZTAs+Hw7lsgTuqIjFLeprWNgScqF3+0pXynLvFY4l0A4GKLCm1n
   gAqScnfPNUz9V6K3LWAWsD2Q0nGDQkaDK0Lkm9ofaU6zzR9tCWcaXYwmh
   /QnSyhdmBi2BkW8tIHYP8LmKJmfDxlhixkgxjEW4Dll7gClymGQ/MzwdV
   alPV5S5iEUIwXAcSKw7BK2IGwZD7U7QZrzTvMqo0o0UtJPbqbuZHyeL2d
   ksgptS4kLC+iK9KILkAa62T982E3Sc+DcHpHBrIIHH4DTtVbznt8JvKRf
   +ly9uMold38TLTtUmxjI17un0KNOjcfz0vwV3agcuOMYR/PwBASqlqq0a
   Q==;
X-CSE-ConnectionGUID: qpKgz+I7QDOorCxscD24aw==
X-CSE-MsgGUID: Rojmg0RjQwuCooZdY+XTVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="39567421"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="39567421"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:49:15 -0700
X-CSE-ConnectionGUID: +46OhpZERIuxLidf9QJHtg==
X-CSE-MsgGUID: 4cFn4d27Ru6+NQeX61+D2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="116921685"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:49:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 12:49:08 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
In-Reply-To: <ZxYgZGYTzINm2lpz@smile.fi.intel.com>
Message-ID: <d40d824e-1827-4030-794c-a7c7e15137e6@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com> <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com> <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com> <ZxYgZGYTzINm2lpz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-256814922-1729504148=:1065"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-256814922-1729504148=:1065
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Oct 2024, Andy Shevchenko wrote:

> On Mon, Oct 21, 2024 at 12:24:57PM +0300, Ilpo J=E4rvinen wrote:
> > On Mon, 21 Oct 2024, Andy Shevchenko wrote:
> >=20
> > > The theory is that the so called workaround in pwr_reg_rdwr() is
> > > the actual reader of the data in 32-bit chunks. For some reason
> > > the 8-bit IO won't fail after that. Replace the workaround by using
> > > 32-bit IO explicitly and then memcpy() as much data as was requested
> > > by the user. The same approach is already in use in
> > > intel_scu_ipc_dev_command_with_size().
>=20
> ...
>=20
> > >  =09err =3D intel_scu_ipc_check_status(scu);
> > > -=09if (!err && id =3D=3D IPC_CMD_PCNTRL_R) { /* Read rbuf */
> > > -=09=09/* Workaround: values are read as 0 without memcpy_fromio */
> > > -=09=09memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
> > > -=09=09for (nc =3D 0; nc < count; nc++)
> > > -=09=09=09data[nc] =3D ipc_data_readb(scu, nc);
> > > +=09if (!err) { /* Read rbuf */
> >=20
> > What is the reason for the removal of that id check? This seems a clear=
=20
> > logic change but why? And if you remove want to remove that check, what=
=20
> > that comment then means?
>=20
> Let me split this to a separate change with better explanation then.
>=20
> > > +=09=09for (nc =3D 0, offset =3D 0; nc < 4; nc++, offset +=3D 4)
> > > +=09=09=09wbuf[nc] =3D ipc_data_readl(scu, offset);
> > > +=09=09memcpy(data, wbuf, count);
> >=20
> > So do we actually need to read more than
> > DIV_ROUND_UP(min(count, 16U), sizeof(u32))? Because that's the approach=
=20
> > used in intel_scu_ipc_dev_command_with_size() which you referred to.
>=20
> I'm not sure I follow. We do IO for whole (16-bytes) buffer, but return o=
nly
> asked _bytes_ to the user.

So always reading 16 bytes is not part of the old workaround? Because it=20
has a "lets read enough" feel.

> > >  =09}
> > >  =09mutex_unlock(&ipclock);
> > >  =09return err;
> >=20
> > FYI (unrelated to this patch), there seems to be some open-coded=20
> > FIELD_PREP()s in pwr_reg_rdwr(), some of which is common code between=
=20
> > those if branches too.
>=20
> This code is quite old and full of tricks that has to be tested. So, yes
> while it's possible to convert, I would like to do it in a small (baby)
> steps. This series is already quite intrusive from this perspective :-)

Yeah, no pressure, I just noted down what I saw. :-)

--=20
 i.

--8323328-256814922-1729504148=:1065--

