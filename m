Return-Path: <linux-kernel+bounces-359185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C6998872
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3EC288A70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3F1CB31D;
	Thu, 10 Oct 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc6LQa9V"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED01C8FD7;
	Thu, 10 Oct 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568523; cv=none; b=qT09AyCPRqthkOr1LzMlEAVdy6g6yyQ0E14tpA2l0ZFuEOVsVv+oa2XxQAfEObCWGjvG6dIT+TnR0VceMgwezy30rPx6P+nNgVHHa40pQr5lKXvhANMqXBxasxsjufGmDI+Ogn4fcs3E1zKYkdJVlSWr3eqsyjIk3Bf3Xvy1Hao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568523; c=relaxed/simple;
	bh=75vOKMXmA1rQLf2SSOVRebQYGC0ajKs7D/y5FxKyJn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR5wiEJmiExL2eUGeroyG0SQp3bZdb7hmPXaKIIXmo+pGuVmoq0FPc/6V7fnQyV9RZFwztRacsUsmF49q+TnWJnbm3WemA7e6ysx7maWeNSV59ZSA4uFofv/A88X+3+be/Al+dq9dkCpdSdCKybk1WM2o4A6Ube7ABBHYfh6z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc6LQa9V; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4604111f629so7830041cf.3;
        Thu, 10 Oct 2024 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568521; x=1729173321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u23J496598uo3V1PJcz6HABIQWosxGdU+i8hsnX5lw=;
        b=Xc6LQa9VJY3GIXEI2AlQFOJL7PE8VVTYAKthC3WBmUVO//yv6+58lUg7eOpDXuF6n4
         pxNBTvzk6TuluTr4OVCFAsbRijt2y14/eMUcgY36pkGa4Hw0FaNERXo6NxgZpr89926c
         U/ZhwwjbpM0jiHwDfrgiB7NJdvqhg/0AHkpscPnyIV+BrWoSka+DCVaud/R3yDRRMWtR
         JRMse2qwnKH2tDzG456+JNcnXBEKthDqlRoU/4hEtXcRa6VK3QIfMisuk1mtI/ZlqbzU
         z/3F+MvCXOXDnK8yKPrq27HEKlHoL17CAPlQuAb2xdMr6ysaOx3TLWjA7x6+QinVLpwA
         Q41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568521; x=1729173321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u23J496598uo3V1PJcz6HABIQWosxGdU+i8hsnX5lw=;
        b=dCN7FYIL0UWks7koCmg3uvNCbUocAZJfznQHqu61pWrH2IvuDhbKQ89EbkuWYoNbm9
         mWzpksnFBgXxGvSyaO9B1XqqVj5qccxj/lKRsOXShsMXaWWHzkn2GdjrtL7iBFrv5Vhk
         yO/qcgUzepg28R0t+fz23qYYbsaGN/kfh1AttE/Z5SwdqLb/nz+SdEg9JwPn+U564ZTP
         UWEgqYhzaMH7a7dnh+aqEe/3aR8Bs5boDJ1eoe0+CVt12XxZQZikxiwahaf3Ls72z3q9
         sKLv0oCVchcLSGLJY0O9TW3dYCmXDLqPbaDsYL4LSaSDVCjuwqkUhKrQtwo7S9VcRCpw
         TFow==
X-Forwarded-Encrypted: i=1; AJvYcCVbsM0dl16y01x+v+JCNteIU4SNmm86SIc0WzIaucTo49be9Ka9c29AdxM30V/YxDXWVmrWgh2IH2qXHZgaGpc=@vger.kernel.org, AJvYcCXoSjuCi+M6wxddb54GjmnznhPsZUqUi8PUtptNKgALzjWvV5m5Bfr9bVlZ90KFKTbnIXoEljVQH43w1oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwintrKJST62LedkkHbPDuvrllPYUYZfa7VcnXCaqrqrGpWnNzs
	eUZcjgW+9g6HdTj6MHslENljVXwnuC6ybWCI/2ovVha69k5d87Dk
X-Google-Smtp-Source: AGHT+IEbAxWbGoFl45YSyno8EkCKUX+gtamxVcuGnt6LYaDn7x+v+27E7A9JNf1UmntwtTe8HDu/YA==
X-Received: by 2002:a05:622a:11c8:b0:456:8b5e:bcf3 with SMTP id d75a77b69052e-45fb0e71c3emr100328771cf.52.1728568521060;
        Thu, 10 Oct 2024 06:55:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042882bbdsm5556691cf.73.2024.10.10.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:55:20 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id DEAAE120006B;
	Thu, 10 Oct 2024 09:55:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 10 Oct 2024 09:55:19 -0400
X-ME-Sender: <xms:x9wHZxxe8mbbflFICeiVwGCCWVweNPF6GSnD0LqMHZHZ8zdKcW2fqw>
    <xme:x9wHZxRWhedeucChsSN6kuqFuiPsjxUkF8QP3zYIt88uvOrWqjjS_t0S4JahRKBf2
    T4qM68MdBHxGuFcIg>
X-ME-Received: <xmr:x9wHZ7X26wgPeYsP4TFcVF0iUKLJDayQa_ZA9WZx1c9xDZ1WUyAC2wtIWp8p0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghp
    thhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:x9wHZzgV3nXZ3IzCcAtudZtiEFzK5n5BmRpSqVGwsupmzKLMGVNX7A>
    <xmx:x9wHZzAdgxJBP5XgZl-L3SVYEoggCEEqZKmbzaf42LMyxR1apDmpQA>
    <xmx:x9wHZ8IpM7dFDsqePi7jhl3MprE7kF3rGB8nvziCrq5c4XOBg8Qi1Q>
    <xmx:x9wHZyClwiXAYcl1jJTmXRD1XLVko4udPjCnEVXiFn7Dnf9E5-_fPg>
    <xmx:x9wHZ3zba_ZZSxSBRlCuq0qveAaUja9Q_cj5hWCoKjN2reekgOFfhV5E>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 09:55:19 -0400 (EDT)
Date: Thu, 10 Oct 2024 06:55:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <Zwfcwg23tfrKIyrq@boqun-archlinux>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
 <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
 <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>

On Thu, Oct 10, 2024 at 12:53:00PM +0200, Alice Ryhl wrote:
[...]
> > > +#[macro_export]
> > > +macro_rules! global_lock {
> > > +    {
> > > +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> > > +        value: $value:expr;
> >
> > I would find it more natural to use `=` instead of `:` here, since then
> > it would read as a normal statement with the semicolon at the end.
> > Another alternative would be to use `,` instead of `;`, but that doesn't
> > work nicely with the static keyword above (although you could make the
> > user write it in another {}, but that also isn't ideal...).
> >
> > Using `=` instead of `:` makes my editor put the correct amount of
> > indentation there, `:` adds a lot of extra spaces.
> 
> That seems sensible.
> 

While we are at it, how about we make the syntax:

	global_lock!{
	    static MY_LOCK: Mutex<u32> = unsafe { 0 };
	}

or

	global_lock!{
	    static MY_LOCK: Mutex<u32> = unsafe { uninit { 0 } };
	}

?

i.e. instead of a "value" field, we put it in the "initialization
expression". To me, this make it more clear that "value" is the
initialized value protected by the lock. Thoughts?

Besides, instead of a "guard" type name, could you make a
generic guard type over the "locked_by" type? E.g.

	struct GlobalGuard<L: GlobalLockedBy>(Guard<...>, PhantomData<*mut L>);

I feel like this could make the relationship between the guard type and
the locked_by type more obvious. But maybe there's something I'm
missing?

Regards,
Boqun

[...]

