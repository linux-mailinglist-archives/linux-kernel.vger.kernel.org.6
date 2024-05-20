Return-Path: <linux-kernel+bounces-183902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B008C9F98
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E751C21028
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B14136E26;
	Mon, 20 May 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/NxzsHE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B3135A79
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218679; cv=none; b=eDYd2EdLCtxJmCe3I1nnt/GIU9pH33kiC4CqvWHSZnCIaj9nO55SxW7sSf1qfs1lsebmqZhWlz3CXcOb9TZup45ZelvtLalu9wn0K+BaZ2xxnVTjaZKhWYiP77ESLn+Eog+mpNNeMowKkhptnND3/j1rGOL3OPPAL2gLXy0f52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218679; c=relaxed/simple;
	bh=/bYutIsSrxoty/i0tqxvH1agSRzviA7eI9qMo7lmngg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHtaEyV2jgCWpsYeojURsSXYvDCJq9NQmJhrVrR3K5yvpcfY+9PD7GvTm39K8X3QMsWULTqmlwjJo4iyb8R05PQqwkksQIPJDiR2FJtUpGBKGQLn9zAJohmW4Dj1g8nnj339YGuGOuQQDxDdDME7faJiyAI8FeKO3fvlJTpDtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/NxzsHE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716218676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPzD2EYz+Tws56HwE5fNBA/4Wwv6n6zB3tlyojChHUw=;
	b=J/NxzsHEf6OCSitqSjOsgtr0U/A95AAJbZkP52gRbIOND2QALRM/mwoonwxCvkZu3M7l7y
	amxxSbNjy1E4XWdNdWaUtd2T4oBO5M7U0w4Wm4ryoH4sMkYJkxmNqbGmilO14csCVFjjs+
	f8eYrdAO1H7XYwGxaBo1meO2s2trLvM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-9s5979q7OyiC1nFId7_BTg-1; Mon, 20 May 2024 11:24:35 -0400
X-MC-Unique: 9s5979q7OyiC1nFId7_BTg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-420094e8896so42649105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218674; x=1716823474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPzD2EYz+Tws56HwE5fNBA/4Wwv6n6zB3tlyojChHUw=;
        b=uFUlnxg+nAxjGo9CnVpSqZ2RuLepDWKDafzI5o2+l+766Zsokn9xvGo186ixWafs01
         mTht7a6+NOK0QNLrKvwNJvA5EyecsFEz1RVraDxG8xBq8i54ce66taq6kVcekNdVnpIf
         zxoCiW45Q9vlKAy5yj4UfePpLG14WiR1KXmU1N4hJkDwuc45iTuhT4s8FupxzjNCp5bX
         4eAhiUV6q+rf5ag5iSrvPTblZgVa6eXWqRJoRH+1OGMXDm5AnF/kpsZgtTNhcSZIa2zN
         /73hcU1RL1c8yu8mfRqZj6wb95hx2MsVV6aS7vDBzV3oKaoPMY/LS52of5eDWqWMDRB+
         0n0w==
X-Forwarded-Encrypted: i=1; AJvYcCUoBOupTQtCUY8mOumht660mD/2VbEjDzYa6N8Goab/8Av/QM1M5Ckp/RQnEoDLKjjcGfqIfPGmZVut5wGBauYsg+l5zlJkYcI/XLU9
X-Gm-Message-State: AOJu0YyzYLInb1EpasrTOh6r4rPuaURhbbm344gJI1MuEPcaFVpnCxvq
	36VZFbTZEuL2x6sqbemmsxmkQlG4qLkqZ3Bya0s/5nO05MkY/2dyXwiAum/tP6lRGaChxsc/vp0
	SrlSaJdeP1Fd7+cwagb/fOTDVmsZTVKcsAPxX4JmTcmz6fo6BMy+6Qhn3f0NyTA==
X-Received: by 2002:adf:f746:0:b0:347:3037:188d with SMTP id ffacd0b85a97d-3504a737594mr27533409f8f.34.1716218674166;
        Mon, 20 May 2024 08:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFybBVRF9qV0XR+xTmYzrgRY5zsNr68gufSFbFaQHscL73I++QGoGy2M8cBG9NDuhAutpTMuA==
X-Received: by 2002:adf:f746:0:b0:347:3037:188d with SMTP id ffacd0b85a97d-3504a737594mr27533388f8f.34.1716218673765;
        Mon, 20 May 2024 08:24:33 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:d829:d5ef:3adf:70e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc8esm29279979f8f.15.2024.05.20.08.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:24:33 -0700 (PDT)
Date: Mon, 20 May 2024 17:24:31 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: avoid unused import warning in `rusttest`
Message-ID: <ZktrL5YcHx6kKtLR@pollux.localdomain>
References: <20240519210735.587323-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519210735.587323-1-ojeda@kernel.org>

On Sun, May 19, 2024 at 11:07:35PM +0200, Miguel Ojeda wrote:
> When compiling for the `rusttest` target, the `core::ptr` import is
> unused since its only use happens in the `reserve()` method which is
> not compiled in that target:
> 
>     warning: unused import: `core::ptr`
>     --> rust/kernel/alloc/vec_ext.rs:7:5
>       |
>     7 | use core::ptr;
>       |     ^^^^^^^^^
>       |
>       = note: `#[warn(unused_imports)]` on by default
> 
> Thus clean it.
> 
> Fixes: 97ab3e8eec0c ("rust: alloc: fix dangling pointer in VecExt<T>::reserve()")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> ---
>  rust/kernel/alloc/vec_ext.rs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
> index e9a81052728a..1297a4be32e8 100644
> --- a/rust/kernel/alloc/vec_ext.rs
> +++ b/rust/kernel/alloc/vec_ext.rs
> @@ -4,7 +4,6 @@
>  
>  use super::{AllocError, Flags};
>  use alloc::vec::Vec;
> -use core::ptr;
>  
>  /// Extensions to [`Vec`].
>  pub trait VecExt<T>: Sized {
> @@ -141,7 +140,11 @@ fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>
>          // `krealloc_aligned`. A `Vec<T>`'s `ptr` value is not guaranteed to be NULL and might be
>          // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T>`'s capacity
>          // to be zero if no memory has been allocated yet.
> -        let ptr = if cap == 0 { ptr::null_mut() } else { old_ptr };
> +        let ptr = if cap == 0 {
> +            core::ptr::null_mut()
> +        } else {
> +            old_ptr
> +        };
>  
>          // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
>          // `krealloc_aligned`. We also verified that the type is not a ZST.
> 
> base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
> -- 
> 2.45.1
> 


