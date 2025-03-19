Return-Path: <linux-kernel+bounces-567747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8CA689EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF45219C2A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0B253B45;
	Wed, 19 Mar 2025 10:46:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4720D519
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381216; cv=none; b=nVwfyl9YmHTLddiq27KD4gt66256W/fQyeI9gGmc0so9tEodonFx9BCUQKGjBivDjzPB00OwGdgd4vOn+xsSVPhgC9A5c2zdc/0yfYWsLoIwbejFtCewWxW/fnBG9toHcsoxVF9mYl4QuSffMXaCWFwRY8M7X6Melan5KSl2rdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381216; c=relaxed/simple;
	bh=xzIeU7ws0DDBQQzU+WgbUSwxNoLzBBXUcGy+s7+m2lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvvcb5Weo6CQ3SC1W9w2qiMOV+0YWWyv2DNu87TyDDl71/AzaO/PLQe61yBBYXqVIH4wHuNZPnysgLl7WoL5K4jxf/0RoJPouUwrpU3sfSx4kqpNgAx2kz2wjGv8wyaBaY0PaUdloSWaQ1MN8+DUyQ7/GQdn7juIhkOy5LHNZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8156C12FC;
	Wed, 19 Mar 2025 03:47:02 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9061B3F694;
	Wed, 19 Mar 2025 03:46:52 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:46:49 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Miaoqian Lin <linmq006@gmail.com>, Gavin Shan <gshan@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: psci: Fix refcount leak in psci_dt_init
Message-ID: <Z9qgmTbeLh0cCULw@bogus>
References: <20250318151712.28763-1-linmq006@gmail.com>
 <28cb8360-7fb0-46f0-b05f-5114f1974cf3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28cb8360-7fb0-46f0-b05f-5114f1974cf3@redhat.com>

On Wed, Mar 19, 2025 at 08:28:38PM +1000, Gavin Shan wrote:
> Hi Miaoqian,
> 
> On 3/19/25 1:17 AM, Miaoqian Lin wrote:
> > Fix a reference counter leak in psci_dt_init() where of_node_put(np) was
> > missing after of_find_matching_node_and_match() when np is unavailable.
> > 
> > Fixes: bff60792f994 ("arm64: psci: factor invocation code to drivers")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >   drivers/firmware/psci/psci.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> 
> I'm wandering if the fix tag is correct enough because !of_device_is_available(np)
> wasn't added by bff60792f994.
> 
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index a1ebbe9b73b1..38ca190d4a22 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -804,8 +804,10 @@ int __init psci_dt_init(void)
> >   	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> > -	if (!np || !of_device_is_available(np))
> > +	if (!np || !of_device_is_available(np)) {
> > +		of_node_put(np);
> >   		return -ENODEV;
> > +	}
> 
> The fix looks good to me. The duplicated of_node_put() can be avoided with
> a 'out' tag added, something like below.
> 
> 	if (!np || !of_device_is_available(np)) {
> 		ret = -ENODEV;
> 		goto out;
> 	}
> 
> 	:
> 
> out:
> 	of_node_put(np);
> 	return ret;
> 
> >   	init_fn = (psci_initcall_t)matched_np->data;
> >   	ret = init_fn(np);
> 

Any reason why we can't move to the new scoped usage like below?

-- 
Regards,
Sudeep

-->8

diff --git i/drivers/firmware/psci/psci.c w/drivers/firmware/psci/psci.c
index a1ebbe9b73b1..a4269078b2a2 100644
--- i/drivers/firmware/psci/psci.c
+++ w/drivers/firmware/psci/psci.c
@@ -797,12 +797,11 @@ static const struct of_device_id psci_of_match[] __initconst = {

 int __init psci_dt_init(void)
 {
-       struct device_node *np;
        const struct of_device_id *matched_np;
        psci_initcall_t init_fn;
        int ret;
-
-       np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
+       struct device_node *np __free(device_node) =
+               of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);

        if (!np || !of_device_is_available(np))
                return -ENODEV;
@@ -810,7 +809,6 @@ int __init psci_dt_init(void)
        init_fn = (psci_initcall_t)matched_np->data;
        ret = init_fn(np);

-       of_node_put(np);
        return ret;
 }


