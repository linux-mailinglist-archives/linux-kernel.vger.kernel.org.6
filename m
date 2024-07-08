Return-Path: <linux-kernel+bounces-244221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E692A0F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3781F21C92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B65644E;
	Mon,  8 Jul 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPNIdJS6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DE7BAE3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437883; cv=none; b=SVIzFgP33NDIKLlwwtcQ36ytq40sq/q2QsF3womyWBZPBIKYA7pTUBr8/Uou/XgkNI/zK7LWJ2QbBh0VbKGkL6XpPMRKlrag1F0jOkv+Xy3RF7dtESkBb/ejXpl8w/Fz1MloFXghizU9Z9GKRQCfq9BOszL/S4AGU36o8t4rYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437883; c=relaxed/simple;
	bh=xTYdYQU1dKWsApIW/T3x4V9sQRMMo94fk5/3o9tWCig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AefOXyr+Zkh9CJUBxE+mPdEmDcc0l51qkpYAnHZJbtozNaD+5ddE1Sl0PrHfLFt5m4ouY/4eZEn3oBe54UGvJntaNkFtqFldw3FmNCt8fv8LpuHe6k+ScoJojDPFzVhU3MLAyLsD9xzBz/jcW4vVcP3U/uJr3gQQ89ANlPx+Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPNIdJS6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oD998hd8L73BF0lomUfy/e1mUZZ0TqEdQJsnDYHHly0=;
	b=KPNIdJS61m9yx8wjRfOllK4DUqqmqtpq0KOAdKGGkG5nfXS0o4BzpN5VuJ8AyZ9oEHvKro
	QjFSHUbj2DBdj969LlXJDqeF8q4TfBxhLg1XLhXW9JKk3pPHoOM7Ru3We+xr/pTTD0WtTj
	HRVroC2LpYGkFf7/Eenzyqvn1ZVx1Ng=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-pi5A12DENxea41DH-LfNTg-1; Mon, 08 Jul 2024 07:24:37 -0400
X-MC-Unique: pi5A12DENxea41DH-LfNTg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ea88005bfso2648228e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 04:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437876; x=1721042676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD998hd8L73BF0lomUfy/e1mUZZ0TqEdQJsnDYHHly0=;
        b=AekKSicx/hKuwEu9roTvOOJRDiZsXijb860wGOh5fkA6ubVON1A4k6GcTF8h6LTOOr
         UnKciA1pPG6WMLjoL+c5+VW1loGBd6lMzLH7QdwITis5xQfVyNXAifNMifm+J1etS9lv
         1L8qd048of8RpkDWiaCbR4J4vBLpmvTV9+CNrM+X7Q0k+xihXOHb95H77YEQt2mBv3QF
         SpGuz5ivQ5QCJOLC66baOJZ7ZSOeYo8GnlCsUtLoavNFNPNQuj/n/K0spX35L7jdCQu8
         XDsgFKNnM8hHKy1wXC6nWyxtaXBC61+1JafCD33MdYx8TYVOH75doedd0XPmErCA33F8
         s+Qg==
X-Gm-Message-State: AOJu0YzO7byTnX7bbKDJHyTMoePwneDAahz3PU28Sc9ZHNbG0RyGxR7l
	Hrs7DWitA9Rf/R6qnAL7XrJS2GGjW3fT/e+Ks3ipET+Ib4kBBorBuVu9zdnWpqQY0ITq+tnmlgp
	PuZt0Ry/U+2hQrDnPV1AsX75CVY/yGEQSq2uv6ftAIUEL6XiWACQR9tNsTQrIuw==
X-Received: by 2002:a19:4355:0:b0:52e:9b87:233c with SMTP id 2adb3069b0e04-52ea063ee82mr7486544e87.36.1720437876445;
        Mon, 08 Jul 2024 04:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFdnakvR9pu+5kvWDlp6fmVf2e9irGiK+WfFFlZ3YcSrSy8lWz1fBvfOFHg0op7WTodR+pyQ==
X-Received: by 2002:a19:4355:0:b0:52e:9b87:233c with SMTP id 2adb3069b0e04-52ea063ee82mr7486521e87.36.1720437876002;
        Mon, 08 Jul 2024 04:24:36 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a188edasm160811275e9.0.2024.07.08.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:24:35 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:24:32 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: firmware: fix invalid rustdoc link
Message-ID: <ZovMcChz-sfSxNRc@pollux>
References: <20240708090615.2267476-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708090615.2267476-1-andrewjballance@gmail.com>

+ Greg

On Mon, Jul 08, 2024 at 04:06:15AM -0500, Andrew Ballance wrote:
> rustdoc generates a link to a nonexistent file because of a extra quote

Please use the imperative like you did in the summary and write a full sentence,
e.g. "Remove an extra quote in the doc comment in order to prevent rustdoc from
generating a link to a non-existent file."

> 
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>

With that,

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> ---
>  rust/kernel/firmware.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 386c8fb44785..763d7cbefab5 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -2,7 +2,7 @@
>  
>  //! Firmware abstraction
>  //!
> -//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
>  
>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
>  use core::ptr::NonNull;
> -- 
> 2.45.2
> 


