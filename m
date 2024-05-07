Return-Path: <linux-kernel+bounces-171661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58508BE706
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028491C22FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFDA1635A8;
	Tue,  7 May 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6GWoR33"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C0161333
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094558; cv=none; b=Ii6nnS9IxCyFE21VTzVSywxGA3KhctM/g7AKPnZen5R1JwtOHQbHs1y9le1blwfucbLa6NissZaP2HRG2rSF3TrSO6Z91p1bQRLzuDQxgHTaZZKDm8BSkx5B6AiTi+EAPzMQCnEMJ8UXycUAbl5OgkbNS9KTXIZPnS0uUqtO/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094558; c=relaxed/simple;
	bh=n6QObf6AjlF0CjynOKd7beMemPp9/Rf6ewdeNj13pR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oev5T+2TZLr1hh+ffVlh7JPcoN+VFtyPuA3Y0Rps+rcfm6rckZUmQa55mDN9QxSWZDUjCRqphJqr8n5Evtr1Uw3AQpIDWLhm7hrUNTjPyZGh8GJ6qysqDha4Jbp+Xv2oEqmlC8GzTb4W6CKEXFLOeJiHceYmiuCN20vVk5P7M/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i6GWoR33; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e1d6166521so45199811fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715094555; x=1715699355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApmnaGazi/o+2qAXdIqqO3f0hkV/MV/lnHoUUZ1Ogfk=;
        b=i6GWoR33teI0nYAHTTwcgSVLbf+nk0v793MYVYEv7bioCm1fm7AODIrDN1Z9toQS6W
         XQYt6eRQnupo375HGkgNkn4Wdg4k25JPwDfwjQg83pthUHLSnmWhk5eINteUyERHRkEx
         qnikiB+DhBqkP5B18cAYKybi55CUUZ04fe2NwHEshIgYYCrz316eqgkVBZKUhfe1L5PH
         6g31gvyfSNRjo1Vyvaw/j8FfZza7nmPIkgq3EA9ZXaBHa9Fe5PWyACg/MfI+wnardr6B
         4hUwmEXVh8ROuPdVDr53eO+EK+WWpofO7NpzBpys1IKmw4rJ76EFrGUUB/nn0csQ9nhR
         y/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094555; x=1715699355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApmnaGazi/o+2qAXdIqqO3f0hkV/MV/lnHoUUZ1Ogfk=;
        b=AwZZ0SbZVKJ0ynTRSBYYZQOljgqUEvLxPR2A1biJpgUURkQ6849rywlBNMd5cS7fA0
         95sSnofMghjJdamHs4nnn/1t20O+n4Hl/ni2Ex+YYAN5ufg1YPD8SxDVk/y4bl40Hc4U
         0wHRrJnIz09MA5BzzscNrLNyfCx3oSz2z+MkvkY1zhBseHR2XfVpCF3+QkgU+4B3eBVC
         eKW8DIv89O/frbc/wKoHDQyYtypDbN0PBDJY4tp8uSxbyy54W7R1W/CfcCbJXvDJiGfz
         sBJBZdDqXYFzkiyvIQGs9/Y3LsXqdulfi2qKi4HOSfhOOU7b3wHzHG3xJ3oiUI+W4wBs
         mQmA==
X-Forwarded-Encrypted: i=1; AJvYcCUjEghA16XDwQ3Hc0YaaX90BaffQekYK9AnJSjaREitduGyhZg0u45WYMG7zIZ3dNRLnxQMdbZfcvJfJfA578lgqvAYJwWNFmIjsUD1
X-Gm-Message-State: AOJu0YyPYszPE+14737PVg91wQ+ID/ebScOtAbDfzGap9Ud5pQV4wCvD
	rZwCiTZT01sJLWNVH32V1N0LUwunOol1nUdGaD1MuKf1oFHXCVtFz1/Pjn2Fx1c=
X-Google-Smtp-Source: AGHT+IFpsJSfGLwS1hXqc0H0trd4MGTiP4vo11gPFrTKC7JHOIUnEb9JodJJuvbqXdQX62FwbtE9XA==
X-Received: by 2002:a2e:9598:0:b0:2e2:3761:2ef5 with SMTP id 38308e7fff4ca-2e3d956847dmr9646361fa.14.1715094554850;
        Tue, 07 May 2024 08:09:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id r16-20020a2e8e30000000b002e35b79a00bsm935940ljk.124.2024.05.07.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:09:14 -0700 (PDT)
Date: Tue, 7 May 2024 18:09:13 +0300
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
Message-ID: <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>

On Tue, May 07, 2024 at 04:34:24PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 5/7/24 3:32 PM, Dmitry Baryshkov wrote:
> > On Mon, May 06, 2024 at 01:49:17PM +0200, Hans de Goede wrote:
> >> Hi dma-buf maintainers, et.al.,
> >>
> >> Various people have been working on making complex/MIPI cameras work OOTB
> >> with mainline Linux kernels and an opensource userspace stack.
> >>
> >> The generic solution adds a software ISP (for Debayering and 3A) to
> >> libcamera. Libcamera's API guarantees that buffers handed to applications
> >> using it are dma-bufs so that these can be passed to e.g. a video encoder.
> >>
> >> In order to meet this API guarantee the libcamera software ISP allocates
> >> dma-bufs from userspace through one of the /dev/dma_heap/* heaps. For
> >> the Fedora COPR repo for the PoC of this:
> >> https://hansdegoede.dreamwidth.org/28153.html
> > 
> > Is there any reason for allocating DMA buffers for libcamera through
> > /dev/dma_heap/ rather than allocating them via corresponding media
> > device and then giving them away to DRM / VPU / etc?
> > 
> > At least this should solve the permission usecase: if the app can open
> > camera device, it can allocate a buffer.
> 
> This is with a software ISP, the input buffers with raw bayer data
> come from a v4l2 device, but the output buffers with the processed
> data are purely userspace managed in this case.

Ah, I see. Then why do you require the DMA-ble buffer at all? If you are
providing data to VPU or DRM, then you should be able to get the buffer
from the data-consuming device. If the data is further processed by
a userspace app, then it should not require DMA memory at all.

My main concern is that dma-heaps is both too generic and too limiting
for the generic library implementation.

-- 
With best wishes
Dmitry

