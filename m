Return-Path: <linux-kernel+bounces-210704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348359047B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA54C284AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40A155CB1;
	Tue, 11 Jun 2024 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AJtP07Xr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC04594C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148887; cv=none; b=a11AiX0Zm4nXmSF1lCdmtT3yCm9iN5J0hUzfllLpE9aAUBx12W4CjSTYNKFSDMl+YtwdHdk2nJx6LSou6L1xjkfW5ySyLrf/dQ3XI/4iWpntnGw1G+IDBoA78J9dcWtHufH425rqYgPRHhEgo9ygF8HRVufyOUyaKjFAC+YbTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148887; c=relaxed/simple;
	bh=vnTp5C1q32ULDWsVgiiLtkZ6zL+dpM1Y6tx5qcG0Wgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPvVEqKc2Z8d0YKTPUvoEpBJYMuinbujOzRBrj2n/DyrYR38QuZuBAC9fEK3qVW2otppc3JkrX6DT+rfm93SSYKjb2/P6P+qfhlmy6cci4XSyR/tHydOkikpr7QBRhZbjvgFA+I7D1ilzqC8e8VpbehTP4qLWXxGbGX/P3dQGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AJtP07Xr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c525257feso4697269e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718148883; x=1718753683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6aiBpkg+Y6Isx66NjusATX/r6xtB4QNiCkHibX6jkg=;
        b=AJtP07Xr9yMP5NR24k5e6v8nVybI7DVvM60OgCR4N0O4Zj4zBv4T5zoA5ynW6RhLNG
         +HC+C2CjB0bNPgnMtocPXp49JYpFx5Y1CRiMDPRqfTAbetmW1tt0JNbQBgDzpepaBh9l
         vfpGzyxFn651vw1tjzFwbflR+X7kcvySNZoUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718148883; x=1718753683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6aiBpkg+Y6Isx66NjusATX/r6xtB4QNiCkHibX6jkg=;
        b=aYgMAfqaO9rnUB5GT4rEgo6MqljdUnYXgn9uRNNOTt3rqYCftJLoSWa99hcmDugqov
         pNBnFy0J0vD6LnF+3aeWUEc15VG4tW0UH/osNtFK+WAxhp1y/zvdiDG6W8Sr+6oT+MEk
         cc+nKpt+8ka1EOXekocZZLf6bc3IwdyZrAUvKWKjpg5e6rspaJB14p31Y5JbZeRAvHOu
         5cwBmNDC8ZR94zcdNMSvuNd7KzcXy6uZNGoYzERMRX7HILvSvNmawf80ldTIqKth6Znm
         ObKnoA2QTLIeWm+DXGg2I3pm/+6LezrS9OpoEYLOOg1qtzsHanmcFZ5PtpZlUYY6TO3h
         2muA==
X-Forwarded-Encrypted: i=1; AJvYcCW3LRPzeT1kJRrTIXjWad+eYkXU3UpmzmsFjLttVfRwHniWG/zNLfb/dxs9kzMly3+o6SHFNY7xtmbl9Az/Slhb9pcNmH3oB2jWyhg7
X-Gm-Message-State: AOJu0YzHF2TzaeY+IRKWheEK4p8HG+qzgw7/7s5fj++lE6WS0pnefp41
	azNCgh/chGVlGoKeUZ1a3ATi0aIWxK9w9obYAgHzbrxU0KL66MAybDcN2IJX/Ie7cWA38jGsW3j
	3Q39PZw==
X-Google-Smtp-Source: AGHT+IFPlFPiofL+SxUSX0m3+zlL4o86iydOQP/g43k1Ke4iwgMmVBuhoSopl92MtEnMAsm791GLcQ==
X-Received: by 2002:a05:6512:1599:b0:52c:988c:6e6e with SMTP id 2adb3069b0e04-52c9a3d9604mr114665e87.30.1718148882995;
        Tue, 11 Jun 2024 16:34:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1c0fe610sm349340266b.91.2024.06.11.16.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:34:42 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so2850837f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQ4ETX1ScQTKK/PiwdTrDO5AxsN6OuAzjU+J/0u+ZVESoYcwMb7MGRXs/ygw+GCeUwEc5uwSKQQm/xBVwa9YT3Jjl2jqf005vxhlrs
X-Received: by 2002:a05:6512:3b9d:b0:52c:82d9:66b8 with SMTP id
 2adb3069b0e04-52c9a3e0935mr101179e87.36.1718148574257; Tue, 11 Jun 2024
 16:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-7-torvalds@linux-foundation.org> <20240611215556.GA3021057@thelio-3990X>
In-Reply-To: <20240611215556.GA3021057@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 16:29:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4mwfbUQwEVDhEsA9MxZKTdTyOKTQa7n8M68_6fxo5Aw@mail.gmail.com>
Message-ID: <CAHk-=wg4mwfbUQwEVDhEsA9MxZKTdTyOKTQa7n8M68_6fxo5Aw@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: start using 'asm goto' for put_user() when available
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 14:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> > +#ifdef CONFIG_CC_HAS_ASM_GOTO
>
> This symbol was eliminated two years ago with commit a0a12c3ed057 ("asm
> goto: eradicate CC_HAS_ASM_GOTO") since all supported compilers have
> support for it.

Hah. And I was trying to be a good boy and keep the old setup working.

Instead - because the HAS_ASM_GOTO config variable no longer exists -
I didn't actually test the new case at all, and it only worked because
the old case did in fact work.

Because fixing the broken #ifdef also showed that the

  +       _ASM_EXTABLE_##type##ACCESS_ZERO(1b, %l2)

line was wrong and was a copy-and-paste error from the get_user case
(that zeroes the result register on error).

It should be just

  +       _ASM_EXTABLE_##type##ACCESS(1b, %l2)

and to make the nasty copy_to_kernel_nofault_loop() build I also need
to do the proper _ASM_EXTABLE_KACCESS macro without the zeroing that
didn't exist.

Oops.

It would be nice to get rid of the CC_HAS_ASM_GOTO_OUTPUT thing too,
but that's probably a decade away ;(

But at least  this made me now go and actually test the _actual_ old
compiler case (no asm goto output). Perhaps ironically, I did get
*that* one right. That's the case where I had actually checked the new
code for get_user().

             Linus

