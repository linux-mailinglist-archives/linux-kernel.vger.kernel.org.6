Return-Path: <linux-kernel+bounces-554762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD3A59C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F07167A70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA266233703;
	Mon, 10 Mar 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRXAY5Ro"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4923372F;
	Mon, 10 Mar 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626361; cv=none; b=HR8RHPsB2+vyle/LLju8b1Jbts0FK7A8OPc+snLjfMoyvBVi7Zv3CGuzngucirRs6Sb6UkWdHuVXhx70sRmMjAdu35JjpwWUISg9TtRJHCXY89WiRdCHlwl9bjXcrFeFtb8CiqAGPhB8er6Ar0JgMDZq1ECaVnIW/zBHWxPPs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626361; c=relaxed/simple;
	bh=91q7NMk8uri5KV8t6pWftFXoW89JfcrovnYLvltLncI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMVcJQU5V6FP4UICttSoZbumNTDQyekF9o3/LdDcc8cpp+GqxSF2/4F2v8dsKMIlf4Cd2Pacpx5MDRcl/owWtI2X6URZzSiF8JtjQiUugCogLgiPFGrA9VXvThbz9mMzJUkeHzUY1WahlBz1B3CQa7yxsqKiT9FwqgDnH5ERo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRXAY5Ro; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f916e75fso41919196d6.1;
        Mon, 10 Mar 2025 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741626359; x=1742231159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YjPz+bVLCcTmJE1Ge9L4Pvb1TVvc1pioSYKZdiC8gw=;
        b=fRXAY5RoMUuRWJoMWVBfcEmSxvxkjR37UrTXpj0W8B1tVs3TTVgot0PRKTbIeq3nOe
         ONDqEEclAlcIDofKxPPBRyGOBb2Pgnt3x09cxH/D3JZ5eibWz28/YQWs6d5kBO3dbk/a
         FhxnpGNa5fFwV1QYtd/4QXjip9eLVuXjDdCdjOgfu2TArUgDDmUJfVdTGEqhKZWifBK+
         3W8bV3V3ReXsg63XzSrnvzd0ZvXi23+/5OHFhwwcLXC2uRchzmkb/KF+wCFDeEnKpjOV
         Sy8CNlOlKSfl7LX/EhGIt++t3epznxW1Qn9dhi6yOnp7D4/r1UmeX/M27ZkV8BMXiSDY
         5u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626359; x=1742231159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YjPz+bVLCcTmJE1Ge9L4Pvb1TVvc1pioSYKZdiC8gw=;
        b=l+asD+G9vPBPrgxxRwZMrXbAkXeCmT8Lrcq7C8EhKhoEo7y6l+toUtdJinbPOh7CpW
         n7Hif4jKjSX+8EL0hIur9dVwfTKRl7xx21svMJCWDTjUdwnaaqCVQwEYsPjysfK6O1j5
         o88TSD5cz24mfpyMvqE7tBs6oeAQgOzWq61qo4A2yjBIRycT7/e9a+xcQpFsI6Wlt5HX
         Aj88G7+FvH2KWWXYd2eOvxqAqdhsEF55GDfKr2FVmR6XqkKWdcCh0nhF/ZIJppur1Xpj
         r2KRlFynqrLeETJLiKvnxWTn8NFAGG8ApiQFXXGaSAN9C333Uc4d+oRG6OVRhcvG3RrF
         VlAA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ikd0G1RU/1j9Q19G0m742XkiZgmFg96z5OfnNqqzOWCJbzuQ+AiHx2Z+Bgn0efzhiBAg8rvW4XpG69HMSwI=@vger.kernel.org, AJvYcCUWTrsuaJYcQBrwhcf50vYqWpEMc6R1FS4SZdCwloI/uIM1oZhnsUNuqNzWdrU/Cj3cvV3kO/HOXZ+iLwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweT/x+ILZZUZzQS0Pu2yh6dqpv6HWPMt71zvkllZm/zqlnm50Q
	LwY3gFZTGvXm60qvJStcZ1nBL75XSjQCdQPq44FCIXJ95prtK9Oh
X-Gm-Gg: ASbGncsSHStZHDCLBzjboZLNTwh1T7ug8vjAF1C/PkVkxhC2M20w1YOPIO5VKP0wHdr
	ZDtXS0lOv9ZE2iKqWx3xlqGqFQh94urPJzprzEwyPAcaEr9nw8sqmBLskqXkVNYbeEE1GKbXL7c
	K5OJS8fNT4fgqw3MjFHmh7OHbXPCK4+7BqZ8qdmHfkF8TMoJZCmGWuT8HwsPtkLRnvJkyTJK8mc
	nZZHeZ56Y0CzYhRs/AfPQrfuG0o947a03mHcWazwC0uWfpxvhGxa9YUsjVt3vyBkz4Yejef0S2m
	wxEFSlT0QBL5t+zC39QkhvOo2KUwlwHJgQk4cKZyGBLOnvULB/rjHm78MpRLVUbvJjw7Ku8Jrdm
	PlFFJTlpBDw1xNYuuQAwoDzM9cYc4U0p8M1A=
X-Google-Smtp-Source: AGHT+IGfjnzon5Mgvw3rfejDPpoaCqfsd04YDbzFhH4EmdNGePT1mNBnj/o3zU1GocqKLhaT01X5WA==
X-Received: by 2002:a05:6214:1c45:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6ea51f159d0mr4027596d6.16.1741626358349;
        Mon, 10 Mar 2025 10:05:58 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm59997406d6.49.2025.03.10.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:57 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 797F41200043;
	Mon, 10 Mar 2025 13:05:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 13:05:57 -0400
X-ME-Sender: <xms:9RvPZxP0pvA5fItaHqWNUpAbpQmTfhdIKVu84BgoFtkVbGLUrhO80g>
    <xme:9RvPZz8a2TkXE6q_2Cndj81aENZ_CzJU_jVXY87ZatUvM2zBqsK-5gZldquQxovxR
    Jm-AO1ccO17PxDD2w>
X-ME-Received: <xmr:9RvPZwQfeXqzdyOIM6tcU9riO7bQ7klvzYJsrCnZI3hYFy5hOVL21MoSOBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9RvPZ9s4A0xsKee5heR_UzkfJv1JqY4pOnrdvXrNm6vXXBU16ZFvaw>
    <xmx:9RvPZ5e7m9Kyyt6R0t89UgWZhghvviYooGkG4XtBmIAJBPkJrA_i1A>
    <xmx:9RvPZ50l8_hFPvFcGxjdRjJH2hy5ZyvSVpyflpfrh0HB-fdkiiQ7Yw>
    <xmx:9RvPZ1-jq7gQJiJuqqbiqVRkwpMRHAxbuR6tRpAMDTsJEYImgYNVlg>
    <xmx:9RvPZ0-2INwwf_-NUKHdrVyzR_YAbfyiXeCU1XNq31FihB3TygB0uL81>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 13:05:56 -0400 (EDT)
Date: Mon, 10 Mar 2025 10:04:37 -0700
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
Subject: Re: [PATCH v7 1/4] rust: types: Add Ownable/Owned types
Message-ID: <Z88bpe59bnXmfVyw@boqun-archlinux>
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
 <20250310-unique-ref-v7-1-4caddb78aa05@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-unique-ref-v7-1-4caddb78aa05@pm.me>

On Mon, Mar 10, 2025 at 10:57:24AM +0000, Oliver Mangold wrote:
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
> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---
>  rust/kernel/types.rs | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 55ddd50e8aaa075ac33d5f1088a7f72df05f74f4..e0ce3646a4d3b70c069322a9b0f25c00265a2af8 100644
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
> +/// of the lifetime, and that any objects owned by Rust as `Owned<T>`) stay alive while that owned

Missing an open parenthesis?

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
> +/// A subtrait of Ownable that asserts that an `Owned<T>` Rust reference is not only unique
> +/// within Rust and keeps the `T` alive, but also guarantees that the C code follows the
> +/// usual mutable reference requirements. That is, the kernel will never mutate the
> +/// `T` (excluding internal mutability that follows the usual rules) while Rust owns it.
> +///
> +/// When this type is implemented for an [`Ownable`] type, it allows `Owned<T>` to be
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
> +    /// Consumes the `Owned`, returning a raw pointer.
> +    ///
> +    /// This function does not actually relinquish ownership of the object.
> +    /// After calling this function, the caller is responsible for ownership previously managed
> +    /// by the `Owned`.
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
> +impl<T: Ownable + OwnableMut> DerefMut for Owned<T> {

Given OwnableMut is a sub-trait of Ownable, do you still need the
"Ownable + " here?

Regards,
Boqun

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
>  /// A sum type that always holds either a value of type `L` or `R`.
>  ///
>  /// # Examples
> 
> -- 
> 2.48.1
> 
> 

