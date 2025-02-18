Return-Path: <linux-kernel+bounces-520020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF2A3A4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD6B7A3389
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF126F454;
	Tue, 18 Feb 2025 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="C+g5n2pW"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9A18CC15
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901636; cv=none; b=Quf87Rj+Jo0TI05ZIGEQaBH2h3Ur4wF8fDPj7arCpZS/sC/sxgzIWCSYAU35wcgKZiLXW7L1MQHX+k/aLHJMpdgo8T9EkUT7DwhXpl6NJ/Q10hsk5XBHNbXUBTzUmjKd4HxIUdkW9RCa+F3RTVeW/oCgKvIYqJqc17RCTdTzGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901636; c=relaxed/simple;
	bh=1z/lv4vZJdAQQnGTqXm8v0ZLOFlsowyJnVLvs25uscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktTLQKZ4EylBXuyOsq8guKrtDkKP1JIW1nXWeSKD+qXoo3syMns7Za3E12yakLEv1V7Mw3jt8A+rQL4utXMRl09noBrcLkcjW/r6HEnOKWm+opHXcJ7O1TP8EkZMiUnu1P8Wl/CBSoXNrP/nzltseVeP2abSQdN0xKa5iQEAYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=C+g5n2pW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd0d09215aso46698976d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739901633; x=1740506433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKhGhCwdxFXUCb+ucDeYz5zuvPrVUrGeftb/OVKAjLU=;
        b=C+g5n2pWHBQJtcHULqWK6+G1cXc4AXdudpAeOHRR1Znug9U6IPoWkudRu42wT/6TP7
         wAcS6SrBVu4T1v0M9ZhZEgfjPmYYpAAtMlLro+U926Ii0nm2soRhoy6kuAvIyvsfzWB6
         DWB6bRslBzLCNScsAhQptcHe9c6d+Mxh0VmFXWuk2j8YUcEJxLbvolVToc6q8EmY/JPI
         xjXHJAc3amvq+K/JGXUfc6nQc5OKKwr8jHaxyZOAg6Z9HmmYAatiynkkMSJsAtsvYtNL
         b71OU4lQktE7TAxx17LW+xaof8J3K1YZQgGiInxeEQWHe/7jLICrwGhmxfo7zzkfuuy5
         I7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901633; x=1740506433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKhGhCwdxFXUCb+ucDeYz5zuvPrVUrGeftb/OVKAjLU=;
        b=LGYFfnZZ8hrBRhgOIQEDGtu8bmGE1WejtTmaacVlr0wTRBSiIHAsxXN8EAW9ECn8q/
         UJmf0+Ix4B1m6f9z9UFS/HNxvlSxUpPuRqoo6BdeUsyht/NSQNZ5/4PuH3X5RPLH6lCK
         ZdGPUWDIxSESW2cJ7MZUNJbyLRcBKnnrXW3NmzneTpznTgwMWwW6/njDUNaXsxxbtwSd
         rLTxskVDslUHRd16amwWMULgA7FIj2AvYIfEi081AWTPzB6g18OPdaKX9JtzTF5rNbRO
         +pn41rSvSZ6py1TRNvUuk91e/Dn4pa6D8l6jYJUEgSPM5iXq2AeJViI2MtwG/53CKP1K
         ruMw==
X-Forwarded-Encrypted: i=1; AJvYcCWZnGWgNtG575DkE52q30S596x7XSJKquKn0Gym3Cl3RYzuUQ37/MAhSlHNOpIoR+96jEcYTqMp/ZpT00A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVIAD1OodKgq2KExMxMcfnzsildb4sj9v5kizkNsgrnY0edOU
	gUJRYy5aVgaHmbi38kRmOgkBHCi+s2aVn9DW9znjhK0nLH7gPKfZi8mZ2wek2ao=
X-Gm-Gg: ASbGncvm26OY4NIHp0wJJRx/GByXNVJB2bcBXfv2IrY6DK8ARg5D+JyFj9HfP2MTP35
	kTtn2DMTPKitxUvJGQdXkq0zKG8Sjz2IKtVWJPeYwtZd6CENrVa62vKDOTMqkmHn8nlH82mTrWn
	Hk8fNZ+y9nK59NZ2jpXRxcLkRGlgjpFGLr24KmfY/LTBjMRPu8KH0QhJQ6hwBbATrPS0tdIK7iW
	mfwmbAh2A0hEIP5JElkmIyQm5Nfi6mu9zbqYCA3omUnY9LOESnQrmctaCemKnVEBF7WdwtDQwK+
	DdUnYXoe6P6lLYGMbPy9rJdN01cg1fcXJ17yudXa8pJU2zLDl5wrmbifx1z2ymT6JDnOWE2y1w=
	=
X-Google-Smtp-Source: AGHT+IF3/DiKHs4o4R84u+oKD1Qu/y2pXXW50nyW+pTteK/G3pyZ3n2mpYfLTxwSK/whECrRsfjI/A==
X-Received: by 2002:a05:6214:cc6:b0:6e4:4085:9f72 with SMTP id 6a1803df08f44-6e66cc85d5fmr238941326d6.7.1739901631323;
        Tue, 18 Feb 2025 10:00:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7792e9sm65946366d6.8.2025.02.18.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:00:31 -0800 (PST)
Date: Tue, 18 Feb 2025 13:00:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
	peterz@infradead.org, keescook@chromium.org,
	gregory.price@memverge.com, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] syscall_user_dispatch: Allow allowed range
 wrap-around
Message-ID: <Z7TKvdjvmtzfjza6@gourry-fedora-PF4VCD3F>
References: <cover.1739894594.git.dvyukov@google.com>
 <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>
 <Z7S8SAGt8blFiFTg@gourry-fedora-PF4VCD3F>
 <CACT4Y+Z3ismwdeqa7iMo0JVD-u-nvSmN2eS5qJ5tUqXT9NjWcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z3ismwdeqa7iMo0JVD-u-nvSmN2eS5qJ5tUqXT9NjWcw@mail.gmail.com>

On Tue, Feb 18, 2025 at 06:34:34PM +0100, Dmitry Vyukov wrote:
> On Tue, 18 Feb 2025 at 17:58, Gregory Price <gourry@gourry.net> wrote:
> > If the intent is to load and re-use a single foreign-OS library, this
> > change seems to be the question of "why not allow multiple ranges?",
> > and you'd be on your way to reimplementing seccomp or BPF.
> 
> The problem with seccomp BPF is that the filter is inherited across
> fork/exec which can't be used with SIGSYS and fine-grained custom
> user-space policy. USER_DISPATCH is much more flexible in this regard.
> 

It's also fundamentally not a security-sufficient interposition system.

> Re allocating resources outside of monitored bounds: this is exactly
> what syscall filtering is for, right :)

No.  SUD's purpose is to catch foreign-OS syscall execution.

You *can* do hacky stuff like interposing on libc, but it you can do
hacky things with bpf too.

> If we install a filter on a library/sandbox, we can control and
> prevent it from allocating any more executable pages outside of the
> range.
>
> The motivation is sandboxing of libraries loaded within a known fixed
> address range, while non-sandboxed code can live on both sides of the
> sandboxed range (say, non-pie binary at lower addresses, and libc at
> higher addresses).

My question is why you aren't doing the opposite.  Exempt the known good
ranges and hook everything else.  This actually makes it easier to
ensure the software you're hooking doesn't escape interposition.

You can use the SIGSYS register data (instruction pointer) to determine
whether to act on the syscall or pass it through.

Like I said, I don't necessarily disagree with the change, just a bit
concerned about the direction this takes SUD.  It's not a sufficient
interface to isolate the behavior of a single library, and this change
naturally begs the question "If we do this, why not implement an entire
multi-range filtering system? Why stop at one range?"

~Gregory

