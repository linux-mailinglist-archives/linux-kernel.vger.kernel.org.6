Return-Path: <linux-kernel+bounces-576701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF38DA7133C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C043D170731
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241F1A5B8A;
	Wed, 26 Mar 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8w9e8ce"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB701547C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742979631; cv=none; b=qtECJtyb2JkwyIxAAWW9iVVWW9xRak8JMMOftHKqfznEA6hgPW2I49EUNVN1WfoKQvzKwHDapcgo2BE61t1UAQIhtO0qKNu+VURbbIC5rxDz/MvFgSDpeojuFpfA/DVbwUXrf2xnJzFrxM7/ak81qyOcZrDnuG29A97q400CgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742979631; c=relaxed/simple;
	bh=iu8rB5v/TCRB4v8pzcOZy2H1O8+0/VMHCUWpamqLeQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtBDJ0hVtBbd/K1XOYAvlwlNMRk3u1NLV6hNVyeBykRHCC2+xizyTVNnSxqERjxrQubFJ9Awd+YjNHX1Da1WTmp9dSCN4hndRVPsMiGgo1dEbxp/gqKY3nRxxe2DyMJDHt/qv2m/p6cvHheQXQWvzs7BPrQHiGQWTGyvQi4babg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8w9e8ce; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523f19d39d3so3196961e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742979628; x=1743584428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb8OnTjsyP5lh3M6/BjJHvWMp8bxQHXc7AdtZ7j6NMg=;
        b=e8w9e8cesfctCtR2OHbR4hDoNQYFjDP1h5ix2W40iIIiL4KiTtaewbZj+oJ+usznZs
         2fxkwa2XdOQuH2p9RKhn2i3/iL+wPcqpkOR3sdl6TTnaQPvDJD+Kcu08DceL1aUAbRqk
         4C0PLN+2czgRLFJZFpiABRzgVoWxbKoynSNc+K54b3fWHZTnDz0xuSVLEjQVlzUeXRqS
         YsyW0y7XdoX+OsgA6epAYChPi5Q2/s/DwZ7tjX21EZjPbZPm6QEk7zRUhFKWY6kxmVEh
         hyOIGP1JsGOnpKpgdRWO7wkmZEz6cehZVDo7d0WyYhPDHdBs8MLF4A0KZdgjIuGzwpx7
         jgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742979628; x=1743584428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb8OnTjsyP5lh3M6/BjJHvWMp8bxQHXc7AdtZ7j6NMg=;
        b=M85W3Tj0ZoDYUZ+CnkfsS2U/NZ1BrdToQixhwYtj/sksSIb5kzIH9vjA+ojceABPzT
         2eHdKUNci7W0Wx67Xz1xRlQ9XCT7mznRoVVpa2x9Q8Hombr8PMu8/BBZ6rpRng4LVkds
         at+lb6PFwQUWihdJxlnY0gb0tAlnclZPsbSu3BZr2Zxh5kYQsVwKzM9PQ4Oh9rfZ6dod
         a8y9iSHOdZM438z4AIo0iK1N/EM2yeWrcmTq2NukgJl8V7kPVqhSsrkP2cM3LwpcQUoa
         OfvgK5c108m21KSByB1NfBu0Uat9wYCkQqk/ss5Ptw9v+jz3N02Aw919ct3hbjQwGGl9
         b+lA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9kEwJ4On1kpaxheQLJbRksIH+cI75Tz8yjVqEIBOXL5KKJJE2bqmaHYQQeYjAO6smvDAAuwa9oyxo4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpBAXvr7VQex7cPfdGhO/+9Fx9Y/rYpN5WtrHCjd2NYhvkaWS
	fAGXUs3wZvQI6K/9rGNHTiCDULWazfRrRncDaqp8BTSXD9RDaTUOu3oZaAGgmHTp+anVenrY58i
	E/+4imA/tiq4JwlvBOsKPL1RcQqI=
X-Gm-Gg: ASbGnct06HJLb2wdM5uLOw1R+J1wBY00lRxWNEeUzTReTuVtk9Dl57R+n1plGgvcMPy
	GA9S8nbMUpOxZIHCq0/6xefUvE/9yLyXRvuNx762+xXL7mgWKWkvO/FJk/cj/C5qrl0CXnX5GQG
	vf5i299AlKEx1wMIdBy1eti0Nnt8myQ+mJkqG4dWA=
X-Google-Smtp-Source: AGHT+IFHSfRSsBj9i2zkCxfktnsQWFsQ03tWsCWMByvDO1w6GNceB8t5REdbBbHd3bhanrFpcKVmTxTs39qjKm4xfjg=
X-Received: by 2002:a05:6122:3212:b0:523:9ee7:7f8e with SMTP id
 71dfb90a1353d-525a8342034mr16692642e0c.4.1742979628118; Wed, 26 Mar 2025
 02:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z+Lan0xeQd3m5ejY@HP-650> <aa42727-6388-cc8-c6e-b9ebc2a63591@inria.fr>
In-Reply-To: <aa42727-6388-cc8-c6e-b9ebc2a63591@inria.fr>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 26 Mar 2025 10:00:19 +0100
X-Gm-Features: AQ5f1Jp6t1I8p7pqAGoHINgVUZFmmVaQWKVJULMkrgI5KoJooT163QOlp85Xx_M
Message-ID: <CADYq+fYD3LVvBJCYizjG2DR4SMMC+V0Pff0zXKb8rLw2ej0jdg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove braces around single statements
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:26=E2=80=AFAM Julia Lawall <julia.lawall@inria.fr=
> wrote:
>
>
>
> On Tue, 25 Mar 2025, Abraham Samuel Adekunle wrote:
>
> > The code contains braces around single statements in the if blocks
> > which are unnecessary according to the Linux kernel coding style.
> >
> > Remove the braces to improve readability and maintain consistency.
> >
> > Reported by checkpatch:
> >
> > WARNING: braces {} are not necessary for single statement blocks
> >
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/sta=
ging/rtl8723bs/core/rtw_pwrctrl.c
> > index c60e179bb2e1..b17b295e8d3c 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> > @@ -56,9 +56,9 @@ int _ips_leave(struct adapter *padapter)
> >               pwrpriv->ips_leave_cnts++;
> >
> >               result =3D rtw_ips_pwr_up(padapter);
> > -             if (result =3D=3D _SUCCESS) {
> > +             if (result =3D=3D _SUCCESS)
> >                       pwrpriv->rf_pwrstate =3D rf_on;
> > -             }
> > +
>
> I'm not sure you need to add a blank line here?
>
> julia
>

Thank you for your review. I will effect the change

