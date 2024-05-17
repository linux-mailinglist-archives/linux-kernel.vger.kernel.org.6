Return-Path: <linux-kernel+bounces-182210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0758C8820
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0CB287D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52679F6;
	Fri, 17 May 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cirqtj3S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFB384;
	Fri, 17 May 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956441; cv=none; b=Yc77uQY0h6UR2z3ahgIEKsqzRZgmDjQ8KU2899gh827IrJOAwx5kOPbYPJw4LnwXAjV2dz7QK+xRB+iBq/KF72FBRXoptpxH+OGbTOu52F95EGkcgWDN6UbMxJP7rD3JeTlr+BbzJsWaCDG2X+Mhi1L1xzhskKLauMXDrLIpyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956441; c=relaxed/simple;
	bh=GEcGQOZtXdyFsY3D7iFPfihQ6HWWbP+dRjsKgMzTFmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THm0ZUoAIpjlJTXLWkiFDlzczP9WgoN7WU1p2+qJFVV9mEOwHu3mMtDjpKzKSl8loFNnA8DmXMb9x0pfGipXJTgE6YMskd5X+FVASO+V4G74ZaEB/I0H+MUBnWt32MmfgEI0nUDj3glND+F30duenSYZw5EkqVobOKtKzwqX9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cirqtj3S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715956440; x=1747492440;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GEcGQOZtXdyFsY3D7iFPfihQ6HWWbP+dRjsKgMzTFmE=;
  b=Cirqtj3SlKAEtTxA/wvGKcZ8N5G2Q4t09ZUoQyb+AugWBGEamNS9vrYs
   jf8nAYxp9UMjlYx8/8xije+OM6EsvPLvTcmzSsdvlHJBTxiB1qd6efOKC
   MoLvsRWDrKyJKZFImmIY8AS6FXz3XShK5d+9u7A/NoSMstfydho4fQ4K0
   1r8KOLRQL0QkKfdK3nPR40OCj7GrnQ2v/laOD9aCL1/tFMQjTEfJfMJLt
   HL2fF3hXqmiOc5dSu6jiiZi1JBb0IVOsV++WdmkfFIakRrbFpt559C/MN
   p+KSalgdg/D9L4Endcnix6nv7dTn9URMHaPzpYO0wULtjGrIF53+TiQmA
   w==;
X-CSE-ConnectionGUID: qZ0OjFzeRZOSQM72CUkESg==
X-CSE-MsgGUID: gk4CwGYpThiDRfTcIPmqsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11574840"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11574840"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:33:59 -0700
X-CSE-ConnectionGUID: cYlVUlO+TmGfawCuq3yoCg==
X-CSE-MsgGUID: FVvTleXATw+yXMyBT7vCqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31734119"
Received: from velpulaa-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.227.54])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:33:59 -0700
Message-ID: <e2b386431754d70c6772abee099dce4acc1d4023.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Hans de Goede
	 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, 
	error27@gmail.com
Date: Fri, 17 May 2024 07:33:58 -0700
In-Reply-To: <48377484a8a9e479b301e9a9772653a3bc6ccf81.camel@linux.intel.com>
References: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
	 <48377484a8a9e479b301e9a9772653a3bc6ccf81.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-17 at 07:31 -0700, srinivas pandruvada wrote:
> On Tue, 2024-05-14 at 02:26 -0700, Harshit Mogalapalli wrote:
> > In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being
> > freed.
> > Fix this by reordering the kfree() post the dereference.
> >=20
> > Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned
> > systems")
> > Signed-off-by: Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
I realized the line length is 127 chars in commit description.
Please fix that and run checkpatch.pl before posting again.

Thanks,
Srinivas

> > ---
> > This is found by smatch and only compile tested.
> > ---
> > =C2=A0drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +=
-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > index 7bac7841ff0a..7fa360073f6e 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > @@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct
> > auxiliary_device *auxdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_sst->partition_mas=
k_current &=3D ~BIT(plat_info-
> > > partition);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Free the package ins=
tance when the all partitions are
> > removed */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tpmi_sst->partitio=
n_mask_current) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kfree(tpmi_sst);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0isst_common.sst_inst[tpmi_sst->package_id] =3D N=
ULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kfree(tpmi_sst);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&isst_tpmi=
_dev_lock);
> > =C2=A0}
>=20


