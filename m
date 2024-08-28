Return-Path: <linux-kernel+bounces-305057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38729628B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164A91C213F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF564187FE4;
	Wed, 28 Aug 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vTPlzDdu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21389184535
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851999; cv=none; b=qpX0GDfgdTJgae5aCA7YZTJkSlMWmJEcSUXcHwfGteTcx4ck5D8f+0O/HiYxvbmCwSKZ8exXDrIN+AFAX4bguEaH4wgSZohHyHzZkm8zm5Jo/Bbpq86t70g336yCrzRe2zXIRKE3F0b1X4d6mEE2gAkRJD5OSVHljVRI9ezWuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851999; c=relaxed/simple;
	bh=P3IwMGc1fhDf/9USYa7v2/NOctNzlLYjG37sTaPmA+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niLF3RDr7EbhMMrkwErjb7HqkhI+JxOP4BOaYhWvEONElXwAFSuhCHNWuIpmr0AhrKVmxwYh2yJtoCqOvBCoR+/tFs1LuChO16kk+y8+tosAP867IQn7/iI7hfOaZdIc6qoeirl9WbN/VNtGRYzabjORXO4i5q/7SVXuy/5PjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vTPlzDdu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SDWTsv050379;
	Wed, 28 Aug 2024 08:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724851949;
	bh=BiLmRdEJkR2KZs9VfjolkDfosTtrOJYzWKnvDNvDsVs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vTPlzDduyLwOz/YHo/ly1RZlUGh8O2s4UqmXAmf7exyVwd77xEaPL8N2SosIAAmMe
	 k/3nd1l0mxQqHuyXKkicPFXPUaDzk+/AMqPx7jFYVwl/i1sT2yh9yiRHSi7WTb1aNo
	 534ecz7k4kR2HvlHNOZWfnp2s4F0YzgWQ68GvOQM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SDWTK6025636
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 08:32:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 08:32:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 08:32:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SDWT0K021616;
	Wed, 28 Aug 2024 08:32:29 -0500
Date: Wed, 28 Aug 2024 08:32:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <bb@ti.com>, <d-gole@ti.com>,
        Jan Dakinevich
	<jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to
 a single register
Message-ID: <20240828133229.67bej3utpgrmzr3p@retired>
References: <20240828121008.3066002-1-nm@ti.com>
 <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:57-20240828, Mark Brown wrote:
> On Wed, Aug 28, 2024 at 07:10:08AM -0500, Nishanth Menon wrote:
> 
> > Commit 0ec74ad3c157 ("regmap: rework ->max_register handling")
> > introduced explicit handling in regmap framework for register maps
> > that is exactly 1 register wide. As a result, a syscon pointing
> > to a single register would cause regmap checks to skip checks
> > (or in the case of regmap_get_max_register, return -EINVAL) as
> > max_register_is_set will not be true.
> 
> In what sense is the behaviour changed for a map that doesn't specify a
> maximum register?
> 
> > Fixes: 0ec74ad3c157 ("regmap: rework ->max_register handling")
> 
> In what sense is this a fix?

The max_register was 0x0 was clearly a corner case. The fix done for
remap  should have cleaned up the users of max_register to maintain the
behavior. That is just my opinion.

> 
> > +	if (!syscon_config.max_register)
> > +		syscon_config.max_register_is_0 = true;
> 
> This will cause any syscon which does not explicitly specify a maximum
> register to be converted to having only one register at number 0.  That

The context of the diff is important - code above already sets
the max_register as syscon_config.max_register = resource_size(&res) -
reg_io_width;

So it already does set the max_register. syscon does'nt explictly set a
max_reg - it is derived from the resource_size.

> really does not seem like a good idea - unless you've done an audit of
> every single syscon to make sure they do explicitly specify a maximum
> register, and confirmed that this can't be specified via DT, then it's
> going to break things.

I understand the risk - but having a consistent max_register definition
is important - key here is that in regmap, max_register is valid if:
a) max_register not being 0
b) if max_register is 0, it is valid only if max_register_is_0 is set to
true.

When syscon sets the max_register, it operates correctly for num_reg > 1
however, when reg_size == 1, you don't get the checks that you
get when num_regs > 1. That is inconsistent behavior.

It might help if you can clarify why you think an inconsistent behavior
is correct for syscon?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

