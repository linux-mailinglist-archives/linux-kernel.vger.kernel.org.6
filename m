Return-Path: <linux-kernel+bounces-431951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DF9E430B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4B41685B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECCF2391B6;
	Wed,  4 Dec 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C3wDS8o3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C962391B4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335876; cv=none; b=PqKCdOiKVGQf4bGEWes7/ZF/KAsZ8s4Gj3VwVQhZbuNmS2x0t2OWBnl4tv5gcYc8dchuXVQzwUcug9dJ265/jHQsdfo1SeKOhXCzmBUrX+kF7rjrW40nsAt1sKI6gwyp8PfTU5qqQHTZgSkmAtMqV4XkIE7i+yaVHUZYVP1kAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335876; c=relaxed/simple;
	bh=X6BEDT6fDm7D7Y0nWW+xKECtJAeRFs5IERZbxKQu3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG5uMo8FhtPHq6WOYCY4qsAGE3jYNEj91FJtiQHMoWQuhs3TJqHVCykDPN9G976gZy3Q+iUQa0Ac/OIGrEftSL46yL3uKmnMInlyNvgAFj0AJ4I6HwKgw+fvzTm9YRv8FxuGme+jdX0G2nGjaW8tbs2GPR4pFy9Bpca6oB2I2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C3wDS8o3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa54adcb894so1765866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733335873; x=1733940673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsHq11mNN/cIeDGdLbelslfoGN88pEnsDmEEyawNX0M=;
        b=C3wDS8o3OKWiwEP8JqCl6n9azBrRVnbsmwNSx/HD+jKWet+qMLrgiqyGlvuJ9tsvzE
         1gxp70lPi3sCeGTG0QQ5/BEuEFafBdyBqnvR4SMDpNzMegXg+7D0gtfWzMEoMJM75M6j
         M0Ti8MRqQUzNcbc7WoDh+d89Md1OxTjZHY1VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335873; x=1733940673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsHq11mNN/cIeDGdLbelslfoGN88pEnsDmEEyawNX0M=;
        b=FSSg7Rt9m7txKqVQkrYaoy1pXT2kDVs2qs/r3TI8o8lJhwgFIkoHJ4ZadXa64w3jeF
         tpcG+t3798VeiPLgCz9lUIqe0tHrFpxakOlRt8H+aSrXzcwjJyTe99vittGluxii/ThX
         MD5F6JOlTJuTbqv7cA7WlGS0T0RNzdiGw6Ven51t7hW0FTQ7dXaV0hsWUKluE0WBbfnr
         mwU/uExmQD0LgWjW5Cqqp/u8JWrGNGcQ+xTHveUa98vsPR3i74oH4RlE7DimW4Upro0e
         o54VHLlMxIjRWnw4U16K2IafRKwBs7E3SL492LQPAucIc+Z0yITxoa8aATitlZdzixEX
         Uxyw==
X-Gm-Message-State: AOJu0YyAkLRM2oOIxfHC8ARf56AmdKjs3wAlwRCvSbDnDVPlHNpO8MPd
	JnrZNraSUUFUPIpT3YzDkcJ8OnUufL/th/VOpZJpmPEuoJYv/cZK+I4jqUjpTeXM3yr8IxRN9QJ
	w4vs=
X-Gm-Gg: ASbGncuNPuVBqPmOPbViaf4jlqyPyEjM0VJNRmk0ypJQ84qvW+Sq1YeJ6o5s2Aio6oL
	I6KDRWiZSUVaS1JWxfRW3j8X8hb11OSn2ky5bkOjlZbn3R2czCNlYiDQA69Rlu4yQsepB/8Ja7/
	L3UYpJnP0KCuzkwjithi0ArSQ7agkMmLtHwDr4L/+L7SuDBl7GD8uoOpqDEQpN+h9dP4mjeE7pj
	SemQJmGOwL0h/DJCWCuHNsJwck/w0i39Ux9jPBEnlXqC2X19O2qTV7oaT+75QfwaL3hPDY82k5x
	JoDddE486AGMzgX667Sa4hhW
X-Google-Smtp-Source: AGHT+IHRrXCG1FXQjr8sjBEtVAIdwM41nUHc9ahJmQ36vztaq2pkp7QBLjx4hhlN+bRJy/Ii7p8KgA==
X-Received: by 2002:a17:906:fd8b:b0:aa4:e18e:1ca1 with SMTP id a640c23a62f3a-aa5f7f5c25bmr895116666b.60.1733335873034;
        Wed, 04 Dec 2024 10:11:13 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59995562csm762437566b.189.2024.12.04.10.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:11:12 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec267b879so114141666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:11:12 -0800 (PST)
X-Received: by 2002:a17:906:3d22:b0:aa5:392a:f5a7 with SMTP id
 a640c23a62f3a-aa5f7f57ccamr725005966b.57.1733335871860; Wed, 04 Dec 2024
 10:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204103042.1904639-1-arnd@kernel.org> <20241204103042.1904639-10-arnd@kernel.org>
In-Reply-To: <20241204103042.1904639-10-arnd@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Dec 2024 10:10:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_b8b1qZF8_obMKpF+xfYnPZ6t38F1+5pK-eXNyCdJ7g@mail.gmail.com>
Message-ID: <CAHk-=wh_b8b1qZF8_obMKpF+xfYnPZ6t38F1+5pK-eXNyCdJ7g@mail.gmail.com>
Subject: Re: [PATCH 09/11] x86: rework CONFIG_GENERIC_CPU compiler flags
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  "On second thought , let=E2=80=99s not go to x86-64 microarchitectural
levels. =E2=80=98Tis a silly place"

On Wed, 4 Dec 2024 at 02:31, Arnd Bergmann <arnd@kernel.org> wrote:
>
> To allow reliably building a kernel for either the oldest x86-64
> CPUs or a more recent level, add three separate options for
> v1, v2 and v3 of the architecture as defined by gcc and clang
> and make them all turn on CONFIG_GENERIC_CPU.

The whole "v2", "v3", "v4" etc naming seems to be some crazy glibc
artifact and is stupid and needs to die.

It has no relevance to anything. Please do *not* introduce that
mind-fart into the kernel sources.

I have no idea who came up with the "microarchitecture levels"
garbage, but as far as I can tell, it's entirely unofficial, and it's
a completely broken model.

There is a very real model for microarchitectural features, and it's
the CPUID bits. Trying to linearize those bits is technically wrong,
since these things simply aren't some kind of linear progression.

And worse, it's a "simplification" that literally adds complexity. Now
instead of asking "does this CPU support the cmpxchgb16 instruction?",
the question instead becomes one of "what the hell does 'v3' mean
again?"

So no. We are *NOT* introducing that idiocy in the kernel.

                Linus

