Return-Path: <linux-kernel+bounces-225021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62E912AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908DD1F21236
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8304A15F30D;
	Fri, 21 Jun 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LlzMtzB3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2115ECFE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985158; cv=none; b=gh2z+rGXUg224w8G/EVEUilFZgX+3jQKamdcEY9kRez9atynGNna3lTLQcM7QnEs7WEOlIG7642kUD6OfQXJHhaPIwBi0AxlAdfQyxtvtm7tUj3a8IIT2X/pFqlJOIWxvyEfuLsyP1CvBC/RzYy9c7Veb9vIJy25uc7w/3I9LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985158; c=relaxed/simple;
	bh=7QtTWpzSkAfcmaeTt2hMYoNG7lS04QTiDzb4LCrYk1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP4BnrcuFvR47oYtjriZOjrskVRLeTe/0i8ZuWE1CNZjiuRHB+BTIOuOdIO02DP5RUdfWLl1E7BX4vNfUysKLruU6spflFzf1ZIP1gDEPigAt6KkRTtAk+5e4CIMwzp07UVZ61PFHdWB+VpGHAK5CvkwwZEZKTq3c4iXvbIqsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LlzMtzB3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4247adb75a1so2629605e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718985155; x=1719589955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vd3HeTeZMYz+szCMLjJ+nPKJvussyehfNdDyWJdflY8=;
        b=LlzMtzB3iqcpGQFsu/JbUoRa/u5wvSn8Y3OCFFMvgbSmo5pqc3jBLQeS5OkUHVRhGu
         VSCpCmv3YpAUsBC3/uXYhPz6ZGmBtbW5OoRh8IgsQ+zva73aoo9NGnsg1haP/0a5xSxV
         3GjU7+qH7IkKu4OaLvvYriF8tw3B7GtKHmmn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985155; x=1719589955;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd3HeTeZMYz+szCMLjJ+nPKJvussyehfNdDyWJdflY8=;
        b=TtxevTiL40POSu2G/6iG151npw7KV2KdUZtmgeh077vssNhhP1/6Bm/r6YO28THjV1
         n7z1qKi7ylfjMXITbT7fTRhHgMmZovsnemt8QX5RfQIPnaxFWLYrTMDnjpyprE5z3yPn
         QIXJDbp18NX2bdtv4cuN8dEH/UuEr+1IixI5SLuWSrPjNxXoef9d30fBs2chSoDR5bxK
         NRvbTFpYy8VMWjk72flGB5/4InThfZCNvUzKwjrqUDDhy5Hnw9eCn59n1zX6G65iH1tw
         1PmaLFz8FjCh1vk/JIYHbHPG/smDHbqPqe8imgo85955u+U3W/HfYLrXAeyn8UEsRjVF
         TsvA==
X-Forwarded-Encrypted: i=1; AJvYcCV0C96vwsQrQrowJ0eXm4aRHDhY5CBvxD1pzpZ9ba1xPvdoygi3nT2Rjxo0BnoWvADsZelpUbRH0K0NsBbm2LtIrB4NT0/FZjedBqWH
X-Gm-Message-State: AOJu0Yzhj0cM9RIWllCExgdqjlKPEO7aeYMCqHwXo/TIP/Dgixx0d26o
	uYDlGY+a/mgFutZ33o4OJbc5mWSOcb39Ywl+F3j+RSSvtu68Qz6plj/n4NdtzXs=
X-Google-Smtp-Source: AGHT+IHTT6f9c44NGR6g+VcrdzZyAm7iHTscK4tEiWZvq36vM9pBm1QlBHsawMSX9ZVQwhSsjv6Cbg==
X-Received: by 2002:a7b:c5ca:0:b0:424:7876:b6ca with SMTP id 5b1f17b1804b1-4247876b78bmr54773525e9.1.1718985155185;
        Fri, 21 Jun 2024 08:52:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247101a955sm102812785e9.0.2024.06.21.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:52:34 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:52:32 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
Message-ID: <ZnWhwJtTXS32UI9H@phenom.ffwll.local>
Mail-Followup-To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@gmail.com>
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm>
 <z6g5ool5vomkudiroyaxh532rhlfu5x4i3l5xoqrsho2sxv4im@v5ghemjkpc3v>
 <CAA8EJprgCJKOnZo7Q31KZV3SA3NqWxcMmoUxuqnVF+8cQW5ucg@mail.gmail.com>
 <6f59552d-d7a3-5e05-3465-e707c1b7eaf2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f59552d-d7a3-5e05-3465-e707c1b7eaf2@quicinc.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Fri, Jun 21, 2024 at 09:40:09AM -0600, Jeffrey Hugo wrote:
> On 6/21/2024 5:19 AM, Dmitry Baryshkov wrote:
> > On Fri, 21 Jun 2024 at 09:19, Bjorn Andersson <andersson@kernel.org> wrote:
> > > 
> > > On Wed, Jun 12, 2024 at 09:28:39PM GMT, Dmitry Baryshkov wrote:
> > > > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> > > > > Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> > > > > to be added for PD notifications and other missing features. Adding
> > > > > and maintaining new files from within fastrpc directory would be easy.
> > > > > 
> > > > > Example of feature that is being planned to be introduced in a new C
> > > > > file:
> > > > > https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> > > > > 
> > > > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > > > ---
> > > > >   MAINTAINERS                          |  2 +-
> > > > >   drivers/misc/Kconfig                 | 13 +------------
> > > > >   drivers/misc/Makefile                |  2 +-
> > > > >   drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> > > > >   drivers/misc/fastrpc/Makefile        |  2 ++
> > > > >   drivers/misc/{ => fastrpc}/fastrpc.c |  0
> > > > >   6 files changed, 21 insertions(+), 14 deletions(-)
> > > > >   create mode 100644 drivers/misc/fastrpc/Kconfig
> > > > >   create mode 100644 drivers/misc/fastrpc/Makefile
> > > > >   rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> > > > 
> > > > Please consider whether it makes sense to move to drivers/accel instead
> > > > (and possibly writing a better Kconfig entry, specifying that the driver
> > > > is to be used to offload execution to the DSP).
> > > > 
> > > 
> > > Wouldn't this come with the expectation of following the ABIs of
> > > drivers/accel and thereby breaking userspace?
> > 
> > As I wrote earlier, that depends on the accel/ maintainers decision,
> > whether it's acceptable to have non-DRM_ACCEL code underneath.
> > But at least I'd try doing that on the grounds of keeping the code at
> > the proper place in the drivers/ tree, raising awareness of the
> > FastRPC, etc.
> > For example current fastrpc driver bypasses dri-devel reviews, while
> > if I remember correctly, at some point it was suggested that all
> > dma-buf-handling drivers should also notify the dri-devel ML.
> > 
> > Also having the driver under drivers/accels makes it possible and
> > logical to  implement DRM_ACCEL uAPI at some point. In the ideal world
> > we should be able to declare existing FastRPC uAPI as legacy /
> > deprecated / backwards compatibility only and migrate to the
> > recommended uAPI approach, which is DRM_ACCEL.
> > 
> 
> I suspect Vetter/Airlie need to be involved in this.
> 
> Its my understanding that accelerator drivers are able to reside in misc as
> long as there is no use of dma-buf.  Use of dma-buf means they need to be in
> drm/accel.
> 
> There is precedent for moving a driver from misc to accel (HabanaLabs).
> 
> Right now, I'm not aware that fastRPC meets the requirements for drm/accel.
> There is an open source userspace driver, but I'm not aware of an open
> source compiler.  From what I know of the architecture, it should be
> possible to utilize upstream LLVM to produce one.

Yeah so fastrpc is one of the reasons why I've added a dma_buf regex match
to MAINTAINERS, and given this move has shown up here on dri-devel that
seems to work.

But also, it slipped through, can't break uapi, so I just pretend it's not
really there :-)

That aside, going forward it might make sense to look into drivers/accel,
and also going forward new dma_buf uapi will be reviewed to fairly
stringent standards. We're not going to impose the dri-devel userspace
rules on everyone, each subsystem tends to know what's best in their
ecosystem. But if something just ends up in misc so it can avoid the drm
or accel rules (and I think media is also pretty much on the same page
nowadays), then expect some serious heat ...

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

