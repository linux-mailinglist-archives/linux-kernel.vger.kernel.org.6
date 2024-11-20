Return-Path: <linux-kernel+bounces-416200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA99D41FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF661F23351
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E7153801;
	Wed, 20 Nov 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R6GhLKYA"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAF4437C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126807; cv=none; b=JkKIImYyC9ZwTh+CjLF0o9yMy1Og+cV7BqjMpuBVSE6d7C9EDx7G+N1HFDjuNG2P96SnvGzMHtuZPBKrw85hcDRIPrsqOIYjVmUR6JlKcx19Q8TnpE2O6GvDBstXd0EHmqzJ9QVpPyOppuLZKC+/9nJU5RJ3nuUePu2kOCz8Kgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126807; c=relaxed/simple;
	bh=42/CjzlZIyAA1TAMBE2KQmRakBTN41uBW33c2VtKYU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpaHy2KkVXwYjcMPqBkLOx8MDoc8cQQKeFAz1rDbjwPOV17zN4Q4mQ2t9dS8fN/AEmkJB0FAxEIX6jZEqGiWVdpp3TjtJpoQV8iQKEcTHqxqGPY0E4IpKTboFCJiBHJUiokL8XdbgmE1qiFuIMBphfm3hmSIc9vA86WFkxKqXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R6GhLKYA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso951701fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732126803; x=1732731603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5B+OR9UgCUqhI32g2+Mi2pzS+m7fzAprX5iLB+aMNVk=;
        b=R6GhLKYAhphMuiWyBk8NMJHVBgtDn84x4iqLLJXVnar6gTHuiwaVb5Ujj85N9qo1Tr
         1WbmEJrh6eqoMNYUgU8FB368yPRZMu2vn7vlzZYDfySWAgMnQvPgr+tzSjS8+0v2DEM/
         EHZq0F9CtxwbyG5Mjwx2LixFVdn8kIGywPoKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126803; x=1732731603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B+OR9UgCUqhI32g2+Mi2pzS+m7fzAprX5iLB+aMNVk=;
        b=LjJR4y+4BKyg5o2nEIl9stfduvGjXOxM+dZjsJI/i9M1VoODSGqyxBeptHNyRVs9zu
         0DSh8WZuyxpQTrqBA02+ynTvnUsHkAWAQE2uhrBmnfRXCIFHgknRnlFKP0DicK7L+8GG
         OjxNQ5nKo/nKv7n2g1uu3Yz2nrGfXyLeo9a4lMvHncYE9AwnOU7Jdc1bTsvnlwTlFDBC
         QIcn5JVrg2WYg2b1gbO/rmgfHENiPkci5qY8PPcn89muMa0RZedsbk3o8sDJcM4AzeAk
         dU8C4T4sGWVNCnkx4G79Obj9aR7MTolQorTDthq/6mnhPGPPtvvhMgEYowutoond5rq4
         A2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWrtR1iUjTOte85eTe8L0YgaYhIcydHErb6ILRS6pvEfw14R/rvztuSd0E/Bldj23M8zzQKAilh4tZb+kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JDa3CS4UTtYiuVqQpYCZC64t9A++RM0QxM7tjwEtT7RUN/4a
	uLhbgJOWn3cVHxs6oZ4tMczGfh/mOkoAGljaOoPIK/Zouujx4aH/iJjnTGe1Cmr9MDPyqstQI33
	3e8MqBA==
X-Gm-Gg: ASbGncsaovhlTFZkV1NDfSKEkVq5Z6QjMhlENwL843+kxxc/AULKIIl/w6jtcmNd/hE
	0lvSM7ZGfD9ag5d41h9JhcrW9Ll48uBDZ658YSWQ6GKY9lqWncviEYaMbqQcUu5gXiVhBG2x3sR
	WqQQyTvEj/+o1Sc/spKa9WJxVTZCPGbkt0/OcoHB9P5774yrf8XVs+5d/OYTql3Rwa/3m2DIKQm
	dp2Ylts1ZLhdMQhfU51KxtKCRWhI9ISoDiLwwNNLTBo2nU3BvDIE/2LbAIGgbS+fxne9gHZca8h
	5iZOQ5FVxzgDCl/e/nrHStgS
X-Google-Smtp-Source: AGHT+IHQwr7+hoVq2QwMwwaFC3S6MEKs+efLWmbXBqsIFXa8SkON28lsa1UQHn7/ycMt+a71/2V0bQ==
X-Received: by 2002:a2e:22c6:0:b0:2fb:565a:d918 with SMTP id 38308e7fff4ca-2ff8dc22534mr15106721fa.12.1732126803115;
        Wed, 20 Nov 2024 10:20:03 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff4501a1bsm1052980a12.48.2024.11.20.10.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 10:20:02 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa1f73966a5so8891766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdWm6ah379UbNRr7/0KPsY3C4MAcMkMBghUnCCyyiWJJIjhETuZ4KVn1erGdBk9UtDR0L+sQRdIFUaF+w=@vger.kernel.org
X-Received: by 2002:a17:907:dac:b0:a99:8a5c:a357 with SMTP id
 a640c23a62f3a-aa4dd766d81mr365261266b.58.1732126801791; Wed, 20 Nov 2024
 10:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzsC7HOiJ8Mwk8D6@gmail.com> <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
 <Zz3Jsn7Vf8X9ICva@gmail.com> <6499c178-b34d-47f9-8b1e-c87852d8426e@baylibre.com>
In-Reply-To: <6499c178-b34d-47f9-8b1e-c87852d8426e@baylibre.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 10:19:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com>
Message-ID: <CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com>
Subject: Re: [PATCH] headers/cleanup.h: Fix if_not_guard() fragility
To: David Lechner <dlechner@baylibre.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 09:57, David Lechner <dlechner@baylibre.com> wrote:
>
>         cond_guard(mutex_intr, &st->lock, &ret);
>         if (ret)
>                 return ret;

I'm not convinced that improves on anything.

You just replace one disgusting syntax with another, and force people
to have a variable that they may not want to have (even if they have
an error return variable, it might commonly be an error pointer, for
example)

I really think the basic issue is that "cond_guard" itself is a pretty
broken concept. It simply doesn't work very well in the C syntax.

I wish people just gave up on it entirely rather than try to work
around that fundamental fact.

Not that long ago, Mathieu wanted to introduce "inactive guards" for
some similar reasons - kind of "conditional guards, except the
conditional is outside the guard". And I pointed out that the fix was
to rewrite the disgusting code so that THEY WEREN'T NEEDED in the
place he wanted to use them. Rewriting things to "Just Don't Do That,
Then" actually just improved code entirely:

   https://lore.kernel.org/all/CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com/

and honestly, I suspect the same is often true of this whole
"if_not_guard()" thing. It's not *hugely* often needed, and I strongly
suspect that the explicitly scoped version would be a *lot* safer.

The "if_not_guard()" model may be great for mindless conversions of
existing code. But I'm not convinced it's a great interface in itself,
or that "mindless conversions" of conditional locking is actually a
good thing.

          Linus

