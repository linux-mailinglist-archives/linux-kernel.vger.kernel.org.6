Return-Path: <linux-kernel+bounces-182276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F518C8920
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A6F1F21DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11112CD8A;
	Fri, 17 May 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gx2NzsEH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4E1F93E;
	Fri, 17 May 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958962; cv=none; b=dLTaEkQzIImfvaXAjUURISVbUzvWfLTaNMbGhVc7u3smi9ZNurNcTgVwv/YGKOeh4ru+KcVayLNzaAcK8VLruCpbKI3PZk1LHo9g5LmxvaBl4EAdpsb4AHbLXkn+/MU2ktjijamP6/FwYtuaNqpgUryKJ0vPUU/fRaDX2Au+lnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958962; c=relaxed/simple;
	bh=6SGRzemzE222vlrc/5jANNd2vwMs0qyJ0hvxeF436QA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWBk58dCBrAOckYUmMlrKZ9C5nTwfDf5sIpQibDZLVu4ghMT2iabG9S5zQE3u1Yu6lOSEz3zsG/4MD6TUgCe6kRG8BNXMD/WVo9v6zYuMFLZDfTpMl8tMDMu16AhzZZ6FjhZGCaA50pzg06rDXoNRsyiSCYycpWh2K8O70IXpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gx2NzsEH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715958960; x=1747494960;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6SGRzemzE222vlrc/5jANNd2vwMs0qyJ0hvxeF436QA=;
  b=Gx2NzsEHBwqaqqkpa1B63TuzUcem3cJCbWOHPZuq5lRgAkxvwA5pUHy1
   5eVFIL88CkwlpvqCj9mn4ATu0aE+jIeOwSZ8E42r55KgSf2nGAZop2gaC
   qzKzZZhag9rQVKgYz++bh0Ea4l8zZn1+ZEGxhzCqlkiFAiuryGHhWMkTl
   pcNbhOp2jzgK9KUu6TvZ+NOB/+0E3EhQSYj9mKlqe94VuewxXQdiopff9
   AxV6j+zX9vg9xDUURVdqxJ5G0wB6gBCP8J6JV+p8xEPhfWU1F5rEUn/Xp
   onUFcdroO1bGSKk2A5Sw07cqgh4O7V0m0GcuXFnr55HPYKkFg5pX3ZoWf
   g==;
X-CSE-ConnectionGUID: FQrkQWcVSCmaTr1yWS4YJQ==
X-CSE-MsgGUID: tfjDikL/Q9WrGHzas6TmGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="23279378"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="23279378"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:15:59 -0700
X-CSE-ConnectionGUID: Tb8kRrpgRgSE/FtMnbu54w==
X-CSE-MsgGUID: 1WreihPMQVOPVhn5DjrZag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31743028"
Received: from velpulaa-mobl3.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.227.54])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:15:59 -0700
Message-ID: <9293c51c7d502843bfff90c5664be00bfe112e8d.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Hans de Goede
	 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, 
	error27@gmail.com
Date: Fri, 17 May 2024 08:15:58 -0700
In-Reply-To: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-17 at 07:49 -0700, Harshit Mogalapalli wrote:
> In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being freed.
> Fix this by reordering the kfree() post the dereference.
>=20
> Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned
> systems")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> v1->v2: Add R.B from Hans and fix commit message wrapping to 75
> chars.
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


