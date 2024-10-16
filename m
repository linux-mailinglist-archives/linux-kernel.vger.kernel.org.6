Return-Path: <linux-kernel+bounces-368273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C429A0D85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630FC2828FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8275208203;
	Wed, 16 Oct 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlMAdq60"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F154F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090834; cv=none; b=GZnuf7iPVszQtiWLb5abvPKwqe4Y0sKZM25C6Jzf7TG8vTFjiup0NtjwimDrVfUZtdRjjUtRtVUp7pMjCvLdpOMvhz7CJc8JjqEMvyK5YqOs1hNOclN/V0s3u0V8vF7jPc90HHi/a0sYW38o5VClx70Zt1/bG+G5o8pY1/1Qk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090834; c=relaxed/simple;
	bh=7VEr6+nb+JtZzrXZYJbHwTMh0pLhSeykuEBxgW94PZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE0ISHuD3HBlJFSeHayiE2ZxNNiGpnSxZhdwpLVt7gU68pPpbqyvnpbvZK9yHJkB+4oRd3M/jQFypMgdR4LxUbmwNcWDuwG9gmdwBxRKA9MHwmreU06NL+vZ6+0MrdtooxngEiKoV8xk5A+BhS9W4A8OFNSUWdrEGPfCq2u7OOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tlMAdq60; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso276121766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729090831; x=1729695631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvVk37S7HDIQotaWRyOCAFl3y6iQYl7qGJcuBYyG6fg=;
        b=tlMAdq60nBmk7QNx9J4YfWYTcE2vKeVOZMKoVfKdIi7IctHONN+/KolvNrr1KI6qJm
         mThfv31Gba6cd2+W/0LXw1jRgsN8mRWcJcXaYmmnnBmmCJaI5UkA/JwNtWw8VrfW1fs2
         U2bvR9V+giOifcP5Q8EyjUNY+o5qXgTHnSh+Kr5hNbJPoGH0L48zAkRUfdbUSV8qiN0x
         oY2ss9alaxCv8dRuz9TXO84qTGlKjhGBlq9s4VKPNsMl4D/EY5BPDQCUKrWAQxsUhA+J
         u/qNslUZhFP0PakQ/QulBNuVI/QXjbuGNbqu7E//yG0e6ZKk7AtEm2icqQFAV/zm7+5s
         ujuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090831; x=1729695631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvVk37S7HDIQotaWRyOCAFl3y6iQYl7qGJcuBYyG6fg=;
        b=RCinpzH17cgo59cnakDv0dfh2DoSkLdF8MBNlHmIgYltKyt7lD6/lqVnsFcxr8i4W/
         BarUIiJEJp9pL1LFA7Pq8rNLyxWXf2N5iNspdigcqOI2pVM5N/4S9ttJyJvMOAHGba1h
         KcU5Y2xUE/0lcBhdDuxAxWhNNlPjZfTeLNBX6fJeI3UrU6Z4Xj9d4Zc/7DzT+oz+J4y9
         L4kwOxt47smcO+AudNx0VRYVSwHun+WtQ/iNvwY0YTN9ppV1kbPkyLUQRZm4zOdaIBCH
         GVtu+dCNQwUKZIVdJx6nmcQoDDcB7DMAOXJNmS6lHlFJSW20p+mH7sGklQB6Ehvge4GN
         h41w==
X-Forwarded-Encrypted: i=1; AJvYcCVBgOk7FjV2VS8wbaJiMEYhEeOOlOD9GwXyji4NJqYHsUyKyrPZz8IdljFxqBUpV2yX2rH2gynNbN6/r2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2RzxxCy7e5XqUVSY6Ysg6L2KikDFcOxHFQeY1rnRRpnhmsjz
	JnJ7BSmdbQQZHIz/7jznr84PWD1WPhfZguk8a4XVhlvOVbS3t1SHQoWcHuH3nqI=
X-Google-Smtp-Source: AGHT+IGhE+BMO/8ZxT0RUdbfErtRHdNNJ6Chzh60sND1VkRimMUw03/vJ/yRqBQMkCoI+Qxuc9wTzQ==
X-Received: by 2002:a17:906:df46:b0:a9a:1092:b10c with SMTP id a640c23a62f3a-a9a1092b143mr596585266b.12.1729090830491;
        Wed, 16 Oct 2024 08:00:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29895da9sm192448366b.214.2024.10.16.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:00:29 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:00:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: Greg KH <gregkh@linuxfoundation.org>, dpenkler@gmail.com,
	skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
Message-ID: <f3fdd6b8-53bb-4e9d-bb32-3816035d4d52@stanley.mountain>
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
 <2024101654-jasmine-ransack-7190@gregkh>
 <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>

On Wed, Oct 16, 2024 at 06:54:00AM -0600, Everest K.C. wrote:
> > > diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > index f9f149db222d..51b4f9891a34 100644
> > > --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
> > >        */
> > >       usleep_range(10, 15);
> > >       residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
> > > -     if (WARN_ON_ONCE(residue > length || residue < 0))
> > > +     if (WARN_ON_ONCE(residue > length))
> >
> > No, this is incorrect, now we never notice is the call to
> > fluke_get_dma_residue() has failed.  Please fix that bug instead (hint,
> > Covertity is giving you a pointer to where something might be wrong, but
> > this change is NOT how to fix it.)
> I need a little guidance here.
> My best guess to fix the bug would be to make fluke_get_dma_residue()
> return an int instead of unsigned int or size_t. But theoretically the
> maximum value of residue can be UINT_MAX, and casting it to int will
> result in a negative number, which in turn will cause  the error check
> condition to evaluate to true.
> The best solution I see would be to make fluke_get_dma_residue() return
> an int (-1 for error and 0 for success). Then pass the address of residue
> reference to fluke_get_dma_residue() to be updated.
> Am I on the right track ?

Functions shouldn't return -1 on error, they should return proper error codes.

> 
> Also,I searched for the functions with names that match get_dma_residue
> in the kernel source code and found that they return unsigned int. I also
> noticed that no error checks have been made to check if get_dma_residue
> was successful.

$ git grep get_dma_residue | grep static | grep -v gpib

arch/alpha/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
arch/arm/mach-footbridge/dma-isa.c:static int isa_get_dma_residue(unsigned int chan, dma_t *dma)
arch/m68k/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
arch/mips/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
arch/mips/include/asm/mach-au1x00/au1000_dma.h:static inline int get_dma_residue(unsigned int dmanr)
arch/mips/include/asm/mach-generic/floppy.h:static inline int fd_get_dma_residue(void)
arch/mips/include/asm/mach-jazz/floppy.h:static inline int fd_get_dma_residue(void)
arch/parisc/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
arch/parisc/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
arch/powerpc/include/asm/dma.h:static __inline__ int get_dma_residue(unsigned int dmanr)
arch/powerpc/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)
arch/sh/drivers/dma/dma-pvr2.c:static int pvr2_get_dma_residue(struct dma_channel *chan)
arch/sh/drivers/dma/dma-sh.c:static int sh_dmac_get_dma_residue(struct dma_channel *chan)
arch/sparc/include/asm/floppy_64.h:static unsigned int sun_get_dma_residue(void)
arch/sparc/include/asm/floppy_64.h:static unsigned int sun_pci_get_dma_residue(void)
arch/sparc/include/asm/parport_64.h:static inline unsigned int get_dma_residue(unsigned int dmanr)
arch/x86/include/asm/dma.h:static inline int get_dma_residue(unsigned int dmanr)
arch/x86/include/asm/floppy.h:static int vdma_get_dma_residue(unsigned int dummy)

Only the Sparc functions return unsigned int.  The rest return int.

The return value is going to be between 0 and priv->dma_buffer_size (0x7ff).
It's set in fluke_allocate_private().

Just make the return value an int.

regards,
dan carpenter

