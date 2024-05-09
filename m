Return-Path: <linux-kernel+bounces-174346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022A8C0D75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6441F22A80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA314A629;
	Thu,  9 May 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="eYUdyphX"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97144D528
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246612; cv=none; b=qHPi6sp8TRujZxJ958BenoJBGoQ8tY46XtpKzRqzAXKn+nYGBkTa/PvRZQlkKaHvwsudAN78y6v/cjVZsVZ904dmTz1cNuNvrOyqdcnMjXkx/4PjSxDDdz0SR3ubJhicZN5GJbF0mparqcN5zyr/Rs04IaostpkCfR9bf/7ytNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246612; c=relaxed/simple;
	bh=nCxyHA4H0zlDgKUBRKhP1uHW5cceyxKQ1uLbmFwQQPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FnMwLn9G2TLsnV5qyGnNc9W8QUKeTfWzjNPuXaH22g0x78yexoq0vTWHLk4RPO9ugC3vxU5MwJ1nil3vVqBgwv7BDC1H51V3uDPPCKQfZpmM92XvTnlPfh2AOuLkisttoP3e/UwObyvOJSbUirRqRaoDMSz9D3tsVRnVEohdG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=eYUdyphX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792b9790f6bso53280985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1715246609; x=1715851409; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCxyHA4H0zlDgKUBRKhP1uHW5cceyxKQ1uLbmFwQQPk=;
        b=eYUdyphXQ2ZTF7qd1pDipbmkAzjobeKUCUb8TlN/ddMY9UHA0BFeUZUFiZcWy//i5d
         Aa8+swrjNgaXU0kPCh8Y7hsgsJELnbKadZgl4i5OKC7cntZ71vEFN536g3MIn+BkFKWP
         pdFE18c2RYwr3FUS+sE3wq3dll038MRpPvhLsO4voBedBO55HJhq9PFjpoX7m9eVQL62
         MLY5pX6mlw1Nstg2Bapb7fRULaide+wUu9ucBQLA4GWaXw84MbR8P7Nn8z5WwyO03jb8
         oFSGn0kSvdUOHOelB8nwXVZ3xos3clE1OijEIuPEG50C9z9OZRi+88fdV6bZi8jYvOSG
         IIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246609; x=1715851409;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCxyHA4H0zlDgKUBRKhP1uHW5cceyxKQ1uLbmFwQQPk=;
        b=GTe1Epc0EFOIdJQcqalP9CjnZ8HuGyA7An2bNFqtNDgLeyT59t/wda+sokCIxaD2p9
         0dn+D5pR3je9pxV5MzNRMRfQVvjJBoXR2fb9LqLI7i0r6IEqbvlAD8IGWzYPmHesQyPF
         XSgVLiWnjBFmTHPGOkOgDNqusK6uLXs4y5OS3tIrATWfCabczUs9sgMtHlwkUJar6RDs
         M167ak8mYKi7Me41CCjBQuy0v+jeM9fmx0Hf4Se4mr70NYubt56VWgDcaDJuQUF7Y0Fs
         f4VAefCsFfYxzsYmNKgZPpZaujur4WJxY17CzaLWzdyBurT22ZHL4BggUFuyaDSo/0nd
         8cEA==
X-Forwarded-Encrypted: i=1; AJvYcCUpC2UtyahOgkGHE6xM7e9MXuW7QKO7Gs4oFsOOKt/oKx/lG6BtxaRQm3//3Xhgb2mH9CD4/rfCwamDOgK11j1cdBMgG/WumsdlfTAO
X-Gm-Message-State: AOJu0Yw/6VgDUTINbskT+3XkYRCiygkEwUkXaFcHXXPZDoz6KgEa8H/9
	BrDJfs1CEedCKuP4rvXWU0UZucA1SLLcMYH1DyfNvqVwJl4WVPAMC+1cYJRC5JEyNvFGUn5Xuts
	+p4R7ZzYGeUAf69YwcIC5Y4tJpUykHnWiMc/s3g==
X-Google-Smtp-Source: AGHT+IF6PhCgk1o7f4b1gc4aesQqVT1tyRMXdb/II5WaUUVRVGN+oa4txBNRnx7jzplgxY+HJ/x6UmsSdSVG8eSyBMk=
X-Received: by 2002:a05:6214:1cc2:b0:6a0:d32d:79d with SMTP id
 6a1803df08f44-6a1514dfd79mr58597296d6.56.1715246609461; Thu, 09 May 2024
 02:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <20240506-dazzling-nippy-rhino-eabccd@houat> <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
 <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com> <ZjoNTw-TkPnnWLTG@phenom.ffwll.local>
 <CAPj87rN3uSZoHpWLSQqz1SW9YMZNj9fkoA_EDEE_bzv-Tw8tSw@mail.gmail.com>
 <Zjs42PGvilLlF0Cg@phenom.ffwll.local> <CAPj87rN-wSbGSAoB8y3MXCS20_MAQvfpWSeUKYR6XzQ+Oh0FZA@mail.gmail.com>
 <Zjue98r4ZgGbMN5K@phenom.ffwll.local>
In-Reply-To: <Zjue98r4ZgGbMN5K@phenom.ffwll.local>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 9 May 2024 10:23:16 +0100
Message-ID: <CAPj87rPywSjKLrv00N-0SrkDndPdYGCBeveO0adh4xGCp20h9g@mail.gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
To: Daniel Stone <daniel@fooishbar.org>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, 
	Sebastien Bacher <sebastien.bacher@canonical.com>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 8 May 2024 at 16:49, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, May 08, 2024 at 09:38:33AM +0100, Daniel Stone wrote:
> > Right now, if your platform requires CMA for display, then the app
> > needs access to the GPU render node and the display node too, in order
> > to allocate buffers which the compositor can scan out directly. If it
> > only has access to the render nodes and not the display node, it won't
> > be able to allocate correctly, so its content will need a composition
> > pass, i.e. performance penalty for sandboxing. But if it can allocate
> > correctly, then hey, it can exhaust CMA just like heaps can.
> >
> > Personally I think we'd be better off just allowing access and
> > figuring out cgroups later. It's not like the OOM story is great
> > generally, and hey, you can get there with just render nodes ...
>
> Imo the right fix is to ask the compositor to allocate the buffers in this
> case, and then maybe have some kind of revoke/purge behaviour on these
> buffers. Compositor has an actual idea of who's a candidate for direct
> scanout after all, not the app. Or well at least force migrate the memory
> from cma to shmem.
>
> If you only whack cgroups on this issue you're still stuck in the world
> where either all apps together can ddos the display or no one can
> realistically direct scanout.

Mmm, back to DRI2. I can't say I'm wildly enthused about that, not
least because a client using GPU/codec/etc for those buffers would
have to communicate its requirements (alignment etc) forward to the
compositor in order for the compositor to allocate for it. Obviously
passing the constraints etc around isn't a solved problem yet, but it
is at least contained down in clients rather than making it back and
forth between client and compositor.

I'm extremely not-wild about the compositor migrating memory from CMA
to shmem behind the client's back, and tbh I'm not sure how that would
even work if the client has it pinned through whatever API it's
imported into.

Anyway, like Laurent says, if we're deciding that heaps can't be used
by generic apps (unlike DRM/V4L2/etc), then we need gralloc.

Cheers,
Daniel

