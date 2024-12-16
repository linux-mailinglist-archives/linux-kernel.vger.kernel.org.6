Return-Path: <linux-kernel+bounces-447085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF09F2D26
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D413518834CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE335201253;
	Mon, 16 Dec 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjLvOrrx"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D381200BB8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342195; cv=none; b=fNCbr4aCxUs8hmWUYO2iRqHXRBnLZDqfrIWo2vsOsVxdmkSxG7jOYHRMkhwVATptHvBCtBJuVUk6OHbuUwZ/ZZPnHkzYVUBiEV8pMExW55NkAfSL3/e5wBXmDDYnfKDfzTUn77m9xkqJxyAdc91bHWK7NSD9XB5Q4v7OzIzIIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342195; c=relaxed/simple;
	bh=marRKKdDm3CBUf16BHSRLoHXTUouVZCY1Mf8jiqg/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alFDELU1oqnLMCGoGHZmVqLlOqn2glE0y4I3ozq9J10OooXCHVO9EzB8no6yquCVH2oyF4y82u/PhuaeffkxQ8Omp3UgWTwpEsQsB50RF71q0xjR/mLFp1XK+Mvr+cyEoP43H8v8bLvqc0mxW24JJ+wgj2oamVNgrO25Ds++bfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjLvOrrx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3022c61557cso41124251fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734342191; x=1734946991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZqtHo3meR/iDgRvma//JvJtYjecjZ0rAvoCSKnHh50=;
        b=jjLvOrrx+BMIpZL2rlfhsFHTOKNxqNXcqwNyjW2avUCORU8wEvq9MFKoVXkJPhJYH1
         4a55N5MYmwnCtEv4t91AHCuS6752xnYV1mDqzUctnbAet45UWlVlPSR56m+BBvFohlF6
         H5uk3aXdAB0w+57evCzKw+1S0QR27nGz50iwTmbAue6N8I8Hj+5BpO3yKm/39FGrIrG4
         hfLDABX14IWdJnVeg0mc/7p757oTJBfZ7EiEqSd4VFmAnjarFY3UjSxO979GRup2yN83
         i+zyDC+tYOSkEPi3osc46uVUKep9rwxtZ/YR1365vyYdso0TVUwTOCsguJyech+4GOy9
         iNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342191; x=1734946991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZqtHo3meR/iDgRvma//JvJtYjecjZ0rAvoCSKnHh50=;
        b=K//wnH3KXudKnVTeoO/kSCzfqfXC5D8v55RUwb7dvCAfgSzBtqT4gyZjtu5aAsJpKP
         x3IYlyoXl3o67QL2NiHrxAfjvfHbx3pYCNUkp4Zv19QoHU7Q6vvTc1/OpBMsTrGCLNFE
         LKZB9HfBd1IiTi3FfiLK9JGjpisW2XKEo8OYyoEZBq0rO0MNHS6SXP2NcpX4AmwDKwIw
         mLju8YBjc/k57YyoA9BVvfBTm9F6+ABJen3TGZhhb8H5h3yzqOwjxJ5579t4n8/C5yPG
         H9B9q0QmWTP0dJUGEmXhfSuhTUj5YVx4eeHs3LxtBA3LOuY1A9QQBPGZLn5E2GyR4d2r
         Izuw==
X-Forwarded-Encrypted: i=1; AJvYcCWt7b54z2XTkEdTEbfh/47euDhBHjcN8XDSdhkh0OKbEt0ZTN8d7HixU/rN7jxcWGVCvhDH3evCG/aHH2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGqOzIr9hNW7vUoqykWFBJ9dsC6DBqgltyUUqhoWW8NEm65nZ
	xY4EC4f7004NbLDAMVPHs8ZKtWNnfzrKn/3BxvC+vZvfpbPwkl7T6DYooXkVwoo=
X-Gm-Gg: ASbGncsAuxPtQQLgEhRt9tYO2Bw82fIrS3EHHiYWqQDXrQJbdidIdvR2gFkZm4xJnvb
	5PUuKDirLfLtbFw64oK13jPyJzuEB3tBcakkJD1YbY1KNYfL10YA50bgq+Cj144cc9BUwtqPcrO
	LSqtVlkdNbxAUsksSuSsr7gPRTB6Pvx2UXW8yWAblXwz7iGSYzczZZKDp6IuPKuZaAsUZvK0km5
	yQdgd5J/7nEBnnTPS8eFjPOJI4tmAb8ZDMtUAS5bZEOklTv3icgyM0Nirw4421to9mG78LiV/GS
	c9u0LaoEfLS5nbWPTMopf/TGgQ1mBgDPllF2
X-Google-Smtp-Source: AGHT+IG5bcxxuzH2khEETnU+th7qZ63UO+GJmzR1lIjc43+w6V0SPKBvLt8wOikZk2L+ZZ8bs68gOA==
X-Received: by 2002:a05:651c:54a:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-302544cc8camr39577691fa.37.1734342191248;
        Mon, 16 Dec 2024 01:43:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344175b76sm8512861fa.90.2024.12.16.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:43:09 -0800 (PST)
Date: Mon, 16 Dec 2024 11:43:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bernie Liang <bliang@analogixsemi.com>, Qilin Wen <qwen@analogixsemi.com>, 
	"treapking@google.com" <treapking@google.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
 atomic_enable()
Message-ID: <fyltwqxyrmy3rz75nosc4wn6z5zglwv7pelzdf5g6ztloq4ncj@yigwmszuhigb>
References: <20241212055110.1862487-1-xji@analogixsemi.com>
 <vkrl7om7hepboovp2uivcnernia3ygqwrj3y3kkjydeclwvrk5@7tkdc4etkcjs>
 <BY5PR04MB673977C1DB1E774CB261C119C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <4q2jncpnmeu7ytuyuv5pjzurh3ai5663jmu2we6cebuad2r3r5@tfb6hf6unioc>
 <BY5PR04MB673902E047FF8ADAFD8B94B3C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <CAA8EJprGjuGFjZnXUxiMZMV=FO9O9CYt06H_nSL82fEOvPytyA@mail.gmail.com>
 <BY5PR04MB6739C5804F0E9764EFD3A3EBC73B2@BY5PR04MB6739.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6739C5804F0E9764EFD3A3EBC73B2@BY5PR04MB6739.namprd04.prod.outlook.com>

On Mon, Dec 16, 2024 at 08:33:23AM +0000, Xin Ji wrote:
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Friday, December 13, 2024 9:17 PM
> > To: Xin Ji <xji@analogixsemi.com>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent Pinchart
> > <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>;
> > Jernej Skrabec <jernej.skrabec@gmail.com>; Maarten Lankhorst
> > <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>;
> > Thomas Zimmermann <tzimmermann@suse.de>; David Airlie
> > <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bernie Liang
> > <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com>;
> > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > atomic_enable()
> > 
> > CAUTION: This email originated from outside of the organization. Please do not
> > click links or open attachments unless you recognize the sender, and know the
> > content is safe.
> > 
> > 
> > On Fri, 13 Dec 2024 at 13:00, Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > Hi Dmitry, sorry, I didn't clear describe the reason.
> > 
> > Please. Do not top-post. Please paste your answer under the question, not
> > somewhere at the top of the email. This allows us to have a more constructive
> > dialog. Additional bonus if you can fix your email client to insert sensible quoting
> > information instead of dumping the headers of the original email.
> Hi Dmitry, OK, sorry about it. Currently, we have problem to fetch email from
> Microsoft on Ubuntu. I'll try to fix it later.
> > 
> > >
> > > Anx7625 implement DSI to DP convert behind USB Type-C port, when user
> > > plug into USB Type-C Dongle with DP monitor, the user space will
> > > enable HDCP feature, then kernel do HDCP and output display and set
> > > HDCP content to ENABLE, but the issue happened if user manually change the
> > monitor's resolution later.
> > >
> > > Each time user change the resolution, kernel will call bridge
> > > interface .atomic_disable() and .atomic_enable(), the old driver will
> > > keep HDCP state to ENABLE, this is a BUG, when user change the
> > > resolution, kernel must change HDCP content too (mustn't keep to
> > > ENABLE),
> > 
> > Why? Could you please point me to the corresponding documentation or a code
> > path in the other driver? Preferably i915, AMD or Nouveau.
> As https://elixir.bootlin.com/linux/v6.12.5/source/drivers/gpu/drm/drm_connector.c#L1423: 
>         - ENABLED -> DESIRED (termination of authentication)
> As there is no other interface to tell anx7625 bridge driver, so the I think best place to handle
> ENABLE -> DESIRED in .atomic_disable().

I was looking for something like cdns_mhdp_connector_atomic_check(),
which switches to UNDESIRED if there is no new CRTC. Likewise i915
driver performs this in intel_hdcp_atomic_check() if there is a need for
modeset.

For the "termination of authentication" case see
cdns_mhdp_hdcp_check_link(), which detects if the HDCP got disabled by
HW and then updates the status accordingly.

> 
> > 
> > > as DRM doc said, kernel cannot change from ENABLE to UNDESIRE, so next
> > > patch, I'll change it to DESIRE in .atomic_disable().

This e.g. will result in HDCP being restarted for all modesets. Is this
an expected behaviour?

> > >
> > > Thanks!
> > > Xin
> > >
> > > > -----Original Message-----
> > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Sent: Friday, December 13, 2024 6:47 PM
> > > > To: Xin Ji <xji@analogixsemi.com>
> > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent
> > > > Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman
> > > > <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>;
> > > > Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> > David
> > > > Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bernie
> > > > Liang <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com>;
> > > > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > > > atomic_enable()
> > > >
> > > > CAUTION: This email originated from outside of the organization.
> > > > Please do not click links or open attachments unless you recognize
> > > > the sender, and know the content is safe.
> > > >
> > > >
> > > > On Fri, Dec 13, 2024 at 10:06:36AM +0000, Xin Ji wrote:
> > > > > Hi Dmitry, thanks for the review, I made some changes which change
> > > > > ENABLE to DESIRE in .atomic_disable(), I'll upstream it after testing. Thanks!
> > > >
> > > > - Please don't top-post.
> > > >
> > > > - You still didn't explain, why do you want to do this change of HDCP
> > > >   status. Could you please provide an explanation before sending the
> > > >   next iteration?
> > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > Sent: Thursday, December 12, 2024 5:18 PM
> > > > > > To: Xin Ji <xji@analogixsemi.com>
> > > > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > > > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>;
> > > > > > Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas
> > > > > > Karlman <jonas@kwiboo.se>; Jernej Skrabec
> > > > > > <jernej.skrabec@gmail.com>; Maarten Lankhorst
> > > > > > <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > > > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> > > > David
> > > > > > Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>;
> > > > > > Bernie Liang <bliang@analogixsemi.com>; Qilin Wen
> > > > > > <qwen@analogixsemi.com>; treapking@google.com;
> > > > > > dri-devel@lists.freedesktop.org; linux- kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status
> > > > > > at
> > > > > > atomic_enable()
> > > > > >
> > > > > > CAUTION: This email originated from outside of the organization.
> > > > > > Please do not click links or open attachments unless you
> > > > > > recognize the sender, and know the content is safe.
> > > > > >
> > > > > >
> > > > > > On Thu, Dec 12, 2024 at 01:51:10PM +0800, Xin Ji wrote:
> > > > > > > When user enabled HDCP feature, userspace will set HDCP
> > > > > > > content to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next,
> > anx7625
> > > > > > > will
> > > > update
> > > > > > HDCP
> > > > > > > content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down
> > > > stream
> > > > > > support
> > > > > > > HDCP feature.
> > > > > > >
> > > > > > > However once HDCP content turn to
> > > > > > DRM_MODE_CONTENT_PROTECTION_ENABLED
> > > > > > > userspace will not update the HDCP content to
> > > > > > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor
> > > > disconnect.
> > > > > >
> > > > > > It seems you've ingored a part of the previous review comment.
> > > > > > It's the userspace who triggers the ENABLED -> UNDESIRED
> > > > > > transition, not the kernel side. The change to move HDCP
> > > > > > handling to atomic_enable() looks fine, the change to disable
> > > > > > HDCP is not (unless I misunderstand
> > > > something).
> > > > > >
> > > > > > >
> > > > > > > So, anx7625 driver move hdcp content value checking from
> > > > > > > bridge interface .atomic_check() to .atomic_enable(), then
> > > > > > > update hdcp content according from currently HDCP status. And
> > > > > > > also disabled HDCP in bridge interface .atomic_disable().
> > > > > > >
> > > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 74
> > > > > > > ++++++++++++++---------
> > > > > > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > index a2675b121fe4..f96ce5665e8d 100644
> > > > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct
> > > > > > > anx7625_data
> > > > > > *ctx)
> > > > > > >                                TX_HDCP_CTRL0, ~HARD_AUTH_EN &
> > > > > > > 0xFF); }
> > > > > > >
> > > > > > > +static void anx7625_hdcp_disable_and_update_cp(struct
> > > > > > > +anx7625_data
> > > > > > > +*ctx) {
> > > > > > > +     struct device *dev = ctx->dev;
> > > > > > > +
> > > > > > > +     if (!ctx->connector)
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     anx7625_hdcp_disable(ctx);
> > > > > > > +
> > > > > > > +     ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > > > > > +     drm_hdcp_update_content_protection(ctx->connector,
> > > > > > > +                                        ctx->hdcp_cp);
> > > > > > > +
> > > > > > > +     dev_dbg(dev, "update CP to UNDESIRE\n"); }
> > > > > > > +
> > > > > > >  static int anx7625_hdcp_enable(struct anx7625_data *ctx)  {
> > > > > > >       u8 bcap;
> > > > > > > @@ -2149,34 +2165,6 @@ static int
> > > > > > > anx7625_connector_atomic_check(struct
> > > > > > anx7625_data *ctx,
> > > > > > >       if (cp == ctx->hdcp_cp)
> > > > > > >               return 0;
> > > > > > >
> > > > > > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > > > > > -             if (ctx->dp_en) {
> > > > > > > -                     dev_dbg(dev, "enable HDCP\n");
> > > > > > > -                     anx7625_hdcp_enable(ctx);
> > > > > > > -
> > > > > > > -                     queue_delayed_work(ctx->hdcp_workqueue,
> > > > > > > -                                        &ctx->hdcp_work,
> > > > > > > -                                        msecs_to_jiffies(2000));
> > > > > > > -             }
> > > > > > > -     }
> > > > > > > -
> > > > > > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> > > > > > > -             if (ctx->hdcp_cp !=
> > > > DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > > > -                     dev_err(dev, "current CP is not ENABLED\n");
> > > > > > > -                     return -EINVAL;
> > > > > > > -             }
> > > > > > > -             anx7625_hdcp_disable(ctx);
> > > > > > > -             ctx->hdcp_cp =
> > DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > > > > > -             drm_hdcp_update_content_protection(ctx->connector,
> > > > > > > -                                                ctx->hdcp_cp);
> > > > > > > -             dev_dbg(dev, "update CP to UNDESIRE\n");
> > > > > > > -     }
> > > > > > > -
> > > > > > > -     if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > > > -             dev_err(dev, "Userspace illegal set to PROTECTION ENABLE\n");
> > > > > > > -             return -EINVAL;
> > > > > > > -     }
> > > > > > > -
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -2425,6 +2413,8 @@ static void
> > > > > > > anx7625_bridge_atomic_enable(struct
> > > > > > drm_bridge *bridge,
> > > > > > >       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
> > > > > > >       struct device *dev = ctx->dev;
> > > > > > >       struct drm_connector *connector;
> > > > > > > +     struct drm_connector_state *conn_state;
> > > > > > > +     int cp;
> > > > > > >
> > > > > > >       dev_dbg(dev, "drm atomic enable\n");
> > > > > > >
> > > > > > > @@ -2439,6 +2429,32 @@ static void
> > > > > > > anx7625_bridge_atomic_enable(struct
> > > > > > drm_bridge *bridge,
> > > > > > >       _anx7625_hpd_polling(ctx, 5000 * 100);
> > > > > > >
> > > > > > >       anx7625_dp_start(ctx);
> > > > > > > +
> > > > > > > +     conn_state =
> > > > > > > + drm_atomic_get_new_connector_state(state->base.state,
> > > > > > > + connector);
> > > > > > > +
> > > > > > > +     if (WARN_ON(!conn_state))
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     cp = conn_state->content_protection;
> > > > > > > +     if (cp == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> > > > > > > +             if (ctx->dp_en) {
> > > > > > > +                     dev_dbg(dev, "enable HDCP\n");
> > > > > > > +                     anx7625_hdcp_enable(ctx);
> > > > > > > +
> > > > > > > +                     queue_delayed_work(ctx->hdcp_workqueue,
> > > > > > > +                                        &ctx->hdcp_work,
> > > > > > > +                                        msecs_to_jiffies(2000));
> > > > > > > +             }
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     if (cp == DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> > > > > > > +             if (ctx->hdcp_cp !=
> > > > DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > > > > > +                     dev_err(dev, "current CP is not ENABLED\n");
> > > > > > > +                     return;
> > > > > > > +             }
> > > > > > > +
> > > > > > > +             anx7625_hdcp_disable_and_update_cp(ctx);
> > > > > > > +     }
> > > > > > >  }
> > > > > > >
> > > > > > >  static void anx7625_bridge_atomic_disable(struct drm_bridge
> > > > > > > *bridge, @@ -2449,6 +2465,8 @@ static void
> > > > > > > anx7625_bridge_atomic_disable(struct
> > > > > > > drm_bridge *bridge,
> > > > > > >
> > > > > > >       dev_dbg(dev, "drm atomic disable\n");
> > > > > > >
> > > > > > > +     anx7625_hdcp_disable_and_update_cp(ctx);
> > > > > > > +
> > > > > > >       ctx->connector = NULL;
> > > > > > >       anx7625_dp_stop(ctx);
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > With best wishes
> > > > > > Dmitry
> > > >
> > > > --
> > > > With best wishes
> > > > Dmitry
> > 
> > 
> > 
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

