Return-Path: <linux-kernel+bounces-361905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F399AEBD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052021C215B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B41D3562;
	Fri, 11 Oct 2024 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeHTRunU"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7901D26F7;
	Fri, 11 Oct 2024 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686652; cv=none; b=iSYE7kl74BMUb/KHkN+4nr9MGS+Yj5RNwoTcAU544bQFJC5Tsjw/o+hFYs1HqXXp2i45vWUAZQkRcSrDgc2mZks02JVUmiwwfdjPuK+FJodvzqzwxlwe9lQnl0tL13g77+sr0z4BxpfER6l01vyj+xntNGpgeDBzWOS5xjhEZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686652; c=relaxed/simple;
	bh=zgIbhqWj1GGp9GTyvh12WuDMyXcHgklU38f5XZ4yBgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSWVjzBBzaOfXA8CrIyrqQAc5iQOE++3djZaqj96yabI12yjS1F+z6U3nCzeQA/TodxDUc1OwkkZiuiKvNZ5F80HlGmTlmpWmLNzrHZgzJtYBHTaekOTyhb3e/B3H9tgYvOYPhxWOYiBqL096ilyDlq31rTxqjWwobW/HNPWNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeHTRunU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b02420b600so217410985a.0;
        Fri, 11 Oct 2024 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728686649; x=1729291449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JWkh0MUz6t5nqDpYKqBaTaCnl3Rvhr3sXih1Y9s70/o=;
        b=IeHTRunUCVzKgo3IU+j2457DSP+Noicd8NwJXVItKfaQ236EjVk6YNrwG1TfZAfXRA
         PoO1ml2WmOdVLdkeGMLAOIVr12GKnzJcUSAdgaF+Y7yUF+YQxQpfoiHwNe0sWlAwNuS6
         pShg/ahtZdfqSj0Y7Ox0r7ifnQDcpxxMDMMkZyTjwn7xk2dBEpg3G86rst8oWWTK8e1D
         QtHwXuF3CXnqSZEsG0J7ska8JaYy7JmWE9FvSuRasnfJQ9kCZJWvWS508NdAxLrjk0dS
         63pFVGq/LKN4NVraciF0f0HsnuwXv1qvXh6wdOcJN7hGVWtAG6ejDCg8kymGUnt2mx6h
         IXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686649; x=1729291449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWkh0MUz6t5nqDpYKqBaTaCnl3Rvhr3sXih1Y9s70/o=;
        b=CipcSykmHh/9sIsBkf3b36kPKPjkKRkMiQWattxoQX3AsBGsrqiLy+9lf7awbOlkZe
         XlPEr+WxM47as8I1PWcze8gCwMzIH3Oeo7rIxR++0jHY5RuJaNsD5KXCDgVkTU1sqZIl
         4dFKUCWg/cZy3K3CJLDflN/l/0ROAvaMBNWNPsvI/U93gkTBoeZDJpncaYovf5J9/CyJ
         kbOqijrnc7qzMnvdrWfaQjXxmkU7GSdmKQQuhB0wEAHkpHlmSjxJzAZuzZTT4bWlIVms
         74XYmOYyuuvYy7EvW6EKj4BxOOi7zp1PwKouo+jxszGbpGAqFCNjtnYsABkgwgN9J9yl
         h5qA==
X-Forwarded-Encrypted: i=1; AJvYcCW9L528FPYWkwXl/tn6tDTTpLGI74F8olrdpj/BTXAqIbMVSWGAs0yGLzpjBTwZ4vneSLzhMR20/HRYGR66qh4=@vger.kernel.org, AJvYcCWY4MOzAg8ah6DLTmzvh8VN695g6duMRLUgLmHOSNDFcHoPkIfIbK7j/i5MxUt80wPdBVUC5g3GxwcXVOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhKloH69qiN+kHay67wejuOAxgUH3NmxQ1XzFICTc+uc1/sDb
	EpOn6Inp/3tKgdungRLOVg4PvAvQv9HOXLPQdkQMzJr1ZTYfEPlA
X-Google-Smtp-Source: AGHT+IGu0nQsrrAB4ZCUTA8cRnSfgVIGytQRIcU7vCxZTdB58U6JUIhXXJdoA6a71ZRKKULuXjwzJA==
X-Received: by 2002:a05:620a:4727:b0:7b0:2dff:c778 with SMTP id af79cd13be357-7b11a3536cemr653655985a.17.1728686649285;
        Fri, 11 Oct 2024 15:44:09 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114988d5fsm177640585a.129.2024.10.11.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:44:08 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 348D81200076;
	Fri, 11 Oct 2024 18:44:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Oct 2024 18:44:08 -0400
X-ME-Sender: <xms:OKoJZ_zvuqZ6FBxGj5mFn3-h2xsszxAfvhn4YRRltP-lHvp5JokEnw>
    <xme:OKoJZ3Syev0k9cdFPEfIDe6S9_xnTOY7OkMWhBhFZrl58edS8gHtNDzM6_Qj5X30m
    sSpIa9CBY6RDPD_PA>
X-ME-Received: <xmr:OKoJZ5WL4jt6Yn6FWAxjX5afhbSHnARRoeiONa0szv-5BCCEwDbPrmAwwdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtoh
    hnrdhmvgdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:OKoJZ5i4HDFSsaqHKnu_BycYQAqunTSgdP8JxFG08RIUKU5emt-Fag>
    <xmx:OKoJZxDtdu85vMdl-q1IS32S0FAG1G9n1B_-gWOV5qasKjQd6A6gTw>
    <xmx:OKoJZyLsRbrlKR1TAf5ZW8se9rKCoGn8rvsQQYt6FtqZuH28bVK7MA>
    <xmx:OKoJZwCo4b-ZNRpvoSWE8djyONukNNLLwyaoMc7QC1BF9adZuLEs2A>
    <xmx:OKoJZ9xUtVhc1f2DJ2fu1mxMygukOJHRM-LBKFIxu88trvfNua55fhXF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 18:44:07 -0400 (EDT)
Date: Fri, 11 Oct 2024 15:43:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <ZwmqLr8XUDSdZMGa@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
 <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
 <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
 <Zwfcwg23tfrKIyrq@boqun-archlinux>
 <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com>
 <ZwfkzKz5mz6UvZfK@boqun-archlinux>
 <ZwgB39dXLdFWQkHz@boqun-archlinux>
 <3e7832f7-8806-41e0-8e36-6f178df2eaef@proton.me>
 <Zwhd-Eu_1oB9CIYd@boqun-archlinux>
 <b91dd35f-78be-4848-a4cf-b82914e742ad@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b91dd35f-78be-4848-a4cf-b82914e742ad@proton.me>

On Fri, Oct 11, 2024 at 07:01:09AM +0000, Benno Lossin wrote:
> On 11.10.24 01:06, Boqun Feng wrote:
> > On Thu, Oct 10, 2024 at 10:21:41PM +0000, Benno Lossin wrote:
> >> On 10.10.24 18:33, Boqun Feng wrote:
> >>> On Thu, Oct 10, 2024 at 07:29:32AM -0700, Boqun Feng wrote:
> >>>> On Thu, Oct 10, 2024 at 03:58:07PM +0200, Alice Ryhl wrote:
> >>>>> On Thu, Oct 10, 2024 at 3:55 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>>>>
> >>>>>> On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
> >>>>>> [...]
> >>>>>>>>> +#[macro_export]
> >>>>>>>>> +macro_rules! global_lock {
> >>>>>>>>> +    {
> >>>>>>>>> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> >>>>>>>>> +        value: $value:expr;
> >>>>>>>>
> >>>>>>>> I would find it more natural to use `=` instead of `:` here, since then
> >>>>>>>> it would read as a normal statement with the semicolon at the end.
> >>>>>>>> Another alternative would be to use `,` instead of `;`, but that doesn't
> >>>>>>>> work nicely with the static keyword above (although you could make the
> >>>>>>>> user write it in another {}, but that also isn't ideal...).
> >>>>>>>>
> >>>>>>>> Using `=` instead of `:` makes my editor put the correct amount of
> >>>>>>>> indentation there, `:` adds a lot of extra spaces.
> >>>>>>>
> >>>>>>> That seems sensible.
> >>>>>>>
> >>>>>>
> >>>>>> While we are at it, how about we make the syntax:
> >>>>>>
> >>>>>>         global_lock!{
> >>>>>>             static MY_LOCK: Mutex<u32> = unsafe { 0 };
> >>>>>>         }
> >>>>>>
> >>>>>> or
> >>>>>>
> >>>>>>         global_lock!{
> >>>>>>             static MY_LOCK: Mutex<u32> = unsafe { uninit { 0 } };
> >>>>>>         }
> >>>>>>
> >>>>>> ?
> >>>>>>
> >>>>>> i.e. instead of a "value" field, we put it in the "initialization
> >>>>>> expression". To me, this make it more clear that "value" is the
> >>>>>> initialized value protected by the lock. Thoughts?
> >>>>>
> >>>>> `uninit { 0 }` looks pretty terrible IMO. Can we come up with something better?
> >>>>>
> >>>>
> >>>
> >>> how about:
> >>>
> >>>         global_lock!{
> >>>             static MY_LOCK: Mutex<u32> = unsafe { data: 0 };
> >>
> >> I dislike this, since there is no `uninit` anywhere, but the mutex needs
> >> to be initialized.
> >>
> >>>         }
> >>>
> >>> ?
> >>>
> >>> "data: " will make it clear that the value is not for the lock state.
> >>> "uninit" is dropped because the "unsafe" already requires the global
> >>> variable to be initialised first. Or "unsafe { uninit, data: 0 }" if you
> >>> want to keep the "uninit" part?
> >>
> >> That also looks weird to me...
> >>
> >> But I haven't come up with a good alternative
> >>
> > 
> > How about a "fake" MaybyUninit:
> > 
> > 	global_lock!{
> >             static MY_LOCK: Mutex<u32> = unsafe { MaybeUninit::new(0).assume_init() };
> > 	}
> > 
> > ?
> 
> That still suggests to the user, that the contents are initialized.
> 
> > I feel like we need to put the data in the initialization expression
> > because if we resolve the initialization issues and can skip the extra
> > init step, we pretty much want to use the macro like:
> > 
> > 	global_lock!{
> >             static MY_LOCK: Mutex<u32> = { data: 0 };
> > 	    // maybe even
> >             // static MY_LOCK: Mutex<u32> = { 0 };
> > 	}
> > 
> > instead of
> > 
> > 	global_lock!{
> >             static MY_LOCK: Mutex<u32> = init;
> > 	    value = 0;
> > 	}
> > 
> > , right?
> > 
> > So we need to think about providing a smooth way for users to transfer.
> > Not just adjust the changes (which I believe is a good practice for
> > coccinelle), but also the conceptual model "oh now I don't need to
> > provide a 'value=' field?". 
> 
> I think we can just use a multiline regex to find `global_lock!` and
> then change the current way. It shouldn't be that difficult to change.
> 

This only solves the "not just" part of the problem, it still confuses
the users why "value=" used to be a field but then becomes in the
initialization expression. In fact, after I take a deep look, I think we
should also move the optional "name=" field (the name for lockdep class)
to the static-item-like statement, i.e.

    global_lock!{
        // I use a new format here, which I think it's better than
	// previous proposed formats.
        static MY_LOCK: Mutex<u32> = { unsafe { uninit }, data: 0, name: "my_lock" };
    }

I think it makes more sense than making "value=" and "name=" as fields.
Think about this: we choose to use a statement in global_lock!() macro
that is similar to a static item because we want to let users know what
the macro does is similar as defining a static item, right? If so,
wouldn't it make more sense to have the initialization inputs in the
static-item-like statement instead of a separate field? This will
provide a clear picture to users that which macro parameter participates
the initialization of the static variable.

Besides, for guard/locked_by, the current format will be something like:

    global_lock!{
        static MY_LOCK: Mutex<u32> = unsafe { uninit };
	value=0;
	guard=MyGuard;
	locked_by=MyLockedBy;
    }

"value=" is the value used to initialize MY_LOCK, and "guard=" and
"locked_by=" are the types associated with the static variable, making
these three parallel in the same level doesn't really make logical sense
to me. I cannot find any reason this is better than making "value=" part
of the initialization expression.

Your argument seems to be that will be weird, however, as you mentioned
below, you don't think there will be many users, so being weird but
accurate on what are used to initialize the static variable is fine. ;-)

Plus, there is no implementation difficulty, so let do it right.

Regards,
Boqun

> > Hence even though the above proposals may look weird, but I think
> > that's still better?
> 
> Do you think that we will have 1000s of users by the time we change it?
> I don't think so, but I don't know how often drivers use global locks. I
> think we should discourage them. People still can have a "global" lock
> by putting it inside of their Module struct (they need access to the
> module, but maybe we should have a function that gives them the module
> for the `ThisModule` pointer?)
> 
> ---
> Cheers,
> Benno
> 

