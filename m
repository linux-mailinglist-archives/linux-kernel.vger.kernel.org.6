Return-Path: <linux-kernel+bounces-374074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C99A6244
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C691F22015
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E61E47C3;
	Mon, 21 Oct 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEemz6NO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A46192D69;
	Mon, 21 Oct 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505702; cv=none; b=uuaRaqCdyNBLQjZlx8mlbnAmcf/pjqp52qYpauESBnCoeFj4dAcxdEPdDcBfDrhzoeGuj0wX7oc9T1vq5yqY0YzUxyvqh2/97TRhnMmPRz4YYbJHll0Hn/hP/MrFOx6NWVV22SF0jqSW/TW1/xEMqc06zcGQ7xuTg32Zt2AV0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505702; c=relaxed/simple;
	bh=gb51aNrzTOur0Z+WesfF7J7WZbMhBgIsrP7GrkfbNyI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DYfJJQK36AXaSpcxsrKfiqJHZgH2cWVhPJxGVuPjGcCxMChQ0ScpcBTiuoNiTmE2g4Uc2cihg9EVEN583Nb3v8oEo3vZR8tjukXiLFUHlcuBuCHLv0FD+hWByUY/3ezkZb8JWmGDiAGmFbjq9pDcM/KyOCLCeQaONIe9MbBnYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEemz6NO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729505701; x=1761041701;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gb51aNrzTOur0Z+WesfF7J7WZbMhBgIsrP7GrkfbNyI=;
  b=YEemz6NOHhlWZ4qm73Tu++GoWPoXumVtHp23bJtfeY+fbIvvLvBcqNPI
   3zIJNNZk2m3vJrBjdf6t2ZPM/SGSISZkNVnHCZWUpZhJOLdqvkBZk+BCT
   Y8liWMNSjNyUlpitlAZNECZ6tSRWfGVoPbf35FDqo9EXrTLS9RahfXNTk
   xVo0XUHkYjD8vjgWwg/7mRDIO2gvPiuvuRf2qLGKSB/57aD4BCbwdbb5c
   OxI6+wQ+oZijVBTyVBlQYr6PL38FxUkVES/dZ7V8XmZdVWRJ/xfvhCPKX
   KyxXUBYOjEvU6x71rfudThG3lXwob6u4F0Lrb26eEDPB2Yubjcxa3slzX
   g==;
X-CSE-ConnectionGUID: p+FJcSmjR3S6Dbx5up/Ozg==
X-CSE-MsgGUID: N+aa07AyQneHYwCtzxll3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="16612693"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="16612693"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:15:00 -0700
X-CSE-ConnectionGUID: M9zx/9BNQJqmvDzcStHG/Q==
X-CSE-MsgGUID: ykqHpS4kQueHUPVmvmbCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84552875"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:14:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 13:14:54 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
In-Reply-To: <ZxYmxOPLOGol22gz@smile.fi.intel.com>
Message-ID: <042a0a04-06e2-f277-f666-15f748469d59@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com> <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com> <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com> <ZxYgZGYTzINm2lpz@smile.fi.intel.com> <d40d824e-1827-4030-794c-a7c7e15137e6@linux.intel.com>
 <ZxYkyC00pDzarnVU@smile.fi.intel.com> <ZxYmxOPLOGol22gz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1357495397-1729505694=:1065"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1357495397-1729505694=:1065
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Oct 2024, Andy Shevchenko wrote:

> On Mon, Oct 21, 2024 at 12:54:16PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 21, 2024 at 12:49:08PM +0300, Ilpo J=E4rvinen wrote:
> > > On Mon, 21 Oct 2024, Andy Shevchenko wrote:
> > > > On Mon, Oct 21, 2024 at 12:24:57PM +0300, Ilpo J=E4rvinen wrote:
> > > > > On Mon, 21 Oct 2024, Andy Shevchenko wrote:
>=20
> ...
>=20
> > > > > > +=09=09for (nc =3D 0, offset =3D 0; nc < 4; nc++, offset +=3D 4=
)
> > > > > > +=09=09=09wbuf[nc] =3D ipc_data_readl(scu, offset);
> > > > > > +=09=09memcpy(data, wbuf, count);
> > > > >=20
> > > > > So do we actually need to read more than
> > > > > DIV_ROUND_UP(min(count, 16U), sizeof(u32))? Because that's the ap=
proach=20
> > > > > used in intel_scu_ipc_dev_command_with_size() which you referred =
to.
> > > >=20
> > > > I'm not sure I follow. We do IO for whole (16-bytes) buffer, but re=
turn only
> > > > asked _bytes_ to the user.
> > >=20
> > > So always reading 16 bytes is not part of the old workaround? Because=
 it=20
> > > has a "lets read enough" feel.
> >=20
> > Ah, now I got it! Yes, we may reduce the reads to just needed ones.
> > The idea is that we always have to perform 32-bit reads independently
> > on the amount of data we want.
>=20
> Oh, looking at the code (*) it seems they are really messed up in the ori=
ginal
> with bytes vs. 32-bit words! Since the above has been tested, let me put =
this
> on TODO list to clarify this mess and run with another testing.
>=20
> Sounds good to you?

Sure, I'm fine with taking the careful approach.

> *) the mythical comment about max 5 items for 20-byte buffer is worrying =
and
> now I know why,

Those functions with that comment seem to only be called from=20
scu_reg_access() which error checks count > 4.

--=20
 i.

--8323328-1357495397-1729505694=:1065--

