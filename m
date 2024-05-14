Return-Path: <linux-kernel+bounces-178706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9608C56AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331B428356D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DD14430D;
	Tue, 14 May 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtDHnUEv"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F11143740;
	Tue, 14 May 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692390; cv=none; b=hs6YxOOVck+la3biKYGE+XRYCnXL2+C9knwK4qyuMN1HL5875dp84keNev6TYBJCIC+UaZYtrf6NtMVq3+5QVbRXqDRJMfijz8whG4ZVfalgIO63VZnFtsJBRIuK5RwzORPFt2qrxYt8G/gPGCSh4lmkebfVQHViFekEBmbyAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692390; c=relaxed/simple;
	bh=2lHTd9vD3VaBq8JrPEYGQii+4KayEbxjkulRHrk3MWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAV0c66vAyMPqKbLSanV9SbEFyVconFT7Hu8bWvrBb98bYVThFMlu5uaYw9ToqalUhQXhMWG/BxikCalJZD6ybByICY/leLPhNYp7Jq6LWoLaetLL1Q4iYrAVm2A2KRKD3Tn7I1I1nUxzfQvPRzIbyV7YdPCR22RloGvbC/g9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtDHnUEv; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c999d53e04so2462342b6e.2;
        Tue, 14 May 2024 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692388; x=1716297188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aun1f18+4H8YVvMFiItfXiXA+SpbSD5X4Dn6XNELRpk=;
        b=LtDHnUEvawTvQ9gHc53BkpB99aoyQAL3yGmMl7pAaU1F0JlEJPPaK+clG/Qd0aM1k7
         rG/q/YhDi/jAyQUYmGMUCtTLiCreP0aGFBkd2zogwbMxUFdox5/9o55j0kdou5FD9/JG
         7C+dfbI4O4VETLJsyqXrkgpoaKfnKaRp/SomI3ieRPzNwQQuKIgLr06PPI6p805tIfia
         dnixFos01VL8azYHXEQiiGV3OT5Ia+5HlkqqvfHfHVfAYI3E+R67ZWArT70Yw0JeZsDd
         +8TaXjHJIYWmfg56noA0e02DVIEs5VSR0iCuhbGOTyvrATKfhvjuswJjLum+wL1w0/xx
         9y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692388; x=1716297188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aun1f18+4H8YVvMFiItfXiXA+SpbSD5X4Dn6XNELRpk=;
        b=Rcuh0OKqzBfecHwsLFNY/fG4GlRYE0z9bxGCeL0ZL33cSfz/JexbQwhwo+Z7CUk1Bv
         H2lNEEia9lVCrhb+xOYaDAkpaojQkvyfyU57PzJXj0xae58eG41HyOywrbwxoNBD4Ncd
         /0W4TINug6Ioq/sc85G+C9AOUXC31bm6RwJAQY+9dLRQvV4srw9jlvqXN3pnqjwA7XMp
         A2gOHqecOEz5Dm1w+WRExitbJa8Rgkc+jIy+U1P5ElgA16eUnXXXwjmylM8372FnHh9T
         /5KlPWRR8tOiIXCzmq5r7bRCiJMRaWe/+uIjAwYXPEPx3+LzKeQlwhr9lBtkcSHcHjGU
         S4ig==
X-Forwarded-Encrypted: i=1; AJvYcCWuUNMJosKkQrM+OC1Eu67pBzuVb4XlWux8PhSnBke6Ofd13rOr3xLoDpG/XgAm2Oa7lVElAlBZdyP/giwBWYFjswR05V8oRNlleafqKYT+aKH8JJ0KXHCDXYirA3YRw/uewue3PvJw68mESi8=
X-Gm-Message-State: AOJu0YxBtitkM7vPM3PwhCCD196622AU1j4ByccAlZFAMEATLTHzujyk
	u8NN9n4xqD7S1mx/VFkHJ1AYMq98J2LiUx9c/nmh53SBk3L3WvJt
X-Google-Smtp-Source: AGHT+IF15FNrz0c/YsAcF06c7l9yWKhemZCZaq1+dTj53wOeDjDUvnmNbB+f+xaDjqjDDDJoEZXahw==
X-Received: by 2002:a54:4702:0:b0:3c9:9567:e5bd with SMTP id 5614622812f47-3c9970ca982mr13658803b6e.54.1715692387116;
        Tue, 14 May 2024 06:13:07 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27f625sm561460185a.33.2024.05.14.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:13:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 241F31200066;
	Tue, 14 May 2024 09:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 May 2024 09:13:06 -0400
X-ME-Sender: <xms:YWNDZuiMqNkaiks8U3N61vFl_qq6LfRH2wKzQ0bftso4ZGmDXhQyiQ>
    <xme:YWNDZvCKMnkSd42lbbDE9yI1Bra6kqYQCD29mTlEOVbTaJVVj4Vo4lFOJJXRan5i1
    cJFnHZmoedeks40NA>
X-ME-Received: <xmr:YWNDZmEg-S9JBDv1u6SIRhGRzWEt777fqVTNaDv5a4ROA9KrI31E6OTGFVwHXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgeekgeettdelffekfedtveelueeiudevjeegieekvdegkedufeetfeei
    iedvueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:YWNDZnRbeXzQTVFS-8rlP951nqZ441rnFEu49vDRV2BBFzzL_jBPhg>
    <xmx:YWNDZrzsCSsGm4KOB1fbmgykRDilC9jwZYGL1qqTrw8qv5x4Rh2Qww>
    <xmx:YWNDZl5QIQRzovoG61DRbawlONVeNTNjFmTrpaus4gCrzl4DiK8hEw>
    <xmx:YWNDZow9qb3YLxZ3Z9W-S9rTQtkIUC-Re9Bzc_A27CUe7Gs9IJIh9A>
    <xmx:YmNDZnjJG_xY24h3SYKGk9vThvtAVqoAVaNlKq8fbR9C0FyT2FzU8WJe>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 09:13:05 -0400 (EDT)
Date: Tue, 14 May 2024 06:12:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Mara Bos <m-ou.se@m-ou.se>, Amanieu d'Antras <amanieu@gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <ZkNjVbqR6gYqg4YZ@boqun-archlinux>
References: <Zigj-lY5lnBSKuib@boqun-archlinux>
 <87cypvnpwn.ffs@tglx>
 <CANiq72nGHhgRjfMOhz=ss51q2egHYexPMVvWTr0RES9WAmMF=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nGHhgRjfMOhz=ss51q2egHYexPMVvWTr0RES9WAmMF=A@mail.gmail.com>

On Mon, May 13, 2024 at 05:04:43PM +0200, Miguel Ojeda wrote:
> On Thu, May 9, 2024 at 2:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > In principle ktime_sub() should not overflow for regular use cases.
> >
> > If the binder example overflows the substraction, then something is
> > seriously wrong. Though in that case as it's only for debug purposes
> > panicing would be totally counter productive. A warning might be
> > appropriate though.
> 
> Thanks for the clarification Thomas.
> 
> Alice and I pinged about this in the RustNL Unconf, i.e. about having
> a way to customize what happens on integer overflow (and, in general,
> other panics too), which I had in:
> 
>     https://github.com/Rust-for-Linux/linux/issues/354
> 
> e.g. like UBSan that allows a "report and continue" option.
> 
> We chatted with Mara and Amanieu, who were receptive. In particular,
> Mara posted right away:
> 
>     https://github.com/rust-lang/rfcs/pull/3632
> 
> as a possible first step to eventually have that ability, mentioning
> Rust for Linux as a user.
> 
> If we get the ability to customize those, then this could simply be a
> normal arithmetic operation, i.e. like any other. That is, considered
> to be a bug if it overflows.
> 

That is nice to have, thank you guys!

> Meanwhile, one alternative is going with Boqun's approach, but I would
> just use the standard operator (i.e. what we do elsewhere) and try to
> get the customization happen as soon as possible since we will need it
> for everything else (plus we avoid to make the code uglier with
> changes that we will need to revert anyway; and it also allows us to
> easily test any new customization feature from the compiler/library).
> 

However, I must point out that it needs more than a customized panic
handler to work: we also need to change the code generation (or adding
a different flag similar to -Coverflow-checks), because the current code
generation is Rust panic when overflow happens, which means the
subsequent code is unreachable.

Regards,
Boqun

> Cheers,
> Miguel

