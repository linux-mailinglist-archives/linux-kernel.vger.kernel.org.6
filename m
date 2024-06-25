Return-Path: <linux-kernel+bounces-229605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F0917141
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F3C2876C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6817CA14;
	Tue, 25 Jun 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQirVh3h"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0771750;
	Tue, 25 Jun 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345045; cv=none; b=SlXyf1N+mAP/+3MVIz6rgRCydk5382G2IpEcgbmX7NIR6bzd5Kh5i9XvUqRpjvwIZMiBACVLK0yEZqbXRT0M7SD3vUCb4BDWKYES/7n5SEbiRsQfxsSYgJzn9rvb5wRJ+Ya7zxBdZTsNmajJ30IdrsVVgEGZbQMYoMxtQgc47PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345045; c=relaxed/simple;
	bh=5qaZBAkSL3htea4GvYsaZHEsqCQw8CFx+a9ZsUMYLtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJc+cUxpLVE9uSlMofrfXf5hx/QShN+7+R/9A0SZSHrw48UTFJRXOxRHHmxIQSsRInxTFg1G4Ypjt3rAFLY3i79HLOVZhPz5o23Rjy+q8hh8pWMLiRQSgGar9njvkMTkLsl3eH7MrGEj2UG4PMP9qtIOJdt/a9HQWgYSf9N0llY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQirVh3h; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79c0e7ec66dso60839685a.1;
        Tue, 25 Jun 2024 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719345043; x=1719949843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyBKhLBfSgwfcLqDDYC6LWcs0BGTCyPmis5F6gsF3wE=;
        b=NQirVh3hiBWIwxSg8M7oiaEvD8cF7C2vfKvh0GS2M2H1FJ6vidvVSGOFTjjilNCdu3
         aBFnPnnCMMc/9AhlmJsJhs/kKE6E/W/G2y3C4jUBQarQfBS25gey8nREs+TxfuMejUVT
         Jjc+DCCf1LRsRHCIpOi8yJp/KCI2iNHuNkyGsZTevaMe05cBg5o74KL3Djfue2ZzAZUs
         rLwLDxMrsgGXA0FfUpTB69Pii9zJ+RiSKVkamayDFalcIDy3gm7BGpZ/DjQqqFEetw+Q
         tse5L7kugjIGKIECBsotbjcAiBZfeUXsbQug0tTeN/wialED55M2m4NRIjvFc5cyggap
         4w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345043; x=1719949843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyBKhLBfSgwfcLqDDYC6LWcs0BGTCyPmis5F6gsF3wE=;
        b=TZNNVwIe5ut+pk3i7bFOsNyIDqpbov2WYQKCtLwP6jseeKNJ30IDyQW37XNwFSjeq2
         0PxVoJyh+oju2SyT73QcpqBAMfjn28QT0IoR4MlBKnFwYlrRUh/ECb7dzjNX7RSEv/ni
         iCKH143O+HpnauD2HDEqJfuft2FkoFeIWZL5U5s0isoBv0hlp0+r3wRztztTA5Fc1fhj
         Kb9KGq9mC+GLLcq4XWsQEvh5gd/TR0iZJxvRGrcu0iQN6HbfxrRISVZBU5G+PE8f7ici
         7W0Yk+nkvbM0QZLW4xeyeLUStLl2OeeWoom9oEJqgFWA75JnDfLc+9ZUIRmJD3RspnGI
         BIMw==
X-Forwarded-Encrypted: i=1; AJvYcCUfVM9B7b1kG9MpoyZMu96EC9Nujc/xtwCvb1uLqSeHApN4mFvT5KXn6WjfVWkel6+Jbt6UW4dYLr0r0IwIM27bmsblquGGONPlqbixS7yYO8idsOfDIGkLeq6kfjFE5iqbnYx7jbPqxA+3Ics=
X-Gm-Message-State: AOJu0YzLcY1l10RvAjBj5PdZpu1Kh1p/csM/bZP3M2KU7zRngSPHQY0p
	T5qxk7nHOIuaUyOy3PQr/ylygTXUTJml+xEv3/OtMppOOSYmQGld
X-Google-Smtp-Source: AGHT+IFshickO8pFKsc280+bfYieTeHUvWakKNVfcLCERSnKS+7f80j9ltMrAaF2fdRzq0RpDKw+SQ==
X-Received: by 2002:a05:620a:170c:b0:795:4c20:5f9e with SMTP id af79cd13be357-79be47a4291mr876293485a.53.1719345043231;
        Tue, 25 Jun 2024 12:50:43 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c0ab69643sm64767285a.114.2024.06.25.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:50:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C512A1200068;
	Tue, 25 Jun 2024 15:50:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Jun 2024 15:50:41 -0400
X-ME-Sender: <xms:kR97ZmMutlVyrnvbhfEr4Thn3UKaRBdVkU73VF96aHnObTgVRhPgJg>
    <xme:kR97Zk_OeBGYWkvjY_P_kJioS_-Aaw6yzDiKluDOVQ0jtOkMYkX8q3JE4Z2zLI7Di
    OFUflL0QyAVPh1WGQ>
X-ME-Received: <xmr:kR97ZtQp_6MC4iMXex0X02rhhgaNoYxoX84P9eKRxK_pWytF-U8jvd4YteuKjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:kR97ZmuzjL_3nXQI7VWwesijZkdCRibUSn_16SCa8eG3cjYs9u0LzQ>
    <xmx:kR97ZudKAmUP5PJkCH5QTwGG5n0ivJ25kJWXeGokdTZcqASSEEvJDw>
    <xmx:kR97Zq0KIPHWeyGRxANcymuyk3XZjNbuDCxz5NdR3B1Bqv4DlgKxbQ>
    <xmx:kR97Zi-LVcRa2KNvGSFwPGP8zEUsXIBF1TtGK6pErf9lQ8hz8B369Q>
    <xmx:kR97Zt9JfY1vqiRmjEUGIFOc4Ytws7Lws6FLw0iXlSAazdTxXWYIpjdp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 15:50:41 -0400 (EDT)
Date: Tue, 25 Jun 2024 12:50:04 -0700
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
Message-ID: <ZnsfbNNYCOm_4jeJ@boqun-archlinux>
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
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration of 'a.
> +    unsafe fn to_key_value(node: *mut bindings::rb_node) -> (&'a K, &'a V) {

I think the function sigurature should be:

    unsafe fn to_key_value<'b>(node: *mut bindings::rb_node) -> (&'b K, &'b V)

right? At least it's more clear to me. Ditto for the other two functions
below.

> +        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
> +        let (k, v) = unsafe { Self::to_key_value_raw(node) };
> +        // SAFETY: the caller guarantees immutable access to `node`.
> +        (k, unsafe { &*v })
> +    }
> +
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has mutable access to `node` for the duration of 'a.
> +    unsafe fn to_key_value_mut(node: *mut bindings::rb_node) -> (&'a K, &'a mut V) {
> +        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
> +        let (k, v) = unsafe { Self::to_key_value_raw(node) };
> +        // SAFETY: the caller guarantees mutable access to `node`.
> +        (k, unsafe { &mut *v })
> +    }
> +
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to the key for the duration of 'a.
> +    unsafe fn to_key_value_raw(node: *mut bindings::rb_node) -> (&'a K, *mut V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this = unsafe { container_of!(node, Node<K, V>, links) }.cast_mut();
> +        // SAFETY: The passed `node` is the current node or a non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k = unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null neighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v = unsafe { addr_of_mut!((*this).value) };
> +        (k, v)
> +    }
[...]

