Return-Path: <linux-kernel+bounces-279805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D294C20D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E62283E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607218FC93;
	Thu,  8 Aug 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GvhQz1hR"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4318B489
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132455; cv=none; b=bVF66RlhsPyHT4IBjLl+bs0izHD+E9Y2JnykecRzKuc7Aa9p2kaq6tO2Kv6zmqf6CxSTQeN75ZKy8gKYV1UQAakXHCeKr5HN06qH4nMM6QARSFp23eKwUcy4tlKg55PXh2ZeU9xc6Lk2yo1vusus/cKZmVREX0qyEDOcBzPZj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132455; c=relaxed/simple;
	bh=74ofta4tuVDtjmE3sMKxYesbYsKyDSwub6JiP0riGnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq3FX4eBJc/HPxzu0HX1NeuPNlDBUsSVndRHQNtUuS594tl6yFVtWcOLcrRiTd+w/m0u5sVnnapYdb93o/pQETHcKTcSJHiPQwkwAcctrqmogYuwRum57sY9NmsXw/1XOLedhi39hN//J48i1HMIZa/qItp6xqws7emuv+yLWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GvhQz1hR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so1416591a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723132451; x=1723737251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EX5+8aeSzFSKcA+0lbl8uR/ffra+3uio0EheWhiGtJ4=;
        b=GvhQz1hR/ZFcFR7wDq9vTVAsY/AML7Kphkui7TBwoTPHEoxTMl5hNZUBaIFo8zo3iv
         0YHran8uGE0kgFd4i99wH3zAR8TEauPpIPSMjVLhq0566FAFHfRLPo1IBQLx1Z/yUbCX
         tf3MZkSBdRKB1ozLKqYf9s+n/xJIAebLmYPXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132451; x=1723737251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX5+8aeSzFSKcA+0lbl8uR/ffra+3uio0EheWhiGtJ4=;
        b=V0xygfRY8/u7968I5Nxo13do91U6mxqCnWFKqli7XzsCfs7rv8caHKMOBR482GbncC
         2J4v8tOD+AIMLOhHyMueMAkO9QEF9P51PjxYGUlyz11wMtXbO7JKSk+oiUdp6v3z739b
         0YfDQqRq2nzKasnJNvd0uFZfzKcw7x3UANNZb+bPvzkybLGC+ukvvxL4M2Fd0iN3Qyx8
         Ba7NazRuttdAgIvxxLn3MwHucPu4fbu5yKz+FK8ZIbYtdA4ja0jZePHaJGcGrvmbKDVn
         hze29v9kpDkwftU9AflEu0fdM2x707kU+k0PJ5Emun70MponKykQ1hw4AvuFgAvz6LVw
         +3ag==
X-Forwarded-Encrypted: i=1; AJvYcCWzF68EdInUfpKwXtaZ1zYVQwW/jS5FDnYj8TYijRekT0lgRK7LjRyyj7VL+AXVYzq6m7sQOIKvNfDAfGwPWo2lllBlldkEupo/2x7L
X-Gm-Message-State: AOJu0Yymr06aySFtBalRKksj8oTh+QCmmRw+r2EdiaXBgybMM3VQmCAX
	87X3MpjDyncobTvbSjNDOpRazL6zgy6xFbIVrERi6MHlq9ED99Q9+Md8lfDN7AYFWRPo3Dn7wk4
	SglopHQ==
X-Google-Smtp-Source: AGHT+IGW5e6qroqK7CY/XrRfyVarGjSYiFskZieJYYlsVtSBYzpHhKAGZ1PmyjR8lJzw9Gds7crGSA==
X-Received: by 2002:a05:6402:11c8:b0:5a0:f8a2:9cf4 with SMTP id 4fb4d7f45d1cf-5bbb2234eacmr1853605a12.25.1723132451045;
        Thu, 08 Aug 2024 08:54:11 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1d615sm786900a12.23.2024.08.08.08.54.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:54:10 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so115339566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:54:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAC92rpGuOX0KPOdMEoAdWIfhOVceXVFvjmtlzYWP6iPpzkBPfoOTZAzCs06jVGtV5cGz5xg31ZNcLgGpSa3avEY0zM0ZZeoybYtot
X-Received: by 2002:a17:907:f716:b0:a77:cbe5:413f with SMTP id
 a640c23a62f3a-a8090c2228bmr161289566b.4.1723132449801; Thu, 08 Aug 2024
 08:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
In-Reply-To: <87plqjz6aa.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Aug 2024 08:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
Message-ID: <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 02:57, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Careful vs. the pr_once(). It's not necessarily the first allocation
> which trips up. I removed slab_err() in that condition and just printed
> the data:
>
> [    0.000000] Order: 1 Size:  384 Nobj: 21 Maxobj: 16 21 Inuse: 14
> [    0.000000] Order: 0 Size:  168 Nobj: 24 Maxobj: 16 24 Inuse:  1
> [    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 18
> [    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 19
> [    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 20
> [    0.000000] Order: 0 Size:  160 Nobj: 25 Maxobj: 16 25 Inuse:  5
> [    0.000000] Order: 2 Size:  672 Nobj: 24 Maxobj: 16 24 Inuse:  1
> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  1
> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  2
> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse: 10
>
> The maxobj column shows the failed result and the result from the second
> invocation inside of the printk().

Hmm. There's a few patterns there:

 - the incorrect Maxobj is always 16, with wildly different sizes.

 - the correct value is always in that 21-25 range

and neither of these are particularly common cases for slab objects
(well, at least on x86-64).

I actually went into the gcc sources to look at the libgcc routines
for the hppa $$divU routine, but apart from checking for trivial
powers-of-two and for divisions with small divisor values (<=17), all
it is ends up being a series of "ds" (divide step) and "addc"
instructions. I don't see how that could possibly mess up. It does end
up with the final addc in the delay slot of the return, but that's
normal parisc behavior (and here by "normal" I mean "it's a really
messed up instruction set that did everything wrong, including branch
delay slots")

I do note that the $$divU function (which is what this all should use)
oddly doesn't show up as defined in 'nm' for me when I look at
Guenter's vmlinux file. So there's some odd linker thing going on, and
it *only* affects the $$div* functions.

Thomas' System.map shows some of the same effects, ie it shows $$divoI
(signed integer divide with overflow checking), but doesn't show
$$divU that is right after it. The reason I was looking was exactly
because this should be using $$divU, and clearly code alignment is
implicated somehow, but the exact alignment of $$divU wasn't obvious.

But it looks like "$$divU" should be somewhere between $$divoI and
$$divl_2, and in Guenter's bad case that's

  0000000041218c70 T $$divoI
  00000000412190d0 T $$divI_2

so *maybe* $$divU is around a page boundary? 0000000041218xxx turning
into 0000000041219000?

Some ITLB fill issue together with that delayed branch and a qemu bug?

                Linus

