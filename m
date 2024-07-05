Return-Path: <linux-kernel+bounces-242909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC825928EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD8B292F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35117D37F;
	Fri,  5 Jul 2024 21:06:54 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB3178395;
	Fri,  5 Jul 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213614; cv=none; b=q/C8XM1QmqxuwzbIWjdPzegtUhsfm7mJcLLBM2vQzig3MY58xKVIzA5Wwbivk+obLpalX+36drYxq0F0fmxnSZDypzY4mv9ofp7hOeXU6f5zeBNPO8ErnenwHLRlviZNwp083PAeILt7lp1dL/ES75S7jhlQ2ZLgw8NvXJUcpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213614; c=relaxed/simple;
	bh=nDCY5LYEV9Y9sc1gkGZbDSb/JXXsS1WcfZlgDg7Z8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bff+ggikgJBF4CsWyEXlBCxxtU2ONgI0t6pa3K7RqI+TfjmzE+xrWq2SKp15/5m0TbkVsPb68/5O2HiydXuxtRA14dwgpaNPCe35LVc543xq6Voj+2RKAJDIYlArI/co6oeQshxgNj7ABit83OdT7vUtKLiXYsLVaJaJ429gMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 465KjtGq002299;
	Fri, 5 Jul 2024 15:45:56 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 465KjrP6002290;
	Fri, 5 Jul 2024 15:45:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 5 Jul 2024 15:45:52 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Marc Zyngier <maz@kernel.org>,
        apatel@ventanamicro.com, Rob Herring <robh@kernel.org>,
        Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mad skateman <madskateman@gmail.com>,
        Matthew Leaman <matthew@a-eon.biz>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives after the of/irq updates 2024-05-29
Message-ID: <20240705204552.GD19790@gate.crashing.org>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de> <86zfqzhgys.wl-maz@kernel.org> <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de> <874j95jrur.fsf@mail.lhotse> <3baff554-e8f6-42b0-b931-207175a4d8fd@xenosoft.de> <dfc7ec00-5216-4590-9347-ee10cd1e8380@xenosoft.de> <87o77ciqj8.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o77ciqj8.fsf@mail.lhotse>
User-Agent: Mutt/1.4.2.3i

On Fri, Jul 05, 2024 at 11:19:39AM +1000, Michael Ellerman wrote:
> +	prom_printf("nemo: deleting interrupt-map properties\n");
> +	rc = call_prom("interpret", 1, 1,
> +		      " s\" /pxp@0,e0000000\" find-device"
> +		      " s\" interrupt-map\" delete-property"
> +		      " s\" interrupt-map-mask\" delete-property"
> +		      " device-end");
> +	prom_printf("nemo: interpret returned %d\n", rc);

It's very fragile no matter what.

If some scriupt does something bad, just add something better for it?
You can replace anything by just adding something with the same name!


Segher

