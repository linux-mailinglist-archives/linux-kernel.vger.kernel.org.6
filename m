Return-Path: <linux-kernel+bounces-437511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580A9E9440
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4521888263
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F722D4E7;
	Mon,  9 Dec 2024 12:33:03 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FA22D4E8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747583; cv=none; b=NBAvwk/SRTl2zLCpypwM9Z3fi0Z6OxVkTASpUs7BOcvCV/xduCN26RaXyySdqK45VypbpebcNapTnfxsuUJcwPoRhwU6jIMoehGXV2A3MInXlT654KDwsLcjTnEv8OqqTtwZUlbMmPe7ZeJNHTq6Zyk40KCMIwFs5JaviL8NsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747583; c=relaxed/simple;
	bh=J3Zd3opQgaR9Wv4HMjE20VpB+33oQF/OvHZ61snu5/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE1PTMSeAPk17aJyLLL4PpSyxXrHKT8cUD+hBz4+p3lribMISZh0Cod3vGj8+LDYMeA9YuWAosSuzH5l0fscRVR6/SF9Nj8/6VCbHGLjott/tOroSUhbLjuNuwZEQCtyoBLtrEWq9aT7Sx59aESlypT1gmaO5gtAktNpxeDtB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afdf300d07so1156683137.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747578; x=1734352378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmzIME5hBzHIgRc790Loeon/HCVGezkSFNU9PjKgjeg=;
        b=S2LHGvojXh4pdEWdz56KqQe5Elmvy/28Iue5vm620ScKfK4SzmIeI8R12B3maztnCi
         k9DbzOnmJHi2SDpUN5BVhZjFk47k7m6l/paSqPGt+BM3bLuhS0jvIgg/UGa7niswhJ2j
         fnNIKkPqQ6PRt1IwwHBrkxAA9s1+6VrESGCrpigiiuyCGcahlrFZyfQDVM/iP7y3MxL/
         sgUkcYMpEgOG1EnL1Uq9mvlF+BBOit15NGR+OJcr+uaOk4bSBkiMTXjNumZ7c1EtBMCY
         AbQiGSeQ0/5ADJkT9b/m37ew01LAbkh1mU98t+iMaLGx5lpmwJOGq0qPf+xdq4rOQmsb
         q0sw==
X-Forwarded-Encrypted: i=1; AJvYcCUJsvBp97l1peNotCCyWGQx6Ildv1devdP4cGpKWJvuDYGQgdUjx/7v15Cni0no6UBuUd27TIKuyyvbOZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqEWo/GuBXXjyaBONyijJ2Fheri3E0MDdcALP7UFRARLkUo5N
	R2YxXpIP3dF/z98SuGB5onTIkVaB94WXohod7wDCJV+4YAU63VVKJePOt01833k=
X-Gm-Gg: ASbGncu8y0wel/zLlaYC7ksHiHrL2bwBc6iZYcgBRpyLRd3dxTMbZ6sFhUmhwoaJxec
	OAyT9yb55g98Ld6fCvelrqQ+B2r9GxHb1QD49gFHzgp7ive4KU6jRr0JCwp85oEzyDKKJl2Y5oN
	7SNrjn1ivgNNmCNCeNjbqqmDlfZe8C8qLC36XkfxmJakx8ynSKO7xqzW3NlzpbDQNRujSD1iY5F
	G+w5LxOTjJQ5kejdZI1tx6A/w2uots9G+/yhDFGOloZN45+AirNtfWh28BFHnNJXyEvGtqKPXvr
	YereunQJJSyzt1DR
X-Google-Smtp-Source: AGHT+IH2NpWX6O2KuQRpIEsojZcFineQ+sv96qAbKklCO0hkMtCrvq4lT7+YbaqkrwQzWG6BbVDiPQ==
X-Received: by 2002:a05:6102:c0d:b0:4af:ed5a:b69f with SMTP id ada2fe7eead31-4b115bc30efmr376618137.0.1733747578434;
        Mon, 09 Dec 2024 04:32:58 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2b48aba0sm1242890241.0.2024.12.09.04.32.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:32:58 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-518802a1e7eso264016e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:32:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhIEtO/5gDQhT1k1oAqedcYg3FPcPXPMCSK8UGH+ykTW590Zk8aKvdASPnyGo11eMTpl6OfsEgt9VMiwI=@vger.kernel.org
X-Received: by 2002:a05:6122:2895:b0:515:f586:5298 with SMTP id
 71dfb90a1353d-51888558a82mr274113e0c.7.1733747577876; Mon, 09 Dec 2024
 04:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113133209.1367286-1-gerg@linux-m68k.org> <CAMuHMdVZh6-64hfx1jgOijBEG6cTftinqf+4fZvqjJtV1hO95g@mail.gmail.com>
 <1dd8be4b-d5c3-4074-a91e-3ce998ce3050@linux-m68k.org> <7bb57485-c08c-4121-ade5-8c76bc48e615@linux-m68k.org>
 <992c4d62-380d-4908-a688-77197d9c4cbd@app.fastmail.com>
In-Reply-To: <992c4d62-380d-4908-a688-77197d9c4cbd@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Dec 2024 13:32:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkeeUD7x4s8F8AtdAcXP4A_Z5Vq2--UwasJC3xtZAzVg@mail.gmail.com>
Message-ID: <CAMuHMdUkeeUD7x4s8F8AtdAcXP4A_Z5Vq2--UwasJC3xtZAzVg@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: use kernel's generic muldi3 libgcc function
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:28=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Mon, Dec 2, 2024, at 02:34, Greg Ungerer wrote:
> > On 6/11/24 08:04, Greg Ungerer wrote:
> >> On 5/11/24 21:46, Geert Uytterhoeven wrote:
> >>> On Mon, Nov 13, 2023 at 2:32=E2=80=AFPM Greg Ungerer <gerg@linux-m68k=
.org> wrote:
> >>>> Use the kernels own generic lib/muldi3.c implementation of muldi3 fo=
r
> >>>> 68K machines. Some 68K CPUs support 64bit multiplies so move the arc=
h
> >>>> specific umul_ppmm() macro into a header file that is included by
> >>>> lib/muldi3.c. That way it can take advantage of the single instructi=
on
> >>>> when available.
> >>>>
> >>>> There does not appear to be any existing mechanism for the generic
> >>>> lib/muldi3.c code to pick up an external arch definition of umul_ppm=
m().
> >>>> Create an arch specific libgcc.h that can optionally be included by
> >>>> the system include/linux/libgcc.h to allow for this.
> >>>>
> >>>> Somewhat oddly there is also a similar definition of umul_ppmm() in
> >>>> the non-architecture code in lib/crypto/mpi/longlong.h for a wide ra=
nge
> >>>> or machines. Its presence ends up complicating the include setup and
> >>>> means not being able to use something like compiler.h instead. Actua=
lly
> >>>> there is a few other defines of umul_ppmm() macros spread around in
> >>>> various architectures, but not directly usable for the m68k case.
> >>>>
> >>>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> >>>
> >>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>>
> >>>>   arch/Kconfig                   |  8 +++
> >>>>   arch/m68k/Kconfig              |  2 +
> >>>>   arch/m68k/include/asm/libgcc.h | 20 +++++++
> >>>>   arch/m68k/lib/Makefile         |  2 +-
> >>>>   arch/m68k/lib/muldi3.c         | 97 ------------------------------=
----
> >>>>   include/linux/libgcc.h         |  4 ++
> >>>>   6 files changed, 35 insertions(+), 98 deletions(-)
> >>>>   create mode 100644 arch/m68k/include/asm/libgcc.h
> >>>>   delete mode 100644 arch/m68k/lib/muldi3.c
> >>>
> >>> I had this in my local tree for about a year.
> >>> Is it fine to queue this in the m68k tree, or does this need a broade=
r
> >>> coverage?
> >>
> >> I am still in favor of it :-)
> >> Would be good to get some feedback on the common code changes, like th=
e change
> >> to libgcc.h.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> This looks fine to me, nice cleanup. My instinct at first was
> to add an asm-generic/libgcc.h as a fallback in place of
> the Kconfig symbol and move the common macro there, but there
> really isn't much benefit to that over your version. Either way,
> please merge this through the m68k tree.

Thanks, queued in the m68k tree for v6.14.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

