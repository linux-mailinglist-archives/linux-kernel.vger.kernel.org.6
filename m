Return-Path: <linux-kernel+bounces-182206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A438C8815
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB031F27DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4379F0;
	Fri, 17 May 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQcIhi8R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0C384;
	Fri, 17 May 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956278; cv=none; b=Tp55HCF/GxBzmKHl24cjD/BjBn8UE50usKC1a3VI65wsjIXp+mksJFajOHEv1wzu4+/LLv72aS1f432EHuUu7vRdtzzK7vLh3wyZfE0o7PEW94LU6niJaw2jB8iqoCFNZCRICrDVNCow1AWapXv1PSrLXOC9CHIpxsLFQ0lpAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956278; c=relaxed/simple;
	bh=+XVwr27g6xpRhArVMCmv1QypsuQvE/ONQgMImM0GOuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHgzynU7fmPsiHwwvUwbMvKh02F9xT74vgp6R5rtrpkkKsqPnAls9Uy1ILrERLz8unrlfLKCSb1YKwLEICwEq8eLeJax947bEAcIAqUrQr3mTC0K7HmyOmMLbxHGd3gZysZxuGkinTlVvJoFcE4L6BIDEDwN8kYKUJzk/63ixfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQcIhi8R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715956277; x=1747492277;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+XVwr27g6xpRhArVMCmv1QypsuQvE/ONQgMImM0GOuQ=;
  b=gQcIhi8RehN+R62F8jBJCcUywWwhcUvquZP/DawFRtTcH6/X5ddL56Wh
   4gki50wDPwizRotdTER/sf+vrprQLK0YifuUlZsqnZMBRCQtDs+6lATvy
   tbVb24ZCSLXpPN2HtyjnKRgQe/rZzYq5Ty9GnOax6wOxgbTR7pSZO6T7Q
   T+sEuiqlH806lojEh2oLRgeBnSzrCqsy+26AweBroFb5fgquKc8AXtMGx
   lxazGMSqUuRR/VsMs03a+XEheAvcio5N2Fwmky/B4GVtkaaEwn7aqJOXg
   o2hfhfaokynkPT8jIn+1CxcZFG++pff+4h3zWRUZKyE5f/jUmX3zHsk45
   Q==;
X-CSE-ConnectionGUID: tF0M2h9yS1K0bGv7X8SASA==
X-CSE-MsgGUID: H75z8426QtqNI1OMxDf/3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="15083948"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="15083948"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:31:16 -0700
X-CSE-ConnectionGUID: W4xs4OT+QE6hymWIEef/RA==
X-CSE-MsgGUID: aSvBzR9gT6mi0Ue4OpWj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="32359554"
Received: from spandruv-desk1.amr.corp.intel.com ([10.212.227.54])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:31:15 -0700
Message-ID: <48377484a8a9e479b301e9a9772653a3bc6ccf81.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Hans de Goede
	 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, 
	error27@gmail.com
Date: Fri, 17 May 2024 07:31:14 -0700
In-Reply-To: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
References: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-14 at 02:26 -0700, Harshit Mogalapalli wrote:
> In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being freed.
> Fix this by reordering the kfree() post the dereference.
>=20
> Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned
> systems")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> This is found by smatch and only compile tested.
> ---
> =C2=A0drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 7bac7841ff0a..7fa360073f6e 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct
> auxiliary_device *auxdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_sst->partition_mask_=
current &=3D ~BIT(plat_info-
> >partition);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Free the package insta=
nce when the all partitions are
> removed */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tpmi_sst->partition_=
mask_current) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kfree(tpmi_sst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0isst_common.sst_inst[tpmi_sst->package_id] =3D NULL=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kfree(tpmi_sst);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&isst_tpmi_d=
ev_lock);
> =C2=A0}


