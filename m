Return-Path: <linux-kernel+bounces-297936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460795BF68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F117D284F61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FA152790;
	Thu, 22 Aug 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcE2QTBL"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE081474D3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357262; cv=none; b=rfcWvsxhncLu0ya1+iRIAGA3GA9lFpj8IRssP+gZ9fhzJh3o52baNJj/Wujd5M2rOjbgKyctrNOzlUf1FT+bVAiAwpfjvgpLoWhwJexbOLfviQeofZAy1PANQGA/nEMVqU5bRN5GTjkfKV+G8PlWWrNjbhYgMkznPsfqNXhq0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357262; c=relaxed/simple;
	bh=peKlo7gpl4NYnwe2qqFXVS4BwQ8f7eb+mFo0rLnk9KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIaUxzJXKAYr4+iZtHFofJyZkzwXw0iOdLmOuycYX8cKZSigiXwDycRzCLmufLdRj/EXEqPYgg8AkE0jAwZei6I2rq+Y2I9fb1WizasJEAmmnuxl22/LJxNU7eKAdTHVzdBx7f0rBzis8vDSD0jwsj/bBnFhl7VWlWHWGyxkbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcE2QTBL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so1642672a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724357259; x=1724962059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj/ZdRQ/J0SSt5Cm7vp1LinY2Js02ustAamTE4OUfqM=;
        b=fcE2QTBLz1KLeToHi7pYaRN1hnbpeklEz8z2Bwo+ffjfFLRTfLQ1iN/13UXKlf9p5m
         3h1ALswESH2N9qTdwR0sEAs/luSv6C51fJLMlYzocZTyRB9c16R2T41hlQkLyi6QNNw0
         IgqeXMFmw786csL5uMenn/OuhTQC10kvr+Njenlq9oBe3KO3Qs+1Kk1pQKo22u9/iQ4K
         LiiCDIalxaNgrO8A0Mz8Z/+0J5eBAMpR8ih3Y8aq1G+Tcx9lfr9kr4+uHFJPrbbOGBq9
         NmI62JKHhqg3yC8uiCYsRoVTmeBr2NAv098ELI+qPRyH8pwCKKplPVgWK7nwvJ5aeO+y
         mkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724357259; x=1724962059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj/ZdRQ/J0SSt5Cm7vp1LinY2Js02ustAamTE4OUfqM=;
        b=YA+mfXTIpLh3RuUJg/1J1kUdxGnACs9jP4QFmygFAARbSopZ0ywd0ypqyYpoKNSveW
         oAlXhnJxr9iGavQNsLJyfEqvi3UjaxKujvgLRWfWSES+BUg9NmlzJODnJ1ELQ7WcTwED
         JJEVglNtDZNckonzDr+dxrGnZOeuShySX78QO3876qfo0qVvVHMo+BEomvM7iAqYYBhl
         Kds/eFcAEXN6ybwIuqPDByi3NpaI598hlfrpO7Dz9zbtlLkM7WEvuOZ2LrVGoueiv0SW
         kViOJh2qShh8UYCvdI3M3V776OFfVIQnuwqPwv6OI1EiAXgahoaDSuRUy99gOTadaLVC
         2aDw==
X-Forwarded-Encrypted: i=1; AJvYcCWTIU1YlYC+CnqalSc+2fjXtwXYRMG25rh4aw0tL3cHhuq+2eNY/EVesJOn/LTJe1Tafeyl3Hy1MX6nKrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGSEHStzU6mG6I9ae+E0hXHMMCUjwumU6I2igo2uwvsmPkwfx
	exU1NwS14w9FFgaF9E0TCguEylGKP1gZjIChF/3hZrMx/6tYep20hMLlR1Vmpu7aYuLuAjdsG5g
	u0bpNpR5rsWc9iUsZ6xpLKHqECaTZV8Q7
X-Google-Smtp-Source: AGHT+IEtd+J6UD1t+3RLE4kEBCangLZO8xgacqf05I1XcVlXh5AXH2uUcxNbMB8IOUoFhdWW11jGIgN/N6BcTLy45iY=
X-Received: by 2002:a17:906:c10a:b0:a86:7199:af37 with SMTP id
 a640c23a62f3a-a8691cb9768mr182051766b.58.1724357258405; Thu, 22 Aug 2024
 13:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822003043.10865-1-anachan.01h@gmail.com> <2024082207-enunciate-whacky-e1c4@gregkh>
In-Reply-To: <2024082207-enunciate-whacky-e1c4@gregkh>
From: "Ana Carolina H." <anachan.01h@gmail.com>
Date: Thu, 22 Aug 2024 17:07:27 -0300
Message-ID: <CACRD3dDMVn+WoeKV20PCi4ebwY07u4gv=ULKMSrB6eTWAgupHQ@mail.gmail.com>
Subject: Re: [PATCH] Staging: rtl8192e: Fix arguments alignment
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	~lkcamp/patches@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 4:53=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 21, 2024 at 09:30:43PM -0300, Ana Carolina Hernandes wrote:
> > Fix the alignment of arguments in function _rtl92e_query_rxphystatus in
> > order to silence the following checkpatch warning:
> >
> > CHECK: Lines should not end with a '('
> >
> > Signed-off-by: Ana Carolina Hernandes <anachan.01h@gmail.com>
> > ---
> >  .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/s=
taging/rtl8192e/rtl8192e/r8192E_dev.c
> > index b3d4b3394284..bca6e4f57bf2 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> > @@ -1145,16 +1145,15 @@ static long _rtl92e_signal_scale_mapping(struct=
 r8192_priv *priv, long currsig)
> >                       _pdrvinfo->RxRate =3D=3D DESC90_RATE11M) &&\
> >                       !_pdrvinfo->RxHT)
> >
> > -static void _rtl92e_query_rxphystatus(
> > -     struct r8192_priv *priv,
> > -     struct rtllib_rx_stats *pstats,
> > -     struct rx_desc  *pdesc,
> > -     struct rx_fwinfo   *pdrvinfo,
> > -     struct rtllib_rx_stats *precord_stats,
> > -     bool bpacket_match_bssid,
> > -     bool bpacket_toself,
> > -     bool bPacketBeacon,
> > -     bool bToSelfBA
> > +static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
> > +                                   struct rtllib_rx_stats *pstats,
> > +                                   struct rx_desc  *pdesc,
> > +                                   struct rx_fwinfo   *pdrvinfo,
> > +                                   struct rtllib_rx_stats *precord_sta=
ts,
> > +                                   bool bpacket_match_bssid,
> > +                                   bool bpacket_toself,
> > +                                   bool bPacketBeacon,
> > +                                   bool bToSelfBA
> >       )
>
> So close, why leave the ")" on the line all by itself there?  It needs
> to go up one line, didn't checkpatch tell you that when you ran it on
> this change?
>
> thanks,
>
> greg k-h

Checkpatch didn't warn me about the ")", but I will fix it too.

Thanks,
Ana Carolina Hernandes

