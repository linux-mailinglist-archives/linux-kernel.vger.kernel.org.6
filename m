Return-Path: <linux-kernel+bounces-348186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240CE98E3D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CCD2813D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0228216A34;
	Wed,  2 Oct 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AgH07O8h"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57D216A05
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899339; cv=none; b=ju1rMkLpPd0s8bAofXJn9RJ35ry/+mjXUGU6J2VYo0pEKFrn2NxB+pmzwj6+PBk32qoJZMMzv6YBXyog2dCPB2rFrZ60GOZj3Zze3dWVo26CPgQLZrzQLON0m9X4n5WyoU3OTzRYM2jOHjsuwhFtzgyRNQEt9TKSHU97hCTmXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899339; c=relaxed/simple;
	bh=26ch3VLdZlgASzApmc+sdmN42sQrSbzi8ri/yXB2hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn7HDdhbEkS6UkfztdGVuBq8hMOKYQdvlXyFKpw+2eOdfKkL6l9qA80mM6/KHYjdDZfMovVRHa3+TMu2yQLca8UpTFMhRpBUAdG4h8H6z/cywKXCxnCQfrGbojCltIDUp8FM7of3hTjgLDSLX047J3VaubnSstzMofBc7V5qi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AgH07O8h; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso2108501fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727899335; x=1728504135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=AgH07O8h0kU3nbK2jusgZHwlBFol5M4MNSqfMd9LvqNe+egpEecyYap1hVVxGNBcsA
         Un1TivTEdBK5z9whjjJ5aWs68D6UkpQrUikrxpWLLpo13zRqBgO8IlPVGQiGUSxYQMyq
         r+t/6vyH3cvjbp7mXoAFQEj5G1zGI4nnZsFqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899335; x=1728504135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=ZzMIxPQPI20/DhdjbioJyFm2c0J7o1o5Qvxb4PVkszhtYxemT+1szcuOly9T75u0EK
         8ID7Z0+4tUERy0FF/39nkyaXldx6bwT6m0BDzmQfCxFGDAkQz6s+kBVCPS4z3qOGD0jM
         CczQJwaB+uFoucSGI+qh9yMqpf0Ij/AHKHozAZMfSfbJsEAsfOzPXYLaylS1DPUPVCg6
         OZT+E/Mm+brTkTHO0TlbDFRGXK7PHqJwzsMfopaiwcZwzoTCCM3fMJzIczlvqlzeuREb
         N9GnxOIh7PvRluzRhcRQXMgDXj7Ogn+6Qt4wTx+gRn8EWYyr1isERgVNpEiLiE+xYf3U
         gI+w==
X-Forwarded-Encrypted: i=1; AJvYcCUbMAL2423OVHkO6xaZzPDEDGuGjCFQ+segF5PWmx2UCK3FPUHdJn05pHFYrivWiOn3emHVN3PGZPU+32k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9FZrW/u/YY5/3KQIIyYNSZyv68ZH1JkAQTjFV48ahGjK8FqC
	ngGMTPWNorg7+qUn5KcRaYdkgawEzrzb8eD7iSzDq5g0Uvrq9kpjOGhFRECgDLQBuSf0XBaOM0U
	0FXoNWg==
X-Google-Smtp-Source: AGHT+IEZu5t21/CIATvBjvOYkKedHXeqwC9oLtWF2RVWA9b+RdJAqbXD1smOZRJIiKnLF/hu+wz5Mg==
X-Received: by 2002:a2e:a586:0:b0:2f6:6101:5a6c with SMTP id 38308e7fff4ca-2fae1004f8dmr24606251fa.5.1727899335185;
        Wed, 02 Oct 2024 13:02:15 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d4628930sm20600791fa.138.2024.10.02.13.02.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:02:13 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53992157528so161954e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:02:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAYyEYoVvxoWqAuYNvdnX7Gp97vgd8+DlDB3fxIHUhhMeqpzhiZ5AR4ekzYrAl0DiLn6MYbcrZbrkHROk=@vger.kernel.org
X-Received: by 2002:a05:6512:e9e:b0:535:6795:301a with SMTP id
 2adb3069b0e04-539a079eb59mr2506573e87.47.1727899328912; Wed, 02 Oct 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
In-Reply-To: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 13:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I guess you are referring to the use of a GOT? That is a valid
> concern, but it does not apply here. With hidden visibility and
> compiler command line options like -mdirect-access-extern, all emitted
> symbol references are direct.

I absolutely hate GOT entries. We definitely shouldn't ever do
anything that causes them on x86-64.

I'd much rather just do boot-time relocation, and I don't think the
"we run code at a different location than we told the linker" is an
arghument against it.

Please, let's make sure we never have any of the global offset table horror.

Yes, yes, you can't avoid them on other architectures.

That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
feel are a complete no-brainer and should be done regardless of any
other code generation issues.

Let's not do relocation for no good reason.

             Linus

