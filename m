Return-Path: <linux-kernel+bounces-575309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD57A6FD75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738CF7A1385
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7026A0FF;
	Tue, 25 Mar 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="lC9oN86t"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCB26A1AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905297; cv=none; b=Tas+hc3IBQxOBsHlnfBZnTr6l6BshICbHZIWTjufl9vmiWG76b7/sksMSktfIMKJdV8lBIVazCvjYPqz7vsU/cVBFxWQs7nNrJ/+hK+AjiowNa7XKOHnHpWb4bxWyVBG/F+0Yf2WB/64aC5NOQQ0DKJAdH3bbHCUq0FiWBHmceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905297; c=relaxed/simple;
	bh=BPdYS6xHL5QzpV7y0DGUk3cFXr0NpmjnOS6Qdgtx83A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3F3mYD57TzfvM1sdV70q7I7ckKcsPJn9rZ1IkxgMY3JiUGdL4qvC6IvBhmj/HNnUzEjChU2N49X7eeJRPHS92zwt6D37aPj6FUe0q81K83HROlDYhTfBpQbyreWciTurHwufcetS9IGFoXJ7XMAGLxovRmwapDtFXN4/dfarj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=lC9oN86t; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30362ee1312so2431198a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1742905295; x=1743510095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oXGmD32nrFAaJW8Y4j0w8vdh1RENWFwbAfw9DIryH4=;
        b=lC9oN86tJpt5j+/KmQSaAj/ti/cl4LAb1QJBROxj0VgpKDM6OqEcZ7UVZC6BwkzeYZ
         BlYaxZ9o6tnUmAMTo2XiD2C2nNTArcXs6C590+27AGT6+P/zxCipXtx9mdpZMdXBEGPD
         5PTZDVSmibu4TTryHd5JHv0aVw8RLGWJhCY9buMNgVeNM2L1x2WWpink7oXuDJLQftWn
         5ASwEeNkmGAowg2Nf4JY+GUZ6TzyY53J/KhtA2YMPuH9i21M0yECx+HoffJSo5uhlBUX
         xVGb5KOssxJFCSFIw898aTdE+TeKLQrnDoUCbSfFfv7C50DdlF/br39bzgeEIdLAxmC7
         Zhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742905295; x=1743510095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oXGmD32nrFAaJW8Y4j0w8vdh1RENWFwbAfw9DIryH4=;
        b=UmasT0/3XrHmaqb7TOdRhpfXsGoLjLXIr7DOWYGN4aR9/mXEnyd2PIy6QwevmrzYI8
         ReC5g/3/9m7FoWvnVi8hesM1lMMj/L4bYyBJLDxRkU1cS3GG9iCEWe+wntTxnWF3T3yb
         AzKDD258dcKRuxcH7xYccMVYh0e2sBb8MZSF49plcn6va2SviKRt+p5ce3XOmYM9S/YT
         cFrG7cJ1yRdAUXGGXZxBF6LCUR+5Xax8WVPtYzh8/8gBGzM9ydvNWiPEEN4tYAoXsRnw
         0qlWy1S7zPfE8pchTv8pigJUWT+UvG69esIJJ5XUpxXwDWRf8arYnCIM4pfWj/AlKXKh
         bNgg==
X-Forwarded-Encrypted: i=1; AJvYcCXolvFBDRqBh6qZbnuUa9o4MLWgEAsZFcLE5p8THvpem0IhUxitbTlhXICfaSEjhRYS8YCkWT327qSWYUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlyvb1rL55qMaR8pPuk1GBexesJdkM/FQFkTLReIBciHJfSpd
	uU2EXn6sTylpW09lQsGDdJfPvR08TeoVwDOHtgNlPboYka0+VAiZopFK9PUtHR0a902r9aRiBAt
	VMFkHRVovr4uh9TE+Y4JHg5U9Mhz/oYAHmWlGWg==
X-Gm-Gg: ASbGncuhLV0qR8n/cCZ9zzfuyyXnWv7xqHTGRnG96a4Rui0fetSH/YnU0kyDScb46bQ
	RRSCwA3MfaEeL8/xZjPbbtMMO4A/D58kzMK54Hek9EDwG9QcP54RjsS+8HjhnFzUVGOGwLeLnDG
	9M67pZKpZAb216dGnVGmqhj3r/a01XKs1erbiw8WbQUjx0rGDZl6pAed9zoSDt
X-Google-Smtp-Source: AGHT+IExz0YT/jp4uxzAo0Fs/pmpz4p7SGOWeBSgdx3aKf6wwX30Ixn/7csWEW/wAweIA22n99zce7ONy1aYp+CyqHE=
X-Received: by 2002:a05:6a20:2d23:b0:1f5:6f5d:3366 with SMTP id
 adf61e73a8af0-1fe434371c4mr31719506637.37.1742905295200; Tue, 25 Mar 2025
 05:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321043504.9729-1-danny@orbstack.dev> <CANn89iLU6M3rvyzNuGtL2LsdYh97Nvy7TpXdGD30qq1yW1tQcA@mail.gmail.com>
In-Reply-To: <CANn89iLU6M3rvyzNuGtL2LsdYh97Nvy7TpXdGD30qq1yW1tQcA@mail.gmail.com>
From: Danny Lin <danny@orbstack.dev>
Date: Tue, 25 Mar 2025 05:21:24 -0700
X-Gm-Features: AQ5f1Jq3MHdMF6P_KWzoTKMwABmy019lYGhMwBdjWsyMs9-w-SbEFz0apr5rNyE
Message-ID: <CAEFvpLebA8OauBWmGswM9ypdmBfQRisw4ksXY0sEGEfZGTFHPg@mail.gmail.com>
Subject: Re: [PATCH v3] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
To: Eric Dumazet <edumazet@google.com>
Cc: Matteo Croce <teknoraver@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:39=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Mar 21, 2025 at 5:35=E2=80=AFAM Danny Lin <danny@orbstack.dev> wr=
ote:
> >
> > This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{defau=
lt,max} namespaced")
> > by adding support for writing the sysctls from within net namespaces,
> > rather than only reading the values that were set in init_net. These ar=
e
> > relatively commonly-used sysctls, so programs may try to set them witho=
ut
> > knowing that they're in a container. It can be surprising for such atte=
mpts
> > to fail with EACCES.
> >
> > Unlike other net sysctls that were converted to namespaced ones, many
> > systems have a sysctl.conf (or other configs) that globally write to
> > net.core.rmem_default on boot and expect the value to propagate to
> > containers, and programs running in containers may depend on the increa=
sed
> > buffer sizes in order to work properly. This means that namespacing the
> > sysctls and using the kernel default values in each new netns would bre=
ak
> > existing workloads.
> >
> > As a compromise, inherit the initial net.core.*mem_* values from the
> > current process' netns when creating a new netns. This is not standard
> > behavior for most netns sysctls, but it avoids breaking existing worklo=
ads.
> >
> > Signed-off-by: Danny Lin <danny@orbstack.dev>
>
> Patch looks good, but see below:
>
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index c7769ee0d9c5..aedc249bf0e2 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -676,21 +676,9 @@ static struct ctl_table netns_core_table[] =3D {
> >                 .extra2         =3D SYSCTL_ONE,
> >                 .proc_handler   =3D proc_dou8vec_minmax,
> >         },
> > -       {
> > -               .procname       =3D "tstamp_allow_data",
> > -               .data           =3D &init_net.core.sysctl_tstamp_allow_=
data,
> > -               .maxlen         =3D sizeof(u8),
> > -               .mode           =3D 0644,
> > -               .proc_handler   =3D proc_dou8vec_minmax,
> > -               .extra1         =3D SYSCTL_ZERO,
> > -               .extra2         =3D SYSCTL_ONE
> > -       },
> > -       /* sysctl_core_net_init() will set the values after this
> > -        * to readonly in network namespaces
> > -        */
>
> I think you have removed this sysctl :/

Fixed, sorry about that!

Best,
Danny
Founder @ OrbStack

