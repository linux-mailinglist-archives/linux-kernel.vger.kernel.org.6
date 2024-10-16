Return-Path: <linux-kernel+bounces-368063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF17E9A0ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B021C21E69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F221209679;
	Wed, 16 Oct 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="L5WmpncI"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C209F5A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083257; cv=none; b=chx2EJGerpBvPA/ZjihGKXCPgtVozWd7/J5nbI1XmbXcgeMA35dzkj84o5weqpc/ARspw0LaoQkgfNmEdnvXejzK5UwxKJLYS7sZDZFVvSfP7rgZ7y6zmPTgCWYu8FDoziZx91Q2739YZQlaGrp8+XKJw5o/8zHfByAcbFKaBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083257; c=relaxed/simple;
	bh=fcRTIfNZx/JTFIjknzqhd10DJMrU/ZuxcvSaaXGx9ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0lWAXD6hPhZgGPdTo1G6aqRxMvfmyoYdaOqJ7Iu9GRWTrinBozOnVZwX90ZzxY+sf5K1+UbJnqebB7m9h3uA9x7UGmK4YGKQapwM8ZWZqqzQmfbVNtjVO6id0LLhUHMmHrdxDa5qnjwT9immLr00PkZoe5j/k97uHhotviW0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=L5WmpncI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso1578811a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729083253; x=1729688053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56Jzig5ogJflOPUw3lWuUlJeigmnzp1xLLN+rEXcG9g=;
        b=L5WmpncIV6FgzP/3q9JI+iPsLUcZxtVXNAmT2S/49wlULmT/Uso5lIFzBdw9I0UoWi
         HwI5MRVZ9XtmKgKyW4nk2vw/O7GanIK9nNS1zHcDZBGV/3YR5cFY62na+rdRUo17/scv
         Wj6z+qpa0VM65qj1ISw7dCRnXDm3hhs0GLSzJBFzRfMavCgUnbQO2fydyiwKWJplI2l2
         OZ7p0gBg5l+yfLaVVrb9x/jRI75EtS9OhhYpF1gUt+WGTHZPowYoe3xpCc9Qv6DmyUCm
         mKBm+JwO1zzX+uyylTs6JiICYXPFxx46eAC3WMw54OIcVpyCiywR4yz0kw8aZd6F1XQk
         AI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729083253; x=1729688053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56Jzig5ogJflOPUw3lWuUlJeigmnzp1xLLN+rEXcG9g=;
        b=BnFszjWfSVIaPBEm6w3hpwCIe0i+04lIKfyb+cW9U+oY/R10Ii9Oh2fyb8f9llNPg1
         lDmAaI99sVqt/W2jQdEoi5Lo9iVdZuF6vjvN3gJGmyUlIQ0LrbjajgNLgv9xyZqCB6vL
         tHTlqMIYM/hVz/175WgP2oljm7IwFbr7oPJPZ1hT2YvROk1e5e7UVzJvc35rARy/KrtQ
         pdLpiC8URBgolcRYg/H9VKPG68O6UAJeCoS17M1JeYNRvQh3PrPo4/2z/CNXUVEOZQwc
         07QRsiV1yN2NlkI9kEP30o3iw9jgbbql/5s42oQuBPbdSZKI5UxQA1bxAIsErUmVKDnW
         IkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7F34LAqN/BB5VruJ9m0T73IH3+ePkuZsHpBSXiQwG268qafk8s0yJBaTc0yrBDimKiMQ9JP8TvLRwx+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdwDOC9kMpVATZY7QnyfCf2C5M6yx6KvRrlnw3G/9+pZTmPlP
	eFhZqwE+jMoJrNndmbO3s7jaQLeTlV6EtT7cI/OXYmtzt0GMmzBif2B6fGCus8La17X1Fwt57c2
	wRrjV2CIxWRyAZvLCp99FLABaIXoCUBrr3bmxmQ==
X-Google-Smtp-Source: AGHT+IFVkh3RJDsr7T3iGN0FxyNqlY+ZdO0pgZdL+clmv27JbwkFocdoahprSMAP9YpeEkHe+AcZIQXG98m5aSCIXJo=
X-Received: by 2002:a05:6402:50c9:b0:5c5:cda5:9328 with SMTP id
 4fb4d7f45d1cf-5c9947e3fc7mr5014646a12.4.1729083252971; Wed, 16 Oct 2024
 05:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016075319.4092-1-everestkc@everestkc.com.np> <2024101654-jasmine-ransack-7190@gregkh>
In-Reply-To: <2024101654-jasmine-ransack-7190@gregkh>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 16 Oct 2024 06:54:00 -0600
Message-ID: <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Oct 16, 2024 at 01:53:18AM -0600, Everest K.C. wrote:
> > The variable `residue` is an unsigned int, also the function
> > `fluke_get_dma_residue` returns an unsigned int. The value of
> > an unsigned int can only be 0 at minimum.
> > The less-than-zero comparison can never be true.
> > Fix it by removing the dead condition in the if statement.
> >
> > This issue was reported by Coverity Scan.
> > Report:
> > CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> > unsigned_compare: This less-than-zero comparison of an unsigned value
> > is never true. residue < 0U.
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> > V1 -> V2: - Fixed typo of comparison in changelog
> >           - Removed Fixes tag
> >
> >  drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/stagi=
ng/gpib/eastwood/fluke_gpib.c
> > index f9f149db222d..51b4f9891a34 100644
> > --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> > +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint=
8_t *buffer,
> >        */
> >       usleep_range(10, 15);
> >       residue =3D fluke_get_dma_residue(e_priv->dma_channel, dma_cookie=
);
> > -     if (WARN_ON_ONCE(residue > length || residue < 0))
> > +     if (WARN_ON_ONCE(residue > length))
>
> No, this is incorrect, now we never notice is the call to
> fluke_get_dma_residue() has failed.  Please fix that bug instead (hint,
> Covertity is giving you a pointer to where something might be wrong, but
> this change is NOT how to fix it.)
I need a little guidance here.
My best guess to fix the bug would be to make fluke_get_dma_residue()
return an int instead of unsigned int or size_t. But theoretically the
maximum value of residue can be UINT_MAX, and casting it to int will
result in a negative number, which in turn will cause  the error check
condition to evaluate to true.
The best solution I see would be to make fluke_get_dma_residue() return
an int (-1 for error and 0 for success). Then pass the address of residue
reference to fluke_get_dma_residue() to be updated.
Am I on the right track ?

Also,I searched for the functions with names that match get_dma_residue
in the kernel source code and found that they return unsigned int. I also
noticed that no error checks have been made to check if get_dma_residue
was successful.
> thanks,
>
> greg k-h
Thanks,
Everest K.C.

