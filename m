Return-Path: <linux-kernel+bounces-220062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EA90DC36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A711F231AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF315EFB0;
	Tue, 18 Jun 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP0SvLK2"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020A1BF50;
	Tue, 18 Jun 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737896; cv=none; b=mA9ZfCAzz9ga+QY5CqlF8/aQbp15zM3+GZ2T1JN/9JdO816uBxzgeVMo+l9RkN59ol/6T0fKACjKIKCY3HykNj7SMRZAjeGdwGHlWkWCWepOKN2I7D/soveQq/VP+wZWBeVLDhG8u8K0fLKTVFaJk4ULH9ivF3qsiNtqvQ9J7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737896; c=relaxed/simple;
	bh=QkcZdI1SzK/GYifPDzyo4MXKlDf4yGGhyffzTmjSls0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6nGxW72kGthFyTtpudpnA/uDcla+d0TwOS5XLHmUMdNuUxA+tU/U52M1ivEM9ZoEFGFvSEECW0dSxCDHnNuYaEQOJsWLmsWzQCPBSlqd94p98BlmZiadjUHghSPBr+e9zvZpd0lYhFht3lDyBJzSdpNHoLAKgCgQ5VzzK77KjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP0SvLK2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b060f0f48aso26772156d6.1;
        Tue, 18 Jun 2024 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718737893; x=1719342693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjgSAIcGlBvcQWlcdFKimsWuEgiOFseD5bqrSyiqGzI=;
        b=UP0SvLK2V7vUqfSmcIC9wdDKBUll79QfWxW/OiPey9tZ6LUnl5slkqS3Ly7mbHByRf
         38FX4ewub/4jF1W2sEHBo8vBweWC0i/0Dk18wF6hd9IOro34950BuchgXr20a4f/HMPa
         UXRgzgK+nIqf780QYEWpiz9H7b6fY7zlRyDs8/xu9kyaCjU2nd+07CY5hj4biqZYNOtp
         5SqDwlP3sh4kKUy/1/cwgbatxS7kdy2L9ZNwm6rN8GsU99UBrFVmOd50qtejgov1j29a
         BesPd4et5gzxcgRO4xyMc08y9QD9iED54x2QXnu+O21Mu6yICYSQh6/T/bKIkzXVTXNv
         4smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737893; x=1719342693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjgSAIcGlBvcQWlcdFKimsWuEgiOFseD5bqrSyiqGzI=;
        b=l4PQBq3oFE9MEGP15EVMRYS1ZVEI5Sc1JGUDjekCmsgQuxRzGCb+Prp97EBC+wBpHV
         jxbQt4h0GS2GftQ225zIsZpYUuwkyEz3gt4oYMBykoovqdXko7Isb/9qjO7W1tai0SbH
         FUzG6Kz+mABJQoXROhCUkuADn2lR7h3n43OKkod9pNYXXhMP0AsdjzKC8kHRKeWxut3i
         Ao5Ha3Y2SACTRIKQ3zBFYZDy2PZx2U69NrgrWoprmCuHClI4Icdc2SYPop59W/EzjFKn
         6gnf2f/FWapd6La22cFLJ9uKD36A7mSLxGgdC1CnGmtgmlezvbFUCa+zuSh2ioYZez9y
         rj7g==
X-Forwarded-Encrypted: i=1; AJvYcCWvuLNbaV/YvYKnsWlMMcOYNYkHqq2n+WDTlvJC96wZM/vb5kzh9upB0EhgIcLGI6c+lq0TaNTGsZaeYWZwYvfNsDMSCbs+L+3CMCrjbvI3aN4DacyEIEhVU/ibV8NLb41dKJSrDhROJeO+hXE=
X-Gm-Message-State: AOJu0Yybu295IjFng26zT9UdwZr88/cJ1IBWs3GyiMB10G9fmf3gVEla
	/vtHm3bS/wn36S1AwIN5cwFdebL1Pbn5FOTT8UFdbAskhAKT8Zmk
X-Google-Smtp-Source: AGHT+IEP1SvUBgbecfLuQ12FLLwDmBC06TibPURy4ePUKsu2A0PH5rgyMjidMV8w8XcnsQFLMvR/TQ==
X-Received: by 2002:a0c:ca0e:0:b0:6b0:7997:ee3b with SMTP id 6a1803df08f44-6b501e47ee4mr7097336d6.35.1718737893421;
        Tue, 18 Jun 2024 12:11:33 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c466ccsm69670486d6.71.2024.06.18.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:11:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E0DCA120006C;
	Tue, 18 Jun 2024 15:11:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 Jun 2024 15:11:31 -0400
X-ME-Sender: <xms:49txZtMKwuEAjSl28-g4jrOYzR08I7Og_0vlseQDRMubpF0OpzPvzg>
    <xme:49txZv9J0rEw-GfB7jyhMsZOCrQfCs6tgx-vBHNCoE3ijGiXvjgsARB7Zdrih9R1e
    tT-3hDfmEZDoljrdQ>
X-ME-Received: <xmr:49txZsTzePWd5a69Mw3W5zwRGJi83BUm6iBvUuG6sqzPgV28ekIVztb2FFvEHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:49txZptOFSWVxP9lRUADtEneVZO23NfpcIpvfKe-cIjOsHj_ZSidpw>
    <xmx:49txZld-2QspmPgi25nr6-yLfv5tpqzPP7fqDQu9ZJ8Y1nVBHSiiuQ>
    <xmx:49txZl2RN96aaDv2NgWAN2bwljcQfUv_amPNtFmm6m7V6aT99K1AKw>
    <xmx:49txZh8EnKTXwvU9poVMwphBI8hrl-Ks-kBzUk9qA7Aqbg7ZhFbIIQ>
    <xmx:49txZg9oZvk9WTofymcXIkNZGgk7DRGkvjjZFXNxuum8l1DdAmFsnO6n>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 15:11:31 -0400 (EDT)
Date: Tue, 18 Jun 2024 12:11:15 -0700
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
Message-ID: <ZnHb05xshC0ZrGIi@boqun-archlinux>
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
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor<'_, K, V>>
> +    where
> +        K: Ord,
> +    {
> +        let mut node = self.root.rb_node;
> +        let mut best_match: Option<NonNull<Node<K, V>>> = None;
> +        while !node.is_null() {
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
> +            // point to the links field of `Node<K, V>` objects.
> +            let this = unsafe { container_of!(node, Node<K, V>, links) }.cast_mut();
> +            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
> +            let this_key = unsafe { &(*this).key };
> +            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
> +            let left_child = unsafe { (*node).rb_left };
> +            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
> +            let right_child = unsafe { (*node).rb_right };
> +            if key == this_key {
> +                // INVARIANT:
> +                // - `node` is a valid node in the [`RBTree`] pointed to by `self`.
> +                // - Due to the type signature of this function, the returned [`RBTreeCursor`]
> +                //   borrows mutably from `self`.
> +                return Some(RBTreeCursor {
> +                    tree: self,
> +                    current: node,
> +                });
> +            } else {
> +                node = if key > this_key {
> +                    right_child
> +                } else {
> +                    let is_better_match = match best_match {
> +                        None => true,
> +                        Some(best) => {
> +                            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
> +                            let best_key = unsafe { &(*best.as_ptr()).key };
> +                            best_key > this_key
> +                        }
> +                    };
> +                    if is_better_match {
> +                        best_match = NonNull::new(this);
> +                    }
> +                    left_child
> +                }
> +            };

These two lines above should really be:

+                };
+            }

, right? Any lint we can use to catch this?

Regards,
Boqun

> +        }
[...]

