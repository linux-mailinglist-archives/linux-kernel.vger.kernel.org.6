Return-Path: <linux-kernel+bounces-171450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840838BE46D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109B62878A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A615F3F4;
	Tue,  7 May 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BABvXfHq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF515EFDC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088889; cv=none; b=l2HVvNAG+jBsapJAp5R7+vr/e0hp0gk4tmTSJppiHtlgbeSWUqlN5EcX02mU2VUqvQ9qqdSqq7vBJ5bHqFak2wBc1lDTJMj8dIMOqTICTGLWkM+cV6z+Igcs+nhRR91C4cUmpQw95tLOpiBJduie0tmeKwDafBlfPcMI7LtSgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088889; c=relaxed/simple;
	bh=RSGtQZGJXs8I6hGHPO4lrlq3ymfMFw5EiPxwgetnth0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI+bAYr11Nbf/mrmcoYrlZzlkZeXe9JZo3DPN7vDa+kwajjqk8dH6evcNhTES81ub/V7gsT5AOwxZqueCwXIJaD0/V/V/yliFfZBwx86ANWbtCZGri1jNchiCbLYDGoP4mQnLYPcGZDCF6JH565uvUyeottZ16EI81GuAhBpCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BABvXfHq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f3761c96aso4082016e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715088886; x=1715693686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKHBCvFKsC6Nzkx2NIWqoEqwLv1oOisbbcdd9aYPJks=;
        b=BABvXfHq536qkZYcYEuvTYRhk1d1yC8T0W1sWwT8uHqfQyak7FaMLbQ9iMniyVaF5f
         TGccjdcBsuMGmtTI9fOM1a+Vs0hMwGUVI0F+YDspy7PKnUnjKcBnZTIUvuMuLNAY9VKs
         hur/uAr1GY81sR+mlbTAI6zROXre/hCJ59+1S20sdAxK2wZNftVk6kQ1yEUiIEShEu3V
         2ovhQX79rL/s//vFp5vnNBQfs6B7Jqifjtks6xeJsHaxXmhL61piF/qwJVnyog+tkeQo
         jjqASijPzeaZcrLSOItOI6Uso8CkbpUe2SdK77ljNtUYW5b8tuwfwhJ2Iw/bVODs3mAC
         91lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088886; x=1715693686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKHBCvFKsC6Nzkx2NIWqoEqwLv1oOisbbcdd9aYPJks=;
        b=r2wLmDxhl99QrOzUoF/QPK8WQn7O2iVOeG6KoulWTekcibRbnCIBX2NwEJSjOjMwWq
         j7HZzuPe5JjXC3yvpbqcsp/C9gu8ZfwxlwfM88AUtiUBeeNF57l4F0Tsb4pTU4eMnFdW
         8I/Cffsb/HMiGewWv8ekv6wWyV+H6Sygk8rZUUznf/bA4+vTc2j1RDPkEbJ0p8aaWOJp
         kp0FSMkviKSFM34FaWzJoOtUDG42yIFzJ5E778JR/qv5ywFJdYQz7oZAcDUeAGIr+fW3
         XuQ/IbYCNW/CUb4bPfcM0mKAZKsy184LXaaYuD98eywRga/cQ/1ML/Wl4dgvxbXZCiDb
         dctg==
X-Forwarded-Encrypted: i=1; AJvYcCX1FqCUIqbMHtIk8fP4uZAfuUNX9F9//ezdaIWMSDmA2QBWeE56XWqjQ9Ra0q6MH096cC7NFnf6IlWvk09f2ejjFaKrtr4slgXIFFFA
X-Gm-Message-State: AOJu0YxeRCJ1QxIzGKQrbe91POtpLC99lsbfDFqELfZ8j8tPwUqH35Kr
	vJeaKgHWyKTyx7WXMGyPlIb3BSJ2tNfiwf5g1i+kdS3wHQJkT8lpo//lmEjPjohrLHIv5G6kJ6e
	f
X-Google-Smtp-Source: AGHT+IGyKKhW4HnullLr9tx7zUu9woNhXXRdGqxwVRSmjqIAiK9LODOmA2YK6g9UQq++3wQQpsuazA==
X-Received: by 2002:a05:6512:4016:b0:51f:567b:c399 with SMTP id br22-20020a056512401600b0051f567bc399mr14982616lfb.62.1715088885984;
        Tue, 07 May 2024 06:34:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id t6-20020ac243a6000000b0051d87562dfasm2116396lfl.27.2024.05.07.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:34:45 -0700 (PDT)
Date: Tue, 7 May 2024 16:34:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <mripard@redhat.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, 
	Sebastien Bacher <sebastien.bacher@canonical.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Milan Zamazal <mzamazal@redhat.com>, Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <xwozli5vbte53ohjhjmne6zzfgmdxey43i35d37ht7rrxooixi@ijfqthxe6voj>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <20240506-dazzling-nippy-rhino-eabccd@houat>
 <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
 <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com>

On Mon, May 06, 2024 at 04:01:42PM +0200, Hans de Goede wrote:
> Hi Sima,
> 
> On 5/6/24 3:38 PM, Daniel Vetter wrote:
> > On Mon, May 06, 2024 at 02:05:12PM +0200, Maxime Ripard wrote:
> >> Hi,
> >>
> >> On Mon, May 06, 2024 at 01:49:17PM GMT, Hans de Goede wrote:
> >>> Hi dma-buf maintainers, et.al.,
> >>>
> >>> Various people have been working on making complex/MIPI cameras work OOTB
> >>> with mainline Linux kernels and an opensource userspace stack.
> >>>
> >>> The generic solution adds a software ISP (for Debayering and 3A) to
> >>> libcamera. Libcamera's API guarantees that buffers handed to applications
> >>> using it are dma-bufs so that these can be passed to e.g. a video encoder.
> >>>
> >>> In order to meet this API guarantee the libcamera software ISP allocates
> >>> dma-bufs from userspace through one of the /dev/dma_heap/* heaps. For
> >>> the Fedora COPR repo for the PoC of this:
> >>> https://hansdegoede.dreamwidth.org/28153.html
> >>
> >> For the record, we're also considering using them for ARM KMS devices,
> >> so it would be better if the solution wasn't only considering v4l2
> >> devices.
> >>
> >>> I have added a simple udev rule to give physically present users access
> >>> to the dma_heap-s:
> >>>
> >>> KERNEL=="system", SUBSYSTEM=="dma_heap", TAG+="uaccess"
> >>>
> >>> (and on Rasperry Pi devices any users in the video group get access)
> >>>
> >>> This was just a quick fix for the PoC. Now that we are ready to move out
> >>> of the PoC phase and start actually integrating this into distributions
> >>> the question becomes if this is an acceptable solution; or if we need some
> >>> other way to deal with this ?
> >>>
> >>> Specifically the question is if this will have any negative security
> >>> implications? I can certainly see this being used to do some sort of
> >>> denial of service attack on the system (1). This is especially true for
> >>> the cma heap which generally speaking is a limited resource.
> >>
> >> There's plenty of other ways to exhaust CMA, like allocating too much
> >> KMS or v4l2 buffers. I'm not sure we should consider dma-heaps
> >> differently than those if it's part of our threat model.
> > 
> > So generally for an arm soc where your display needs cma, your render node
> > doesn't. And user applications only have access to the later, while only
> > the compositor gets a kms fd through logind. At least in drm aside from
> > vc4 there's really no render driver that just gives you access to cma and
> > allows you to exhaust that, you need to be a compositor with drm master
> > access to the display.
> > 
> > Which means we're mostly protected against bad applications, and that's
> > not a threat the "user physically sits in front of the machine accounts
> > for", and which giving cma access to everyone would open up. And with
> > flathub/snaps/... this is very much an issue.
> 
> I agree that bad applications are an issue, but not for the flathub / snaps
> case. Flatpacks / snaps run sandboxed and don't have access to a full /dev
> so those should not be able to open /dev/dma_heap/* independent of
> the ACLs on /dev/dma_heap/*. The plan is for cameras using the
> libcamera software ISP to always be accessed through pipewire and
> the camera portal, so in this case pipewere is taking the place of
> the compositor in your kms vs render node example.
> 
> So this reduces the problem to bad apps packaged by regular distributions
> and if any of those misbehave the distros should fix that.
> 
> So I think that for the denial of service side allowing physical
> present users (but not sandboxed apps running as those users) to
> access /dev/dma_heap/* should be ok.

What about an app built by the user? The machines can still be
multi-seat or have multiple users.

> My bigger worry is if dma_heap (u)dma-bufs can be abused in other
> ways then causing a denial of service.
> 
> I guess that the answer there is that causing other security issues
> should not be possible ?
> 
> Regards,
> 
> Hans
> 

-- 
With best wishes
Dmitry

