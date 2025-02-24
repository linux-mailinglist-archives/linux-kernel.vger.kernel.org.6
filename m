Return-Path: <linux-kernel+bounces-529132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB97FA42017
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E63165E56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE11248881;
	Mon, 24 Feb 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OG0l2yPc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13580248862
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402825; cv=none; b=b9uEbko3FVbx8oRb5kWhyiHpoNZTJ0LWUCkWM9RleFyZFC1PnAIs4UgDD3lyfTdDxGj5auxbj1t1kzzGKVUyv5nuUgwEFPZaefqOOau8zcbBEATIjWipSx5xSFTHrZ2BMpL8s6DjRUxxPXr7Tu1qQ8oOnRFKc9KbaV7NiPIzRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402825; c=relaxed/simple;
	bh=FJoND9jFNnnNAMkgzJFWDjRCMTnPwYnnldsd3k5ZzjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjNy8qgtYyTt6mlZ+jlrvHfL0P1IJGHlxJV4gSWttyLDPPSpz6kgBFijXDT1Vq577uCaEEds+ZLrD3UU/Syqy/hF6tqDvWi1qx+i71pPuzqSZiXF26ojXXQILuneS31AP1VABahi0BonWRQKAYrq7NqW48KAwEsfpV1iWiQBPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OG0l2yPc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54524740032so4609525e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402822; x=1741007622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdTbVKi0CUQDbJRgMdFniAozjWCEaHtWyxLsgTRQpmw=;
        b=OG0l2yPcGyY7qrylzB04aNlbB9pPBG1k6mRVv0uw/yuTwPap1/WDYYylt0RS+5Q5sz
         IjyO/oVmrmey6lBCUblvnV/Sy594iJ/nCwx0O6fWkFFiKLBjVOESIjw8DFPYZN6bpp9P
         TZTMXaJLizK0R4APJAvuP4D3IBCmwiTSVKyYtPYriv67SHweXSQcaYeOizTVhs4NqC+B
         ab6PxBwqTBpQ2b/XUm100sce6vsd79WrUDgfxzM7r+IBQg5mHQitqs1iAjLq6SpVnbrl
         Mqy2X2hpSslgaxcyGCzIlWvd0bDLJi/XywQdj7fmPCewllslCYR863KTTGjBLi4IKhk2
         pcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402822; x=1741007622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdTbVKi0CUQDbJRgMdFniAozjWCEaHtWyxLsgTRQpmw=;
        b=O7nA4bNJbVqsktZ+GKebXQp6mkyC0iiZZUk2ghyXng3AgctgzLr/BjB4qxqO0r0RG3
         SVYYPgoVW1Zqw7/zagP3OLOzhePllmvifP8zg52PolYW2W1Xn8cJhyZxYYUjQF4zkarW
         iDucqBwoXh6fYQ9fvC5pbC6k3n33OJXYDRHVEDF+89Ls7M6HvCyCdWoOU6NdOwOm7IES
         caN4oLi779QJIeGkaPd9WypI1xrUVzwzrWdKNeCa/RoRWkv2R2lZrIRwRiZDGohLarwW
         cy/qEGnMtTZ6ucq49v8MrBLZGq9XmmO4OlGYUbFOhSYikE8tA25exRixRBStuX5pQcFA
         cxHw==
X-Forwarded-Encrypted: i=1; AJvYcCVvyUycIOMtFEkpUz1MO82pdYB3jNHgeRdoCqf/I1qUOovDb857c9p2UQd1p0xBi14rPQkbuuZ3JXyTyDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUcanhU7LYfMjb7qTwr2Q+LD2J6R2usMwsQGLBonFF6eTW2Dh
	5BvY/edy1yYJ+C/a0BV6QpI1YWKUdCamQqyr3jnxON9WQGr5FPd+s/Um9P3QGGwVw3J1THkFnML
	pThJ47JL5V53k+TZF84Ns18pBUk12fRxaF0Jx
X-Gm-Gg: ASbGncvABdd12Tldn+DmmBzfPtYmzSdXSp4BjhCAoToEFk8BvO+UdIwheuCa1gvPqoJ
	tFWd0IXsX919saZ0iO8za7t4v34cIOV7Idwf+/B+4ys73WYQqsdNdg11BLa4ORZ5BlXtI4sq3Uf
	U9AFh/xBJ1nWIqVnDQavKY5u5ArBje9+m7J91H
X-Google-Smtp-Source: AGHT+IGQrvsr4odKUEgeH1bkkZjegayIkiqYClbMrE0j3eOYhXJOuvoctFYePfM/+qd8DmdTmo8UHRlGJd684M6yAAU=
X-Received: by 2002:a05:6512:31d2:b0:546:2ff9:1542 with SMTP id
 2adb3069b0e04-54838f79e55mr4764605e87.53.1740402821962; Mon, 24 Feb 2025
 05:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <6a97e9986b0fb05935204f55f8d16fc5e66f0ccf.1739790300.git.dvyukov@google.com>
 <d6d7745f-ad25-4faa-a3a3-65a4604e8592@intel.com>
In-Reply-To: <d6d7745f-ad25-4faa-a3a3-65a4604e8592@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 14:13:28 +0100
X-Gm-Features: AWEUYZlYLWq2aISpHvFPgJAzT8TTyQJjq1PvXwFPLhQWiasg7JhczNUZf7FZBLE
Message-ID: <CACT4Y+YmdnTznWw5LO4gXHbxbXNPj0jqOO3KG=dJWKEcVbrkvA@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86/signal: Use switch_to_permissive_pkey_reg() helper
To: Dave Hansen <dave.hansen@intel.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 17:26, Dave Hansen <dave.hansen@intel.com> wrote:
>
> ...
> > -/*
> > - * Enable all pkeys temporarily, so as to ensure that both the current
> > - * execution stack as well as the alternate signal stack are writeable.
> > - * The application can use any of the available pkeys to protect the
> > - * alternate signal stack, and we don't know which one it is, so enable
> > - * all. The PKRU register will be reset to init_pkru later in the flow,
> > - * in fpu__clear_user_states(), and it is the application's responsibility
> > - * to enable the appropriate pkey as the first step in the signal handler
> > - * so that the handler does not segfault.
> > - */
> > -static inline u32 sig_prepare_pkru(void)
> > -{
> > -     u32 orig_pkru = read_pkru();
> > -
> > -     write_pkru(0);
> > -     return orig_pkru;
> > -}
> > -
> >  /*
> >   * Set up a signal frame.
> >   */
> > @@ -157,8 +140,18 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
> >               return (void __user *)-1L;
> >       }
> >
> > -     /* Update PKRU to enable access to the alternate signal stack. */
> > -     pkru = sig_prepare_pkru();
> > +     /*
> > +      * Enable all pkeys temporarily, so as to ensure that both the current
> > +      * execution stack as well as the alternate signal stack are
> > +      * writeable. The application can use any of the available pkeys to
> > +      * protect the alternate signal stack, and we don't know which one it
> > +      * is, so enable all. The PKRU register will be reset to init_pkru
> > +      * later in the flow, in fpu__clear_user_states(), and it is the
> > +      * application's responsibility to enable the appropriate pkey as the
> > +      * first step in the signal handler so that the handler does not
> > +      * segfault.
> > +      */
> > +     pkru = switch_to_permissive_pkey_reg();
> I think this hurts readability too much in the get_sigframe() code. On
> some level, it's silly to have a basically empty helper. But in this
> case, it does help keep the signal code readable.
>
> In other words, this would be preferred:
>
> /*
>  * Keep existing big comment
>  */
> static inline u32 sig_prepare_pkru(void)
> {
>         return switch_to_permissive_pkey_reg();
> }

Makes sense. Done in v3.

