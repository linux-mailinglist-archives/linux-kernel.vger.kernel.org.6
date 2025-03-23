Return-Path: <linux-kernel+bounces-572915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D96A6D06A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EC5188C9B0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F2188722;
	Sun, 23 Mar 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5xw1S2n"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCDE17BEC6;
	Sun, 23 Mar 2025 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752148; cv=none; b=nWqNyPEPi/XJR3/sDaqhNhBbRt9/OwJsExx4VZiXjPTmryGYyELIrc7DZ5ogU8tXm2UoR7fz8HcnW6tfrBS61kVWY+Z9cKp8yNN1bgmRH4CXtKhgI8H2ra7/rld4eRnd5+FgprIszdrhZjysvFJnYSp1aaxJeTy2yvXsNp5JfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752148; c=relaxed/simple;
	bh=SG/EBYlZWIpjS2XnWIM7BPdKAfQ27KKiGHLIKdXWnY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9dLIYoZTcu5lRMaySIO1LV3RbAokotqlK9P354aIbPOaiSpr6j/nZUvLw3BUlCt28lbItOSsTATBDfmkVY5Tu8CIK5k/laGAQ5eZIDhbRweliwgoFpaabcYA26EBNB2fB4PWiLS31dvcOXY7PzeG6jBfqWhdiB3eR+OpKIkxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5xw1S2n; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47688ae873fso37912671cf.0;
        Sun, 23 Mar 2025 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742752145; x=1743356945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ+uJqVTsZ3avtStcJ/Ztz1VeIpyTD8NbqJn/aT9rMo=;
        b=F5xw1S2njXwh9QuE9EBZbZBmN9sraMQZKRcukqnCNm+UKmrk3/1/tzXXDvomCMHsQR
         cXVuE4PiG+zyjAw21/b31EdyFOPH1v0/wVENDyQS9MxZWT2O9A1T1nmx3ICa/+qt1pCt
         i8FlA7BpesdkHF44cr+zXauq+i9/JQgj2NbBp3/C4kevWNDCeGrnSEVRQINBNitEuHWt
         DA/Cb7Ur5lWpfmOB1VK/s5TBH6dGCPchH3DixYIkVY3SK9hp3+0sDV6amU+3ITIegm+p
         W9aodPszT/IXpiO28M6lv9lT6MyfO38BDQBL/sX3Rg1mgMQKUiwH2r9nSj9eTtrO3PRr
         kVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742752145; x=1743356945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ+uJqVTsZ3avtStcJ/Ztz1VeIpyTD8NbqJn/aT9rMo=;
        b=YkLFvv2OITe2jUuBeh24WXL3LL6qxuiYvp398KtnI/vvIedG7cBeD2MY0sbMD69Q+1
         q/PSOvg9s5+B25XdooYDq+S7CXtNe0nUo0IZ/z+xtLKrJmTQcV6G7FodVs+sspmm6kmR
         pB7fFvBcEwZfxF4y+AUDFwwuh0p1HJmNB0aduytvbbPgB5PnyLdIjLS2G3YagE5Alxob
         hEJzOWnawG/PVsLmYjAEbSjG+ofsu5ACvQG3luA9PLWsCMqLDsD2VXkJ9E+H3yT/IHUr
         gbJbv61PuYhjpQDZpwcw+sX7zw3TpTbevEUOTpsKf2pL128jN7T+moXlrA2zapgBaiAo
         fUgw==
X-Forwarded-Encrypted: i=1; AJvYcCVNe7wT7PXBrLgGczilndOl7+bm0AsYwrDiMkPlYU+oFsWH/o3oZuyHCwwslN3soieKhLMS9InZjub2OrE=@vger.kernel.org, AJvYcCXb9gNO3hEFyWgqk5Y+vBp9yOl9VncpqchbRbYYj7zzOr4t11MRfKa2/cSWs8tlyD2woBgGH9UQwh6b9FZ0tD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJk2KHVu4BXFEJb5DqXgInx00Lgx0fTUUqgHBmAu8ZGclnb19J
	/iHfYxaXo4yK51GGPdN3PFkQ3fdTdJsOkDyhDwsGhFUBJ3tHNoxZ
X-Gm-Gg: ASbGncsipE/4nmANEDQyGu6v9N2hstu8oA+ly8QsNOrGYHnHkQo7i/+xce1FMyiVXvz
	D8tONxgN46ilRPdqI3KpIg6oarY+QbjRxW7nsSGZfIC0/WAc7oxSTJZKQTmcsTEqGBl+iZkQbPD
	cI/LL4a8TAk3kjtRDvLCP7RU/cO9reHUvUjnCwbFaiumLspao683pslv8Akizi2qoz9iHUbYX2l
	/0SsA26XG435+OzJkIiq8KxlFT/sSy9NXcUOHQ78lkiOLr4h0GuVUvV3/zxW3fDKWmvlzRsh3nk
	aoR9FTSuds1MoqZNWsdoC/t82z6MPeGfGRxPiJlC4rjvDcqONvSwb97OgqfgMwt0207KBY2kF3E
	Ime8GxWVsOtby5rcJYHYscWzMiJE7E7SB0HA=
X-Google-Smtp-Source: AGHT+IHwOMkiPyfCebAU+FAmjNOE9+kHDmW37cwJs+eNWPDT3lqiXEsUNpMavaTipAKKb+6RfMr4eA==
X-Received: by 2002:a05:622a:1928:b0:476:afd2:5b5e with SMTP id d75a77b69052e-4771dd65d18mr208515231cf.13.1742752145286;
        Sun, 23 Mar 2025 10:49:05 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d179f42sm36056481cf.25.2025.03.23.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 10:49:04 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E888E1200043;
	Sun, 23 Mar 2025 13:49:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 23 Mar 2025 13:49:03 -0400
X-ME-Sender: <xms:j0ngZ90Mne4yNM_NAqXTZLpCComvPhYGRqfGdjav1WBhnP_AAKhNDw>
    <xme:j0ngZ0EkH3zseaheX6S92TVMVS36FBbHPdZpNwTc-pPoGMEwjgLhoPpYJeLwHIgth
    9vpia4duZJrXlWqDg>
X-ME-Received: <xmr:j0ngZ94tIZVn4fwyfX8gCWEjuXOH0uMeLSiNPArPus22lPAs1HgMVrt2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhhunhifuhdrtghhrghnsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:j0ngZ61n4V_BhQJwP8uulWcxWCfztjIu65i8y0ldbM8SR4bDPpxU-w>
    <xmx:j0ngZwFX3isJBz5nUmQEhXOTohqKliqTSz7wxGhW2MX68u4cM4Ci0g>
    <xmx:j0ngZ7-NqAPfMHfcTHNuwOFxoJHlLcu_NxfyGMCEYXXoOIyjs2jIJQ>
    <xmx:j0ngZ9mFz770s8ReWyObLlXDa2gaxPcMRPmGkK_VHTxB7yuc77A8BQ>
    <xmx:j0ngZ0HAWUuJVohC8nduQIUGGvvwJjg34izbUVxe7-m9rDnSVfU753uU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 13:49:03 -0400 (EDT)
Date: Sun, 23 Mar 2025 10:49:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@gmail.com>
Subject: Re: [PATCH v2] rust: sync: optimize Rust symbol generation for
 PollCondVar
Message-ID: <Z-BJjjEZBzwKJ9mS@Mac.home>
References: <20250317025205.2366518-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317025205.2366518-1-kunwu.chan@linux.dev>

On Mon, Mar 17, 2025 at 10:52:05AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $nm vmlinux | grep ' _R'.*PollCondVar  | rustfilt
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
> 
> This Rust symbol
> (<kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop)
> is trivial wrappers around the C functions __wake_up_pollfree
> and synchronize_rcu. It doesn't make sense to go through a trivial
> wrapper for its functions,so mark it inline.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> 

Queued for future tests and reviews. Thanks!

Regards,
Boqun

> ---
> Changes in v2:
>  - Add link and Suggested-by
>  - Reword commit msg
> ---
>  rust/kernel/sync/poll.rs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
> index d5f17153b424..a4f92c545fec 100644
> --- a/rust/kernel/sync/poll.rs
> +++ b/rust/kernel/sync/poll.rs
> @@ -107,6 +107,7 @@ fn deref(&self) -> &CondVar {
>  
>  #[pinned_drop]
>  impl PinnedDrop for PollCondVar {
> +    #[inline]
>      fn drop(self: Pin<&mut Self>) {
>          // Clear anything registered using `register_wait`.
>          //
> -- 
> 2.43.0
> 

