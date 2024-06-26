Return-Path: <linux-kernel+bounces-230193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E8D9179A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4BB1F2436A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F8315A856;
	Wed, 26 Jun 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QQEUlhnw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAF1598E3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386807; cv=none; b=fzMh2veHEL3L5TFqEDWwvzQKN8G1k8ULEzL2YQdrp7DSZUvjnmMKG6vAJD2/KtW21jgAvVgZPJZGSGKXJRN0flqZY5JDOIX1AivXwzOi+IvHZ0FENCnvqv5yyMTeqnEgYoJL9FdCAgGbeVIZTDT3Mxv4vnKC9gs13N7RSvivHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386807; c=relaxed/simple;
	bh=hpdbSay+4y8O+Hm6PRDCATi/6rr7X5OL4cPffuxhmmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZtgbi1/iqtVUGBbSj3LpiTfXM3wjnpp5QfYnLs7BQm0eOVanMYrNUp/N3xDYB73AlC/sMUOfddxot7qv2TMEyUGIcWb0EbctnyqU73LJUex2ezIsd3gAkJT8RpLbEXLau7iRIbEnXSCXsPPM691ne43YfQmJgGMyGuJnvKb+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QQEUlhnw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-363ba6070b1so231922f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719386803; x=1719991603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMADylHdd12eheZDYxCQcaXIZ7L3W07jFpRH04vs5ZQ=;
        b=QQEUlhnwz22EF6L7QfJRehIvxkXyAQm6jqtJUJtQOWAjE+nmhU9cHTqUvuQCgxsdNj
         bdobWXOBW2KzDUrFgGxFcO0YWX4Cr317Y2+6GBYsGiQXpNocmj0dTnDiKtJf6bKsZNxb
         cp3ETfF8NLaYzDqH5uYjXShNLPGWKTTjBBFfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719386803; x=1719991603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMADylHdd12eheZDYxCQcaXIZ7L3W07jFpRH04vs5ZQ=;
        b=c/WZUenFh4FFwJEx3DYepN3nXWbwWRHke0uecgEnr9ahsmsYBNdiuXtU7uly8annhO
         fj8vsbfhj47gU4KVSn1WBuZBYS+f2M4Wv6qt+3Wf1VuwbWd0qUbMYZRMxF0SzzE6BbD1
         bp3RddFCCzgdqNXqpBTFJwaBdyc0qforP3fKG5tCNPLSU1UfzTZnqI6eFfTSD4KxWWXS
         iXqEf7PSGTTFGm4aTRwyrKIoNZX/9v4nrb0cSV7pY3j1rHrVAIEkzPWAGjtdAgW65o0i
         YPalP1w2B4390WLCd2O8/WruAb1qHezfNZWXgcqvvrHNVc9gfGsVBy1WlmBoOwb5SJIG
         jTTg==
X-Forwarded-Encrypted: i=1; AJvYcCWja1UzEwWr6K3byWD6pUuxFA6GFdFxsBLoZYZKCK/9AN2TDPs4Y51XoAfArS0gOM42g+egFnOwHVVfT0M+zVt1rGXOdtGaLA7sKj8B
X-Gm-Message-State: AOJu0Yy2HGK7gQXfbjs83S4PlN8dFRU6c1ZaW3cdz1xoXxDOAICkklzP
	GKF2NsDDIEWw2Cv7R1C0WNHJDzfw/umEMnR35cIV1C0R7kubZhwyWuZLr9uPXA4=
X-Google-Smtp-Source: AGHT+IHeQqyDxVRd9QAvvWNFl7K8NBdMF289e85FjexEmWnGMrmTe32t1vKI5rWbeEJPDYl7vHlqfQ==
X-Received: by 2002:a05:6000:18ae:b0:35f:2929:846e with SMTP id ffacd0b85a97d-366e2a0a8eemr7752228f8f.1.1719386803205;
        Wed, 26 Jun 2024 00:26:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8597sm14875130f8f.36.2024.06.26.00.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:26:42 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:26:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <ZnvCsJfdZdLvw1ZN@phenom.ffwll.local>
Mail-Followup-To: Oded Gabbay <ogabbay@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
 <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
 <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>
 <20240509144118.baib2pftmpk5nikr@GABBAY.>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509144118.baib2pftmpk5nikr@GABBAY.>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Thu, May 09, 2024 at 05:41:18PM +0300, Oded Gabbay wrote:
> On Thu, May 09, 2024 at 03:53:01PM +0200, Tomeu Vizoso wrote:
> > Oded, Dave,
> > 
> > Do you have an opinion on this?
> > 
> > Thanks,
> > 
> > Tomeu
> Hi Tomeu,
> 
> Sorry for not replying earlier, I was down with Covid (again...).
> 
> To your question, I don't have an objection to what you are
> suggesting. My personal view of accel is that it is an integral part of 
> DRM and therefore, if there is an *existing* drm driver that wants to 
> create an accel node, I'm not against it. 

Yeah, there's a continum from "clearly 3d gpu" to "compute AI
accelerator", with everything possible in-between shipping somewhere.
Collaboration is the important part, hair-splitting on where exactly the
driver should be is kinda secondary. I mean beyond "don't put a pure 3d
driver into accel or vice versa" of course :-)

> There is the question of why you want to expose an accel node, and
> here I would like to hear Dave's and Sima's opinion on your suggested
> solution as it may affect the direction of other drm drivers.

So existing userspace that blindly assumes that any render node will give
it useful 3d acceleration, then that's broken already.

- kernel with new driver support but old mesa without that driver already
  gives you that, even for a pure 3d chip.

- intel (and I think also amd) have pure compute chips without 3d, so this
  issue already exists

Same for the other directions, 3d gpus have variable amounts of compute
chips nowadays.

That leaves imo just the pragmatic choice, and if we need to complicate
the init flow of the kernel driver just for a different charnode major,
then I don't really see the point.

And if we do see the point in this, I think the right approach would be if
we split the init flow further into allocating the drm_device, and then in
a 2nd step either allocate the accel or render uapi stuff as needed. The
DRIVER_FOO flags just aren't super flexible for this kinda of stuff and
have a bit a midlayer taste to them.

Cheers, Sima

> 
> Thanks,
> Oded.
> 
> p.s.
> Please only use bottom-posting when replying, thanks :)
> 
> > 
> > On Fri, Apr 26, 2024 at 8:10 AM Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> > >
> > > On Thu, Apr 25, 2024 at 8:59 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
> > > >
> > > > On 4/24/2024 12:37 AM, Tomeu Vizoso wrote:
> > > > > If we expose a render node for NPUs without rendering capabilities, the
> > > > > userspace stack will offer it to compositors and applications for
> > > > > rendering, which of course won't work.
> > > > >
> > > > > Userspace is probably right in not questioning whether a render node
> > > > > might not be capable of supporting rendering, so change it in the kernel
> > > > > instead by exposing a /dev/accel node.
> > > > >
> > > > > Before we bring the device up we don't know whether it is capable of
> > > > > rendering or not (depends on the features of its blocks), so first try
> > > > > to probe a rendering node, and if we find out that there is no rendering
> > > > > hardware, abort and retry with an accel node.
> > > > >
> > > > > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > > > Cc: Oded Gabbay <ogabbay@kernel.org>
> > > >
> > > > I hope Oded chimes in as Accel maintainer.  I think Airlie/Vetter had
> > > > also previously mentioned they'd have opinions on what is Accel vs DRM.
> > > >
> > > > This gets a nack from me in its current state.  This is not a strong
> > > > nack, and I don't want to discourage you.  I think there is a path forward.
> > > >
> > > > The Accel subsystem documentation says that accel drivers will reside in
> > > > drivers/accel/ but this does not.
> > >
> > > Indeed, there is that code organization aspect.
> > >
> > > > Also, the commit text for "accel: add dedicated minor for accelerator
> > > > devices" mentions -
> > > >
> > > > "for drivers that
> > > > declare they handle compute accelerator, using a new driver feature
> > > > flag called DRIVER_COMPUTE_ACCEL. It is important to note that this
> > > > driver feature is mutually exclusive with DRIVER_RENDER. Devices that
> > > > want to expose both graphics and compute device char files should be
> > > > handled by two drivers that are connected using the auxiliary bus
> > > > framework."
> > > >
> > > > I don't see any of that happening here (two drivers connected by aux
> > > > bus, one in drivers/accel).
> > >
> > > Well, the text refers to devices, not drivers. The case we are talking
> > > about is a driver that wants to sometimes expose an accel node, and
> > > sometimes a render node, depending on the hardware it is dealing with.
> > > So there would either be a device exposing a single render node, or a
> > > device exposing a single accel node.
> > >
> > > Though by using the auxiliary bus we could in theory solve the code
> > > organization problem mentioned above, I'm not quite seeing how to do
> > > this in a clean way. The driver in /drivers/gpu/drm would have to be a
> > > DRM driver that doesn't register a DRM device, but registers a device
> > > in the auxiliary bus for the driver in /drivers/accel to bind to? Or
> > > are you seeing some possibility that would fit better in the current
> > > DRM framework?
> > >
> > > > I think this is the first case we've had of a combo DRM/Accel usecase,
> > > > and so there isn't an existing example to refer you to on how to
> > > > structure things.  I think you are going to be the first example where
> > > > we figure all of this out.
> > >
> > > Yep, I will be grateful for any ideas on how to structure this.
> > >
> > > > On a more implementation note, ioctls for Accel devices should not be
> > > > marked DRM_RENDER_ALLOW.  Seems like your attempt to reuse as much of
> > > > the code as possible trips over this.
> > >
> > > Indeed, thanks.
> > >
> > > Cheers,
> > >
> > > Tomeu
> > >
> > > > -Jeff

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

