Return-Path: <linux-kernel+bounces-181170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950398C7867
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D231F23125
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28314A4D7;
	Thu, 16 May 2024 14:26:23 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E4149DFB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869583; cv=none; b=P0qYq2e0p0LC1rq2M1QmHFoLruvmssiHk49WpTLioot+R+QolYKg0675D6EbfdDN3NMj/5xGx+CH577ItknvTYdDe5Scvr/yat++/OSFDC0IdgkUaUPZl/YM/ezBtNtg6+EuRKkN5R7/W+6OMxU5YFoi01uzyQDEE+Tfhy5T3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869583; c=relaxed/simple;
	bh=ZzE4IugBYkyPpxD2g5Mg3atg5gahwJi7Wb+GI0B19U0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr4lgI6hpUUGWRSUj4b6KHFHkR+fVAhL897Zd1HOy6I2EKzl6wT9P/Pe+7nAv2J0rbL6l0+SOHnkvNZUWSw49zEGfSu/mXPJbcU72TCQcSuqhsLpyl/SjPMjRVQbdPPAFbjDtR1wZZwNtREcmtnrb67QAjgQd6J9CWlsgKTuqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cn10ka; spf=pass smtp.mailfrom=marvell.com; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cn10ka
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G40GAs017382;
	Thu, 16 May 2024 07:25:41 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y5aqxspy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 07:25:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 May 2024 07:25:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 May 2024 07:25:40 -0700
Received: from cn10ka (unknown [10.106.49.40])
	by maili.marvell.com (Postfix) with SMTP id A9B0B3F7069;
	Thu, 16 May 2024 07:25:39 -0700 (PDT)
Date: Thu, 16 May 2024 07:25:39 -0700
From: Tanmay Jagdale <tj@cn10ka.smtp.subspace.kernel.org>
To: Will Deacon <will@kernel.org>
CC: Tanmay Jagdale <tanmay@marvell.com>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <nicolinc@nvidia.com>, <mshavit@google.com>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
        <set_pte_at@outlook.com>, <smostafa@google.com>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>, <gakula@marvell.com>,
        <jcm@jonmasters.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <ZkYWbhTOEBu5vUVk@cn10ka>
References: <20240425144152.52352-1-tanmay@marvell.com>
 <20240430150950.GD14187@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430150950.GD14187@willie-the-truck>
X-Proofpoint-GUID: bRpFxqrbi4G_SI4aKqjFXb7lumX-n6Vy
X-Proofpoint-ORIG-GUID: bRpFxqrbi4G_SI4aKqjFXb7lumX-n6Vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

Hi Will,

On Tue, Apr 30, 2024 at 04:09:50PM +0100, Will Deacon wrote:
> On Thu, Apr 25, 2024 at 07:41:50AM -0700, Tanmay Jagdale wrote:
> > Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> > support for SMMU ECMDQ feature.
> > 
> > Tested this feature on a Marvell SoC by implementing a smmu-test driver.
> > This test driver spawns a thread per CPU and each thread keeps sending
> > map, table-walk and unmap requests for a fixed duration.
> > 
> > Using this test driver, we compared ECMDQ vs SMMU with software batching
> > support and saw ~5% improvement with ECMDQ. Performance numbers are
> > mentioned below:
> > 
> >                    Total Requests  Average Requests  Difference
> >                                       Per CPU         wrt ECMDQ
> > -----------------------------------------------------------------
> > ECMDQ                 239286381       2991079
> > CMDQ Batch Size 1     228232187       2852902         -4.62%
> > CMDQ Batch Size 32    233465784       2918322         -2.43%
> > CMDQ Batch Size 64    231679588       2895994         -3.18%
> > CMDQ Batch Size 128   233189030       2914862         -2.55%
> > CMDQ Batch Size 256   230965773       2887072         -3.48%
> 
> These are pretty small improvements in a targetted micro-benchmark. Do
> you have any real-world numbers showing that this is worthwhile? For
> example, running something like netperf.
We are running benchmarks on the latest kernel with and without ECMDQ.
We will share the performance numbers and observations here.

With Regards,
Tanmay
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

