Return-Path: <linux-kernel+bounces-243714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A495A929982
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A1281482
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762CF6F2E5;
	Sun,  7 Jul 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O0gZTKHW"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8B55893
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720380185; cv=none; b=hc/FxLvTRrpt+ejGZVfUbVMcRU2fGLfQgBbw9TPqoTfCNEWyg8Ze0r3FnJcFZIxi2sUtAjbamMBZM241qWYFUrzughzBnV+BWVZPRVhKqKhzgwb/1t8Vy3mzxL3nUHESXRK6BL8xayA/5WHtTo4RL8GIIB9ikphcF1qC9ggoFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720380185; c=relaxed/simple;
	bh=EpPs/PieXAoJ9C1Niu2SR/rTGpSjbWX77CzmDxsNsCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4SIhdJdioECrWfu242Dy2eWWCYSBMA0qWakHktM3tUpdhpd8D62tq2mLKYlLym0UScSZxh62gJyhIERSS+ecB4tlea3ITIdUYfjLpXK1mzVEn5dxJJaI0xRrk0sibOvh7jsaTYq40OH2ZrlXQbJgfWppqg6OGkPMzFCbxi7u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O0gZTKHW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso260390266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720380182; x=1720984982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0kqfSkBdmswPIG4hqXsZ+rgeH3ZVa2Soxi8UY2qccM=;
        b=O0gZTKHWqwDskabka0/dAI4tfr6cJLX8haT1skAujsKfM4W3QilrlqCBwDr44hKW17
         xtgglYIPxVAdWCI+RJsP1vrns2bj0cUvkT40pn5gDU0uFGfxLoUP7WHAqAdYUPNViAiy
         xvwJZ9+fbwptTWg8g8RSgavWJZrIA0TgP17Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720380182; x=1720984982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0kqfSkBdmswPIG4hqXsZ+rgeH3ZVa2Soxi8UY2qccM=;
        b=rYRd5aJNy1EAGueURsvhGT1Fxk/6rysLVl3z9TctFQcN/ENteYPI9QU4aySvzZKhew
         nbFIBxrHbcaD0pY8AUKKuUKE//+ysCu4rNwHOQkB9s+BmyrXA/jo6vSVzZ5c66czQQPF
         /6WTMwmpLykwrF9+qVCNzf9ykg6rpOh4YEN8xnPrjTGLsm3DX/OcoW5T6NTnfeDDcNua
         ywEmfYVwPfCSuOI9B/74VTCDsO/QGh5fpMQxVHNnUHK8P7tg55p+CsUcntJVieuMVU0O
         fG/+FdHgWtGM2y5a+gVfDY45kmWo9RiPCm4Jtm4ggUIZDMixPY+Yxxr6MLr0IX73+O1S
         kghw==
X-Forwarded-Encrypted: i=1; AJvYcCXx1DACwGfaJjbE/Hhprn0cGYjNV4ub5ELK6cHNUTqVjE0DTLwMCINMO2EWM9B8nSf7FBFbqW6R54k/ScbgVr1wJGn/tm/wHrP6VPjv
X-Gm-Message-State: AOJu0Yyaqu50setfhqblDwlG2Ys+IRupuodIRaNosOCF/7Y1K8ONdvKt
	VNrWpOLGnGKY9yIebwKfgmijBVRuBJ8xau39mIBaC3k6IHZylATLbOgzFeGg+zqatui5YCGaRQE
	hnmb9cA==
X-Google-Smtp-Source: AGHT+IFKIxtdQLj8rYciQUnfKuVc4nv3ypiQkOb74bOTLRpWIPjhoq6zWN2+/Xgpj+SJI++1TNX6xQ==
X-Received: by 2002:a17:907:97c8:b0:a77:b410:b1ed with SMTP id a640c23a62f3a-a77ba48325cmr875597466b.36.1720380181863;
        Sun, 07 Jul 2024 12:23:01 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c68cf842sm265059566b.148.2024.07.07.12.23.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 12:23:01 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c4309fc8so313883566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 12:23:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXipNqzzZ81yoRj6r3ljCU9+5NN4hnPANaz0sZUtl/dfSxzGbDXolad/seaDvitxWxjWZDJQ3BJQrUjP9zm3S5j1jmVElgPbbso1ChU
X-Received: by 2002:a17:906:7708:b0:a75:3c31:4f58 with SMTP id
 a640c23a62f3a-a77ba46fa2bmr620405066b.32.1720380181227; Sun, 07 Jul 2024
 12:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707002658.1917440-1-Jason@zx2c4.com> <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com> <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
In-Reply-To: <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 12:22:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
Message-ID: <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 11:52, David Hildenbrand <david@redhat.com> wrote:
>
> I recall that introducing things like MAP_SHARED_VALIDATE received a lot
> of pushback in the past. But that was before my MM days, and I only had
> people tell me stories about it.

I think MAP_SHARED_VALIDATE was mostly about worrying about the API impact.

And I think it worked out so well that this is probably the first time
it has been brought up ever since ;)

That said, the *reason* for MAP_SHARED_VALIDATE is actually very
valid: we have historically just ignored any random flags in the
mmap() interfaces, and with shared mappings, that can be dangerous.

IOW, the real issue wasn't MAP_SHARED_VALIDATE itself, but introducing
*other* flags that affected maps that old kernels would ignore, and
then the worry was "now old kernels and new kernels work very
differently for this binary".

That's technically obviously true of any MAP_DROPPABLE thing too - old
kernels would happily just ignore it. I suspect that's more of a
feature than a mis-feature, but..

> My understanding so far was that we should have madvise() ways to toggle
> stuff and add mmap bits if not avoidable; at least that's what I learned
> from the community.

It doesn't sound like a bad model in general. I'm not entirely sure it
makes sense for something like "droppable", since that is a fairly
fundamental behavioral thing. Does it make sense to make something
undroppable when it can drop pages concurrently with that operation?

I mean, you can't switch MAP_SHARED around either.

The other bits already _do_ have madvise() things, and Jason added a
way to just do it all in one go.

> Good to hear that this is changing. (or it's just been an urban myth)

I don't know if that's an urban myth.  Some people are a *lot* more
risk-averse than I personally am. I want things to make sense, but I
also consider "this is fixable if it causes issues" to be a valid
argument.

So for example, who knows *what* garbage people pass off to mmap() as
an argument. That worry was why MAP_SHARED_VALIDATE happened.

But at the same time, does it make sense to complicate things because
of some theoretical worry? Giving random bits to mmap() sounds
unlikely to be a real issue to me, but maybe I'm being naive.

I do generally think that user mode programs can pretty much be
expected to do random things, but how do you even *create* a mmap
MAP_xyz flags field that has random high bits set?

> > We also have PROT_GROSDOWN and PROT_GROWSUP , which is basically a
> > "match MAP_GROWSxyz and change the mprotect() limits appropriately"
>
> It's the first time I hear about these two mprotect() options, thanks
> for mentioning that :)

Don't thank me.

They actually do make sense in a "what if I want to mprotect() the
stack, but I don't know what the stack range is since it's dynamic"
kind of sense, so I certainly don't hate them.

So they are not bad bits, but at the same time they are examples of
how there is a fuzzy line between MAP_xyz and PROT_xyz.

And sometimes the line is literally just "mprotect() only gets one of
them, but we want to pass in the other one, so we duplicate them as a
very very special case".

                     Linus

