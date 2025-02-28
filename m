Return-Path: <linux-kernel+bounces-538869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAAAA49E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECED1894BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426552702D6;
	Fri, 28 Feb 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9RD9JqR"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE221F9AA6;
	Fri, 28 Feb 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758050; cv=none; b=YvapdAvw8bEmYtfZ1VWseZwFcvLkYGQ9PqtMemParOO+aBypWW/FGkwqCG/ZZMocgBhtbXbgrXVhARjYvOZA2/zV6vSg6iOWUQ46qCsVZlRGuNaNcfk0qg+o+3ZCumeHd9VwYy32l9QkMh7OT9iQ/vCiwTqL8RgDccOPX5n8gCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758050; c=relaxed/simple;
	bh=Jy5xpWECOq8g2BbX66ZPmFhSis92TzmiHpwJvrfN2/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNTTDSElAp+7HonXorXHgrO/t+xWsWCQezpg65pAlrR/pT1b02v1DUATyQ90FioEYNVrslIRvJY3KyzgooKaoOcHKXUO/Dud2nk33JljbpTL72/VcFmCkHmI2h62sJRpSlLV5lXM/nJ/Fz9oXRKqHamRjdf6qqK8JeBVZM90chA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9RD9JqR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e895f3365aso17280396d6.0;
        Fri, 28 Feb 2025 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740758047; x=1741362847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOuPCznz5V/Qc6HR9+0KsY6tZ7Awjk9O4h21Q0S5mfE=;
        b=d9RD9JqRqE7+WmmVVkTB+7kIlRIA6vUNqaHySGLNP4BZAWgsU6SdGqDp3ZS9+VKkmI
         5wui3QKJU+dMyRsLpCfD8lfYrMEkd8+qxB+8Baqj2Xy6eQBox8X/4sVbDx/wPgP12blJ
         KxaLHSBaqeuB4y2jUwGWIiUx+Z2PaqggRCVIhkYH1cqMOn1/Rbx5KqNJrMFBBfSfKA91
         yLCJCHI1cLZ4qaEBtauRFLfHvG6T/8qvD6yHgDO7oDhgm/eZfXYBEymn73OeVVcfT7qA
         sKqh6cBxVvPAEYx0cotDTjqP13HPaYz4UOLhTft5GmiaCp9JH9JbZpflMWqYCHTYZUZI
         tJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758047; x=1741362847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOuPCznz5V/Qc6HR9+0KsY6tZ7Awjk9O4h21Q0S5mfE=;
        b=NteyGJH2iNtPlut86HQn+FJgQ/nUmZNzA1p1e8l2m2EpXl3ZEtp5qOW/D7TVMjyxTH
         IX98Q0OjqVlhBEAy/3ClijOOzza9xd8x6WVRr5biLcgE9qbXeQsJUZ13GT8ainOqMDF/
         zQpvZe73iGmC0wqkRCHU8Ah7haEa1FzONgJqmErPQ4GnPO2wdHS7oeD3BNcoQhzsRWcy
         oLqVn7brWBSa45b4FouQz0axigSduFTDR+xoQGfu17s84Ly6dSngEpwsdDhXawP8Kb1F
         +xBlx40WSMcSrJwr+BP2y/2AhkqwW53UPjelljEb/JHbJwIxnkB0h6zquWWX49+VUiei
         E0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXF/pX7mTKdBVVAO56H0VWmD5oPqkETOJdLFePX2vE+3mKCJORjGoxPGNJ0Wwv8zqYgZFOLZcKCoV7eAqjnpYg=@vger.kernel.org, AJvYcCXtfKlEbMpz4JxIQFPPN3DCrkT7HJGAgpNtRkZs9G1FpBFQW4+vVIhSgUqKGwogt1jIcH6+wT+cp38THcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzzQaiKyofisjpr1JW/YR4HexN7uUg2PQ2/qnhbeS4TxD1sB1x
	DQm8D5mGuQuX5sRPn1fhpX/24LHrrSWVdBzNfyHyvFCTUBul7T2B
X-Gm-Gg: ASbGnctATQRTyrK0C8bbmGvFLv8utdPY4JGDGiGKG3NgwD+BG2MV+YVzCtukyTQvJk9
	No4wsZAbPmS/6I3J9MSROwJoqZmkff5X8cboiQiENNNRBG/VZ486Jzkt3/ixi4lKkAmKpe9NNsb
	UsYEy6NACprBZzsRLnNsUCRbr+rINAHVP7+hebkZYrTFIXRbHa1Ze8tJvDmntJOIh8+Yl/xvpBS
	haYN+MMg/9ZYlGgv/+kyqiAcAcQkYrhDcub2580TNoUW4YQ3qQU97SNru3ivXDVMu9/GMGSYXLe
	LpDbt2wXZmzfHfBHjswUz5pLN41QlLQKIO5CLGKhwMKVFg70kpvsFyhGwjoI+jvEKVAtG8zkYlb
	kHi+P5cJ7/43KFdB2
X-Google-Smtp-Source: AGHT+IGRioi16+hiQnf3GM/IfLmmQqAOIWJJaTa3+ToTLWETrevMFb53ZZS+OKbixCfp1Mw3WDxfLw==
X-Received: by 2002:ad4:5f08:0:b0:6e6:61f1:458a with SMTP id 6a1803df08f44-6e8a0d14f35mr55130316d6.14.1740758047282;
        Fri, 28 Feb 2025 07:54:07 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634d1dsm23549666d6.5.2025.02.28.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:54:06 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7445E120006B;
	Fri, 28 Feb 2025 10:54:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 28 Feb 2025 10:54:06 -0500
X-ME-Sender: <xms:HtzBZzMu4Rf70o90PB4kOSpVwuidliOmSA5eFhureCQDCef0ZyFQ4A>
    <xme:HtzBZ9-ZXJNjf7YsHzZHhlEsrGh58zMoyF0wtBpousVIt7Psy5jce3vaXzKhlcYE2
    kLLoegrmviGed4XFg>
X-ME-Received: <xmr:HtzBZyQ2oCNRCR3BwZS6UjMVND7mCg_Cr1heatk3thv4n8ZVe3pSsIA69g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfekudfhfeffvdfhhfdvtefhveffhfeftdef
    vdehjeegkeeftdeggfevfffhveeknecuffhomhgrihhnpehpthhrrdgrshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholh
    hivhgvrhdrmhgrnhhgohhlugesphhmrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhr
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpgh
    hhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhi
    nhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:HtzBZ3vR7oGU_E3vFAtMmp_8a7eysgXlG9LafIpkqbmKfaL04JS5XA>
    <xmx:HtzBZ7d3i-bJ6X5I37k5rzl7FDtFrKs2JM16NN78Qd8NyFfbJRBX_A>
    <xmx:HtzBZz3_igYYErux4Glw3N_wjlQ5Oc3xouOEphDb_N2Bpd5_UO9RdA>
    <xmx:HtzBZ38MWU-uK4EsWHvcAJnBh4F2moqeGW9-UIy8rgqxpX8AdbJ2-g>
    <xmx:HtzBZ-846Xm4i4Yebhakb74JS64XkGCEWE9Bog-xcRCjx_7edlxtssbV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 10:54:05 -0500 (EST)
Date: Fri, 28 Feb 2025 07:54:05 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8HcHVtPiG-X6ujP@Mac.home>
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>

Hi Oliver,

On Fri, Feb 28, 2025 at 02:43:03PM +0000, Oliver Mangold wrote:
> Hi,
> 
> For usage with block-mq, we found that having a variant of ARef
> which is guaranteed to be unique being useful.
> As chances are it is useful in general, I implemented it
> as kernel::types::UniqueRef.
> The difference between ARef and UniqueRef
> is basically the same as between Arc and UniqueArc.
> 

One meta comment: could you add examples for the usage of UniqueRef?
Ideally, we should have example code for all the new APIs, so that we at
least have some test payload on them (doctest will be generated as kunit
test).

Anyway, thanks for the patch!

Regards,
Boqun

> This v2 of the patch, addressing the issues raised by Andreas Hindborg.
> 
> On 250228 1417, Miguel Ojeda wrote:
> > 
> > I think should be caught by Clippy -- Oliver, please try building with
> > `CLIPPY=1` (we would like Clippy-clean builds as much as reasonably
> > possible),
> 
> Got it. This version should be okay for rustfmt, clippy and checkpatch :)
> 
> Best regards,
> 
> Oliver
> 
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
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> 

