Return-Path: <linux-kernel+bounces-400548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9DF9C0F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DBB1C23E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32163217448;
	Thu,  7 Nov 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikLmlUL8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B382C60
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008284; cv=none; b=u1nBplazE235NZhNNVlw1kl6Rhg39zg3O82U52Hbisd96epbl4vNDDNC07yU9F20Qj5ffsut3Zt3luX4oFHLQB6KAsWzgpKCssGyR0J/Oi/Rayr3H0RJWwTPzxDknBAGyMCV8b+qfjy2lf3nCLcCCeAKV++G4mpUq+2BVd89AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008284; c=relaxed/simple;
	bh=OQrBkqQtsvfo3sVV9/HnVk7awZnGrUeB4xmdydHvXaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAwKGKWFsi9vZeS3o9YLM0Fd5+A/4yTvNPKb3vMRMbvUxKXxKBdSJdCdSQkO1ahRda291tSmvXqyigS1w2yLCj1iOCScdZ2yqBQq8djw3GKafkf01rw59fjtetHBM7wl2Zvey598BVkw6frO0XJ/mSdu3JKdmAuL/3HBe3nhQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikLmlUL8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e617ef81so3069e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731008281; x=1731613081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOj8LMAazYpTjfu5mrOLk8RCDPLc0j+wCQq6uBtbnSs=;
        b=ikLmlUL8cMVInuKhbMVsSZ6FYcRVXAPcqIa6caRCNNnnltidGQfGESUsfQi9R/0MMZ
         07dyYLEBiy0kOaL3osXflyrNIyTPUeHq+eF20jKcEeSJ8N8LT2klLl0+PCwPGMum1bSw
         ox6o2/VEtFjgG6U44kaxHuWOPNbYC4ApJ7FHbKHEziOsWdL0OoemeNXqyNpqHRjeEgeA
         zZhK2ZDSSaEWXdnevPUOsS2obHBPyktma3j5Jg/TZVt0s8ahkEBmxUWAXJ3PeFGKJW6A
         ry1qNWnCym5xjGHdgci4hYYfTXKR7HaaZp9O+9Q8GpyhqWB6ZteGbLhxROB3fpF4794a
         q5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731008281; x=1731613081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOj8LMAazYpTjfu5mrOLk8RCDPLc0j+wCQq6uBtbnSs=;
        b=glcgL87k6D8Rg9GVuwOWLM55vYavTHgT547M1ALMA5W/XTWMAlvv75GTwzFm3o/EcJ
         tUoKmXNpl5JEWScxMIYVfAuk12UmoqiKbzGDVlbAzD+37rx8+ZewGgXSPLlj7kWMurb8
         Buf4nov9T+5G1Nm/QpysYlwRFje/xfOD0VQENhdb24Ytey21jwnmXeH2wSO6jqUFCXJi
         AagRx1Y+tnTzKmMex+ou5maQ7CHJhSrI+nxZ/WYP2i9j3Fnt+w84jcYfzWCdzn4ST+Ye
         doLO9pviKSu4+EDIdBYGXL5jKJnq7vicWKPEEQhXwq7YNtqs9RZsSidYjYJ5m3K7nf9j
         lZFw==
X-Forwarded-Encrypted: i=1; AJvYcCWBmzcqYPfFihkGNVWdGjjMlGazLsUH0KDFkDWVLmM3nu64Gn49BzM6cS8yJF52hDklno4ayCQGW++e42g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdr/Vbji7JTVot5M2idJr34GvFF4E2pEyRNVE6AtmXQtZ6yTL3
	3xYGmZEEVKWl3kkESZZalLjMkAsPhsClfTxr+xJshxZ5UghaVuJANU6DwcwlQZN2UNVTJ+P+ZoA
	eakb4HH4YU80Rfem4Cj7wzSxaUDd1ZN9UM9hk
X-Gm-Gg: ASbGnctXFeV7k0Z2ENZidbRkGrHdzrjmBAPxXO7GAsVRYjafvHhgsPxfwy7x4uc7VyC
	c4ou2uG4psocZTEeMVt3N4np0XCpAn2Drb88K0qTIxp5LTrygSkZ9vpXLZ07ODw==
X-Google-Smtp-Source: AGHT+IGExvGXqzYeYDQ4rDspkwVFg2PIUqBXwcbJS7a2hiTewgKwW0pQmiUCGPl4ZzxqFZQAq3zzHYeO+DEmkcjl1iI=
X-Received: by 2002:ac2:4e44:0:b0:53c:7652:6c97 with SMTP id
 2adb3069b0e04-53d811f1d2cmr340579e87.2.1731008280784; Thu, 07 Nov 2024
 11:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-2-93acdef62ce8@google.com>
 <ZyNr--iMz_6Fj4yq@bombadil.infradead.org> <CAGSQo00F07viDHQkwBS8_1-THxJHYwx9VkS=TXC5rz3i8zSZSw@mail.gmail.com>
 <ZyVDv0mTm3Bgh1BR@bombadil.infradead.org> <CAGSQo02uDZ5QoRMPOn=3Fa9g5d+VPfKW-vmSsS2H+pOdPYCBFw@mail.gmail.com>
 <ZyrRYUD0K1f7SwWg@bombadil.infradead.org> <CAGSQo03+1WjUVj-iQ6zdOST6z=p+=OqS2Xk_c4ZUdHOsxa7g2w@mail.gmail.com>
 <hs5fxluchiconuonhziu3qh2ol5bsdxva3cuny2mit4i3equzt@ieueiius5x4w>
In-Reply-To: <hs5fxluchiconuonhziu3qh2ol5bsdxva3cuny2mit4i3equzt@ieueiius5x4w>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 7 Nov 2024 11:37:49 -0800
Message-ID: <CAGSQo00H+K-Sr1F37N27RutWthYRd0o4QbP_Z-kfWwb65L+Kxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] modpost: Produce extended MODVERSIONS information
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:27=E2=80=AFPM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> On Wed, Nov 06, 2024 at 02:19:38PM -0800, Matthew Maurer wrote:
> >>
> >> > If booted against an old kernel, it will
> >> > behave as though there is no modversions information.
> >>
> >> Huh? This I don't get. If you have the new libkmod and boot
> >> an old kernel, that should just not break becauase well, long
> >> symbols were not ever supported properly anyway, so no regression.
> >
> >Specifically, if you set NO_BASIC_MODVERSIONS, build a module, and
>
> how are you setting NO_BASIC_MODVERSIONS and loading it in a kernel
> that still doesn't have that, i.e. before EXTENDED_MODVERSIONS?

That action would involve e.g. building a module against a 6.13 series
kernel with NO_BASIC_MODVERSIONS and trying insmod it on a 6.12 series
kernel. I know it's not supported, I was just trying to describe the
full matrix of what would happen differently with the proposed
additional config flag.

>
> Please Cc me on the format change and if possible submit the libkmod
> support.

It seems awkward to adjust kmod to support a format that still hasn't
been accepted to the kernel. I can send kmod patches to support it,
but since this patch series hasn't been accepted yet, it seemed a bit
premature.

I'll explicitly add you to the format change (patch before this in the
series) and add you to the whole series in v9

>
> thanks
> Lucas De Marchi
>
> >then load said module with a kernel *before* EXTENDED_MODVERSIONS
> >existed, it will see no modversion info on the module to check. This
> >will be true regardless of symbol length.
> >
> >>
> >> I'm not quite sure I understood your last comment here though,
> >> can you clarify what you meant?
> >>
> >> Anyway, so now that this is all cleared up, the next question I have
> >> is, let's compare a NO_BASIC_MODVERSIONS world now, given that the
> >> userspace requirements aren't large at all, what actual benefits does
> >> using this new extended mod versions have? Why wouldn't a distro end
> >> up preferring this for say a future release for all modules?
> >
> >I think a distro will end up preferring using this for all modules,
> >but was intending to put both in for a transitional period until the
> >new format was more accepted.
> >
> >>
> >>   Luis

