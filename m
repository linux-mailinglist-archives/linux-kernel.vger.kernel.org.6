Return-Path: <linux-kernel+bounces-368086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66D9A0B01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C9328162F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45BE208D85;
	Wed, 16 Oct 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG8kHhua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B8206E66
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084040; cv=none; b=LM8NfTdcidIXb3EUXAqNW53SuE2MkItZlWpKUPkFbQB5svwHW88XrtjHVuaz+Mgkqat8Ro8P5eiWKZ6e5CBxuUWhgYEl4k9EmISrDqPNznPNVeOG/dsxd+lyZHMwlrcQJhfZQT2m0fbXR6xGqEbTt0NtSVTEPRVqIOP7EYAQ3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084040; c=relaxed/simple;
	bh=Ve33raK75MTK0VVW6KPCaQUPS4lVUV7+OTp0uduyRvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOo00TB860cy7eACZr2CAs9qf4Ji3scIzfNOLX/clyW+LFLc+yTQNP4uMNp2FYbQwyDcys5PzJPIumFJslUF/q6lnQT3IdatxROeJvrQrSvmqZ4ZEOF2W5xe30Ywirxp/1OTpYbytMinyQBEWvJGWnPm3frd9BgS3/BtheXW5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG8kHhua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E7C4CECF;
	Wed, 16 Oct 2024 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729084038;
	bh=Ve33raK75MTK0VVW6KPCaQUPS4lVUV7+OTp0uduyRvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OG8kHhuacv0g9lsaNnIFxVCUCEEvcj9UpwmAnUe2cJ4cQs7+D4AsQlEbQ2ZlUwWnh
	 nOYSicmwdl0/NUDMHHDFfZ2zhj2jo61iM3dOiZqXtVDUIUhG65EaO+0+ctjubCzRG6
	 svPAXIYNkPWFDGrVoaTS93m/9OaxAlAeqIvuw96RsDnznFi/pUXZMjEpYY1N2rqNjn
	 f1338fwJ+Grf9b0uO0rWELfXXP1O0QEumM7TTDL9UlWYpf3QMZtSIjUYaFGTgf0Yrk
	 9b0KBdpHf0FJ33yHl2ZWJMZcMyg6B5fBzX/NybQ3a1RDPkKJpJdfLbYF5cD+Lzamqz
	 +8EczoMcg0I1Q==
Date: Wed, 16 Oct 2024 14:07:15 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: Re: [PATCH v4 5/5] mfd: tqmx86: add I2C IRQ support
Message-ID: <20241016130715.GA1152434@google.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
 <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>
 <20241015113841.GH8348@google.com>
 <8fbae19e7e85a8fc8d6f9738155ec8fe44e63061.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fbae19e7e85a8fc8d6f9738155ec8fe44e63061.camel@ew.tq-group.com>

On Wed, 16 Oct 2024, Matthias Schiffer wrote:

> On Tue, 2024-10-15 at 12:38 +0100, Lee Jones wrote:
> > 
> > On Mon, 07 Oct 2024, Matthias Schiffer wrote:
> > 
> > > From: Gregor Herburger <gregor.herburger@tq-group.com>
> > > 
> > > The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> > > Add module parameter to allow configuring the IRQ number, similar to the
> > > handling of the GPIO IRQ.
> > > 
> > > Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > > 
> > > v2: improve module parameter description (was patch 4/4)
> > > v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
> > > v4: no changes
> > > 
> > >  drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> > > index e444fcd2a3e9d..057d035b71d33 100644
> > > --- a/drivers/mfd/tqmx86.c
> > > +++ b/drivers/mfd/tqmx86.c
> > > @@ -50,6 +50,7 @@
> > >  #define TQMX86_REG_IO_EXT_INT_9			2
> > >  #define TQMX86_REG_IO_EXT_INT_12		3
> > >  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> > > +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
> > >  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
> > >  #define TQMX86_REG_SAUC		0x17
> > >  
> > > @@ -60,7 +61,16 @@ static uint gpio_irq;
> > >  module_param(gpio_irq, uint, 0);
> > >  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
> > >  
> > > -static const struct resource tqmx_i2c_soft_resources[] = {
> > > +static uint i2c_irq;
> > > +module_param(i2c_irq, uint, 0);
> > > +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
> > > +
> > > +static struct resource tqmx_i2c_soft_resources[] = {
> > > +	/*
> > > +	 * Placeholder for IRQ resource - must come first to be filled in by the
> > > +	 * probe function.
> > > +	 */
> > > +	{},
> > 
> > Having a NULLed entry in the first slot doesn't sit well with me at all.
> > 
> > In order for us to avoid wasting memory, it would be better to place the
> > entry at the end of the array with a blank entry:
> > 
> >   DEFINE_RES_IRQ(0),
> > 
> > Later comes the matching code which updates the 0 value to something sane.
> > 
> > Before you call to the add the devices, check to see if the value has
> > changed.  If it hasn't, deprecate num_resources, effectively masking the
> > last entry in the array.  Then when platform_device_add_resources()
> > comes to duplicate the array, it will only copy the relevant entries.
> 
> I chose my current solution because it resulted in more simple and maintainable code:
> 
> - No dynamic array access, the IRQ resource is always written to index 0

Which is fragile (even with the comment).  If you're going to directly
index array elements, please do so with a unique identifier rather than
relying on it happening to reside in the first.

> - No surprises regarding num_resources, it is always equal to ARRAY_SIZE(resources)

No surprises, but sometimes it's incorrect.

> It also allowed to make all mfd_cell const; to make num_resources modifyable, either the const would
> need to be removed, or each mfd_cell would need to be copied to a stack variable in the probe
> function.
> 
> In my opinion, these benefits outweigh the 2*64 bytes saved for the additional resources allocated
> by platform_device_add_resources() - and 128 bytes doesn't seem significant at all, in particular
> considering that this driver is used on x86_64 only.

But doesn't outweigh my disliking for placing a NULL element at the
start of the array.  If you _must_ do something like this, please place
it at the end of the array.

> > 
> > >  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
> > >  };
> > >  
> > > @@ -263,6 +273,14 @@ static int tqmx86_probe(struct platform_device *pdev)
> > >  	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
> > >  
> > >  	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
> > > +		if (i2c_irq) {
> > > +			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
> > > +					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
> > > +			if (!err)
> > > +				/* Assumes the IRQ resource placeholder is first */
> > > +				tqmx_i2c_soft_resources[0] = DEFINE_RES_IRQ(i2c_irq);
> > > +		}
> > > +
> > >  		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > >  					   tqmx86_i2c_soft_dev,
> > >  					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
> > > -- 
> > > TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> > > Amtsgericht München, HRB 105018
> > > Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> > > https://www.tq-group.com/
> > > 
> > 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/

-- 
Lee Jones [李琼斯]

