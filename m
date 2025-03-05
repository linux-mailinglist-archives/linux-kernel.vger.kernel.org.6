Return-Path: <linux-kernel+bounces-546726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1DA4FE11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309E116DD65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F8241C89;
	Wed,  5 Mar 2025 11:55:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A3233737;
	Wed,  5 Mar 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175742; cv=none; b=gutfI/hBNb185qywMqfKYmigoeQA6Rma0OYz3KP4epwzHieJocLWqfmEgYSXfjAACwf7It1BZvdRUacj4nOHfr0In51EFahUAlZQ7fptWUAhxalIPaR5bR5L31I+FqGa7IzN4aQuGA86AbdkQjtAAseGzamMSTHVkvfH7hat+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175742; c=relaxed/simple;
	bh=n0ErFNxQMLvccEYJKdGex8SoK60liI0SddSQ9NOfhCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7GvLS+9XS600G5x5xvMF2r42WhnBhU5+9lnZJ16I3HAH85kX02QWuSLDoCJkrckUPXqeshnr1XmruTN1tTX9eF7Gvp4hK1SMlHE6qHjE0r+4COVtSyKXlAMMzBXktmmS1fc/e8bmxRXet+kQnyaExna+yuPzfiSKGOkxtt35Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6E3FEC;
	Wed,  5 Mar 2025 03:55:53 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AC353F66E;
	Wed,  5 Mar 2025 03:55:38 -0800 (PST)
Date: Wed, 5 Mar 2025 11:55:35 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] irqchip/sunxi-nmi: Support Allwinner A523 NMI
 controller
Message-ID: <20250305115535.619ba087@donnerap.manchester.arm.com>
In-Reply-To: <87frjr6i1j.ffs@tglx>
References: <20250304222309.29385-1-andre.przywara@arm.com>
	<20250304222309.29385-7-andre.przywara@arm.com>
	<87frjr6i1j.ffs@tglx>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Mar 2025 08:41:28 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

Hi Thomas,

thanks for having a look!

> On Tue, Mar 04 2025 at 22:23, Andre Przywara wrote:
> >  
> > -struct sunxi_sc_nmi_reg_offs {
> > +struct sunxi_sc_nmi_data {
> >  	u32 ctrl;
> >  	u32 pend;
> >  	u32 enable;
> > +	u32 enable_val;  
> 
> The data structure name and the corresponding variable/argument name
> were making the code pretty obvious, but now this is opaque and
> incomprehensible.
> 
> data::ctrl does not even give the slightest hint what this is about. You
> need to read up in the code to figure out what it means. Something like:
> 
> struct sunxi_sc_nmi_data {
> 	u32	reg_offs_ctrl;
>   	u32	reg_offs_pend;
>   	u32	reg_offs_enable;
> 	u32	enable_val;
> };
> 
> or even better:
> 
> struct sunxi_sc_nmi_data {
> 	struct {
> 		u32	ctrl;
>   		u32	pend;
>   		u32	enable;
>         } reg_offs;
> 	u32		enable_val;
> };
> 
> makes it clear and obvious, no?

Sure, will change it, it was just the usual decision between reworking the
existing code or just adding my small change in. 50% chance of getting that
right, I guess ;-)

> 
> > +static const struct sunxi_sc_nmi_data sun55i_a523_data __initconst = {
> > +	.ctrl	= SUN9I_NMI_CTRL,
> > +	.pend	= SUN9I_NMI_PENDING,
> > +	.enable	= SUN9I_NMI_ENABLE,
> > +	.enable_val = BIT(31),  
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

Oops, missed that.

Thanks,
Andre

> 
> Thanks,
> 
>         tglx

