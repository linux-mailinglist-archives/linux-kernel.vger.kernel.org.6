Return-Path: <linux-kernel+bounces-366950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1DC99FC99
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934B31F25C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE691D63F4;
	Tue, 15 Oct 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="eYs8Yzhx"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D921E3D9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036215; cv=none; b=HxiwFananOX0ESI4xXKw4lNpfrW+/qlZwzGUsg7D8tlk5UIV1iISnh9QCccZSHPxW9Ks834rq4HgbN8tM6Hezmrp4i3CeMjOgAk6S2PoKkOzRe+ldaZxyY35eXLW9KHpUGkH1QEvPrk86pDg7kPtevEHeYZDFy9RtG8N/0Uc1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036215; c=relaxed/simple;
	bh=BPqG4gTsk+vhLnlZTlNewcMhDPZAaGvvlDX/+YqAcOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T89TU64Jw+gdW+qgsp7DdYzoLQcgsyVpF/ZuoKhQTytyqErMcKDy/cyDex+t93xZWth1/2Ltnn3Een4youmGQ5qyFTA3NmeN+kCGs/mTTtpjWGpDsoO1TfXNtiqusmmjwzkzJI4FR0Aoty2794Isd4bjccNMqZ+SmIkpgKig3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=eYs8Yzhx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso8962529a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729036212; x=1729641012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XCHEzfb7w2t6Cnrv1teCZ2LLAXX8T7VUwX708rvPrE=;
        b=eYs8YzhxBP4ELk5muVb1EdnQLclglnb8hseQg6ifSkHRKxF6LPH1SSiHz083WM+Z+z
         oq9uVsDJos+5672UJup1LnlZkNiPsSdvVds7EjxoynHVbgEj5DohiCbNmV4J44+0+B67
         KG9t+gsVcGs7JbGSciVgKcJmuACqrIcxuD+NIqzgZ114QhxFRLMSnc3RuZ7jZkAXS5+h
         R3RfNnpzyYBGao27Nm347xhDxO7EvbeT8kb6YNd/+oHx0KSPMfJYLrCYkJ+QabsxkE1f
         +Shw+9jU6V5MHF0OTX+qFCOIqKoITLiACJA28Qm6h3nOaP5rH5yBDbJR7pqj8ETNDfBc
         Zpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036212; x=1729641012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XCHEzfb7w2t6Cnrv1teCZ2LLAXX8T7VUwX708rvPrE=;
        b=pxLTu2DHKvOhYj+Y3P2pT10RFw3jSbigOxMI78ouUK1dtpoSijJhlWUa2hKK9dNlJ/
         hfvjddnllHK5yQQqRHbLqrDaaHAZJb2uPkGciCy/0glaDYL8ZsMcDOmoI8maYwLXITfC
         B50UW0COlvM0YmNWDYgfGE43AcEulf2XVttcevGWKEI6onhuYlqlMyN1O+iZbtnRtbiK
         31yO/NWUqLlBgf84HcfaKMEruzegjkhTOQVwPvwKryctyoeWoWZ9oJCwpwj9+QGE2DdT
         9AcKQgvAnNVKhrRt5Fo9iHTNIW4+Y4xK3751odrpg5AFhbT63AcLbrTNF2s9Lwxh5UpT
         veDg==
X-Forwarded-Encrypted: i=1; AJvYcCXFpaUw56A8v40p4Wx/obvNvPjMdSdwUwnM6+OXYq/42UXm7EsSq0/wD8TRv+cAHaAFiFDLCkPzlk0Mmss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCDr8K6UpmvQjE4d70E8anYMuvFpFxU9V40MFUIfhYaxtvx4Y
	nLkAzueYIBuwbKNXzZgZS4meX10i0VgvjOQicDa0Q4yGDWCuh/VjI+Q+Z2ZoHFK7WOJ1yUfjPF5
	v/FAOdkfnf2Uy+tP36iGsgxNoF+xzQ/anxaGKZg==
X-Google-Smtp-Source: AGHT+IFgb18AKuNMlykdo7Bc/k4uImWvwUeI8NNoAS7hD8o0sKiqPbQle5yPJkU/9n70pfkL/+L8Qy1G5YAS0ETCMdg=
X-Received: by 2002:a05:6402:2350:b0:5c9:76e0:2b8 with SMTP id
 4fb4d7f45d1cf-5c976e007c6mr6843891a12.3.1729036211831; Tue, 15 Oct 2024
 16:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015200655.17444-1-everestkc@everestkc.com.np> <59521671-db23-42ba-8db3-ed48cef53c05@linuxfoundation.org>
In-Reply-To: <59521671-db23-42ba-8db3-ed48cef53c05@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Tue, 15 Oct 2024 17:50:00 -0600
Message-ID: <CAEO-vhEPmPSSb_T2b17KDjuvXCTvr41_JRK0tCBSqustMHjuxw@mail.gmail.com>
Subject: Re: [PATCH] staging: gpib: Remove a dead condition in if statement
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:47=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/15/24 14:06, Everest K.C. wrote:
> > The variable `residue` is an unsigned int, also the function
> > `fluke_get_dma_residue` returns an unsigned int. The value of
> > an unsigned int can only be 0 at minimum.
> > The less-than-zero comparision can never be true.
> > Fix it by removing the dead condition in the if statement.
> >
> > This issue was reported by Coverity Scan.
> > Report:
> > CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> > unsigned_compare: This less-than-zero comparison of an unsigned value
> > is never true. residue < 0U.
> >
> > Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB dri=
ver")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >   drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
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
> Are you sure this is the right fix? length is size_t
> fluke_get_dma_residue() returns unsigned int - yes
> the coverity report is correct, but should fluke_get_dma_residue()
> return size_t?
I agree that it looks kind of inconsistent. The variable residue returned
by fluke_get_dma_residue() is defined in a u32 defined in struct dma_tx_sta=
te.
I will wait for the feedback from the maintainers on this.
> >               return -EFAULT;
> >       *bytes_read +=3D length - residue;
>
> bytes_read is also size_t
>
> >       dmaengine_terminate_all(e_priv->dma_channel);
>
> The patch should indicate it is against next. [PATCH next].
The patch was created from linux staging.
> thanks,
> -- Shuah
>
>
Thanks,
Everest K.C.

