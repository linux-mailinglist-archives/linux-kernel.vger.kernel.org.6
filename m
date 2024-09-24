Return-Path: <linux-kernel+bounces-336905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73EE98425A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B5B1F21FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700C15D5B7;
	Tue, 24 Sep 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkZXd1oK"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8F15884D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170714; cv=none; b=BRW3prUNpqVTOIPu/pio4IIskxBc3DE1ZWg+hyoxkMrexArT9tIlKzthWW/Lzl1pNiEl5TTxF3qHfjhN/WyVfLqWzONhxKTC+YY3BMB7HO3hUz7bgn59y15cpv8OZGaWH0YgG4052grCYZzV24Y8ujcOF5svCnT7lwgRaJWnhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170714; c=relaxed/simple;
	bh=XiEp6M6uQ1zDT7UyK/xawymV8aQtHN8rxZbBRUXgg0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAHi7V9k9x9p2D5fMd+8pXCSd1zdndYqWx6Is5FkQiwx9cugfxrENwuMuaYZZaovA7q9hZtolVlqbTl6gLqtBWVZxv6K0OYuyhcr9FazWl2g5IhbHek1563TVnvamv0PiOovTDQOV1fEVzNBf4whY6YnfI/ww9Z1eWy1fb5V75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qkZXd1oK; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e468baeso56987761fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727170710; x=1727775510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/nisFp8RKAs/gX3FD0xOUvyQj0aIVN5DLGlMJinQ3Dk=;
        b=qkZXd1oK+2sg90pISrwHRMS65OaHCLIOtEnRisXoK2pe4bYzpbSQs9W7gg8jqh/KiD
         rvHn8+NetCVxVGYpkJStI1redkf58rIzXX4w7vrcY9yJ8zdIO/5L8GjUOCHOJpedBA1Z
         C8ZpW/fNdB62dtTTCm4slO2Y0UPX16fdJq6DJ6YXDEsyytOZEQfg8a1Begw6gEXFyaLb
         v9GuCxzqdimDZK4WYDzldshLzWhBCbMiLZKTFD9X4wbSdTgf5cqJ6R5O71/ogCJjdS9n
         0dXYCwDnWSTfmaBWnJTdrviFYMvAipGWL8aNkq4fbfdw3n1Jqj1uxlOlbHsAXvBLy3/q
         MzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170710; x=1727775510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nisFp8RKAs/gX3FD0xOUvyQj0aIVN5DLGlMJinQ3Dk=;
        b=LA1CRSkaMcu7AadsnTz6pQETSycyc93TL9uAN0W2ZGNmMVPf71/3DlQsDVCwOGD3+H
         pELn02eSfSFOcktWtVuxvkO4d6whJLtBm6xs/sJWSMzhEuBfiJxZPMExhSb4OhyaeIcO
         IWS5wmqnw9i4TumY2icTh+hjEUqoNYKnMg5gweF3U8pPhIHMo0wfC0AvgiZhErQgQLze
         iZ492/FNfE3MPaArj9WPw81HXQ2XzF4raDM1OIZYqzh2U13APKsS6QVJpOKmBqniMJVr
         KN1Uqh6Vzjofv4zYWITHV1EkBrP6ViqMA9/wMjUENXF0NNh7MmClJtyk/fRXefRoqp7W
         SU+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZWNj8AnqKWnq0Gqg5/0k83sbqZwOvFg8/pFrtrC2ZbBESUX/EMMTcThaLEqd9S699WrDShjakYkvQ9Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kkEx5O9NCbdc4HNQHTXkqi9eD9Nd1SUj8RcADEGbGY0mkV9b
	ZGls1x96J33uQ/RoeQZ94cEC7BwTkUOsmvqEZXi4H+W+06ghTaUDS7umgIuGuiw=
X-Google-Smtp-Source: AGHT+IEVkdo9IU3eIpJK0EZxoXqGXjm1n93E9m6udz7QEOiMd5oLT7l8JD5yFadH+lkhJgbpkNuuYA==
X-Received: by 2002:a2e:bea1:0:b0:2f7:4f58:4a9c with SMTP id 38308e7fff4ca-2f7cb2eda53mr79119231fa.16.1727170709926;
        Tue, 24 Sep 2024 02:38:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d28b5c15sm1627151fa.133.2024.09.24.02.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:38:29 -0700 (PDT)
Date: Tue, 24 Sep 2024 12:38:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <sandor.yu@nxp.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	dl-linux-imx <linux-imx@nxp.com>, Oliver Brown <oliver.brown@nxp.com>, 
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Subject: Re: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add MHDP8501
 DP/HDMI driver
Message-ID: <3z53w7kzwnsn3pg5elp5fbueid323t47yyhub67muidd6k47me@assca4bckdt5>
References: <cover.1719903904.git.Sandor.yu@nxp.com>
 <359914108b879e995d4a39de32a33310009f0fab.1719903904.git.Sandor.yu@nxp.com>
 <20240702-quartz-salamander-of-culture-eec264@houat>
 <PAXPR04MB94480AB0490BBF00D2BA17BBF4932@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <20240903-gay-capable-hound-3cbef2@houat>
 <PAXPR04MB9448EF507CB5C18A43239A80F49E2@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <20240912-zippy-mongoose-of-domination-2ebc1d@houat>
 <PAXPR04MB94484D86A71A7527ADD42EA4F4652@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <CAA8EJpphegHmBFgH1-n9PEkrr-Ys+HCvekKGNYRp=xQxgmC0Cw@mail.gmail.com>
 <PAXPR04MB94481627922756E892C37B7DF4682@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB94481627922756E892C37B7DF4682@PAXPR04MB9448.eurprd04.prod.outlook.com>

On Tue, Sep 24, 2024 at 07:04:58AM GMT, Sandor Yu wrote:
>  
> > 
> > On Fri, 13 Sept 2024 at 11:46, Sandor Yu <sandor.yu@nxp.com> wrote:
> > >
> > >
> > > > Subject: Re: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add
> > > > MHDP8501 DP/HDMI driver
> > > >
> > > > On Fri, Sep 06, 2024 at 02:50:08AM GMT, Sandor Yu wrote:
> > > > > > On Tue, Sep 03, 2024 at 06:07:25AM GMT, Sandor Yu wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On
> > > > > > > > Behalf Of Maxime Ripard
> > > > > > > > Sent: 2024年7月2日 21:25
> > > > > > > > To: Sandor Yu <sandor.yu@nxp.com>
> > > > > > > > Cc: dmitry.baryshkov@linaro.org; andrzej.hajda@intel.com;
> > > > > > > > neil.armstrong@linaro.org; Laurent Pinchart
> > > > > > > > <laurent.pinchart@ideasonboard.com>; jonas@kwiboo.se;
> > > > > > > > jernej.skrabec@gmail.com; airlied@gmail.com;
> > > > > > > > daniel@ffwll.ch;
> > > > > > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > > festevam@gmail.com;
> > > > > > > > vkoul@kernel.org; dri-devel@lists.freedesktop.org;
> > > > > > > > devicetree@vger.kernel.org;
> > > > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > > > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org;
> > > > > > > > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>;
> > > > > > > > Oliver Brown <oliver.brown@nxp.com>;
> > > > > > > > alexander.stein@ew.tq-group.com; sam@ravnborg.org
> > > > > > > > Subject: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add
> > > > > > > > MHDP8501 DP/HDMI driver
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > There's still the scrambler issue we discussed on v15, but I
> > > > > > > > have some more comments.
> > > > > > > >
> > > > > > > > On Tue, Jul 02, 2024 at 08:22:36PM GMT, Sandor Yu wrote:
> > > > > > > > > +enum drm_connector_status cdns_mhdp8501_detect(struct
> > > > > > > > > +cdns_mhdp8501_device *mhdp) {
> > > > > > > > > +   u8 hpd = 0xf;
> > > > > > > > > +
> > > > > > > > > +   hpd = cdns_mhdp8501_read_hpd(mhdp);
> > > > > > > > > +   if (hpd == 1)
> > > > > > > > > +           return connector_status_connected;
> > > > > > > > > +   else if (hpd == 0)
> > > > > > > > > +           return connector_status_disconnected;
> > > > > > > > > +
> > > > > > > > > +   dev_warn(mhdp->dev, "Unknown cable status, hdp=%u\n",
> > > > hpd);
> > > > > > > > > +   return connector_status_unknown; }
> > > > > > > > > +
> > > > > > > > > +static void hotplug_work_func(struct work_struct *work) {
> > > > > > > > > +   struct cdns_mhdp8501_device *mhdp = container_of(work,
> > > > > > > > > +                                                struct
> > cdns_mhdp8501_device,
> > > > > > > > > +
> > hotplug_work.work);
> > > > > > > > > +   enum drm_connector_status status =
> > > > > > cdns_mhdp8501_detect(mhdp);
> > > > > > > > > +
> > > > > > > > > +   drm_bridge_hpd_notify(&mhdp->bridge, status);
> > > > > > > > > +
> > > > > > > > > +   if (status == connector_status_connected) {
> > > > > > > > > +           /* Cable connected  */
> > > > > > > > > +           DRM_INFO("HDMI/DP Cable Plug In\n");
> > > > > > > > > +           enable_irq(mhdp->irq[IRQ_OUT]);
> > > > > > > > > +   } else if (status == connector_status_disconnected) {
> > > > > > > > > +           /* Cable Disconnected  */
> > > > > > > > > +           DRM_INFO("HDMI/DP Cable Plug Out\n");
> > > > > > > > > +           enable_irq(mhdp->irq[IRQ_IN]);
> > > > > > > > > +   }
> > > > > > > > > +}
> > > > > > > >
> > > > > > > > You shouldn't play with the interrupt being enabled here:
> > > > > > > > hotplug interrupts should always enabled.
> > > > > > > >
> > > > > > > > If you can't for some reason, the reason should be
> > > > > > > > documented in your
> > > > > > driver.
> > > > > > >
> > > > > > > iMX8MQ have two HPD interrupters, one for plugout and the
> > > > > > > other for plugin, because they could not be masked, so we have
> > > > > > > to enable one and
> > > > > > disable the other.
> > > > > > > I will add more comments here.
> > > > > >
> > > > > > Right, but why do you need to enable and disable them? Do you
> > > > > > get spurious interrupts?
> > > > >
> > > > > They don't have status registers and cannot be masked. If they are
> > > > > not disabled, they will continuously generate interrupts.
> > > > > Therefore, I have to
> > > > disable one and enable the other.
> > > >
> > > > Sorry, I still don't get it. How can it be useful to detect hotplug
> > > > interrupts if it constantly sends spurious interrupts when it's enabled?
> > >
> > > Yes, this interrupt is different from a normal one; it's likely a design flaw.
> > > For instance, the plugin interrupt is continuously generated as long
> > > as the cable is plugged in, only stopping when the cable is unplugged.
> > > That's why two interrupts are used to detect cable plugout and plugin
> > separately.
> > > If interrupts aren't used, the only option is polling.
> > 
> > I think I've seen such strange design on other platforms, level interrupt for HPD,
> > which needs to be disabled via disable_irq().
> > 
> > >
> > > >
> > > > > > > > > +   /* Mailbox protect for HDMI PHY access */
> > > > > > > > > +   mutex_lock(&mhdp->mbox_mutex);
> > > > > > > > > +   ret = phy_init(mhdp->phy);
> > > > > > > > > +   mutex_unlock(&mhdp->mbox_mutex);
> > > > > > > > > +   if (ret) {
> > > > > > > > > +           dev_err(dev, "Failed to initialize PHY: %d\n", ret);
> > > > > > > > > +           goto clk_disable;
> > > > > > > > > +   }
> > > > > > > > > +
> > > > > > > > > +   /* Mailbox protect for HDMI PHY access */
> > > > > > > > > +   mutex_lock(&mhdp->mbox_mutex);
> > > > > > > > > +   ret = phy_set_mode(mhdp->phy, phy_mode);
> > > > > > > > > +   mutex_unlock(&mhdp->mbox_mutex);
> > > > > > > > > +   if (ret) {
> > > > > > > > > +           dev_err(dev, "Failed to configure PHY: %d\n", ret);
> > > > > > > > > +           goto clk_disable;
> > > > > > > > > +   }
> > > > > > > >
> > > > > > > > Why do you need a shared mutex between the phy and HDMI
> > > > controller?
> > > > > > >
> > > > > > > Both PHY and HDMI controller could access to the HDMI firmware
> > > > > > > by mailbox, So add mutex to avoid race condition.
> > > > > >
> > > > > > That should be handled at either the phy or mailbox level, not
> > > > > > in your hdmi driver.
> > > > >
> > > > > In both HDMI driver and PHY driver, every mailbox access had
> > > > > protected by its owns mutex. However, this mutex can only protect
> > > > > each mailbox access within their respective drivers, and it cannot
> > > > > provide protection for access between the HDMI and PHY drivers.
> > > > >
> > > > > The PHY driver only provides two API functions, and these
> > > > > functions are only called in the HDMI driver. Therefore, when
> > > > > accessing these functions, we use a mutex to protect them. This
> > > > > ensures that mailbox access is protected across different PHY and HDMI
> > drivers.
> > > >
> > > > It's really about abstraction. You're using a publicly defined API,
> > > > and change the semantics for your driver only, and that's not ok.
> > > >
> > > > Why can't the mailbox driver itself serialize the accesses from any
> > > > user, HDMI and PHY drivers included?
> > > >
> > >
> > > In the current code implementation, cdns-mhdp-helper.c isn't a standalone
> > driver but rather a library.
> > > It provides fundamental mailbox access functions and basic register
> > read/write operations that rely on the mailbox.
> > > These functions are highly reusable across MHDP8501 and MHDP8546 and
> > can be leveraged by future MHDP versions.
> > >
> > > However, most MHDP firmware interactions involve a sequence of mailbox
> > accesses, including sending commands and receiving firmware responses.
> > > These commands constitute a significant portion of all firmware interactions,
> > encompassing operations like EDID reading and DP link training.
> > > Unfortunately, these commands cannot be reused between MHDP8501 and
> > MHDP8546.
> > >
> > > Creating a dedicated mailbox driver with its own mutex would effectively
> > address race conditions.
> > > However, this would necessitate relocating all mailbox-related functions to
> > this driver.
> > > Including these non-reusable functions would defeat the purpose of code
> > reuse.
> > >
> > > To strike a balance between code reusability and race condition mitigation,
> > adding mutexes to PHY access functions seems like a reasonable solution.
> > 
> > You seem to have two kinds of scenarios when talking to MHDP: just
> > cdns_mhdp_mailbox_send(), no response needed and then the
> > cdns_mhdp_mailbox_send() /  cdns_mhdp_mailbox_recv_header() /
> > cdns_mhdp_mailbox_recv_data() sequence. Extract those + the mutex access
> > to separate functions, add a mutex to those sequences and use them as a
> > high-level API for your HDMI and PHY drivers.
> > 
> > Adding mutexes around phy_foo() calls doesn't look like a proper solution _at_
> > _all_.
> > 
> Because the sequence cdns_mhdp_mailbox_send() / cdns_mhdp_mailbox_recv_header() / cdns_mhdp_mailbox_recv_data() cannot be reused by different drivers, 
> it's not suitable to abstract them into a separate function.

Why is it so? In the end, even if one driver uses it and another driver
uses other functions (while holding the mutex), please move generic
versions of those functions to your helper code. It should abstract
_types_ of hardware access (and send/recv_header/recv_data is such an
abstraction).

> I've noticed some Linux kernel drivers use global mutexes, which can solve the current race conditions problem. 
> I'll implement this in the next version.

-- 
With best wishes
Dmitry

