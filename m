Return-Path: <linux-kernel+bounces-543242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A19A4D31C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B339E16D66D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C511F150D;
	Tue,  4 Mar 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgbkpuee"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5379F5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067027; cv=none; b=csvwETLxrC5sG21LFLgODYYVdqD8pHg/eJLaDNeLfPXOxiWm1JOmLZOYvYMGMGKSwlC6dj56x7JkgLkms23GOcToFRc9hiz0wXr7B2e3a06wtrl3sZydoo6/Oyx5T1IyRJK3JAmXTNGyoi64PQsZm61btUKisMVbWSDqEmC/ccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067027; c=relaxed/simple;
	bh=3h4os+bNTphBVoPx8cLJxbxtkUv/5yT5Gx6LY5/6TZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH3cEmgN4GuPq4foaQfIdjyROuCoSoUGlHuTHnZffJdpZSZux8L3EXW9etC5YdBUNT0oyOqPpxoWC4gb/Qqsq7OwUbSXHn42X6zmfi6JRtI33e//yTlIJF8jjmYVA4Ezon9aIksBntavIsrLrnU3eFB8uDWg1W9MSXmcch9Xpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgbkpuee; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54963160818so2657606e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741067023; x=1741671823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKTXFIAdwYgvuh07rZ1NyeKtb1x4g4EP7f5OZK492cc=;
        b=hgbkpuee9Hg+q3L4FTEP+/+5snc0Xc7nry0HWSzTUf8Dj/w1HbCubQLAwALroPFujx
         i9kibSOT+5L42KJSJi7PfYY8xFNyjlauLCyuebH9+Oo7ENpnVtehAEuDxs4SIYizmcPn
         9qTr94RgriId133cnetPhSN+CfXyTYSbRvRb4idMRBbz+DsstgQu1iOCqGzpUwp9TytF
         noIxxk+blqZzB064iHwIYBLICKQt3dHsq7dbmA7AgMBfSH/gkbPtMEQxBYdrllF+BCWw
         tD15hOZ4KBy1WJTgPINVWbTBanFUMXQKu7zk0L22sxljVlGPWNWu5e2KjxrpS8pVe5Jj
         6alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741067023; x=1741671823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKTXFIAdwYgvuh07rZ1NyeKtb1x4g4EP7f5OZK492cc=;
        b=FcG5pvQzAoOKASQo2jwkorjwJsA6wG6GWhRilXBUpUcapLcLLFRTS7LpcGohghdPGC
         B4mOyiZzjQr4j9gItuTVUXg5Aur6gFd/HdKFU3UiHi3G+fDvWqs/yje00uFbFF6AibBu
         3bXV97HJ0d9JNM6tFXKVNBglTpuiv5afXL00qUyKY73ACPwu/TSOZySLkXsAiPxfLRyb
         qjhhNKZwIb7THDTgSLEKfLguG+71jcXyrYkrkURwELsJ26G+v3vwvgmSobFtiE6pQO6s
         I0mcWwp7ezV8ZJ/w322mW6w+cf+i3XBT6/sgT8bh4LRnQ0WNAfWhHBZ1ITxtYvV0OIEL
         GLYg==
X-Forwarded-Encrypted: i=1; AJvYcCXo1rnQcvZOOuZHCIwXbeNtFBpa+o5W16NmmYQhLfWstm7EebnHC3mM471z05n8FcngHKrdIdcmfjBDiGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztf+W7qCPfhrtctMEYqinoUbuxxuFAKbnspYicGIL126VTozMi
	XUtI9DjYcukI5gegpN/htKbV0QyGidjhupoYa98NRtJtkN1y6Xor04K7yC12cUQ=
X-Gm-Gg: ASbGncta2DIhvRwsiHMXUEZWUdEw/VwWPZOuzcMn0WcWrB5uPO/WFmw888r61eZHxzF
	hDPiHr6LeoYo1/NLmT4cmL01PtBk0iCOvgUQ2EdJkjgAY2CnGfWnCRbkqA7EOekYoch7oJrEy0T
	/jJ1kT8ndSByFMsmsum/2wiVixGFG26kuyxLTXhP8OilRopu5mXl94qklyTufm2mHHTQlOeBa66
	O5VfTQGlC1wR1Rq+THLcd8egLFjRLMJnl0EH82wRRMpEqAN7D19uNoubPrC+qCwWGgD1yBUhBZG
	Xy6eMI9yEMrIv3DvbUTYtdKL0QuTbNIoeJfEnUDEJQ6WveBsA7/YToEi5hmpBW9SU8GRyyCsvhh
	hgH7WTb9gTPsvyKNVKdsPGF/B
X-Google-Smtp-Source: AGHT+IFl/XhxWgK5jjaVHGYT1do5OUCGy7ZZK0LuSUnLvpBu8eiZJ80JLtemF9/oM7QJHl7X6Sj2qQ==
X-Received: by 2002:a05:6512:3d19:b0:545:5d:a5e2 with SMTP id 2adb3069b0e04-5494c129f56mr5433163e87.10.1741067023442;
        Mon, 03 Mar 2025 21:43:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494f5a7c23sm1203370e87.142.2025.03.03.21.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 21:43:42 -0800 (PST)
Date: Tue, 4 Mar 2025 07:43:39 +0200
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
Message-ID: <kdk7p6yhuvby2nyqriufj3jo7kkyxv4ml4awdhszkehv2r2om3@cvho3j27hmwx>
References: <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>
 <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
 <6506e448-3851-436f-9354-42f9ef844d27@huawei.com>
 <njnz5hxumrvqrgsfq7zlunle3jgfan3be34ao5xtkmzczpi6af@waywds2ww6qw>
 <c87613aa-1d17-4a88-acce-269ea9eddc22@huawei.com>
 <CAA8EJpo71m_ae9siT7f4Tsfr0C4XeoraqPYPsPp0gz-N+oMOjw@mail.gmail.com>
 <6e54c88f-dfaf-462d-b66b-c237d19faec6@huawei.com>
 <zzi2h52xiernm32h7i7xtrlnjwaqc3n2tx33ypmhw6quoi5qyg@pilzj5zantii>
 <fce2e5e8-ba38-474d-891c-f8ab0de8d07e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce2e5e8-ba38-474d-891c-f8ab0de8d07e@huawei.com>

On Tue, Mar 04, 2025 at 10:23:14AM +0800, Yongbang Shi wrote:
> > On Mon, Mar 03, 2025 at 01:02:44PM +0800, Yongbang Shi wrote:
> > > > On Sat, 1 Mar 2025 at 11:54, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > > > > On Sat, Mar 01, 2025 at 04:45:40PM +0800, Yongbang Shi wrote:
> > > > > > > > On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
> > > > > > > > > > On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> > > > > > > > > > > > On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > > > > > > > > > > > > On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> > > > > > > > > > > > > > > > > +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> > > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > > +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> > > > > > > > > > > > > > > > > +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> > > > > > > > > > > > > > > > > +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> > > > > > > > > > > > > > > > > +  int ret;
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +  if (dp->hpd_status) {
> > > > > > > > > > > > > > > > > +          hibmc_dp_hpd_cfg(&priv->dp);
> > > > > > > > > > > > > > > > > +          ret = hibmc_dp_prepare(dp, mode);
> > > > > > > > > > > > > > > > > +          if (ret)
> > > > > > > > > > > > > > > > > +                  return ret;
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +          hibmc_dp_display_en(dp, true);
> > > > > > > > > > > > > > > > > +  } else {
> > > > > > > > > > > > > > > > > +          hibmc_dp_display_en(dp, false);
> > > > > > > > > > > > > > > > > +          hibmc_dp_reset_link(&priv->dp);
> > > > > > > > > > > > > > > > > +  }
> > > > > > > > > > > > > > > > If I understand this correctly, you are using a separate drm_client to
> > > > > > > > > > > > > > > > enable and disable the link & display. Why is it necessary? Existing
> > > > > > > > > > > > > > > > drm_clients and userspace compositors use drm framework, they should be
> > > > > > > > > > > > > > > > able to turn the display on and off as required.
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> > > > > > > > > > > > > > > We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> > > > > > > > > > > > > > > the different video modes into DP registers.
> > > > > > > > > > > > > > Why? The link training and mode programming should happen during
> > > > > > > > > > > > > > pre_enable / enable stage (legacy or atomic).
> > > > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> > > > > > > > > > > > > And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> > > > > > > > > > > > It should be userspace, who triggers the enable/disable (or it should
> > > > > > > > > > > > be the in-kernel fbdev / fbcon, which interface through the generic
> > > > > > > > > > > > drm_fbdev client).
> > > > > > > > > > > Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> > > > > > > > > > > by user, but it won't call when HPD triggered .
> > > > > > > > > > - Is HPD even properly delivered to userspace? What kind of compsitor
> > > > > > > > > >        are you using? Is .detect working properly and reporting a correct
> > > > > > > > > >        plug-in state?
> > > > > > > > > Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
> > > > > > > > > this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
> > > > > > > > > I use Xorg, and the display service is GDM.
> > > > > > > > > The .detect is called and the getting modes info is correct.
> > > > > > > > > I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
> > > > > > > > You can go to the display settings in GDM. It would be interesting to
> > > > > > > > observe if it notes the second monitor or not. Last, but not least, you
> > > > > > > > can use a simple tool like 'xrandr' under your XOrg session to set the
> > > > > > > > display resolution.
> > > > > > > Thank you for your advice!
> > > > > > > Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
> > > > > > > So do I need to clear the vga connector, if dp is plugged in?
> > > > > > Unless your hardware can not manage two outputs at the same time, no,
> > > > > > you don't have to. Just check how it behaves on x86 systems. Ideally
> > > > > > your driver should have the same behaviour.
> > > > > Our hardware cannot support two outputs with different timing, so I used the one crtc and one plane that DP and VGA share. And just add a new DP connector
> > > > > with a encoder, just like the previous VGA's code logic. But the HPD problem makes me feel confused, should I change the framwork structure to slove this problem?
> > > > I think registering a single CRTC is a correct way. Then it is logical
> > > > that there is no mode set on the DP when you connect it. The userspace
> > > > can not output any data. However if you disconnect VGA and connect DP
> > > > then it should become active and should output your desktop
> > > > environment.
> > > Okay, Thank you for your guidance. So I need to disconnect VGA when I get the HPD (plugged in) , then
> > > userapce will active and enanble DP, right?
> > Yes.
> 
> I'm sorry for that, just wanna make sure one more thing. I found if I only set the VGA connector's status to disconnected when HPD plugged in, it won't be active.

Huh? You should implement hibmc_connector_funcs.detect() or
.detect_ctx() to report VGA connector's status. Use
ast_vga_connector_helper_detect_ctx() as an inspiration.

> And If I add drm_cleanup_connector() for VGA, it work. So is this okay that I use this cleanup in HPD?

drm_connector_cleanup() should only be callsed if the connector is going
to be destroyed. You should not be callign that function.

> 
> 
> > > 
> > > > > And also, I will check whether this driver works good on the x86 server. Right now, I'm testing on arm64 server.
> > > > > 
> > > > > > > And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
> > > > > > > but there are errs when set some low resolutions.
> > > > > > That's a separate topic, most likely related to timing or to some other
> > > > > > issues. You can fix that separately (but please do, switching modes
> > > > > > should work).
> > > > > Okay!
> > > > > 
> > > > > 

-- 
With best wishes
Dmitry

