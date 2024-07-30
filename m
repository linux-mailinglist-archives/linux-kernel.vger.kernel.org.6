Return-Path: <linux-kernel+bounces-268272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2F94228B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD51C1C22FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0318E05A;
	Tue, 30 Jul 2024 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX+tsubb"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459251AA3C3;
	Tue, 30 Jul 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377195; cv=none; b=Dm8eejaFqDT6fuTO1vRtZvcKixmGxzlCZh6V2bJHIo3EOTDohV64aLT9jgs07eVzZVpgghQX9UNxNsvooYRSnYuEWgzCF+p/ycuIcAjYjx6dBXF3Bkq7rYiRNqywNGXz1QjXzGIh7+fDxuyFuwtmhb4LVQKJ7RH9VdsSVmBWLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377195; c=relaxed/simple;
	bh=Ds1uhl8VGl2N6fEfVBcRSBcgyUphnUxrxOG5x8i0Pho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAYO56fo1voPuCUJ860Zi0fi3kqgYoiGVUwKfALES8qwk6X0jNvrTBy4yuyntPBEuinEcUe3mOFYiqqPUGWBP4Qk7a63DA21nc6HkfffIqEq2cuUm17kVGfxQ+QkPb1FLvLqv3uzEVTZIhERe9vpQgaBaucGDF/r93Vwci9LWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX+tsubb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44febbc323fso27876531cf.1;
        Tue, 30 Jul 2024 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722377193; x=1722981993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVw2KpthxU8jlBQahqrzZUWPHZ3m06u8jaNvfPAwBLQ=;
        b=RX+tsubbgQp43UZG4KgF2pHpBlKxIS+6uW3YKmzCdWLLGXRh73qEXjabElorl93yPv
         6eZfSlfDoSoCajgnPFI3YeAKWU22cW9t3//6SXn9UBe+Ga7wv3F4lBk940e2PLzXQIdI
         eE2mudb5u1oKsDXn2wwlhCy/S71/Mti78f9A8MOAXhLVpPmvhb88Dk0XoKIKYZjFRFYN
         99An9arz9WxuekUOSUV/SprS+HhGhKsIDt+3YIoHlVpTkJCPEwjGT9OQmSblgJGIbS9A
         mtYVT2hYtneNsCf7PmdpLYCgVGeqIiRFWc0EQFcuLkz/HJQ3F8DJGJMpFg3vfyIsA5rv
         ch+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377193; x=1722981993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVw2KpthxU8jlBQahqrzZUWPHZ3m06u8jaNvfPAwBLQ=;
        b=GYzu49EV5s2kkPFvjDehoPqXmazDhlnu5mvimM1rTmH51xcojjwvCOfL4ylxdFaLMs
         NtLofwpGNwVbFULEsaqDToQXgsUA6FoTVymSq0KSI+wjykk7cE5oI5igsSYk5M57a6AI
         5W6aeiVPiyuJlFzXqWrZbrRjdVKrG1pqA9XrQRswBwZxU/wBiBQRQ0UziQtysDMEuHTc
         wW9G3uoGeUaDYlhLXDhb35UFbxOyAWVXIjsvvNmh5SvA6sMt/+eQ1/IGQO7ZAJB6YnHd
         xzaVMiHED8ZPwkmGHJkyV+BvVOmtIAffTd8bRsZg4jr4JP7A4dTpHYdOznDiKpghB86u
         vE9g==
X-Forwarded-Encrypted: i=1; AJvYcCXlTAJZ246Lc79yoqTqB2FaE15Ag/OBSnWe53SzOq31u3Qt2aNOhU1jKJf/U7VHHmcDW2f1vqxRomGeT0KjO3B04M/oulClKU0lYz5AaLptXRc5ww85E7y8QtR0Td5FE2J+xJZ90qdD0wEwqdY=
X-Gm-Message-State: AOJu0YzM5g4LXNbSFSeF4m0Tz9+T22p/WVVY8E686nJcqLq/8hNRy/EF
	aMbvHEiD3TNdiRHMffIvFEGq5432GRiDRFLxvuokZ+/oKay0AgVK
X-Google-Smtp-Source: AGHT+IFP7bi44J66LsWfM9BWyyHJ2qYNDfwex6DI/P3ll0PWuSsCxmW67ptcpD+177qq1iYQwBk4wg==
X-Received: by 2002:ac8:5953:0:b0:447:f5d2:7c5f with SMTP id d75a77b69052e-45004f4e50emr161021771cf.53.1722377193023;
        Tue, 30 Jul 2024 15:06:33 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe814edc4sm54245991cf.28.2024.07.30.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:06:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1E9521200070;
	Tue, 30 Jul 2024 17:57:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Jul 2024 17:57:31 -0400
X-ME-Sender: <xms:y2GpZgsrxjyIqjjLGJFJJ_eAZAc6MAt68VHlw5OqL5EaTxJlD0A4xQ>
    <xme:y2GpZtdRJmsxZRGIm4Da6nuUTBl9D0uULD2GNy4E6ZDa8m6IckdNUJRuHfdGTNJwX
    CSvyZL2qCnvS-i8DQ>
X-ME-Received: <xmr:y2GpZrxabOg2J00LkavMUYN-A5EKyG-MxB9TZuktVU1yzWfzcbnfcpeE-F2MIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:y2GpZjP22kEX_7aewlbtG0yOl0MmXCNtO3OBZvvWXSC5OYwbrr5jvw>
    <xmx:y2GpZg9qtDDAVxxoGsNuoJ077viMCyIJ60jYlQu9zzJAzY98a4YWoA>
    <xmx:y2GpZrU-1RyKOXATbWnqb8LmM_b4yPIU29IrgalnWKGGl1FdYz6sQg>
    <xmx:y2GpZpfimxQEVkya7N-lqT7NlWhp7ZFVWyw0yB_HSmq_FUUqegruZg>
    <xmx:y2GpZifx17HMPyFWZaAgxySQpiqNhF1LQpSJnBWCXlb8wSmeDGsvWSQ_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 17:57:30 -0400 (EDT)
Date: Tue, 30 Jul 2024 14:56:48 -0700
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
Subject: Re: [PATCH v8 2/6] rust: rbtree: add red-black tree implementation
 backed by the C version
Message-ID: <ZqlhoGJyYzrSpmb8@boqun-archlinux>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
 <20240727-b4-rbtree-v8-2-951600ada434@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727-b4-rbtree-v8-2-951600ada434@google.com>

On Sat, Jul 27, 2024 at 08:30:47PM +0000, Matt Gilbride wrote:
[...]
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 4c8b7b92a4f4..608b38c0b3e8 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -157,6 +157,13 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
>  
> +void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
> +			      struct rb_node **rb_link)
> +{
> +	rb_link_node(node, parent, rb_link);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_rb_link_node);
> +

Just FYI, this will trigger a conflict because of:

	53ed0af49642 ("rust: add a rust helper for krealloc()")

Regards,
Boqun

>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
>   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 9a943d99c71a..dc2678803637 100644
[...]

