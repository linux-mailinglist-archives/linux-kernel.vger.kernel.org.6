Return-Path: <linux-kernel+bounces-449174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B09F4AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A7916C72F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268101F37BF;
	Tue, 17 Dec 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mavW8GkO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C91F2C23
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438612; cv=none; b=ouLGKWIJRKtFZQzp0sPtCuULRR5cJAX7Y7srFLJAACwxjRdnsPzAeEXMrrjbExSB03aUQZcB3OMEBHxwO1w2gZC5/LKaplWmSsa+jFGbsiyp7RPoZUzvP62I9hH5Du3fN+EKGs41PT8KbjvGALwnvHN3d7p5oDECuY5lf1w4jc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438612; c=relaxed/simple;
	bh=601UAN188A6cMX11FnH+sOdmhoW63ndmmRxJeMn0NG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opCPW5D0exrrDe5EAZpAZc3RyRvkmqWhkptF86UVpvO+/g+KS1VKHjSdkGJgyQPrIFs5v8djK3+PDCzMN5Zt2b2Qyei2or7/tHzv8+D2ZN19YRXu1UNWJxOsW6GOaOfwQJ4LROHQKX82ZtKTwcXqmq8WbY51gfqnQ8rffcWuJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mavW8GkO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso52493631fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734438608; x=1735043408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cpeg+OoZlAk/avwRjAkuR0FSLO7wRA76WtZnvtz5hp4=;
        b=mavW8GkOhxd6SL6IQwDxrmRMp8L/M0qwuRvXYggvs3N7jxDuKfcQLa9chPA/2ewlh3
         H8NdTJpkXlVZTWvxolQVakOHuHYI5sw3d6YNISHlWtrhnYUQ6FQL7nhuZnM974rfewSv
         MMHBod+U1OoOrCutkDXU8Ji5Oh27Ow4vFWlbAv5TivdvrqqJBgSewwmeJET8uRFxX4MR
         N775X0skZ53csiu6+C4cb7dXGBdBUqY/BcGNCi53jqLfBHNPnwK5eevQo1O7GDFegfLO
         jJpGYqAoYv3jgsD/qu4RfXHOi4h5Wf7UpbWMidBc/iAfXouJVo6t8Ej70hrUAmfFftkh
         zdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438608; x=1735043408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpeg+OoZlAk/avwRjAkuR0FSLO7wRA76WtZnvtz5hp4=;
        b=TjNOyMntUYilv3NqVsExgkWkd4jTr0GuRPNNnEvUI4o+f2b5IDp3p9anERQfQ9WmLn
         MWvzUFWFGoXwfzgk1yjzih79Q3VZMojhyODJ4Rytf0N34TFT9B99l3hDT76DEIvExVrW
         G9eXa+p5LrZ4breLxRA4QtAKZ7as/cCwVd2GTHM9tMJG/gpYMaR0/W+EX2RadKmukM/s
         WTayJfcybFbVEmONsx+La9STu1BYoWuXuqP+SaOaoYeMx2Ra4kXn8hhbcNVOHa08xdER
         0ictuZQdoCCbZWetTKkCfqFdbofucDsrqKbWEfjnQc1GU5kMjfh6DbupBNCjz09G4ELm
         Zcpw==
X-Forwarded-Encrypted: i=1; AJvYcCXX2999R1QexsfcMwRQDcGTKsVwvhV4zm4IqxdSqJ+nY1OLQeXHd11ezFA0+x7pJe9Tc/Mb6raOAJe85sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gImVY6HyZnvUUXf/xU5k8s71YTd1qRTBRH+5cnE76iGKQH0t
	40+lV/yNHTE/4Y89pKwgMT5p1ZyHOevMLYnOA6+ZfTdrnLAJgU0SEem6DZFwBbI=
X-Gm-Gg: ASbGncsG6nMD+LEuIoecwLjzS0JdvFWHT88l/iPLOHl0bQjc0QbJDSVS2dTRkyNB3GF
	JXRAnAX9KO1JENTaug0RssM4QWNbkwYU8T+l5yCqEXXFYa8V47IJ5S1oAzLtvzPtjMh3CnoFPEi
	bLlRBln3KAhIcsziXB7F2Vv4HsxeLE+Djo29QCXnW6cy9GaQv4N99OOQzP/cDDUbo106peQmG4B
	MLO+R5S2oY4B9ka3f+bq/ln9gqZ6r7Stnuz3ytDb6n2H/ck50+Vr2oiFx8/E9oLfgxaGFQYFyf+
	wK6XIgFrxlWY1QdXPFGVrO3a597MFf3PnsI4
X-Google-Smtp-Source: AGHT+IG/o83HRTYlBKwHjBbNkkDbTOVwon5AjYEKHu8C9oNpfKtoWKENsqidPqi+Ggy0KZ4EaXhgqA==
X-Received: by 2002:a2e:bc1d:0:b0:302:2620:ec84 with SMTP id 38308e7fff4ca-304434d9d6emr11629731fa.7.1734438607708;
        Tue, 17 Dec 2024 04:30:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a5a75sm12573331fa.99.2024.12.17.04.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:30:06 -0800 (PST)
Date: Tue, 17 Dec 2024 14:30:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Ji <xji@analogixsemi.com>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bernie Liang <bliang@analogixsemi.com>, 
	Qilin Wen <qwen@analogixsemi.com>, "treapking@google.com" <treapking@google.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
 atomic_enable()
Message-ID: <6xyyujq7pizt6a2ztjfuapz7pphz33lxgvsjextlrhnefkjaq2@lhpy4bo4wajd>
References: <20241212055110.1862487-1-xji@analogixsemi.com>
 <vkrl7om7hepboovp2uivcnernia3ygqwrj3y3kkjydeclwvrk5@7tkdc4etkcjs>
 <BY5PR04MB673977C1DB1E774CB261C119C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <4q2jncpnmeu7ytuyuv5pjzurh3ai5663jmu2we6cebuad2r3r5@tfb6hf6unioc>
 <BY5PR04MB673902E047FF8ADAFD8B94B3C7382@BY5PR04MB6739.namprd04.prod.outlook.com>
 <CAA8EJprGjuGFjZnXUxiMZMV=FO9O9CYt06H_nSL82fEOvPytyA@mail.gmail.com>
 <BY5PR04MB6739C5804F0E9764EFD3A3EBC73B2@BY5PR04MB6739.namprd04.prod.outlook.com>
 <fyltwqxyrmy3rz75nosc4wn6z5zglwv7pelzdf5g6ztloq4ncj@yigwmszuhigb>
 <CAEXTbpf3Bipid7bgnYzGJ6C6d+pgPcA2mjwFijSBwz_6Ub4aaw@mail.gmail.com>
 <BY5PR04MB6739B4BEAEFD0292C1AC9E3FC7042@BY5PR04MB6739.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR04MB6739B4BEAEFD0292C1AC9E3FC7042@BY5PR04MB6739.namprd04.prod.outlook.com>

On Tue, Dec 17, 2024 at 01:50:00AM +0000, Xin Ji wrote:
> > -----Original Message-----
> > From: Pin-yen Lin <treapking@chromium.org>
> > Sent: Monday, December 16, 2024 8:05 PM
> > To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Cc: Xin Ji <xji@analogixsemi.com>; Andrzej Hajda <andrzej.hajda@intel.com>;
> > Neil Armstrong <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>;
> > Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman
> > <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>; Maarten
> > Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>; David
> > Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Bernie Liang
> > <bliang@analogixsemi.com>; Qilin Wen <qwen@analogixsemi.com>;
> > treapking@google.com; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > atomic_enable()
> > 
> > 
> > Hi Dmitry,
> > 
> > On Mon, Dec 16, 2024 at 7:59 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 08:33:23AM +0000, Xin Ji wrote:
> > > > > -----Original Message-----
> > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Sent: Friday, December 13, 2024 9:17 PM
> > > > > To: Xin Ji <xji@analogixsemi.com>
> > > > > Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong
> > > > > <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>;
> > > > > Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas
> > > > > Karlman <jonas@kwiboo.se>; Jernej Skrabec
> > > > > <jernej.skrabec@gmail.com>; Maarten Lankhorst
> > > > > <maarten.lankhorst@linux.intel.com>; Maxime Ripard
> > > > > <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>;
> > > > > David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>;
> > > > > Bernie Liang <bliang@analogixsemi.com>; Qilin Wen
> > > > > <qwen@analogixsemi.com>; treapking@google.com;
> > > > > dri-devel@lists.freedesktop.org; linux- kernel@vger.kernel.org
> > > > > Subject: Re: [PATCH v3] drm/bridge:anx7625: Update HDCP status at
> > > > > atomic_enable()
> > > > >
> > > > > CAUTION: This email originated from outside of the organization.
> > > > > Please do not click links or open attachments unless you recognize
> > > > > the sender, and know the content is safe.
> > > > >
> > > > >
> > > > > On Fri, 13 Dec 2024 at 13:00, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > >
> > > > > > Hi Dmitry, sorry, I didn't clear describe the reason.
> > > > >
> > > > > Please. Do not top-post. Please paste your answer under the
> > > > > question, not somewhere at the top of the email. This allows us to
> > > > > have a more constructive dialog. Additional bonus if you can fix
> > > > > your email client to insert sensible quoting information instead of dumping
> > the headers of the original email.
> > > > Hi Dmitry, OK, sorry about it. Currently, we have problem to fetch
> > > > email from Microsoft on Ubuntu. I'll try to fix it later.
> > > > >
> > > > > >
> > > > > > Anx7625 implement DSI to DP convert behind USB Type-C port, when
> > > > > > user plug into USB Type-C Dongle with DP monitor, the user space
> > > > > > will enable HDCP feature, then kernel do HDCP and output display
> > > > > > and set HDCP content to ENABLE, but the issue happened if user
> > > > > > manually change the
> > > > > monitor's resolution later.
> > > > > >
> > > > > > Each time user change the resolution, kernel will call bridge
> > > > > > interface .atomic_disable() and .atomic_enable(), the old driver
> > > > > > will keep HDCP state to ENABLE, this is a BUG, when user change
> > > > > > the resolution, kernel must change HDCP content too (mustn't
> > > > > > keep to ENABLE),
> > > > >
> > > > > Why? Could you please point me to the corresponding documentation
> > > > > or a code path in the other driver? Preferably i915, AMD or Nouveau.
> > > > As
> > https://elixir.bootlin.com/linux/v6.12.5/source/drivers/gpu/drm/drm_connecto
> > r.c#L1423:
> > > >         - ENABLED -> DESIRED (termination of authentication) As
> > > > there is no other interface to tell anx7625 bridge driver, so the I
> > > > think best place to handle ENABLE -> DESIRED in .atomic_disable().
> > >
> > > I was looking for something like cdns_mhdp_connector_atomic_check(),
> > > which switches to UNDESIRED if there is no new CRTC. Likewise i915
> > > driver performs this in intel_hdcp_atomic_check() if there is a need
> > > for modeset.
> Hi Dmitry, the bridge driver is different with i915, anx7625 bridge driver
> only implement some passive callback interface. There is no HDCP status
> checking while do resolution switch.

Does that mean that you _have_ to reestablish HDCP after mode switching
in order for it to work?

> > 
> > I believe you mean "DESIRED" here.
> > >
> > > For the "termination of authentication" case see
> > > cdns_mhdp_hdcp_check_link(), which detects if the HDCP got disabled by
> > > HW and then updates the status accordingly.
> > >
> > > >
> > > > >
> > > > > > as DRM doc said, kernel cannot change from ENABLE to UNDESIRE,
> > > > > > so next patch, I'll change it to DESIRE in .atomic_disable().
> > >
> > > This e.g. will result in HDCP being restarted for all modesets. Is
> > > this an expected behaviour?
> > 
> > The bridge could be powered off between .atomic_disable()
> > and .atomic_enable(), though I'm not sure if this would be a concern for
> > anx7625. I'll let Xin to comment on this.
> The flow of resolution switch is:
>     -> .atomic_disable().
>         -> .atomic_enable().
>             -> HDCP status check and enable.
> As resolution switch is triggered by user space, at this moment, the HDCP
> works fine(cannot get disabled event from HW).
> So, I think, .atomic_disable() is
> the best place to do termination of authentication (turn HDCP status to DESIRED).
> This is the only entrance which can do termination of authentication, I cannot
> find others.

I'm probably still missing a reference to the standard (please excuse
me, I don't know it by heart). Is it a standard requirement to
reauthenticate on the mode switch?

BTW, while reading the anx7625 code, I noticed that there is a possible
race between .atomic_enable() / .atomic_disable() which set
ctx->connector and the hdcp_check_work_func() which reads ctx->connector
without any protection.

-- 
With best wishes
Dmitry

