Return-Path: <linux-kernel+bounces-544766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBCA4E4E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FC17F845
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4A28D049;
	Tue,  4 Mar 2025 15:41:01 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617F280CFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102860; cv=fail; b=E2mk3aq3iKAvXdRFes7su0JFvETK7v2WCkYFa657fBdc6A76aZiM3SLvldqzyCwASEh+6LupNwNL8cHVt/uJM4rv4pReMdjUHoDkpj99Psc+e+P56A9PbDUeeXR1Vc3I6UDw1+zpV0ll4SQXoOPXhBWBx3gblFCGalg0L6ttyUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102860; c=relaxed/simple;
	bh=FoX4PlmAfW5XQloU1QHbG5tBBFvNZA2tVcUGlZ4kVBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLrJfNtdmeLZ5FHF5C4rRi1wF5kTXpmGCvEBow1/KzW9YgCTLKZzZF24UHdT1S9y8Welf8ZI/0LE2S2HydylnMDsrSnKnApLYgmxdHwUts2TtJWNwVvUz6zdQmUm18DGhO0yxn85hMuXNfOqsJ530Psquhn32lYYY6E+Zww8qjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 20E9F40D4DEA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:40:57 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fwf0kY5zG0tB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:38:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 67CB042722; Tue,  4 Mar 2025 18:38:35 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541383-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 851B742EBD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:33:28 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 5CC2E2DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:33:28 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A3E18947A1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DCC1F3D50;
	Mon,  3 Mar 2025 10:31:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE71F3D44
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997871; cv=none; b=BN1G8emrX5P8MhIxQYQoJTF1bXjMMBuRFtIf61edrq3DNE5Kc5V+yZO7YJkqaMmyFoHMDapM6zDkUtHMUIw5/AP22XZAyq72hn/sR+o9ZFPlZw1PkEvp+xbv8dymCxnrQC3hixIQr3ygPsmrG9YI1MbX3UgARuW/WueHycMaf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997871; c=relaxed/simple;
	bh=rgzwGH5cEjTRq3vGnAFZZRUFPP20k51i8X7R7tFsVDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJT+9QkJx1geOz6qJQCAoHH2gIy0Z94+rFC9+gcVVAsKMD37B0jyIYGLgpLFkXA7ngy2r7OXeCpWjcX71mIatWHTU3Hudvvm+o93Ttq77sjcFTmMWZ+TASkMGjUiVQ/KL/1CQ0ETnk6c0goMKpC9Lh5Ac1ERbEomhcKO0wIZJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6621C113E;
	Mon,  3 Mar 2025 02:31:22 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3C423F66E;
	Mon,  3 Mar 2025 02:31:04 -0800 (PST)
Date: Mon, 3 Mar 2025 10:31:02 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250303103102.GC13345@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b23aa37f8e864dea82a6143bece912d6@huawei.com>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fwf0kY5zG0tB
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707564.32749@IhspBhL1bdcUQcbrV8O5bg
X-ITU-MailScanner-SpamCheck: not spam

Hi Both,

Thanks for review and for checking other implementations for this
discrepancy.

On Mon, Mar 03, 2025 at 08:49:02AM +0000, Shameerali Kolothum Thodi wrote=
:
>=20
>=20
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Friday, February 28, 2025 7:32 PM
> > To: Miko=C5=82aj Lenczewski <miko.lenczewski@arm.com>; Shameerali Kol=
othum
> > Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: ryan.roberts@arm.com; suzuki.poulose@arm.com;
> > yang@os.amperecomputing.com; catalin.marinas@arm.com;
> > will@kernel.org; joro@8bytes.org; jean-philippe@linaro.org;
> > mark.rutland@arm.com; joey.gouly@arm.com; oliver.upton@linux.dev;
> > james.morse@arm.com; broonie@kernel.org; maz@kernel.org;
> > david@redhat.com; akpm@linux-foundation.org; nicolinc@nvidia.com;
> > mshavit@google.com; jsnitsel@redhat.com; smostafa@google.com; linux-
> > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > iommu@lists.linux.dev
> > Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
> >=20
> > On Fri, Feb 28, 2025 at 06:24:04PM +0000, Miko=C5=82aj Lenczewski wro=
te:
> > > For supporting BBM Level 2 for userspace mappings, we want to ensur=
e
> > > that the smmu also supports its own version of BBM Level 2. Luckily=
, the
> > > smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (D=
DI
> > > 0487K.a D8.16.2), so already guarantees that no aborts are raised w=
hen
> > > BBM level 2 is claimed.
> > >
> > > Add the feature and testing for it under arm_smmu_sva_supported().
> > >
> > > Signed-off-by: Miko=C5=82aj Lenczewski <miko.lenczewski@arm.com>
> > > ---
> > >  arch/arm64/kernel/cpufeature.c                  | 7 +++----
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
> > >  4 files changed, 13 insertions(+), 4 deletions(-)
> >=20
> > This patch looks good, for what it does. However for bisection safety
> > it should be earlier, before the patches that change the page table
> > algorithms to be unsafe for the SMMU.

Right, I should have noticed this earlier. Will reorder the patch.

> > However, I've heard people talking about shipping chips that have CPU=
s
> > with BBML2 but SMMUs without.
> >=20
> > On such a system it seems like your series would break previously
> > working SVA support because this patch will end up disabling it?

Perhaps my understanding is flawed here, but I was under the impression
that with SVA both the core and smmu MUST support BBML2 to use it safely
for core translations? Otherwise the smmu might experience page faults
when it touches pages from the core that use BBML2, if it does not
support BBML2 itself? Again, I could very well be wrong, will double
check with the reference manuals.

> > Though I see your MIDR_REV list is limited, so perhaps that worry
> > doesn't effect any real chips made with those families? I am trying t=
o
> > check some NVIDIA products against this list..

Hopefully, as you say, the MIDR list restricts the breakage to a limited
(ideally, zero-size) set of implementations which advertise BBML2
without conflict aborts, but which do not support BBML2 on the smmu.

However, if my understanding of the BBML2 feature and how it interacts
with SVA is flawed, this will obviously be something for me to fix.

> We do have implementations that support CPUs with BBLM2 with TLB
> conflict aborts and SMMUv3 with BBML2.  So don't think those platforms
> be affected by this.  Will check with our hardware folks if there is
> anything that will be affected by this.
>=20
> Also we  have plans to try to use SMMUv3 BBML2 during VM live migration
> to split block pages to 4K. I guess, in that case we can enable SMMU BB=
ML2
> independent of CPU side.
>=20
> Thanks,
> Shameer

On independently enabling BBML2 on the smmu but not the CPU, this should
be possible. My check was intended to catch the case where the CPU is on
the MIDR allowlist, but the smmu does not support the feature. Whilst
this might still be bad logic, if it is correct, then as long as the CPU
is not in the allowlist sva should not be affected. And bbml2 itself on
the smmu should be safe regardless, as it is stricted than the
corresponding cpu-side feature.

--=20
Kind regards,
Miko=C5=82aj Lenczewski


