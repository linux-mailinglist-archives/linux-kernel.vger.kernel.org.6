Return-Path: <linux-kernel+bounces-360181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D448F999595
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85982284A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD21E5714;
	Thu, 10 Oct 2024 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoHUZQER"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A614D6F9;
	Thu, 10 Oct 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601608; cv=none; b=atUwCXkMQHrTbX+Ddw9pwMXZ2sEMkPjTKGwAQuhKTYffo4BDyshhpnnUSL9mH8ApInqUOAOEWbPFz9OCE4046XJrVpYeoLFRWfGdLm48win1v+gvIsqOlpDbSqblo1dv6ic0lIcfEdI19nLfio++ywqNsGtdnwyCRQu1FAAP4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601608; c=relaxed/simple;
	bh=YLuKjDxmL7XQBkXyqS0+w9XDn7surOgsOY4wlYFluZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osl5M5hajea6RF/DjsQJ/FRWQVMRW2TmWJ0Cd1u61+Kn4QEIQ1lPHgin2FM7Q8rzSjTapwj7bIT1msCFIZ7cQ6Qasri1UgM+uqFRF30uNf1NAtifWeNTDvpz0/M98GdAEvugykZLIp1gkyHgu2BBqgmj33F52UeZsGnQldI54yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoHUZQER; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b10e0fadbcso92667385a.2;
        Thu, 10 Oct 2024 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601605; x=1729206405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i/sS0ErlMuTAzK3eikJGf9qkuIa41+FkusE3cYOwPH8=;
        b=SoHUZQER1Cjtab2CIBVvs3myVl0Hqd4/rg1WnXBwzrh22hdKvJz1toG5KgbmuoW8Gr
         TSC7oxFJWNWulDD1mNBuR1d2S7pkF8+IVS2OYeiwicY860FIDBKYT+ZCDnP7QgiYZo4M
         /dmKpcZ3JMZ5M1hMtdlCTosYwF4ZjAPteKCVicFEpvqx0pz4xLhPZTMYJoz8LSSBbNH8
         VPJw7ojdMPi3yk/OEv8UAx47OwraMI71UDgF935bI0eSpkXI65oAsKvexZe7ATz4bDWM
         k1cMxN60B+S3+IECItTQbjerFxfXf/FSbOk8Go9MGpxXrMX4syidIUIG8VxhD42puERB
         ZMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601605; x=1729206405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/sS0ErlMuTAzK3eikJGf9qkuIa41+FkusE3cYOwPH8=;
        b=o5Pm74TCyR91KCEGjJbd7v1vJTr9FrFvbtRCDyS6u3YWql6lKPvkYXozzE2yquIVxP
         tJw9g8SMQuHcqavwsI4VKfmoxt2be+Ljhcsy0B8uA8wh36aHhFkk3vj5LFPW1blvxZgp
         otz2hA7KdIQ52bbuTFzpO4WGWXvhdA4NByfCArLRbZtpBJwk2Nv13+V1oYNoM2gKzNmC
         xeVHj0LI63XdVIfoiATxIYW79pWYu78zMcTjIAtYMvzfz6XFRRZOSm63mMWzGSyE6SIk
         +eeBNKUZinRQaazGuS9zZoV9FT/6jgpFxYrASYVgaEN8INkLxL7PjrOPBOtXw64PnGIa
         xIrg==
X-Forwarded-Encrypted: i=1; AJvYcCUVqQdnAJy5w9ZVsQG6wL1qYnBie+YMrnjXCeHl43cuNMmhLs28jAnOEnpFTziuwA1hUnxnn0fHuJjhnNo=@vger.kernel.org, AJvYcCV8OPiCAolOh3AWI9R4xAqC8tcfa6PhkUTau9ErazrQgJ0DNL6JxLwStKnA5b/cQmWJq616WDNHT3VIPlk40gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK2XP9/uN757pRJDv7beTxxxnhOq1cvi3DP9OK9g3Z0EUDtBb
	VauAgrnGZiYnKWga5/gmmaKmSxqCONpLTYF42gxx+7LsV/piFZx6
X-Google-Smtp-Source: AGHT+IHO7HUgUEiWGHGvwuj0m62GUIGJenqQ2aggMakuy6xJt1K5+MM0WzAR1ZGM/Vwx/llsG4YKSA==
X-Received: by 2002:a05:620a:46ac:b0:7ae:64f4:db46 with SMTP id af79cd13be357-7b11a3c570fmr108479985a.64.1728601605311;
        Thu, 10 Oct 2024 16:06:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148d69fesm86394685a.41.2024.10.10.16.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:06:44 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id EFAD6120007F;
	Thu, 10 Oct 2024 19:06:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 19:06:43 -0400
X-ME-Sender: <xms:A14IZ-ukVeEZqJA4WVTeIpsAK4wpOORp1zAUq6LJM_hA_zYlZo3yxQ>
    <xme:A14IZzd2PP5mbPhDul891cNrBa2Xn_d7E8YH93580aQtvQb-WTKBe5H_iW2ISERww
    zKCt3Gp_vtO0ZCIIQ>
X-ME-Received: <xmr:A14IZ5wXCDYO4ULvjO6Bt_K6AbSyFVF5zAqRIcLyM6iA5HA3CVlmBttOacI7YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudelucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:A14IZ5OhW5crXFOC0Lyg047R6kX3q8wZkTMXEVXjLWsX8C9-eCKnfg>
    <xmx:A14IZ--h9W4suqz090z9djw3T9sByn8kqjpU-r04QuiwW8MOzzgYGQ>
    <xmx:A14IZxVJTflXiHPk5bJbgvR4eWvVnRMeMpXK8vGdGyEEhLLtANSW6Q>
    <xmx:A14IZ3eNip09eg2IZf2zg5G3ZdbxZ7qj_bwsxcFGbRmBAtqefBZ0AQ>
    <xmx:A14IZ4fyezOyN8x7bSkYZcSI_qE_cmb_YH_JQfLa6pDY5AFu5BNRTL4u>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 19:06:42 -0400 (EDT)
Date: Thu, 10 Oct 2024 16:06:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <Zwhd-Eu_1oB9CIYd@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
 <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
 <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
 <Zwfcwg23tfrKIyrq@boqun-archlinux>
 <CAH5fLgjhTWjmYqxcTRRv6FTpv7Vg9nnVCGGWbSKPqOSjJ5XyQA@mail.gmail.com>
 <ZwfkzKz5mz6UvZfK@boqun-archlinux>
 <ZwgB39dXLdFWQkHz@boqun-archlinux>
 <3e7832f7-8806-41e0-8e36-6f178df2eaef@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7832f7-8806-41e0-8e36-6f178df2eaef@proton.me>

On Thu, Oct 10, 2024 at 10:21:41PM +0000, Benno Lossin wrote:
> On 10.10.24 18:33, Boqun Feng wrote:
> > On Thu, Oct 10, 2024 at 07:29:32AM -0700, Boqun Feng wrote:
> >> On Thu, Oct 10, 2024 at 03:58:07PM +0200, Alice Ryhl wrote:
> >>> On Thu, Oct 10, 2024 at 3:55 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>>
> >>>> On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
> >>>> [...]
> >>>>>>> +#[macro_export]
> >>>>>>> +macro_rules! global_lock {
> >>>>>>> +    {
> >>>>>>> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> >>>>>>> +        value: $value:expr;
> >>>>>>
> >>>>>> I would find it more natural to use `=` instead of `:` here, since then
> >>>>>> it would read as a normal statement with the semicolon at the end.
> >>>>>> Another alternative would be to use `,` instead of `;`, but that doesn't
> >>>>>> work nicely with the static keyword above (although you could make the
> >>>>>> user write it in another {}, but that also isn't ideal...).
> >>>>>>
> >>>>>> Using `=` instead of `:` makes my editor put the correct amount of
> >>>>>> indentation there, `:` adds a lot of extra spaces.
> >>>>>
> >>>>> That seems sensible.
> >>>>>
> >>>>
> >>>> While we are at it, how about we make the syntax:
> >>>>
> >>>>         global_lock!{
> >>>>             static MY_LOCK: Mutex<u32> = unsafe { 0 };
> >>>>         }
> >>>>
> >>>> or
> >>>>
> >>>>         global_lock!{
> >>>>             static MY_LOCK: Mutex<u32> = unsafe { uninit { 0 } };
> >>>>         }
> >>>>
> >>>> ?
> >>>>
> >>>> i.e. instead of a "value" field, we put it in the "initialization
> >>>> expression". To me, this make it more clear that "value" is the
> >>>> initialized value protected by the lock. Thoughts?
> >>>
> >>> `uninit { 0 }` looks pretty terrible IMO. Can we come up with something better?
> >>>
> >>
> > 
> > how about:
> > 
> >         global_lock!{
> >             static MY_LOCK: Mutex<u32> = unsafe { data: 0 };
> 
> I dislike this, since there is no `uninit` anywhere, but the mutex needs
> to be initialized.
> 
> >         }
> > 
> > ?
> > 
> > "data: " will make it clear that the value is not for the lock state.
> > "uninit" is dropped because the "unsafe" already requires the global
> > variable to be initialised first. Or "unsafe { uninit, data: 0 }" if you
> > want to keep the "uninit" part?
> 
> That also looks weird to me...
> 
> But I haven't come up with a good alternative
> 

How about a "fake" MaybyUninit:

	global_lock!{
            static MY_LOCK: Mutex<u32> = unsafe { MaybeUninit::new(0).assume_init() };
	}

?

I feel like we need to put the data in the initialization expression
because if we resolve the initialization issues and can skip the extra
init step, we pretty much want to use the macro like:

	global_lock!{
            static MY_LOCK: Mutex<u32> = { data: 0 };
	    // maybe even
            // static MY_LOCK: Mutex<u32> = { 0 };
	}

instead of

	global_lock!{
            static MY_LOCK: Mutex<u32> = init;
	    value = 0;
	}

, right?

So we need to think about providing a smooth way for users to transfer.
Not just adjust the changes (which I believe is a good practice for
coccinelle), but also the conceptual model "oh now I don't need to
provide a 'value=' field?". Hence even though the above proposals may
look weird, but I think that's still better?

Regards,
Boqun


> ---
> Cheers,
> Benno
> 

