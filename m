Return-Path: <linux-kernel+bounces-328739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7AC978812
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E851C20DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059F12C552;
	Fri, 13 Sep 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YFLfK5Jq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90BBA37
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253122; cv=none; b=smNQXCU38C12Ebp9SPSslS2wbBcurFYvBkO22t/dlqAeh+zVEmSIGDymarubukzyGPVcJLXLDLovSfWiTMRXarMyBlisdDGbWO2XMvDeYG8jA23ldhC7j5kW7flR1dY8zvUhlrGEJVaHwYJfeiaYH6RmY83oU1UBexLhL9k8iZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253122; c=relaxed/simple;
	bh=GlBvP3ViV9KPWtoucCkWNwSLKlfFG/0mIg/gEdqo61M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzwkT/LqrxrCiHXIj2x/mXkuvfcPNMVFPZRvZ0mOnyuff+YqkwOkydR1T2LR8l2EhkSP1tIoYLiiYHUK9dU6EFusNnR7cXdpZE1Q0Wowcpjp0nKgXVaxDjP42G6mJpVc17QekjlCUNBajBqKKqqBp5t80hC+2dHgT0CQ7vE8Tx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=YFLfK5Jq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so24143875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726253119; x=1726857919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSzjfySTjvZJGJIQqb4ynY2CDR7SAt/ILMEUtxFMYeE=;
        b=YFLfK5JqKannNOx07APWZygbKmCAMb6NOqUFEZsWYDWzi1/KWoJtMxKmBaVRnhtPIn
         r9medNucrg+cbHiR2iP6Ja2bGK/uCK6hznXX11EB6dT1YZpnvKi/134sHKPy5+RSzvSH
         BTKdT7WJB33NgfHkVeyahrhsIRStu5LtBrCYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253119; x=1726857919;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSzjfySTjvZJGJIQqb4ynY2CDR7SAt/ILMEUtxFMYeE=;
        b=nzKfKoGX+d3GLtifl2Kx7Kgbi9LRi1xAKUs1ZdqkLVnnMWAYKDv/hVmuwyMeKOWtUL
         BH6gcrXBkMNrSSH10qkvUULnNZGld7u9o2KfC9J/615WR9XV3x9nQ2erxJUVxviDm/In
         knT6S1U77g3nwgqK+MI624Foz+9AdAd7z9V2nldZbu36YM0pZQCHtnfyhSnZJEiltiEY
         sI9gK67GxYhcsj5I3qB4eIMUylR/Y0gCWphqxy3EiLGolTdGmbj4zdtmDAvNlsjAejvH
         IwDl9x3qOa2siP374chdviuEH5B/X3OaZnvmRyQWX6EYHUCAKvCklriKQV3i9YYeooIs
         Y1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXJfmqnHhRnD07UbM/ndifdRDM/GKqtYbkLg3n6ATZEgFA37on8hik9poHhZxam1h8H3i3WI7RL8CqCAnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp82841UPCDwKNbheNCpH2aHKtjsIDBpgNRa8582bMgnpbJzMG
	WqXcD6wQW1D/sfs7aXi3WtQSiSpI06E/WiPRNqH0StcenJhc90mEYhB6IhCivDU=
X-Google-Smtp-Source: AGHT+IFPN0GwoCbn4Rkz9K4zq2VjUv9KlAEsC/5ciNxXM3x3Pn5uZy49vr9hXmEsYYlJz6eJPjBoDg==
X-Received: by 2002:a05:600c:6b0b:b0:42c:bb41:a077 with SMTP id 5b1f17b1804b1-42cdb56daacmr58188035e9.23.1726253118897;
        Fri, 13 Sep 2024 11:45:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665632sm17538008f8f.37.2024.09.13.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:45:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 20:45:16 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
Message-ID: <ZuSIPIHn4gDLm4si@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Thu, Sep 12, 2024 at 02:20:06PM +0000, Alice Ryhl wrote:
> The `impl Sync for LockedBy` implementation has insufficient trait
> bounds, as it only requires `T: Send`. However, `T: Sync` is also
> required for soundness because the `LockedBy::access` method could be
> used to provide shared access to the inner value from several threads in
> parallel.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

So I was pondering this forever, because we don't yet have read locks and
for exclusive locks Send is enough. But since Arc<T> allows us to build
really funny read locks already we need to require Sync for LockedBy,
unlike Lock.

We could split access and access_mut up with a newtype so that Sync is
only required when needed, but that's not too hard to sneak in when we
actually need it.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  rust/kernel/sync/locked_by.rs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> index babc731bd5f6..153ba4edcb03 100644
> --- a/rust/kernel/sync/locked_by.rs
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -83,9 +83,10 @@ pub struct LockedBy<T: ?Sized, U: ?Sized> {
>  // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
>  unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
>  
> -// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> -// data it protects is `Send`.
> -unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> +// SAFETY: Shared access to the `LockedBy` can provide both `&mut T` references in a synchronized
> +// manner, or `&T` access in an unsynchronized manner. The `Send` trait is sufficient for the first
> +// case, and `Sync` is sufficient for the second case.
> +unsafe impl<T: ?Sized + Send + Sync, U: ?Sized> Sync for LockedBy<T, U> {}
>  
>  impl<T, U> LockedBy<T, U> {
>      /// Constructs a new instance of [`LockedBy`].
> @@ -127,7 +128,7 @@ pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
>              panic!("mismatched owners");
>          }
>  
> -        // SAFETY: `owner` is evidence that the owner is locked.
> +        // SAFETY: `owner` is evidence that there are only shared references to the owner.
>          unsafe { &*self.data.get() }
>      }
>  
> 
> ---
> base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> change-id: 20240912-locked-by-sync-fix-07193df52f98
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

