Return-Path: <linux-kernel+bounces-269540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD3943406
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5821F21E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806861BBBC3;
	Wed, 31 Jul 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jk3Tq65p"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252917BA0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442686; cv=none; b=thEpxrvqePFGM0BK4OcjcDeWLmkb8k6/JqXJFQg4SCQGGAQ1Pu0OV5vstAtIA2626xmvCYSlhceq/vOqLbEFn8tZYNjfg6jzKi+MNyJxtZIPQkVGraXDjfGehTnmurUwNuHjDO4vNCPQ1ng+XUHaploEY6ChPezGGnOGPvhn/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442686; c=relaxed/simple;
	bh=5na9tYjwaQW+yhB/iGHaHD52CAs9xRJ+HI3JjIaTqJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhIAi5Nb1kfODRjFI4fSAqXmJF5qznNC1cxC1yzQl2HIx2vUuntKvBhCb+kHxaLxVKSoRIVxG+Ot9s0UyuXBN1darx21bb0c+4xOTG83rPYJF0qWwRKY6KnKGVR8+m659nmN9240I90R/d38nppryhuG8XcnHmuIrhVUJhFPGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jk3Tq65p; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a8553db90so812803466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722442683; x=1723047483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RaF5PWbLsagAoFCEttHblhVfcmh/8fMf1m+AjtjSdbc=;
        b=Jk3Tq65pn0ygyIcP1ZLiPELMkdkhLO4Q76ubU2+yUkc4pP4WnRAga65xDz3l1zf5cr
         N5sRzqWOaZzWqRWIEDU1ZkPJdCYvzpsGhwyYp0EYi/bK/CLIEKJZl6eFthefvaCTe38E
         sJ3Q0d+D+gJ/DZ2uJ2emf+5WozzfFf1FS93H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442683; x=1723047483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaF5PWbLsagAoFCEttHblhVfcmh/8fMf1m+AjtjSdbc=;
        b=fckKj1n438ayZZBL5PJ0ZrULnOBEZHlfj2tPTnqdXzC1bwz7ZSQSbnNm89tgZ7HfMn
         wm7zzVb+mVG5DZ2K2R/FVSYt0nBG6veXKo1ta4Z6G4AgEZL7UJLqlsPpdTwOWOx/KxzM
         U35Q52nwZra1YW9pZfuXVhhuT2r+I/A5UVxTpLdePlyTQuU97I1FpbFXqpsaSpfAzwiV
         fowylDIKNOGsywD03TcEOFp6rfM5F65ReTbXAQLkQb0qA8c+jTrWhpagdYmfiNF1G1MR
         LTxsiVRxLgD/skPVbJJz1Z3XQDmNPkeV/wXt+IB3SH/0vDH3rtVV5afz8zHZpCcZo5FP
         waMg==
X-Forwarded-Encrypted: i=1; AJvYcCX082HNs/8PsUVHKtvrRqitWwwabMtVXKl1wvJBuQ8vMBRWNCQ8THNvu34gpoGjv5Pb2edwvhovzcehGkbpgbdcdI7BJpRYOz+i3dhU
X-Gm-Message-State: AOJu0YzyoupiNJpBVgktBp01lcnsYf7eYkNKpJdLnTsbm5Az4Zh7yQ3E
	r6jGBnHkJYb+YSTXtlawkPJWT4ZUUBEuYgbZ6HzfHXmnY2qXT+jSMklbrhq6M7SEEyYE+KDZqgl
	khpzXPg==
X-Google-Smtp-Source: AGHT+IG3RYX4AWVYQNdxm16b2bEz3t3yxG4m7MVkqROIv6VmSMh3NsbvZK1VREkJVZEqEkjRBwCknQ==
X-Received: by 2002:a17:907:d8e:b0:a77:c314:d621 with SMTP id a640c23a62f3a-a7d3ff557c0mr1309131366b.13.1722442682836;
        Wed, 31 Jul 2024 09:18:02 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91075sm784012766b.168.2024.07.31.09.18.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:18:01 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so8809995a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:18:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW++iD5fPvKfWtLPIQ8VpAFZ5gECeK5aWrHpTOQfWLqieumWm/YPVJJgiT5scT/OcAFeMwKIV7zvDlfj8JvN/UI0BtHi1LeSOi1HkU3
X-Received: by 2002:a50:9b0e:0:b0:5a3:71ff:ebbe with SMTP id
 4fb4d7f45d1cf-5b0211909a7mr9536507a12.1.1722442681542; Wed, 31 Jul 2024
 09:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net> <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net> <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net> <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net> <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731155551.GF33588@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 09:17:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
Message-ID: <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 08:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right, so Thomas found that i386-pti fails to map the entire entry text.
> Specifically pti_clone_pgtable() hard relies -- and does not verify --
> that the start address is aligned to the given granularity.
>
> Now, i386 does not align __entry_text_start, and so the termination
> condition goes sideways and pte_clone_entry() does not always work right
> and it becomes a games of code layout roulette.

Lovely.

> Also, should we just kill PTI on 32bit perhaps?

I don't think there's much technical reason to keep it - I can't
imagine any security-conscious people actually use 32-bit x86 any more
- but apart from fixing this bug I wonder how much of a maintenance
burden it is? I think most of the code is shared with 64-bit, isn't
it? The 32-bit case in many ways is simpler, even if it happened to
hit this odd alignment issue because it's obviously also a lot less
tested.

I'd rather kill highmem and X86_PAE, but I also suspect that horror
has a much larger chance of still being used.

The day we finally get rid of HIGHMEM I will dance on its grave. I
have hated that thing for a long long time.

              Linus

