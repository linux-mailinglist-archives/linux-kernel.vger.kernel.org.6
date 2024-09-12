Return-Path: <linux-kernel+bounces-325769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0C975DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B1F1C22724
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208E4685;
	Thu, 12 Sep 2024 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3BWqoM+"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF110E4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100791; cv=none; b=tTPxqJdwllEnOaQkCfAN4gxSdus82EQKQnXAou49KESPg54IGdJzVqs/4ms7d8vMXchATkg/hIn5EK/k/DWAxsHmPo3W09aRWr0m20vKAJ10bSBI3aVZvMRzqwFp1S+ZxRePHZl8QFgr0lVmRvVLhTTQw2xaFKQ3QgnurXQ81lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100791; c=relaxed/simple;
	bh=kasfeox+CzrHbfMRAEEJsi5I90eUrj7IqhCAiGF7uTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq779qYruPalczXTFun6DlMiu87hsffgKSGbxK6s0wjreD6eibfPoxg7EVTXCQDOMp1/p4Spjz3Xy7m7kRB5ymeBdRyUWO2yFY2pXdzBpTs75XGTJrIeYJH6UlF0/cmSPp6zX3Y65JItLe/yyC3/ge29OI/+azU8VrpNR+kaNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3BWqoM+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so267476a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726100789; x=1726705589; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KfXOZmFnB0RCicjkER0daQ4yJ1WQ0U6fnNsCPP4bbDk=;
        b=g3BWqoM+l0SjhkQQ2jf8GQiHaJ/Wh6SDh490k+oNTYfRyHnzBXG557xOX5gczYTQVf
         skMUM1LE9F4cgShLfODlfa3pba9ptZDI3Lbwpi16kgKKKA/li9klHjA0iU7xwBFerwAo
         Z4qJCJgKaPDl/O3/ODGe1H2rmqbnzrJ1kuTwPrmCo75dO5oUsOtUDnpVvQek0aQAt5WC
         hwfbuIpb56dg7qkLfsmlL5ioPV76eG/ixjuxcJZqjF87X9gQoeEknBWXaR5XXpN6P3v9
         rufqccgQnQhRWBg0mY2V/hqzoa0z7VfwQApQp9iRGV29iLWlU82/0j30GMHCfuWOOs8V
         7pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726100789; x=1726705589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfXOZmFnB0RCicjkER0daQ4yJ1WQ0U6fnNsCPP4bbDk=;
        b=Na4DnAz/yJZE2+Vdh3PAG7EEZ/aIdUjdij7YMjOelNLqpDQ8z3wyYlm5vPFWim1OsC
         Z8dnUZh9v5U9LlnuIrl2w4cHJfJnjOoN7J82x5/Ny3iolKtlrGm1mulHnlAn7ftmUylc
         I1I3LdVYlMSaAjGYJSR3yAUCxzwy0dtACFIj55jJh7XUNOZWHrr1I+4ud+NS++BvojU0
         GAR4Pjusuo1tfoB301Q72JvEOz219/tjIjmnZ5+jxKEJMrm3aDyiXK8/DZj3IRVVkfew
         cphwr0Te0rjeUJ32ELADSLVJhrbBV577F+EhJN/Bj6Fzo4SGlqvMhy8NAsfH4OYexY1Y
         mQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqwT12XF26tHJYyymgBy8a7+0qzZfe1guso3ox6Q4n/EmzVIoleDjtuBCXRgq8R3ckgiH/hh8MNZT2aJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4O9DeRr3ud66p7MUmmrU3Ev8BJmL++KXPN0udrDqRWvg2blNV
	e1JSfWKq+LHjUVKj6vtg1YaSnweKjfNMOTmFQCJL2L5PdN4MNBan
X-Google-Smtp-Source: AGHT+IH2fGYf4ERmiPFCi3lGAkDSSQdZ8YwlweCm1l7pE1CERkvDT1yK/XaWyerqooXL1IfLZ8ml9Q==
X-Received: by 2002:a17:90a:684c:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2db9ffefa37mr1086933a91.24.1726100789148;
        Wed, 11 Sep 2024 17:26:29 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.234.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12dfccsm11204096a91.47.2024.09.11.17.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:26:28 -0700 (PDT)
Date: Thu, 12 Sep 2024 05:56:23 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: tejasvipin76@gmail.com, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi
 wrapped functions
Message-ID: <ZuI1L8mypd0kyw7V@embed-PC.myguest.virtualbox.org>
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
 <0bb94cc0-dd72-4da7-b0b6-9e1fe712709b@quicinc.com>
 <0e3bf87b-7d82-44eb-88d2-fddc8e33dd25@quicinc.com>
 <330174f9-bead-4411-b05e-ea9c009f765c@gmail.com>
 <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XsHuhprN-ijw8-ZmOKV6CnCrR=s4X4L57p9J8e02MTBg@mail.gmail.com>

On Tue, Sep 10, 2024 at 02:19:53PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sat, Sep 7, 2024 at 1:32 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
> >
> > On 9/7/24 3:53 AM, Jessica Zhang wrote:
> > >
> > >
> > > On 9/6/2024 3:14 PM, Jessica Zhang wrote:
> > >>
> > >>
> > >> On 9/4/2024 7:15 AM, Tejas Vipin wrote:
> > >>> Changes the himax-hx83112a panel to use multi style functions for
> > >>> improved error handling.
> > >>>
> > >>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > >>
> > >> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > >
> > > Hi Tejas,
> > >
> > > Just a heads up, it seems that this might be a duplicate of this change [1]?
> > >
> > > Thanks,
> > >
> > > Jessica Zhang
> > >
> > > [1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1
> >
> > Ah, thanks for letting me know. I hadn't realized someone else had
> > started working on this too.
> >
> > However, I would argue that my patch [2] is a better candidate for merging
> > because of the following reasons:
> >
> > 1) Removes unnecessary error printing:
> > The mipi_dsi_*_multi() functions all have inbuilt error printing which
> > makes printing errors after hx83112a_on unnecessary as is addressed in
> > [2] like so:
> >
> > > -     ret = hx83112a_on(ctx);
> > > +     ret = hx83112a_on(ctx->dsi);
> > >       if (ret < 0) {
> > > -             dev_err(dev, "Failed to initialize panel: %d\n", ret);
> > >               gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > >               regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> > > -             return ret;
> > >       }
> >
> > [2] also removes the unnecessary dev_err after regulator_bulk_enable as was
> > addressed in [3] like so:
> >
> > >       ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> > > -     if (ret < 0) {
> > > -             dev_err(dev, "Failed to enable regulators: %d\n", ret);
> > > +     if (ret < 0)
> > >               return ret;
> > > -     }
> >
> > 2) Better formatting
> >
> > The mipi_dsi_dcs_write_seq_multi statements in [1] aren't formatted
> > quite right according to what has been done so far. They are written as
> > such in [1]:
> >
> > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> > >                              0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
> >
> > Where they should be written as such in [2]:
> >
> > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
> > > +                                  0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
> >
> > All in all, the module generated using my patch ends up being a teensy
> > bit smaller (1% smaller). But if chronology is what is important, then
> > it would at least be nice to see the above changes as part of Abhishek's
> > patch too. And I'll be sure to look at the mail in the drm inbox now
> > onwards :p
> >
> > [1] https://patchwork.freedesktop.org/patch/612367/?series=138155&rev=1
> > [2] https://lore.kernel.org/all/20240904141521.554451-1-tejasvipin76@gmail.com/
> > [3] https://lore.kernel.org/all/CAD=FV=XRZKL_ppjUKDK61fQkWhHiQCJLfmVBS7wSo4sUux2g8Q@mail.gmail.com/
> 
> I would tend to agree that Tejas's patch looks slightly better, but
> Abhishek's patch appears to have been posted first.
> 
> Neil: any idea what to do here? Maybe a Co-Developed-by or something?
> ...or we could land Abhishek and Tejas could post a followup for the
> extra cleanup?
> 
> Abhishek: are you planning to post more _multi cleanups? 
I’ve just started learning about the DRM subsystem, I don’t have specific 
plans for _multi cleanups at the moment. However, I would be happy 
to contribute further.
>If so, please
> make sure to CC Tejas (who has been posting a bunch of them) and
> perhaps me since I've been helping to review them a bit.
Yes, I’ll make sure to CC Tejas and you.

Regards,
ABhishek

