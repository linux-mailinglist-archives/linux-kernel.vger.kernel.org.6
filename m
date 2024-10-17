Return-Path: <linux-kernel+bounces-369173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B208D9A19CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE2A1C20F55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBACB14A0B8;
	Thu, 17 Oct 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="JZJyrqv/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582D137C35
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140140; cv=none; b=OFBPncsGra5Z6X+0bSUecvqd61hxtVx7Vqw+JqEW1NBn8tbxp9+pD0Z99GQ6O072Y7b4OdAMvZSDmvztaWDX4DBRmd1iTucHbghmX/pK5L3aXpen0hPLkzRMEUrxmJDw6fPSwqHHI3E6/s1NnDIKJSEihUKbY14ymkOebeHLmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140140; c=relaxed/simple;
	bh=wu9Pw76v2JHuN4yRz49dAZg/Y7qju9tF4wYEc47Wsjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaXEommbLUcFyeysSO2VD1sqxDN42UsF5MSXFBhuWVH3VfDF79BCncZAAh9gyOI2IHg7y32XogrAJ9O6TGydoXsF5DqRHtIJZxaj/4URTF03PqfYSYv9RsPNT91FuRV4Qd6lVxxSSVD9uAeh/9ciy5gm06XfMABgzm9K1Kmr3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=JZJyrqv/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so646212a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729140135; x=1729744935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV2banS2XGnv6eLgH4AlJYfnoHvz5mT7AoXEkIrqrMQ=;
        b=JZJyrqv/w1F6VSwq9d2TgrgGNXEuj+kJfGQCkbNC2zigMLGTpJbUsCjtRR/Ag26vNW
         Q1ZIX11jpOU9DinGvspVMoN5U1kOioOFj2lly9cSD67EtDAVz5MjjicgmInDIqTrY1hU
         zfYU5SxlAd8ntAduYLCi9qJe4kgXV3dvuNS+tyF1dkL36wj30ITz6M/mgwmg4cI4qPdz
         LWuy9TBv8eK0SwxZrpRy61KWgjtCSNukQbp+ZwFfeFIjNg7hK0TfTz1WdgRRnz1K7VDn
         miM3JN8jf7GsOlJKV8Q292WCwNVfyQkrvuHL3pQzIDGsBGNEileVZI2vWQJ34MvkIN8L
         m59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729140135; x=1729744935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV2banS2XGnv6eLgH4AlJYfnoHvz5mT7AoXEkIrqrMQ=;
        b=B2YiS8kOUR9afh0LOYA8MOpekbZgDXPdBm9OfX87k6OPB+CuepbVkcmFdtec47cxBv
         wcj/EblOi+Oq10ca96uZPBWy1bupiqGAgcW/sBGlhPXSS8pmLoCeeJfYKjeyXVDTD0s9
         YRS/i8JHexFHZTHZwCjpiS8+nABT8w+WcNrmM4HDkX277v5iWLxAsyt8PWJ41K6Q/fkD
         RunEJEg+SrFsxTXg23/apM7xSMeWQCs8IbYkgZA6/fIhG1IuKkNu3rPSvgyZS7nlulqg
         YLD5qjPWTQQEPf9OpeEwARUJazm269hh0NO2axKXAlWa38Btyp3oadYVhnMQo/nomKbR
         QDbw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ubFArSSUTECvobNBsgWQe2SJYdvqsXaGxOR8Vmmkb3zQA1cKRwM50B8NsdzwO0SyhFFTgWCWFufmEDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3csESx1EvKz0yc7Fx5WRBNJyX0GUVlIgwi+meerGvHkcbj3s7
	aSdOTr0c9gcNKq5m8bjj1MEjBkdo2QPFrqTo9WaOc76I9Ffl0e3KZmy625YQmZ+fsEUwd4wjNmH
	pd3FuvipstPtSq4CJtHBG82RRrZ1veJ7t+Ukf1g==
X-Google-Smtp-Source: AGHT+IE+Cp+zJwaX0xJLM8AA+O4Cv2X1SYjhOULR0Fy4udXaDFUMqgLong5zl5e+DDnmK0/VYplXU70HKApp4X/8pVc=
X-Received: by 2002:a05:6402:440e:b0:5c9:a5a9:1175 with SMTP id
 4fb4d7f45d1cf-5c9a5a9135fmr1328152a12.17.1729140134883; Wed, 16 Oct 2024
 21:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
 <2024101654-jasmine-ransack-7190@gregkh> <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
 <2024101625-activate-gluten-3547@gregkh> <CAEO-vhGM8_x4Teqt7D8d=3KJcLPAgd2rWpkEDsZw=h0cS_7BLQ@mail.gmail.com>
In-Reply-To: <CAEO-vhGM8_x4Teqt7D8d=3KJcLPAgd2rWpkEDsZw=h0cS_7BLQ@mail.gmail.com>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 16 Oct 2024 22:42:03 -0600
Message-ID: <CAEO-vhFtFu806Ls8p3vZhVP9yE-B23Lkht65ghHHojCcumBWSg@mail.gmail.com>
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:50=E2=80=AFPM Everest K.C. <everestkc@everestkc.c=
om.np> wrote:
>
> On Wed, Oct 16, 2024 at 9:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Wed, Oct 16, 2024 at 06:54:00AM -0600, Everest K.C. wrote:
> > > On Wed, Oct 16, 2024 at 2:04=E2=80=AFAM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Wed, Oct 16, 2024 at 01:53:18AM -0600, Everest K.C. wrote:
> > > > > The variable `residue` is an unsigned int, also the function
> > > > > `fluke_get_dma_residue` returns an unsigned int. The value of
> > > > > an unsigned int can only be 0 at minimum.
> > > > > The less-than-zero comparison can never be true.
> > > > > Fix it by removing the dead condition in the if statement.
> > > > >
> > > > > This issue was reported by Coverity Scan.
> > > > > Report:
> > > > > CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> > > > > unsigned_compare: This less-than-zero comparison of an unsigned v=
alue
> > > > > is never true. residue < 0U.
> > > > >
> > > > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > > > > ---
> > > > > V1 -> V2: - Fixed typo of comparison in changelog
> > > > >           - Removed Fixes tag
> > > > >
> > > > >  drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers=
/staging/gpib/eastwood/fluke_gpib.c
> > > > > index f9f149db222d..51b4f9891a34 100644
> > > > > --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > > +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > > @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board=
, uint8_t *buffer,
> > > > >        */
> > > > >       usleep_range(10, 15);
> > > > >       residue =3D fluke_get_dma_residue(e_priv->dma_channel, dma_=
cookie);
> > > > > -     if (WARN_ON_ONCE(residue > length || residue < 0))
> > > > > +     if (WARN_ON_ONCE(residue > length))
> > > >
> > > > No, this is incorrect, now we never notice is the call to
> > > > fluke_get_dma_residue() has failed.  Please fix that bug instead (h=
int,
> > > > Covertity is giving you a pointer to where something might be wrong=
, but
> > > > this change is NOT how to fix it.)
> > > I need a little guidance here.
> > > My best guess to fix the bug would be to make fluke_get_dma_residue()
> > > return an int instead of unsigned int or size_t. But theoretically th=
e
> > > maximum value of residue can be UINT_MAX, and casting it to int will
> > > result in a negative number, which in turn will cause  the error chec=
k
> > > condition to evaluate to true.
> >
> > Look at the code to see what it does.
> >
> > > The best solution I see would be to make fluke_get_dma_residue() retu=
rn
> > > an int (-1 for error and 0 for success). Then pass the address of res=
idue
> > > reference to fluke_get_dma_residue() to be updated.
> > > Am I on the right track ?
> >
> > Close, yes.  "-1" is not a valid error, so that needs to be fixed at th=
e
> > least here, as it's obviously not returning an error that gets caught
> > today :)
> Noted. Thank you very much.
> I have a question though. Since, the file I had previously fixed (which
> was incorrect) and the file I now need to fix are different. Should I cre=
ate
> a new patch that would be of version 1, or should I send a V2 ?
Oops, it's in the same file but my question still stands, should I send a n=
ew
patch or V2 revision ?
> I went through the "Submitting patches" documentation but it does not
> clearly explain whether I need to send a new patch or the revision ?
> > good luck!
> >
> > greg k-h
> Thanks,
> Everest K.C.

