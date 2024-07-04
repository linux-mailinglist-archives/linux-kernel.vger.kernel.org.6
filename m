Return-Path: <linux-kernel+bounces-241618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE89927D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D6B229C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295887344C;
	Thu,  4 Jul 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ebxKb6HQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26383C482
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118134; cv=none; b=Z9I03wfPFbFDUEnvhkUt1saLPN8ODlZFvfzOvnMmFoiYS0btch6n1EewrH1/0W8rj4+ZDW5t1EOydgO/gq2hq+pKgbBIhtZgW+2rxGdFMIrg14L/nG8ITMA+kR+t+N2y0oSkVK77tFKIWUaxTUPGptkrroaO93k/b8Y8q8WtKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118134; c=relaxed/simple;
	bh=3KrRlAYycpVy0h58h2mpN9xTr1dy/2XEpPbZRwlBVJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kG+OzwwaeFAbtXqCoY1TSo3lWhYSPjU8lDkOVEZP4IuvA1Hi5EDmPS/zGTrMnA51spOSlSR0xmGEysiINGDhw5cyktsM/YQSuXMHwIc9qhh2CjXvmNf5Px2yJ7DlYyqNI+kb8yD7flTGdzagEfs6GzfyasExzXBzxe8XPyefW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ebxKb6HQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c4309fc8so54730266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720118129; x=1720722929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6xGQ5gwdWA+Q4B03DfxL06XnGmh8h93hT1i9dIdXC4=;
        b=ebxKb6HQuU+g8ntkRBQxZ/V8/aZOt+/W5HW/0GjywWBeh/UeYNiTFm8Qj6lOssv1Qm
         Gu5paHriCE1zsv+OywEH0bydQIhN/j3zLcNoUxcL60nvjNI2KYRQO5h/COq0kNXViq2c
         N/2vfByv9RK9wdZU9fxYd9FVonVwgw8yCUlig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720118129; x=1720722929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6xGQ5gwdWA+Q4B03DfxL06XnGmh8h93hT1i9dIdXC4=;
        b=p9jEsO0+jw1zF5Ku45orryZFXDnE1a+KvNKhXuqX3V7EGcy7h7U4rGVfE8K2RPV+Mx
         FBYxo1aK9gK/caDcU7ttZX1VXe0TICK0AiN/Tf/iJx3qVFkTIqzBSAQl7C7EZK717zuN
         n5yDzP8SVYOeLxLl0K8dEa0dj23pMDY7gmY5yYbE9oV6Nus6iRyCJCL5ne8ZeBs6Sv07
         IyXFUIpsEjEsU/QHBu13lu7g6msOJ74tBvjhCWPKUObSGyr3THa0ce0UT4fMHSTlKNJJ
         vwQEhbG72pRUoLo140GHvd7a+0AXm4YkaVc/TonJf3/vC+LHL8mijVzv+VSzYbWIOxPq
         r4Og==
X-Forwarded-Encrypted: i=1; AJvYcCWeTz+l4z0K53zx0j4j5s2ZS7KK8t3Ftg8DLqWKCkSuIt8u0je7z+eAY2ILyQLP/Q/hCe6qtn/BLjAx2kwRNJCyC7nqKRE2k5rC2TtH
X-Gm-Message-State: AOJu0YxEWt25m4XETVJXYFedRaXGk2TMmqxL+FdHRmC9zsQ4TNZPcnQB
	P058/0zYvtyeiM3tOPvh6ytJvgruW2zPx1gctltJtgRyJYHHAp95mT2yR6LllW7+6OdO5aca3oe
	8oe7sFQ==
X-Google-Smtp-Source: AGHT+IFmPd5tqM8fp1Ixh+Z3Bbk0qQEosTuE94Ixs0Gj3q9O7L9R3eoYGa1U1XUy7zCrlLavUqTueQ==
X-Received: by 2002:a17:906:adca:b0:a72:7bf4:694c with SMTP id a640c23a62f3a-a77ba4517e5mr174830466b.16.1720118129633;
        Thu, 04 Jul 2024 11:35:29 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77bd30d04asm64285866b.143.2024.07.04.11.35.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 11:35:28 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso15937366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1Nxck0Ypo9NqqZAqKfPE1t3L8OVKad+bMA+1+yC0AoJztS/LjZdttO0Wj+y5PJgVdHEv1YhI+AZn0x43C6Mq2hzOiX1zkMKX0MleD
X-Received: by 2002:a17:906:ae47:b0:a6f:1c81:e220 with SMTP id
 a640c23a62f3a-a77ba451686mr155819366b.13.1720118128238; Thu, 04 Jul 2024
 11:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com> <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
In-Reply-To: <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 11:35:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
Message-ID: <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 11:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See what my argument is? I suspect _strongly_ that this is all
> completely over-engineered based on theoretical grounds that aren't
> actually practical grounds.

I also have a separate suggestion: I'm more than happy to do something
*MUCH SIMPLER*.

If people want just generation counts, we can give them generation
counts and maybe something extra in the vdso read-only page.  No new
VM stuff, no new "allocate a buffer that the kernel manages", just
something like one cacheline of helper data in the vdso page that is
shared with everybody and is already mapped.

THAT is what the vdso stuff is designed for. It's not supposed to be a
whole new library routine.

The state allocation should all be done in user space. The mixing
should all be done in user space. As far as I can tell, the *ONLY*
reason this is at all about the kernel is that "generation" counter.

Just expose the generation counter in the vdso data. It will even be
backwards compatible, in that old kernels will always have a value of
zero, and whatever user space library then uses the generation counter
to check that we haven't had some migration event or whetever won't
get the *migration* events, but the code will otherwise work.

And the regular user space library can decide to use whatever mixing
it wants, whatever state size it wants, and the kernel doesn't have to
worry about special memory allocations.

See why I think this is all so *HORRENDOUSLY* over-engineered? The
kernel has absolutely _zero_ special knowledge about random numbers
that user space doesn't have, except for that *one* number.

And you literally don't want to do kernel system calls anyway due to
performance, so your code is 99% user code anyway. KEEP IT THAT WAY.
Don't add it to the kernel.

                Linus

