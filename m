Return-Path: <linux-kernel+bounces-222038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5F90FBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BFE1F2196E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142972B9DB;
	Thu, 20 Jun 2024 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DGr7OTGN"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82562230F;
	Thu, 20 Jun 2024 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856883; cv=none; b=Ew4YtmpbJgvL5NSjSXnK2+qvQfISMED61Ws9O2LMX2XHQqR2WUqMTU+uLjsSDrxD1/Fm40KsZFYqdeaRrRUo23u2/yoABqbpV85B8IaL1zKaC/3RTnomRIhNmzIITsSi0qU0bpnumt0+3bVl74ijVUr4w4IoAySO2cM0HQ71smI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856883; c=relaxed/simple;
	bh=YQIn1MkMpj7lY0d17NP7sN5KihKvvgi0NIlPgb28b98=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6R/Uo/NWeqjaxkl/j1kIU0pNYYvZynpONnSH2egsdU8GAnTEHz0xoIje6JJ+CqsMr1qsVSmqj8BYMz5xK0o5g0HGyPoI1RoiiaZIDWZ1LcNErekDIaHkS9aztENWb1ZWEjggZ+SZQO8LrbSU11ApQ5YyPFw/OOUzv9lTE+2S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DGr7OTGN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K2BDqK011177;
	Wed, 19 Jun 2024 21:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=SgSc/yGNsoojtkr4IzPFWAM/9
	qskkZPIOilqTLxkI50=; b=DGr7OTGNieTX72350G3XDFBcweuuO4cI1vG02Qx/N
	Pq30xy1eN7lrccD9Hbd74fQGfeTP7oQGBiRVlXhWTjLnT+hti1MdlURUWSSAbzRN
	v+Kz4aoG4NX3mP3gBKPFCGP8oG044ov/Qwo9B5n2BJp4GHJJ44CcNaBO4e64dN/R
	L4stgCxvo2j/iNNbKt9iGy1r4oKTdI2T48OsAdnL1TNlZhMZgKMdDKEC6POr56of
	I+Qb5jtXztzfp7o6df4+uc/RqQiIq/4C0MxjUYZLP6f/LmuLGA4kVpu8O592Z4VE
	I+/XDmxgCApAZFD4clStPbrdv4Yam9/NLkusXq2ItO7FA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yvbdy89nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 21:14:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 21:14:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 21:14:30 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 74B3B3F7062;
	Wed, 19 Jun 2024 21:14:26 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:44:25 +0530
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Anil Kumar Reddy <areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
Subject: Re: [PATCH v9 5/7] coresight: tmc: Add support for reading crash data
Message-ID: <20240620041425.GE125816@hyd1403.caveonetworks.com>
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-6-lcherian@marvell.com>
 <1b0c8c7e-2cf2-49a9-9120-3ced46f2df08@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b0c8c7e-2cf2-49a9-9120-3ced46f2df08@arm.com>
X-Proofpoint-ORIG-GUID: IHPwesqrCBc5RZTccJ_VODNiKAGbJONw
X-Proofpoint-GUID: IHPwesqrCBc5RZTccJ_VODNiKAGbJONw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_01,2024-06-19_01,2024-05-17_01


Hi James,



On 2024-06-05 at 16:00:39, James Clark (james.clark@arm.com) wrote:
> 
> 
> On 05/06/2024 09:17, Linu Cherian wrote:
> > * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
> >   captured in previous crash/watchdog reset.
> > 
> > * Add special device files for reading ETR/ETF crash data.
> > 
> > * User can read the crash data as below
> > 
> >   For example, for reading crash data from tmc_etf sink
> > 
> >   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> > 
> 
> Hi Linu,
> 
> I think you are missing the removal of the new crash file when the
> device is unloaded.
> 
> If you reload the module you get some errors:
> 
>   # rmmod coresight_tmc
>   # modprobe coresight_tmc dyndbg=+p
> 
>   kobject: kobject_add_internal failed for crash_tmc_etf0 with -EEXIST,
>     don't try to register things with the same name in the same
>     directory.
>   coresight tmc_etf0: Failed to setup user interface for crashdata
>   sysfs: cannot create duplicate filename '/devices/virtual
>    /misc/crash_tmc_etr0'
> 
> I'm not sure if it's related, but there are also some kasan errors at
> the same time which I haven't seen before:
>


Okay, somehow i missed testing with modules. Will fix those.


>   BUG: KASAN: slab-use-after-free in strcmp+0x94/0xd0
>   Read of size 1 at addr ffff00080b271be0 by task modprobe/570
>   CPU: 2 PID: 570 Comm: modprobe Not tainted 6.9.0-rc4+ #71
>   Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno


Okay. Will check if its reproducible and related.

Thanks.


>     Development Platform, BIOS EDK II Oct 19 2019
>   Call trace:
>    dump_backtrace+0x100/0x158
>    show_stack+0x24/0x38
>    dump_stack_lvl+0x3c/0x98
>    print_report+0x178/0x508
>    kasan_report+0xc0/0x120
>    __asan_report_load1_noabort+0x20/0x30
>    strcmp+0x94/0xd0
>    cti_add_assoc_to_csdev+0x174/0x430 [coresight_cti]
>    coresight_register+0x414/0x500 [coresight]
>    __tmc_probe+0xd40/0x1340 [coresight_tmc]
>    tmc_probe+0x60/0x98 [coresight_tmc]
>    amba_probe+0x604/0x838
>    really_probe+0x318/0x780
>    __driver_probe_device+0x168/0x318
>    driver_probe_device+0x78/0x2a0
>    __driver_attach+0x22c/0x538
>    bus_for_each_dev+0x1bc/0x1f0
>    driver_attach+0x54/0x70
>    bus_add_driver+0x2a8/0x4c0
>    driver_register+0x168/0x2b8
>    amba_driver_register+0x74/0x98
>    coresight_init_driver+0x34/0xa8 [coresight]
>    init_module+0x34/0xfb8 [coresight_tmc]
>    do_one_initcall+0x1a0/0x8d0
>    do_init_module+0x1f8/0x588
>    load_module+0x3c20/0x44c0
>    __arm64_sys_finit_module+0x3c8/0x638
>    invoke_syscall+0x78/0x218
>    el0_svc_common+0x160/0x1d8
>    do_el0_svc+0x50/0x68
>    el0_svc+0x4c/0xc0
>    el0t_64_sync_handler+0x84/0x100
>    el0t_64_sync+0x190/0x198
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

