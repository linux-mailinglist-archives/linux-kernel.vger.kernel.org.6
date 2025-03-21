Return-Path: <linux-kernel+bounces-571583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3ACA6BF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CC41880933
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F622B8BC;
	Fri, 21 Mar 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyQVUF9t"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02741DE4C2;
	Fri, 21 Mar 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573311; cv=none; b=Decf8HbZ3VF7y2xiGR8DoS79klnWEng5YohFCTXW+A0LZ4R48uxHBnRHqem2soaPAhnJNGbI4SGZng1IYHhs6rGmPNFYVqrSJqyOP7C5/efNFpnn92gDfma31cZbOmFInzGnxMhgHq2C1etle8fp6SZBtV6euBEv2ZAdCcuZ9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573311; c=relaxed/simple;
	bh=qN+LpDUJYEqiy0V6nsKAjCdksehseRBDZ9lr0ggP17o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXeS2RDvWZvkduLfcVGZxx0vofQ64NyXGKq4YUgMDxLqBGiP/nLGibwVahISuG3hXjzoztjugiz56JJXJxAlDWUJ6qH0+UGjS5Drm5QUfHCziFHOnrl3PT6pUrErP/zpyg20xw+kjwT2Zv9iRCYuldxdvHqY1InyxoRZt0QRbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyQVUF9t; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47664364628so22991641cf.1;
        Fri, 21 Mar 2025 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742573308; x=1743178108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvXualmAR3FInNiY6DGDtZdQ6hg4lKs5EWYscjWgiQk=;
        b=EyQVUF9t1hxox8O82Ee/VavpJmZJaMPvBgCpsH4HPsGTm7JuTtVlXEWukfaubIeSlV
         sYehzIUDdbETLyR/BWYO+MPtQhwKLHQV2sYLO5sjhobxjNR0CkjgLl9VPmnYbtalq6G6
         z+4XY3TlHBxBf6mPF1k26UC43r/zb0sdNLFTQ70380uxFxZ3OPzp9K7OD67qVrCTFchJ
         F8wT8CcMzNlUZX5BvMMhoNJZzE/rUhi8vTxARdmDWBZYV2v1BRvyQiY0CJa7XwWw9XzW
         KXie4eni3KpM1wBCa+4z42M9rPxWeuL6zwhKkYm85CBtwloU1NutmNbC4K4QlcbwecVf
         wROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573308; x=1743178108;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvXualmAR3FInNiY6DGDtZdQ6hg4lKs5EWYscjWgiQk=;
        b=vIFgKxDHmK+JIqbyE4sWPKQFqa2o3gxE+J6Yj6xACThV5zCqTdUZwcDvp8exUXi501
         q595ldNszglTMltw37w9sUyew8qPYFm7UDImlC5IR4nV8NyEjOX+At4dq/BQMq8zGys9
         xvmxqYGLZpEK3Q3BVO+zzp2AuNHOR90NVx+9dK50ZKy2KQPzHTSiUALqsMLlBf8EC1Dq
         3fvkMEi1DPbukAQX2RYzch8qnvnZ4NU7IPnd60pdV1CPXM4ETbZMmvTvDy6ztaU2448q
         KkLfXA32o1mLT3bs+Gj98Eq9gNVnfi0l6VO8SfJNBQdvfpFKZ8QxZ+UWv4g0vTkkqvSp
         qjWw==
X-Forwarded-Encrypted: i=1; AJvYcCXFUUttMdYKNtbvhPsyNFAnC2ztzB1p5UvmFvE9VkUWYACjD0APeGDIb/Txzz7fGrrWr34quz3CJQQbhAlTFFA=@vger.kernel.org, AJvYcCXIIq4FrwQQ/Grl1yo2OvfTD47VjiaEn8LucocW6DoZlT9TMmGMtOAZHzPATFFV9b7Ra7i9EBreXGYkNqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLU8+wPcstIymqxPklA2GlzHUukefeptK4XCuy6tbhmOobTeHb
	G1uc1rGZfAflEOQTAHd1h2X2nq+dR4j2cKHf/DpVu3x3kvc0wFp3
X-Gm-Gg: ASbGnctbuVhSxNanWorjob8v0mU7eO2+ad2CM6wnCXBHN6YaBqg9miVWjc6doklgMVs
	yLushJMTxxBMPKm5JjqOyB6z12lG7gdAS3jl8OK/l+G5nH8r5H9hII+fxe8qsMaWZjlBkt9lglN
	mWmVdMhkr1AeOYuFCcPC8TXXilLNFzWqkhopwUu3FaXqXQTls5iyzLmn9KhVfgsIp4ioTibv8T6
	Grh6NspQog1AQUNKkGJuixk5dOlPjxM20FokqT346sngH9ncw8F9oQ67k47RM/W9ahLncf+2nbv
	8VVzxBq9pfmdPOZ/hQZv3Y8nCCTI7S1Dg833sBaLmXKeQCdTs7QOFcJkzBO6swyuU74++j2ceMm
	HZ80pkn8AgeRC06yzBOgBIJ/gj/PbFZ25kqg=
X-Google-Smtp-Source: AGHT+IHAhQl0luzGh+/SDl+pY3gD66OmPkHrDFmFVuahgjg6pUgKi4pQNtt5muaHUMwspMgEjknM9g==
X-Received: by 2002:a05:622a:244c:b0:46e:2d0b:e1bf with SMTP id d75a77b69052e-47710c4011cmr126432401cf.11.1742573308190;
        Fri, 21 Mar 2025 09:08:28 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d15a2d9sm13442691cf.2.2025.03.21.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:08:27 -0700 (PDT)
Message-ID: <67dd8efb.050a0220.11e64e.7506@mx.google.com>
X-Google-Original-Message-ID: <Z92O-TBYRQh4kCTf@winterfell.>
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1E35E1200043;
	Fri, 21 Mar 2025 12:08:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Mar 2025 12:08:27 -0400
X-ME-Sender: <xms:-47dZzFzTG4l0fZMgQbDuTM6PO2wD2-wrNlLi23eeOz2GG3dcZsG4w>
    <xme:-47dZwUuLZ2lolOywBMuW7jEyuqj62ljKNyl7lcbL7-RijguCYC9kzqF46jwQn1FJ
    _yyKEWWnCsQQhRAgA>
X-ME-Received: <xmr:-47dZ1JukT0Uu9P4iUfgodKRx4Zh_oStEzBAcpQTwCy3VuDPXeWZMiAlTMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeigedujeffgefgudevkeeuleehvdduvddv
    udekjeejudefuefhkefguefhgfetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hpthhrrdgrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopeholhhivhgvrhdrmhgrnhhgohhlugesphhmrdhmvgdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthht
    oheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhi
    tghhrdgvughu
X-ME-Proxy: <xmx:-47dZxERhfTYatd3_MZgOvVbbSND0npVckpuCtETbVaYPR5AkrMNjg>
    <xmx:-47dZ5VO7V8vJ7pn0Hi4yfIT8PksIYXTG26n6pG-_RTghs-rK8BusQ>
    <xmx:-47dZ8Pv5jR_X7_txZcosAxK13K39meeNek7qUD4ID1QfJunH45pLw>
    <xmx:-47dZ43ZHpYV5n7mku46_KT_YrbCZdjykeiofnHAFGGp0nRNATJV5Q>
    <xmx:-47dZ-UbRH95DJAUdyYd80OFRoqRz7nRArLOcwjo-F8AsrxdV56kr3hH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 12:08:26 -0400 (EDT)
Date: Fri, 21 Mar 2025 09:08:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] rust: types: Add Ownable/Owned types
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
 <20250313-unique-ref-v8-1-3082ffc67a31@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-unique-ref-v8-1-3082ffc67a31@pm.me>

On Thu, Mar 13, 2025 at 07:00:04AM +0000, Oliver Mangold wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> By analogy to AlwaysRefCounted and ARef, an Ownable type is a (typically
> C FFI) type that *may* be owned by Rust, but need not be. Unlike
> AlwaysRefCounted, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
> 
> Conceptually, this is similar to a KBox<T>, except that it delegates
> resource management to the T instead of using a generic allocator.
> 
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ om: make from_raw() and into_raw() public, small fixes to documentation ]
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---
>  rust/kernel/types.rs | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 55ddd50e8aaa075ac33d5f1088a7f72df05f74f4..65f6d0721f5f23c8db79c6735dc7d5e1ac984ea7 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -551,6 +551,115 @@ fn drop(&mut self) {
>      }
>  }
>  
> +/// Types that may be owned by Rust code or borrowed, but have a lifetime managed by C code.
> +///
> +/// It allows such types to define their own custom destructor function to be called when
> +/// a Rust-owned reference is dropped.
> +///
> +/// This is usually implemented by wrappers to existing structures on the C side of the code.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that any objects borrowed directly as `&T` stay alive for the duration

It may be more clear to use `&Ownable` instead of `&T`, but I will wait
and see if others have better ideas.

> +/// of the lifetime, and that any objects owned by Rust as [`Owned<T>`] stay alive while that owned
> +/// reference exists, until the [`Ownable::release()`] trait method is called.
> +pub unsafe trait Ownable {
> +    /// Releases the object (frees it or returns it to foreign ownership).
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the object is no longer referenced after this call.
> +    unsafe fn release(this: NonNull<Self>);
> +}
> +
> +/// A subtrait of Ownable that asserts that an [`Owned<T>`] Rust reference is not only unique
> +/// within Rust and keeps the `T` alive, but also guarantees that the C code follows the
> +/// usual mutable reference requirements. That is, the kernel will never mutate the
> +/// `T` (excluding internal mutability that follows the usual rules) while Rust owns it.
> +///
> +/// When this type is implemented for an [`Ownable`] type, it allows [`Owned<T>`] to be
> +/// dereferenced into a &mut T.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the kernel never mutates the underlying type while
> +/// Rust owns it.
> +pub unsafe trait OwnableMut: Ownable {}
> +
> +/// An owned reference to an ownable kernel object.
> +///
> +/// The object is automatically freed or released when an instance of [`Owned`] is
> +/// dropped.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`Owned`] instance.
> +pub struct Owned<T: Ownable> {

This can be:

	pub struct Owned<T: Ownable + ?Sized>

right? Hmm.. but `ARef` doesn't support trait objects yet. Maybe it
makes sense to support for both `Owned` and `ARef` later?

> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: It is safe to send `Owned<T>` to another thread when the underlying `T` is `Send` because
> +// it effectively means sending a unique `&mut T` pointer (which is safe because `T` is `Send`).
> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> +
> +// SAFETY: It is safe to send `&Owned<T>` to another thread when the underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`).
> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
> +
> +impl<T: Ownable> Owned<T> {
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// It takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the underlying object is acquired and can be considered owned by
> +    /// Rust.
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> +        // reference.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Consumes the [`Owned`], returning a raw pointer.
> +    ///
> +    /// This function does not actually relinquish ownership of the object.
> +    /// After calling this function, the caller is responsible for ownership previously managed
> +    /// by the [`Owned`].
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +}
> +
> +impl<T: Ownable> Deref for Owned<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: OwnableMut> DerefMut for Owned<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid,
> +        // and that we can safely return a mutable reference to it.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}
> +
> +impl<T: Ownable> Drop for Owned<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `Owned` owns the object we're about to
> +        // release.
> +        unsafe { T::release(self.ptr) };
> +    }
> +}
> +

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  /// A sum type that always holds either a value of type `L` or `R`.
>  ///
>  /// # Examples
> 
> -- 
> 2.48.1
> 
> 

