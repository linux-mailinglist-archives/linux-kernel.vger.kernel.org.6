Return-Path: <linux-kernel+bounces-408088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4D9C7A51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0028D1F23522
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE37202638;
	Wed, 13 Nov 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAPk5E7i"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7F2AE69
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520461; cv=none; b=h9gvL3xy+ukVPh6V8XFFzIRYkOHp/bv9LgbjYzWJCvhncTPG9agzvjbNP+pyWk3g68Pzuge9eorExzuJ83tfeUc/vLCoWqsbtbqSH1/4a0dXUcrPnQENV1ASBg2YfFNeTbpv3MOuSNIxpjxV40iGCtGw6mN1NAMconj2d9tM2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520461; c=relaxed/simple;
	bh=GLNEdJnIJ8LZnbahpw3kB6Ri67YbLsla73/1yEoh83E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmnP0Ve+JEr/ynaI0W6riDRL9o7O9RSnkf3N5dzklWirYsrT7tw9eR3gUKzpakGz4MxotleVb85MgtwbMqVno9Z62gueeAcz9zRt/z61IeYg48WNvmRCO8hNoF+VX3rdDW+0tcJRuyHqCK7tNbBQztKPpC3Cxyj7PznZzuxitpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAPk5E7i; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so9264a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731520458; x=1732125258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY7wBsUbdQcWggybLDq37KJ8DaxAj5d11PMFbvDEhAw=;
        b=hAPk5E7iPdRGDjWTmDRRHcxYpnDfw+d86PJtJkK9kPXpYgcAGWBnOh5J8LTQf3juXK
         ncOnA0KbRXw2OMxatjtWQRRfg7RR3fZM5YgHCzIWPVXgrn+Ba4UYr5hnmXc3E8ShBshL
         jRe9+PUp0g9kTFXkEt31FcOpGFxqZRUakp+0LwiyrlM0ycmpMUkzGZJHf3ANlpr3PMGh
         8l0scIbHmGUsHR7q0EaOTd/FCxikK9xWs4X+m6T08czYuaJLpbDpKU4/C76yw0pxwEtp
         02EPuiyVLzOvKGSfGmEe4XePJgaF5OQCsgmzQketJJbIkvnyfn/sOAQmkfGfcAJxOBYV
         eu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520458; x=1732125258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY7wBsUbdQcWggybLDq37KJ8DaxAj5d11PMFbvDEhAw=;
        b=g2hVSOETGE1THbkb1jmVkTAMtGLZrySwscUx70TuPAKwz8FNFdrkLM9wEUcX28wshH
         v75eWRpg/tUUk4HDkacG2L4LiUkrxRVF7w2YJOH83EfV/Lh5wVoBUIXYYGQ6JEjsunWS
         iqPyK2f8g6GRp3ZCGHT+QZfM8XOyGnXmhgzvmrRasZqngReuR765dEomiWvYL+OjIxOA
         AovAPXAlEXJqFafOJah5yCoh21ZKU9GIFDZg3qxbgt21I9foq+LaFjJBWBCRoAc/oNmj
         31aK5CpZcyWMTa8NuasDnh3XvM255K6HjqEWVTib3TX//iqGRD59gUaupSBPpidRyxjP
         o6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUKF2OKIQPTMuJ1EsO38IPNGxYpA7i5fKq7zg5m8l9GWXKlkUD4sSIeS77G9FWE6mrjj2/L08K9V/VN30=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZ9/g0PXRQv559TOqdheYJEHy8+iMj9AxajmkSE0cRd58SrSa
	xQvOziGs7x3INygElRdjG3J5oo2Yf+bHD94DayBPi5hVDjgaM9DwU4j9h17l33mqBYk9tnnfJSz
	ZEScSJmA7D/HsGh3yG+xypwRqhkOPhk2AoTKH
X-Gm-Gg: ASbGnctkuiqfpx3qkRIjlu83CrY9vqambXDFdkc1iCt70gQgbefhTz13AfmtLFtml3T
	cs3sUhkw0GN51E8ZexTYmIBU+4rkB
X-Google-Smtp-Source: AGHT+IFXLnHsfDYTpS01K6b79CsIuzgS6MULqvEjuFdWIkvmBmxgPffAF9QVNOOGzikrvjwjQEp2QY0dMQ2TSECyW3Q=
X-Received: by 2002:a05:6402:5308:b0:5cf:659c:abb9 with SMTP id
 4fb4d7f45d1cf-5cf659cadbfmr209409a12.6.1731520457717; Wed, 13 Nov 2024
 09:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com>
 <20241030170106.1501763-22-samitolvanen@google.com> <CAK7LNAShVzrE6uhXxZ7HepKhmOJYsZeigq6w19jRN3OH-T_Jyg@mail.gmail.com>
In-Reply-To: <CAK7LNAShVzrE6uhXxZ7HepKhmOJYsZeigq6w19jRN3OH-T_Jyg@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 13 Nov 2024 09:53:41 -0800
Message-ID: <CABCJKueVjP8V-=3Ehi4QvQzg1FZh2unyVMDzSJ_vJ_E5EE+gLg@mail.gmail.com>
Subject: Re: [PATCH v5 01/19] scripts: move genksyms crc32 implementation to a
 common include
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, Sedat Dilek <sedat.dilek@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2024 at 8:06=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Oct 31, 2024 at 2:01=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > To avoid duplication between host programs, move the crc32 code to a
> > shared header file.
>
>
> Only the motivation to use this long table is to keep compatibility
> between genksyms and gendwarfksyms.
> I do not think this should be exposed to other programs.
>
>
> If you avoid the code duplication, you can do
>
> // scripts/gendwarfksyms/crc.c
> #include "../genksyms/crc.c"

Sure, that sounds reasonable. I'll change this in the next version.

> > Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Acked-by: Neal Gompa <neal@gompa.dev>
>
> Does this Ack add any value?
>
> Acked-by is meaningful only when it is given by someone who
> maintains the relevant area or has established a reputation.
>
> $ git grep "Neal Gompa"
> $ git shortlog -n -s | grep "Neal Gompa"
>      2 Neal Gompa
>
> His Ack feels more like "I like it" rather than a qualified endorsement.

Like Neal explained, an Ack from a potential user of this feature
seemed relevant, but if you don't think it's meaningful, I can
certainly drop it.

Sami

