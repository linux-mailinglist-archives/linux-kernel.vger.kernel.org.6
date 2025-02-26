Return-Path: <linux-kernel+bounces-535123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CAA46F46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7FD188C3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AF2702B7;
	Wed, 26 Feb 2025 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EW66coPp"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E172702A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611836; cv=none; b=qdhniakJ2a9CSgzopYAnmfQo5QTSudfUBk80lNKKen4h/qe0iogypVPmXxvsN1nHvK5LcjluYCFUpnMD5swICCJRaz07falScWNxHc3dBE2hP2dCsKfxmTohrjD2/q58DiD84qgflqUk0lZan7YsForRbtNPkZ3hGkGJW+PPtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611836; c=relaxed/simple;
	bh=XarU5AoRc1EC+DeSSkq4KJpi/IJAWCVURI1rN1QDT3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZQZK9O2+VqnB3NthFMTbjjhJMHmXgacGJ1D6mQVqpckgJGShNUnm2VhyN6idMlinMR1JAwoqFvgHgIHwwTEU8ZoOp/qPi7Og2aE2V5pMFOXBHTY0y0enPDwEOI41vTzu3QEzX2Y36GgLGTy6PDPn9xdXWgRemOjD8bKdckXsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EW66coPp; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso373855a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740611832; x=1741216632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IuzhV/0JqnZbj1q0brkRQlbfU2Wt+k1TRbEteuusQss=;
        b=EW66coPp8X92aElPZcMPoz+YSP9DtZNTOOWIIXAfTKM7kIDuvFS4gv2FMOPJeVQULY
         m+BqzgFhyUyu9BJl/lCXNavOj1sCLcHWcSBep5x+oJ1MyKOuWHTLuJf1kpEOKSup+aK2
         4T6YlkRPgwPCaUQuY/bn+mc85s1lXoQRtjZtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611832; x=1741216632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuzhV/0JqnZbj1q0brkRQlbfU2Wt+k1TRbEteuusQss=;
        b=u3wAUn96gY7fwPzJq02rfZfxCoxG4D+Wf5AbJUIw7tkJKXvq1cLlJA4hyDw8Glqzvd
         dEeDVRwZFUK+M4JIowXWG2Gvh0XLxRNYkdrwN2Q5+/+vjiDRoHNxlKWHWWpQqJkE+mnR
         2xosGTppKZ3wdSBhIbDA4+kk4Xm/B++VVtnXiHm69VGMIQx2jQvWgwg1pscb68sZIV3m
         SAlTh8xTL7w6VxaKzyWXzrY5zslXRrEa9+QozRus5riwJgURhijguJVnanyA+30fTd9z
         gKmuRf6OklW9flspN01RDKA0r7wwtVn0UZqmOhYq4kuC2dG0B5hyMa+jVpXButIF/82A
         nt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+EPNgYVZ/RdHM8N+N9nNtEl4jXbl1jKweWA+3l93hW+ym5Sc1q1XIyGViftmaigRn6eQmzVLTodF8i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2pAMcgG82riLCXqmQj5nI/zgG/7VxNUsfFkSTMu4/O8hrVzI
	ywZVbZ3GpJUNuFcZJedmS6XQIbNmsCcsKQZ+cZHlOoT4JmRKZzqTu3ebdJKuIl0ZBi97glktsN2
	XwBWsx9Bt
X-Gm-Gg: ASbGncvouMbT8wh47w9fLP0hBd1/JwTuOl60bSQ+3IRzMUex+nJcF9CBD7TVmoJEG26
	qEyjq+CsY46+NK821f6AZUfdGK3SN16KGeSTewwbKss6+w4hjIAlUo0cSkr0ofz2mcn2HRsNqmu
	jvU3rA+XpcINm5eI5BbCrcVzDmpp54lekntoKM4oAShQJDgMwR/ehl8MTfOW2PwxRB21/l8bhRF
	qPLtmhjMPJ29rAVRjiJ+9ymfI/0YKk9bWrnmh2ljsyEmUm2CuW6PDjZL/dZlg5tqKmY18hJuiNt
	62fuTEx898mjp9wBhwVXzKCeagGuL26p3GEJxydVHgP2NinU/jptrdPEL8PvjBoqmWSl4d69aAN
	R
X-Google-Smtp-Source: AGHT+IGE7vGdDk1eYobE3j4eEenqSBHwxgsJjkFP8SC2ApJzMLqo/JRNGwqZ2idziaLtYSwok+y3Eg==
X-Received: by 2002:a05:6402:26c8:b0:5de:dd6b:a7b0 with SMTP id 4fb4d7f45d1cf-5e0b70be231mr23007977a12.1.1740611832699;
        Wed, 26 Feb 2025 15:17:12 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6dac5sm171442a12.19.2025.02.26.15.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 15:17:11 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so42641466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:17:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP8sUyoPo+LGZBMtgu6DVWmOxNfOCKKIAuyRtaRXny/r3QRT3QGiRjit8qiUcKuwcsEHWv2wP38g1ejFk=@vger.kernel.org
X-Received: by 2002:a17:907:7758:b0:abb:519e:d395 with SMTP id
 a640c23a62f3a-abc0d9da124mr1995246666b.20.1740611831430; Wed, 26 Feb 2025
 15:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com> <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
In-Reply-To: <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 15:16:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
X-Gm-Features: AQ5f1JoyIv-1_glEa7tZi4ZthcHRhGP_dyEjdVPws-Ir7Wz4fXVxNYINjV-KbP0
Message-ID: <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 14:27, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> This is another one that's entirely eliminated due to W^X references.

Are you saying rust cannot have global flags?

That seems unlikely. And broken if so.

> IOW: if you're writing code where rematerializing reads is even a
> _concern_ in Rust, then you had to drop to unsafe {} to do it - and your
> code is broken, and yes it will have UB.

If you need to drop to unsafe mode just to read a global flag that may
be set concurrently, you're doing something wrong as a language
designer.

And if your language then rematerializes reads, the language is shit.

Really.

             Linus

