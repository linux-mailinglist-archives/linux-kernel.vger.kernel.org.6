Return-Path: <linux-kernel+bounces-171104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE508BDFCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FB0281618
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01613D26C;
	Tue,  7 May 2024 10:32:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA322064
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077941; cv=none; b=dBwOKLucCUL8rAuuLwplTDqVIVXzj+2XCpjnVpqTZGIhVe9WUNpm7FQnJz620lrIP+EAYqLCPau8CGdSx4VPfwRt8sRcILuigE0VsRuhCmWSFD4Mok6l+m4GQjBC6XifVn3hdx15iN2h9S5ML4jpfcL3nB5hzakiq+NbZ+xzJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077941; c=relaxed/simple;
	bh=u/BiEH3uaN9Y0kT7PVoWcpdxWQWEfIsnIh/Z0uYsUa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7L+hJ7vF42uGbR0Kprj/PNAp/pdiSGaVfRl8EBrPNSRMhpyJJ5P83bczRyyFOaP13HLLx5I0UBWB9QpDsmBdalmi+cW41kQ5Gtw644tFJlGwC8tp1llvYry+XqWhpOcZL1xQN5NwMMlINeDvcYDUF4qi9gG6p7pXv9Oo4Hkgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3FD51063;
	Tue,  7 May 2024 03:32:44 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5ECB3F587;
	Tue,  7 May 2024 03:32:17 -0700 (PDT)
Date: Tue, 7 May 2024 11:32:15 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, javier.carrasco.cruz@gmail.com,
	Sudeep Holla <sudeep.holla@arm.com>, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	skhan@linuxfoundation.org, conor@kernel.org
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
Message-ID: <ZjoDL6EkDcRf6hML@bogus>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
 <2024050102-reshuffle-licking-f84e@gregkh>
 <673df61a-e0f5-450b-8fb4-746bc950e3d1@gmail.com>
 <2024050148-dutiful-unsubtle-dbb1@gregkh>
 <2398ca58-eafc-46df-92c1-c03cd920fd06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2398ca58-eafc-46df-92c1-c03cd920fd06@gmail.com>

On Mon, May 06, 2024 at 05:30:49PM +0200, Vincenzo Mezzela wrote:
> 
> On 01/05/24 15:06, Greg KH wrote:
> > On Wed, May 01, 2024 at 02:33:39PM +0200, Vincenzo Mezzela wrote:
> > > On 01/05/24 12:48, Greg KH wrote:
> > > > On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
> > > > > Introduce the __free attribute for scope-based resource management.
> > > > > Resources allocated with __free are automatically released at the end of
> > > > > the scope. This enhancement aims to mitigate memory management issues
> > > > > associated with forgetting to release resources by utilizing __free
> > > > > instead of of_node_put().
> > > > > 
> > > > > The declaration of the device_node used within the do-while loops is
> > > > > moved directly within the loop so that the resource is automatically
> > > > > freed at the end of each iteration.
> > > > > 
> > > > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > > > Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> > > > > ---
> > > > >    drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
> > > > >    1 file changed, 21 insertions(+), 30 deletions(-)
> > > > How was all of this tested?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > Hi,
> > > 
> > > I just cross-compiled it for RISC-V to enable the config
> > > GENERIC_ARCH_TOPOLOGY
> > > and include arch_topology.c as well.
> > Cross-compile is nice, how about running it?
> > 
> > > Do you have any suggestion to trigger the affected code and perform some
> > > testing?
> > That is up to you to determine if you wish to modify it :)
> > 
> > thanks,
> > 
> > greg k-h
> Hi,
> 
> I've successfully run it on QEMU. There are no differences in the dmesg
> after applying the patches.
>

For this patch, dmesg delta may not be of any use.

> Furthermore, I've tracked the execution of the parse_dt_topology() which is
> calling all the functions that I've modified with the patches and I checked
> that of_node_put was correctly called at the end of each scope.
>

That should be good enough.

> Is there anything else that can be done to further testing this changes?
>

I don't think there is much we can test other than what you have done already.
If you fix the subject and any other comments me and others had suggested, I
am happy to Ack.

--
Regards,
Sudeep

