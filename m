Return-Path: <linux-kernel+bounces-529947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94FDA42CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403271750EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58E1FFC6F;
	Mon, 24 Feb 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaH9T0ST"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21438DE9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425659; cv=none; b=GtVt0+iHM2EPXGmijpygzMy4IFf6QZbOa5wHlh0dCJZ7BQoPd5QRKG/kBpB/TJhoZwaig4Tf2A4HxHC2aXx20grMocVBZey29AM3HjtcB8CvPaWZcFGwVTPj1H+oBvcH7oqEJ2Ah/Zve7mdCIFiewLe/ACQbjNRK5GxQDnUddMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425659; c=relaxed/simple;
	bh=ZNAJBzjfq6uYqRLXpoJyrh8DGBBLa5628qhsEzaSUHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFDVcxgRuJOJAfOEk22BOWsUJ0kzrsYdLlttULj7a/RpmIouymmEjp+kyU40GYbERQFiFHteHoXqaZ0CiJEsxg5ZIh973p2ea2nhVMTZdnoFmIaMzMdfzkuEESUxcBCWOdwbrUwSyGZfLJgHQ9WeLr0kfpzI0AjfCkD6OD3MLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NaH9T0ST; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f401d3b7a2so106281b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740425657; x=1741030457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQY6dOosAcucIiRDQdMzsS+fL5tcNzoRGW55wAAQqwA=;
        b=NaH9T0ST7thZR1yZpBqvdhLxdmbViMCj731Q2fRcrVKvJACCSZOU5vYFEKIf8OLd+Z
         +hvGSqU4qeZX/PA5YZzfblp4aFfbU9V9yNDjRS41EKj3ndOQzJUwTRjgz0hq8+CGy6yX
         Hm3rhtL7EShD9xpeO4GEHQHGd2k6s92bpbOYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425657; x=1741030457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQY6dOosAcucIiRDQdMzsS+fL5tcNzoRGW55wAAQqwA=;
        b=jM9ATOgq/BijJMnueOorHGoNPUA6dVPzcXXvzLifpmwxkMqtlw08L+ZCE04XgShzYu
         plcRBef4lYclninN3Q2WxSACfCrAArgHslr3TO5ERt1IJctu4NAiC/d0+K4idy3uKh05
         BVzPygVXHHfVWQY+IabifRLP02W+u1Q0Euxjn4kkMNpeRDcGC8SK4zOH8Jyw3L07nBKa
         eeR53rvDOFHzJun+HoXa2t8OxHCWg6m2Y3unMxWv/5KwvhxaqpWA/aRQjxseqmaS7Roi
         11sJOzUFf4sxAJ7XC/zdLf8tRH8Mfg0cZgJHVa0BA9LjyRlxUCuHPxunij3yIW7meWRW
         vQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUI/cgc+Qrm5QfEqshXROf9iD3kJBSNXjlsJv4LoO7xplCfDWko/kuRc/7EMynKkdylL7cmFTWZYcY1fhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2zm2tK8/znwB4eSNz32IM+fp306Fum4mazgvdQE+aAlEHzbfC
	2wVIkA+GE2EoTZtNGOCUhzzzGYu6stzkl99SvR95Paps3xkEqkNaHyLlvFtdPZfiqBqIjf4ayAE
	SyO0quhYe42+YMEtCI+pxtwQju5zlvlDe+c3e
X-Gm-Gg: ASbGncs2Ld13NgmtJO0VA4aA22m0t2IA6jsM4m8iyt9WNWf+8/hqm60vcmx7MCFRlnx
	xLQu7+Op8ZlT7WsAFLP9CE8h5YP0h6ubod5NdpH9y0ex4xt9Q/XnKwOHJPfHCA+XbLVB7rikkbE
	T2VH3yJPWvetlB19T3zFHqA/VTeR8t1Z3TLyYL
X-Google-Smtp-Source: AGHT+IFsKQI/wA+4sHfEV/I1olQBkEfue3loUdNFzmEYTOMnz4MZXEFiZGBxlenlf0rK5hXvgVztHBZRVg4eMn9wabc=
X-Received: by 2002:a05:6808:178a:b0:3f4:cf:5d7d with SMTP id
 5614622812f47-3f4247c0d9emr4328678b6e.7.1740425655952; Mon, 24 Feb 2025
 11:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com> <202502241053.1FF33D5B0@keescook>
 <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7> <202502241125.75EF4FC783@keescook>
In-Reply-To: <202502241125.75EF4FC783@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:34:05 -0800
X-Gm-Features: AWEUYZlICjQ_BKj7NOI18C7IZh1axQsiUlF463h-YGPwCWcvEopchlkyDHgqfEE
Message-ID: <CABi2SkXLFnfMkZ8xjxiu6Evcvk_yqNt3Yw9Xm0GXbTKMdi2mrQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: Kees Cook <kees@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 11:26=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 02:10:58PM -0500, Liam R. Howlett wrote:
> > * Kees Cook <kees@kernel.org> [250224 13:55]:
> > > On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > > > On 2/24/25 10:44, Jeff Xu wrote:
> > > > > For example:
> > > > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/ta=
sk_mmu.c,
> > > > >
> > > > > #ifdef CONFIG_64BIT
> > > > > [ilog2(VM_SEALED)] =3D "sl",
> > > > > #endif
> > > > >
> > > > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the prob=
lem
> > > > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > > >
> > > > > Please note, this has been like this since the first version of
> > > > > mseal() RFC patch, and I prefer to keep it this way.
> > > >
> > > > That logic is reasonable. But it's different from the _vast_ majori=
ty of
> > > > other flags.
> > > >
> > > > So what justifies VM_SEALED being so different? It's leading to pre=
tty
> > > > objectively ugly code in this series.
> > >
> > > Note that VM_SEALED is the "is this VMA sealed?" bit itself. The defi=
ne
> > > for "should we perform system mapping sealing?" is intentionally sepa=
rate
> > > here, so that it can be Kconfig and per-arch toggled, etc.
> > >
> >
> > Considering Dave is the second person that did not find the huge commit
> > message helpful, can we please limit the commit message to be about the
> > actual code and not the entire series?
> >
> > I thought we said that it was worth while making this change in v5?
>
> Right, please minimize patch #1's commit log to just what it is doing,
> etc, and leave the rest of the rationale in the 0/N cover letter.
>
Sure.

> --
> Kees Cook

