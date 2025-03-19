Return-Path: <linux-kernel+bounces-568447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8905A69596
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE9D884B29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD151E3769;
	Wed, 19 Mar 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBBhk5uN"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC51DF74E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403403; cv=none; b=FFhg1QUJtB3U5HZl0ea2ymdZfXR+Uw3mlFX0t2MUroDgAGqW0rdDU8K/bCZ1M6D4ioLB0K7ISEGk7j1cCVsRzA3tRJl9i4Gx6YpmASlQ/A1/SXRXrTvjrXvDABjTe/1DmlT7lpIed+Y+9uEgu9PCN+kY4+Q7F80Oyc6e8Sdrtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403403; c=relaxed/simple;
	bh=zwYnXMMsa1QDVsiNd/S8z1RYMd3ZqeeN/TUb6PISgzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHCsAs40H1BqCG7I1nlaG8i51QGAw+8lV4WGcdhI3VIb7D4HUPx/ElwGzifmdm5B+ou+mWsBHh1TE53zXAttoWgGGUh4IH58q29WlAC4q5VIvv6TXDulPwYcuXxW2P6cm5+oIghOMZ02wwBdbx9vVg5AF2x9Hnra0LkkT2Aajqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EBBhk5uN; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-724daedf8c3so764940a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742403400; x=1743008200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE5HVBmGckTruTp6gXALafzs0whRU9prTDWUYYmCwK0=;
        b=EBBhk5uNZh9ZBAyboCzc1aIyUl1KCcgE7b0IlGjfBsTfXjT5aOl9rr0f32KQIj9mp1
         Q8od83wTNmVoYo1FOmolYeqmgaGXgjY58Qth5cU4Uj4kYRlcDzJ6NiUt+TtIo4Rxa6TR
         N4pwpJnIotjlWOP7uLm7S5XHRu5Ct1FKhuGUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403400; x=1743008200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE5HVBmGckTruTp6gXALafzs0whRU9prTDWUYYmCwK0=;
        b=CBKZTGQO0y6UwdeC8KnL9ugpiZiN4jLD/ZqoOB5VL5eddtLLyYp+Q2D804pUO/QNvI
         0kaUIcUCnjtwyAgPETbq5INSC7DyMx3662x4ipbLCsoWkAQMAaklcLGO1qVDMPvaBlt8
         B0fT/6tnXhL/jXC+R4vBkUUyoZRvvBqayZlURt8EplffjHyY6Ku2TppJR6RRsLIpSiUa
         0DRSgesTqDnW41dwJerYmW5UGWths3XrUArrLyYK3lEC0OIPxMpS65wlO83KDwf53AUT
         4uKvU0bH2M7U62R+PmXd3f3CLSLdnR21CukAU35HEML2QrKEAFp9a8y/kjYyzcMzCzkq
         HDGA==
X-Forwarded-Encrypted: i=1; AJvYcCXvrR6bY7P2ROFMuvEvPhK/RM5mZ9K5dmwr/q1QhbS2lmxEfLpSeyNwUpjXlhohhFOw0Yx+i0o/e2ACPm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNoTxaMzadCbLJbhQ0l2vrG60fCL2YA66XzVE0Keid6aH+sh8
	sP/dS7YbK2FJv8dKJmtGWqjGf5lDcwY10uLnPIlIpm+u+aGyN1D09KK1iiWqfEFxBafpjeN3gNr
	TKKDDFyD+kBFpDYovrXFcqp2of+wCfT9x9p/7
X-Gm-Gg: ASbGnctSHvKEoVXoj8eoi+GECzqaD00ZlmGBfs2Ga0gIhE6LbGrYZdyVWEiE30TJHkq
	zNhqViAYQNnMd1EwxJfdwtlzBHnMxBhjlSIwUOCmq0LS0xqyu6cw9hRWlwCYmliS2QZ7NC4tQQe
	TX3I7OcgP8FO6HXcsY1gtWtNPGOby+D46jvuNwj0U5ODRnaKOSj9hgloRbzyGBrinpBQ==
X-Google-Smtp-Source: AGHT+IFzgXMNQcpoWareSib6wev3ti0IRU9vlUdrQeO22LdB0Bu/vQYpcQWzOYqllkJTRFeitamGLkxU/bPpWHg0/cs=
X-Received: by 2002:a05:6808:228c:b0:3fe:ab9b:1a8a with SMTP id
 5614622812f47-3fead6023f0mr973087b6e.5.1742403400056; Wed, 19 Mar 2025
 09:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
 <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
 <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
 <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
 <CABi2SkVndMyOUpRR8z7f0J-r7chkVNZ17-kaEcBje1kBjk-1iw@mail.gmail.com>
 <CABi2SkUAnWAu9L-Km35U4XMmbp9-w+hKCXkM6MYNejYi5ip5Tg@mail.gmail.com> <CAMuHMdUruXfLCZ7vC+VmPRnJUH1Z1LnN9iaeafGaa_EAisnk6A@mail.gmail.com>
In-Reply-To: <CAMuHMdUruXfLCZ7vC+VmPRnJUH1Z1LnN9iaeafGaa_EAisnk6A@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 19 Mar 2025 09:56:28 -0700
X-Gm-Features: AQ5f1Jo5j5hm3bh2_R1XoS4SHAz-D931z9dWRwfaWf7nMpMXBKMw_L75WG7Uvjk
Message-ID: <CABi2SkX2piCzCHMoxe5txGCZ0wAkMbZ0A1VeMottZo5xa3-A-A@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: edumazet@google.com, m-malladi@ti.com, 
	Kevin Brodsky <kevin.brodsky@arm.com>, guoweikang.kernel@gmail.com, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, svens@linux.ibm.com, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert

On Wed, Mar 19, 2025 at 1:17=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Tue, 18 Mar 2025 at 19:39, Jeff Xu <jeffxu@chromium.org> wrote:
> > On Tue, Mar 18, 2025 at 10:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> =
wrote:
> > > On Mon, Mar 17, 2025 at 12:14=E2=80=AFPM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, 17 Mar 2025 at 20:02, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > > On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium=
.org> wrote:
> > > > > > On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <gee=
rt@linux-m68k.org> wrote:
> > > > > > > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> w=
rote:
> > > > > > > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium=
.org wrote:
> > > > > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > > > > > Add Documentation/features/core/mseal_sys_mappings/arch=
-support.txt
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > > > >
> > > > > > > Thanks for your patch!
> > > > >
> > > > > I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_6=
4BIT
> > > > > under arch/, and together with internet search/wiki page, and bel=
ow is
> > > > > the proposed update.
> > > >
> > > > That way you only find users of the symbol, not where it is defined=
.
> > > >
> > > > You can use
> > > >
> > > >     git grep -W "config\s*64BIT" -- arch/
> > > >
> > > > to find out which architectures are 32-bit, 64-bit, or support both=
.
> > > >
> > Microblaze, openrisc, sh, hexagon all don't have CONFIG 64BIT defined
> > in KCONFIG, and are not using CONFIG_64BIT in their arch code.  Is
> > there something else that makes you point out the hexagon as 32 bit
> > only (and not other 3) ?
>
> AFAIK Microblaze, openrisc, and hexagon are all 32-bit.
> Linux used to support sh64, but that was dropped, as sh64 never went
> beyond prototype hardware.
>
Great !  Thanks for the information.
I will update accordingly.

-Jeff


> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

