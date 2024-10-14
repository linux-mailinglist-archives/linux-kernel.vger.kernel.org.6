Return-Path: <linux-kernel+bounces-364063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0912699CAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E351F2121E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E671A7275;
	Mon, 14 Oct 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyh6bQ8W"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04D1E4A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910281; cv=none; b=et+ltWrilsiJJ0T+29OBYk5sYPCdhQL9z24C3pU4F77eiR9einVZ2iw1bIE0u9OirK073XHmsFpQzy0hgaotSu03RqjaUdyA9P8fyi7rheMd63IGfNEv8ydYbz4/0c66Jb6FH6elTFgeBXlbLHe199j9WvsHGxje8AsXrLS3I/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910281; c=relaxed/simple;
	bh=gHhsAOC3U2cihF/qlkuCA+W4SjKaaladfJPd4frAlhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uj57pEkFewdtu4NYkNZJwMt/B1SwAzkqJYztTifRZEPaFKdP9tXWtArfbFZy9gnIoVF9tjtmPOVP/7DmIiFIM1wSXC+A959o5IxLqAbBYiJypDca6YuUJNJIhKMLrBNh1XbYQHjL4YZw9eNZipE69XlFVSSTR/Qg9VrOwbNZQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyh6bQ8W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso26940015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728910279; x=1729515079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTj+KrwAbzaTCdU6CLaQDg0rSRCy4G4QoJfQLN+pOnw=;
        b=kyh6bQ8Wp45U8AKFvFB5+eQhYzsiypnAnfF//ZOEQxDi5T9BaLzaSMRoDXlJ21sY2J
         GB1Now5RIKAnO8RmOpSOcfIAOCJAkpjLTfFcD93rB5WIfjMB7a1hIwhnypVnPFo/F9S2
         e3A0EDS3IvKegEc9Avzj7KgLW8chkUJaJc3dy0s9p82pMXFCVjjJkXsimiBg1MpuSR5C
         Z5K0WlQC/YLFN9pvXWsj0/VAKY/j7K0V9vkr127aM4HY78776awEXtvz1z+QfVCID4/D
         LG94ITprW5XaJ0dsAQ1xBiR0FWiouXo1o7TMcEelBMcUK7jenRKPLkvPQu36UhXNClLm
         3nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910279; x=1729515079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTj+KrwAbzaTCdU6CLaQDg0rSRCy4G4QoJfQLN+pOnw=;
        b=ApYme07t3uc7/2LVch/RYKPnECrITImoE3YSRTPMPzaYZmy1VMDMDFihuxJiL0d22T
         IEUJgI3YkpnFcsGnvYHoo3+XbFuY+xIKVY2ahsCnLKgQWbwQNhSRwj2sggWSaZFmfDlr
         xOaTVQmfBqG26jQ4Qzy0Yur2MZXedoRHiThAwvs8YcEBPm2zaIrhMd69sI5od8EbPfnY
         bUPGUMT3r4KLARInDgdI2h9VVek+AhZwXWCPLFVunLyZkeimSK2bsy54MiOv/vKECFT0
         HUZLNYl37Z65e3tzdB5itXKB+uNIEgEH7a2aw6SRvreR+T4+xVICVLUqA0fK5wsx/s9+
         y6bw==
X-Forwarded-Encrypted: i=1; AJvYcCVei+mHduc4zskLTnQbh5PY+5V2hifHs5/GwC/4OT3UjRPuFAMeFq5trwnyL+73pRcIcqOLodpzJRPaysY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXEGB6TJ9YTrQsxNzITKDmL9HqSjZrmYPWFOgd5xUY0FHmoQo
	0Llz0vT/7EYBmpexzvRjMd5Sf63QEJVJTff2gg8KK3iYOa7VsIc5BwMnUHsJ5arN/Hht/g8Wh6X
	kshK0pGYG/+UgIGy1qxsyDeN9LGw=
X-Google-Smtp-Source: AGHT+IEsZHLFXBrY9HEdog2g0szs2BzXi3YXDG4qk4mTBIdEbLat39nT4Dmp3v+TSVAyGbAIzkG5WUbb1+4D/DbyFss=
X-Received: by 2002:a05:600c:8714:b0:430:57f2:baef with SMTP id
 5b1f17b1804b1-4312561a03amr80486185e9.32.1728910278570; Mon, 14 Oct 2024
 05:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012225524.117871-1-andrey.konovalov@linux.dev> <CACT4Y+YS4UTMwk_j+Fjah3bCQd0zFcr2XqsUJ5K8HC991Soyhg@mail.gmail.com>
In-Reply-To: <CACT4Y+YS4UTMwk_j+Fjah3bCQd0zFcr2XqsUJ5K8HC991Soyhg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 14 Oct 2024 14:51:07 +0200
Message-ID: <CA+fCnZfkurMxTyf0ivF8uffeO+S0piqFuZ975SSxmjr_V2OrHg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: kasan, kcov: add bugzilla links
To: Dmitry Vyukov <dvyukov@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:08=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> On Sun, 13 Oct 2024 at 00:55, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Add links to the Bugzilla component that's used to track KASAN and KCOV
> > issues.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7ad507f49324a..c9b6fc55f84a6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12242,6 +12242,7 @@ R:      Dmitry Vyukov <dvyukov@google.com>
> >  R:     Vincenzo Frascino <vincenzo.frascino@arm.com>
> >  L:     kasan-dev@googlegroups.com
> >  S:     Maintained
> > +B:     https://bugzilla.kernel.org/buglist.cgi?component=3DSanitizers&=
product=3DMemory%20Management
>
> Do we want a link to buglist.cgi, or to enter_bug.cgi, or both? =F0=9F=A4=
=94

I think buglist.cgi makes more sense - people can check the list of
existing bugs before filing a new one. Finding a link to the right
enter_bug.cgi page once you know the component name should not be hard
(but IMO Bugzilla should just provide that link when viewing bugs for
a component).

