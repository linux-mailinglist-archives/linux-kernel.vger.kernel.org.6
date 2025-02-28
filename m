Return-Path: <linux-kernel+bounces-539121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC55A4A12E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB981899E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A5270041;
	Fri, 28 Feb 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTkeFiC4"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0E1A2554;
	Fri, 28 Feb 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766206; cv=none; b=IXBO3r/24Lqa+5MNHD+vH4dKo+ojo/oT0I4xX86TvPluzPi98gohpBFEXATTE28Jd4zxjGL7hm+9I/94q/QW08vwsBKRFJVGwvFR9YglAsoqKGJ4aaCAXsizHB52Jz39Hv+0lrkir9spy6wQSb2jDdDmT2px9stM2LGkFI7y0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766206; c=relaxed/simple;
	bh=rhA4akekKRdwqdS9h1H7Eg8sQ2gCjlaGLY+tCx8QsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1RWiU/hrfJE9bOP7A6TuuvTOfJwLWtJ1A+DCWs/PaoijpTLLe0MjNXrdr7qATeDQ2afIfZcowIHbn+tttCVVLohcDG0GjZ7FNlk1LA+NXX9C0i58RKeMFEvqASXGkMDspAlz/yBjqa/Jmb8gD0AvlSY4OEWe7Zk/vK98lZc09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTkeFiC4; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f88518c8so13669741cf.0;
        Fri, 28 Feb 2025 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740766204; x=1741371004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+wQDbrlA+fHjAMKtxH8m9yh6D78UzXdvzdjms36zho=;
        b=iTkeFiC48NgpNle3wySbwe6YIaGkuT5/+/X3tUrcXn2LCg8EWCeOO/FXkLd2LRPkdf
         S4nlvHu7zfjOOZmyygxA4SyJzOZn6tsnJSi8htAnjkvIdJbzzvNTll/tg96LLKTO4LyY
         NGiQj+OAtdORNGvc5536hWWxaSReY9aYP8eUvrnLKloHeqphBD/AJHKCR7swzsrH7xzr
         uycg+62xXPImBIEo3FP2KeGLxSx5F6OsggTy5LfOzrCu3Kuz4ZwQGONtt78yUVxZ5mXY
         MYf3fuo2Vn9aJpz/Hj24WjApS+j7WV8zNLjqYr6JXpOrqT04h/DYYiY7gF5Aozr6cRIT
         fpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740766204; x=1741371004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+wQDbrlA+fHjAMKtxH8m9yh6D78UzXdvzdjms36zho=;
        b=BmrOPG186XCHGBGlpnUXLVM7SaKkh10hr0bbOUyLMe/6dc+LcDgwCJmK6mgSVacMI1
         LsQut7pkSjiQz4fPNkbmnghFaDTCPuVuKs/9f82Ll5mM2sF8N7IITfjbz1Q88S/im7G4
         I9XR4ln7dt/S0+28dJM7ZRav12vpPgPB1SAUMygKgltcPwV5bvHt7UNjF30CsrVufX9z
         mfI5NFTevLDnZYwFPBQNXewl9vL1XlY7AIx/wvIlZp8NZ7GdDp23yjaFlojG5Xcg9LN+
         7FGDabIrOMQICWCynM+VBFK/Tx+ytrHI0/ZA0Taq6LZe5TbnnYvylUn88HQ+hbS/tIqj
         ealw==
X-Forwarded-Encrypted: i=1; AJvYcCX0wgM+sgY/UbosuujQuEzequr08W2TtkWYq/YQvXJQoB+SROlDgyPZYCNojhRBtJwhVDfqnoCuOh2Atio=@vger.kernel.org, AJvYcCXp0BxlS8KwXv95a5ay3+JMU8roTriXawixBWOBpq0h+8xJX6H5siLGIqDWv1xmOYnEtz9o2tKc/Inuv7J/jPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVgX+njhr5KGUW9eO2b28YP5PLPZ27dXiWJ51v+zcta4Y8qrMJ
	jKj5CIb/ThWhIRKVXksPsx1Lkfy9qQK+RVIJ5H/7FMqq32+Hz/j8
X-Gm-Gg: ASbGnctQouF/RXNGlWUSK2aCtV9KdA90F3A+GXQMzS2b704QyT+NWCwTndqomjA8Q0e
	2t6aX5IuhX0HiiBv79pAuXIMv7w0/nTSMrvUnowUn7NqSOcGQm4QKhCQVHytElU2OAa1kohCpO2
	I81hcs5RYvW7Q4iJUPh8dy4wyUwWrz03FgpFUK1KSQ4m2i70sOfPGsShOyB9Df462QLirBhVi/G
	9KM5CaCdgIb7kFk13se9FmKiFrxZKiGoIWFwKmnZjS8T+z9miVdOSFttL+20B+uEyOdAZIPaQzG
	V6BanjICVYqsh0FFbxoJvacgr165FVOX2w4ic+c1EyEjy53S3n6SF/p/IC9vvWlSyKnfdaUedEB
	WH93+aTVwr/C3dXZh
X-Google-Smtp-Source: AGHT+IHuo0HsFsiIjlhxfg+74IXiGdTCyskrqQYRV6vFHzDTSfrqtPY18e74+VczM/PgceUb1pwG8A==
X-Received: by 2002:a05:622a:646:b0:471:ca95:217c with SMTP id d75a77b69052e-474bc09e3f5mr54460901cf.23.1740766203514;
        Fri, 28 Feb 2025 10:10:03 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf65asm27261871cf.36.2025.02.28.10.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:10:03 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 87E321200069;
	Fri, 28 Feb 2025 13:10:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 13:10:02 -0500
X-ME-Sender: <xms:-vvBZx4pjCND-jW1ddpWb5J0h2SA_Odo_RCpYlMggzum0VpGmGbzSQ>
    <xme:-vvBZ-6RPEPI2QpcJsTgmv5nrX1xU4kcFMkKeUxXHAkPNFwsIKbh2LFlHppXR9e4N
    R7gqpLrU4IDZN0j6A>
X-ME-Received: <xmr:-vvBZ4dOru6eeK9idQoNhbrZxxSBR5Wl4R9np2vmhzQwn1nOrXVmrBfWns8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepieegudejffeggfduveekueelhedvuddvvddu
    keejjedufeeuhfekgfeuhffgtefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpph
    htrhdrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepohhlihhvvghrrdhmrghnghholhgusehpmhdrmhgvpdhrtghpthht
    oheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpth
    htohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgt
    hhdrvgguuh
X-ME-Proxy: <xmx:-vvBZ6IlHPajZp0P52V0xiSwiJgLYMQnyCMzqu2_gY1F8FtIZvFsNQ>
    <xmx:-vvBZ1JWZ30qnNNRhat-CLklBnveKMUg2Pn7qXqgxiHWY93HtdVlFA>
    <xmx:-vvBZzwJDG2Y8La5W4Hph6zG4dDYbEXftMCM8NT1hwqg6teEozFt6g>
    <xmx:-vvBZxJoWTwE9f9RPRA1ATDf5Qypou96i-XO62vbVTDFOMaKij64EA>
    <xmx:-vvBZ4ZI2poARgxEvEWhqO5gbB2hv5-3EYPtGmjFe-X-gfv_75z6RnLc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:10:01 -0500 (EST)
Date: Fri, 28 Feb 2025 10:09:11 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8H7xx6_rIFTyV5V@boqun-archlinux>
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
 <Z8H6EUy1HqLrzytE@laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8H6EUy1HqLrzytE@laptop>

On Fri, Feb 28, 2025 at 06:01:55PM +0000, Oliver Mangold wrote:
> For usage with block-mq, a variant of ARef
> which is guaranteed to be unique would be useful.
> As chances are it is useful in general, This implements it
> as kernel::types::UniqueRef.
> The difference between ARef and UniqueRef
> is basically the same as between Arc and UniqueArc.
> 

Please add the "# Examples" section as I requested:

	https://lore.kernel.org/rust-for-linux/Z8HcHVtPiG-X6ujP@Mac.home/

I also would like to know why do you think it's OK to ignore my previous
comment, thanks!

Regards,
Boqun

> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---
>  rust/kernel/types.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 55ddd50e8aaa..72a973d9e1c7 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
>      }
>  }
>  
> +impl<T: UniqueRefCounted> From<UniqueRef<T>> for ARef<T> {
> +    fn from(b: UniqueRef<T>) -> Self {
> +        UniqueRefCounted::unique_to_shared(b)
> +    }
> +}
> +
>  impl<T: AlwaysRefCounted> Drop for ARef<T> {
>      fn drop(&mut self) {
>          // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
> @@ -551,6 +557,153 @@ fn drop(&mut self) {
>      }
>  }
>  
> +/// Types that are [`AlwaysRefCounted`] and can be safely converted to an [`UniqueRef`]
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the methods of the trait
> +/// change the reference count of the underlying object such that:
> +/// - the uniqueness invariant is upheld, i.e. it is not possible
> +///   to obtain another reference by any means (other than through the [`UniqueRef`])
> +///   until the [`UniqueRef`] is dropped or converted to an [`ARef`].
> +/// - [`UniqueRefCounted::dec_ref`] correctly frees the underlying object.
> +/// - [`UniqueRefCounted::unique_to_shared`] set the reference count to the value
> +/// - that the returned [`ARef`] expects for an object with a single reference
> +///   in existence.
> +pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
> +    /// Checks if the [`ARef`] is unique and convert it
> +    /// to an [`UniqueRef`] it that is that case.
> +    /// Otherwise it returns again an [`ARef`] to the same
> +    /// underlying object.
> +    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>, ARef<Self>>;
> +    /// Converts the [`UniqueRef`] into an [`ARef`].
> +    fn unique_to_shared(this: UniqueRef<Self>) -> ARef<Self>;
> +    /// Decrements the reference count on the object when the [`UniqueRef`] is dropped.
> +    ///
> +    /// Frees the object when the count reaches zero.
> +    ///
> +    /// It defaults to [`AlwaysRefCounted::dec_ref`],
> +    /// but overriding it may be useful, e.g. in case of non-standard refcounting
> +    /// schemes.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The same safety constraints as for [`AlwaysRefCounted::dec_ref`] apply,
> +    /// but as the reference is unique, it can be assumed that the function
> +    /// will not be called twice. In case the default implementation is not
> +    /// overridden, it has to be ensured that the call to [`AlwaysRefCounted::dec_ref`]
> +    /// can be used for an [`UniqueRef`], too.
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: correct by function safety requirements
> +        unsafe { AlwaysRefCounted::dec_ref(obj) };
> +    }
> +}
> +
> +/// An unique, owned reference to an [`AlwaysRefCounted`] object.
> +///
> +/// It works the same ways as [`ARef`] but ensures that the reference is unique
> +/// and thus can be dereferenced mutably.
> +///
> +/// # Invariants
> +///
> +/// - The pointer stored in `ptr` is non-null and valid for the lifetime of the [`UniqueRef`]
> +///   instance. In particular, the [`UniqueRef`] instance owns an increment
> +///   on the underlying object's reference count.
> +/// - No other references to the underlying object exist while the [`UniqueRef`] is live.
> +pub struct UniqueRef<T: UniqueRefCounted> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: It is safe to send `UniqueRef<T>` to another thread
> +// when the underlying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `UniqueRef<T>` may ultimately access `T` using a
> +// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: UniqueRefCounted + Sync + Send> Send for UniqueRef<T> {}
> +
> +// SAFETY: It is safe to send `&UniqueRef<T>` to another thread when the underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
> +// it needs `T` to be `Send` because any thread that has a `&UniqueRef<T>` may clone it and get an
> +// `UniqueRef<T>` on that thread, so the thread may ultimately access `T`
> +// using a mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: UniqueRefCounted + Sync + Send> Sync for UniqueRef<T> {}
> +
> +impl<T: UniqueRefCounted> UniqueRef<T> {
> +    /// Creates a new instance of [`UniqueRef`].
> +    ///
> +    /// It takes over an increment of the reference count on the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the reference count is set to such a value
> +    /// that a call to [`UniqueRefCounted::dec_ref`] will release the underlying object
> +    /// in the way which is expected when the last reference is dropped.
> +    /// Callers must not use the underlying object anymore --
> +    /// it is only safe to do so via the newly created [`UniqueRef`].
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new instance now owns the
> +        // increment on the refcount.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Consumes the [`UniqueRef`], returning a raw pointer.
> +    ///
> +    /// This function does not change the refcount. After calling this function, the caller is
> +    /// responsible for the refcount previously managed by the [`UniqueRef`].
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> DerefMut for UniqueRef<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is valid.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> From<&T> for UniqueRef<T> {
> +    /// Converts the [`UniqueRef`] into an [`ARef`]
> +    /// by calling [`UniqueRefCounted::unique_to_shared`] on it.
> +    fn from(b: &T) -> Self {
> +        b.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(NonNull::from(b)) }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> TryFrom<ARef<T>> for UniqueRef<T> {
> +    type Error = ARef<T>;
> +    /// Tries to convert the [`ARef`] to an [`UniqueRef`]
> +    /// by calling [`UniqueRefCounted::try_shared_to_unique`].
> +    /// In case the [`ARef`] is not unique it returns again an [`ARef`] to the same
> +    /// underlying object.
> +    fn try_from(b: ARef<T>) -> Result<UniqueRef<T>, Self::Error> {
> +        UniqueRefCounted::try_shared_to_unique(b)
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> Drop for UniqueRef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the [`UniqueRef`] owns the reference
> +        // we're about to decrement.
> +        unsafe { UniqueRefCounted::dec_ref(self.ptr) };
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  ///
>  /// # Examples
> -- 
> 2.48.1
> 
> Best regards,
> 
> Oliver
> 

