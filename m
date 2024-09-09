Return-Path: <linux-kernel+bounces-322107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB4972420
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394AD1C226BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E318A939;
	Mon,  9 Sep 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YoLGblid"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352296AB8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915814; cv=none; b=DHNXTC1rL1rVKTRQH1Q+Wzh4oOSuhDgl/LSrGg7ERWwfWCJk6Z7eqwFkr7ossM+ldZHszeZGBvEL5r2xSt1lz+KQcbl8/irLG+a5IXFUMu73fb2h8IyFVGTz9iRZhYzQS0l8AOSoh0uIkyVV+bLxST58Eo65xsG9BdnvOFXj9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915814; c=relaxed/simple;
	bh=OGwFIBfkQZPm7Mn2DYOWykrTRecZ7Tp+roVH+JLWTbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0mzqAgjnpwGFGUajb4aiCtyJP9gCAQYJPxCupOTAYCFzt0s74VT0Nx1IRr2yuJBrkU0NYEDgPV1i6oWKpp1sEsljP2xVxQv4nbALWPHvlv9PZUknQf4Eufopl64XNWvuu0WUiXtKdh1sNW1bby2CFpC4mwcdg84grRILzEPew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YoLGblid; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 380EA1BF208;
	Mon,  9 Sep 2024 21:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725915810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C94iueCtkgJZqwdOpqmnG2jA8jBtTJ3vB4jL9HoEEOY=;
	b=YoLGblidTwXhZDm/vQcmx5P989eRq14+XupMbGnNV9Nm4xUQQEFGszO9XU4U4HRIaFAiwF
	Xyg1V/uhxk0WyPddL8awBSeyTJf9HnUn47Rts9TSnrHRsY3isBJZkqU3tpAR6jbpaG06uM
	rnHX2QqvrHi/50RLmzh7VSLcIIooxi9Xw2J5+Bn6rTDACmOBUbTUyCbyCM3FX762duKD2U
	286Y6Vx4z03mM3wcyS5wreWH3uv/Sas+PskIrDv2OrchsGiu506SeMJVF1+hUGu9Brcq40
	34nD8SXvBupMX7k09h7YNDwPmv/3kP5OOwumhZxKRKWfuai8g0Vf4ZGR+gzP8w==
Date: Mon, 9 Sep 2024 23:03:29 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Carlos Song <carlos.song@nxp.com>, miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V4 1/2] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <202409092103290fd1d226@mail.local>
References: <20240905074557.3810026-1-carlos.song@nxp.com>
 <Zt9TcLqi34EDlI6b@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt9TcLqi34EDlI6b@lizhi-Precision-Tower-5810>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 09/09/2024 15:58:40-0400, Frank Li wrote:
> On Thu, Sep 05, 2024 at 03:45:56PM +0800, Carlos Song wrote:
> > According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> > of SCL Clock timing for first broadcast address should be adjusted to 200ns
> > at least. I3C device working as i2c device will see the broadcast to close
> > its Spike Filter then change to work at I3C mode. After that I3C open drain
> > SCL high level should be adjusted back.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Alexandre Belloni:
> 
> 	I have not seen these in patch work
> 	https://patchwork.kernel.org/project/linux-i3c/list/
> 
> 	Any thing wrong. These two patches is critial for some boards.
> Could you please take care it?

They didn't make it to the list, please subscribe and resend. Also, it
is very very difficult to keep track of all the patches you sent s I'm
not sure what actually needs to be applied and what has been dropped r
superseded.

> 
> best regards
> Frank Li
> 
> > ---
> > Change for V4:
> > - No change. Send this patch with svc-i3c-master.c fix patch.
> > Change for V3:
> > - Modify comments from Miquel's suggestion
> > Chnage for V2:
> > - Fix set_speed description from Frank's comment
> > ---
> >  drivers/i3c/master.c       | 12 ++++++++++++
> >  include/linux/i3c/master.h | 16 ++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 7028f03c2c42..6f3eb710a75d 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  		goto err_bus_cleanup;
> >  	}
> >
> > +	if (master->ops->set_speed) {
> > +		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> > +		if (ret)
> > +			goto err_bus_cleanup;
> > +	}
> > +
> >  	/*
> >  	 * Reset all dynamic address that may have been assigned before
> >  	 * (assigned by the bootloader for example).
> > @@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  	if (ret && ret != I3C_ERROR_M2)
> >  		goto err_bus_cleanup;
> >
> > +	if (master->ops->set_speed) {
> > +		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
> > +		if (ret)
> > +			goto err_bus_cleanup;
> > +	}
> > +
> >  	/* Disable all slave events before starting DAA. */
> >  	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
> >  				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > index 074f632868d9..2a1ed05d5782 100644
> > --- a/include/linux/i3c/master.h
> > +++ b/include/linux/i3c/master.h
> > @@ -277,6 +277,20 @@ enum i3c_bus_mode {
> >  	I3C_BUS_MODE_MIXED_SLOW,
> >  };
> >
> > +/**
> > + * enum i3c_open_drain_speed - I3C open-drain speed
> > + * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
> > + *				broadcast address. The first broadcast address at this speed
> > + *				will be visible to all devices on the I3C bus. I3C devices
> > + *				working in I2C mode will turn off their spike filter when
> > + *				switching into I3C mode.
> > + * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
> > + */
> > +enum i3c_open_drain_speed {
> > +	I3C_OPEN_DRAIN_SLOW_SPEED,
> > +	I3C_OPEN_DRAIN_NORMAL_SPEED,
> > +};
> > +
> >  /**
> >   * enum i3c_addr_slot_status - I3C address slot status
> >   * @I3C_ADDR_SLOT_FREE: address is free
> > @@ -436,6 +450,7 @@ struct i3c_bus {
> >   *		      NULL.
> >   * @enable_hotjoin: enable hot join event detect.
> >   * @disable_hotjoin: disable hot join event detect.
> > + * @set_speed: adjust I3C open drain mode timing.
> >   */
> >  struct i3c_master_controller_ops {
> >  	int (*bus_init)(struct i3c_master_controller *master);
> > @@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
> >  				 struct i3c_ibi_slot *slot);
> >  	int (*enable_hotjoin)(struct i3c_master_controller *master);
> >  	int (*disable_hotjoin)(struct i3c_master_controller *master);
> > +	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

