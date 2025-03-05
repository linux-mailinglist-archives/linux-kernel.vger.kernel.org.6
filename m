Return-Path: <linux-kernel+bounces-546321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A55A4F923
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69ACD3A6A44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900DD1FCFD3;
	Wed,  5 Mar 2025 08:50:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49F1FC7D1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164630; cv=none; b=W9780OtG1dpEqpFoujma1AuT8Ud5LiQyiiIVahw4QQTnGl6Pg/rp4VPGorxTgoSwYlk4IyC72CAtnian4MwzBJD6ZMKpu1E5joO9iIPujNUJuky0F1h7Uz8j1wIeZ4s6IzrKmWl6R38Tpqy2ssBx5f9yyjcEZFxa84+bYxlwPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164630; c=relaxed/simple;
	bh=9yMqqJpFRl1mhJQIRFycG3q2J7bCAVjeeOJl0b7GFFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fRkprcwzgXXhTnqpbzspqR09fyWMeBEm6karL+CuuXaIhLTEdRZi2ixpRviNKpeOUEo0TVzZufDpWTcxWI8LzzDs+7qUaWzeSUBvJ2TR6Ic63W110o6lRMPxeOzxfLmvdBjPfLkauDHnV+NSGwEX50KJM1QfgY1sHks7vvqrFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z75mV2Phgz6K9RV;
	Wed,  5 Mar 2025 16:48:10 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AECE14011D;
	Wed,  5 Mar 2025 16:50:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 09:50:17 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 5 Mar 2025 09:50:17 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
 arm_smmu_make_s2_domain_ste()
Thread-Topic: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
 arm_smmu_make_s2_domain_ste()
Thread-Index: AQHbjYw6xgWAQwMkG0OYeMfm+TEXTLNkOtMw
Date: Wed, 5 Mar 2025 08:50:17 +0000
Message-ID: <a95b39a55c324907a7001d3a2cdf076b@huawei.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
In-Reply-To: <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nicolin,

Thanks for sending out this series. This might as well help me to rework my=
 pinned KVM
VMID series here,
https://lore.kernel.org/linux-iommu/20240208151837.35068-1-shameerali.kolot=
hum.thodi@huawei.com/


> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 5, 2025 5:04 AM
> To: will@kernel.org; robin.murphy@arm.com; jgg@nvidia.com
> Cc: joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
> arm_smmu_make_s2_domain_ste()
>=20
> An stage-2 STE requires a vmid that has been so far allocated per domain,
> so arm_smmu_make_s2_domain_ste() has been extracting the vmid from
> the S2
> domain.
>=20
> To share an S2 parent domain across vSMMUs in the same VM, a vmid will
> be
> no longer allocated for nor stored in the S2 domain, but per vSMMU, which
> means the arm_smmu_make_s2_domain_ste() can get a vmid either from
> an S2
> domain (non nesting parent) or a vSMMU.
>=20
> Allow to pass in vmid explicitly to arm_smmu_make_s2_domain_ste(),
> giving
> its callers a chance to pick the vmid between a domain or a vSMMU.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 6 ++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c    | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 6 +++---
>  4 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bd9d7c85576a..e08c4ede4b2d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -887,7 +887,7 @@ struct arm_smmu_entry_writer_ops {
>  void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
>  void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  				 struct arm_smmu_master *master,
> -				 struct arm_smmu_domain *smmu_domain,
> +				 struct arm_smmu_domain *smmu_domain,
> u16 vmid,
>  				 bool ats_enabled);

Now that vmid is an input, do we need some kind of validation here as
at least vmid =3D 0 is reserved I guess for bypass STEs.

Thanks,
Shameer


