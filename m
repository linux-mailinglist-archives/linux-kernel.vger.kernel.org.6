Return-Path: <linux-kernel+bounces-263489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB693D6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE79283EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B092017C7B1;
	Fri, 26 Jul 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5kfsSfg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC67494;
	Fri, 26 Jul 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010801; cv=none; b=nBfkJ6CMx6SYfW/DHX7kRLZ8uXJCBM6+hJxyZ8ICPfWIcw22XQ1tNTMnpilniti4UVoN4MwFaEjen6jBQkVSFqQhWMHCy+uAk2feX8xjFIHHC5M2zvSdirZyNlqkiuN9qJkwgju4JhI/RVTOxPUkjAuZQEWbO2o5k+hRJIuhink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010801; c=relaxed/simple;
	bh=FLp3Zxmrz8zZtnxkt1Gkle1MHvmPV/H0QI7MI32bdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBMljFQDgxTq7YbIBXT8TbWb4T8jaSOgJozF+A7RuOFgI1Zzv+H3RAHlT74i6+0QipGepsywrkrPPj65oEdgwZmL34PvKj094vuRzVvSXZKKNJKz9qXs7sY7Q3C3Nb6AxCzGiYNaBykaOV2MCBL1I21NXddGDiKGIKFN+JhIdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5kfsSfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D8DC32782;
	Fri, 26 Jul 2024 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722010800;
	bh=FLp3Zxmrz8zZtnxkt1Gkle1MHvmPV/H0QI7MI32bdlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5kfsSfgo6m3o3SZVOYmIFGFs45sCA6yxz9GehiUoUkrcHG77WYiiuSQUjNO6fgDQ
	 v9GzRyAYpM2o2GG5A/63+YC2PRZyoPc1Sr579/+ngr6NGNByUq5C0NxSviZYKD+Ap3
	 Fl/K+dcqIfYNOKEFaqMvGZOjA13V/WrD029kolL+ls5lZXFRw/R+L7hotT3UuJU10R
	 n5WEh2MP9vAgZcID60V+ECK3hqIbl+180au12WwSpEUApaJkaBnrMFhhuqrPy5+Onq
	 Bx1k3PPVVlS1Dy870KzDMODP88Lf3u5SKC8hgy1ypSNR41NUaAI0jNi25QdsjvNQ+d
	 /DM+qVdGHyLNA==
Date: Fri, 26 Jul 2024 18:19:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <ZqPMpNNq0Q0S-M2P@cassiopeiae>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
 <CAH5fLgjat2Y6RT957BhdOjJHt7rPs0DvZYC6JZ+pHFiP=yDNgA@mail.gmail.com>
 <ZqE9dzfNrE3Xg3tV@boqun-archlinux>
 <bcdd74f3-d0c0-4366-976a-5a935081a704@proton.me>
 <ZqK1l05zcCwGforV@boqun-archlinux>
 <beaf1fa3-eebe-443c-bc51-abd9348a411d@proton.me>
 <ZqOyMbi7xl67UfjY@Boquns-Mac-mini.home>
 <81ceeca9-8ae5-4a82-9a46-f47767e60f75@proton.me>
 <ZqO9j1dCiHm3r-pz@Boquns-Mac-mini.home>
 <8641453e-664d-4290-b9bc-4a2567ddc3fe@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8641453e-664d-4290-b9bc-4a2567ddc3fe@proton.me>

On Fri, Jul 26, 2024 at 03:54:37PM +0000, Benno Lossin wrote:
> On 26.07.24 17:15, Boqun Feng wrote:
> > On Fri, Jul 26, 2024 at 02:42:36PM +0000, Benno Lossin wrote:
> >> On 26.07.24 16:26, Boqun Feng wrote:
> >>> On Fri, Jul 26, 2024 at 01:43:38PM +0000, Benno Lossin wrote:
> >>> [...]
> >>>>>>
> >>>>>> You can always get a `&T` from `ARef<T>`, since it implements `Deref`.
> >>>>>>
> >>>>>
> >>>>> Yeah, but this is unrelated. I was talking about that API providers can
> >>>>> decide whether they want to only provide a `raw_ptr` -> `ARef<Self>` if
> >>>>> they don't need to provide a `raw_ptr` -> `&Self`.
> >>>>>
> >>>>>>> Overall, I feel like we don't necessarily make a preference between
> >>>>>>> `->&Self` and `->ARef<Self>` functions here, since it's up to the users'
> >>>>>>> design?
> >>>>>>
> >>>>>> I would argue that there should be a clear preference for functions
> >>>>>> returning `&Self` when possible (ie there is a parameter that the
> >>>>>
> >>>>> If "possible" also means there's going to be `raw_ptr` -> `&Self`
> >>>>> function (as the same publicity level) anyway, then agreed. In other
> >>>>> words, if the users only need the `raw_ptr` -> `ARef<Self>`
> >>>>> functionality, we don't want to force people to provide a `raw_ptr` ->
> >>>>> `&Self` just because, right?
> >>>>
> >>>> I see... I am having a hard time coming up with an example where users
> >>>> would exclusively want `ARef<Self>` though... What do you have in mind?
> >>>> Normally types wrapped by `ARef` have `&self` methods.
> >>>>
> >>>
> >>> Having `&self` methods doesn't mean the necessarity of a `raw_ptr` ->
> >>> `&Self` function, for example, a `Foo` is wrapped as follow:
> >>>
> >>> 	struct Foo(Opaque<foo>);
> >>> 	impl Foo {
> >>> 	    pub fn bar(&self) -> Bar { ... }
> >>> 	    pub unsafe fn get_foo(ptr: *mut foo) -> ARef<Foo> { ... }
> >>> 	}
> >>>
> >>> in this case, the abstration provider may not want user to get a
> >>> `raw_ptr` -> `&Self` function, so no need to have it.
> >>
> >> I don't understand this, why would the abstraction provider do that? The
> > 
> > Because no user really needs to convert a `raw_ptr` to a `&Self` whose
> > lifetime is limited to a scope?
> 
> What if you have this:
> 
>     unsafe extern "C" fn called_from_c_via_vtable(foo: *mut bindings::foo) {
>         // SAFETY: ...
>         let foo = unsafe { Foo::from_raw(foo) };
>         foo.bar();
>     }
> 
> In this case, there is no need to take a refcount on `foo`.
> 
> > Why do we provide a function if no one needs and the solely purpose is
> > to just avoid providing another function?
> 
> I don't think that there should be a lot of calls to that function
> anyways and thus I don't think there is value in providing two functions
> for almost the same behavior. Since one can be derived by the other, I
> would go for only implementing the first one.

I don't think there should be a rule saying that we can't provide a wrapper
function for deriving an `ARef<T>`. `Device` is a good example:

`let dev: ARef<Device> = unsafe { Device::from_raw(raw_dev) }.into();`

vs.

`let dev = unsafe { Device::get(raw_dev) };`

To me personally, the latter looks quite a bit cleaner.

Besides that, I think every kernel engineer (even without Rust background) will
be able to decode the meaning of this call. And if we get the chance to make
things obvious to everyone *without* the need to make a compromise, we should
clearly take it.

> 
> >> user can already get a `&Foo` reference, so what's the harm having a
> >> function supplying that directly?
> > 
> > Getting a `&Foo` from a `ARef<Foo>` is totally different than getting a
> > `&Foo` from a pointer, right? And it's OK for an abstraction provider to
> > want to avoid that.
> > 
> > Another example that you may not want to provide a `-> &Self` function
> > is:
> >  	struct Foo(Opaque<foo>);
> >  	impl Foo {
> >  	    pub fn bar(&self) -> Bar { ... }
> >  	    pub fn find_foo(idx: u32) -> ARef<Foo> { ... }
> >  	}
> > 
> > in other words, you have a query function (idx -> *mut foo), and I think
> > in this case, you would avoid `find_foo(idx: u32) -> &Foo`, right?
> 
> Yes, this is the exception I had in mind with "if possible (ie there is
> a parameter that the lifetime can bind to)" (in this case there wouldn't
> be such a parameter).
> 
> > Honestly, this discussion has been going to a rabit hole. I will mention
> > and already mentioned the conversion `&Self` -> `ARef<Self>`. Leaving
> > the preference part blank is fine to me, since if it's a good practice,
> > then everybody will follow, otherwise, we are missing something here.
> > Just trying to not make a descision for the users...
> 
> Sure.
> 
> ---
> Cheers,
> Benno
> 

