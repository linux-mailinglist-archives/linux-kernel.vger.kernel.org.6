Return-Path: <linux-kernel+bounces-320825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9697111A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843E1B23312
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4CA1B250D;
	Mon,  9 Sep 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFEbHb2T"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB54171E5A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868774; cv=none; b=Cd/EZcygfGxUEWjBYwwkCynoSQHKsBp+XZCyzZm+PMHv1uigZo7hETJ/B14WHUzAh0zneezDrnZd323uSBbe9k5o+pkVXA+DEOqS1XrOYicIpgU4MuTgyl7gucAoBKVZ+EKMQ3e6BWTYnrbABqLTpKz+osgkqKilI7WeRGl2Djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868774; c=relaxed/simple;
	bh=4wsk85TBpy5BbtUqTzPL/QeUfy4tD/VA5ngs7D4xXkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNeQEQY57OrO/gok+I4xIxNmOvE2juddyqc5uCFz0o2lhm89gqTDjJgN0bVwMf2szI2mrYcrJvWgt45F4ydho8You2aK9sS7RWBkjl8oI81ehAW0YsVur92mczPsYP8FtHDqc6Sb3DDaAkmN9WCMOHo8UWTnsG/4lNetOcMRMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFEbHb2T; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e03f0564c6so765622b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868771; x=1726473571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMzKeyE28KgaABYxV90qLu2+vknssj4YYRJcYPydeZU=;
        b=ZFEbHb2T3BErvVa4Os4JlTn/qtCqrcZ9FKz2J7JVIthBaSa645F7iJZ4HyoK29mVEq
         PeSCNaA6SN+w/RCaTw4/iYjVkhAly7fshqJqRw7hpn5CagoyDAwQGRc3cQ861IAF3Z/f
         czkdWjQwUR1D01dh4Ft6kPU8Vmu09gl63p2h1B24/Ojodg5UUXB9n0NpjbD+4MmpBk6T
         y2wFnidT7Es0QX7KxD76RCl7Fmafd1Tj0kMnp2xkcLZJzoDJhrtDqxL42HzuCfdCtpyw
         1P1TZoEF2oot6R3h+GIsGIYx6/Ih8ZSkJeCk9NwA07SQjdhiHaZ5Q4RjW1ynslCzEfNw
         KwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868771; x=1726473571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMzKeyE28KgaABYxV90qLu2+vknssj4YYRJcYPydeZU=;
        b=M3tXmeJRNdTRQJZltZfZPenQbZH0xGDOOIbaqCUb7fBJl1UgE5lXGnMqQz3L30sUDW
         NKVuyl+7B2WttwnK53hj3tYNSBNp2rdpAfbZL/XILJojBuGKYt5YY6OHjSQyAYHhNny2
         ebHGfvVTgaKrfmhASLDt8ZmzJKKaq6Jb2GXVuGA4Rc4L+5hh1ilnbQ8EgU2e/wvX/t58
         +Vzl5nuqom1LpiGMC5ngdpB6Gmg2O3yN1VvRiFe38smfMEfANfHDpK2i71DjrrX2Ty08
         UmLEst5XKBhPUgLJtp8dDuKxiypN303qgv+otTvJaenT7HZGvRgSdrvGGIfxvZ2TGyQe
         lnLg==
X-Forwarded-Encrypted: i=1; AJvYcCV9q+Ba4/AHntbrQuV7c0+k1mfmQp6VQVz7XwAWjBwIBPsU4q/C6CbXKWsqkHhl9a4imU3HD1KEgeXfAXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBlhjw+oTuAzl38BWEQjIsOqL2dMvlXDO3t7FKgbqNYMwkSe6
	OFlHWpbp+RGxDc8Dbjy36aKb3WR21WewTKvv9YnXIYJNqt8x+52gRj8AzFtyjXgfsS9OQiBN1yA
	OX/eVGtA9c8TRSybY8rL4td+YTYo=
X-Google-Smtp-Source: AGHT+IHsaq8RNSsCYrWFo71sF14XOuhx/NDs7XQwGzWq5ZwbYLuDAvZetCA/zvlME2UZ2SDrIqdIW+IlgwJLXt8EmTY=
X-Received: by 2002:a05:6358:3426:b0:1b5:fde1:d00c with SMTP id
 e5c5f4694b2df-1b8386fd0d8mr1217821055d.25.1725868771331; Mon, 09 Sep 2024
 00:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
 <20240908101110.1028931-5-sayyad.abid16@gmail.com> <4bc6cfea-ecf4-40ad-a3f6-c32bb411949a@gmail.com>
In-Reply-To: <4bc6cfea-ecf4-40ad-a3f6-c32bb411949a@gmail.com>
From: Sayyad Abid <sayyad.abid16@gmail.com>
Date: Mon, 9 Sep 2024 13:28:56 +0530
Message-ID: <CACVUEBnsHZT_Csmqak3ecg=jBMhAUDvODTF8YiCi6C_8seGJRA@mail.gmail.com>
Subject: Re: [PATCH 4/6] staging: rtl8723bs: fix comment with a trailing */ on
 a separate line
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:56=E2=80=AFAM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/8/24 12:11, Sayyad Abid wrote:
> > This patch fixes the trailing "*/" on a comment block.
>
> Hi Sayyad,
>
> important is to describe why this patch makes the code better. You
> described in the description just what you did. But that can be seen in
> the changed lines blow.
>
Note, I'll add a descriptive summary of the "why" for the patches.
> Thanks
>
> Bye Philipp
>
> >
> > Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> >
> > ---
> >   drivers/staging/rtl8723bs/include/rtw_security.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers=
/staging/rtl8723bs/include/rtw_security.h
> > index 4efa2d258ebf..1e5e7f52f8da 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> > @@ -240,7 +240,8 @@ struct mic_data {
> >   /* =3D=3D=3D=3D=3D start - public domain SHA256 implementation =3D=3D=
=3D=3D=3D */
> >
> >   /* This is based on SHA256 implementation in LibTomCrypt that was rel=
eased into
> > - * public domain by Tom St Denis. */
> > + * public domain by Tom St Denis.
> > + */
> >
> >   int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac);
> >   void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);
>
Thank you!

--=20
Abid

