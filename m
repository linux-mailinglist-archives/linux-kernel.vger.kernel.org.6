Return-Path: <linux-kernel+bounces-573876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0FA6DD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971703B5E07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986EE25E460;
	Mon, 24 Mar 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AsMdWie0"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886901DD873
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828009; cv=none; b=oacpbkUgzSTwJHWSHfo+0+MzkX+UlnEQPvQsQNrcmcGxiXDji2DCpB3J+ZFRJ9jlEMlgiI1QezTOuT32xoG6NnGgtfQqD7QT0cPHAQxZFySDdLvAUEnAlI41a8G0rJ2+MivLDpPTqUrVw9OP/Z5z+ZSikGasl91OBoSPiVm+SLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828009; c=relaxed/simple;
	bh=fSYzfzwBGJuhSvnM/JJDU5Js2NwwoHLN3rPSCQutl50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EejkV4YBjCAaNHo8XCGAEsamUWD6qTS519aYl1KzXzw0BhxHWTzTnIfRE3Lj9sKWgQdxx8TwFbs7rNt9Nyaj6jwlBA8hytONmaMEUTT2qoUrWx2yU8oGcvDGWqCQT+fOym4uhgjQk3I5gR4reHdTAN0XMw0yEuIg8kO8jtVOR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AsMdWie0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b938f6014so830067a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742828006; x=1743432806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLSbZsyFsudAbghWPIsTb3HkPd3QHoIGTjeEhasFfwU=;
        b=AsMdWie0MQXIBxkHMgrLsFJkTBkAP9I3tk+VS0z0TrXS+xHOlI017ZzxTUvhY3iH0x
         xoyq6r5K9sV5ekoFGG+Y3Lw8IW/z6JfZQzIXbXYy6HLYL9E0T4SKh4HkzlZSy7uIZr83
         BF24NtECcVFMxE0i76Y5x8eweLHMjslD/V4V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828006; x=1743432806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLSbZsyFsudAbghWPIsTb3HkPd3QHoIGTjeEhasFfwU=;
        b=gkyTzVLdQoGKqbm3+i48QQVGEMUby+ICrn+TLXU0uObxNcZHVhc2k2T4k7KqErvDQt
         hYVOUlUia/l/r4LqSSTpBWX7TSMEp1UBIUmaXI7xztSjwfYNNn8EZEAdQkGYsDhUT6OV
         fn3K3IX4zmJtLBXdPlqJ7TjgQ+a8cXvUC2ECHYWtd6zZudC/gtXxf93CWwmw1F3jm8qg
         +jQPDfE7VJ1aXPIGc9A25gqx3OgOxRjwtDwEboj4HUaMif9JAHnm5C5Wn5RgDjHsWAf2
         4js8HO3moef8MYYaCxYDPuMOsrVnM9cw0+CTm2bPsto5eBfumUl/WZ/y+m1nPVVyKpKl
         1lag==
X-Forwarded-Encrypted: i=1; AJvYcCVBuKRGjAhiE2H/droQ0ZeeIVBH5iTA1pm1XsX9pD3co5idr2o4qizkDnULiQ0aQyCM8KWWUMShvMSSZZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgzLxQU9eru5lbXRrEcL5/88t1p//PZ9SfS8ZkDzCZhy80kn1
	+oJHoClCEdgAHKlbnJAN2FjMnd3Dc5PEMASZW9Y8I4tmEYQmSlFySI99n3k9xwCpQ4lo8Wub+5l
	ActDniAycZFmscUQYwiOtO+mgin221X8xoYNN
X-Gm-Gg: ASbGnctangK/6Ey34BrWHy4Ymsl57+FfF/3jQgvazA6gTVJfUokyfS4vNPynLC81H8M
	+cmGjJdXLeHYluWtZdlE8A+KYgai8HAZsIwGW8mOtKmjkHmXDx26t7OMwmf9teUoXwuzrhCJysf
	mKA73eh+x9UR37dT/mugF74t6/ZVZu8C85suqDlybEArGiTO6vO5fk1W0=
X-Google-Smtp-Source: AGHT+IHBWyPFsx3QeUc6IdoeHIYFTrIvYvef70j14jedqTuNmPWl2CL7e6SqnTvD3LR9P4A95or3uELGCPRHdEcd3Ho=
X-Received: by 2002:a05:6808:320c:b0:3fe:aedb:7a1e with SMTP id
 5614622812f47-3febf79a9c0mr3078021b6e.4.1742828006273; Mon, 24 Mar 2025
 07:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321032627.4147562-1-jeffxu@google.com> <20250321032627.4147562-2-jeffxu@google.com>
 <CAMuHMdWDrByGrgcTK9dRKRJyQ3ecQwadJjCcW=Nd0SjUeEukpg@mail.gmail.com>
In-Reply-To: <CAMuHMdWDrByGrgcTK9dRKRJyQ3ecQwadJjCcW=Nd0SjUeEukpg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Mar 2025 07:53:14 -0700
X-Gm-Features: AQ5f1Jq3gf--eO0JAHMaBIJnqixFJiGbf1XCTFaxigbe-ZoS9oaIhAP6xq7hHEc
Message-ID: <CABi2SkUGLRb=WZMzDhY-8-hcTN_Rc4gxmGmksD2kQtqVcB8eRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Liam.Howlett@oracle.com, agordeev@linux.ibm.com, akpm@linux-foundation.org, 
	borntraeger@linux.ibm.com, edumazet@google.com, gor@linux.ibm.com, 
	guoweikang.kernel@gmail.com, hca@linux.ibm.com, kees@kernel.org, 
	kevin.brodsky@arm.com, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	m-malladi@ti.com, svens@linux.ibm.com, thomas.weissschuh@linutronix.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert

On Mon, Mar 24, 2025 at 2:03=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Fri, 21 Mar 2025 at 04:26, <jeffxu@chromium.org> wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > @@ -0,0 +1,30 @@
> > +#
> > +# Feature name:          mseal-system-mappings
> > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +#         description:   arch supports mseal system mappings
> > +#
> > +    -----------------------
> > +    |         arch |status|
> > +    -----------------------
> > +    |       alpha: | TODO |
> > +    |         arc: | TODO |
>
> N/A (32-bit only)
>
> > +    |         arm: |  N/A |
> > +    |       arm64: |  ok  |
> > +    |        csky: | TODO |
>
> N/A (32-bit only)
>
> > +    |     hexagon: |  N/A |
> > +    |   loongarch: | TODO |
> > +    |        m68k: | TODO |
>
> N/A (32-bit only)
>
> > +    |  microblaze: |  N/A |
> > +    |        mips: | TODO |
> > +    |       nios2: | TODO |
>
> N/A (32-bit only)
>
> > +    |    openrisc: |  N/A |
> > +    |      parisc: | TODO |
> > +    |     powerpc: | TODO |
> > +    |       riscv: | TODO |
> > +    |        s390: |  ok  |
> > +    |          sh: |  N/A |
> > +    |       sparc: | TODO |
> > +    |          um: | TODO |
> > +    |         x86: |  ok  |
> > +    |      xtensa: | TODO |
>
> N/A (32-bit only)
>
> > +    -----------------------
> > --
> > 2.49.0.395.g12beb8f557-goog
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
Thanks for your expertise! I'll send V3 .

-Jeff


> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

