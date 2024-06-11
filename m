Return-Path: <linux-kernel+bounces-209147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D543B902DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7539A28201E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9957749C;
	Tue, 11 Jun 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GvVxFgF2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2785684
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068192; cv=none; b=W0XnFl39n7nHiUJf50ywLQ7A4ISxtEaJYakWOCzu5TjaC74iXNhPoPPLZjQEAWDkD0hS8WFFHz2Uw6l19zN1SHd04zLI3p3yOzljuPgj3BnQhIVjQJt5HF/EroJik2SPEJoJIpfDZWmuK70FSbuFWbUTxKPCS4TowZ6nvdX/WtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068192; c=relaxed/simple;
	bh=ISwR3L/+vG1MP+uku//9GZeeAXnWRoG3eGy94sqfYJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7331urCLE0x1ErH/naxrs/9WUjYKH8cZnqMpXP5Q6iIUY7jbNlQfEl+4O7eY/oqalJYxeLd6/oSpEWrlqcpTwBdC4H2q9xvaBQTVoaVbmZX47KUrQk6HQQN009JuwAv7jl3wup32twB0gJ+80ZcCwfZR2FNmAHl9AFU5A42YCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GvVxFgF2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so5786841fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718068188; x=1718672988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwfbM40EYyuUQKmQd1ErLsOSkNp0fbZk7Synz5+L9UY=;
        b=GvVxFgF2aoEEMvkl/klxpsn8sA7lV8kvv+6qySPwqs8ttAKXdRUVWj9oawuPn4BVJp
         uVOWiwfIXfxCXXv7G3/MqHOw6cBYzTPP20CWuA9rvZvz33TUTW/7+CHD+g7Xi3aNf/ai
         R/bum4zSTuszo5djb5zF9ZVUzLut7vSAm9AJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718068188; x=1718672988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwfbM40EYyuUQKmQd1ErLsOSkNp0fbZk7Synz5+L9UY=;
        b=KQ05LdvNnhw0+dwj85bFnjwaxIine3mtQejKi8G/P9Op4SZehaaPvdj8yBhKcqnOLo
         XJzwNfWBkG4x8BSbYePaFhquZmIsclV5z6qR+2CybNS+fsnDw0BXIofRbtr/WDL0Rpit
         7F/JlZLLzURcYGLD2P1cl24NyE6p6SkDDNIcnkBXifgLQ+kh/LRhS4U552uqr2dc6HKg
         3TT66v5u7wvYwcKM1Kybu+BQdh7U+3coNWwglIopE5EYa3UkkpybOCFdwET0qXKXWPiY
         5dpVW5Ac3dAFXSnWRbSzFHSfYKVJdmiTfmkYpFEyqhFllJydA8baouCSj17dvvG8fzKZ
         mGKA==
X-Forwarded-Encrypted: i=1; AJvYcCVadqFS181lNCODE8iR5+2aKju7bqV2GR1FkzGpbJX8GpM/LYCA2R8+uplwmIPTRHQxaZyMvJL2ZrTvmLQQKvtqUJI9ZwwQS/Yth1sn
X-Gm-Message-State: AOJu0YyieWcPOU+KqKXJWiQgUENAdBiZlIM/0hYSDLjs3D4puC09wzZO
	jw9AJeQQPIsmYzICP/g9nqgE93Ra5iR0qp4Pm4GQoE44XGBG5wXAsBb8rk79oGqnG6G4YDZUadY
	qGsY=
X-Google-Smtp-Source: AGHT+IE0xvhYGElCKZNt8c8XxuM2qfJafBa4rj0yQA9ne7I0SqyQjE9XwXmhCZ4Xe9a5vMQc1WY2Rw==
X-Received: by 2002:a05:651c:1547:b0:2eb:df11:ca0b with SMTP id 38308e7fff4ca-2ebdf11cd1dmr63255131fa.14.1718068188350;
        Mon, 10 Jun 2024 18:09:48 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7407b4f0sm4347238a12.92.2024.06.10.18.09.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 18:09:47 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so611221a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:09:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4gBiFuSNa1NpvLcigF9vJVa0E5AoSMThzgQ6w88015noUebaSGE5cf+KJhUoQDF3yD2PUhqbJc0gFZe7YyPcMGwbeQ8T/n9HxZTeh
X-Received: by 2002:a50:aad8:0:b0:57c:738c:2c84 with SMTP id
 4fb4d7f45d1cf-57c738c3299mr5316366a12.10.1718068187113; Mon, 10 Jun 2024
 18:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com> <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
In-Reply-To: <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 18:09:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
Message-ID: <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 16:35, H. Peter Anvin <hpa@zytor.com> wrote:
>
> So I would also strongly suggest that we make the code fault if it is executed unpatched if there is no fallback.

It effectively does that already, just because the address won't be a
valid address before patching.

Doing it in general is actually very very painful. Feel free to try -
but I can almost guarantee that you will throw out the "Keep It Simple
Stupid" approach and your patch will be twice the size if you do some
"rewrite the whole instruction" stuff.

I really think there's a fundamental advantage to keeping things simple.

                Linus

