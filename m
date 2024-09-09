Return-Path: <linux-kernel+bounces-320826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089097111C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF40B22D14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064F1B1509;
	Mon,  9 Sep 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e59YycgU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E6176230
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868815; cv=none; b=m2XRh1L3dUEdnairdVyuYjqa8YPk0cz5/hPnKDrYp/fJmnVDHOgDpBKp8sXGfOb4M7XB4yr+/3pUQ/pIOkZr3l/SElyBteVA31CVlcllfXeYDuGUR35avZ4sIZSQtNNAeIS7WbFUrbRUzBJfvm4ol1xXnwBa1Bg8iWGM/6fpYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868815; c=relaxed/simple;
	bh=DCY7no0mv2jCQtkrDrEVtkKE4sUg4xh36za+NR/Bv2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGUQIIDti6I9U7syA6m5n6x5r9ruWhNymuogR2eCZAGt1EOFclgRWGGej39uuWTLBLSlXctLpnqy8GqI7NQ3fAHjibZsLBVqsJlCF3AJFeBd9rfuiY7hiqZWX0NxgKGRqjklaS5mkRFUJT1DOJBJTG4vyFvH51n5ui8g6dFhtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e59YycgU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so780477b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868813; x=1726473613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6hWMpBb44cMivpgFiSL2Yqa6TbfWk2CxNFS7WDJW1Q=;
        b=e59YycgUrflGCyDgikWmxHRo1B/7mOUlnT56PVYx5SQHo9khXXb1bRGwZs35bHTmGB
         a6cjv0uU0eLECzFL1wQUBZf2GgteERZzmeWEOvqBhawTKxGn7tbKrYEt1cl+Pjt229dW
         j+Ihfe8kVDp65zl3VqE/Nhzh8M9GEdD3Dlg5TTFi97nODutieuaJN3v9ObBpQfaHeonN
         q48wc67QamcmYycOlVLhr+5l8NGmCJnN04tybvck96Ng+R6POMcIx5MluIBzk17oxaNg
         o9nvuH45pZ2pKe5ZCSk75xEZIseI6mM/T6b25e8MQqt+aWxD3Ml5HCP7K8/gKxneTq9B
         HrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868813; x=1726473613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6hWMpBb44cMivpgFiSL2Yqa6TbfWk2CxNFS7WDJW1Q=;
        b=JNOT2hSYdxWSEGA2xrmtIK/fuVz0PNRYss692zA9HYLb/muKKaWQArLkS8f2poWd67
         jBf8OtwH21N1hjvTiYzK204CDy7YJi2axUFHgtpUBlXXgkbTG2fwEXFvBlFqxr8yjYts
         aKGIiynNGZQ4oatxLxODyTDrgAeLJiIIZQMTyUqoZMunhCi6oIZC7ceIRxNJ+4zJRwon
         bWf774y5rLArtPNgvdfIFgQuFixdI5mFlKNU29Ft+Two8VDo0cLU7ssYp1rn6MYzAoTS
         FuIdyWogkK7Dm6zrSJmLa8S7RV8AT2zINyuF2au26rlsT97InfovxNj85cRoHiBBsur/
         gKMw==
X-Forwarded-Encrypted: i=1; AJvYcCUzcbKdhCyMIpIi3QFMPXV8R2dcxvfgDbpS8140Jos4hgSQcOgCmvx442F1PNB3qXz4c5he9l1jZr0AB5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lRqYTXdLtxnzvV0rbFy67OsTbt7j7lKJf7SkiyGhh+x59hIb
	HC2578vN1ZeyI17tSixfBsXsvQP/TWsugtRECahEXkcwRHDgxbRohV/OLIRrBrd5aQfVnANFDKv
	5wmnED4Uz85207tEXVwTPxWoVtUq54CJO1qI=
X-Google-Smtp-Source: AGHT+IEzvol2Cx1dncYrA7xViTbl8c5+gva0/9Gk+m54uyYkqTTwTct8kdYp+1zW6Nb+LPWf9GHM9oEx66uWXchYKVE=
X-Received: by 2002:a05:6a00:1825:b0:714:2198:26a1 with SMTP id
 d2e1a72fcca58-718e349294bmr8282235b3a.27.1725868813456; Mon, 09 Sep 2024
 01:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
 <20240908101110.1028931-3-sayyad.abid16@gmail.com> <b335b3dc-61b4-4e39-8627-76bd4acc82c2@gmail.com>
In-Reply-To: <b335b3dc-61b4-4e39-8627-76bd4acc82c2@gmail.com>
From: Sayyad Abid <sayyad.abid16@gmail.com>
Date: Mon, 9 Sep 2024 13:29:38 +0530
Message-ID: <CACVUEBneRuc=n9aHFoBZW7QJ6NsYP5txN7Kx-mc8hay115fHzQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] staging: rtl8723bs: fix position of opening braces
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:03=E2=80=AFAM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/8/24 12:11, Sayyad Abid wrote:
> > This patch fixes the coding style issue of opening bracket "{" being on
> > the next line.
> >
> > Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> >
> > ---
> >   drivers/staging/rtl8723bs/include/rtw_security.h | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers=
/staging/rtl8723bs/include/rtw_security.h
> > index 487d69460cec..3ccbccf92417 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> > @@ -170,8 +170,7 @@ struct security_priv {
> >
> >   #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
> >   do {\
> > -     switch (psecuritypriv->dot11AuthAlgrthm)\
> > -     {\
> > +     switch (psecuritypriv->dot11AuthAlgrthm) {\
> >               case dot11AuthAlgrthm_Open:\
> >               case dot11AuthAlgrthm_Shared:\
> >               case dot11AuthAlgrthm_Auto:\
> > @@ -191,8 +190,7 @@ do {\
> >
> >   #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
> >   do {\
> > -     switch (encrypt)\
> > -     {\
> > +     switch (encrypt) {\
> >               case _WEP40_:\
> >               case _WEP104_:\
> >                       iv_len =3D 4;\
>
>
> Hi Sayyad,
>
> I cannot apply this patch. Please rebase.
>
Okay, will do this.
> Thanks for your support.
>
> Bye Philipp
Thank You!


--=20
Abid

