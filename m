Return-Path: <linux-kernel+bounces-546289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA17A4F8C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408F817034C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1041E5B9E;
	Wed,  5 Mar 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vaf7tLIz"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3681F09B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163254; cv=none; b=pEX14XQCzFbS2/QU/W3Y+xbjHd1alntn5WDWpAHN0CisujIb3/PBhYg+y2XhHRfkHR592GEiFA6PUfM5FRplCF9i+MuhEZ9akoQUxM9WMqvSKOUtfJo6+krvWtAAx5NcGLHxUH19yx2hciW5P/sPCOVeQPDX9B9cHhigkzLeqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163254; c=relaxed/simple;
	bh=sPVdpU5db2LCvw2lUJPoGNvGP6ZGedTztn/sM5zrYMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zna08RGb2D9yFeKeDXcFhO/SohlQGgeHXO91bDzMxBsmX3kxHmg4SaQvXOTelsNhA8cejGKK/qsniAuiUxz8LwDxub2zPdal/d1ZDY3BnREL24B3PhOYLytsa5c1JTBASG8Wz7n8rt9hUZJSrA7JJIKsNZatnAFiRATn2TZo0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vaf7tLIz; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e608b2698fcso4603892276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741163251; x=1741768051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bi2C4pewmcM5VJ8Iq8i6k/4osIHG8Rf8aqI4wTiT7Y=;
        b=Vaf7tLIzwnidoR6V8gt0a4XXkT9zsbMcnntm3VpB65zlfetLVr8AyzW+IYlptw5AvX
         7+Yfzi0qey6h4R0nQA2fI27eopYtxsfWpq1jr6YyV569PWpWmjks9b8EJhaeH9c+5Ri7
         v65LRVplU3OFmpoWudZGe2UlUDvvrR9zyuAhhZm6Xwi2w7zVJ00izFjPqho6hvRT/YGK
         QZCWgs2xvtTitIGm3BkbS/mKkSi0an7E3Ec6t9HQGKomm38POBtsmG78kgZKE+ptJY0s
         v2OiaFu7u9MMP91nnH6Ao0itx2fNj/vmIEXTcgah9tqwHRw73cvjtgNKNK3QM+eIoihp
         FUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163251; x=1741768051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Bi2C4pewmcM5VJ8Iq8i6k/4osIHG8Rf8aqI4wTiT7Y=;
        b=Jo6J/huLnEbf/yZS5W+w7BYMRa6AdL6c8gj90unVxkYShNcgyDV9Hx75CnF5EedmMv
         DvFMQC6bWHWLO8pHV339tFjZCdPupRWZE8X5qFPl3JH+tanl/wtmcsTD3n3Y7116lnSp
         Jnt0sZqI494BpnhfZA8i34wKHuH2nnN23OTYVw6+IHlYaGzIg3PR7AnAHjKR8SA5ytVL
         CLYTAN9na5avHrA2TcUOQdYXhO7pVY7S+k9aBtTiXuPqSTUYSkzNzzX8+/8YW7ZL6gaX
         XXUzpx134Hdu+06vM1N2i2GEPwcyK6PfPKHSUvkjdoSGojAI9M25Z213IdnmPxUoYWoH
         rlTw==
X-Forwarded-Encrypted: i=1; AJvYcCV2fauQ5w+ueXMzxe6S5v10ux1fDSx/3P2JBOZ680r+/16LIo6ho1tPe4H4lkV7clpnyO0YYxLQQO4sL9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl56rVa9F/k1AS5G90/dQxnzD/4Nx4HWyYt2xKKzmsZpWDnNxJ
	fAleD/E19xyAAbucPzwzAQNNWiR0RbOdPwpQxmTG8Caf1aM+WZtff0Ewdli7IppW7i+qo4G0xpp
	rwLRo9PXjFRy7KsB4J0QPmRomZTBiP/7blrbyIg==
X-Gm-Gg: ASbGnctDG6TMWGVLaOlrxurqamV44rM/T1r0os8zxEgH1aWLyuUk4M22R7f4Tcl58TY
	UQW4kVIof35p7ze9/iigbRsJYKFtkCyr/LTQGwIlFF17SoIYOMx4e2DSdvGZRzq6EOY/RsB/uHm
	Vd0qLRKhKJJkqFErhjJw25wDvj
X-Google-Smtp-Source: AGHT+IHfHfrshSogOG0i4IcAYrvgOTnd8G9r2T28dussiCbapuii+jTnkJK5v4fmcr2pB+CEOqtZypPELtcFVBMou74=
X-Received: by 2002:a05:6902:2484:b0:e60:a241:84bb with SMTP id
 3f1490d57ef6-e611e1e53dbmr2915356276.26.1741163251412; Wed, 05 Mar 2025
 00:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com> <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
 <6506e448-3851-436f-9354-42f9ef844d27@huawei.com> <njnz5hxumrvqrgsfq7zlunle3jgfan3be34ao5xtkmzczpi6af@waywds2ww6qw>
 <c87613aa-1d17-4a88-acce-269ea9eddc22@huawei.com> <CAA8EJpo71m_ae9siT7f4Tsfr0C4XeoraqPYPsPp0gz-N+oMOjw@mail.gmail.com>
 <6e54c88f-dfaf-462d-b66b-c237d19faec6@huawei.com> <zzi2h52xiernm32h7i7xtrlnjwaqc3n2tx33ypmhw6quoi5qyg@pilzj5zantii>
 <fce2e5e8-ba38-474d-891c-f8ab0de8d07e@huawei.com> <kdk7p6yhuvby2nyqriufj3jo7kkyxv4ml4awdhszkehv2r2om3@cvho3j27hmwx>
 <3465ce51-a844-4c77-8e80-179d5ca279cc@huawei.com>
In-Reply-To: <3465ce51-a844-4c77-8e80-179d5ca279cc@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 5 Mar 2025 09:27:20 +0100
X-Gm-Features: AQ5f1JozWElSEoofiFEaVq2FjF0NOrV6b92xHl9Z_oztaKLwn8OJzFF9TMlLqaY
Message-ID: <CAA8EJprPAdsUS7FJCDmMnk7YZ7yM-=M15dEFcJhAg+CEezQSaQ@mail.gmail.com>
Subject: Re: [PATCH v3 drm-dp 7/8] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 08:29, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
>
> > On Tue, Mar 04, 2025 at 10:23:14AM +0800, Yongbang Shi wrote:
> >>> On Mon, Mar 03, 2025 at 01:02:44PM +0800, Yongbang Shi wrote:
> >>>>> On Sat, 1 Mar 2025 at 11:54, Yongbang Shi <shiyongbang@huawei.com> wrote:
> >>>>>>> On Sat, Mar 01, 2025 at 04:45:40PM +0800, Yongbang Shi wrote:
> >>>>>>>>> On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
> >>>>>>>>>>> On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> >>>>>>>>>>>>> On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> >>>>>>>>>>>>>>> On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> >>>>>>>>>>>>>>>>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> >>>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>>> +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> >>>>>>>>>>>>>>>>>> +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> >>>>>>>>>>>>>>>>>> +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> >>>>>>>>>>>>>>>>>> +  int ret;
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +  if (dp->hpd_status) {
> >>>>>>>>>>>>>>>>>> +          hibmc_dp_hpd_cfg(&priv->dp);
> >>>>>>>>>>>>>>>>>> +          ret = hibmc_dp_prepare(dp, mode);
> >>>>>>>>>>>>>>>>>> +          if (ret)
> >>>>>>>>>>>>>>>>>> +                  return ret;
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +          hibmc_dp_display_en(dp, true);
> >>>>>>>>>>>>>>>>>> +  } else {
> >>>>>>>>>>>>>>>>>> +          hibmc_dp_display_en(dp, false);
> >>>>>>>>>>>>>>>>>> +          hibmc_dp_reset_link(&priv->dp);
> >>>>>>>>>>>>>>>>>> +  }
> >>>>>>>>>>>>>>>>> If I understand this correctly, you are using a separate drm_client to
> >>>>>>>>>>>>>>>>> enable and disable the link & display. Why is it necessary? Existing
> >>>>>>>>>>>>>>>>> drm_clients and userspace compositors use drm framework, they should be
> >>>>>>>>>>>>>>>>> able to turn the display on and off as required.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> >>>>>>>>>>>>>>>> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> >>>>>>>>>>>>>>>> the different video modes into DP registers.
> >>>>>>>>>>>>>>> Why? The link training and mode programming should happen during
> >>>>>>>>>>>>>>> pre_enable / enable stage (legacy or atomic).
> >>>>>>>>>>>>>> Hi Dmitry,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> >>>>>>>>>>>>>> And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> >>>>>>>>>>>>> It should be userspace, who triggers the enable/disable (or it should
> >>>>>>>>>>>>> be the in-kernel fbdev / fbcon, which interface through the generic
> >>>>>>>>>>>>> drm_fbdev client).
> >>>>>>>>>>>> Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> >>>>>>>>>>>> by user, but it won't call when HPD triggered .
> >>>>>>>>>>> - Is HPD even properly delivered to userspace? What kind of compsitor
> >>>>>>>>>>>         are you using? Is .detect working properly and reporting a correct
> >>>>>>>>>>>         plug-in state?
> >>>>>>>>>> Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
> >>>>>>>>>> this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
> >>>>>>>>>> I use Xorg, and the display service is GDM.
> >>>>>>>>>> The .detect is called and the getting modes info is correct.
> >>>>>>>>>> I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
> >>>>>>>>> You can go to the display settings in GDM. It would be interesting to
> >>>>>>>>> observe if it notes the second monitor or not. Last, but not least, you
> >>>>>>>>> can use a simple tool like 'xrandr' under your XOrg session to set the
> >>>>>>>>> display resolution.
> >>>>>>>> Thank you for your advice!
> >>>>>>>> Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
> >>>>>>>> So do I need to clear the vga connector, if dp is plugged in?
> >>>>>>> Unless your hardware can not manage two outputs at the same time, no,
> >>>>>>> you don't have to. Just check how it behaves on x86 systems. Ideally
> >>>>>>> your driver should have the same behaviour.
> >>>>>> Our hardware cannot support two outputs with different timing, so I used the one crtc and one plane that DP and VGA share. And just add a new DP connector
> >>>>>> with a encoder, just like the previous VGA's code logic. But the HPD problem makes me feel confused, should I change the framwork structure to slove this problem?
> >>>>> I think registering a single CRTC is a correct way. Then it is logical
> >>>>> that there is no mode set on the DP when you connect it. The userspace
> >>>>> can not output any data. However if you disconnect VGA and connect DP
> >>>>> then it should become active and should output your desktop
> >>>>> environment.
> >>>> Okay, Thank you for your guidance. So I need to disconnect VGA when I get the HPD (plugged in) , then
> >>>> userapce will active and enanble DP, right?
> >>> Yes.
> >> I'm sorry for that, just wanna make sure one more thing. I found if I only set the VGA connector's status to disconnected when HPD plugged in, it won't be active.
> > Huh? You should implement hibmc_connector_funcs.detect() or
> > .detect_ctx() to report VGA connector's status. Use
> > ast_vga_connector_helper_detect_ctx() as an inspiration.
>
> Okay, thanks for your correcting, I'll try to add drm_connector_helper_detect_from_ddc() in VGA's detect_ctx.
> And also, I wanna make sure that do I need to unplug the VGA monitor manually when I plug in DP, or just
> set the status of VGA connector to disconnected in interrupt handler.

If the HPD reports the status of the DP connector, why do you want to
change the status of the VGA connector?

>
>
> >> And If I add drm_cleanup_connector() for VGA, it work. So is this okay that I use this cleanup in HPD?
> > drm_connector_cleanup() should only be callsed if the connector is going
> > to be destroyed. You should not be callign that function.
> >
> >>
> >>>>>> And also, I will check whether this driver works good on the x86 server. Right now, I'm testing on arm64 server.
> >>>>>>
> >>>>>>>> And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
> >>>>>>>> but there are errs when set some low resolutions.
> >>>>>>> That's a separate topic, most likely related to timing or to some other
> >>>>>>> issues. You can fix that separately (but please do, switching modes
> >>>>>>> should work).
> >>>>>> Okay!
> >>>>>>
> >>>>>>



-- 
With best wishes
Dmitry

