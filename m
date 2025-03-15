Return-Path: <linux-kernel+bounces-562524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F2A62A81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3173AE9F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C461F4E38;
	Sat, 15 Mar 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/06oT5"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CA15098F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032355; cv=none; b=AfM2ABCoB9uX2ypDxP6ndo6kp21bGhHKyKktuk4ZcVuZrhYK9pCkPw4bKHwsEvnNn4k/Z2KcJKS63pRQgNNV4GcaLHId/nDtZkTdirYLf2lZJzYsB+hSK7kZs3FVG+czkt6zfQHpwQUDyyDFjwnxP+h0uvchwiNbLkKPvszlYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032355; c=relaxed/simple;
	bh=xTGvF3Ir9tZ2m5SS31fb9uKV5JmrGPMCnhfRcKQITeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBKmLVE5QiMAg9jlvNunaqlYZgKWeG/qkSk9x7hSOgaCdQNNobdlfgxTajCEKHd/5Gjs+4o30imXGmUG0SreFVgByZJyJgqXxXIfj0cYtRvYHce/V2G3VgcaoghNIS+3F3IVZVsVEFwlz/y2hrem7LTZ7DOOGtXwde9m8rd/pC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/06oT5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bae572157so29494931fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742032352; x=1742637152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAFDPR5P5AoiJc8yKYq7TWHB5cRXWpXtC1zcY3B02KI=;
        b=H8/06oT5cTlu13qk9PS1ZTUeP2NZQEVm43c8AQgVotf89HdN80+1uoQWmlY74kz8j6
         EFgSdDSFC/kiczNjNoMKqEaqA5Cm1V/Z2srShk7+FDJe7wE+aWRplVzEH3f+NVywAjv+
         IgSlX4I+HvLSvqxZ+JBGeJJE08IgjF9lPKZCoHE5cwGKOdh9uLPEc2zYopRGa6NDMu8n
         kRX7L3YP9K2YliWzTEEmWWTXpxX+AlXJE1qq1NeaR2JBmU0INu8cw5v9dotkry/iUOEf
         IAn6yXo4GMgwSobZ6jjj1l1twjkyGtKceRjHxVk72Ex6X+hKj7JRrvRr9bVh60OySdU8
         b8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742032352; x=1742637152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAFDPR5P5AoiJc8yKYq7TWHB5cRXWpXtC1zcY3B02KI=;
        b=XebKJwU8bzNuMun78b6gPpxpVzAe0DuiGTTFKqq8zMd5KxIvmdjSIesFDBPruFiPIe
         PYhrGFW8s6utemmDgvzUFoIyksk6aRwM2gnNhuJtiOZlbwOw2lVrkXOv7yGZd6/Af42o
         7+meogTK4UA2mL4ySXcIXX3q8n1D4TTV/MN5KuTAznvBfa8UZ7NqajGxIWIDmLEidR17
         BdipsA6mbblM2C/JI1iFu2Cqw2v1/SwZvvWwKaA+A/43G3mQl2VU7Exq6kt6/IP6cnX2
         9kkvgMh8M8JdwhxuxZXD6oek5qYklXElL2tG9HiOLfdu8MjQuvORL1dq/yM8GxN/lsE0
         x5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXqdf71mMiWVSgBY3GnE0X+fRjqNRpznPiT2QSvGaWlikm/31ml9YylVzMok5HLo4hHvayIe09aXJOQjUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynecZD+Z7PMDoic0vRBeb5GDP+I6mb5C2uuLqMLhoMIF28tYwr
	p7y8TC+tdcMg5y/A4a/Cv3OmbTQagFQX1oKlf7/PlPeF3X/IH9Kt3wTRKIbKCMJeaQh359zfshW
	W3KsCJQlqHkv7dWjpjZWrdubGC54=
X-Gm-Gg: ASbGncuFVegT3XPbUI8w4/wK2SC/QSPdNqa+t0fUsc6lanjI6MfQrQHLXcVgacbdVOm
	hi0IJvjaD/M/jrOEFZ/eQwkmYFXzon9PCviTv9dhTYrfIJ9uYMVW2gDDueXYUlTerfTyBnl5p5Y
	coWzUuQ5Cxi9mhfC9SA2iiuGLWQg==
X-Google-Smtp-Source: AGHT+IHULw3O+TXkTRct7wV9eNc4lkNGhkw5ireDGy/w5V3vOJtUhiT5KkDPWZpf/cDAdkex7t3m+3I8HdYLPto/9Lw=
X-Received: by 2002:a05:651c:b0d:b0:30b:8f60:cdb7 with SMTP id
 38308e7fff4ca-30c4a8c3cdcmr22387131fa.24.1742032351769; Sat, 15 Mar 2025
 02:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <tcizy2pikr4nonjo3bi74fr63kctbh6333rxdkoeb4bnnnwffn@qpd7igl33f2e>
In-Reply-To: <tcizy2pikr4nonjo3bi74fr63kctbh6333rxdkoeb4bnnnwffn@qpd7igl33f2e>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 10:52:25 +0100
X-Gm-Features: AQ5f1JoXpaDgsi6sMbl0SnmUGE_70BSjxpfdRmHzzeb96xqZuL8JThpiShYgNTY
Message-ID: <CAFULd4YXYSFN+0KnmU0G0gx0rHrGKR_X58ZOhUVbWDd9cTJfuQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] x86: Cleanup alternative_io() and friends, prep for asm_call()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:25=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Fri, Mar 14, 2025 at 02:41:13PM -0700, Josh Poimboeuf wrote:
> > Make the alternative_io() interface more straightforward and flexible,
> > and get rid of alternative_input().
> >
> > These patches are a prereq for another set[1] which will get rid of
> > ASM_CALL_CONSTRAINT[2] in favor of a much more flexible asm_call()
> > interface similar to the new alternative_io().
> >
> > [1] Additional 20+ patches not posted yet to avoid flooding inboxes
>
> The rest of the patches are here if anybody wants to see where this is
> going:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git asm-ca=
ll

FYI, you missed one conversion of asm involving ALTERNATIVE in
arch/x86/include/asm/nospec-branch.h:

void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
{
asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
: : "c" (msr),
   "a" ((u32)val),
   "d" ((u32)(val >> 32)),
   [feature] "i" (feature)
: "memory");

Uros.

