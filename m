Return-Path: <linux-kernel+bounces-226966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF6914681
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FB8282C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E1132116;
	Mon, 24 Jun 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iJy3SyWT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BF79DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221629; cv=none; b=mfkEmGdAjP/1MfXcHJJDHSOF+otaI0lI9IbP/y6A0hWBEEYi5cJaWxOEX/I2IM7qji/t6AYCGGJk5Q1QJT6VoZnky08l4hFxs4JOVbgTTG+x9ipGzoWQKX0RgMQmjDQCmuAH435bJT2VznobCha/j50yFkdybYbjQu4kqIF8Fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221629; c=relaxed/simple;
	bh=/KL/NdBDG58xCIPAw4YwdMeg/5iy22kVY2U90t04DA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG3VzUAmhRIKojK3uS5o/8HPohSVUm5pgv5WvdM3fA9lNLhf7eIZtwILwMa1TtOI5vWV4qiAdO4wjL3YQnJEUO1FXH/iP5zdpPoyiFt25gg0dE4Q7mT5Jy0nENWwDmnQypFpYibUtuH/FtADxreN87PK9JFZ9Q6d8W/0MveX6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=iJy3SyWT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3635f991f4bso307491f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719221626; x=1719826426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDecevrNwUO63hAzBHMfL3jldrZsRCPWB7PKUAe6PW4=;
        b=iJy3SyWTvK5GK2A6Nr6YdO4jXj+vSOuOiimH1UrurVIIUz01VnrJfOe5IdPD0rWzCa
         jXJiSqZuhjzfmMnUOaudSiBAzL8/XyEMC6fjiBRyzQg3+efsizwg1TtuB36R0c1FufHN
         ZxwCBub7McDu9+h4ME7w0CGrMudV9Z4lywclg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221626; x=1719826426;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDecevrNwUO63hAzBHMfL3jldrZsRCPWB7PKUAe6PW4=;
        b=lefNe4p5V9wuf1bcEaoCSDvtmB8AZiCuoSU09ZJgNa60Wr8DGWAyPWUrDenFOMJMp7
         K6bERZkKHpjbdGUF2OA715zFhM/qNHgDkFPBFZHJ5jzG2wuv888v3oogUGcx2xVuJAZc
         O3SCDoEofhc2RNw3AHPPzG11Ks3c94ttwJCFTBrekRJjcMMICfqmOne/qeTimcURRG8Y
         JmOnO7dCwtVa7n4+YLXF6daxorWFI5qLETK6YRYeTddRb9s+ezMSxqsjl8f32eOormRq
         +o8hDBgKgnQca+z33LCJ6aBIm3UKdvgup9qB96uavRC5J/aM1hpkxKtgGHO470wPzOik
         RFBg==
X-Forwarded-Encrypted: i=1; AJvYcCV9SR0yyKD9KNFn7kK+cDwf1TcleDqCRizxvsn/Fe5e9olQ520vK5ILu/wp97AIJawGnvDl0ckfvaYAPBRBmo5VUotMidj8hhHQavI0
X-Gm-Message-State: AOJu0YwG/R5s7UMizH9r4oQEgjHTQP7ss52YGi5/oe9k4pfXkz6vi3yb
	LdAaFG9W+p89UqLSnkK9K/DGRtZOAj3aqKb25KX4x7EA4wE5VEbQkxENIeljsHw=
X-Google-Smtp-Source: AGHT+IFmDBOhp59HDggw1pz7CehJXLtxtOoh3bEUePIFnDfBhsEsaT5adH0/nPk85Q2FcM5IFWiknA==
X-Received: by 2002:a5d:5983:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-366dfa2d903mr4504328f8f.3.1719221626371;
        Mon, 24 Jun 2024 02:33:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8634sm9593317f8f.34.2024.06.24.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:33:45 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:33:43 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
Message-ID: <Znk9d80pd67cWEYU@phenom.ffwll.local>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <ZnWhwJtTXS32UI9H@phenom.ffwll.local>
 <fin5dnpf3jyo5mk4b7fktdutbds5lkpxwzojecxa4zh7gwfad2@rkryxqzt6maq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fin5dnpf3jyo5mk4b7fktdutbds5lkpxwzojecxa4zh7gwfad2@rkryxqzt6maq>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Sun, Jun 23, 2024 at 03:19:17PM -0500, Bjorn Andersson wrote:
> On Fri, Jun 21, 2024 at 05:52:32PM GMT, Daniel Vetter wrote:
> > On Fri, Jun 21, 2024 at 09:40:09AM -0600, Jeffrey Hugo wrote:
> > > On 6/21/2024 5:19 AM, Dmitry Baryshkov wrote:
> > > > On Fri, 21 Jun 2024 at 09:19, Bjorn Andersson <andersson@kernel.org> wrote:
> > > > > 
> > > > > On Wed, Jun 12, 2024 at 09:28:39PM GMT, Dmitry Baryshkov wrote:
> > > > > > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> > > > > > > Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> > > > > > > to be added for PD notifications and other missing features. Adding
> > > > > > > and maintaining new files from within fastrpc directory would be easy.
> > > > > > > 
> > > > > > > Example of feature that is being planned to be introduced in a new C
> > > > > > > file:
> > > > > > > https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> > > > > > > 
> > > > > > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > > > > > ---
> > > > > > >   MAINTAINERS                          |  2 +-
> > > > > > >   drivers/misc/Kconfig                 | 13 +------------
> > > > > > >   drivers/misc/Makefile                |  2 +-
> > > > > > >   drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> > > > > > >   drivers/misc/fastrpc/Makefile        |  2 ++
> > > > > > >   drivers/misc/{ => fastrpc}/fastrpc.c |  0
> > > > > > >   6 files changed, 21 insertions(+), 14 deletions(-)
> > > > > > >   create mode 100644 drivers/misc/fastrpc/Kconfig
> > > > > > >   create mode 100644 drivers/misc/fastrpc/Makefile
> > > > > > >   rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> > > > > > 
> > > > > > Please consider whether it makes sense to move to drivers/accel instead
> > > > > > (and possibly writing a better Kconfig entry, specifying that the driver
> > > > > > is to be used to offload execution to the DSP).
> > > > > > 
> > > > > 
> > > > > Wouldn't this come with the expectation of following the ABIs of
> > > > > drivers/accel and thereby breaking userspace?
> > > > 
> > > > As I wrote earlier, that depends on the accel/ maintainers decision,
> > > > whether it's acceptable to have non-DRM_ACCEL code underneath.
> > > > But at least I'd try doing that on the grounds of keeping the code at
> > > > the proper place in the drivers/ tree, raising awareness of the
> > > > FastRPC, etc.
> > > > For example current fastrpc driver bypasses dri-devel reviews, while
> > > > if I remember correctly, at some point it was suggested that all
> > > > dma-buf-handling drivers should also notify the dri-devel ML.
> 
> If the agreement is that dma-buf-handling drivers must get reviews from
> dri-devel, then let's document that in MAINTAINERS and agree with the
> maintainer.

About 5 years ahead of you here with 78baee8d3b97 ("MAINTAINERS: Match on
dma_buf|fence|resv anywhere").

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

