Return-Path: <linux-kernel+bounces-537529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA1DA48D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731E418909EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE59629;
	Fri, 28 Feb 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kvic/EVZ"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694C17E0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701060; cv=none; b=cHIK1KBOj0xFwXiXLrRm5Y7Zu/avhBzM6U7uiwnfmb08wUvpSRvvAfTbcGf3C/3oeaGV+7qkYK9HKfChU45u+mRNKeJMC5SjDYhkS8nZoGQk0YgMQ3B3sXuF8OfW9HkJvKuPJxHay8ClelsREPLYcoPoy3wA517hqquJYSpYjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701060; c=relaxed/simple;
	bh=PEcWf1lC0yhjFwXmZ+djf4p4vdM62eIMsikl4LRYCy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGnAjyTCkX4jL+WawwiKjjX4kt0sDSnxw0JQmGJT3KjKcC+YHEJkpm+AHcXN0yqo+Uddo4yIB4O9799gqwlZTzgoc0uzOUptjTxwNeamqaT4KJ8IGoFIb3ARHNDBLWxlp9MHwV3a0eBy0w1J1OtRGt8Lnf9omqSTEvexPSs7P34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kvic/EVZ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fc6f75aa8aso81190eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740701055; x=1741305855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdAKRoI4MWNZS1p5ikuwofSWZ+m+ABE0cVc0cuX4/8s=;
        b=kvic/EVZUyZ01lsS213y+Wl0oiYKgD0Vo8fZTu7yhfIAMYA5xRc73CCZ9KgNHmlum1
         4XMttEnng3BT+pAKyh4jyoxQ5670+ma1MshtA55Zj86r1O++pRV8ZCe9VGxhyJyRMug3
         oM3cR/g7oqnk4IuEPyEftiTC6GOKs4akHMpZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701055; x=1741305855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdAKRoI4MWNZS1p5ikuwofSWZ+m+ABE0cVc0cuX4/8s=;
        b=mP+F+sfcwRI5PvXCeK23bOMDHi4RUkxjbXueE7YLSezVAWz4b3N8MY2e/9BG7JYXxM
         4JUkPIJM+LFyV+An5GM3pAC57jIAYMOYRKAISCq1sxS754f32JC8Uy8WC8DzKllw4+W+
         72QlActhChljJODRSzuw2NZu7dv+gKQQwD+dxkCdVwOa3APWUZyHYpvAiKIZjggB+WfG
         nWWFVI9ZU8URexPPq9RUTnLe3abjaq7JkHh6qZHE6nL5+z9kqyF0oF3edaEJrXEkz5xw
         LKgyvziH9S98Xo4Atmn4HXgTkWJ1MERWzUJIz0Ol7QQQD/TYFcQ/sezFZ64iLN1fCug1
         ZpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7NArF+lH1fWsDODfuYYpKjMXE8OIR0yB+CqeeXiUstu08RwKYko4ATqhqZzs9eANkgh58Gy68YjDjGH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAm2ct92GyNmfKOMuV1w9CRsY0zAaGanUVftqolbmdZ9ykdmGR
	VvM0lLaZAqwAbu9vljKLEC/ISeFDBRKL2H7sALTZRrMclTRO+sBmmklGy9w5KE9CdW6L+3ak1vr
	oLUjuzNXe3yiYEskRO4rPLhag74xIXwuphhGu
X-Gm-Gg: ASbGncvk+gwu0KFd6GxXsLGItwwn0R53+MJFDyIxcExuuC5YqOa/UkTIKTHVII38gA5
	VyyhQBXxxNEco8YFAy8KUZL4lxg+dtKtUrIq4NcDDe6tUmWgRx1HqRuOSAvra73lgME0L6IFdOP
	H/bdeKADnY8z5jWCRLZtE8K0GhmtqUVp1d8KX5igzO
X-Google-Smtp-Source: AGHT+IGWuXQs0PIThChSzMMhBYpO8F+O5v1PgymX4okVh9IJ0FU07Sbjp0HW52pAlPT3tSirmglti/FDlIKqYQSJ9pg=
X-Received: by 2002:a05:6830:6c0f:b0:727:2f27:2a5d with SMTP id
 46e09a7af769-728b82f0b63mr269890a34.3.1740701055553; Thu, 27 Feb 2025
 16:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-2-jeffxu@google.com>
 <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local> <CABi2SkXT0z9YFsEkf3-HH0r_NuXXs_SJid9yzjuu0SwuxxWmZw@mail.gmail.com>
 <b7a38abf-f102-47b4-b085-213298c51aae@lucifer.local>
In-Reply-To: <b7a38abf-f102-47b4-b085-213298c51aae@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 16:04:03 -0800
X-Gm-Features: AQ5f1Jq9-ymrZNzxRItoW5EEM_7nmfT5SZHdmMKzLXHDq-gTSSV1Cci_cu2NaII
Message-ID: <CABi2SkWeXJXmuE8OETJvbmxzGjk1e+5FUT9Gi2ZC35M-TcZWEA@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header change
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:04=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Feb 25, 2025 at 05:33:24PM -0800, Jeff Xu wrote:
> > On Mon, Feb 24, 2025 at 10:05=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > > +     bool
> > > > +     help
> > > > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > > > +
> > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > +       No specific hardware features from the CPU are needed.
> > > > +
> > > > +       To enable this feature, the architecture needs to update th=
eir
> > > > +       special mappings calls to include the sealing flag and conf=
irm
> > > > +       that it doesn't unmap/remap system mappings during the life
> > > > +       time of the process. After the architecture enables this, a
> > > > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage =
access
> > > > +       to the feature.
> > >
> > > Architectures also need to be confirmed not to require any form of VD=
SO
> > > relocation, which as discussed in previous series some arches appear =
to
> > > need to do. I'd mention that here.
> > >
> > This might need clarification, the system mapping includes vdso, right
> > ? Why the focus on vdso ?
>
> My mistake, I thought scope was more limited than this when I first
> looked. Please disregard the focus on VDSO here... :)
>
> >
> > The sentence  "... it doesn't unmap/remap system mappings during the
> > lifetime of the process."  already cover what you want here, I think.
> >
>
> Right, I guess it just doesn't quite _emphasise_ it enough for me. Someth=
ing
> like the below would really help bring that out:
>
>         The existing of this flag for an architecture implies that it doe=
s not
>         require the remapping of these system mappings during process lif=
etime,
>         so sealing these mappings is safe from a kernel perspective.
>
I'm not sure I get the difference, but I can add it,  is below OK ?

To enable this feature, the architecture needs to update their
special mappings calls to include the sealing flag and confirm
that it doesn't unmap/remap system mappings during the life
time of the process. The existence of this flag for an architecture
implies that it does not require the remapping of these system
mappings during process lifetime, so sealing these mappings is
safe from a kernel perspective. After the architecture enables this,
a distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to
manage access to the feature.

Thanks
-Jeff

