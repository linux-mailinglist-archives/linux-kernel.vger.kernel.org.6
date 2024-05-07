Return-Path: <linux-kernel+bounces-171446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E68BE45E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A771C23CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA216D30E;
	Tue,  7 May 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/ZtlBcD"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52416C86B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088744; cv=none; b=ssvAo4K6f3tgkniN42uLaVjP5aDmC/GPJvX6G8QKN9LVBeq14a0w0gMdH/5T8kCY4jzTbnnU3wz+i0zgO0edQjh2f8r2wP7YaZm0rJUkG22WmAGOw4PtPEFIoHNIvgTenP904sDstiKs/MFTloXtBnKfHfcGqme311BNPB/PX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088744; c=relaxed/simple;
	bh=UJlF2bhHHChbK6u5/+NFiBJBntvOiOhalI3jj92AG7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHTXWCL+5pki6YHQPmyHFEa5K9Vs7rl8szIXJ3CCfL3ToTRdJb1OFfTO45179+v1o1RWWih/pabrB7vjXG+sjz4Wjs+t086rGKOv95MTroaiTcH1H0fo1qQky8igVt6DTuz2k3aJWithadr8ODOfTYRq4+SnbL/CMCMhiL8OHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/ZtlBcD; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso11508001fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715088741; x=1715693541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=huJibqJN85r8uyZHaWnhr5W8KxIdUNVSaNrUGy1RNcA=;
        b=U/ZtlBcDMKQwr+oxdoDKvKuQAfz/338KvF5K7MizbQYLET5G6KLOA2qNQXC/1nGyHR
         GxZ8UzFM9KzoJOB+Qbr3FEYqi28C5l7cERzs1z3jK2UPT0S9xViJDXogz3+8QcdUJFyM
         tRzXsjFVD5qb/ixF3Kt9LMKzgb9fyBP8vEco50tLty34vKexEM2TzXeku81NX/I0zEHZ
         yZjCab5cvE8kBXj/sBEAtHr2pSV9dMhqb8EzxP0D3PJFtv/TUPBGQ4yt90xFd5IK3O3U
         cDgYZKpj6FfSxeY5Binj66HBJG2tAki/0oKtZyC87ITvr0u27wBkyBTDeWfnPTAhg+z0
         mVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088741; x=1715693541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huJibqJN85r8uyZHaWnhr5W8KxIdUNVSaNrUGy1RNcA=;
        b=Pg3KE6MrxB80i8XoF1SYqVD4dems5Ho2VIBsQC9T8KxdzEVbOOEcoljx2GYG8YiA4Z
         EvWNrlGMVCcy2fAYKd3tazHNKUC3pjLX243mVSe4gOeJ4uLPQk0u3pLUgHKt+ArSemXa
         1R5QbL3vVVNb6jQfmksF+eLBOAkxyAIuTjVeNqVUU7hKx1zne+qsunDa2oUiytUdx4hr
         s2kExD5ex/pFB3a8YghsVvHdxVCJ1HkQyU6kl7+b+ES8kud6ZoRMF3ypaJBpLjTXV0SG
         R/lwkSJwEp0tbJhsHXqA4K6QtFdGmkWonzefRVUayMe1qmkV/T8xFCEFawzYkIP+73Su
         UTKw==
X-Forwarded-Encrypted: i=1; AJvYcCXkGD3qDwegYr3lk/9sozc8Gbvr/noeiA6G6tQGSZfCCNNHL1Y8OK5Ee4DIdoHJXdDiuHYYSOO5CwppgMDY+Rdvsd1/RHz6KNrD6gVp
X-Gm-Message-State: AOJu0YxtYccgVESG6nXAKFhNP8Kzkv7d0VC9524MGJstqI0g6/XHWa1y
	zRhITm3kscYgKuooUFipJBZtCKGa66KgEB8wpt3/eDAcz270HFywku9yYM4Vjjk=
X-Google-Smtp-Source: AGHT+IGD/JeQgTpquE7MLFJE26/XO1UVjUN5TKpuK/IVcoLAzeSx3fB3SA/M1rPKsXsUuic7yU+dKQ==
X-Received: by 2002:a05:651c:20a:b0:2df:dea1:5378 with SMTP id y10-20020a05651c020a00b002dfdea15378mr10307465ljn.16.1715088740904;
        Tue, 07 May 2024 06:32:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea366000000b002e2b229d8d5sm1403183ljn.83.2024.05.07.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:32:20 -0700 (PDT)
Date: Tue, 7 May 2024 16:32:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Lennart Poettering <mzxreary@0pointer.de>, 
	Robert Mader <robert.mader@collabora.com>, Sebastien Bacher <sebastien.bacher@canonical.com>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Milan Zamazal <mzamazal@redhat.com>, Maxime Ripard <mripard@redhat.com>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>

On Mon, May 06, 2024 at 01:49:17PM +0200, Hans de Goede wrote:
> Hi dma-buf maintainers, et.al.,
> 
> Various people have been working on making complex/MIPI cameras work OOTB
> with mainline Linux kernels and an opensource userspace stack.
> 
> The generic solution adds a software ISP (for Debayering and 3A) to
> libcamera. Libcamera's API guarantees that buffers handed to applications
> using it are dma-bufs so that these can be passed to e.g. a video encoder.
> 
> In order to meet this API guarantee the libcamera software ISP allocates
> dma-bufs from userspace through one of the /dev/dma_heap/* heaps. For
> the Fedora COPR repo for the PoC of this:
> https://hansdegoede.dreamwidth.org/28153.html

Is there any reason for allocating DMA buffers for libcamera through
/dev/dma_heap/ rather than allocating them via corresponding media
device and then giving them away to DRM / VPU / etc?

At least this should solve the permission usecase: if the app can open
camera device, it can allocate a buffer.

> I have added a simple udev rule to give physically present users access
> to the dma_heap-s:
> 
> KERNEL=="system", SUBSYSTEM=="dma_heap", TAG+="uaccess"
> 
> (and on Rasperry Pi devices any users in the video group get access)
> 
> This was just a quick fix for the PoC. Now that we are ready to move out
> of the PoC phase and start actually integrating this into distributions
> the question becomes if this is an acceptable solution; or if we need some
> other way to deal with this ?
> 
> Specifically the question is if this will have any negative security
> implications? I can certainly see this being used to do some sort of
> denial of service attack on the system (1). This is especially true for
> the cma heap which generally speaking is a limited resource.
> 
> But devices tagged for uaccess are only opened up to users who are 
> physcially present behind the machine and those can just hit
> the powerbutton, so I don't believe that any *on purpose* DOS is part of
> the thread model. Any accidental DOS would be a userspace stack bug.
> 
> Do you foresee any other negative security implications from allowing
> physically present non root users to create (u)dma-bufs ?
> 
> Regards,
> 
> Hans
> 
> 
> 1) There are some limits in drivers/dma-buf/udmabuf.c and distributions
> could narrow these.
> 
> 

-- 
With best wishes
Dmitry

