Return-Path: <linux-kernel+bounces-385526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F19B3832
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2381E1F227E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F151DF744;
	Mon, 28 Oct 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz+1RXCB"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474771DF738;
	Mon, 28 Oct 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137766; cv=none; b=u9suzmBhRF80lBgb9M2F4laOnysSiEBWzV6t1tBhHUCK6rgxYaEucOyKz8GQVnzPxvlYodxpBs781+T1aQ9eE7vyod4p6LJkUYXWsyr+bEcesMcGtPZpkNm1WhiyWqq7+XhiMZQXY2CZ24DWfHIHU06Bl3o6KyKlTS1js/HFyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137766; c=relaxed/simple;
	bh=7ayCsqrr1mrRVearVMSZy/P4wPt6IXQWqnCFlaSfuco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn+WN6hVSsUyen5MIlQzDl5inKVN507f4ROAZAi2+7gg0Tv5JFL7dha9Bphxfomw4X83wxb9/CS7NSLZuu2pBOS6W5y14IKqryNcDKUBsuwWcI1fd1oUaK+ciCrdjU7x7sHllO2/eYXp/h8RL2/R3uImHveXVJ9aaiPFiFx2t2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz+1RXCB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460ab1bc2aeso29225901cf.3;
        Mon, 28 Oct 2024 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730137763; x=1730742563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf1VYV2hbE13vzY2iJV8rZEJWPrd1VFWj+kgpJsm7qk=;
        b=jz+1RXCBSAfiZmh0WmxKJQkHoFu2DOSRkGMTDDvwfT3ZjGdGzxJb5I4HEFZdS6AbxF
         xA7fVCwsGZ/j4iKVxKDgPPOYBPgKvGkgiHmfcSFwdW3tqFocJRNLaE3T7ckMqS4nHrBz
         BAQLOECZFZAPedyVHe1P0OwNrk6q95GvS645KnXxrutM+58eiUnr5ORyP4yaQdQLteGY
         ClW7OmoQX+WrjnRJcWvIPH/5v/uYnd99J0fH4RfluqNIRE5AyeH+zhZ1gURFnYwbiLY/
         k6n2QPyxOmTpShXAF2dE7zXbSiqIFCMCmfWbo0zkYFkm1O9rDHHORHMBU7h5NSlZrqH0
         UvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137763; x=1730742563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kf1VYV2hbE13vzY2iJV8rZEJWPrd1VFWj+kgpJsm7qk=;
        b=H2WOWlqKA6zYV9Rx9QlcHcwizoZEu2PXbsHadKG8r7DmdAVe2xaujX6iezJljIxKqq
         h9RcVUtY+D9HfbvdPJwV8+iLPne80FtmjYVVC0ypo23OjdjWHOu245+HSCgrYB7ci0Zb
         O36ErZnIISLR4toVV8oYRvLoi3MfC4pQm337V29Mphs4yq6K3X/YioR3UfnJmG3Z9nIe
         PwMLXkdkRjYo6kTe6l4UCLIoX5fSi58kvGz8l12cm17g2jL6x8NWzbjYKWBt0PLpDnQP
         x9iA3YCMYegbWQVi0ZIAy71EpReodsb2l146tzXrSqREoW56SQrjUvmpXNXeQgRki4SR
         /ffQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM3+wk4SUoMhevk1exkgPoDrcgCG7p6Jh67LievuDt9DRf/u3a/dsKab2LR0niMb0f7e6NJtbNvGk3Kfc=@vger.kernel.org, AJvYcCXgCvlwmAPtoBCoPxWvYFpiH7ON6//CeY8E6TrTbSLA4FE1lW9UiLQK8gReCb+7poeXVnLd3Kbr4BMTKSQ3D4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVnGQX0PhRg2i0TCKYE1OwRWmu76mCJjdyNljnW+rMVomyakE
	t5/mDqmkpSkyzndvxccR0wF9QkJfOK14AfJVZeIagw44IzHEnf0U
X-Google-Smtp-Source: AGHT+IEN8EOxvSZI1flKKC4c07nesJpaoYhHSnXkP01baQ7iAm3+Ai45AgTcMiEV6GxSUYk/xwTdDg==
X-Received: by 2002:ac8:5845:0:b0:460:95b7:bb0e with SMTP id d75a77b69052e-4613c055463mr131733041cf.34.1730137763122;
        Mon, 28 Oct 2024 10:49:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132164f8asm36676321cf.38.2024.10.28.10.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:49:22 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 24ABB1200043;
	Mon, 28 Oct 2024 13:49:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Oct 2024 13:49:22 -0400
X-ME-Sender: <xms:oc4fZ-LqpJZzwEI1Gt4t9xiE8g3wJPkYByE1jd6jAiz96nIb0d9OBw>
    <xme:oc4fZ2IqjRtQxHnvonUYO_-bL3pWjCkVe0egUuZvT2jghAcIYkhgHc2KD1wWyHMBD
    oFZBYK4oMy-a1kKNw>
X-ME-Received: <xmr:oc4fZ-tv55Sq7ImvfpTzrGTdBwxGth4LIBiEghDsUzR88ZHAhvvspHS08FY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    fihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:os4fZzY1n5DzsK0nm7RGA37th27fb7Pp4FO8kXR87MM_oybgF2SMMg>
    <xmx:os4fZ1bwo7subi7Wt7c4RemIPbEfdLfZRWxg3YEfPI6fht6_iKkegg>
    <xmx:os4fZ_A06dIdIKArYtHOQzAXvo7WYOiYGRFwCESRA5FD-1FGQK85Gw>
    <xmx:os4fZ7a7uLJgG0URknbgQZl2IJ8-lN29txnVg18k1O-dFZK1a1PnKQ>
    <xmx:os4fZ1o9xvmYf1ySCN2qmyVRSLfUj0yol4Fgy4eGfN-01eGrrjACSaON>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 13:49:21 -0400 (EDT)
Date: Mon, 28 Oct 2024 10:49:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v6] rust: add global lock support
Message-ID: <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local>
References: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com>

On Wed, Oct 23, 2024 at 01:23:18PM +0000, Alice Ryhl wrote:
> Add support for creating global variables that are wrapped in a mutex or
> spinlock.
> 
> The implementation here is intended to replace the global mutex
> workaround found in the Rust Binder RFC [1]. In both cases, the global
> lock must be initialized before first use. The macro is unsafe to use
> for the same reason.
> 
> The separate initialization step is required because it is tricky to
> access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
> require changes to the C side. That change will happen as a follow-up to
> this patch.
> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f637@google.com/#Z31drivers:android:context.rs [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

In addition, I've also queued it in my lockdep-for-tip branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=lockdep-for-tip

as I want to help route Rust lock-related patches into tip, so this is
a practice round for me ;-)

Miguel, feel free to take it via rust-next with my Reviewed-by, I will
drop it from my branch once if I see it shows up in v6.13-rc1.

Regards,
Boqun

> ---
> This patch is based on top of rust-next as it depends on:
> https://lore.kernel.org/r/BL0PR02MB4914579914884B5D7473B3D6E96A2@BL0PR02MB4914.namprd02.prod.outlook.com
> ---
[...]

