Return-Path: <linux-kernel+bounces-567917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61069A68BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4840175BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F01254B04;
	Wed, 19 Mar 2025 11:39:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E851D63CD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384369; cv=none; b=Fg/DyEXvAzxXsD02x7xnQVayZYivmep7TxglhuAULWCZKbnxg2/C8xeU6/0/4jbOLYLFVYu2qX3gGF1/sctY3y5XZv+fzW1G0ulmY9XeYBGl2GmbealFwy5cldUnc0jcqB5BmkdNTvxH7FI9AW4wIKfl+8Xd4JJ6TO4IU/2BGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384369; c=relaxed/simple;
	bh=F0pFZ9igkUZ+KSEqHj+9N5X7cF/VPtyb0skN2IwYkyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+TXTMPHQul0LHtgs4XCGy6gbUgSylvGu+QVo3b8LwhX7hlckjKb50egPLjGqeFS2NH6iKi/Z67Sua+ShjG3Ht/ka4haNBJc/CzsUmr9+wzXEyo5E9RAWobYRlY0DA7pEI1XdJQvrt9v+CD+wCQQ+2vwfGKj0Wi4n22C0HV3kWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC4E113E;
	Wed, 19 Mar 2025 04:39:35 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8329F3F673;
	Wed, 19 Mar 2025 04:39:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:39:22 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Miaoqian Lin <linmq006@gmail.com>, Gavin Shan <gshan@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: psci: Fix refcount leak in psci_dt_init
Message-ID: <Z9qs6r_eaQ0qLx9B@bogus>
References: <20250318151712.28763-1-linmq006@gmail.com>
 <28cb8360-7fb0-46f0-b05f-5114f1974cf3@redhat.com>
 <Z9qgmTbeLh0cCULw@bogus>
 <Z9qmglbXw0xILaet@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qmglbXw0xILaet@J2N7QTR9R3>

On Wed, Mar 19, 2025 at 11:12:02AM +0000, Mark Rutland wrote:
> On Wed, Mar 19, 2025 at 10:46:49AM +0000, Sudeep Holla wrote:
> > On Wed, Mar 19, 2025 at 08:28:38PM +1000, Gavin Shan wrote:
> 
> > Any reason why we can't move to the new scoped usage like below?
> 
> > diff --git i/drivers/firmware/psci/psci.c w/drivers/firmware/psci/psci.c
> > index a1ebbe9b73b1..a4269078b2a2 100644
> > --- i/drivers/firmware/psci/psci.c
> > +++ w/drivers/firmware/psci/psci.c
> > @@ -797,12 +797,11 @@ static const struct of_device_id psci_of_match[] __initconst = {
> > 
> >  int __init psci_dt_init(void)
> >  {
> > -       struct device_node *np;
> >         const struct of_device_id *matched_np;
> >         psci_initcall_t init_fn;
> >         int ret;
> > -
> > -       np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> > +       struct device_node *np __free(device_node) =
> > +               of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> > 
> >         if (!np || !of_device_is_available(np))
> >                 return -ENODEV;
> > @@ -810,7 +809,6 @@ int __init psci_dt_init(void)
> >         init_fn = (psci_initcall_t)matched_np->data;
> >         ret = init_fn(np);
> > 
> > -       of_node_put(np);
> >         return ret;
> >  }
> 
> IIUC the bug has existed since before the scoped helpers were
> introduced, so for the sake of keeping the backport simple I reckon we
> should take Miaoqian Lin's patch as-is, and we can consider moving to
> the scoped helpers as a later cleanup.
> 

Agreed.

-- 
Regards,
Sudeep

