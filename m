Return-Path: <linux-kernel+bounces-367780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E00759A06BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EE9B280E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B2206071;
	Wed, 16 Oct 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RAodgloz"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C529A0;
	Wed, 16 Oct 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073494; cv=none; b=qUlq70OBAx3fSDwf6wKMz/Z1eEEjwq9qKgpB7UGgB7EhWI+wR0T/uDxM7Qr6TdpkRKAkWXP3cpIGtS+Ds+6FvKC/pmU6jFqq0iD0lNSPHe6rq9Vuw30JolV9mjB1QZezTWnZng/4rWd7z/XBDVOY/eMDJBv4kVX6b2oLmWeGXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073494; c=relaxed/simple;
	bh=F2kJZIzZm26i8nnqK2Ymt2aisFINAhBthb4LO9ij7Cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9oIFrbmnPihAJz89klfxT37w5QGVOeZAjC4IjGnH0KcywBJMncjEeSFKHBUk9RqCmk+ZMlFMuJNQg7SXiFGkbRy9vcMv2c8bGDknzESc1wkxZq+dubsXc2pWkEKwHlNXuMNnjSY65eBSaHV2sKyGS+0ILzZyBeNJH+8vbHvdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RAodgloz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G98fH1024811;
	Wed, 16 Oct 2024 03:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=OdX0x+N0H55Ay6Jz5bU5yimxH
	ELv72e2HNowzA8u8rE=; b=RAodglozRbh8qsMdvhKJ3TpQCYLOUv9ZwhsSAu2Ts
	P3iEvouPQXqOEQW4t7OR3rI5I+dELCzpfsUA5beVUHGho0Q496X4mBc4cWIT1DTT
	2wvuGHp0a9vfDSo+/CNKN3UgZXwtJ3zjNTRjhFK42TNN/1KyYRGLFyvcUXZ7LL7p
	eyOBUNX0rb4fVuCVH7VRspzsBcM5VlcSuO2ioYQLpvU2co24h85KchSkhFZmOeWK
	wxsrNHIc+8xTFQuk2yf5yv9KqlXpIhB++0Im/Ac7piGNUMuxLDOFHVyKmYxtE7el
	nj3qeBeKpRxZBr1pgCzwyHdxkDxoW96YJ0VOs4JAc13mw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42aaker42n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 03:11:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 03:11:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 03:11:19 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 59C673F7053;
	Wed, 16 Oct 2024 03:11:15 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:41:14 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH v10 7/8] coresight: config: Add preloaded configuration
Message-ID: <20241016101114.GB896339@hyd1403.caveonetworks.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-8-lcherian@marvell.com>
 <53b80d4d-31f2-4abf-a0ef-f194c63280dc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53b80d4d-31f2-4abf-a0ef-f194c63280dc@arm.com>
X-Proofpoint-GUID: ANgnaqkchMdM9Bjcodfn68jla00mTR0d
X-Proofpoint-ORIG-GUID: ANgnaqkchMdM9Bjcodfn68jla00mTR0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

On 2024-10-03 at 18:59:30, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> On 16/09/2024 11:34, Linu Cherian wrote:
> > Add a preloaded configuration for generating
> > external trigger on address match. This can be
> > used by CTI and ETR blocks to stop trace capture
> > on kernel panic.
> > 
> > Kernel address for "panic" function is used as the
> > default trigger address.
> > 
> > This new configuration is available as,
> > /sys/kernel/config/cs-syscfg/configurations/panicstop
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > Reviewed-by: James Clark <james.clark@arm.com>
> > ---
> > Changelog from v9:
> > No changes
> > 
> >   drivers/hwtracing/coresight/Makefile          |  2 +-
> >   .../coresight/coresight-cfg-preload.c         |  2 +
> >   .../coresight/coresight-cfg-preload.h         |  2 +
> >   .../hwtracing/coresight/coresight-cfg-pstop.c | 83 +++++++++++++++++++
> >   4 files changed, 88 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c
> > 
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index 4ba478211b31..46ce7f39d05f 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -25,7 +25,7 @@ subdir-ccflags-y += $(condflags)
> >   obj-$(CONFIG_CORESIGHT) += coresight.o
> >   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> >   		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> > -		coresight-cfg-preload.o coresight-cfg-afdo.o \
> > +		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
> 
> Please could you only build it when ETM4X is selected ? That way you
> could drop the "CONFIG" check in the code ?

coresight-cfg-pstop feature follows the approach taken in existing
features like preload, afdo etc. Hence, shall we keep the same format ?
Please let me know if you think otherwise.


> >   		coresight-syscfg-configfs.o coresight-trace-id.o
> >   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> > diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> > index e237a4edfa09..4980e68483c5 100644
> > --- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
> > +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> > @@ -13,6 +13,7 @@
> >   static struct cscfg_feature_desc *preload_feats[] = {
> >   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> >   	&strobe_etm4x,
> > +	&gen_etrig_etm4x,
> >   #endif
> >   	NULL
> >   };
> > @@ -20,6 +21,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
> >   static struct cscfg_config_desc *preload_cfgs[] = {
> >   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> >   	&afdo_etm4x,
> > +	&pstop_etm4x,
> >   #endif
> >   	NULL
> >   };
> > diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> > index 21299e175477..291ba530a6a5 100644
> > --- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
> > +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> > @@ -10,4 +10,6 @@
> >   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> >   extern struct cscfg_feature_desc strobe_etm4x;
> >   extern struct cscfg_config_desc afdo_etm4x;
> > +extern struct cscfg_feature_desc gen_etrig_etm4x;
> > +extern struct cscfg_config_desc pstop_etm4x;
> >   #endif
> > diff --git a/drivers/hwtracing/coresight/coresight-cfg-pstop.c b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
> > new file mode 100644
> > index 000000000000..c2bfbd07bfaf
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
> > @@ -0,0 +1,83 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(C) 2023  Marvell.
> > + * Based on coresight-cfg-afdo.c
> > + */
> > +
> > +#include "coresight-config.h"
> > +
> > +/* ETMv4 includes and features */
> > +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> 
> Could we not drop this check, if we only build it when
> CONFIG_CORESIGHT_SOURCE_ETM4X is selected. It is not useful
> otherwise anyways.


IIUC, this arrangement might be helpful to add register
configurations for future ETM versions in the same file.


> 
> Rest looks fine to me
> 
> Suzuki
> 
> 
> > +#include "coresight-etm4x-cfg.h"
> > +
> > +/* preload configurations and features */
> > +
> > +/* preload in features for ETMv4 */
> > +
> > +/* panic_stop feature */
> > +static struct cscfg_parameter_desc gen_etrig_params[] = {
> > +	{
> > +		.name = "address",
> > +		.value = (u64)panic,
> > +	},
> > +};
> > +
> > +static struct cscfg_regval_desc gen_etrig_regs[] = {
> > +	/* resource selector */
> > +	{
> > +		.type = CS_CFG_REG_TYPE_RESOURCE,
> > +		.offset = TRCRSCTLRn(2),
> > +		.hw_info = ETM4_CFG_RES_SEL,
> > +		.val32 = 0x40001,
> > +	},
> > +	/* single address comparator */
> > +	{
> > +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_64BIT |
> > +			CS_CFG_REG_TYPE_VAL_PARAM,
> > +		.offset =  TRCACVRn(0),
> > +		.val32 = 0x0,
> > +	},
> > +	{
> > +		.type = CS_CFG_REG_TYPE_RESOURCE,
> > +		.offset = TRCACATRn(0),
> > +		.val64 = 0xf00,
> > +	},
> > +	/* Driver external output[0] with comparator out */
> > +	{
> > +		.type = CS_CFG_REG_TYPE_RESOURCE,
> > +		.offset = TRCEVENTCTL0R,
> > +		.val32 = 0x2,
> > +	},
> > +	/* end of regs */
> > +};
> > +
> > +struct cscfg_feature_desc gen_etrig_etm4x = {
> > +	.name = "gen_etrig",
> > +	.description = "Generate external trigger on address match\n"
> > +		       "parameter \'address\': address of kernel address\n",
> > +	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
> > +	.nr_params = ARRAY_SIZE(gen_etrig_params),
> > +	.params_desc = gen_etrig_params,
> > +	.nr_regs = ARRAY_SIZE(gen_etrig_regs),
> > +	.regs_desc = gen_etrig_regs,
> > +};
> > +
> > +/* create a panic stop configuration */
> > +
> > +/* the total number of parameters in used features */
> > +#define PSTOP_NR_PARAMS	ARRAY_SIZE(gen_etrig_params)
> > +
> > +static const char *pstop_ref_names[] = {
> > +	"gen_etrig",
> > +};
> > +
> > +struct cscfg_config_desc pstop_etm4x = {
> > +	.name = "panicstop",
> > +	.description = "Stop ETM on kernel panic\n",
> > +	.nr_feat_refs = ARRAY_SIZE(pstop_ref_names),
> > +	.feat_ref_names = pstop_ref_names,
> > +	.nr_total_params = PSTOP_NR_PARAMS,
> > +};
> > +
> > +/* end of ETM4x configurations */
> > +#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */
> 
> 

