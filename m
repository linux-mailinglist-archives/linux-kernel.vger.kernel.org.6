Return-Path: <linux-kernel+bounces-441194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00C9ECAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1188C18893CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10533211A03;
	Wed, 11 Dec 2024 11:13:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4195153BF6;
	Wed, 11 Dec 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915582; cv=none; b=sr0ghDwsUryXBh8BYqY+JuoL+zFftp6BpH5WSDfA/uOoxw8hMd6D7xltuPB5M9/YceX2qYvxEBdUYUFZXpXVtfytkCmo1IjiA2yMxyGBUc3fNLO+6/CjGeq8fI/Q2lOem6a0HeIYRj0NooETFqZu01pr2llKMdRqLgE0M7oJLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915582; c=relaxed/simple;
	bh=pwaXnwScMmWVtE9kXWSbyvAjg7nJ7o8fdfHIiQ/5UQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwoF886akdquetLYlYT4USm/jr2vSjvbBxhCtD6Doy+LusjNx520fxGhirrfs54EFsJmKdcwWzC6iIp7ei3HDutroWM4T1m09x8Uo9IJr0jlXSzFk4hiy+NFI4HJHDFR8pd68o/HRiYRPCj7ANKpWUZ3PzyqVRlxRTwWp0Io65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7Xx940vqz67CvH;
	Wed, 11 Dec 2024 19:11:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ADE7140113;
	Wed, 11 Dec 2024 19:12:51 +0800 (CST)
Received: from localhost (10.48.156.16) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 12:12:50 +0100
Date: Wed, 11 Dec 2024 11:12:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "
 =?ISO-8859-1?Q?N=EDcolas?= \"F. R. A. Prado\"" <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <20241211111247.00003a05@huawei.com>
In-Reply-To: <OSZPR01MB690841B2D3522EC863F10800D4242@OSZPR01MB6908.jpnprd01.prod.outlook.com>
References: <20241108054006.2550856-1-fj5100bi@fujitsu.com>
	<20241108054006.2550856-2-fj5100bi@fujitsu.com>
	<20241108141911.00003e14@huawei.com>
	<OSZPR01MB690841B2D3522EC863F10800D4242@OSZPR01MB6908.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > > +device_initcall(register_fujitsu_mac_pmu_driver);
> > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > > index 2361ed4d2b15..e6e49e09488a 100644
> > > --- a/include/linux/cpuhotplug.h
> > > +++ b/include/linux/cpuhotplug.h
> > > @@ -227,6 +227,7 @@ enum cpuhp_state {
> > >  	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
> > >  	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
> > >  	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> > > +	CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,  
> > 
> > Can this use CPU_AP_ONLINE_DYN
> > or are there some ordering contraints?  
> 
> It follows the same principles as other PMU drivers.

Some of them and I suspect the is cut and paste rather than justified.
+ Not sure how long the dynamic part has been available.

> 
> >   
> > >  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
> > >  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
> > >  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,  
> 
> Best Regards,
> Yoshihiro Furudera


