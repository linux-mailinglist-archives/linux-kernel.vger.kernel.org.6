Return-Path: <linux-kernel+bounces-539852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBEA4A9E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809777AA706
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E401CAA68;
	Sat,  1 Mar 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SikyzHnZ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5B1AB52D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740820311; cv=none; b=PNN8INFdURxRb/VC62YeG7ERivzfr9qi7S7aQpSKEkFH+KtDGWDQSQwEsQKpSql3dndUw8WSO3ntL8ep4nERDmZTff5hbcmVx3jcj6ctuyXL4dvOoQns6I2cEnZcfo/jrygzjqx80kskEBexnRvPG1EJbqG4L5EpbhmQU2JAzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740820311; c=relaxed/simple;
	bh=5woWo5tvmwSGCfcI6Zs77YXZgBhQH9IQiA1Bc/8NRhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmykLdVRzMW02dZp7kGCiOKPclRvGBnzc9rvnRgWCoFNy05WDNr3TW+PJNBUXeT6nRI6udRdZZNvzst7bChFhCYhWZMCuBn0VjTW5SXmc5qj7JMqeodraOnoam+wE9FA7wz2nIthSwghlLrq0x2rjOhGoTsGK1yUUZaXZBC80IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SikyzHnZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bab0ad5a8so851681fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740820307; x=1741425107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYj9EmFInvMUKhXPbZju8haPAjZ+p2e+tp/UQEcEJJ0=;
        b=SikyzHnZtV4QnFUrWGs7iVMqkzbdkeAEphjArAkKRJFOmD2MZHTssBifnqXlHYo2TB
         Ki2XwJSkVNQUaSjC4cdZIfME+ZmInHnWm1uVeBDCBpzidIBz6CdcI3m/hVGV9IMaAzv9
         T7e+CaEtQYlrHGx7t99/myykxMUtomJKOWcinapC+5bHOSlVTDFeCu16LlSLCCfl/DyV
         2NpbltbU8HwFLYegB7AG124NTymDti4ES4eZYQJuPXWCyUX/Mqgce8efZUhzgOdnVucc
         thPhSbj987UcSk8rcSB1K1RI3Myretl2oTAiDjkNmCFT0abaUslREQpeyXNjCbSmVNMs
         TApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740820307; x=1741425107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYj9EmFInvMUKhXPbZju8haPAjZ+p2e+tp/UQEcEJJ0=;
        b=oR8vxuYDF14hW7qunRf3W05WmtMVCgLBeOwmPOjzmcjaiufSW441sahKDGBRV2aWxe
         lOsmc7w01S+axfJVxp9juSjXJvrFWkhjGM+6HDI9k0aYJucJH6/bYafda4pakR0l8hSG
         xY2t8xmuYeXs0i7IOcOObtxPLd0jE3lsgO/rY/r0kxLHxBo0KPQzG6V9AcKUWZOd487G
         bOZNR2uiM2F6bf09KHasA+M2eqJ1mw27eYuz/bJ/JcLNgcVsqeKU0SuausNGKX6hZOPX
         U4UE2gbW0kuiBzkh8A7luhXJ6dVKtmBrjSkWaiaetA8pdBWKyRto9rA29d5AKcSNFY45
         kYig==
X-Forwarded-Encrypted: i=1; AJvYcCXetoZS1iPOGHqf3h/FS+hkiKG3zCnlxVk7t1kItzT+NzHeHL3pHm5O67t0D0N377LOHAfw2zpmdGHi59k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbulhykQwGV3kM+iWyfz67X553+u1REgXrvbI+LeJuddDtFrC
	ot7gBYhvEKhLotcQZWK7OXr/j9vSAbjJUNtuIcb6IX91uSRuB9hlWmmAbh+GKag=
X-Gm-Gg: ASbGnctcwv2Vz4fa+fnSDj+8rrlm700WA7zjli7a2pYkpSq6/zobJ/7zcW6Tad42mJn
	aUfjw+6f9RUjqsHswxblJf5tunHfr9U/llrGn+lofUCBozYAcnEP8VxMuqwXIUt7kguRr040F32
	AiaFBC8I0+VnoEg5BCCx73WWkoZjUdkxyUXH+lTXMyXNHEZTBFxWJarWcQqxoSo285MaVHpYWq8
	OFOEJk4ne2/I7/kb/S2HiE+Gjz7Gy4+qvBpxgnT7/sX1Hx+w5ighnPoQstIUjs5diJeovAxVarL
	nWmccWOqpTDu/6uiYriEiwSpAXBnKCHfMZ2NWrINwTLWSlcSFLH8HfJXCkW+iCKkOsjsySMU8e0
	QQFvGLAG5JUoFlzFonGQ089d8
X-Google-Smtp-Source: AGHT+IE4HGuzBxzcEoFrkOedX31N4YMF2wWHxVY/nsHjlS/ri3PT6h8G6bwSl9JSN0NuyHMOaWjSSQ==
X-Received: by 2002:a2e:bc17:0:b0:308:f01f:183b with SMTP id 38308e7fff4ca-30b932004e7mr21143391fa.2.1740820306765;
        Sat, 01 Mar 2025 01:11:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8685f35esm7560901fa.71.2025.03.01.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 01:11:45 -0800 (PST)
Date: Sat, 1 Mar 2025 11:11:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <njnz5hxumrvqrgsfq7zlunle3jgfan3be34ao5xtkmzczpi6af@waywds2ww6qw>
References: <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com>
 <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
 <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com>
 <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
 <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>
 <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
 <6506e448-3851-436f-9354-42f9ef844d27@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6506e448-3851-436f-9354-42f9ef844d27@huawei.com>

On Sat, Mar 01, 2025 at 04:45:40PM +0800, Yongbang Shi wrote:
> 
> > On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
> > > > On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> > > > > > On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > > > > > > On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> > > > > > > > > > > +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> > > > > > > > > > > +{
> > > > > > > > > > > +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> > > > > > > > > > > +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> > > > > > > > > > > +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> > > > > > > > > > > +  int ret;
> > > > > > > > > > > +
> > > > > > > > > > > +  if (dp->hpd_status) {
> > > > > > > > > > > +          hibmc_dp_hpd_cfg(&priv->dp);
> > > > > > > > > > > +          ret = hibmc_dp_prepare(dp, mode);
> > > > > > > > > > > +          if (ret)
> > > > > > > > > > > +                  return ret;
> > > > > > > > > > > +
> > > > > > > > > > > +          hibmc_dp_display_en(dp, true);
> > > > > > > > > > > +  } else {
> > > > > > > > > > > +          hibmc_dp_display_en(dp, false);
> > > > > > > > > > > +          hibmc_dp_reset_link(&priv->dp);
> > > > > > > > > > > +  }
> > > > > > > > > > If I understand this correctly, you are using a separate drm_client to
> > > > > > > > > > enable and disable the link & display. Why is it necessary? Existing
> > > > > > > > > > drm_clients and userspace compositors use drm framework, they should be
> > > > > > > > > > able to turn the display on and off as required.
> > > > > > > > > > 
> > > > > > > > > Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> > > > > > > > > We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> > > > > > > > > the different video modes into DP registers.
> > > > > > > > Why? The link training and mode programming should happen during
> > > > > > > > pre_enable / enable stage (legacy or atomic).
> > > > > > > Hi Dmitry,
> > > > > > > 
> > > > > > > Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> > > > > > > And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> > > > > > It should be userspace, who triggers the enable/disable (or it should
> > > > > > be the in-kernel fbdev / fbcon, which interface through the generic
> > > > > > drm_fbdev client).
> > > > > Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> > > > > by user, but it won't call when HPD triggered .
> > > > - Is HPD even properly delivered to userspace? What kind of compsitor
> > > >     are you using? Is .detect working properly and reporting a correct
> > > >     plug-in state?
> > > Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
> > > this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
> > > I use Xorg, and the display service is GDM.
> > > The .detect is called and the getting modes info is correct.
> > > I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
> > You can go to the display settings in GDM. It would be interesting to
> > observe if it notes the second monitor or not. Last, but not least, you
> > can use a simple tool like 'xrandr' under your XOrg session to set the
> > display resolution.
> 
> Thank you for your advice!
> Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
> So do I need to clear the vga connector, if dp is plugged in?

Unless your hardware can not manage two outputs at the same time, no,
you don't have to. Just check how it behaves on x86 systems. Ideally
your driver should have the same behaviour.

> And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
> but there are errs when set some low resolutions.

That's a separate topic, most likely related to timing or to some other
issues. You can fix that separately (but please do, switching modes
should work).

-- 
With best wishes
Dmitry

