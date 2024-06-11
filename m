Return-Path: <linux-kernel+bounces-210574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183DB9045B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934A71F24A57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F61150992;
	Tue, 11 Jun 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cd0nQ7H7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143380607
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137622; cv=none; b=WrcXiXjl0xNtJ1kfxy3olBH5+Npg9rNRslPPVHAslPJw3fKFZTE84D15lNO0eUbvnZQsUL4KOH3uSLo2/ffaqkyeaeX/qFxqUdh1aMGPMOZjKQUU8ArdJ4ZPfoAHZ9iVpHd7FHy6Q5Ey0rJ5/t7CnDYJ36vi7HLNXQ+4IHz5QXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137622; c=relaxed/simple;
	bh=m6u0TEW+to/kS5lz7pac+0GlCH2b5cvGTQl95Wz9HHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yaoc+wfizOkk6HmV3J88jcy7QSR5JVXtUJh5npreXSToKWm5C/Z5+MbQm0DQ6IEOVGRlczNAICF4e169RCxnsFc1S8LymUNRgknxC9a5CxXVvs8tFoHuM81OjppT65Ebzb/Pti7tAjPdWknBtSViJJUJk3ObFiwsPTMrjTypJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cd0nQ7H7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bbf73f334so4511626e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718137618; x=1718742418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwLXpsWWWKNNMe2wfaY/7uDw2Z9xjWpxzliXTIklXvE=;
        b=cd0nQ7H7JbhmUgWVkcDjzJ7JTA13XhoCmern7cYCwG8/s7dObmEonhahA9jaSMx4tE
         o5qXl0CAfYV0FXLOarXH2ZuhzOge3eSjznKzt5Lq0KvpXaeSCNWIsYzgSj+IY3DTu7mb
         ZDzfEe2oI0h3O0TP10tXcQWSdSPe8ad/KKk5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137618; x=1718742418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwLXpsWWWKNNMe2wfaY/7uDw2Z9xjWpxzliXTIklXvE=;
        b=gIofWK+iilbrYH78oaWtuY4P8hSWOCtTX1jmqUq0Rs+OnMHq/wZaXiVYOAiQJjvV+W
         iTNdsmUvx7/abW75HcYKiEnp6sWadKuAVi8e+11qFod+U0qKTRqAk8pWQqRy7S8V04d8
         M6mrwBmRkTLL+AnUoG63ygWBvWwB9P4MrxF/CDeHOVISMQTDXrNqZGqX8pFvuy5eHp3W
         P7XEsEbnNPw7xrUoXs5mpdgOc/zmDBxHDJ4o7XvSr7MJYgdd5Kq5uvViIHqpWOfVKFaT
         5dR7kcCldK105QItXhXma2iaZMqG0A8qiT98O788IoHUKH4ZltulgYPdY8N50r/bn7F0
         lFKA==
X-Forwarded-Encrypted: i=1; AJvYcCUF0fB5CZVOgLi7qQpzTSiymtbwqpQ8uJU8tKOgtMj8Fd3pj3B2b5HMgyGHsJGt+NnZYkNmbLr2C1XBPiPHxtzjjKgwEzKmVGb1G8xI
X-Gm-Message-State: AOJu0Yw/9ZIkkUCbmZHI+fMQrWfSNjnB5+T/hgQaM7uLt2cnHGrqWYBa
	pU28szjr4G5MeErEayvcc1qjebBGRr0HKuIsCTTYutHmKrBmV+O6sT/73k3SEJxvU2TV7MTQrHU
	ch6mfsg==
X-Google-Smtp-Source: AGHT+IH2FOirSSch5FcGEGDoCjFKs74e4uclTkdsjyahRh+/pCJTXsu9Ub6OnV81qa7/VvgIt16JMg==
X-Received: by 2002:ac2:5607:0:b0:52c:8a88:54c with SMTP id 2adb3069b0e04-52c8a88077emr3697613e87.7.1718137618393;
        Tue, 11 Jun 2024 13:26:58 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c84a258e0sm1387726e87.98.2024.06.11.13.26.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:26:57 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebdfe262feso34867831fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:26:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfTE+wWSgIuDI0DtPdgAkCPKkG/kgnAm8UGtIol1EZ201+iaJhxkRLY+mR3YN/FYAFopFogB5lAaAUN290i+j8MzHJO3ZgL/5xRm48
X-Received: by 2002:a05:6512:b9f:b0:52c:785f:ae23 with SMTP id
 2adb3069b0e04-52c785faf05mr7126558e87.24.1718137616651; Tue, 11 Jun 2024
 13:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk>
 <8eb5960f-17f9-4d94-9b52-dea8b475e9dc@zytor.com> <BFD0AF77-C95E-4B8B-B475-DCBD808CA5C0@zytor.com>
In-Reply-To: <BFD0AF77-C95E-4B8B-B475-DCBD808CA5C0@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 13:26:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+1kOrg3H7wDBEVG2nw2xeB0F_YBqrw=bMBo0nRNtCKw@mail.gmail.com>
Message-ID: <CAHk-=wj+1kOrg3H7wDBEVG2nw2xeB0F_YBqrw=bMBo0nRNtCKw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 13:16, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I just had an idea how to clearly make this type-safe as a benefit.

You mean exactly like my patch already is, because I use the section name?

Christ people. I am throwing down the gauntlet: if you can't make a
patch that actually *improves* on what I already posted, don't even
bother.

The whole "it doesn't scale" is crazy talk. We don't want hundreds -
much less thousands - of these things. Using one named section for
each individual constant is a *good* thing.

So really: take a good hard look at that final

  [PATCH 3/7] x86: add 'runtime constant' support

at

  https://lore.kernel.org/lkml/20240610204821.230388-4-torvalds@linux-foundation.org/

and only if you can *improve* on it by making it smaller or somehow
actually better.

Seriously. There's one line in that patch that really says it all:

 2 files changed, 64 insertions(+)

and that's with basically optimal code generation. Improve on *THAT*.

No more of this pointless bikeshedding with arguments that make no
actual technical sense.

             Linus

