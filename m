Return-Path: <linux-kernel+bounces-423810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601619DACF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208F8281C73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704C201039;
	Wed, 27 Nov 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koBL67DI"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F313D503;
	Wed, 27 Nov 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731783; cv=none; b=XeRXBUgez1dLtcOwLGJrymH/RUxh5n46Bafa23eRWfzqOf8EZYHZpgAz0FXJpZZBJsnKHOIKs8ohgmAdxDYknKyA4yB4yBohyzIQtHWN345T4OqS+9Z4E2R9wxMiFsJvjHreU0DEAIH/bT6VtaWnMZXvOVFgyIKywkrfpTGYqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731783; c=relaxed/simple;
	bh=4PDI0htTnxmFDm0mz2y/fW8w6DXOb4WGvwwHxWoQWlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxEC0qB8zUgDw3lrH5wCS1JG1U5X+L346hym5ohrOG+fr3brkujqOF+ZzmZMutkoaN17ShcLx/kDCfk0jZ6Dz7kCAIa7zfChl/wbQL9RlA2lmkJwIERl3ZkyfJLibAcFu1dUf+7KD7epC0lldbZ7E9Mue+6iGBSmQ57NtxiTeMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koBL67DI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d41176505fso693576d6.2;
        Wed, 27 Nov 2024 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732731781; x=1733336581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eISakJOcv+PV1YvMPgACMX4UmzwPjsf42/TbzCRDUtM=;
        b=koBL67DI3cOJ9QHPDeN9xMl45chW2DvHFKbojtckRzOfffgLUmL9cx9IsAnfR8rnyD
         jBqgmTg/pkKasOvckC/F+L9ObBJvV3RMClffhUOE7EDzxtYWEsMdUxv91TF45nr/heYK
         Jr4ewjVwU4VPBY81jltcdXedZYdIbeh1fZMisAEjGD1WwN8MOyHfz6yxpxINpPQ2h6mL
         gO0A5LpTvx1+vVd46WbTsOrAKtoZu8Tvp6FC+rMnzQG87s0p9H/hE6vR7nqRRyZT2tzw
         Zr4WnMGErK1jg67J+HmxX5WsnsbVnMjHVFkJg6L68zX/7oXxNFASEjdoL+YfMLayxysG
         iqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732731781; x=1733336581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eISakJOcv+PV1YvMPgACMX4UmzwPjsf42/TbzCRDUtM=;
        b=avxaihgrMzJ8whItKTRdB5/G/OLjMlS4cmLf/ZiyQKB4VIP6pWYU0mOKA6upuHvqUw
         b3EJZpaRakEqzBS4/0Q0W+ktAM5OA9HZZE1vuSmRme+P3FHmhAuKv8rl2ZDCGmuevb1a
         cDbZ9CE3K93V7xSrfYwxPS9/y3B6kXzIh0J8XpeaVVbORF7g4NDjzU8WFW2Ks9N9rI9t
         QNPLZIuYmG1kr8D2PLLLoDqikFbNOQD0JBJCpMxt56G06/5V71v6le1nSd9H9rf9nlDI
         +9GZRUrXB8YYddGTWIxCpMnnrADVz8fnq7k7S1aL8oqLnqpd6GMtA8XInhp7ZCG2a2C+
         hR+g==
X-Forwarded-Encrypted: i=1; AJvYcCXghaTHT2azi7QdEXPpXm06p632nd39JE6uxxrD63LNXANFuKj9aUViN+nu09mobo0Tr97frR9IcfavzbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4lUDhIDkAbhtxUIo78CQWMtlkV2iiyI4lRrP/5pBOb67cQHe
	Gshj2ABeH8aOY61xIJgAp4C6+MZV5HSk2LmEsTs3hcblcECxWCR3eqJeVw==
X-Gm-Gg: ASbGnctKvS8bJl6FvOa1EZCpdc/YoR/grGDShD5HYSYgY/jN0+XyfUJF0fCfvOI0mfs
	pH3AeJk4rm23srTe8w3PgLyjRCxjGHu+riQjvU296VL1qcSb43xGicX85vISiJqhpyAOvZbVMlc
	yXquxa300TlIxgArRD6SJFrRGeFQabNkXbOdemoag8vfbNplV2BfwJS+2OjdE3P6s91pY8XFZpr
	wjY5UWIlWTwH+oa0zYvchrwIIFu19Pikj8megBzFg3CaDulGWMiCkHXUSyqYiWSUmtCfH/ymXD3
	S4yckffMyPMnZ6NsGRJG/DFDQiSKaEgwC5b0a0nA
X-Google-Smtp-Source: AGHT+IGnAf5Bttrg7RcKKmyoDu7B4sERCYq1Ctr2aZWNzU3oQMidBCsqa3mdJ8QMK1GRWpx7Cpd2BA==
X-Received: by 2002:a05:6214:c68:b0:6d4:586:6291 with SMTP id 6a1803df08f44-6d864d467cemr67383756d6.25.1732731780848;
        Wed, 27 Nov 2024 10:23:00 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83b86sm68868616d6.19.2024.11.27.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:23:00 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id D72BE1200074;
	Wed, 27 Nov 2024 13:22:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 27 Nov 2024 13:22:59 -0500
X-ME-Sender: <xms:g2NHZ_ztAxQJVCz0Kwj-YtVTUpZp-XtSsxFYrVK1bhES5zLiQEDGTg>
    <xme:g2NHZ3TYwkE0YhKqHmakTi5CcIeY7vA77Cge6EOVo-8rjAj7o2Y8bJghsLC9uzIsb
    sr3pq6Oqcs9i8WOoQ>
X-ME-Received: <xmr:g2NHZ5W5vigVVbWopkBtVCX7AlPWvs6vB07eEZJvG6_W4-YaU5Q4ykOLtQkW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmh
    gvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g2NHZ5hOMERn-7TztsVBBwu-f7IfxOI0KnIhvWc8AcSzqQafqr1hCA>
    <xmx:g2NHZxDLke_lKihDKjPM12y5KNFzGm9r8_h1MIm6h3iD1QjIuLOHxA>
    <xmx:g2NHZyJyKpGZpwjSbkOtqXdVeccGnQMQQ2HeGLQZV15f2YpsqlJ26g>
    <xmx:g2NHZwC2khdBNb52eQzo9cKgdTKbMJ6snZnchmvIDUmtmPp9vU6S-Q>
    <xmx:g2NHZ9xKrKkDV9z1clz_N8-UVf5DtOvtcAoXGHCvJYiPa6SBIYJpzn6M>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 13:22:59 -0500 (EST)
Date: Wed, 27 Nov 2024 10:22:58 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH 0/2] rust: sync: Add Guard related type-aliases
Message-ID: <Z0djggljFnGqRS9D@tardis.local>
References: <20241120222742.2490495-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120222742.2490495-1-lyude@redhat.com>

On Wed, Nov 20, 2024 at 05:26:27PM -0500, Lyude Paul wrote:
> This is something I originally meant to do when adding Lock::from_raw
> and exposing Guard::new - introduce type aliases for the various types
> of Guard that we can run into.
> 
> Lyude Paul (2):
>   rust: sync: Add MutexGuard type alias
>   rust: sync: Add SpinLockGuard type alias
> 

Queued for future tests and reviews, thanks!

Regards,
Boqun

>  rust/kernel/sync.rs               | 4 ++--
>  rust/kernel/sync/lock/mutex.rs    | 8 ++++++++
>  rust/kernel/sync/lock/spinlock.rs | 8 ++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> 
> base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
> prerequisite-patch-id: 8c65a39abe47832d0c98c9c266b4b9348fb3526a
> prerequisite-patch-id: 211faf8533feec77907b0a1b9b2f788e72c5ac58
> -- 
> 2.47.0
> 

