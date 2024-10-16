Return-Path: <linux-kernel+bounces-368105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9CF9A0B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1216F1C22F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49A20966C;
	Wed, 16 Oct 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mycDx9OT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24018208D7D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084716; cv=none; b=pA5c8bnU2pW/iHQFlkmGpZ2SWnMmr4hMS6JV7N1IfHdkvGSZiaFsh5GFiledjv+pBRFXQEIEKcAJhJkoKgDWoA5lkyvuJsIrxxuZJcn031tvB5jCjd0KOP9pU9e6bW2RB4lY0DKEY89Uz+XutDqhGkumW33wnzXQFXNLjKYEpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084716; c=relaxed/simple;
	bh=Ei04/y7E+9GEINyDxafGA/mkjtrWrbFV5lAkYjh0DQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEsBIUqmvSrr3Dnr/YQzP4qjH3xYYe8MIqbEHRx7Z/2q3g3/WTyoJd+SZl8ITF7iWNaihcmP51TLTqTCo9rR1E7LXejxTqPzOX4wzM3bjId5iq7jdGjv4kV3B1vFPncshVeCskFoOZdrvpt6Y8R/AjFNpvsDMo/sgQbsUf4dgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mycDx9OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93BDC4CEC5;
	Wed, 16 Oct 2024 13:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729084715;
	bh=Ei04/y7E+9GEINyDxafGA/mkjtrWrbFV5lAkYjh0DQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mycDx9OTDHRJ5FvjAxCOhWlYOC+2328tkRSCNO1lqE/9UBf4R+IFRiw/K0GHwl9ON
	 JPTrUR17Rf5OT8KSpdWY1vPlkNiinEG0KKdeai7cuKyH1b3yVI/qKL1Q33ELUsT3uC
	 E5awGRa62YfkZKdrOQlbnf3rDrR6PZvCNBAmArIJk/ccnQj6I6vgR236LYr7/2YwW2
	 hbpBRB2msDZR99L7Wbsb0QpW1QTkjxFk290WEQOYLwJnhI9TGDummXNJut2IyBjkbR
	 OWTPxLQnSA4JniqVfjCTfxcIFfqDujCB1wd62UIw0sYaQvBnp7etM5XL/v8+tu7C6Y
	 F8TDvHPty0ZXA==
Date: Wed, 16 Oct 2024 14:18:32 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: Re: [PATCH v4 5/5] mfd: tqmx86: add I2C IRQ support
Message-ID: <20241016131832.GC1152434@google.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
 <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>
 <20241015113841.GH8348@google.com>
 <8fbae19e7e85a8fc8d6f9738155ec8fe44e63061.camel@ew.tq-group.com>
 <20241016130715.GA1152434@google.com>
 <e2842ba1ea0f5dfa818e4cbb9aefe343f48c1e53.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2842ba1ea0f5dfa818e4cbb9aefe343f48c1e53.camel@ew.tq-group.com>

On Wed, 16 Oct 2024, Matthias Schiffer wrote:

> On Wed, 2024-10-16 at 14:07 +0100, Lee Jones wrote:
> > 
> > On Wed, 16 Oct 2024, Matthias Schiffer wrote:
> > 
> > > On Tue, 2024-10-15 at 12:38 +0100, Lee Jones wrote:
> > > > 
> > > > On Mon, 07 Oct 2024, Matthias Schiffer wrote:
> > > > 
> > > > > From: Gregor Herburger <gregor.herburger@tq-group.com>
> > > > > 
> > > > > The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> > > > > Add module parameter to allow configuring the IRQ number, similar to the
> > > > > handling of the GPIO IRQ.
> > > > > 
> > > > > Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> > > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > > ---
> > > > > 
> > > > > v2: improve module parameter description (was patch 4/4)
> > > > > v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
> > > > > v4: no changes
> > > > > 
> > > > >  drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
> > > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> > > > > index e444fcd2a3e9d..057d035b71d33 100644
> > > > > --- a/drivers/mfd/tqmx86.c
> > > > > +++ b/drivers/mfd/tqmx86.c
> > > > > @@ -50,6 +50,7 @@
> > > > >  #define TQMX86_REG_IO_EXT_INT_9			2
> > > > >  #define TQMX86_REG_IO_EXT_INT_12		3
> > > > >  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> > > > > +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
> > > > >  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
> > > > >  #define TQMX86_REG_SAUC		0x17
> > > > >  
> > > > > @@ -60,7 +61,16 @@ static uint gpio_irq;
> > > > >  module_param(gpio_irq, uint, 0);
> > > > >  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
> > > > >  
> > > > > -static const struct resource tqmx_i2c_soft_resources[] = {
> > > > > +static uint i2c_irq;
> > > > > +module_param(i2c_irq, uint, 0);
> > > > > +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
> > > > > +
> > > > > +static struct resource tqmx_i2c_soft_resources[] = {
> > > > > +	/*
> > > > > +	 * Placeholder for IRQ resource - must come first to be filled in by the
> > > > > +	 * probe function.
> > > > > +	 */
> > > > > +	{},
> > > > 
> > > > Having a NULLed entry in the first slot doesn't sit well with me at all.
> > > > 
> > > > In order for us to avoid wasting memory, it would be better to place the
> > > > entry at the end of the array with a blank entry:
> > > > 
> > > >   DEFINE_RES_IRQ(0),
> > > > 
> > > > Later comes the matching code which updates the 0 value to something sane.
> > > > 
> > > > Before you call to the add the devices, check to see if the value has
> > > > changed.  If it hasn't, deprecate num_resources, effectively masking the
> > > > last entry in the array.  Then when platform_device_add_resources()
> > > > comes to duplicate the array, it will only copy the relevant entries.
> > > 
> > > I chose my current solution because it resulted in more simple and maintainable code:
> > > 
> > > - No dynamic array access, the IRQ resource is always written to index 0
> > 
> > Which is fragile (even with the comment).  If you're going to directly
> > index array elements, please do so with a unique identifier rather than
> > relying on it happening to reside in the first.
> > 
> > > - No surprises regarding num_resources, it is always equal to ARRAY_SIZE(resources)
> > 
> > No surprises, but sometimes it's incorrect.
> > 
> > > It also allowed to make all mfd_cell const; to make num_resources modifyable, either the const would
> > > need to be removed, or each mfd_cell would need to be copied to a stack variable in the probe
> > > function.
> > > 
> > > In my opinion, these benefits outweigh the 2*64 bytes saved for the additional resources allocated
> > > by platform_device_add_resources() - and 128 bytes doesn't seem significant at all, in particular
> > > considering that this driver is used on x86_64 only.
> > 
> > But doesn't outweigh my disliking for placing a NULL element at the
> > start of the array.  If you _must_ do something like this, please place
> > it at the end of the array.
> > 
> 
> Ok, will move the placeholder to the end, and access it using a defined index instead of 0. I would
> still prefer to keep num_resources constant instead of adjusting it. Does this sound acceptable to
> you?

It would allow me to sleep at night, yes. :)

-- 
Lee Jones [李琼斯]

