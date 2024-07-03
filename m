Return-Path: <linux-kernel+bounces-239969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430A8926760
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC311C22B41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC9D186E31;
	Wed,  3 Jul 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfX2WZcY"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882F17F511
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028738; cv=none; b=B/ZvREK9iv64e+rP6Z1AXYl5vebTFgI3e1agF4RxNGXxHGv0XlXS9fYzZz1I6rDJZygZt3DtNeTEvBLuEyxXH3tPJHBZQFo6xEKq+Q21f6Tc3fSZat03s04qB3A2zVjD/lTMDf8HrdMQS1QRdXSl01Kil8DogwRNVHGjVUjA+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028738; c=relaxed/simple;
	bh=ZFx/AckbAn6Lg2bbrC5Gs3Kyo9xcbmBm8MnNgPXHVZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSI3j83zZojnXgiteLwCEvDmwVyN0SNCynKaIEnciy83e9AAs/oeRMbOTdssewwh7Yxx/37tJSjdn3qqPLSJuy9MkG6XlP2h5HbKFKiTxJcUivnggsdfjgEOrd/DMJ64PdxkZ1mMo42FsxSWq9Qx9FoiScMzch0dcGDbfW55e9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfX2WZcY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-650469f59d7so20121247b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720028736; x=1720633536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhxR4AnmOLb2e8qgt4elcn3tmPYz1HfQBknaKkg9ViY=;
        b=pfX2WZcYWJxW8EgUYeR4iqpcFNMNlk2PI1rHa3mDFv12nL0Z4Hmjhj8bLu8y5zU59V
         jsjXr6CgtAiXyNT5r/U2nj1ASKZ0BKqoP3MB5nP2UwN5EAVncegani8pyuOt2Y3HFue5
         66gZ3L9qTBwJZ0vO8jlKqCzyN315Yky/gBTOsT3lf6mXv/PED2CWMyQKMgSSoDvtbKqZ
         XduELPVoftWrGyFVUPfOZao1XpLQ9DmZ4QlickrZ1M3jdO5FqXqeRv6YyXP0aMtADNUb
         SxsMs5m/4WqPJwzRVUM9+BnjWtXeeGQjEKl6KeHVkcNIJgRg7AFy7eb9czZP8//Xb6Hd
         zVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028736; x=1720633536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhxR4AnmOLb2e8qgt4elcn3tmPYz1HfQBknaKkg9ViY=;
        b=cgiCT69b0c5Id4QBm+zoQ9Exa8z9FIx107NoO2vALFi7CaQb2dF/s8ANu2gATy4kEZ
         rZVGL5w64GvOqt4eHq8GzuoVma2Hn2+umwwjAcrHdoBi7k8vis6KW++at6rATRsEoUAR
         44UwdTXLX94BdNIiccPRfhLxRrizAiMXVh8gwwg4Qtrf+laFjTV6aW2nTZoQFkAb0Dvs
         ZpNxS5ytVF5YNZx+sdiMUaACKF4CUcAfjJ37PhX6vg9FL5T8ZRbOn5qKNJrU2iKlW/Os
         IBQ6s9aVLLwkSehhXATlQbPSH4zr3EpYiS0o83n2D7o2JFElxD/AeKusmBk8CqukCExS
         imug==
X-Forwarded-Encrypted: i=1; AJvYcCUbKgh1blhiN7ehDpLuAwnDY3/NfpJnL1ozRSz4PkGS01+dssB0rIXcfSeQhQiiVcybZGL1MuUMYyOYl/TGzOdoGcbPi52sXZaNfmVO
X-Gm-Message-State: AOJu0YyIIwpJ++HW44jf0BecQeF1V1m8r+AwLe8mO9h5crz4TcHrupA2
	9ofae3y2E0A/IdrKXp9ydyR933yOOVfSSYdfaD+B5KegefaN9yT+yicjuZG18XzPrCGzmkBP5iK
	i2VMdjmlCq72HIVyXKUA7j+/BLLueEyUxr+a3Wl4Ty0h0aNBV2X3t
X-Google-Smtp-Source: AGHT+IGhOytUB8CaG/gAFJEC68exEInJu4ze08dBFswC7EHqqNiHxCYGfnPatnT8gPM2A0u1TbA00DVz/5EvCS/GRV4=
X-Received: by 2002:a81:7c54:0:b0:646:25c7:178e with SMTP id
 00721157ae682-64c7123c013mr127129437b3.5.1720028735529; Wed, 03 Jul 2024
 10:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630011215.42525-1-thorsten.blum@toblux.com>
 <20240701232634.0bddb542ddea123b48dcabdf@linux-foundation.org>
 <20240702064017.GA24838@lst.de> <e0f384b0-6913-4224-a3ea-bdae784f5dab@amd.com>
 <20240702003357.6bfd1d918c56d536bb664c37@linux-foundation.org> <CAJuCfpFCiUfpa45rG74zd-KoQcaA2fwgUw86iSF2CDiFrXCOdA@mail.gmail.com>
In-Reply-To: <CAJuCfpFCiUfpa45rG74zd-KoQcaA2fwgUw86iSF2CDiFrXCOdA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 10:45:21 -0700
Message-ID: <CAJuCfpHJPtduJwOyxTFT9RVmWZCcWULWhUN4ZPEt6earHp=MXA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Remove unnecessary kmalloc() cast
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Christoph Hellwig <hch@lst.de>, Thorsten Blum <thorsten.blum@toblux.com>, jack@suse.cz, 
	linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:15=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jul 2, 2024 at 7:34=E2=80=AFAM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Tue, 2 Jul 2024 09:13:35 +0200 Christian K=C3=B6nig <christian.koeni=
g@amd.com> wrote:
> >
> > > yes that is
> > > intentionally a define and not an inline function.
> > >
> > > See this patch here which changed that:
> > >
> > > commit 2c321f3f70bc284510598f712b702ce8d60c4d14
> > > Author: Suren Baghdasaryan <surenb@google.com>
> > > Date:   Sun Apr 14 19:07:31 2024 -0700
> > >
> > >      mm: change inlined allocation helpers to account at the call sit=
e
> >
> > Dang, yes, that was a regrettable change.  But hardly the end of the
> > world.  I do think each such alteration should have included a comment
> > to prevent people from going and cleaning them up.
>
> Sorry I missed this discussion. Yes, the definition was intentional
> and I will add comments for all the cases which were changed this way.

Posted https://lore.kernel.org/all/20240703174225.3891393-1-surenb@google.c=
om/
adding clarifying comments.
Thanks,
Suren.

> Thanks,
> Suren.
>
> >
> >

