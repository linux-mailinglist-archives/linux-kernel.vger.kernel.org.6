Return-Path: <linux-kernel+bounces-563321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4503A63DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B413ADE46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2C215044;
	Mon, 17 Mar 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQfNIQPH"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44AEEBB;
	Mon, 17 Mar 2025 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742184063; cv=none; b=RIFQEaxYBh6YH3c76b7AdP21xRUqCSklhnVeK/clHHyV0mYzGCVtvXiirPtOj7TEPXsv+i1U0UDiHTEfdZK/1ycPMbmqPgguEjxz2wzO497V4r4FoKaoB7nhr+Ge2L3YmI7Aq8VMTAWE7FUYrvZjNTkhH7rv3tqor3vT2tFmQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742184063; c=relaxed/simple;
	bh=CPRK+WJkOO4h0Vp9h8+sDfVxsygNEVJ8QoQNxeVtxbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1KdMoDR9CAtwbwRh6eaB0KY1vH5AtwtSg0syW6fZo/Hc6qQQnqdD5n8AxEo2c2tCNu1+Y5cPFgIaWnSNZagSvAJgB21oi+189H1k5V3JX7VHXSzj5V85gMiFhFKVxxy3G0o52ESByDGZNGVGCCPU+V+TPkmuouBFa7BdWD3/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQfNIQPH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0a159ded2so532055785a.0;
        Sun, 16 Mar 2025 21:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742184060; x=1742788860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0RY31U7IeQCdaigqT63GbXTi4AkErC9Ud8HZP9nkSk=;
        b=aQfNIQPHB3fF4RwzB2wM0ZKABeNLVOxp/if1vgEfc+fKbjFkroe//FBIlWYBz+q+I6
         dljTUU5zFzSGWlhEqmoLQi2j5RIPyIShkfevh/PdfXIQu9UXx9cxNxaDP4Bb8G4owy4i
         asyWpM7zNwqAuhCxSVMVIIKQ4Ek7Jee5HUbMhKuUvjNE04YKTA9zjykFkjzndg62wlnr
         Z+B4co2CCIzKUvHnsG1jTIYjSPSp//YEistzS6e7tZ/Y293y09U926sATeFG6Zw9d+qf
         C9fS6jpVeF8NnV5sYCIg//4urC7FqGcbPCdLFfo62s6KmPvugB5aLB/SLSIERI/8aCqE
         eE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742184060; x=1742788860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0RY31U7IeQCdaigqT63GbXTi4AkErC9Ud8HZP9nkSk=;
        b=d8d6EZ8UDO7RDmRV59DwwOvujRg73IPLU7YacAxlDJ062rqfRYRULsTA8eDTmLp6w8
         snAt9HyF3v/0Nbu7KhdAfyRgz2pW2Q2vxSuQLK1uvRUeQX0u1vd+h63DHUb8XsjbfqFp
         NIr3JrJIrqBKMKcrvZz1eTUcbjOHMnFGBCtmcBNiL7CAs9qtDE5ui9m0WtaZ7D0pKzmE
         G/rBB3HzOVG0HLAyXzhUv3F7S1hVTGB7vLpJ73Is/EcGHn5e/jw3U0m5Al4tj586JwF1
         dyPJGROH0FdD5dxqdLMnOUDY3gKBBYh//OQUixvzfYB3pTFWcic+x1DPD2bEryGlaoU9
         a5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVAuKK2l1WuSVpRBli3Yp3ert13l1GcRccOC08GUOSxEceLgwJLadNUQXzhC8bL5WVQ8zWX/KrelU95lMY=@vger.kernel.org, AJvYcCX5Povw1SbRb3JBXenvYBHSYx195FQa0Z11nYcFXz3k+kAmVVJu/dMfjWItjPb75uNKSKs6zUVpzgxVvquJFzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87V++CwTBwwdoYCxLiunH2ZZGsHKOwVFoMwziAihBQ9e58Jf/
	TqHyCUXh+Q76Hl005+ggAP0jW/b3QusleFiogqXrnj/KSWprACDx
X-Gm-Gg: ASbGncucMlJtSRMPLN9+1MoBZPzDBpTbbJjpSDDI32+NjuPS5Bt8LAxdJI5PGg8zK69
	hAxAa3DZLNRO7ajy+zUyMtUi9TigKBNI1Iq8jOGDYwQOxelU/PCUJGhfpas/pUG6oOdVKT1JGDG
	Mq6wDD7D9pOkuxQPOloOebgoRIMJ180PJM/x+oXQcAeHOx56lDpSOY19NUz4rCS5PaTWt+u6jTs
	b2waIMsxaSYD/iw5Jm7/zgmZ+ENi/gO5GtT2diy0oz2YEGEIiWF8RcEGYjJGcQW+kQrhSvzHyep
	gKCbAjz+atKcNSqj961cnnoxTGDOg7223bgoZZhlkArBBKuE49GDDpajhuQch+bk6InXHBvQuhe
	kfYMYXIhRiw6YiOfRb+2XwnEDzCyT/vkhhPA=
X-Google-Smtp-Source: AGHT+IGYQe3AtIK+Tt+34wc6nrL/bqTpsVN0e/l7vVIWlB5VhW2ixXwbMxLBGm7aMe4he1pcGcwSGg==
X-Received: by 2002:ad4:5f4f:0:b0:6e8:9d00:3d71 with SMTP id 6a1803df08f44-6eaeaa2389fmr161898576d6.21.1742184060285;
        Sun, 16 Mar 2025 21:01:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330b72sm50588896d6.72.2025.03.16.21.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 21:00:59 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E4F6120007C;
	Mon, 17 Mar 2025 00:00:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 00:00:59 -0400
X-ME-Sender: <xms:e57XZzMXD-BH5R5FyVdfv23mcleoZ0uDObogRhxq-0vvjtXrrTvlJg>
    <xme:e57XZ9_OPtpybRUU2Dz3-rIxCHUe_qji5M_CF1RA8wAzTNI1Cl0j0WShnHnh2sEm7
    TfkGabAlkVFqsG2Ug>
X-ME-Received: <xmr:e57XZyTHjmkWCCDfmRGl1d-3y5HIKR5cJk0qFMrjd28k_6daLcE6vZ64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejieeffeeffeehffdugfetveefhedtheeu
    tdekudfhtefggfetieeiffekgffghfenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    grshgpphhtrhdrghhrohhuphdprghspghpthhrrdhpihgunecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuth
    hhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhu
    nhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtph
    htthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhtrggtthes
    sgihthgvqdhfohhrghgvrdhiohdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpg
    hghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhs
    ihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:e57XZ3uOyErEeJWNcNCalErNQI94Y4kWfmLySK0Oj-nBon1rYuca1A>
    <xmx:e57XZ7fwDkdAKMC6-sMSfl5_cb9IFKoeajSzfn2ThD9oktEfhn3tLQ>
    <xmx:e57XZz2EO8kDXnoAso6ZXEZHkOzOowIndyyjxqZHXqKvc5PgfpuD8g>
    <xmx:e57XZ3-t_2cDCytk2N9CWFGo-ixIqc6fBfE93QSKiaqLgmd-QqcqfA>
    <xmx:e57XZ-_FgRkJXmbaivMMReNZRw1rwIidqAJarudCJVSPKRYe7p5TmV0f>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 00:00:58 -0400 (EDT)
Date: Sun, 16 Mar 2025 21:00:57 -0700
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
Subject: Re: [PATCH v4 04/16] rust: task: refactor to use `&raw [const|mut]`
Message-ID: <Z9eeeTpSr-vVD5eL@Mac.home>
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-5-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316061429.817126-5-contact@antoniohickey.com>

Hi Antonio,

On Sun, Mar 16, 2025 at 02:14:13AM -0400, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
> 
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
> 
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148

You need to change the above because this patch doesn't replace
addr_of_{,mut}!() with `&raw`, and also the patch title. Thanks!

Regards,
Boqun

> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  rust/kernel/task.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 49012e711942..568b528e2cc4 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -257,7 +257,7 @@ pub fn as_ptr(&self) -> *mut bindings::task_struct {
>      pub fn group_leader(&self) -> &Task {
>          // SAFETY: The group leader of a task never changes after initialization, so reading this
>          // field is not a data race.
> -        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
> +        let ptr = unsafe { (*self.as_ptr()).group_leader };
>  
>          // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
>          // and given that a task has a reference to its group leader, we know it must be valid for
> @@ -269,7 +269,7 @@ pub fn group_leader(&self) -> &Task {
>      pub fn pid(&self) -> Pid {
>          // SAFETY: The pid of a task never changes after initialization, so reading this field is
>          // not a data race.
> -        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
> +        unsafe { (*self.as_ptr()).pid }
>      }
>  
>      /// Returns the UID of the given task.
> -- 
> 2.48.1
> 

