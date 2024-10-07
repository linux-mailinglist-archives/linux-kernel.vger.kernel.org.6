Return-Path: <linux-kernel+bounces-354280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8E993B29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB41F23900
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095218DF88;
	Mon,  7 Oct 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="BknXOZ8s"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2F18C320
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343459; cv=none; b=QBlkamndaaEGcx/VkXL8To5TjmVWCSuDwM5WN1OSwlFsE/IZheYsbf8qAdaZInq4IreUD4TkecysrLwlkZ/3hKKSs5ZgX4ex0zzs9qsIuhMKqXJnUgtDCkWJ8sBDgzgMb0j3HBuCXfI4tUMzf5JdbPWWlfDHDVCMwfEUo6qJB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343459; c=relaxed/simple;
	bh=S++SZRGC4WZd6VqO5EBNm14oG5f04BfiaAcbU5vSpUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cjrgzod0q5kJpTyKMvE2pNefMFA3lBjqMOHWdYJoFCUoJuquedeGGHdOXqQTHlJhnmFLt1atg4oWNBvvDDrC5iErgEGIJaeu9hlUKDnZvqap7ApwsFpBQwlxEV9ngRYb51Qlo+zCKOo9EklbAzsUVOOpxkYNnMgVRDqbR0TIA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=BknXOZ8s; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a994ecf79e7so243931966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 16:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1728343454; x=1728948254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA93a5yRb00a+UuMXUW9NqL0csLZVpZst4pu2BAc5AA=;
        b=BknXOZ8s68wjlH9MaVnZiMwTjWnBScNqP0rFrtSDj2tuHEi0CqKmLwuOeFj4ygv2aa
         HhcftVdJjJjNvkZa/uDfAfHAdSYHChKzXQhlfwcqfvmaWWdIIOIk+581Tt+CMLos3yHl
         0vIaoZm2u1eg7aZTY6Vb91rnHPWxYyIzQqMo+L/ksob8urFIxE0oLNqX8MHugyNUZscM
         uGt6/V/sv0vVlXrHADZMkIp2cemEzQ7uPCxas0CvtbFWzpoiGEnnzFukb4Nzu3IMHGVO
         hBPFg7s+bTD3amfhsfotAdzgFSkhd8qRfNRJeH9siK3II7wge771wsUMkfiteMfpdfxn
         G90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728343454; x=1728948254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA93a5yRb00a+UuMXUW9NqL0csLZVpZst4pu2BAc5AA=;
        b=jHHfCPh61sx2RWEs1ZMNJ9B2FQSyM76BfssGywBMV7akEgfxiG8o5NpnRS070OJ7s7
         B8HZDAEE0u0efd8JlbZzO0czBAhjKOpV+YhjVUZ/xYSQC3dmbHii7KbnbZt3v+cDi3cQ
         4eMq/Cd85B21v66B6hJv5/wURsikrpC3dB9gk5Abz6iRDHMUalcZ2ed7S/bRlzNVJCEG
         aZrIyEtmEeENgXtiWLT62GeaipIR9t5i+Lwa2N9nsKIbozp6tjRNl7Www+lkHnS2r0j4
         UHdnBXCXsB+ie4ittGMR7TvYNciIqvzb4i9P5Pwa7lMENco4wOxFeOsPImvPz9P8SDmn
         GwGg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjhvhUjGIBq55LbsTuCzTzdbK4CQA91J7HgjV+LeULrbnByLCW6zMd+iMP0dn4p4qeZgEnbdHdHmHpYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxonG2qp5BPldpOzS1Plx+es+OC2lIeEF/Y3rUkVCE9TiJNhQ0o
	VSyQVLxVpqrYX7oqVU7APJEd2aVnYevBRRi6e4d6/Uv/u3+jlyVJ/8rwOH62aX+WpiW5vDoGPGg
	2NV3fu0HwquL5V4GWCg9HMOZJfLsYbZvRYoQ=
X-Google-Smtp-Source: AGHT+IERrr0zaNaDVVkW0Rnlzxg6JvJCU14edQFkNtV2OEdfJ3z6obkLAO+RaU9b3thWOGpvRRhCh+RZYXmVn1C4KNE=
X-Received: by 2002:a17:907:1c93:b0:a90:d17f:eced with SMTP id
 a640c23a62f3a-a991bd04dd2mr1420586866b.5.1728343453702; Mon, 07 Oct 2024
 16:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006001553.7430-1-iwamatsu@nigauri.org> <20241007135920ef75da53@mail.local>
In-Reply-To: <20241007135920ef75da53@mail.local>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 8 Oct 2024 08:23:47 +0900
Message-ID: <CABMQnV+Gi2qysXf872OCevCJikyWRbbw016ivoD_tmvweUan5Q@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-mc146818-lib: Use is_leap_year instead of
 calculate leap years
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2024=E5=B9=B410=E6=9C=887=E6=97=A5(=E6=9C=88) 22:59 Alexandre Belloni <alex=
andre.belloni@bootlin.com>:
>
> Hello,
>
> On 06/10/2024 09:15:53+0900, Nobuhiro Iwamatsu wrote:
> > The is_leap_year() for determining leap year is provided in rtc lib.
> > This uses is_leap_year() instead of its own leap year determination
> > routine.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  drivers/rtc/rtc-mc146818-lib.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-=
lib.c
> > index 651bf3c279c74..ce4d68de05831 100644
> > --- a/drivers/rtc/rtc-mc146818-lib.c
> > +++ b/drivers/rtc/rtc-mc146818-lib.c
> > @@ -232,8 +232,7 @@ int mc146818_set_time(struct rtc_time *time)
> >
> >  #ifdef CONFIG_MACH_DECSTATION
> >       real_yrs =3D yrs;
> > -     leap_yr =3D ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
> > -                     !((yrs + 1900) % 400));
> > +     leap_yr =3D is_leap_year(yrs + 1900);
>
> Could you also eliminate the leap_yr variable?
>

Yes, I will send v2  patch that deleted it.

> Thanks!

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

