Return-Path: <linux-kernel+bounces-521206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7BA3B81D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F93C188A669
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38C1BEF71;
	Wed, 19 Feb 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="haJX/d7C"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1711E009F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956300; cv=none; b=YtfM1VByaPS5MS6qcDeZL2rEdYldfDjKWsdaD+3zP/vtYWWAYBFPs1jEsklHrGB5zmAZqJyIbkfkn+fTmKmt6sZwAQBfk3fyLkkQaeGvxWMYIfSQcxuilnw5gBxAXrpBOR4TzYHz+eA8UulL7hjSvwP2zCkfsxQfbcDlSmqLnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956300; c=relaxed/simple;
	bh=W870LZCRo8vROMZoL7m2LOfZhN0cIZS97vy6KL8pHvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeGh046hsLY3kZ37xVYVBv8Lv3JdKD9hrG49CNWugzpS/07Tw+ehLQc48uaD2EDy/cZtHwRno5N0vb2M8fAVcmjIdSekbn7dDyFeS7TomXv6oRYnSqWn2akg9Tssf6kxbwWW9j4hyIkvfj9MLeAoHuiKdqYhRoG4Ha+hNtfrX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=haJX/d7C; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54605bfcc72so774507e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739956296; x=1740561096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jza03j0MnQGznKWpKvTiC+4+k6GxgwZi0Po40ysUY6w=;
        b=haJX/d7CFFwL06d3PUTuXk8riyDrSrwREwK/Si2y3dI4MfeNfoZuJi0WbAIaQKEni5
         CcT0SLvjZGnOHBKvTVIpqOzuk01S+NRN1SFQvUmntc8XxTCVErv7KI6WlwsFKaRIKGnA
         ciaYF2TYdGWFe2CEzTDXJ2INQC34Ig71w2CiDOX+DuR7aS0V87PriKCI1Eh5c2FXF7ZC
         TOdVC34xvOzJFh1HiBJdC3B7OZKoeYfOARaVVWsQGUa7osEch9Xloc5SuRV0ffkeJBub
         c8JvaTEfDH0tp1ZfhKd8FKijjWZFADLS2aSP139XlmfxnGi3FjQGBKuOh0XllJh4/YhT
         pC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956296; x=1740561096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jza03j0MnQGznKWpKvTiC+4+k6GxgwZi0Po40ysUY6w=;
        b=OrceUadt1Dn3SQpdEXx3wpoZSxPrfPod21RW7k/OSN2y28QWq9I55tecp878zTzXrU
         1Akyk6xFhFKbaYk4PWrQAf/7ws+zllsRq1NxwjmE+9C2slSdUTIzS98s3c66E1jN6HbP
         XmTVREIFhOtEdRxZam9SiT1hQKF0Cy2CqbQWo/nWaj41Aw2ic8vq0RQvReGNEBLeGICn
         LyR+y3Ewmxygq/zrglR07r/X5u0fsIiSLskvk0slG4WhX001vGCBsnZ2twxhQANk/WVS
         Xl8m7jiOdRKHd3ewOvpGEjm33L0i6uqCZx2m40HKDE8/imvge/Q8z9PcThAclqI3xkoD
         qZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQYWeoks3Tbr3YzJ/FeZAZfvGCUvqwhZPq/zVTfH7juuNpW9EEsl9jVTJLu2G5tAbjHp7IUSOwjrLfBq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgtAt39BlI2CzSZyLqnmvx0VHrGwYT5tEi4eNdC/hnlpBxrJw
	ck4sMVWljyy4qEuUuc6h0m1TRV5g0mqQxPoXKcolchrtL8lxgV1g41Q7iy+ovlE=
X-Gm-Gg: ASbGnctl3MWYqFuoQwX6eaiA7fmOW65tBwabZupU07zpAZMsTIDrGKKBgUx0YFvklga
	XvCE+AC71JJYn4ol4TxM1UwiNdqYIu9XnhO84/ew6sUo2OIRV0msSCt1g+7EJmZ0+VH6ddJvilk
	F4DJ/quXhllVnRPZl47Dn0mWtXUyT9UM/etVh857WUPqWkQXN6Q3jVBEAwnA+MNscu6M9dFL8+E
	qUmbxzYGCjKq3o/66T+pJRmw+O3PT5gd/WXkRXuiZpa2oPMBigv3dVSImJ1GS+6B9FRLFMLkepJ
	Jc7GV6uhe5yKL2eBaA3WKFLrWXFZfE8nYV9gu4eRGv4nWv+wwGVX1vNglYFN/uli7BewTYU=
X-Google-Smtp-Source: AGHT+IFa5flmo8YhTuWoDOUEgP1BOmmAOlZ+4HxQtHdeWbJ1wWlQi3XsL8Oh/UDWY10wx8g82SoCHA==
X-Received: by 2002:a05:6512:281b:b0:544:e:cfea with SMTP id 2adb3069b0e04-5462eaa65c6mr989206e87.6.1739956296217;
        Wed, 19 Feb 2025 01:11:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462cb28b60sm349095e87.153.2025.02.19.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:11:35 -0800 (PST)
Date: Wed, 19 Feb 2025 11:11:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, 
	Anusha Srivatsa <asrivats@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
	Javier Martinez Canillas <javierm@redhat.com>, Jianhua Lu <lujianhua000@gmail.com>, 
	Robert Chiras <robert.chiras@nxp.com>, Artur Weber <aweber.kernel@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Tejas Vipin <tejasvipin76@gmail.com>
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
Message-ID: <rg4mctlqofydzexa7uwnmcsv66dhx5u2wrmytslpyltraz6p5q@ohvo7ab2ws7q>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com>
 <20250218-fabulous-agile-corgi-9a5ee0@houat>
 <ynmxaimdwkwfiryz5le5vpnfh5fzh5se4ebyqzkbnq355me76x@yxtyan3niivb>
 <20250218-primitive-kickass-seagull-008bf2@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218-primitive-kickass-seagull-008bf2@houat>

On Tue, Feb 18, 2025 at 04:52:53PM +0100, Maxime Ripard wrote:
> On Tue, Feb 18, 2025 at 02:14:43PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Feb 18, 2025 at 10:55:49AM +0100, Maxime Ripard wrote:
> > > On Fri, Feb 14, 2025 at 08:26:02AM -0800, Doug Anderson wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Feb 13, 2025 at 12:44 PM Anusha Srivatsa <asrivats@redhat.com> wrote:
> > > > >
> > > > > A lot of mipi API are deprecated and have a _multi() variant
> > > > > which is the preferred way forward. This covers  TODO in the
> > > > > gpu Documentation:[1]
> > > > >
> > > > > An incomplete effort was made in the previous version
> > > > > to address this[2]. It removed on the mipi_dsi_dcs_write_seq()
> > > > > and mipi_dsi_generic_write_seq_multi() with the respective
> > > > > replacemts and not the rest of the API.
> > > > 
> > > > You didn't seem to take most of the suggestions I gave in response to
> > > > your v1 [3]. Specifically:
> > > > 
> > > > a) I asked that you CC Tejas. I've added him again.
> > > > 
> > > > b) I asked that you CC me on the whole patch series, which you didn't
> > > > do. I can find them, but I'd find it convenient in this case for them
> > > > to be in my Inbox.
> > > > 
> > > > The first patch conflicts with what Tejas already landed in
> > > > drm-misc-next. See commit 8025f23728e9 ("drm/panel:
> > > > xinpeng-xpp055c272: transition to mipi_dsi wrapped functions"). The
> > > > second patch _also_ conflicts with what Tejas already landed. See
> > > > commit f4dd4cb79f9e ("drm/panel: visionox-r66451: transition to
> > > > mipi_dsi wrapped functions"). Later patches also also conflict. See
> > > > commit 0d6c9edf9e5b ("drm/panel: ebbg-ft8719: transition to mipi_dsi
> > > > wrapped functions"), commit ce8c69ec90ca ("drm/panel:
> > > > samsung-s6e88a0-ams452ef01: transition to mipi_dsi wrapped
> > > > functions"), and commit 7e3bf00047cd ("drm/panel: sharp-ls060t1sx01:
> > > > transition to mipi_dsi wrapped functions"). Maybe you should sync up
> > > > with drm-misc-next before submitting.
> > > 
> > > Yes, you should definitely work from drm-misc-next there, and sync with
> > > Tejas.
> > > 
> > > > I also questioned whether this really made sense to try to do with a
> > > > Coccinelle script and I still don't think so. It looks like Dmitry has
> > > > already reviewed the first few of your patches and has repeated my
> > > > advice. If you want to help with the effort of addressing this TODO
> > > > item then that's great, but I'll stop reviewing (and start silently
> > > > deleting) any future submissions of yours that say that they're done
> > > > entirely with a Coccinelle script unless you address this point and
> > > > convince me that your Coccinelle script is really smart enough to
> > > > handle all the corner cases. I'll also assert that you should review
> > > > Tejas's submissions to see how these conversions are expected to go.
> > > 
> > > I couldn't find that in your first answer though. What corner cases do
> > > you have in mind, and why do you think coccinelle can't handle them?
> > 
> > As can be seen from the reviews:
> > 
> > - sleeps between DSI calls
> > - properly propagating the error at the end of the function
> 
> These two are legitimate feedback, but I don't see how coccinelle cannot
> deal with them.

Maybe it can. both issues were pointed out during review of the first
series, there was no improvement here. I'd really ask to perform
conversion of a single driver, so that the script (or post-script
fixups) can be improved. I'd still expect that Anusha actually reviews
the changed driver before posting it and verifies that there is no
regression in the logic / error reporting.

> 
> > - making decision whether to create the context at the caller or the
> >   callee side. E.g. in patch 8 it is better to allocate context in
> >   hx8394_enable() and pass it to .init_sequence() instead of keeping
> >   some of error handling.
> 
> Yeah, that one is definitely subjective, and is going to need manual
> review.

-- 
With best wishes
Dmitry

