Return-Path: <linux-kernel+bounces-210476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D290441B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F9A28389B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A4770FB;
	Tue, 11 Jun 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HARF3oQJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C97404F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132383; cv=none; b=MzJW1t0oBMykX7GKHK1jY/FUbV2dPjd9WToVPR5WzvdhIMpKrVP89nIYcoDEJEhrb1M2ww3Dgq1u/lybyN+19DfH0Ao/tbOQoJA+vLHW27o5LgdXYnV+DD4p8i0i1sBtYz7SANfuRd2yZnwzNcmWdIkLzXkURADyymbKiL2kvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132383; c=relaxed/simple;
	bh=94I3KscaFLWq+P7YGN1Fyl5KFoU2gBZQ1lhMwCwnJdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+OktCCHEpdhTwEac8XQEtqHG14qaxqSQJxfD7Tw4TRh+hjaX1QeL6xh1pRAJ+MIA16F4wISkO6z0YPpbyDdcVSfIM+F7SF+pWpZd6pkFodFgsRHjvDO+WXyjn+/rUbh2E6uRbY7ZGqMEjYFCzvwJX6z7fk6MU6jKcK2oiexn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HARF3oQJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c9034860dso2537513e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718132379; x=1718737179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naqtn4h8MjWycYEp8tdkv+DK6jY/XqNOfy509OQj180=;
        b=HARF3oQJnZmuejk+ncC2yRQDMv/YQk/uTU6HDcr0rnr5YRWK9ckuhrFj11yUkCCuvw
         olLz8PB1S3saz2gw5cGFqiFUMJvjRyRaR2j01p14VgIPxrLbgPG93yFTIGptvQ2RImkt
         gO/nE7saP9nVX+Eqp3AsYVi7USpS6HflYh9AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718132379; x=1718737179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naqtn4h8MjWycYEp8tdkv+DK6jY/XqNOfy509OQj180=;
        b=ZAWUj6/6qJdQU1BrijkYTaVx1dZqC1dwkLHXPt9RQHkbXVxvBbA5Erw6vNOGd6OfXm
         ZL/Xy2uVWJ3mQgWT4/YB3kci/WdY7wI2T3hoC6x8sm1fg7tLDGr3Cd53Z4BeiMv1aqls
         APxv5lOGMhPTXo4BfJbMOPBNe8srHmXe+0eBUy1e21hM6zl6ZV+xPL2NecczKKzO6Sew
         MNS0wh5irAMNXQSIsB3jP31TZNEg0fJHFkUiYSXqANZJzYm96957pmg6ZKxASnPa/6iI
         pL03gg7k6M4nkkhYeZRyHFlgNdUBjbQq7tmpUV5PO6aZMImM9FZ31KUmwTMFYSW8TIBw
         vtGw==
X-Forwarded-Encrypted: i=1; AJvYcCVpNjs50iQcfipqlVHQwCUN1NdZi2C1oK07CljKtsxIGg1tPXUG1JXVVXF7ndgEOjCOxx95pgIHDFESxxpSnyWnFDXet/KsXQjulUzK
X-Gm-Message-State: AOJu0Yxk/LuywDhft8l+CCW/L+Cq1tTZ82e/50Tr1vFjkbWfb8SnGM0E
	CI87IiNn6lOOe/kAfd+SeD/vCxe2tBFCo5RQbehs1K3gl5RcsWAQ2lrEvVeVicHswoy4qoymEl9
	+tod0Lw==
X-Google-Smtp-Source: AGHT+IH/CKDZK2V026GwvPjX4APo6nbP1kwi3MWADW0zPIFQNp3gw+mUprix21nY1crIgt2zYhpLgA==
X-Received: by 2002:ac2:5498:0:b0:52b:fac5:a3e9 with SMTP id 2adb3069b0e04-52bfac5a481mr7493129e87.9.1718132379148;
        Tue, 11 Jun 2024 11:59:39 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc192d093sm1819569e87.81.2024.06.11.11.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 11:59:38 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c9034860dso2537466e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGwKII7Qoz6oWXTe7ROztTC5Z3YnWAyUZoKT2+udGK8ZAZsDetax7hYEbGxjg+ciDvWKL+zH2w48ERMTIuDYb+E1jdpSmD7r6Ni10L
X-Received: by 2002:a05:6512:2254:b0:52c:9523:f0db with SMTP id
 2adb3069b0e04-52c9523f264mr2270564e87.45.1718132377816; Tue, 11 Jun 2024
 11:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
 <ZmiN_7LMp2fbKhIw@J2N7QTR9R3> <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
In-Reply-To: <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 11:59:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com>
Message-ID: <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 10:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'll look at doing this for x86 and see how it works.

Oh - and when I started looking at it, I immediately remembered why I
didn't want to use alternatives originally.

The alternatives are finalized much too early for this. By the time
the dcache code works, the alternatives have already been applied.

I guess all the arm64 alternative callbacks are basically finalized
very early, basically when the CPU models etc have been setup.

We could do a "late alternatives", I guess, but now it's even more
infrastructure just for the constants.

              Linus

