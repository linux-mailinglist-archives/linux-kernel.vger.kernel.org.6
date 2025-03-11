Return-Path: <linux-kernel+bounces-556815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4ADA5CEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A4F1894A20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC9A2641F1;
	Tue, 11 Mar 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOfCouex"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F105262D32
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720176; cv=none; b=aWC7rqnnfbWBtR+Eh8QoiBGrWaD23TXB9BzM9SwJGvcXpObOEW1EUGWkoWe+yfaDCUcAgd3mv6vBIrI/ehcAQmgNmUR5sKgGByq/4c4HnJ7jTcl6ulvIGkA2TwhYLv1T4B2kW8rIjmbagFJLOMygZHnwIdJEKD2XmjQAfQJKi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720176; c=relaxed/simple;
	bh=MT4KIEXDYAda2ZPIqFmDaXeAzKgL5BjwsOEQyMFsJW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU3CEMO8tpiHcKtdWdHq3tdE3FE0x9UGOnxirHMNtKp/7AmP8RA7zbGhwY7uJqUzldEcht2g5sUMMRgmyF+8AkECgWfqiwwLmRPcJfGEBGmNSzwgP/i9c7INUsytWivCoOxPglhqz8BhJbBq5/E3XDGPVACWPIea2IzBXdxwyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOfCouex; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769e30af66so53261cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741720174; x=1742324974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFAEU/m42kolI7o2UBtagA4X8ZayRpTZW4FmPY5DRL8=;
        b=JOfCouexykl6rJAht6yMLmvKxaZ/9iPwl7WRacSc32pnjZ0fUL+3Z+9OFL+sgheBEB
         DXJARGySpAM7dHvU5lVP7tDZa66rFq+aazWSNC7GQx/eRORir+YbZZ95xUXvRSf3mWUT
         N5VX2CrAJx2d6YK+VbUrai4jsgJx28CVt7IFaSNXQNy7dbAjZPiGbBykPTYDHUtr5qTR
         9c2wkch6rUhr+kLQOgV131zkYDhL0sxCA2IZJ6LHj2pSQQEG/5IpiXZbSNRlJXej8ffs
         4pKwIjLvdOu5PIXLTUBbjJa3LRDeTza+5WRW6K0qP+3vzgtHn338plmNQ0XNj3Ny4XKo
         MrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720174; x=1742324974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFAEU/m42kolI7o2UBtagA4X8ZayRpTZW4FmPY5DRL8=;
        b=dF0EgYGqSv/hrhHfh0dsbxIFzDSxT15/zPVpkwiP4XNdKBdhQXlEu41fzt3MEoR5F5
         9U4tQshSF/HPb+bPT3waZoDEz+J3EQGK4jNUTcNsNb5Byls6vhAI12hXLNL2eBxAi19j
         y8Dqm/7W2zsJMkgwWzRtdQCZZ7+d0lYWAQVkIyweiYPYNcCt8ZgW67B8l7gXmzYrpTPU
         w2HG1/CrUFsOL1HBZ6gGqUZbnkZlVhgJdikmO362HsjnMk6njORWd4SuIHOwZO6qksWZ
         2REaPE0eWYF8L1EafcxLpJVycINvfNDvjuawqAxl9piW+TYl3oaBv9xQ3YTcNGvMpq+E
         Kk5g==
X-Forwarded-Encrypted: i=1; AJvYcCVLnNNO3/RMxRDUge8cY6tC9QnrssmKnieDakz5JYTkLYSdDtQOSElSOH9EeBSywwQPHjXgaD+U9IFg96c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/0dqFFvq2Ah4D1uS6thanJYarFRJxU20Kn3p4sjvlS7daqds
	SWOCK+yWyq6c0/VJrfpAVYNLHNw2HHwVT0RwQdw59IjqgPH05ZRWw3KJE9usEs8W4KXAu0iLrBv
	tDaao5cRsfe5l16mrOP3aFwVhcttGIJJ60t6L
X-Gm-Gg: ASbGncvDMEJHcnq/NkZHh0yL61udjIoZZFJCQKUQiNLk8Aj4HVDIDlVZGWTdOkXgB92
	p3GB/ZeWThGMV2IufarWZfXR33216KpsUxDwjbedJzIO4+IE7h42GUUwfwszZwjsA+Rkhnjk7Fm
	IS+g9brxGvmK+CcTqXBPYzGnhJq0+gSTUPBO1oVUXS8lxFTNnRIn7JxJHv
X-Google-Smtp-Source: AGHT+IHC917nAvWIA/Bj5kyqPPfwGwqj9CH/w5Z0oWa/lQ+m7IY3UUlwjuwuqez0X6+HZVxKqmjsaUkxOVHXJsK3yVs=
X-Received: by 2002:a05:622a:87:b0:475:1416:5cc9 with SMTP id
 d75a77b69052e-476ac43023emr739401cf.10.1741720173802; Tue, 11 Mar 2025
 12:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224124200.820402212@infradead.org> <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net> <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net>
In-Reply-To: <20250310160242.GH19344@noisy.programming.kicks-ass.net>
From: Ramon de C Valle <rcvalle@google.com>
Date: Tue, 11 Mar 2025 12:09:22 -0700
X-Gm-Features: AQ5f1Jq1r4Lml3jLS-NMmbFgi85kOdzC-wdrdZA59dLGP6T7oPwNiU2pQejz1Kk
Message-ID: <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Matthew Maurer <mmaurer@google.com>, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Mar 10, 2025 at 05:00:47PM +0100, Miguel Ojeda wrote:
> > On Wed, Feb 26, 2025 at 8:53=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Feb 26, 2025 at 12:54:35PM -0000, tip-bot2 for Peter Zijlstra=
 wrote:
> > >
> > > > +config CC_HAS_KCFI_ARITY
> > > > +     def_bool $(cc-option,-fsanitize=3Dkcfi -fsanitize-kcfi-arity)
> > > > +     depends on CC_IS_CLANG && !RUST
> > > > +
> > >
> > > Miguel, can we work on fixing that !RUST dep?
> >
> > Thanks for the ping Peter -- we discussed `rustc` in the couple PRs
> > that added it to LLVM back then, and I think the conclusion was that
> > it shouldn't be a fundamental problem to add it to `rustc`.
> >
> > From a quick look, the Clang flag that eventually landed just emits
> > one more `llvm.module.flags` and LLVM takes care of the rest. So it
> > should be straightforward to add a `-Csanitize-kcfi-arity` in `rustc`
> > and then pass it at the same time to both Clang and `rustc` in the
> > kernel.
> >
> > But I may be missing something -- Cc'ing Ramon and Matthew, since they
> > are the ones behind sanitizers and kCFI in upstream Rust.
> >
> > I added it to our list, and created an issue in upstream Rust for it:
> >
> >     https://github.com/rust-lang/rust/issues/138311
> >     https://github.com/Rust-for-Linux/linux/issues/355
> >
> > I will also mention it in the meeting with upstream Rust in a couple da=
ys.
>
> Thanks!, let me know if there's anything I can do. I'm happy to test
> patches.

I've submitted a PR for it:
https://github.com/rust-lang/rust/pull/138368. Let me know if you're
able to give it a try.

