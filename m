Return-Path: <linux-kernel+bounces-183548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A132B8C9A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC09281FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5C224F2;
	Mon, 20 May 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2C1HHCx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC13249E8;
	Mon, 20 May 2024 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197943; cv=none; b=GMSa5AI6Rb1AgnxPhs1mZ3AgDMuzn4aRO7ZbKuUumiTfaXTyX+tWtFKe4+u/sqzNiRID8iS/WegkztBEzOfecIKqDZhvt/zB7hU58It+2qOov6kufgj0zcPWWi3iDXN/Giq6ai5TcQDhAPbc9s2Oud1+k3hnqSwTA8/w//6InZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197943; c=relaxed/simple;
	bh=HnrE7YR5PqVfQJBFtQC0OlXuY+THNTwRfu9PcjEgXMA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A0kTBhsbDCe1rfKy40jSS+BQeHqTzDuMty3RtBBs1yclFNELJhy9p6uvaixD/smaWRPSPVi6exDNDOzSTD0AGWAW6u3A1G01qpCxF0r6SuRYV7DdS4JjMhHFSnzTUmZANvzSi55S3OeJSMioYV2E+Sf6kq81WuqBoAshromvlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2C1HHCx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716197942; x=1747733942;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=HnrE7YR5PqVfQJBFtQC0OlXuY+THNTwRfu9PcjEgXMA=;
  b=h2C1HHCxaYwGHFrkI1DYGtN9Iu32MLH0qXCbxy5AjFohtWNwA0l+9H0p
   MygnO0YMapXQ2vKpxTa0LwRoV3KwZp/K2qSrbIdTq08CflurO+ULOLf4m
   LlM7Iu947xuQHY1qLy4vtmXqmPWLMMh9zNcJhMAOk6dZBu9DD2lgPlbfI
   vESuHuBE+OFA/Fzqa462bxIefS7u+bzMLO5ZwG74RbRPIEqfPPQApX4/k
   TCD/1M3iAkTrgtK5EgKZIw3LGIxlc8srGn3juOcZ9anFLAgtMHJATY4gg
   ST8QjQX+m4cvb4o/a9hvfauwoC7Oad93nx15jMmypxNAh35ZtqmIHtK+E
   Q==;
X-CSE-ConnectionGUID: gJ1wBnz8SXerGMRkwEJ3Hw==
X-CSE-MsgGUID: QYqpxxoERxW8R58FAT61WQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="15260860"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="15260860"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:39:01 -0700
X-CSE-ConnectionGUID: FAPKg2nDSMSWRYVi5g54Ww==
X-CSE-MsgGUID: Kmr3vay3RGyb+8t5T3ojIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="33086025"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.113])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:38:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 May 2024 12:38:55 +0300 (EEST)
To: Markus Elfring <Markus.Elfring@web.de>
cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
    platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
In-Reply-To: <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de>
Message-ID: <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com> <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-129071608-1716197769=:5522"
Content-ID: <2d9bfb7c-a268-9795-b90f-6138f88f9a83@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-129071608-1716197769=:5522
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <68320c4c-2329-261b-89c9-f624e9d11f16@linux.intel.com>

On Sat, 18 May 2024, Markus Elfring wrote:

> =E2=80=A6
> > Fix this by reordering the kfree() post the dereference.
>=20
> Would a wording approach (like the following) be a bit nicer?
>=20
>    Move a kfree() call behind an assignment statement in the affected if =
branch.

No, the suggested wording would make it less precise ("post the=20
dereference" -> "behind an assignment") and also tries to tell pointless=20
things about the location in the codei that is visible in the patch itself.

--=20
 i.

> > v1->v2: Add R.B from Hans and fix commit message wrapping to 75 chars.
> > This is found by smatch and only compile tested.
>=20
> * Can it occasionally be nicer to use an enumeration also for
>   version descriptions?
>=20
> * Is it helpful to separate additional comments by blank lines?
>=20
>=20
> > ---
> >  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
>=20
> How do you think about to omit a repeated marker line here?
>=20
> Regards,
> Markus
>=20
--8323328-129071608-1716197769=:5522--

