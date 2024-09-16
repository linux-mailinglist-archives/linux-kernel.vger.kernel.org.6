Return-Path: <linux-kernel+bounces-330195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C011C979AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E6B20BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF6D38F83;
	Mon, 16 Sep 2024 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkAm5drf"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E01BF58
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464589; cv=none; b=HogAAuNzlzEiaq7UGC9MqxU5LbmlqZ2B5v8dND57gJcVT6bBYViR0vSkQbQ1a9G3bZ6K/OUVkoWyiPJHX9fUCFzfMCgmdDVA6e07D/QSXK97s0dBZv9XdpCkXV3CTz8dpeRBhJetoH6vdnTI4KRK2liCk5Ks4OSZhlMtGF6sPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464589; c=relaxed/simple;
	bh=YlngQhXsz9XMm4gwYpAC99X0rDnNoWUaEjAWKKnja6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJVgqL/PgpXnGaf2g1eQ7i8ZmCkfcD1eCw5GCCKBdzJRU5WDVZ92oQZxVLksOfdA92EW4NKT5b1RWdHmr4bfXAoEF3MuFaQ3IWYO5coYMPpWxEJGIntrXiWb+4K2iC3x8Xiprn3BgbGRlNjw0/nlrqKlUS7oBvj6to62f/YxYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkAm5drf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dbb24ee2ebso34474827b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726464586; x=1727069386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee0cDtGE5u+y2+k+wmeH/b6bPYytWbs2Gx4nJ7mANiw=;
        b=NkAm5drf5tsJsSUpscxFwCw2yu0fFsUlrW7uMdKeLGXo7wew2gtqzgccTUmwRFxl9/
         96HHkb4ZjTuBHEltI3OHQg216ApGfsPebR6enZXC70rwOalrsTUBcZfr2GUruf9Qvggp
         7nfX7vplxiXp/SLwGHMd/XDt9iUakZ8kqN6szfqsydeRKgp8PVEV87nvHRtteH/vPNQz
         e44KrXJGd2q2UHE8FCWpn73LZbSJKJkzrs0SRGYNfMd39dl0SP4peGgg/6kIrEHsucvy
         kiYJQ9h7It5U3Aq5hreSd0iux9blgI81/x58P0ZGjhQYQoRAVJ29Tql26IwnGotXMstD
         Hyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726464586; x=1727069386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee0cDtGE5u+y2+k+wmeH/b6bPYytWbs2Gx4nJ7mANiw=;
        b=t2QKIwg2+GojcIkxhoYY/hD1Pmeda6RdZTYlYANsR4SNNAGwpIs7Nvp6MK0w1g6UEE
         uabPrNcL8YPP1bhszIfIP1i5x4+dBXcvHKKUA1Df/b8PW0l3EuBp6Kx3CN2Sf+SQSloT
         PvAOD+j25nFzi+nF89JpcsMU3b3VFd4+WJzLf0Q91ZhWjfOPOLE/BxyeAq+TRmmW2OES
         pcVN+9rwOjdWwn0H363WT0NvOjF5mdMcMi5JOrUEDhgjx44AFEFdyJvsFPdMByv7YR6R
         NHhP/3j2N5ZU07Ai62mLv7R9bIfPU7wBniuN2M81RIW/wx2uxnLY+Zg5BTuTwYnGwgRu
         dEmA==
X-Forwarded-Encrypted: i=1; AJvYcCWukkDiMo/zyw8iruwbcLwrUW59wMlOIJO/j9HnH0POHh7e/rWe8wHuWXYvX0vFMNP8hzjYfzu9M9R3Kvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcxaVFQyvno4lKIRr6tApBqRCxpp4G6YQxTAD5UE6pyLHff9N
	ad3iSctuJE7U7RYxXb8QuhqkS4HP0c3Vlqm0NDY9FFNzhHDVB+GNLMZQC6FLAfBtW43lZVuEyH3
	8pl2Qqp2eivySIudUXTpe7y0j4D5yiTHpAiZHKQ==
X-Google-Smtp-Source: AGHT+IFDkQKoJlgZEgnRuo6gyvtTIbWXlWt6sK8BFmy+M9HJocvVWMY5H8oxKmosTB0PuutrBkAkoT0AnTg43NbHajw=
X-Received: by 2002:a05:690c:45c1:b0:647:7782:421a with SMTP id
 00721157ae682-6dbb6bbb427mr100754317b3.45.1726464586201; Sun, 15 Sep 2024
 22:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719903904.git.Sandor.yu@nxp.com> <359914108b879e995d4a39de32a33310009f0fab.1719903904.git.Sandor.yu@nxp.com>
 <20240702-quartz-salamander-of-culture-eec264@houat> <PAXPR04MB94480AB0490BBF00D2BA17BBF4932@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <20240903-gay-capable-hound-3cbef2@houat> <PAXPR04MB9448EF507CB5C18A43239A80F49E2@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <20240912-zippy-mongoose-of-domination-2ebc1d@houat> <PAXPR04MB94484D86A71A7527ADD42EA4F4652@PAXPR04MB9448.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB94484D86A71A7527ADD42EA4F4652@PAXPR04MB9448.eurprd04.prod.outlook.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Sep 2024 07:29:35 +0200
Message-ID: <CAA8EJpphegHmBFgH1-n9PEkrr-Ys+HCvekKGNYRp=xQxgmC0Cw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add MHDP8501
 DP/HDMI driver
To: Sandor Yu <sandor.yu@nxp.com>
Cc: Maxime Ripard <mripard@kernel.org>, "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, 
	Oliver Brown <oliver.brown@nxp.com>, 
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sept 2024 at 11:46, Sandor Yu <sandor.yu@nxp.com> wrote:
>
>
> > Subject: Re: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add MHDP85=
01
> > DP/HDMI driver
> >
> > On Fri, Sep 06, 2024 at 02:50:08AM GMT, Sandor Yu wrote:
> > > > On Tue, Sep 03, 2024 at 06:07:25AM GMT, Sandor Yu wrote:
> > > > > > -----Original Message-----
> > > > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On
> > > > > > Behalf Of Maxime Ripard
> > > > > > Sent: 2024=E5=B9=B47=E6=9C=882=E6=97=A5 21:25
> > > > > > To: Sandor Yu <sandor.yu@nxp.com>
> > > > > > Cc: dmitry.baryshkov@linaro.org; andrzej.hajda@intel.com;
> > > > > > neil.armstrong@linaro.org; Laurent Pinchart
> > > > > > <laurent.pinchart@ideasonboard.com>; jonas@kwiboo.se;
> > > > > > jernej.skrabec@gmail.com; airlied@gmail.com; daniel@ffwll.ch;
> > > > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> > festevam@gmail.com;
> > > > > > vkoul@kernel.org; dri-devel@lists.freedesktop.org;
> > > > > > devicetree@vger.kernel.org;
> > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org;
> > > > > > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; Oliver
> > > > > > Brown <oliver.brown@nxp.com>; alexander.stein@ew.tq-group.com;
> > > > > > sam@ravnborg.org
> > > > > > Subject: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add
> > > > > > MHDP8501 DP/HDMI driver
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > There's still the scrambler issue we discussed on v15, but I
> > > > > > have some more comments.
> > > > > >
> > > > > > On Tue, Jul 02, 2024 at 08:22:36PM GMT, Sandor Yu wrote:
> > > > > > > +enum drm_connector_status cdns_mhdp8501_detect(struct
> > > > > > > +cdns_mhdp8501_device *mhdp) {
> > > > > > > +   u8 hpd =3D 0xf;
> > > > > > > +
> > > > > > > +   hpd =3D cdns_mhdp8501_read_hpd(mhdp);
> > > > > > > +   if (hpd =3D=3D 1)
> > > > > > > +           return connector_status_connected;
> > > > > > > +   else if (hpd =3D=3D 0)
> > > > > > > +           return connector_status_disconnected;
> > > > > > > +
> > > > > > > +   dev_warn(mhdp->dev, "Unknown cable status, hdp=3D%u\n",
> > hpd);
> > > > > > > +   return connector_status_unknown; }
> > > > > > > +
> > > > > > > +static void hotplug_work_func(struct work_struct *work) {
> > > > > > > +   struct cdns_mhdp8501_device *mhdp =3D container_of(work,
> > > > > > > +                                                struct cdns_=
mhdp8501_device,
> > > > > > > +                                                hotplug_work=
.work);
> > > > > > > +   enum drm_connector_status status =3D
> > > > cdns_mhdp8501_detect(mhdp);
> > > > > > > +
> > > > > > > +   drm_bridge_hpd_notify(&mhdp->bridge, status);
> > > > > > > +
> > > > > > > +   if (status =3D=3D connector_status_connected) {
> > > > > > > +           /* Cable connected  */
> > > > > > > +           DRM_INFO("HDMI/DP Cable Plug In\n");
> > > > > > > +           enable_irq(mhdp->irq[IRQ_OUT]);
> > > > > > > +   } else if (status =3D=3D connector_status_disconnected) {
> > > > > > > +           /* Cable Disconnected  */
> > > > > > > +           DRM_INFO("HDMI/DP Cable Plug Out\n");
> > > > > > > +           enable_irq(mhdp->irq[IRQ_IN]);
> > > > > > > +   }
> > > > > > > +}
> > > > > >
> > > > > > You shouldn't play with the interrupt being enabled here:
> > > > > > hotplug interrupts should always enabled.
> > > > > >
> > > > > > If you can't for some reason, the reason should be documented i=
n
> > > > > > your
> > > > driver.
> > > > >
> > > > > iMX8MQ have two HPD interrupters, one for plugout and the other
> > > > > for plugin, because they could not be masked, so we have to enabl=
e
> > > > > one and
> > > > disable the other.
> > > > > I will add more comments here.
> > > >
> > > > Right, but why do you need to enable and disable them? Do you get
> > > > spurious interrupts?
> > >
> > > They don't have status registers and cannot be masked. If they are no=
t
> > > disabled, they will continuously generate interrupts. Therefore, I ha=
ve to
> > disable one and enable the other.
> >
> > Sorry, I still don't get it. How can it be useful to detect hotplug int=
errupts if it
> > constantly sends spurious interrupts when it's enabled?
>
> Yes, this interrupt is different from a normal one; it's likely a design =
flaw.
> For instance, the plugin interrupt is continuously generated as long as t=
he cable is plugged in,
> only stopping when the cable is unplugged.
> That's why two interrupts are used to detect cable plugout and plugin sep=
arately.
> If interrupts aren't used, the only option is polling.

I think I've seen such strange design on other platforms, level
interrupt for HPD, which needs to be disabled via disable_irq().

>
> >
> > > > > > > +   /* Mailbox protect for HDMI PHY access */
> > > > > > > +   mutex_lock(&mhdp->mbox_mutex);
> > > > > > > +   ret =3D phy_init(mhdp->phy);
> > > > > > > +   mutex_unlock(&mhdp->mbox_mutex);
> > > > > > > +   if (ret) {
> > > > > > > +           dev_err(dev, "Failed to initialize PHY: %d\n", re=
t);
> > > > > > > +           goto clk_disable;
> > > > > > > +   }
> > > > > > > +
> > > > > > > +   /* Mailbox protect for HDMI PHY access */
> > > > > > > +   mutex_lock(&mhdp->mbox_mutex);
> > > > > > > +   ret =3D phy_set_mode(mhdp->phy, phy_mode);
> > > > > > > +   mutex_unlock(&mhdp->mbox_mutex);
> > > > > > > +   if (ret) {
> > > > > > > +           dev_err(dev, "Failed to configure PHY: %d\n", ret=
);
> > > > > > > +           goto clk_disable;
> > > > > > > +   }
> > > > > >
> > > > > > Why do you need a shared mutex between the phy and HDMI
> > controller?
> > > > >
> > > > > Both PHY and HDMI controller could access to the HDMI firmware by
> > > > > mailbox, So add mutex to avoid race condition.
> > > >
> > > > That should be handled at either the phy or mailbox level, not in
> > > > your hdmi driver.
> > >
> > > In both HDMI driver and PHY driver, every mailbox access had protecte=
d
> > > by its owns mutex. However, this mutex can only protect each mailbox
> > > access within their respective drivers, and it cannot provide
> > > protection for access between the HDMI and PHY drivers.
> > >
> > > The PHY driver only provides two API functions, and these functions
> > > are only called in the HDMI driver. Therefore, when accessing these
> > > functions, we use a mutex to protect them. This ensures that mailbox
> > > access is protected across different PHY and HDMI drivers.
> >
> > It's really about abstraction. You're using a publicly defined API, and=
 change
> > the semantics for your driver only, and that's not ok.
> >
> > Why can't the mailbox driver itself serialize the accesses from any use=
r, HDMI
> > and PHY drivers included?
> >
>
> In the current code implementation, cdns-mhdp-helper.c isn't a standalone=
 driver but rather a library.
> It provides fundamental mailbox access functions and basic register read/=
write operations that rely on the mailbox.
> These functions are highly reusable across MHDP8501 and MHDP8546 and can =
be leveraged by future MHDP versions.
>
> However, most MHDP firmware interactions involve a sequence of mailbox ac=
cesses, including sending commands and receiving firmware responses.
> These commands constitute a significant portion of all firmware interacti=
ons, encompassing operations like EDID reading and DP link training.
> Unfortunately, these commands cannot be reused between MHDP8501 and MHDP8=
546.
>
> Creating a dedicated mailbox driver with its own mutex would effectively =
address race conditions.
> However, this would necessitate relocating all mailbox-related functions =
to this driver.
> Including these non-reusable functions would defeat the purpose of code r=
euse.
>
> To strike a balance between code reusability and race condition mitigatio=
n, adding mutexes to PHY access functions seems like a reasonable solution.

You seem to have two kinds of scenarios when talking to MHDP: just
cdns_mhdp_mailbox_send(), no response needed and then the
cdns_mhdp_mailbox_send() /  cdns_mhdp_mailbox_recv_header() /
cdns_mhdp_mailbox_recv_data() sequence. Extract those + the mutex
access to separate functions, add a mutex to those sequences and use
them as a high-level API for your HDMI and PHY drivers.

Adding mutexes around phy_foo() calls doesn't look like a proper
solution _at_ _all_.

>
> Sandor
>
> > > > > >
> > > > > > > +static enum drm_mode_status
> > > > > > > +cdns_hdmi_tmds_char_rate_valid(const struct drm_bridge *brid=
ge,
> > > > > > > +                          const struct drm_display_mode *mod=
e,
> > > > > > > +                          unsigned long long tmds_rate) {
> > > > > > > +   struct cdns_mhdp8501_device *mhdp =3D
> > bridge->driver_private;
> > > > > > > +   union phy_configure_opts phy_cfg;
> > > > > > > +   int ret;
> > > > > > > +
> > > > > > > +   phy_cfg.hdmi.tmds_char_rate =3D tmds_rate;
> > > > > > > +
> > > > > > > +   /* Mailbox protect for HDMI PHY access */
> > > > > > > +   mutex_lock(&mhdp->mbox_mutex);
> > > > > > > +   ret =3D phy_validate(mhdp->phy, PHY_MODE_HDMI, 0,
> > &phy_cfg);
> > > > > > > +   mutex_unlock(&mhdp->mbox_mutex);
> > > > > > > +   if (ret < 0)
> > > > > > > +           return MODE_CLOCK_RANGE;
> > > > > > > +
> > > > > > > +   return MODE_OK;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static enum drm_mode_status
> > > > > > > +cdns_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
> > > > > > > +                       const struct drm_display_info *info,
> > > > > > > +                       const struct drm_display_mode *mode) =
{
> > > > > > > +   unsigned long long tmds_rate;
> > > > > > > +
> > > > > > > +   /* We don't support double-clocked and Interlaced modes *=
/
> > > > > > > +   if (mode->flags & DRM_MODE_FLAG_DBLCLK ||
> > > > > > > +       mode->flags & DRM_MODE_FLAG_INTERLACE)
> > > > > > > +           return MODE_BAD;
> > > > > > > +
> > > > > > > +   /* MAX support pixel clock rate 594MHz */
> > > > > > > +   if (mode->clock > 594000)
> > > > > > > +           return MODE_CLOCK_HIGH;
> > > > > >
> > > > > > This needs to be in the tmds_char_rate_valid function
> > > > > This clock rate check is covered by function
> > > > > tmds_char_rate_valid() It could be removed if keep function
> > > > > tmds_char_rate_valid() be called by
> > > > mode_valid.
> > > >
> > > > Yeah, it's not something you should have to duplicate.
> > > >
> > > > > >
> > > > > > > +   if (mode->hdisplay > 3840)
> > > > > > > +           return MODE_BAD_HVALUE;
> > > > > > > +
> > > > > > > +   if (mode->vdisplay > 2160)
> > > > > > > +           return MODE_BAD_VVALUE;
> > > > > > > +
> > > > > > > +   tmds_rate =3D mode->clock * 1000ULL;
> > > > > > > +   return cdns_hdmi_tmds_char_rate_valid(bridge, mode,
> > > > > > > +tmds_rate);
> > > > > >
> > > > > > It will already be called by the core so this is redundant.
> > > > >
> > > > > mode_valid function is use to filter the mode list in
> > > > > drm_helper_probe_single_connector_modes(),
> > > > > if function cdns_hdmi_tmds_char_rate_valid() is not called,
> > > > > unsupported
> > > > modes will in mode list.
> > > >
> > > > It's probably something we should deal with in the core somehow. I'=
m
> > > > not entirely sure how to reconcile drm_bridge_connector and the hdm=
i
> > > > framework there, but we should at the very least provide a
> > > > mode_valid helper for bridges.
> > >
> > > I agree with that. In fact, I'm a bit confused about the current
> > > mode_valid and tmds_char_rate_valid functions. Ideally, we should fin=
d
> > > a way to make tmds_char_rate_valid also work for filtering out the
> > > mode list, rather than just during atomic_check.
> >
> > Yeah, definitely. The way we did so on vc4 for example was to compute t=
he
> > rate for a 8bpc, RGB, output and try to validate that. I think it would=
 be
> > reasonable to start with that.

+1, please extract this code as a helper. You can even submit it
separately, reworking sun4i and vc4 to use a new helper.

--=20
With best wishes
Dmitry

