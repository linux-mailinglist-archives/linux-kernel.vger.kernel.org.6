Return-Path: <linux-kernel+bounces-525772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5839A3F4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11CB17D364
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC4205AD0;
	Fri, 21 Feb 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KJTalR0E"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F021E493
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740142174; cv=none; b=MoYxQxY42TI579oez3L3vJhjTuxbGD1vXgNBWJs1Wrpz9uc0jkjjx48T8FhLOIwqGAz7SmUqrQT/sqksDqjLBJgYBSDTqxe3xrqa0ZfM3g8kkvsu/+FuhQcshtZr+Ac/SZ8evkZGOGSYRiTuNYhrufm2sBZG6K61hBFsYT/FYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740142174; c=relaxed/simple;
	bh=XZC6YO9cfD3PYKWQaHvmx9J7OqQe50DqvuwqbV/O7Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyUKPk+NppTHLxGoeNmX8i3A+/YFAmPWXrrZmL2i1dULGkFggETRDja7VH0rPEGNMf0j3mlro4A135Q0L0A+8ptmV9gUbZxmA0DCQXm8F0Rlr0J9W+zBTwSeq2A1QAPjhXdmRkuGDd9U5NiIcyFmt9kaKktWZBvZKuXOB/CrtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KJTalR0E; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E5BB841962
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740142162;
	bh=Cbhc1gItpcV9XrUirN5RFenJxQvMr3Yj1sfpWoFEODI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=KJTalR0EwYNDhj77OKMsBP+PBp2DV3suT93b/pcrgNMqm8AAskIQope6yzCUdnPno
	 bxz3a2faH9lZ5eSrjHAXFAgtqc+WVDIZRCMCvPf7h6phaNVejewapfcpZoExZffBsr
	 FR9H9VouYaPC4MX6WRJJmcd2W/Z8RysRFLkehy8LAz633vaJyTrPnIwCTc6tPDLOew
	 KBc6PjXMQYzqiLD2Yu4IdivyWbo2oINx2LI/q4uGjSnYMRTnpGZyuVoENSGNoieenB
	 c0NrzZOSl8jSaWkV2COB40H6WQqgVoNRQlUT91AsNlumPXTswnX1smgxSg7/3kmqSo
	 +9Yci5i35fdiA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso6918371a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740142161; x=1740746961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbhc1gItpcV9XrUirN5RFenJxQvMr3Yj1sfpWoFEODI=;
        b=kqWw/qgzmFJmZxC1s13I0UvNqUSRx0Jc/vC5sqCXUxXjNBGc0TMrOQWar+xER38D7H
         fzzQjVY3Q0KZkMX6u38MXMsypORdLN6ZEARLfZARfz+tyQBRpSTYT/XuxEUWdWE7tMcE
         X5kCE4Ah3fhPGljllZYU9qRc1RzG/953jGJfe3Qims2AaxbryomarHTq1cYed5+ykAzK
         Uem0MDTRrpZnV8NhKx9dNjP89NUzu8JTkc+L1dzmJ/XElsbTh66mxn8tI//HW0i/kd2t
         B+yKgLKz4Zp8cpI9Fzxb+eah6HkVmlycdAic02MgnR24uQ9j7wJ+D30fVa17cFU7f1MJ
         XWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUSZ+tv4Aj+G5bEBW6bfgf4aj1IvEsGG7Tl8FjgUcatv6WxKTJ5okR481HbpstgMsAycWZjvdIryFMlugE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBIr0ofxhbSo0siAcZkVR5G30/wW39OsdmOcj4YldPTKkSxW1
	9TcMKdxBciLZ2CiUkwJSLI1L94VGoo4jCaCmAiziSp/4ycrkIWsKOV0N3NUZ5DBXS/gpPw6178H
	yNNjlYqrKffEMilI9exi1UwWf95AHiSiEc1wfS/mBBHFB8SmCJaewzh1Wd/f9fgtuUnb9+b5c21
	dOPJCjCy4WFg==
X-Gm-Gg: ASbGncv+61rHRLPT/M84o5iBDzixVG4wVyMjiVLncs8fvmGsfaqCWlYcfYHhlilMGC1
	Ml6yzSkaCKOtTPv6Abvjq3sGPZsvjjmbWR6geKXuyOvuqGcoQFu0MFg+d0e5y66lYSF4REKNcZq
	afeOArqpQJ9ChCm1pBaakDt50trZqI2uxP39ofTfT+Co/MaJHbmYNDeyMo6FrvpqY9CSoXHHiVb
	mtYcwVcUvxYpKQ9BIgoBg1nYOqSnJSWNbh8YT13ajddIgQO+mx6JbpJF61VVKQR+/YmhAItgATv
	1rsgb3ooqu5Y2DnFEA==
X-Received: by 2002:a05:6a00:3cca:b0:730:9a55:d921 with SMTP id d2e1a72fcca58-73426ce9816mr4726262b3a.14.1740142161293;
        Fri, 21 Feb 2025 04:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+WrUmQ1IDllm96EpcU+4i2VZHzQKp2I4mpHe6LQtUBeMbNazqwM3Swjy1TvDaB7O4OM+ewg==
X-Received: by 2002:a05:6a00:3cca:b0:730:9a55:d921 with SMTP id d2e1a72fcca58-73426ce9816mr4726233b3a.14.1740142160899;
        Fri, 21 Feb 2025 04:49:20 -0800 (PST)
Received: from localhost ([240f:74:7be:1:2777:7867:71cd:dd56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73270a9c8dcsm10685337b3a.74.2025.02.21.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 04:49:20 -0800 (PST)
Date: Fri, 21 Feb 2025 21:49:17 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] gpio: introduce utilities for synchronous fake
 device creation
Message-ID: <uucxoejbornqxgm2h4qjxhv77aispccwxl55qelk5rynwfs6nd@vxjscvztfzlf>
References: <20250218160333.605829-1-koichiro.den@canonical.com>
 <20250218160333.605829-2-koichiro.den@canonical.com>
 <CAMRc=MfmG0okVjV1nH78Aw18dFcoOAZ-UwU-iFc1VKb-BVcTxQ@mail.gmail.com>
 <CAMuHMdULzDfdg-7HBk1f-Z+AZ5L2WGUEiPMqtvk+bNSkLb38BQ@mail.gmail.com>
 <CAMRc=Mecp9se3dTLkS6AokP3N=GHJ6CRNCuYipMfjd3crYkNWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mecp9se3dTLkS6AokP3N=GHJ6CRNCuYipMfjd3crYkNWQ@mail.gmail.com>

On Thu, Feb 20, 2025 at 02:27:41PM GMT, Bartosz Golaszewski wrote:
> On Thu, Feb 20, 2025 at 2:24 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Bartosz,
> >
> > On Thu, 20 Feb 2025 at 12:06, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Tue, Feb 18, 2025 at 5:04 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > > > platform device, wait for probe completion, and retrieve the probe
> > > > success or error status synchronously. With gpio-aggregator planned to
> > > > adopt this approach for its configfs interface, it's time to factor
> > > > out the common code.
> > > >
> > > > Add dev-sync-probe.[ch] to house helper functions used by all such
> > > > implementations.
> > > >
> > > > No functional change.
> > > >
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> >
> > > > --- a/drivers/gpio/Kconfig
> > > > +++ b/drivers/gpio/Kconfig
> > > > @@ -1863,6 +1863,13 @@ config GPIO_MPSSE
> > > >
> > > >  endmenu
> > > >
> > > > +# This symbol is selected by drivers that need synchronous fake device creation
> > >
> > > This comment is unnecessary, please drop it.
> > >
> > > > +config DEV_SYNC_PROBE
> > > > +       tristate "Utilities for synchronous fake device creation"
> > >
> > > Please don't make this available for users to select, this should be a
> > > hidden symbol only to be selected by its users.
> >
> > It is still useful to make it visible for compile-testing, i.e.
> >
> >     tristate "Utilities for synchronous fake device creation" if COMPILE_TEST
> >
> 
> I disagree, this will get plenty of coverage being used by three
> virtual drivers.
> 
> > As it does not depend on GPIO at all, I think it should be moved
> > to the end of the file, outside the big "if GPIOLIB ... endif" block.
> >
> 
> Indeed. And eventually I'd like it moved to lib/ but that's for another time.

I'll move it outside the big "if GPIOLIB ... endif" block. Thanks for
pointing that out.

Koichiro

> 
> Bart
> 
> > > > +       help
> > > > +         Common helper functions for drivers that need synchronous fake
> > > > +         device creation.
> > > > +
> > > >  menu "Virtual GPIO drivers"
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds

