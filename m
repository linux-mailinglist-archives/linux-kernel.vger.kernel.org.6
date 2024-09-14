Return-Path: <linux-kernel+bounces-329186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F73978E77
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC221F24E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5129017C9A7;
	Sat, 14 Sep 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgKfcvbT"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7E748D;
	Sat, 14 Sep 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296076; cv=none; b=f9B89d+RC/TzevchzYyY7sGGHwJBrazRDEZh9C4Z+VTDJSj8UhEhmSI553lHdNiztRH8OU1YYZphsRtVlWuMq/fFEhuRAC1SeDjE3lurcSztCghgfO1xvTHLXVeoxRLPrFbdXxLU0Uy2gnoPBGOCiVF9Hzp0YAEAzyMWK6wL3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296076; c=relaxed/simple;
	bh=i6x5+w90U8Ps5RP3eYPjER699hgmw+WWRz+0AwTGLfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqXoWKVoQJFakZAZLVQL2rCOpWEldS98D0r5uE7ypRPtrorccP3i3WnidPe677SUHQWDfraxg+ILbuQxrzDj7Ved650dehF9hfExl3VZ2m+ri8KOwODaLb35sEd6Oko/u4NVI9zaGtgsnlumsod+ku4m745cH8lg5+qZxbDj5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgKfcvbT; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c351809a80so21751226d6.1;
        Fri, 13 Sep 2024 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726296074; x=1726900874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Utq6wPOaksPeu7TRNeQZKl8eCYWJU4eVCJRxeL5AQ=;
        b=bgKfcvbTB7A8WY2kjE/ZoPnE2YO2TP3/j7ZhME+B6cjQEvRYNbXHbrQnSW+IOiE3m8
         O0rl7q/lJsZAk6XVn5MPjyS4KaV6zJioKSR3TgWARwA/BRUqTHlzjTibt3TOMFG33cav
         xGBm8MH0P7VelN2C9fVCdnX1wlX6ZVYtY1cNBthyTeWeVURYbLyJ8huqsAYFq/l9FlUj
         V9QmFxPmKVVsOYqznwBQwTuOyORxlomwhN1gCJhSUkMANYAfIRvP6ZfxmM1gXwgtcAs1
         pMvheqC+ASoWwF2mGaVFnI9HshYaYGx74pE9UM21ZhEiJVsAmJvK6MD1FF2n2VMrRixk
         YJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726296074; x=1726900874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6Utq6wPOaksPeu7TRNeQZKl8eCYWJU4eVCJRxeL5AQ=;
        b=VkvueVx8Nf9q4NnqhnW3Dv10F3QQZZA3ZSgAv5xbIaEO+D2QYhmb5RqGkHS/RmLUlG
         +h/pqCUSSsDMD0ibyAwDkurkRgl+i2cmxONiOpGSFw7szyE9EI9NdvEJX1KNRxSki7+f
         SjGimYj3RMVUAqB54PxeVm9CL33xOPApCt15/nqnYFXl+8rbdM//315mDKHaIcwEUEUL
         icjDZNj2uYp8kWAP0XrfqT/qZmi6HVs0IWqJf6QQrJiRa0y8F1zE7gnRqD+5NQILPwX7
         J+qrYOXzGDdaB5GwwURoo0jR1fNukDj3ubI0bWv+BQwQmuhPGVJrDkKunbGcktxy78Uf
         js6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxrEsBd+94E0H3GforO9f5Yrvy+dDa1qVrxCHt5DQIRYF8Tqh8ONZdjtTc0yelzeovhUzo1mENvI/WZvq9GQw=@vger.kernel.org, AJvYcCW8K7t7DkM+Vt9UMMUmJprdxf1K37cOoQIG0SVSvOuJwBvAJJmOsgxBQJi+/byDtvedTo9eoYdM34NzEo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1y4BHmHhCBiqSef+PKTUYISSl7UxwaS5ZKBFM0mWOthtUXySj
	4PMe1v2H1fz71g4K/iuRaWPmkfhiMCf0hdaBD0bmTfkPH8BQokFH
X-Google-Smtp-Source: AGHT+IFnc18cSpUrpNwkFNDWUcQNlLf7zsEk4fFAIjMHa1BqZk+Ip1Od++IGx10jUpUiZzKQWn2HiQ==
X-Received: by 2002:a05:6214:469d:b0:6c3:562f:568 with SMTP id 6a1803df08f44-6c573477a68mr154519336d6.0.1726296073987;
        Fri, 13 Sep 2024 23:41:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7d589csm3860446d6.132.2024.09.13.23.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 23:41:13 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 319C51200068;
	Sat, 14 Sep 2024 02:33:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 14 Sep 2024 02:33:59 -0400
X-ME-Sender: <xms:Vy7lZrxxFD58crdmOFvVUe1aXZGpXWTMDXZSItZbOvj81JBKe3uZpA>
    <xme:Vy7lZjRxKfaLRhFaHUZj1tc9IIVAMZB3mNNMHyLpLtEeqJuk5h2hNSNmDwrhfiyFi
    QNApocfrsy2X7RnBA>
X-ME-Received: <xmr:Vy7lZlVDqnYrzahoa2n8sVoSXiVvo3sVAXR8IsST280JJ9h56KvYjR5i8AcNSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurg
    hvihgusehfrhhomhhorhgsihhtrdgtohhmpdhrtghpthhtohepiihhvghnghhqihdrrghr
    tghhsegshihtvggurghntggvrdgtohhmpdhrtghpthhtoheprhhomhgrnhdrghhushhhtg
    hhihhnsehlihhnuhigrdguvghvpdhrtghpthhtohepmhhutghhuhhnrdhsohhngheslhhi
    nhhugidruggvvhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtph
    htthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:Vy7lZlh1PIyscQABF8npfDdm8-7f39Wy6eas-mJGizUpRGdaZh2JPg>
    <xmx:Vy7lZtDKjsBFd_HIomYtN1ds7MvZngO9nYOFKPNgVvDOboucXeqeMA>
    <xmx:Vy7lZuLWqR99KHccnIRvR2lZKyCIQrXUXc_b-wqSVxw4QDU_1tGiiw>
    <xmx:Vy7lZsAbVZn5_gux__0x4MFcleyvSO8NA9rJb-DwodOhKg_cHpbctA>
    <xmx:Vy7lZpwd3N31Bgnpul6uYXjFu8qNmiqDPnEHtVzTocZVNq10sacym68d>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 02:33:58 -0400 (EDT)
Date: Fri, 13 Sep 2024 23:33:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
Message-ID: <ZuUuTS096DcmyofF@boqun-archlinux>
References: <20240912-shrinker-v1-1-18b7f1253553@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-shrinker-v1-1-18b7f1253553@google.com>

On Thu, Sep 12, 2024 at 09:54:01AM +0000, Alice Ryhl wrote:
> Rust Binder holds incoming transactions in a read-only mmap'd region
> where it manually manages the pages. These pages are only in use until
> the incoming transaction is consumed by userspace, but the kernel will
> keep the pages around for future transactions. Rust Binder registers a
> shrinker with the kernel so that it can give back these pages if the
> system comes under memory pressure.
> 
> Separate types are provided for registered and unregistered shrinkers.
> The unregistered shrinker type can be used to configure the shrinker
> before registering it. Separating it into two types also enables the
> user to construct the private data between the calls to `shrinker_alloc`
> and `shrinker_register` and avoid constructing the private data if
> allocating the shrinker fails.
> 
> The user specifies the callbacks in use by implementing the Shrinker
> trait for the type used for the private data. This requires specifying
> three things: implementations for count_objects and scan_objects, and
> the pointer type that the private data will be wrapped in.
> 
> The return values of count_objects and scan_objects are provided using
> new types called CountObjects and ScanObjects respectively. These types
> prevent the user from e.g. returning SHRINK_STOP from count_objects or
> returning SHRINK_EMPTY from scan_objects.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
[...]
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -45,6 +45,7 @@
>  pub mod prelude;
>  pub mod print;
>  pub mod rbtree;
> +pub mod shrinker;

Meta comment: I think we should create a mm mod (memory management) and
put shrinker there, otherwise there would be a very long list of "pub
mod" in rust/kernel/lib.rs ;-)

Thoughts?

Regards,
Boqun

>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
> new file mode 100644
> index 000000000000..9af726bfe0b1
[...]

