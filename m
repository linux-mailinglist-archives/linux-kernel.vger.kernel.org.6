Return-Path: <linux-kernel+bounces-413615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C69D1C00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027FF283043
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC61E7655;
	Mon, 18 Nov 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKjg5FY2"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AE1494B0;
	Mon, 18 Nov 2024 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731973577; cv=none; b=S4pPRXz+qehLJIy4H1oRFWstQj8d0xo7ojiJ1XSH3T8hxdfyNvavR+16WRmnEzU75ZNWATNGZEPTXC404DtL/QdWlMLZ9p5G3wekKyLQAt7F3kkkzdgDYHj6dvMlR8vU6yDMWrRAAAWej2rgCbBu9kSc+23AgYQjGU0XTM6T/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731973577; c=relaxed/simple;
	bh=p+/Mrld4M7AGbJrJBN9npD8AefoOtAvVG2DcUmTXQIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRLy4kzcVq8R+CkH17NQw5lbO89sw10bHPjvEtb5SaHQit7JcdX3fRJtBmX1QRCgDhb8TbM52aJdo6R2ESjOBrPuZ2m1bGLTSB2iJ0rppfzFntn6zyrF3vpY2XJE9uO+QAyMrw+Q15ZHdSId/i/LLtfVXFQVbARavjBijl74OJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKjg5FY2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d382677c92so20534896d6.3;
        Mon, 18 Nov 2024 15:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731973575; x=1732578375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3QTOoQSHQynJjxTpLmcWi990RofKSEhQZSw2PpHVOY=;
        b=KKjg5FY2u6cqYs/n0gl5rpTQY1A+cgKCgrq+PH+5NS+a1nH7xmWPzYDowvCmqJSkkm
         MxnQFY6xBpTMuZx06JNkt5UI7Iy+7YBCG/eIQ+sImGeYtxQTywWFpKXhGhbO7uEl5Nau
         ka8Y4Z2skTFq1H6tV1xrhpcBnejtD1eWFcrS0hpvz6Gqy+oawzcXr7ZoxWgBrk7Ufyxr
         tpPSGK/ATg/XjQJtU/oIRuZyZQEh+WIC6JCa5+fn6RsBX1ix/yXgQRGU1BWw5a5BYI2p
         DTI5Px61NeCtXrzcS97sDnugHls6MEQ19q1KqKg4QfHuj/TCXaja9UzLkTg1KHNnCfCM
         mY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731973575; x=1732578375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3QTOoQSHQynJjxTpLmcWi990RofKSEhQZSw2PpHVOY=;
        b=N/qTqiLAhpeayCwYoVcn1RRLOkVMrnpf2UoAMKRXiSJezgTIi/91tZxi3IcfM+NKTZ
         rpNPf17MkY8l35Gc7iyXknZAErR7tNCrtR4CM5HIhOl8YGV7CRcjWkre97hCpyTjIXS9
         x/NYuzVjqFmkVczTIcUMAheUyTfI7IQ+E/VAQwHvqgFPf0CeqdQl9qoRwZs/FXiEutS1
         4E+i+opS1sYHho5ShUg7PekCyIeRKBmeaHQ5EzTQ7lNqQu6+zBpqKbv6iUQoO2pAcqQ6
         zPL77H3wW93otXCHqOOnZfwzph2JJWGeSUzjrgdQdAWNsM7kmtgKBvOnvhUH3TKCcmyG
         mIbA==
X-Forwarded-Encrypted: i=1; AJvYcCUgR86TopyinbMRcaYLAoAIsuXf+VH/DrkH3TGHLI4SHRENBHH4VVxuM/3iZEYWHhf9c/p0k9wSjnDwRy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydoXQJImBv5SeTBeSvzCxAIlV6RKq8hMuyqlLGVE3qmM4eTlP
	d2r6i89XpcuICTSLxIz+aMJvfIDkWJWUkCuEW7qD15XCUTG//0x6
X-Google-Smtp-Source: AGHT+IEmee7PStNwUcEyEqcdYUL67BWZbw3/gueqot6IFPsqGK1iynGbsbLtR9cZyP5wZiHBGciEng==
X-Received: by 2002:a05:620a:8014:b0:7b1:5424:e99b with SMTP id af79cd13be357-7b3622f28d7mr2060459685a.35.1731973574906;
        Mon, 18 Nov 2024 15:46:14 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a85cf6fsm38603285a.47.2024.11.18.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 15:46:14 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id E9E481200043;
	Mon, 18 Nov 2024 18:46:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 18 Nov 2024 18:46:13 -0500
X-ME-Sender: <xms:xdE7Z5U04a3UcpwpEvxLEAMcOeWiYJQqmn03mTkr-Xwyur3X-WJPlg>
    <xme:xdE7Z5ldc1WQ4ER3NdAlM_cfjCGdVSnDOT_iU9SGsZQV5gpDZjYrRQv58IaXQw9Dc
    jlCxdYR-GBpiLCliw>
X-ME-Received: <xmr:xdE7Z1aoovZBpz8msZFfZ9zxrNDLEKIKPGfHiDeGbfeawdZo-Mvua482Lfs8mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieev
    tdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
    dprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xdE7Z8Vcqi6oesxECI6_ahyXRCPKg3jqpZOGnpx3Sm5Y_guRWGdbYw>
    <xmx:xdE7ZzlCwoWLSyp0nUcy3JmzCrrKlKnyNnu9RmhoG_Te6hiFjHKb1g>
    <xmx:xdE7Z5cEqHbuy-koAbJtj0D2GKnM_bg_N4BwIgOGgraXFP8skbFUQw>
    <xmx:xdE7Z9Evexn4FBzIc0NrTF8_l9XtYPXANvGR9zDVS01MJ4IZmjmTSQ>
    <xmx:xdE7Z9nuxeG7o78LYub4M7aVziEbOyU0q6j51R2xp5VPaaLfCBLVoLHI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 18:46:13 -0500 (EST)
Date: Mon, 18 Nov 2024 15:46:12 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Filipe Xavier <felipe_life@live.com>
Subject: Re: [PATCH v3 1/2] rust: sync: Add Lock::from_raw() for Lock<(), B>
Message-ID: <ZzvRxDSU2Fy9SPCk@tardis.local>
References: <20241031231025.3466571-1-lyude@redhat.com>
 <20241031231025.3466571-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031231025.3466571-2-lyude@redhat.com>

Hi Lyude,

On Thu, Oct 31, 2024 at 07:08:44PM -0400, Lyude Paul wrote:
> A few of the APIs I've been writing bindings for (KMS in particular) rely
> on the user manually acquiring specific locks before calling certain
> functions. At the moment though, the only way of acquiring these locks in

Could you reword this in a more abstract/object way, like: KMS (probably
a link to you RFC patchset) has a few bindings that require manually
acquire specific locks before calling certain functions.

> bindings is to simply call the C locking functions directly - since said
> locks are not acquired on the rust side of things.
> 
> However - if we add `#[repr(C)]` to `Lock<(), B>`, then given `()` is a ZST
> - `Lock<(), B>` becomes equivalent in data layout to its inner `B::State`
> type. Since locks in C don't have data explicitly associated with them
> anyway, we can take advantage of this to add a `Lock::from_raw()` function
> that can translate a raw pointer to `B::State` into its proper `Lock<(),
> B>` equivalent. This lets us simply acquire a reference to the lock in
> question and work with it like it was initialized on the rust side of
> things, allowing us to use less unsafe code to implement bindings with lock
> requirements.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> ---
> 
> V2:
> * Don't implement this for all ZST types, just implement it for ()
> V3:
> * Get rid of some unused imports
> * Make sure that we run rustfmt
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/sync/lock.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 90cc5416529bd..c7b0c6351f793 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -88,6 +88,7 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
>  ///
>  /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
>  /// [`Backend`] specified as the generic parameter `B`.
> +#[repr(C)]
>  #[pin_data]
>  pub struct Lock<T: ?Sized, B: Backend> {
>      /// The kernel lock object.
> @@ -126,6 +127,27 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
>      }
>  }
>  
> +impl<B: Backend> Lock<(), B> {
> +    /// Constructs a [`Lock`] from a raw pointer.
> +    ///
> +    /// This can be useful for interacting with a lock which was initialised outside of rust.

s/rust/Rust

> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `ptr` points to a valid initialised instance of [`State`].

Please add "during the whole lifetime of `'a`" or something similar.

> +    ///
> +    /// [`State`]: Backend::State
> +    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
> +        // SAFETY:
> +        // * By the safety contract `ptr` must point to a valid initialised instance of `B::State`
> +        // * Since the lock data type is `()` which is a ZST, `state` is the only non-ZST member of
> +        //   the struct
> +        // * Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
> +        //   `B::State`.

Please use '-' instead of '*' for listing to stay consistent with other
part of the file.

Regards,
Boqun

> +        unsafe { &*ptr.cast() }
> +    }
> +}
> +
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
>      /// Acquires the lock and gives the caller access to the data protected by it.
>      pub fn lock(&self) -> Guard<'_, T, B> {
> -- 
> 2.47.0
> 

