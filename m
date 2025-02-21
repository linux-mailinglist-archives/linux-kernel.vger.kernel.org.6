Return-Path: <linux-kernel+bounces-526600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61148A400DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CBA19E2606
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31D253F23;
	Fri, 21 Feb 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B/C7w7N1"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C19253F05
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169583; cv=none; b=U48vU/6v5NNtNahfqnjyKUEiI23pcukktL5NhdWnqZBGLBKPYV+bLHAV1uB5HeMlu4eoCuloizBc5jdWyxR+YbVKZCO2leGzuWwss84q53uqRL0JyVqXRNDSela8zkhl/adLeso6q5J2AY+qDePK9wYhNY9Kvdu8SAGjgoUn2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169583; c=relaxed/simple;
	bh=giBBo4caqx8Tf9a93T9eGadcf7q3hJroPXPmYCW+yTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXjQ4YeOmN+A7Ya+/2/97zoxMvQZA4y8YZcStx+eWGnaqt0cZa5iYwQqsXWNF640/9W7As2S0maowW3UOyDM2IICN1hWlMStZiEZAa9ROWiMme0Enw+UjrIwG4PZg8tMVGb+9vlfQYG8A6YSMUNIfTKbOq6K3SjZlD9ULZocTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B/C7w7N1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbd96bef64so403598366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740169579; x=1740774379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5rQmbjlwBbLwDXvN5+jqJigL+IoD9eonvyj1f9icKNM=;
        b=B/C7w7N19QGuXv8+1C180yMWS5+ix2u++/E3oXW5QgHnWHYQ/SfHU8QPhc8HfTtOgh
         jdZIbv/phy/naK8Zj8udg5IDBaNFxn+Zm3D6D31STwWVgX4rb5uHmTcxhIH80q8cxZOL
         wNmYwU6hxGUaYTsVQioeQcz/srWWMyUM1r8zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169579; x=1740774379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rQmbjlwBbLwDXvN5+jqJigL+IoD9eonvyj1f9icKNM=;
        b=sZ9UDtKYcbUPtjV9mUug/wtjg+LjeT8GWppjgVVSwKfrtmlHpi4RW0R6fhSbQjkuzI
         3Q0XFEzXP3va6C4cDCHRSmsnr5aPlxq+f2Xe6iM9UqqH3DXyMZLH2aQ0IF/kvihsdHoP
         0PDB0ZUdf8hiUR3vMl5jbn3Q0Ch7Yog9dI9PJUjfqNG3oBQ4tFWJS5I8+HyqW58aibt/
         RtaygB+bx+y0nKOknRjysp/SP7ASW1hBxRZ0C5U41ha2wO+8UGHQNoCQYatqNLAnkSlo
         XBWZvM3MgpQUiVQMwE/73MrhOq+K2CM2TctKta380pvEo3vTobUQnEASteV/kQzuF6wN
         uSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo6j2bRxQaPJnylxgn/ND/P39+uQvQcZVVaKo+JGELiE8Vhj4oFNR8WnWmSFagJbS86gP7Fjl0dNlRXSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdeELnUAkaABJMcwd5sYTgMxCuGWR8w8LDrOYxh85PL3VNe+Et
	jaodwu9aWM/H01rl7NqPgv3cH/WHIply3t5I2aXNcy8+jniPf0qUF4w+gcPyUZ1hoYpjGQx5K81
	WOFs=
X-Gm-Gg: ASbGnctAseVTeaomC5kdE5kxf3XeIDvvkKOnNYQhBY8sifjYglmcEh50MZdSKk7Bz5t
	nYVj4588sRuMrhLNs+gBqN2k+Ybp2RhOMl69jIEMuC5GxesNx9qOHNOEa8/v6D4bx0wPu1GndyP
	AijUD7/jKJOkBiCniLAsAOPjqz/o2yLJaON5emDe45oYiBnhbPFfUEFNaLBT4fwZQm5jYukStgu
	CzjG0bxIi91S9xEQi91m5v0gBm/iFYMAuna1HZcuBfWvyvC7FSdqjqOg32RzMEOiTTmyc7o6kgT
	NZNTmI4VKHDs+lmxlf5pbfoFzUP879lQVbx6wGWX9vBwrMHDKEAXRBApzjkbSWfdCA1BDeYCBm7
	U
X-Google-Smtp-Source: AGHT+IH+qRMD9lV77pe99RYoOYdrrgON/RU0mng1W1h3MQenEdAA9nEnOujrXdZC/s05YOXZKnD3hw==
X-Received: by 2002:a17:907:7f9e:b0:ab7:caa9:330a with SMTP id a640c23a62f3a-abc09aab978mr441731766b.23.1740169579292;
        Fri, 21 Feb 2025 12:26:19 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb80ba68aesm1232089766b.23.2025.02.21.12.26.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:26:18 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb9709b5b5so478119566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:26:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHlEKjBPDfCIIWUl+T8jcOVnwy/IH+jQel5WFrCSe3w4buRkytbDwwRtqPuU+0+JctDwH5TM+pVpuXX+U=@vger.kernel.org
X-Received: by 2002:a17:907:72c1:b0:ab7:b356:62e0 with SMTP id
 a640c23a62f3a-abc09d3615bmr497772366b.53.1740169578296; Fri, 21 Feb 2025
 12:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh> <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr> <20250221183437.1e2b5b94@pumpkin>
 <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
In-Reply-To: <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 12:26:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZwXK9shqeV5fpRF9CRqApVy5wz6myNeAkyuFm-ERTpQ@mail.gmail.com>
X-Gm-Features: AWEUYZmxOG8LoPESIjY5QVAnSYfcZ5a_0i_NpT_k6tEamu_ExBz05y6DOubwg3k
Message-ID: <CAHk-=whZwXK9shqeV5fpRF9CRqApVy5wz6myNeAkyuFm-ERTpQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Jan Engelhardt <ej@inai.de>
Cc: David Laight <david.laight.linux@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie <airlied@gmail.com>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 12:06, Jan Engelhardt <ej@inai.de> wrote:
>
> >(Apart from the fact that c++ makes it hard to ensure all the non-class
> >members are initialised.)
>
>         struct stat x{};
>         struct stat x = {};
>
> all of x's members (which are scalar and thus non-class) are
> initialized. The second line even works in C.

Sadly, it doesn't work very reliably.

Yes, if it's the empty initializer, the C standard afaik requires that
it clear everything.

But if you make the mistake of thinking that you want to initialize
one field to anything but zero, and instead do the initializer like
this:

    struct stat x = { .field = 7 };

suddenly padding and various union members can be left uninitialized.

Gcc used to initialize it all, but as of gcc-15 it apparently says
"Oh, the standard allows this crazy behavior, so we'll do it by
default".

Yeah. People love to talk about "safe C", but compiler people have
actively tried to make C unsafer for decades. The C standards
committee has been complicit. I've ranted about the crazy C alias
rules before.

We (now) avoid this particular pitfall in the kernel with

    -fzero-init-padding-bits=all

but outside of the kernel you may need to look out for this very
subtle odd rule.

             Linus

