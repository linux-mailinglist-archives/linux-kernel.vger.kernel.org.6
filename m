Return-Path: <linux-kernel+bounces-230194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC69179AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9F128650C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0ED15A4B0;
	Wed, 26 Jun 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FQxUDq98"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E82159598
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386923; cv=none; b=otVlU+Jk1GlY6+MSYC7oD3kF8O4WHx7FQPVh4msSdCTr28kuOsI/3IdpK9c2xicPC5cGxsgYxiWtRLlNB4TWulsytmBmnrBzuc1wPrRRpPKnbtrgI8zrSj2tBKJqMUXwQAFkjoRn1ESbUmtHNCZlDptmSWCX6DBWZejE/1/N1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386923; c=relaxed/simple;
	bh=+oyisVs/eKXqJPa4GjyRFcvU07KQxM/W486mQfQC7Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDbLkqsQ23Anh/BdvItdG7HI/4zXz0TIAFro1ML+vYXnxi9lqLw1NjRX3W3Rn8py28DJEpqojOAyO2wxSAIK/xWP87c+e6UOp+bSu4j/LRRnZdqetkmbZ6/+ewCa05F494jMCtFpO8ejyR91jRAhO5WBgu3s6Mi7mPUk202VheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=FQxUDq98; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3672ab915bdso24136f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719386920; x=1719991720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqNG77PcBYWk1qlqmdc1D97HuBROg9p8D0BaXqBlCPo=;
        b=FQxUDq98Yy55HaI2TY9UZ6qJQ85xTN5H7DemmwR1eYdsoa8acsrgzU4/W/b5UwpiQC
         uXsOohgzQs9r8xkf4FKz5dVnIitX/rk5so4wknTUhbuzpP0v71GvD69h/fJfop8il0gc
         7siuT1Aa075ASEefYskH1rKHb0a0xD1ly/vzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719386920; x=1719991720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqNG77PcBYWk1qlqmdc1D97HuBROg9p8D0BaXqBlCPo=;
        b=pRwsX8rAItbjpq56L+UHJieILmqH4QFPkdSbf0RpmBIxBMpZdv7RgiO/0EpckBL3v8
         meTMBSoBZ1pIm04LeAsFg7cdGNx52tjLCEarX/Y+DispbYeDxFwiZemTCUEzUFz/70ye
         6vc0mwa6kam33TKKzquYTE2RAiqCCRS+A+xDrJoUzGKVb3TLEHBA2uFmFTEnz8ywtobE
         Ynuu7syO3bHMa7Tbl+3ePGV9FFgDVCz33CBBB6pRVpJJWlJdxDyuPX7hLdfPtCnlP963
         qJ8nK0wdbF4st88V2VxrKBfCr7KCHnGgOB+7fFTbmDiXCY+9ERE7hnVCyZTdBxww5vbR
         PqOA==
X-Forwarded-Encrypted: i=1; AJvYcCXl0R/5Tx/jF5CnZpUw2GPmCfaXX/dbfUp9yz8PytQrn5r5ewuzrvy4oxRvJp1qFtvvjbMruO/B9I7okBA2Kp5vHnFfNlBlR4GsK2Ak
X-Gm-Message-State: AOJu0YxpZzQfnpOcsuKJldT1OW+bEvIv67WtvJPB8gnweE8QSPT2hPAb
	L7PUY8CZQkk2rcg/W4u3WylIWW1RvvAObnHRhAICqW6tJigzj/Q1WNEtfjMxHqo=
X-Google-Smtp-Source: AGHT+IGkwDomQEANyZ+eXIUVoM6FPDmgEQt/mHUtBowVFVCo5z8ux3/Xf7CVbrm5g5deo4x8C36TWw==
X-Received: by 2002:a5d:457a:0:b0:366:e496:1caa with SMTP id ffacd0b85a97d-366e4961e22mr5453532f8f.5.1719386920297;
        Wed, 26 Jun 2024 00:28:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638e90ccbsm14947006f8f.59.2024.06.26.00.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:28:39 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:28:37 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Daniel Stone <daniel@fooishbar.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <ZnvDJVeT3rz-hnv9@phenom.ffwll.local>
Mail-Followup-To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Daniel Stone <daniel@fooishbar.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Daniel Stone <daniels@collabora.com>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Mon, Jun 17, 2024 at 07:01:05PM +0200, Tomeu Vizoso wrote:
> Hi Lucas,
> 
> Do you have any idea on how not to break userspace if we expose a render node?

So if you get a new chip with an incompatible 3d block, you already have
that issue. And I hope etnaviv userspace can cope.

Worst case you need to publish a fake extremely_fancy_3d_block to make
sure old mesa never binds against an NPU-only instance.

Or mesa just doesn't cope, in which case we need a etnaviv-v2-we_are_sorry
drm driver name, or something like that.
-Sima

> 
> Cheers,
> 
> Tomeu
> 
> On Wed, Jun 12, 2024 at 4:26 PM Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> >
> > On Mon, May 20, 2024 at 1:19 PM Daniel Stone <daniel@fooishbar.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, 20 May 2024 at 08:39, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> > > > On Fri, May 10, 2024 at 10:34 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > > Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso:
> > > > > > If we expose a render node for NPUs without rendering capabilities, the
> > > > > > userspace stack will offer it to compositors and applications for
> > > > > > rendering, which of course won't work.
> > > > > >
> > > > > > Userspace is probably right in not questioning whether a render node
> > > > > > might not be capable of supporting rendering, so change it in the kernel
> > > > > > instead by exposing a /dev/accel node.
> > > > > >
> > > > > > Before we bring the device up we don't know whether it is capable of
> > > > > > rendering or not (depends on the features of its blocks), so first try
> > > > > > to probe a rendering node, and if we find out that there is no rendering
> > > > > > hardware, abort and retry with an accel node.
> > > > >
> > > > > On the other hand we already have precedence of compute only DRM
> > > > > devices exposing a render node: there are AMD GPUs that don't expose a
> > > > > graphics queue and are thus not able to actually render graphics. Mesa
> > > > > already handles this in part via the PIPE_CAP_GRAPHICS and I think we
> > > > > should simply extend this to not offer a EGL display on screens without
> > > > > that capability.
> > > >
> > > > The problem with this is that the compositors I know don't loop over
> > > > /dev/dri files, trying to create EGL screens and moving to the next
> > > > one until they find one that works.
> > > >
> > > > They take the first render node (unless a specific one has been
> > > > configured), and assumes it will be able to render with it.
> > > >
> > > > To me it seems as if userspace expects that /dev/dri/renderD* devices
> > > > can be used for rendering and by breaking this assumption we would be
> > > > breaking existing software.
> > >
> > > Mm, it's sort of backwards from that. Compositors just take a
> > > non-render DRM node for KMS, then ask GBM+EGL to instantiate a GPU
> > > which can work with that. When run in headless mode, we don't take
> > > render nodes directly, but instead just create an EGLDisplay or
> > > VkPhysicalDevice and work backwards to a render node, rather than
> > > selecting a render node and going from there.
> > >
> > > So from that PoV I don't think it's really that harmful. The only
> > > complication is in Mesa, where it would see an etnaviv/amdgpu/...
> > > render node and potentially try to use it as a device. As long as Mesa
> > > can correctly skip, there should be no userspace API implications.
> > >
> > > That being said, I'm not entirely sure what the _benefit_ would be of
> > > exposing a render node for a device which can't be used by any
> > > 'traditional' DRM consumers, i.e. GL/Vulkan/winsys.
> >
> > What I don't understand yet from Lucas proposal is how this isn't
> > going to break existing userspace.
> >
> > I mean, even if we find a good way of having userspace skip
> > non-rendering render nodes, what about existing userspace that isn't
> > able to do that? Any updates to newer kernels are going to break them.
> >
> > Regards,
> >
> > Tomeu

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

