Return-Path: <linux-kernel+bounces-273708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203B946CBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01651F21DA2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E310A3D;
	Sun,  4 Aug 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jENhFP9R"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216F138C;
	Sun,  4 Aug 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753078; cv=none; b=IOVl20OIPaIBVnTIR1FBfeM95jyC2UD+Ccn3+ViWBvROJn+qYMlqof+deM4+D91bOwXNOJRV4jB5PN5Y7HcVVyncpWNji9ebzbYKk4iDIKf2JRsNHgZkfgfNa01HZ5v97qzdJyNS+Z8HNjpahqrXKRdBXmflxBGKWq+Qi0dG0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753078; c=relaxed/simple;
	bh=SbSgs4MFpL6KZRQuV1LLX5H6iF+zg+wO2Gaqqk0dRPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioCsaX3wP5dnvfdLSfYRQpq1yDHDhr6q/fGxF0K3EkmsvN2kU/BuQGejvOznKBayb7D4WkQ+3hX/6h7YEJud/9iH7r6nbGxJEe2C71Cc54bc4CTDLBRkzBR/H0kWVO8BPm5Phn+nSmb4dNfQrZ5i2jPfjxdiUPllsWn1YPKXnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jENhFP9R; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso69674806d6.2;
        Sat, 03 Aug 2024 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722753076; x=1723357876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NZxw82SfdAXEz+K8bi67990DiXrbNqIt6CzOagLaek=;
        b=jENhFP9RcWqyC7Kp3tvNdeLXigYM20hv/vbkqmFRjgEpMcnkNqgFmAZWD7ZJxKwUYd
         jvPPn6SEdKIgo3DGAdKFOXsX/Ecc+PD9ulGL6KPMCX0bRvCgm0VBJPYrBus7113+SO3O
         kU0n4DZ7hcS2GAmQ3KVCBz6+mrsnbKiGgTCpIv8vjol/1r0KZU6qWNlzvXvkqxoRBBuR
         hbnpco5sLqidQtGK6D5HJFB9gYpejBVHGine/QABp/CcymRO504dsnNpcGjkXIDisang
         lliIMr4jUUdN9+MDS2y2AjPDMI7BWihLxJxSg55hLtJ8zY7Ob3ZN5kpqwQvZJWztYBTH
         xRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722753076; x=1723357876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NZxw82SfdAXEz+K8bi67990DiXrbNqIt6CzOagLaek=;
        b=VpBMnjp5acUbUB1+UufH2OmW+qA2aGHSVBd/KMYveKJsrbzauqDLlO4hMTtkXUpulk
         QfC4YfnR6o3BTR5ng5FjWRtU8ouUqy0PtVuNu/cizaoohJorMHbGWYAQUKtuklVvp64k
         Fp1tP+2Zy45xhITZY0Msdpl3NV70jqsEa1m8DBzUYdpJSVU9D7Ubi8QsIaDAWjB6wnab
         Kp9qcnzDYgPGzzuL6+ONAeptdHfDBbysEc4wSplWhi3FCxYZYL82W9hAPRZ9CSOEh7Pi
         /Ybi+MoOQo8/Ej67B9Puzit7pcyH8L9RyhrKKgfAatgpk6vbwiz02Wl8T3ioir2zbB36
         BZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeemdgIn+mcfuABCcmNsfSiNIzkZ1NcM76X1R9iP+yZ0hxIAe8G5uIDR/ecxCozIwoJTmRJ0AM3u6THYtlmWPHCC9nWeuS0hiI/LBe5rni+h1Bc+M4vhf9uas3/OqWqeSwfyqlB6uhzq4GR7g=
X-Gm-Message-State: AOJu0YzjG55AAzpRK7IJNXD6I1Rr1TujpsyFeLpvk1KmEA13UtRkoHEu
	VLdP9BTgJij90kl2a/pYlSZNUU4/ZwljaTJMuxkrYKYW55Sf5XvBxbIOOA==
X-Google-Smtp-Source: AGHT+IHBTO+D88JzfW6pu9QPm3Lvx4nQGCDMnbUFWj/ag9pX33msBTQ3hbPO/V+yYk0ZXWdu3W1w2g==
X-Received: by 2002:a05:6214:3f8b:b0:6b5:40d:c2d9 with SMTP id 6a1803df08f44-6bb9836ed10mr115535966d6.19.1722753075899;
        Sat, 03 Aug 2024 23:31:15 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8631d0sm22519876d6.106.2024.08.03.23.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:31:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BDEDC120006E;
	Sun,  4 Aug 2024 02:22:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 02:22:17 -0400
X-ME-Sender: <xms:GR6vZjmj6NqCvj-ExoPQ9kCP_1CDBUuIRPlfXc7uggJxGbNgd19Tug>
    <xme:GR6vZm3RNGYtSkOrNoFgIFqhonYfbfTz3MOzHaex6Ad_cUGwtrZxHpETF1EHBtOi5
    6e_QHIxNg1xMn4ipA>
X-ME-Received: <xmr:GR6vZppxgYazLvrrYBP4qpOaH5ROOBtJqDjborLAUCBy6ZvS9u5VcACsYTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:GR6vZrkmCRzKvlm3tNQ6ORObZ1Vdq7VcdSktoQ7GII516aDNTfGzow>
    <xmx:GR6vZh13f4V4tK_byHEA8M2lgVjKgURzAQaufiaF4oVJyS0hPVjewA>
    <xmx:GR6vZqth7NHsCTN7HZNQCa2LoMUfzzm9hmzm4V7i8Ai7AbzUz3yv_Q>
    <xmx:GR6vZlXJpodoAH9rlIObdqZTIEx0VBMS2Fh45qa5B-50RlsMTy0MIw>
    <xmx:GR6vZg3k8vP5XS9pXJqHCxaAlRPQnx9hgg2armd451g8FXy4PSOw8BBN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 02:22:17 -0400 (EDT)
Date: Sat, 3 Aug 2024 23:21:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 01/25] rust: alloc: add `Allocator` trait
Message-ID: <Zq8d4fKUhXchuZBR@boqun-archlinux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801000641.1882-2-dakr@kernel.org>

On Thu, Aug 01, 2024 at 02:02:00AM +0200, Danilo Krummrich wrote:
[...]
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> +/// an object instance.
> +///
> +/// # Safety
> +///
> +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> +/// it is explicitly freed.
> +///
> +/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
> +/// other [`Allocator`] function. The same applies for a NULL pointer.
> +///

Are you saying you could kmalloc() a memory buffer and pass it to a
vfree()? Or am I missing something here?

Regards,
Boqun

> +/// If `realloc` is called with:
> +///   - a size of zero, the given memory allocation, if any, must be freed
> +///   - a NULL pointer, a new memory allocation must be created
> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with a NULL pointer.
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
> +        // for a new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> +    ///
> +    /// If the requested size is larger than the size of the existing allocation, a successful call
> +    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
> +    /// may also be larger.
> +    ///
> +    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
> +    /// may not shrink the buffer; this is implementation specific to the allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains valid.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation created by this allocator
> +    /// instance.
> +    ///
> +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
> +    /// created.
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError>;
> +
> +    /// Free an existing memory allocation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> +    /// instance.
> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> +    }
> +}
> -- 
> 2.45.2
> 

