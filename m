Return-Path: <linux-kernel+bounces-245574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E892B481
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D56D1C21D20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAA9155CB2;
	Tue,  9 Jul 2024 09:55:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E312E1F1;
	Tue,  9 Jul 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518956; cv=none; b=rJj6JuA4JAW00hkYbOLKRx6ciWLKTaQqzWVDq6FHyWVgTBWgDKvGxAtG9BU7pKpsrjUTaOINpxbWNLGP/1ZcX7qkG69nVqnhLCNlx8/XgEH+pM3B+HuH9GTg+20ViNCWAFEcbSjyZKBG8vikRxhwrf6lWo+dfkL4sEkPTbiDCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518956; c=relaxed/simple;
	bh=GCS1KUGFPktHLLRRHrFy8MVUE0CMFLsivV64i/DKgks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZQ1aYmjztXi6HbFqG5n9fa2i7/U1mviS7H1S6y/zJ4UNpZqiEIO4XdOxUgY4YKjJnMpkD7Bvy+a9bstPmzlKJF9NLqBFvQ1Oig8fSPWMygUB4mTTs+RuhOAth0AJtthfgazLrwTYQPqH+AY+Ruh79D5YV1fzE/rFf4T2w30d14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4FE91650;
	Tue,  9 Jul 2024 02:56:18 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D54B03F762;
	Tue,  9 Jul 2024 02:55:50 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:55:42 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH 6/8] firmware: arm_scmi: Make OPTEE transport a
 standalone driver
Message-ID: <Zo0JHtuZo_tKEMzP@pluto>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
 <20240707002055.1835121-7-cristian.marussi@arm.com>
 <e27dc456-33bc-450e-8e54-1cd5b7ae11ef@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27dc456-33bc-450e-8e54-1cd5b7ae11ef@suswa.mountain>

On Tue, Jul 09, 2024 at 04:21:46AM +0200, Dan Carpenter wrote:
> On Sun, Jul 07, 2024 at 01:20:53AM +0100, Cristian Marussi wrote:
> >  static int scmi_optee_service_probe(struct device *dev)
> >  {
> >  	struct scmi_optee_agent *agent;
> > @@ -555,7 +553,7 @@ static int scmi_optee_service_probe(struct device *dev)
> >  	smp_mb();
> >  	scmi_optee_private = agent;
> >  
> > -	return 0;
> > +	return platform_driver_register(&scmi_optee_driver);

Hi Dan,

thanks for having a look !

> 
> There needs to be some cleanup if platform_driver_register() fails.
> 


Yes, indeed....also smatch/sparse screamed a lot in some other
places...I will rework in V2.

Thanks,
Cristian

