Return-Path: <linux-kernel+bounces-541044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF98A4B7C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7268718916A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAFD1E22FA;
	Mon,  3 Mar 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbME5r0I"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1BEADC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981430; cv=none; b=msqBNwzY1dm/fbYKYIg/dEyHFycJBhaOs8vcyqjSVDTeZW5+236H/5sv5uuvHOHAkf2GOebKI21Y4RGIDdCmFzEsjcTjockCsNFzC/kXiJyfUy7Pr8VfOX/gAOA1F9kenxNOSJ5l/xGGOC9+sRoxI2DxosNm19HmG08aw9Yekec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981430; c=relaxed/simple;
	bh=1iXgfGz8aCzzOVaz9fAAhwHgGGeKfeq21gh9vGmS1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrSt5nsdN3XX8HRGvkwQJQOqeqr9eDlVPCH8gyMjGqIqru4dTVYNLC8LA3QxJkPexxn4lHovJj9oqfN1Nn44B0SJ5tr7UMJWqlu7Rrc/wMhLma4BK7453svwB/JDCKO56spqbPgu5lnzBwZAB4/mPtvNPW7sj6vAsys5XlCZPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MbME5r0I; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54957f0c657so2415051e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740981426; x=1741586226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWBERfZwdl/ZLDNsSZCDejFbWH27yw+tz7Ij819/Y+c=;
        b=MbME5r0I5xSJRzbfPL3uRgVd+g0dSwIDG0f2WNXu3q5dGEshRb9xJeQaoOyHVRX/62
         CsqOkEwNeFwk636HANu6hFzSRBpcbjaVTHzIBOznUT37uW80ofWvH5TjHW+gs2PGut/N
         7VNT6ggz7OWb8FmIrgfNzrAjLvHof6KKGzbiIFdCKoEO21IRXUFtp9psaWTy/4t+f503
         VYYpOdZr1G0rORJ+a51qqKswzo/bGQiunssblEowG8UFNCJv9uHp4bmNjdPzqVN49dNA
         iwkHM9qAFkHLkEwPwFFqPUgiY6bTMsEDU1pTh1oNu8fk19uddMvhkPr34Gvxro6NLsfJ
         Hbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740981426; x=1741586226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWBERfZwdl/ZLDNsSZCDejFbWH27yw+tz7Ij819/Y+c=;
        b=mxbOubmHu+PLxsk0EDGgU8GkSpDQJ5fp6yDaY/sE/MyOKgGV3TfDlvqTh6chBjxaUf
         IQ4wt18MOwMTI6f3n5CfTJjOOv3KjGf+70/Y2eECdAmriEUOqDb1irCbb9oy8YrtQ60L
         YWwg9IAb2uoSz+R2O2jwRGr4sCLfrPd8A0ptzlJsA79NI9AzHYwYZ8901gIsWk1cIkIB
         vlkhLgg2Tjcc1LmjGTZCK3L8+0qI8BGPnqGcyJMyJYOxBFm8bmA5vx9xatYMRVFqIsTD
         C/dh8EBW6y3zLlnuPhOFP6BgdPlYLwPL6FbglzGEeIFvFMAP39EltFKlQUVNRRuim9mN
         hIGw==
X-Forwarded-Encrypted: i=1; AJvYcCV1KhPmccEtAyly8j03ajbaAXr65hXhn93j4krT6QrHf/gWWx+duHuzJpRz97HJ0xcuAC+7YX0b6Ccj4V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirYgAhwOrh4Lirlyvo9KtXkGd6HkXVcFBJwv/DL4zW2VHNNQc
	POJ8Eny6PY93wxnvM45l8aAleS4iI+IO/22Nhyxio7DIqPSIWbFfJzTTDOhwsxg=
X-Gm-Gg: ASbGnctq36lerTj0HNp0BuMvyzDlQP9cutUlJ/DWhqarGVGUUOdbbmGEh8IYktodxnC
	0nU3F4He2hxLrdM7nD6COcoBVD1igFNj4QHyqpblhbIXliatgaWihjNa0qm6xBDJDjDZ1+OgCag
	9LkYitts15byPpq35hTmIxcOhfdrEiu8s+VqXgDR+w/u3C/TZgjJUHMRBz5gMFTfC3xlYMI0WuX
	KKokCjgv6V7fQ/w9hLNvuRajREYrWTs84/qPRHVN2jlPPujtZKtobHJjvXenRFLR8qihZDvcCPB
	RQ8jBdm8lfKBKGZpCj2KoPGPY26qrS+HKRaH9+yXz2HXFFDcuFLn/eQDGYLI5Yp3I+5lRKoIvIm
	soBBT7KjQhdI9qJqToWjwNJxT
X-Google-Smtp-Source: AGHT+IGIC/s5MUT4pFlpat5x0cb77+1fbUQt3ZrQqYTEYQAarXWRgBC0UpZ1rzDKYIgWH6QxoU9hgg==
X-Received: by 2002:a05:6512:a8b:b0:545:8c8:30f2 with SMTP id 2adb3069b0e04-5494c107d86mr4882774e87.1.1740981426320;
        Sun, 02 Mar 2025 21:57:06 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495f27fd5fsm438707e87.255.2025.03.02.21.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:57:04 -0800 (PST)
Date: Mon, 3 Mar 2025 07:57:02 +0200
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
Message-ID: <zzi2h52xiernm32h7i7xtrlnjwaqc3n2tx33ypmhw6quoi5qyg@pilzj5zantii>
References: <CAA8EJpqHmhUxLE57XNeh-nVtSP7WvtBE=FiFWk9kqM_P+AC=0A@mail.gmail.com>
 <5af62fa9-e71b-412f-8640-502f03fcaa52@huawei.com>
 <vrsy4hao4qu3hlcbmjyfyibeearhhjgtik3e6o3v2eyzkatdve@kdb7cyvl45tu>
 <ade54ddd-79ea-4335-9058-c17e4525e83f@huawei.com>
 <4hicem4rbz5l7wnzaaz3krrl3euh2dmvlah2rb7errrdq5fann@44dvdxirkuzh>
 <6506e448-3851-436f-9354-42f9ef844d27@huawei.com>
 <njnz5hxumrvqrgsfq7zlunle3jgfan3be34ao5xtkmzczpi6af@waywds2ww6qw>
 <c87613aa-1d17-4a88-acce-269ea9eddc22@huawei.com>
 <CAA8EJpo71m_ae9siT7f4Tsfr0C4XeoraqPYPsPp0gz-N+oMOjw@mail.gmail.com>
 <6e54c88f-dfaf-462d-b66b-c237d19faec6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e54c88f-dfaf-462d-b66b-c237d19faec6@huawei.com>

On Mon, Mar 03, 2025 at 01:02:44PM +0800, Yongbang Shi wrote:
> 
> > On Sat, 1 Mar 2025 at 11:54, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > 
> > > > On Sat, Mar 01, 2025 at 04:45:40PM +0800, Yongbang Shi wrote:
> > > > > > On Thu, Feb 27, 2025 at 09:46:10PM +0800, Yongbang Shi wrote:
> > > > > > > > On Tue, Feb 25, 2025 at 09:57:17PM +0800, Yongbang Shi wrote:
> > > > > > > > > > On Mon, 24 Feb 2025 at 16:03, Yongbang Shi <shiyongbang@huawei.com> wrote:
> > > > > > > > > > > > On Sat, Feb 22, 2025 at 06:35:48PM +0800, Yongbang Shi wrote:
> > > > > > > > > > > > > > > +static int hibmc_dp_hpd_event(struct drm_client_dev *client)
> > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > +  struct hibmc_dp *dp = container_of(client, struct hibmc_dp, client);
> > > > > > > > > > > > > > > +  struct hibmc_drm_private *priv = to_hibmc_drm_private(dp->drm_dev);
> > > > > > > > > > > > > > > +  struct drm_display_mode *mode = &priv->crtc.state->adjusted_mode;
> > > > > > > > > > > > > > > +  int ret;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +  if (dp->hpd_status) {
> > > > > > > > > > > > > > > +          hibmc_dp_hpd_cfg(&priv->dp);
> > > > > > > > > > > > > > > +          ret = hibmc_dp_prepare(dp, mode);
> > > > > > > > > > > > > > > +          if (ret)
> > > > > > > > > > > > > > > +                  return ret;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +          hibmc_dp_display_en(dp, true);
> > > > > > > > > > > > > > > +  } else {
> > > > > > > > > > > > > > > +          hibmc_dp_display_en(dp, false);
> > > > > > > > > > > > > > > +          hibmc_dp_reset_link(&priv->dp);
> > > > > > > > > > > > > > > +  }
> > > > > > > > > > > > > > If I understand this correctly, you are using a separate drm_client to
> > > > > > > > > > > > > > enable and disable the link & display. Why is it necessary? Existing
> > > > > > > > > > > > > > drm_clients and userspace compositors use drm framework, they should be
> > > > > > > > > > > > > > able to turn the display on and off as required.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > Thanks for your asking, there are cfg/reset process when the connector 's pluging in/out.
> > > > > > > > > > > > > We want to cfg DP registers again when the connector changes. Not only dp link training, but also cfg
> > > > > > > > > > > > > the different video modes into DP registers.
> > > > > > > > > > > > Why? The link training and mode programming should happen during
> > > > > > > > > > > > pre_enable / enable stage (legacy or atomic).
> > > > > > > > > > > Hi Dmitry,
> > > > > > > > > > > 
> > > > > > > > > > > Right, that's what I'm curious about. It won't call encoder enble/disable functions when I triggered HPD.
> > > > > > > > > > > And I'm sure the drm_connector_helper_hpd_irq_event() is called. So I add a drm_client for it.I
> > > > > > > > > > It should be userspace, who triggers the enable/disable (or it should
> > > > > > > > > > be the in-kernel fbdev / fbcon, which interface through the generic
> > > > > > > > > > drm_fbdev client).
> > > > > > > > > Right, I knew it. When I insmode my driver firstly (or restart display service), it will call disable, modeset and enable,
> > > > > > > > > by user, but it won't call when HPD triggered .
> > > > > > > > - Is HPD even properly delivered to userspace? What kind of compsitor
> > > > > > > >       are you using? Is .detect working properly and reporting a correct
> > > > > > > >       plug-in state?
> > > > > > > Thanks for your answering. I'm not very good understanding about userspace in framework. In my opinion, when I call
> > > > > > > this drm_connector_helper_hpd_irq_event(), the HPD will deliver to userspace.
> > > > > > > I use Xorg, and the display service is GDM.
> > > > > > > The .detect is called and the getting modes info is correct.
> > > > > > > I find that it would only trigger(disable, modeset and enable), when I changed resolutions, restart display service and insmod driver.
> > > > > > You can go to the display settings in GDM. It would be interesting to
> > > > > > observe if it notes the second monitor or not. Last, but not least, you
> > > > > > can use a simple tool like 'xrandr' under your XOrg session to set the
> > > > > > display resolution.
> > > > > Thank you for your advice!
> > > > > Right, there are DP and VGA two monitors. I tried to totally remove the vga connector in driver, the problem is gone.
> > > > > So do I need to clear the vga connector, if dp is plugged in?
> > > > Unless your hardware can not manage two outputs at the same time, no,
> > > > you don't have to. Just check how it behaves on x86 systems. Ideally
> > > > your driver should have the same behaviour.
> > > Our hardware cannot support two outputs with different timing, so I used the one crtc and one plane that DP and VGA share. And just add a new DP connector
> > > with a encoder, just like the previous VGA's code logic. But the HPD problem makes me feel confused, should I change the framwork structure to slove this problem?
> > I think registering a single CRTC is a correct way. Then it is logical
> > that there is no mode set on the DP when you connect it. The userspace
> > can not output any data. However if you disconnect VGA and connect DP
> > then it should become active and should output your desktop
> > environment.
> 
> Okay, Thank you for your guidance. So I need to disconnect VGA when I get the HPD (plugged in) , then
> userapce will active and enanble DP, right?

Yes.

> 
> 
> > > And also, I will check whether this driver works good on the x86 server. Right now, I'm testing on arm64 server.
> > > 
> > > > > And also, I used xrandr to set modes after 'startx'. Changing resolutions works,
> > > > > but there are errs when set some low resolutions.
> > > > That's a separate topic, most likely related to timing or to some other
> > > > issues. You can fix that separately (but please do, switching modes
> > > > should work).
> > > Okay!
> > > 
> > > 
> > 

-- 
With best wishes
Dmitry

