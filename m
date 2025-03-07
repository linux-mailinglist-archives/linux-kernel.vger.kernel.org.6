Return-Path: <linux-kernel+bounces-550660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15124A5628C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C2218951E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FF1B86EF;
	Fri,  7 Mar 2025 08:28:25 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FA186607
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336104; cv=none; b=AqkwzhoaHMjvT7p3mSxuUt8q9Et0iVREBB3ttX4YEpVXhe4n1/qji0R2DwcR5GB8JroDt7YPVUuolVfyfRHivqNdCnky34/vhZ+cVCmnqkRwTMZI3vtzZSD1nzreaxqW8zQkATOqb7tWN31DaxxFXPrn2nPi36Ngxo/LTiZi4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336104; c=relaxed/simple;
	bh=RLW5W7vE6eKHVXzzEER3TJZBcheFUauQWYUYHYGJdj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ahmw9ZySbnf3HgpO2gdSx6Lj0kg8FNmYZfMmmjS0uU2KHurgj9lpjO4NDiQJSqCtirO226qe8+KW2Mup+OGaZcT7nfEX4nl8u+oFfHBR5SZNvpJ7d3K7X/BGVQJfFmow5gY1lousun6spuZnGbkFfSX3LSzP4OhkxVdT+Gi7a1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso671983e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336101; x=1741940901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xum+DVk/hz2H5siGnkfuO3VHERgZhJbJ0D0R2U7DBis=;
        b=Yf/8NEAHkZ2dya1RRuV3gyjQG1sHvBWMyHvT6vJpOyaCXQ+B89LNn0rGdP9WzHaow4
         /S2ESgUi63rXgU23X4cKho+/yhQMLslYNTd4lPzp/i4ZjJXuf6OY9K278dkaUC2xschK
         kfeV8PDdRT9AvrjWZ1zgcV57yfjIcMGbxyck/BG0f7yx9vZ4AElTzlRJx+NKNUNStaiH
         sKJk90F4nSAgWrSWvulvIrwXhfciXSH5bQsr4V8/DolKHE1IGpxAedmWL4oioaFottia
         8ZiVHKtt8pJ44FoXPZJVLArGk69lkyTNrJ3JCddW/fVYJCPHQXAj7SZ/+MozCLD39cNs
         OtPA==
X-Forwarded-Encrypted: i=1; AJvYcCXaaw//v/phUpuHsckicVioyawUKORNUqmcby2A9gw1+GsdNg8mekAJSBApbTPlb9Omc9tjBmCVf77XW7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGRyn/UMyouL5tiq+YcLbVMoMoTiRFU4UZns9JmnpeGZe35y0
	laVNhnfzImkRez7GyhWulaKZdzdhqvRluTd7mIUdr5uzoXhRhqTtWkMSlaoR05E=
X-Gm-Gg: ASbGncu2SCGiEpDQ/jHNx8KjeKRhnyq4J2oNZ66t88hgEGrb2XpJ/FPoNmdUZZsZabZ
	vIy2VZicnP3MIHPvej4YitRfdDlI0qJ/vmE+IUvoeuza1XU7cuRKREQecRRXtUdUAh3rTaoQU3Y
	cfKz+QocYgta+XvBy6H/Zj3nfVDyAEhRABh+RiagTBXIiVTQjtXdj9R4/PD4x0pISH/m5mYv6AN
	Qw7Ni4jVYSjzUD1i10qsFBFvXXGz8t3Iv7lIw29P45gyJtL6B6Jj8K8UJm+xL9iK2RXX6HiNB3p
	WKvmduzIEors10VtllqJjqwjieQ8IANZPPXYQrKtLrQh8Zee+CtEjYwk7uqVG6jp+9dMJ7FNKgf
	1/Lyw7iY=
X-Google-Smtp-Source: AGHT+IFoZ3sqq81yMs1WB95I9u+6kobMfzkR8Zo9AkCZ6l6IlH/u8NxFumWIH7ei2xgF18q8zbPBPg==
X-Received: by 2002:a05:6122:65a8:b0:520:6416:56f8 with SMTP id 71dfb90a1353d-523e40245e9mr2230174e0c.3.1741336101302;
        Fri, 07 Mar 2025 00:28:21 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8cbad9csm445410e0c.43.2025.03.07.00.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 00:28:21 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86714f41f5bso667181241.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:28:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0AJNbrA4b8BBt0Fbeg7T80ncitcymfB2Jjon6UcpBpTGre6G9Yj9Giu91vwxxrLr0jv560ZWgUlz/+yE=@vger.kernel.org
X-Received: by 2002:a05:6102:38cf:b0:4bc:82f:b4e0 with SMTP id
 ada2fe7eead31-4c30a6d240emr1447532137.22.1741336100864; Fri, 07 Mar 2025
 00:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302230532.245884-2-thorsten.blum@linux.dev>
 <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com> <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org>
In-Reply-To: <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 09:28:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWjOkUXy+jf0yghs2_SQM3UWY3e8or3T11=fXYYD-VJEw@mail.gmail.com>
X-Gm-Features: AQ5f1Jr2qcPxvP5d5iuyyv-KmQbBRQb47zOza6WWuoy8m5L3ptAnJ84hV5gOB4E
Message-ID: <CAMuHMdWjOkUXy+jf0yghs2_SQM3UWY3e8or3T11=fXYYD-VJEw@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
To: Finn Thain <fthain@linux-m68k.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

CC Kees

On Fri, 7 Mar 2025 at 00:24, Finn Thain <fthain@linux-m68k.org> wrote:
> On Thu, 6 Mar 2025, Geert Uytterhoeven wrote:
> > On Mon, 3 Mar 2025 at 00:07, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > > The size parameter of strscpy() is optional and specifying the size of
> > > the destination buffer is unnecessary. Remove it to simplify the code.
> > >
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > i.e. will queue in the m68k tree for v6.15.
>
> The commit message says "simplify the code" which is only true if you
> never scratch the surface (i.e. it's simple code if the reader is simple
> too...)

The code is simpler in the sense that the API is simpler to use,
and harder to abuse (i.e. to get it wrong).

> Commit 30035e45753b ("string: provide strscpy()") was a good idea. It was
> easily auditable. But that's not what we have now.
>
> Patches like this one (which appear across the whole tree) need reviewers
> (lots of them) that know what kind of a bounds check you end up with when
> you ask an arbitary compiler to evaluate this:
>
> sizeof(dst) + __must_be_array(dst) + __must_be_cstr(dst) + __must_be_cstr(src)
>
> Frankly, I can't be sure. But it's a serious question, and not what I'd
> call a "simple" one.

All the __must_be_*() macros evaluate to zero when true, and cause a
build failure when false.

BTW, Linux does not support being built by an "arbitrary compiler":
only gcc and clang are supported.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

