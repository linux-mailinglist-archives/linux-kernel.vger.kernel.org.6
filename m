Return-Path: <linux-kernel+bounces-563326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57AA63E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AE63AD0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694B214A9C;
	Mon, 17 Mar 2025 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4wNZGJy"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3E79D2;
	Mon, 17 Mar 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185265; cv=none; b=MFQVeCEkFIKBe1eWFlDkpX24l6uRJiYioXZefzDveFe3KgegmiBWaZk8b7vmyTyJw1M8nPhhOWcFVHMCPGF9jt2XFhfkezkPeQbTxjklxG1b92pQERXiQt6M/6YRf0A60ngsP5tSJNhka43jpjmSA7WD/d4cbb+tdMddNcwvLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185265; c=relaxed/simple;
	bh=AQA9dlmoqy+Jsgn9EwnyKogUKDWd5Cey2OuVpyiC4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+B6KVbhQB5rz+9Q7iD1WI74to6AYtPeZ+Klba8b8kUBNjh9nZGT3/Fr+a2kxo9Do95CHbckOtQ02La/YOY/8kY1lYHJ19INr83UDakH8ywsUYPccRHmkv6PHCpc86b324CgOWwG6KF7ccp+hzSid2Rstg6E1BJ4KNhPhyVMNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4wNZGJy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8f281714so442873185a.1;
        Sun, 16 Mar 2025 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742185263; x=1742790063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXhCFZU0KRigtJIqFtwicDR75ty228eo06CQmvCoMuA=;
        b=S4wNZGJylXMCw52+NdmKQa1irAauxjqNCZwXaLB+89B5y1U0rlC4c90Iu0TUVQMZtb
         iNvL9/cT22yUdOtwF4+QDcezZ9iMZDg3bmoHvWHaFtSAD7afKb18mH+eGaqgqXLuFnwx
         TV2fRYlX9HWXfWtD5nGCVVSEBiEOHEN45XrR4f+eKw6W5OOMiSQv1A6VyMXG4lHH/ahp
         /t8FnQY4GnsN61LiBw9RBqdfmwiQYuWpDf/X0y5e3KH5/8sSZmM7OvIOv0u5qKYeoFic
         WOaIaVxIyFl1WZFItaWzYSKD5BDBI4OHflzTgrF4lqqhcAJtqCEYLdsP6EYryPQYHZZI
         7Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742185263; x=1742790063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXhCFZU0KRigtJIqFtwicDR75ty228eo06CQmvCoMuA=;
        b=sfV0krfn0YKuKmIkkZNallzq7CKheja0gqj9l1wWYviw0Tjin6K6OEC3P/4mzb9saZ
         /jq5NGkUm4vDoG9I0xVw/FVvlSGzCcMA8F91YFpuJwmVCW+Ua+v5ABILOQg0hYldgXLj
         2/TjjycrVDAyON/Vb7gI+t/2rSTm0xrn8uEQRoT7cHECPEog5eS+UIEQweAVtNwT9Shk
         dnjYhE3WoHEuAjhsFY7PRtgMMRSul3AnBKeDGB1ei6q3zWw03UnDr3nlhch1t9eawR+G
         9RyW2UXXQwas5fSMzOLpraoiK8p4J3G8/8yWNfRoznLHPoMBjwbg2h/rV05Q9bpEUh9A
         On2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYtlwp1Yy6G8VtyvQ4LA0TGnfSodGhHjM0mGHNd/57Vd9W22L46qV41ZgjofNb9Fha0v01VnSxgcwhME6Cbk8=@vger.kernel.org, AJvYcCXcVG7YJO3BIZo3/ErHENHaC0Z0Xp5Arnpy3QjgPyRQKRfFY50I4YSCDF2p7QXwUclaSZD+EiYposQE6O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpzF2/wXGpG5BdX1vLJ+aG3N06igDMmwiSy4x3ASQ1I/3utsY
	Ahv6f6Ca9SLrVM8buFTycOjdGwQNamGsFhP9PSZEzDln4Rwuh1Mh
X-Gm-Gg: ASbGncuAw4ymp+wUeCo7qXOHMiqi1EIWvSotzsNSO5mI19RJse70MYkb0PXS3EgOM7Z
	PhAuvKUbNAAb5X7TMZrU/CfOVAp8uEvxyfb3kkranmmtuuMoHkYfOE1uVXzpICL5Y24yDHrv27Y
	i3WkL4qdIWsoII8dthp9hl8Xj5e2JrgpVv5MC9ReN6nBuNxI5dA3XQDtw+rPC1+lE7U8+CURMPj
	nPAuK9l64YcNm8aHrA68hs/2F7QvlqYPZ973BRh621b8ICaqzZd6/MH57tFXiLCWjGhUtkbU33F
	pwqvTdZh6m9JfyU7VPRzJic/XzIotDGRsIUb0/scvzT1xx5ztW8WFfwVOJZxaO6614D0y3mn97r
	wjdoz08NOM4hitWA6KmPKtpG1KNBV4KCQeyE=
X-Google-Smtp-Source: AGHT+IHeTb+KjpEzUGH6xxkquuGpqUeE2z3SLZ3YYMjBrmPOTTp5rs1Q+rSp7Hjqt7D5WZoi9QAyXw==
X-Received: by 2002:a05:620a:27c4:b0:7c5:4caa:21a4 with SMTP id af79cd13be357-7c57c8fc42fmr2039679685a.55.1742185263212;
        Sun, 16 Mar 2025 21:21:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd9fsm549102985a.4.2025.03.16.21.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 21:21:02 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 446AF1200066;
	Mon, 17 Mar 2025 00:21:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 00:21:02 -0400
X-ME-Sender: <xms:LqPXZ52yovKdZjJ3SOnXeYxB2ej4pcMtiFkst1Vzy-dI-6N61hyscQ>
    <xme:LqPXZwE3cZKsKNknfMLdyprrc48zjkpLWqOxmXwpl5r9BjMaaBoEWtMJbXuRM8Gh-
    2Ll9bYg_zLO1mSXXA>
X-ME-Received: <xmr:LqPXZ56p65tliJaUcEqA-rp-7I5Bef_B8KIPb7cHEo48xK8l837Yv5lh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheptghonhhtrggtthessgihthgvqdhfohhrghgvrdhiohdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghp
    thhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhi
    nhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:LqPXZ22YRsRO65-Xihqf307y9YHUAHNSg0bjNr4VlDPn8lpXkgqrng>
    <xmx:LqPXZ8GYwEWWFQMsQTRolSaYsHoGhzD5-4XKoG9fTP9Sm2suQV7onw>
    <xmx:LqPXZ38MEW0gDgPOpdZ8B1NSavL6i_qnz5JpqEve2EjF7LQW4kz1wA>
    <xmx:LqPXZ5n9LdvedigTHnbjdxPg_84htT8WEFfv-bhsNwHdPnryaIwYWA>
    <xmx:LqPXZwE9KSRacawk3RMX8mH5rh6vsFZHOv1WOLW4dyRIEYf8W13OilEV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 00:21:01 -0400 (EDT)
Date: Sun, 16 Mar 2025 21:21:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@byte-forge.io>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/16] rust: workqueue: refactor to use `&raw
 [const|mut]`
Message-ID: <Z9ejLCnJHvaRWgQ4@Mac.home>
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-10-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316061429.817126-10-contact@antoniohickey.com>

On Sun, Mar 16, 2025 at 02:14:18AM -0400, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
> 
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
> 
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  rust/kernel/workqueue.rs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 0cd100d2aefb..4e27df324d26 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -401,9 +401,10 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
>      pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
>          // SAFETY: The caller promises that the pointer is aligned and not dangling.
>          //
> -        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
> -        // the compiler does not complain that the `work` field is unused.
> -        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> +        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use
> +        // `&raw const (*ptr).work` so that the compiler does not complain that the
> +        // `work` field is unused.

I think we can actually use the pointer casting here. Because now we use
pin-init for Work initialization, so `work` field is always used.

Could you replace this with a:

	// CAST: `Work` is transparent to `bindings::work_struct`.
	ptr.cast_mut().cast()

in a separate patch?

Thanks!

Regards,
Boqun

> +        unsafe { Opaque::raw_get(&raw const (*ptr).work) }
>      }
>  }
>  
> @@ -510,7 +511,7 @@ macro_rules! impl_has_work {
>              unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
>                  // SAFETY: The caller promises that the pointer is not dangling.
>                  unsafe {
> -                    ::core::ptr::addr_of_mut!((*ptr).$field)
> +                    &raw mut (*ptr).$field
>                  }
>              }
>          }
> -- 
> 2.48.1
> 

