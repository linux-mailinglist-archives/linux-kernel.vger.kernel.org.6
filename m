Return-Path: <linux-kernel+bounces-229717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F34991731B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B5E1C22915
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24D17E451;
	Tue, 25 Jun 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVySmlm0"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96E16F0F4;
	Tue, 25 Jun 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349915; cv=none; b=qtaL1aGIv2fSsz9poaIntux31fRJoy9e5RNvvLpGmE0/9f8iQ8fSZPy4VMn/Ql4kVSq+kppzsK16vPjmeyXYwDXkp0sf9Z4jwgs6HNNgbBd/BAsvpK6l6lvxmpTVBEWT9PHuYpDggNjXYLwykcqhGzQ9LTB4e+UOtc5nxM1Coc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349915; c=relaxed/simple;
	bh=mSzr+ocilC/6cTw/lJmP+RY5zeDuek96htoYIOKFow0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdfYluxEH1/bLdTNH/7ZNRJAkxgyZs+LMJbNCuUmR8GUFgDkFeRVo+gAjc22msd6flRqbVhh2gRF4F97vCIwMoON+C5moO1rXyYHehDUFdLq0hsmPbIPcs3BX929kMAKckbrrBYoVNBI3t6dBg1J4DEKSR+6wqFkqOuaMIX1vG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVySmlm0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d55cfebcc5so440909b6e.2;
        Tue, 25 Jun 2024 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719349913; x=1719954713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HvqzW2oM9L4jphH3y37Iwy7iI8bpvxZoFRboe3629w=;
        b=CVySmlm0VgfItimURWpTbpmtUCT8D7BkqNqQ0rUvQxErfduALNBLfEuMLtHYNt4UCZ
         hl3TqYiJmaJ63/tkyZOQC5MDIj8FhZao6f8j0kkU2SHEt3kzXDDVn+5v9Y8zm7WOwLS1
         G5jE6Br1bBZWXZuZvASfb0320PxzgR6cfb+dW+J8mC/tFoln+eOtBBlXpDGI0f/kBlP8
         lz7Id5/oSMw3GlHtwVf95/V9YIKI1q4BMcOJjsgYsWUyJJg7ceSEvmjbrafbnowN/S1Z
         aAheKDgDLdhnH3r9O/y4BccV28mNIkE69igp4XT45VPfvUKO+izC6AxghuhvwPTo9Py/
         7nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349913; x=1719954713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HvqzW2oM9L4jphH3y37Iwy7iI8bpvxZoFRboe3629w=;
        b=hmC6VCqBYyNDUNopnf4UGrP+1h0nPnuoWwmhVfWuYRZ4bzBtTdXkz+BjHivYn2YlRO
         TBs5wIv8t4Amxmyg5SPMeJi958gG+evwVHoeHSIAKYsqWytnYRz91EoUK+ohFZa5xSHg
         q/tJQ+mtBSX0rodS4BVqSI4XORMripoAwSZg7lHoqFImCo9984/QLHBXFU3GuHDHcxdt
         ROkJPsYfoPMnp84voKPEmck6WhjDYC96DA35OxddOjYOagXS5GcGvhtC/veeouoaiQIa
         R6YFcQTug9hpqcqV7MXtfUB4Svy2Lfu4wccVLrTfJUm87TZhQJOCeZq4jX0H/S6vQMql
         2zlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEbW4Sj/M6HOv0qzPCJdvWJd4HT4XSYoctFw6GgFK4CdJ5iGBVAQt4jDK4Z0u91xjS9211v7x+C7LSZHFXbFibDdWCO/D3/2fxqg+A/2f4JIGC7N7eUyc0yNJlT0voEugT30w1wbIBGJxx35M=
X-Gm-Message-State: AOJu0YymK4zQ2FNo1QDAH0ZJF4sJPzcxdHIKhSFhNTY2WtIObMIjUkCO
	bRl9D9Ko5Qvra7xPQU8hOhK7IdbnybjYo1ElYuZ/lEAKYNgTyMbv
X-Google-Smtp-Source: AGHT+IHnXeQxvPhwtqGL6CpITVXxkyw12DFJYrQkVfsG+ZQ5d4GYbmzqimTrd0mAvCv0VtMPfDzR5g==
X-Received: by 2002:a05:6808:1787:b0:3d5:2c01:9df6 with SMTP id 5614622812f47-3d5459643f2mr9509926b6e.15.1719349912879;
        Tue, 25 Jun 2024 14:11:52 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44501893592sm6216931cf.37.2024.06.25.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:11:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5B1331200043;
	Tue, 25 Jun 2024 17:11:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 25 Jun 2024 17:11:51 -0400
X-ME-Sender: <xms:lzJ7Zip2ZAlCHbim4IyDzr9NuqllasSgY21DYUfmjBInI18P56QGuA>
    <xme:lzJ7ZgoonuT6u48YzwfVYbXyxWtuT59uZ6bN0bpUg1mqoU9LOdeVvYS8Z5o3_uSCl
    nj4UpLFED27tRBFlw>
X-ME-Received: <xmr:lzJ7ZnNg6PumoF62GQ1TjHxSH87xitYV3XsSrWYuS96Rl9wPN3HDS_tsrCTBJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lzJ7Zh7Pf_GC78n23xSJjwWNyw1Msk9FuYcZi04uDI5n42glFQB2gw>
    <xmx:lzJ7Zh7oa9ftKTZUCqKySGh_btV1hf9vlogb8ic7fXBcKt1KroFOOQ>
    <xmx:lzJ7ZhhlCyw8tLIJ0_9PPf2AG6ocdQdPuHS37ORToxUNdCoGxj99yw>
    <xmx:lzJ7Zr4sa3KBF_Q4GA0yvLaqTag0cVI_MAyDbroS0Fianh5PF739jg>
    <xmx:lzJ7ZsKNrQ3Smn_G4oX8bAPXFRO-yq_4O5n3CHuHcqFVbJ8ZNAn7uCZV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 17:11:50 -0400 (EDT)
Date: Tue, 25 Jun 2024 14:11:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Michel Lespinasse <michel@lespinasse.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] rust: rbtree: add `RBTreeCursor`
Message-ID: <ZnsycdnqbdOSMSt5@boqun-archlinux>
References: <20240606-b4-rbtree-v5-0-96fe1a0e97c0@google.com>
 <20240606-b4-rbtree-v5-5-96fe1a0e97c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-b4-rbtree-v5-5-96fe1a0e97c0@google.com>

On Thu, Jun 06, 2024 at 02:50:08PM +0000, Matt Gilbride wrote:
[...]
> +impl<'a, K, V> RBTreeCursor<'a, K, V> {
[...]
> +    fn get_neighbor_raw(&self, direction: Direction) -> Option<*mut bindings::rb_node> {

I'd suggest we avoid Option<*mut T> as hard as possible, because it
prevents niche optimization (i.e. the size of Option<*mut ..> above is
16 on a 64 bit system). Could you make it return a
Option<NonNull<bindings::rb_node> instead?

(I think we can also make RBTreeCursor::current as a
NonNull<bindings::rb_node>, but that might be too much, althought that
won't hurt)

> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor = unsafe {
> +            match direction {
> +                Direction::Prev => bindings::rb_prev(self.current),
> +                Direction::Next => bindings::rb_next(self.current),
> +            }
> +        };
> +
> +        if neighbor.is_null() {
> +            return None;
> +        }
> +
> +        Some(neighbor)

with Option<NonNull<bindings::rb_node>>, you can implement this as:

	NonNull::new(neighbor)

Regards,
Boqun

> +    }
> +
[...]

