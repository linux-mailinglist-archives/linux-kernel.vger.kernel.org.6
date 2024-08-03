Return-Path: <linux-kernel+bounces-273543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1EE946A69
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE2DB21211
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43713154BEE;
	Sat,  3 Aug 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQg1FQCh"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038981ABEA7;
	Sat,  3 Aug 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699662; cv=none; b=NODEeURVT1dCAYLSMdIFSUMu5A8ie8KE5JCQMR7+EV/EC0MNLcVrp/4fK2yvpw2KidKoOAWUd63/k5cDg/cMKIENudlzwNmTj3Q6+qE06dcbPsMLl2Shiz7mKlSXg6FxaRdqpfgChuf5EYsM3hRc3exjKhMC4PGIA+8AvhAzxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699662; c=relaxed/simple;
	bh=QkFO6aBotCZtphQD1evRT9s6dvDdVLimF9/zKN8J3yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpW5ND59bfDnvjH8E+QL2qvi0BCnguRQzEv8liJhAdsbpWtmVofglW5/oNkPoHwViXGGuRQcASWHof9pnUmSN0Bu2jVVrkagNs6yHRNZbvcmM5JqLMtSNTEmHKxByoyS81ELrNPJ9KIzFkV6jsZopCOg3HN1XZWJAdef8jxHYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQg1FQCh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0b10e8b6b7so7797978276.2;
        Sat, 03 Aug 2024 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722699660; x=1723304460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMfW+Wl1WpbyyLnLgMc1s+Q6RfchQMIz1Z67kx/E1FM=;
        b=EQg1FQCh9yrvMOGHPXlr/GRyPzZsChm68ox9p2C8tyHn4oo7sD7bgygswppfQjkbKa
         BuVRvgGFnkkDa1gP41gOgTcpsxNsoNboUkmILrYpjfmnsbwS8fZ2ejya2ZMlOYDJJ3K/
         dUdko6obwexPDZd0dDcrCPLcXA9bzIJynWY9wKz8p2p+lFyK3FdrtH/RN8fhze5sO/Cw
         EJoUQ+w0geQ2q6VO+6/BzxbkZyJWmj1CimdmLGbR2qnnk47cta1zwLnW5dCFz24bLueS
         c9Q/yMWKAAumyCTztwLCkYTGnf0s4HHARDrwK6FpePi3Siw+n66TwDlMli3aOT8AWMwL
         +3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722699660; x=1723304460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMfW+Wl1WpbyyLnLgMc1s+Q6RfchQMIz1Z67kx/E1FM=;
        b=kp97GTPf+zZ/JiUvPgUsZKUpg6c2iKt3QbVsahlFpKlu07dPUl60uw8nH7kVHxjbGJ
         NWthx0aFxU2KtO2KZ+qrubikx8yq8vONx2VoN2jCyd6GKcnl0sBFiuXT4CGF3PDe24w1
         Nn8q+0PDD4IkNQU7GsFN6XM7D3lHlnfyyGLCNhftneKiqDtnTplda8XhGLdDxPwqpoPV
         J+4ZSliuQ5+YDQGreI41nEk/z3V4raiZWMRgH3+J0dp7aAlTiJvmJRnbiMyCCI3jmGND
         BtDdAIToABsYyFWQw33u+ivCs9zaEgVSitBtdZ6HeUTNk6jm3G06YQyXnTUZQrDOzNUX
         q2hA==
X-Forwarded-Encrypted: i=1; AJvYcCX506nyCWNwr+lJBUqJhMlJj7lOT28GIQtMV8etwKdvjZqxsUUyqqykbJpxaSGoUSNezvGeXb0blw2nNlAK4BttfQjp4oomJVjJy3cbWXFiLfjInvRg85qW/mYXucib9CcXln5EP1qGyjbRZC8=
X-Gm-Message-State: AOJu0Ywks6AS0kmfyL10baDPIMeKOm36a79yiFMkLuORm0JMAl113vyg
	gL1YtT9VPwDf1lUMKXOljeCOLWgPR9QJOp2DvTp2Yar1jXowSNAD
X-Google-Smtp-Source: AGHT+IGygqVxMFawtUBB2M//BqfjsRC0y46GvL+h7ZBP5V5LnTs04idyLXD7CInuEXS7SHmwbOjW6w==
X-Received: by 2002:a05:6902:248e:b0:e0b:eee8:ea05 with SMTP id 3f1490d57ef6-e0beee8ea8dmr4798941276.54.1722699659841;
        Sat, 03 Aug 2024 08:40:59 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a35f3fc336sm41079085a.22.2024.08.03.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 08:40:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 10975120006F;
	Sat,  3 Aug 2024 11:40:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 03 Aug 2024 11:40:59 -0400
X-ME-Sender: <xms:ik-uZltVija5t-ji7G1cLl4I_GZHa2HyYaN7MpwcE8pRdyl2ozpB4w>
    <xme:ik-uZuc1cGOZalm0jtFMdAiIdf4GYBXgpOQ4ADl9S9eOIpMOeDNSuZRaQULVDSTEf
    l0tPrDc4eP4RgtsGA>
X-ME-Received: <xmr:ik-uZozViCGPlSgHpbiqtF1NlLCWVY_bz07gAqPPLT6DEa0WVCbC5LBySb6fUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ik-uZsMgEsGETp5ow1SmqJhC8A1rG5ffmS7-mIjP02KdiU7qpyq-9w>
    <xmx:i0-uZl_pLgg4hOiLmnU3V3NWH2gt5g9Vt-60bCx-qR_8jnfnE1cqMQ>
    <xmx:i0-uZsVTH6i2duoAZMnqd8b0VTl0XmgvgPyHRJL11jItm626WD8Hbg>
    <xmx:i0-uZmc60zz5MEiJvUjBVE-vV9oBFD4XVsz4nw6YSr4pG9HSleOL1w>
    <xmx:i0-uZrc0Dd6kOwezdkm1c-fHTt7DWKKIGv94smk8DBCjhYasnb9QuTM9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Aug 2024 11:40:58 -0400 (EDT)
Date: Sat, 3 Aug 2024 08:40:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <Zq5PVEZNcXHThNHB@boqun-archlinux>
References: <20240803141639.3237686-1-benno.lossin@proton.me>
 <241c994e-28fb-448c-aa4f-b96154988bf6@proton.me>
 <Zq5Io6tKgczUYcf3@boqun-archlinux>
 <7a145166-cfe0-48b0-994b-6c6a4ff6744b@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a145166-cfe0-48b0-994b-6c6a4ff6744b@proton.me>

On Sat, Aug 03, 2024 at 03:32:06PM +0000, Benno Lossin wrote:
> On 03.08.24 17:11, Boqun Feng wrote:
> > On Sat, Aug 03, 2024 at 02:23:42PM +0000, Benno Lossin wrote:
> >> On 03.08.24 16:16, Benno Lossin wrote:
> >>> @@ -53,4 +69,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
> >>>          // zero-sized types, we use `NonNull::dangling`.
> >>>          Ok(unsafe { Box::from_raw(ptr) })
> >>>      }
> >>> +
> >>> +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
> >>> +        let ptr = Box::into_raw(this);
> >>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> >>> +        unsafe { ptr::drop_in_place(ptr) };
> >>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> >>
> >> I just noticed that I missed another comment from Boqun here. Got
> >> confused with the two mails. I would replace the comment above with
> >>
> >>     // CAST: `T` and `MaybeUninit<T>` have the same layout.
> >>     let ptr = ptr.cast::<MaybeUninit<T>>();
> >>     // SAFETY: `ptr` is valid for writes, because it came from `Box::into_raw` and it is valid for
> >>     // reads, since the pointer came from `Box::into_raw` and the type is `MaybeUninit<T>`.
> >>
> >> Let me know if you want another version.
> > 
> > Looks good to me, please do send an updated version.
> > 
> > Although, I would expect the "CAST" comment already explains that if
> > `ptr` is a valid, then the casting result is also valid, i.e. we put
> > "CAST" comments on the casting that matters to safety. But that seems
> > not matching what you use CAST for?
> 
> Well the pointer is no longer valid for reads, since the value has been
> dropped. Only through the cast, it becomes again read-valid.
> 

Fair enough, the past Boqun who made that suggestion might also realise
this and that's why he brought this up ;-)

> CAST comments must justify why the layouts are the same. On that note,
> this comment might be better:
> 
>     // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.
> 

Looks good to me.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 

