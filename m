Return-Path: <linux-kernel+bounces-539917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF5A4AAD0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64EE1897BDC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DD1D90AD;
	Sat,  1 Mar 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNqntUkY"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BA23F37D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829544; cv=none; b=bnGQu6cGzDq4MORcOC69dPxUSkWOVDpL7jyUH0dTrH7jZKKSyOqslBHXAk/gp5fJMNZjwzXEhsIWJM8DCqh1s4S1sTGyNX/1eABWDlfvZZJYmXQNJ0oZ31vjDzQtDClSg4PF058xxBl2OS2cFVSkwJjKAuIViznax/NmXpQf4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829544; c=relaxed/simple;
	bh=bQNngq3YUR6OHOaixcCrFhLENfwp9TaNS4P5nWNQzNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJJbPVzD+6wQ7/7IS5G52xO6/SvHBV2D+aHcVjiphG2XlpEg1G0AMo9hqWY+v3luXjMT0kUbrDiHdzC+xuixwQx9bA4K5CaNXg44pj29DccbGrJqWPh48yhs+a/PnxjMfdac+B/8PeRn485580vD8Wer9NiuKZYgKyS18pAXXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNqntUkY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6ca9a3425so26788597b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740829541; x=1741434341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wPdFtRIcEJljlyiH4UNQ0Wo6ovomIZEN33SfT6PWHDw=;
        b=fNqntUkY8M1FPYu34RwteDdQrrzJRWBltTk2Uz3RfwkGbFuwZpODSZvO1c0r6qbu8g
         mGT8YgAHZwaFITsNXU4LZ2aidBGPYhjHI2v4mRvMmKImw5w7OW3F+VFAe/SrMtDDGQrp
         7NXOBCmfPjs01F2LRXM1vq2vtXVOZgwU6HpUmlCDonB6vHeqIrAn3gaQ6AJ12ejRGd2d
         Qt017y4HM0SyfGGnmeD0iz6LxkCpO5s2iv+bpCtRkGWOERLqeBaTH68ukygt+juLj3tm
         00xsDe2/vqf9EW+W0ZsnjIxIrIwMfOSlwp3wNt+hv1hKYzDCy4iqml4A2KzuZ4msEY2T
         6/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829541; x=1741434341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPdFtRIcEJljlyiH4UNQ0Wo6ovomIZEN33SfT6PWHDw=;
        b=B1rW0Pi1WnfMHrQq4fucVxkIuAi1YFh0sZA8F/PTDTh9D5sB0Cb2YM0+BE/UbdBIFj
         ItsBHmM0lv7bv2fdEAWSXrEEKdl9lilvaNPxg0P4wCYgTCvwBn1LwhIeXtNBDl4b19YW
         GMMoJmDzkcA4hkxPN/sPd352h5J/EAbddMSfLMt8w8D3+LmqssEmMf6mHd00h8OgOks4
         HJs/fBgKVquZqqCeT/ynvFLX1IK4jUqCWfPlPGTJRzA3qY9UZZf5yYhSjymSLbN8N/FK
         PgZk/OZWCiQPezL+l6+1v2ioD7+IR39fxmCNtThlkfstGKf2Epo+Cg9uEeyT++OV/fD7
         vQow==
X-Forwarded-Encrypted: i=1; AJvYcCULXce1kCShu6wZs7msf4qc3qypDLTGK+2D4qTcfjXGItTCBpSGbTsDIyrsm6lk4rwziGGGff1S8qyFQlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0kUYodluJPVSwEpY/uNT4D6m+9anATEKO58gXFgW+d3yUq7W
	9HKVU1ZesWYR4CDlWpRxgSHHilWhgpM/pg7oDaYCekltPg10PMdq8j1zNV/BrjiK+9xnvJS73hI
	M531wRJ/DKjOe9YxCb68eBDNpGMMGrKB5qNF04g==
X-Gm-Gg: ASbGncvf43aRQQQEKYyBArNaz52JfNhgaYSBJ42lt+rowbAdWEloJI5NdEn7Q+h7CFS
	3cWY3fHYG3WGalO7+Lx3wDOUaDLzns8AKyIvNRVM/shyHEsH4UJN2/G3AlriQJC5LsJM85l9OZC
	gKJYcum1H1jidOppVfUgE/uFiLeDxqMmW7FU5Us2Jx
X-Google-Smtp-Source: AGHT+IHgRqqiTqKK9xWzlnJl9nuXClN9+LmtvWVEfm6elxrtnetY9R0eCj0ZsKS6jravLjWFcCumIH9iOwPR7gur47c=
X-Received: by 2002:a05:6902:98e:b0:e57:346f:5b12 with SMTP id
 3f1490d57ef6-e60b2eacc43mr6998903276.18.1740829541019; Sat, 01 Mar 2025
 03:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <reqpxlbvlz5qssgy6gbjuou33h4zevo4xeztqbsr4keehplyhx@utv22a5ihohx>
 <eef68fc7-30f4-4246-a82e-4f90cd6a665d@huawei.com> <6jx5ldpidy2ycrqognfiv5ttqr5ia4dtbryta3kc2mkndrvvgo@qzuakucz765k>
 <6634386b-afc1-4e31-a2f4-9c1afed2d1d8@huawei.com> <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com> <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com> <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
 <6506e448-3851-436f-9354-42f9ef844d27@huawei.com> <njnz5hxumrvqrgsfq7zlunle3jgfan3be34ao5xtkmzczpi6af@waywds2ww6qw>
 <c87613aa-1d17-4a88-acce-269ea9eddc22@huawei.com>
In-Reply-To: <c87613aa-1d17-4a88-acce-269ea9eddc22@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 1 Mar 2025 13:45:30 +0200
X-Gm-Features: AQ5f1JovDIdMFleM78uUNt49Eq12cxxY-CMeDTA14F_begq8E4NvDwe6hIZMAW4
Message-ID: <CAA8EJpo71m_ae9siT7f4Tsfr0C4XeoraqPYPsPp0gz-N+oMOjw@mail.gmail.com>
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

On Sat, 1 Mar 2025 at 11:54, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
>
> > On Sat, Mar 01, 2025 at 04:45:40PM +0800, Yongbang Shi wrote:
> >>> On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
> >>>>> On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> >>>>>>> On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> >>>>>>>>> On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> >>>>>>>>>>>> +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> >>>>>>>>>>>> +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> >>>>>>>>>>>> +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> >>>>>>>>>>>> +  int ret;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +  if (dp->hpd_status) {
> >>>>>>>>>>>> +          hibmc_dp_hpd_cfg(&priv->dp);
> >>>>>>>>>>>> +          ret = hibmc_dp_prepare(dp, mode);
> >>>>>>>>>>>> +          if (ret)
> >>>>>>>>>>>> +                  return ret;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +          hibmc_dp_display_en(dp, true);
> >>>>>>>>>>>> +  } else {
> >>>>>>>>>>>> +          hibmc_dp_display_en(dp, false);
> >>>>>>>>>>>> +          hibmc_dp_reset_link(&priv->dp);
> >>>>>>>>>>>> +  }
> >>>>>>>>>>> If I understand this correctly, you are using a separate drm_client to
> >>>>>>>>>>> enable and disable the link & display. Why is it necessary? Existing
> >>>>>>>>>>> drm_clients and userspace compositors use drm framework, they should be
> >>>>>>>>>>> able to turn the display on and off as required.
> >>>>>>>>>>>
> >>>>>>>>>> Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> >>>>>>>>>> We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> >>>>>>>>>> the different video modes into DP registers.
> >>>>>>>>> Why? The link training and mode programming should happen during
> >>>>>>>>> pre_enable / enable stage (legacy or atomic).
> >>>>>>>> Hi Dmitry,
> >>>>>>>>
> >>>>>>>> Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> >>>>>>>> And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> >>>>>>> It should be userspace, who triggers the enable/disable (or it should
> >>>>>>> be the in-kernel fbdev / fbcon, which interface through the generic
> >>>>>>> drm_fbdev client).
> >>>>>> Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> >>>>>> by user, but it won't call when HPD triggered .
> >>>>> - Is HPD even properly delivered to userspace? What kind of compsitor
> >>>>>      are you using? Is .detect working properly and reporting a correct
> >>>>>      plug-in state?
> >>>> Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
> >>>> this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
> >>>> I use Xorg, and the display service is GDM.
> >>>> The .detect is called and the getting modes info is correct.
> >>>> I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
> >>> You can go to the display settings in GDM. It would be interesting to
> >>> observe if it notes the second monitor or not. Last, but not least, you
> >>> can use a simple tool like 'xrandr' under your XOrg session to set the
> >>> display resolution.
> >> Thank you for your advice!
> >> Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
> >> So do I need to clear the vga connector, if dp is plugged in?
> > Unless your hardware can not manage two outputs at the same time, no,
> > you don't have to. Just check how it behaves on x86 systems. Ideally
> > your driver should have the same behaviour.
>
> Our hardware cannot support two outputs with different timing, so I used the one crtc and one plane that DP and VGA share. And just add a new DP connector
> with a encoder, just like the previous VGA's code logic. But the HPD problem makes me feel confused, should I change the framwork structure to slove this problem?

I think registering a single CRTC is a correct way. Then it is logical
that there is no mode set on the DP when you connect it. The userspace
can not output any data. However if you disconnect VGA and connect DP
then it should become active and should output your desktop
environment.

>
> And also, I will check whether this driver works good on the x86 server. Right now, I'm testing on arm64 server.
>
> >> And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
> >> but there are errs when set some low resolutions.
> > That's a separate topic, most likely related to timing or to some other
> > issues. You can fix that separately (but please do, switching modes
> > should work).
>
> Okay!
>
>


-- 
With best wishes
Dmitry

