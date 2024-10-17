Return-Path: <linux-kernel+bounces-369089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AF9A18C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6761F22953
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFB524B0;
	Thu, 17 Oct 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="bzvSbpUV"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CD42AB1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133457; cv=none; b=h/kfNyeKPzZEwwuCyQhY2KnKnFW91WnAFYb5Mg/KOIhAJJBZPWNhhk6OcVuCeyONNKkaeqlEwHsgP/LjGxu5R2ILjGuRx1Qhm/XDY4sw+ARHph/xi2hx8XMNmN/KF3j0KPgrYZAZql8bSUD+uBE9qkfPlNcsR7r6YFH5mSZS40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133457; c=relaxed/simple;
	bh=Zdwf5BgnTpOZ84F4YflB1huMvcyKYRcc7W+IWgVAZ7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLGqqeopnUsQelDUDDV90lpnEbw0cqmTmMXsNhOJNjAHFfxhzEbc6+heFliXTnU5AGavg6M7MMzPh9jp8l9baX3kll6A03+bPMFKy9MwybYlFiIxRVxjMRwrh9lqYht5mO6SE1+EInf19ExGebXbe5XuZ5fBe/nzglbHX/Ar86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=bzvSbpUV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so581986a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729133452; x=1729738252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIbDMl8gjW1pXQSxx+4reNTL+NZ/14g/xdSwZlsXFVE=;
        b=bzvSbpUViBJjJvzmMO9cN75UNgRRQnbwUBtb2/7LLRXLUEOcYP5Fwx3wrUbO+keK5F
         OGuBwvoQMzKRDiUwPK1H7XHOF9LF3suj+aKaNeXQdfabAK/1fQIMf9sxHL0zLWMaNXJ9
         oLfeZrfoS1EPU5YdvHXV44u9ObLHKF4VJywk6oULPEYi3OnoB3AZY5xeaf2NEQqM8B4y
         /JrsBrBGBDrnWO/gv7lgBcZLS/1jIGVqkMDuBo0GkM7VphH1aFnyg9eA7IvMisFINZy9
         JCxqa72beOlXw3XwGhCUY2pxTsUYk/EAReJ6mMMOXCjVMqmAoAwU+HxBHpbkKR9Qp9co
         xzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133452; x=1729738252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIbDMl8gjW1pXQSxx+4reNTL+NZ/14g/xdSwZlsXFVE=;
        b=AZ8ZZh+JB80LJh/cAnGYhjmVbTPO1a+j+LEgr2JJQ6ygmOZ9+ar5UryXT7E95zoDRs
         SNzabAwhTNtdQwR/+iCJfiOMxHRLFjnc75cyY+i1TY8A7zvJ/8iG+IbE8S26lFEZs0eD
         DOWBFrrpdyqryk3inDrBmB17B3fE8v0CbcoKYQWoUBbb/H0A3GFr7pNPjErWwPJjf17v
         LI8FaQ4Ymd3QKfhbTqnySD/l7BSk2pqNqPDxHYummdZPB6SUvokjh7LtgDnZPAIEDqkp
         Mncc1ZGbh65J7dP4hLdodad7r7GA76hN2ccf4qNGx2F3W5K2VApmanIV3M+/E1F1UKrb
         LQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZhx8ClEf30d5XNDGkUkrCLJE2hLgV+HoNcU6D8jDDwGC07Vrnxs4Fa8luJk8oiW6ZdqeqeqzCOw2Lqeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7V07Sc8DQ3486+H5yc9ajfG6qyM0jTqBifl96i48U/V90Jbk
	fkqI2Hd0hBLyvsbSjjLC5dxWyC/80LcPWm/WY+wNw0626GU4RZqhJ1nDxee4YfJk67MIKYvCd3V
	p/Ck5DhctpvX0zJR24l+50xajhmoo6Q3R1olo9Q==
X-Google-Smtp-Source: AGHT+IGZEg0rLJYeX//oZKYgP/RbQfMH2yo0BvVbMr1srtnJ+sdvJuPzjemXqjvKuUeHeLhINhFyM+fo0g3gBQ4Hc2M=
X-Received: by 2002:a05:6402:13c3:b0:5c9:218d:7071 with SMTP id
 4fb4d7f45d1cf-5c95ac1776cmr13943290a12.20.1729133451937; Wed, 16 Oct 2024
 19:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
 <2024101654-jasmine-ransack-7190@gregkh> <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
 <2024101625-activate-gluten-3547@gregkh>
In-Reply-To: <2024101625-activate-gluten-3547@gregkh>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 16 Oct 2024 20:50:40 -0600
Message-ID: <CAEO-vhGM8_x4Teqt7D8d=3KJcLPAgd2rWpkEDsZw=h0cS_7BLQ@mail.gmail.com>
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Oct 16, 2024 at 06:54:00AM -0600, Everest K.C. wrote:
> > On Wed, Oct 16, 2024 at 2:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 01:53:18AM -0600, Everest K.C. wrote:
> > > > The variable `residue` is an unsigned int, also the function
> > > > `fluke_get_dma_residue` returns an unsigned int. The value of
> > > > an unsigned int can only be 0 at minimum.
> > > > The less-than-zero comparison can never be true.
> > > > Fix it by removing the dead condition in the if statement.
> > > >
> > > > This issue was reported by Coverity Scan.
> > > > Report:
> > > > CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> > > > unsigned_compare: This less-than-zero comparison of an unsigned val=
ue
> > > > is never true. residue < 0U.
> > > >
> > > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > > > ---
> > > > V1 -> V2: - Fixed typo of comparison in changelog
> > > >           - Removed Fixes tag
> > > >
> > > >  drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/s=
taging/gpib/eastwood/fluke_gpib.c
> > > > index f9f149db222d..51b4f9891a34 100644
> > > > --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, =
uint8_t *buffer,
> > > >        */
> > > >       usleep_range(10, 15);
> > > >       residue =3D fluke_get_dma_residue(e_priv->dma_channel, dma_co=
okie);
> > > > -     if (WARN_ON_ONCE(residue > length || residue < 0))
> > > > +     if (WARN_ON_ONCE(residue > length))
> > >
> > > No, this is incorrect, now we never notice is the call to
> > > fluke_get_dma_residue() has failed.  Please fix that bug instead (hin=
t,
> > > Covertity is giving you a pointer to where something might be wrong, =
but
> > > this change is NOT how to fix it.)
> > I need a little guidance here.
> > My best guess to fix the bug would be to make fluke_get_dma_residue()
> > return an int instead of unsigned int or size_t. But theoretically the
> > maximum value of residue can be UINT_MAX, and casting it to int will
> > result in a negative number, which in turn will cause  the error check
> > condition to evaluate to true.
>
> Look at the code to see what it does.
>
> > The best solution I see would be to make fluke_get_dma_residue() return
> > an int (-1 for error and 0 for success). Then pass the address of resid=
ue
> > reference to fluke_get_dma_residue() to be updated.
> > Am I on the right track ?
>
> Close, yes.  "-1" is not a valid error, so that needs to be fixed at the
> least here, as it's obviously not returning an error that gets caught
> today :)
Noted. Thank you very much.
I have a question though. Since, the file I had previously fixed (which
was incorrect) and the file I now need to fix are different. Should I creat=
e
a new patch that would be of version 1, or should I send a V2 ?
I went through the "Submitting patches" documentation but it does not
clearly explain whether I need to send a new patch or the revision ?
> good luck!
>
> greg k-h
Thanks,
Everest K.C.

