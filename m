Return-Path: <linux-kernel+bounces-519988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE8A3A46B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1883D189287B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF226F45C;
	Tue, 18 Feb 2025 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lvbGNuO"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274E23497D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900089; cv=none; b=uxsyDUgT28dpsF8LFF+OuP1StPq15MG8ONQmONEMdQrL+6mfVkBAc6h8WOkEAX+KxgBAQ5215+R18AQybk46uuuwENRJsN4o4wvDDdxXcTnUJq9CI+vWTRotb8yAetvGkaQqrlFJba4m4R41v+Z1D9v1ULjBzO0GVAffIbYptj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900089; c=relaxed/simple;
	bh=RYe4Ml2prJU23zBpyMoGM4BQ+siusE+C9t1PTcfWDEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuGK7MbM/U4xolNKJgdE7G4z3AaxiwDAVTKnf+/0MvivGyO3wFcN5BNXGL/vKDxsmCzV4wxyHmXBAeRfKRTVTQ7NFeynwOg4r3FAuSKUp5MrvU+dfgOTbzqEqSqq1avyEboV+EORgEqZQeN8sXgz0r72yA6iGBqq2j0PTFaTv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lvbGNuO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so24169311fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739900086; x=1740504886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfW36CEJBX+QFUXB41GrziKudJM9/Txa2CU7hlT1tzk=;
        b=2lvbGNuOFodjmHaJXtaJpOXw0VQxonJzQwPRTd3pPbt/p6pJihiQgMmC8eiFgd6mYg
         q76jYJP8qx2Oodg00H85sVtY8kbNSLhVo55fa+krX0NAqxpCnxH8OXTKUzNwJr9UruHC
         UPBsrMD042m/i7Tvn3HpYCgb+euCJbUiIe8ez9kzBDzK4ix+jtCdDMhpjm8zvIE0xg6n
         nRbTh3ep5Gp8BMlcuuZpepcP/GHXWNUVBZNXc7bxH5ImBXo2pnjQYjTejbh7QDMgZprL
         X3D5pglEZBbspqTKfI9c8LpM4MoOfzb4XM5J71g7IXtsn+YfZ2vq3QaTsFRSzJ7d75Kk
         ccfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900086; x=1740504886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfW36CEJBX+QFUXB41GrziKudJM9/Txa2CU7hlT1tzk=;
        b=YwYQ5S7fin67xBBkjDGcTjzXnPCCbFEV1viITtAKvBSG/Fcgs8UMYLGCJuW6Nbo53c
         ANNN9/eD+e5XJ/BsVJQX+X74iJqO40jD8BkN/MqAzubE/Ppb2kuS+YVcmeMYef6TuRcI
         GkMZmN6uuCZNvawVRUFe34l46wQ6sNKYYAixrWQIvKRuZTszSvsc2JvIbPQZvhTBK6p0
         uEyhz0x0Q8MS7zu2+ezKtlKrzUFQiXYzWzqDxldHFOZOkEMD+lTbcfl1CkVrQjnupu88
         a6um6HOuRC2Dee/2cSMXlbEFYrPoBYw43v2vWrDjlEW5OKESgzKoT5L8aIZ0ikeIPHJH
         otpA==
X-Forwarded-Encrypted: i=1; AJvYcCVFKga8zVatnfSzsDyAbJ9Nkd2o5UVaFhRFlzoBcpGFbnsvlvMGCMn62Zj4Rx5BDNjQ+Ne6DymitC+5+yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYruON5Va3xYmTZW0HKpe60Y/q3h83t+4wXcc+9nXnd/bKq8N
	EPSYVkExxCXsVmWSdP+LCfiO4Fr7h8sRkgS+KxG3v/RLZlF+wC0/3sI4CcyhmIs93yR/WnHsPdd
	FI6EUR0FY15TooAw8zTEwuAb3T4cbvAOAn2CT
X-Gm-Gg: ASbGnctXWgafBo2UiRjlHo5XF0ZXakOI1wGrIGocWLaavuPhGbD/HQUXYnKzcr6k6qZ
	9M6vtCdOBgFfjE1cc2H32YGSgXepUUqGlCllzv+TvKlN283+03JmRhMo/J2L5ss6HlRxSG6pLLi
	X8WVrhVWc4G31xlTRu3FSh8UCtfQ==
X-Google-Smtp-Source: AGHT+IF/Ti4E9RTJirBYzGKLERsmarFkfxpZZdYvTjtsjFuPaskxSPlcp67YvCteLQu+1JYfXCRN34XezRV9/1X8bAU=
X-Received: by 2002:a2e:9bc2:0:b0:2ff:a928:a23e with SMTP id
 38308e7fff4ca-30927ad673fmr45379881fa.25.1739900085961; Tue, 18 Feb 2025
 09:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739894594.git.dvyukov@google.com> <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>
 <Z7S8SAGt8blFiFTg@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z7S8SAGt8blFiFTg@gourry-fedora-PF4VCD3F>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 18 Feb 2025 18:34:34 +0100
X-Gm-Features: AWEUYZkxxwwRb99IcB9I3shnwd3XLgfxKSaJZ8SmyYG7ZqeRgGZAEmghbRplZoE
Message-ID: <CACT4Y+Z3ismwdeqa7iMo0JVD-u-nvSmN2eS5qJ5tUqXT9NjWcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] syscall_user_dispatch: Allow allowed range wrap-around
To: gourry@gourry.net
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 17:58, Gregory Price <gourry@gourry.net> wrote:
>
> On Tue, Feb 18, 2025 at 05:04:34PM +0100, Dmitry Vyukov wrote:
> > There are two possible scenarios for syscall filtering:
> >  - having a trusted/allowed range of PCs, and intercepting everything else
> >  - or the opposite: a single untrusted/intercepted range and allowing
> >    everything else
> > The current implementation only allows the former use case due to
> > allowed range wrap-around check. Allow the latter use case as well
> > by removing the wrap-around check.
> > The latter use case is relevant for any kind of sandboxing scenario,
> > or monitoring behavior of a single library. If a program wants to
> > intercept syscalls for PC range [START, END) then it needs to call:
> > prctl(..., END, -(END-START), ...);
>
> I don't necessarily disagree with the idea, but this sounds like using
> the wrong tool for the job.  The purpose of SUD was for emulating
> foreign OS system calls of entire programs - not a single library.
>
> The point being that it's very difficult to sandbox an individual
> library when you can't ensure it won't allocate resources outside the
> monitored bounds (this would be very difficult to guarantee, at least).
>
> If the intent is to load and re-use a single foreign-OS library, this
> change seems to be the question of "why not allow multiple ranges?",
> and you'd be on your way to reimplementing seccomp or BPF.

The problem with seccomp BPF is that the filter is inherited across
fork/exec which can't be used with SIGSYS and fine-grained custom
user-space policy. USER_DISPATCH is much more flexible in this regard.

Re allocating resources outside of monitored bounds: this is exactly
what syscall filtering is for, right :)
If we install a filter on a library/sandbox, we can control and
prevent it from allocating any more executable pages outside of the
range.

The motivation is sandboxing of libraries loaded within a known fixed
address range, while non-sandboxed code can live on both sides of the
sandboxed range (say, non-pie binary at lower addresses, and libc at
higher addresses).

