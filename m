Return-Path: <linux-kernel+bounces-222037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FAB90FBE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B509284939
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5362BAF3;
	Thu, 20 Jun 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Bm2UzDzt"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF42230F;
	Thu, 20 Jun 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856748; cv=none; b=SToClQ6wATn3M0GnS+8IiqOMvT7NfCVmUjih/JTQFXmHmsO/0ORrzjGp2oAQxLz7EDXHCLH/WwIfSvrYMGG2S6x4hDEKtqP3hsJaDmhub6HOLk4GIl7MnKVJWrC2jgFlp3bUH9IFYvIcKu//SXHYBAQXssfAP9QT9RT7KTH794U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856748; c=relaxed/simple;
	bh=vQaW55DmtGePf4eGnJYX06yy4tM3bf4Sc6nVqjUHZ+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE+KVbpRaVnsPE5fRoZN49wEKUlsiT9H2XJNSp8pMXg3LW1BPWJbixy6+LyLtjCO5PFCdnaQq3m60WgO5W1+U+Tts5iSu1pP0HtIitTOTtj4ehx4caXUafSqqfk73kqJstqVlnM76+7La7MwN/nxsK9ZZF8q+OgW//owd9v06f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Bm2UzDzt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K2BN80011674;
	Wed, 19 Jun 2024 21:12:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rl5w2pkRDEESVU7+xLhhQfbli
	58CwfHcSuehWCZKp08=; b=Bm2UzDztj7Q6uScrYq+Iw+9BKKZVZhH9qdWjuJP0j
	ajdyJ9Vw5Bcs2NQp+WavnW5bVxeEJOujiooYjSa0gVnGHT7nY63FAjUiskw1xH87
	JrrFKD1CFlz6z06FqhaHWgKOXfovl8IO6CL8DQb+0IeEK9V2/NsrJPilM4sIr+xr
	eFM94eb6QcDTvPWam0LwT1+kGFMEUDvh31NY2VcicGRB5tZrv45vNUWguKlVPfxK
	wtmZqy0jkhugWwlHQf91cCXSyBl0WY645aNqAlroWey1pwq1wjLc1mFykdzcPeau
	eucsKDuNSoEWorQX/F8t8GX9ilNtTr7UFhkAp/61O3K/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yvbdy89g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 21:12:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 21:12:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 21:12:17 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 9C8DC3F7078;
	Wed, 19 Jun 2024 21:12:13 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:42:12 +0530
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
Subject: Re: [PATCH v9 3/7] coresight: core: Add provision for panic callbacks
Message-ID: <20240620041212.GD125816@hyd1403.caveonetworks.com>
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-4-lcherian@marvell.com>
 <739d24fc-b557-4ef9-875d-d1a800f6c4db@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <739d24fc-b557-4ef9-875d-d1a800f6c4db@arm.com>
X-Proofpoint-ORIG-GUID: MJ1kf9lziui8jwzNy0I1ANNdGu6gm4sg
X-Proofpoint-GUID: MJ1kf9lziui8jwzNy0I1ANNdGu6gm4sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_01,2024-06-19_01,2024-05-17_01

On 2024-06-05 at 21:39:17, James Clark (james.clark@arm.com) wrote:
> 
> 
> On 05/06/2024 09:17, Linu Cherian wrote:
> > Panic callback handlers allows coresight device drivers to sync
> > relevant trace data and trace metadata to reserved memory
> > regions so that they can be retrieved later in the subsequent
> > boot or in the crashdump kernel.
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > Reviewed-by: James Clark <james.clark@arm.com>
> > ---
> > Changelog from v8:
> > Added Reviewed-by tag.
> > 
> >  drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++++++++
> >  include/linux/coresight.h                    | 12 +++++++
> >  2 files changed, 49 insertions(+)
> > 
> 
> [...]
> 
> >  static int __init coresight_init(void)
> >  {
> >  	int ret;
> > @@ -1377,6 +1408,10 @@ static int __init coresight_init(void)
> >  	if (ret)
> >  		goto exit_bus_unregister;
> >  
> > +	/* Register function to be called for panic */
> > +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> > +					     &coresight_notifier);
> > +
> 
> ret isn't checked here

Ack.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

