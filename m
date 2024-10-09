Return-Path: <linux-kernel+bounces-357588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0C99730A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2300A2827FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19BA1DFDAB;
	Wed,  9 Oct 2024 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="ezAqI8oR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CE1D356C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495003; cv=none; b=TE4iLJ99rO8TQzHGqDrDZs78kY6fJCpI/222JPgNIpSowVzJ2VaaYPQbcDT12hlJhH2qIoFYhJ+wRDC0w5mLqpEwfqaLt3PB1GqRVHOs21tmwQB8SsQoeSzBOzIHSLItwwqvk6PxqnxZsdZxuicU1VGB9OOYU9+SnrdLDWG4h2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495003; c=relaxed/simple;
	bh=PJVwcXcibgiYriey2g8Mw/pptgW5zUsdumgQFIEbIoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+3GzBiTPwfTF51X7AVBrFXcv1S9pwilw1SjVZ0AdDFHMejTC54FfKAiaL2tfcQLbhOxeldm9rzbR/SDwY5I2cKTywvyS7/kztsLNDAZL8QxoSbkxrTQtW68s7HSsAlByq08ESfQSCC0brCqTNCZ9H/5YkGpLsmEgUFdUQl6Jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=ezAqI8oR reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99422929c5so8574366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728494995; x=1729099795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cp2ioR05MBhm6TSp5/Wwm/z/I4MQsDlfJob4dXYszs=;
        b=ezAqI8oRdb10issRjccSZ8y+P+stree8FmeTwUlRgCIbEo4PPbtGkj4mpN9YuObm0a
         mhP7nLpga4ITmxmVy6tA+Im+P/c58UOosLMID5KTvPkrrolt66q/sGDCBbksAF8ATxtV
         aZiCaLrCqaR/enADTYQeEOwh5IngUO7EyqQO73twwxrlLMzC6cw7MfRzsRurN0kJEO3Q
         tvsHkAOsXoFBB7HakAmIUP9kMHa9s5NENSXlIkvIRaa6S9e3q9hI9XHxiQhknRDVELXz
         xZDog59tpk9aR8JBMntHVr8llKvEDT/iNEu/3wNyTmngMEB+KEKZLEqjJNfcfCCY/jsT
         /aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494995; x=1729099795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cp2ioR05MBhm6TSp5/Wwm/z/I4MQsDlfJob4dXYszs=;
        b=tWeu1R8ICu+yGFxppvKWWl+kiT1tRw3faqSoekgbHUt5p+GNqwD/2aKRuKVuDIl7dC
         Mp69sCnPNkdZf5u/SezxzMp4Z9+m2KpjfuXw+v9HdNk6acAYlWQImgWloQDB8wxGxNZf
         i+vcmCaMil8yoA79SS2RzTIYRHg7W67op+i8lkFD8p6/osHoYY5ucMpHiMa2iG5r05Ke
         AMBAVzZRwm4bDtRQ/3j0supESQoc42bdL1aSvFu8T6Hyi0Cw5CAY1vt+mte9jkw9Rb9H
         xNOR+my2HunUc1eyRhrQnq9ySvFLJNyLzHsFok870mOll/zBJ3M9zPYdzCP8TZSfOBNt
         gZIg==
X-Forwarded-Encrypted: i=1; AJvYcCVPyUXxFlwlimgq9puxszgCOhX6OyMXRneNXIgcHqoREAzjoLAwmS74uHWKyANPadzeH9RS86hnsCoa/UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAepmqaWE4p0NQx9N9i6EH2VWWPUx69EZAzhxAlB3BCk6I9Rdq
	0PDls/r1mMvFG19IhBMVOiSy5ZM5lvk5EFjDbkvjJ1Ix/c5xC85sRPimAqRDvi7CYfRpuBya847
	si2hSR3t+p/utPPtgITdEbiW3SSw0OekJB+qMnw==
X-Google-Smtp-Source: AGHT+IFlkcPGSSt+FkF/AeZ9ren+91PRcuHIGXxky2tQ3SxKjSYHH1M3nNkivi+T62HmOUXRleWu7WPHCEDV1ks1k1M=
X-Received: by 2002:a17:907:9706:b0:a99:51dd:9792 with SMTP id
 a640c23a62f3a-a998d20b4d3mr292257666b.30.1728494995415; Wed, 09 Oct 2024
 10:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008071559.18523-1-everestkc@everestkc.com.np> <ZwanGrWs3PI4X7OZ@p14s>
In-Reply-To: <ZwanGrWs3PI4X7OZ@p14s>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 9 Oct 2024 11:29:43 -0600
Message-ID: <CAEO-vhFFHXeHH961e8KMYrwyUHtGCZmPOP9VC7QrhpabH2wP5A@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Fix spelling error in remoteproc.rst
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:54=E2=80=AFAM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good morning,
>
> This is a case of old english vs. new english.  Using "implementors" is s=
till
> correct.  Moreover, there are 33 instances of the word "implementor" in t=
he
> kernel tree.  Unless there is an effor to change all occurences I will no=
t move
> forward with this patch.
I can work on changing all 33 instances of the word "implementor".
Should I create a patchset for it ?
> Thanks,
> Mathieu
>
> On Tue, Oct 08, 2024 at 01:15:57AM -0600, Everest K.C. wrote:
> > Following spelling error reported by codespell
> > was fixed:
> >       implementors =3D=3D> implementers
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >  Documentation/staging/remoteproc.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/staging/remoteproc.rst b/Documentation/stagi=
ng/remoteproc.rst
> > index 348ee7e508ac..5c226fa076d6 100644
> > --- a/Documentation/staging/remoteproc.rst
> > +++ b/Documentation/staging/remoteproc.rst
> > @@ -104,7 +104,7 @@ Typical usage
> >       rproc_shutdown(my_rproc);
> >    }
> >
> > -API for implementors
> > +API for implementers
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  ::
> > --
> > 2.43.0
> >
Thanks,
Everest K.C.

