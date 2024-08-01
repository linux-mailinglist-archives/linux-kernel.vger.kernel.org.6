Return-Path: <linux-kernel+bounces-271796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF894534D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973F6B26662
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F72149C5E;
	Thu,  1 Aug 2024 19:24:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC6713D8B2;
	Thu,  1 Aug 2024 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540246; cv=none; b=Z9rZfVPqQoPsCVpzNxxLX1UfwFdceVosycAHvnDbhnE6OkkPIeaVRtaTU3j625P3IdQa2JeX4sqhcKftid1kv00cWhSayr3N2CqgnxwnkBPFWgA11RJPTapeXplnx0AhmnGo+NrUQz115NpANlMaM9nO+A7JfuSNQMtutLmYq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540246; c=relaxed/simple;
	bh=nVaGm30wehDUSM+FZVnkyp3r6UoMaU+Lyu8afDcjiPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj7RhGkRak+VMWLC1UMVlXm2Ko6yTYEohDW+bxeOb/QacFF8yrQVEg2XUFzb4tj2+2icSPT6FP79Lr8xsPwWdgUqsIRFY8HKJ6xHqTWp7K9dQ2Huhp9zdTaAG87UrBAIO/z01ir9jkhM6BJwbkHOjjcwPyEnfM4/IANKFlMi+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F356E1007;
	Thu,  1 Aug 2024 12:24:29 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2403F64C;
	Thu,  1 Aug 2024 12:24:02 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:23:59 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, devicetree@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, robh@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v1 0/6] Add SCMI transport descriptors
Message-ID: <ZqvgzwDtxdOuM1WJ@pluto>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
 <9c476b12-a4ca-43f7-875a-eb0a1032c494@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c476b12-a4ca-43f7-875a-eb0a1032c494@quicinc.com>

On Thu, Aug 01, 2024 at 12:17:36PM -0700, Nikunj Kela wrote:
> 
> On 7/30/2024 7:47 AM, Cristian Marussi wrote:
> > Hi,
> >
> > this small series is an extended version of this recent, already reviewed,
> > series [1] posted by Peng to add a new arm,scmi property to describe some
> > platform-specific SCMI timeout constraints.
> >
> > On top of that, this adds 2 more properties to describe a couple more
> > platform-specific transport characteristics.
> >
> > To minimize conflicts, the whole series is based on top of another recent
> > series, which represents a rework of the core SCMI stack to split SCMI
> > transports as standalone drivers. [2]
> >
> > Thanks,
> > Cristian
> >
> > [1]: https://lore.kernel.org/linux-arm-kernel/20240709140957.3171255-1-peng.fan@oss.nxp.com/
> > [2]: https://lore.kernel.org/linux-arm-kernel/20240730133318.1573765-1-cristian.marussi@arm.com/T/#t
> >
> > ---
> 
> Thanks Cristian for the series. I have validated them on Qualcomm
> SA8255p(to be upstreamed) Ride platform.
> 

Thanks for testing...does this solves your issues ?
(assuming that will go through as it is ...)

Cristian

