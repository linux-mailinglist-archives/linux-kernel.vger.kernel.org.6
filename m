Return-Path: <linux-kernel+bounces-423811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED99DACFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C20B21D90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7520101A;
	Wed, 27 Nov 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj6WTMT5"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53638DC8;
	Wed, 27 Nov 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731829; cv=none; b=BuMw43xsiCY5zhRJtuLUVOv9KKeejEcS0uH6CC0E1wraCxnBMRjPqBoMNwuGbeONHNWeLkAuHL8mNjYiDCbZYDaDbsiKZn6xwwOnNy9cLMlbVyMCo1mTUf4vO1pb7SyXpoIIKyDQR+ezSbr7uO61YY/0evj4wQnJ5xsm0rAONgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731829; c=relaxed/simple;
	bh=kwLzy/1QA5jeObp8/TyC7hkXyhfeqsy2mMuYb1rzcA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLE+o1M79VdxMC4GujzsE9TzqcF7B/WyVQYRhXExOX5geHna5yNKFGm3J1/Yb+XBcWFRExnU6TXpOa0V+JzwhFVJX1TG8YOmA7WP/JmC6Lz3FPDjwFFVeWs73B2IAZ82PWkVQ/37c/5hv7lOdy7M2HZP+AqbGhf95fL7cCS+KSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj6WTMT5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d42b87aceaso10820826d6.0;
        Wed, 27 Nov 2024 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732731827; x=1733336627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi1grvlnoKRmNDylmQ4ifR2JBVGeTJZYQ1EP7iQjYr8=;
        b=hj6WTMT5X0PUHmkJrwjNjnWcwsVyGrfpOWf2ftGVJRuu5GOLmUv7NSp/65ya8m8+Zi
         ki3nN+Pz3/zT345dXBkYYadyb0+E/InnaQ+IsubOayp9ywXTFwNnjIcbi9Q1Ynr9ixil
         oUBDHwiY+YBRet7pKpe9/jLET5FJTuBN3WzcO42vKJYT97VAUslHt++DU1Ged6yNDWMv
         sJnvjvCwwQj06HP+3AzJFQ1s65vZG2wwpIlNAD+922R9uYRY90ASutS6Ygww1ZnhtLFG
         TCpW0nxrHMxPsS+fJV58zCs6aEnEJyWyOxRSHX3p4dBfV7UbMo5jKynpAjra/9eFjhu/
         zrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732731827; x=1733336627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi1grvlnoKRmNDylmQ4ifR2JBVGeTJZYQ1EP7iQjYr8=;
        b=vHXIISl7nHygmvLGgSmgpq4ibIwLWulU3Ws5m3dejFfksixqVOy0Rwg+bcIXDtyeOA
         N73KbtHP9r/uZoHfDHrxLOVfnLT+7xQU7XqS0aHHEKR0MDi2BQTAg+ki1KjmZmrMS+Lk
         708GoBH+jFDYdPVdQJA390uEF68q1liSnNeoHZ2rBiDH6bhi82CbO13J74LSzPURSjj+
         EwIlesBgjtUbGkQqoF97mRe7/T9BEapd51FGQaWOgDsUAm9r+3/W/ktXV4FlwBH3pkNc
         TtRQaB2Btt9Sk7TyDhdsShbZmwbM2CxaA/9ITeftMxKy6G5vA9bQzL5DPVgC8PCmYixg
         l/2w==
X-Forwarded-Encrypted: i=1; AJvYcCV4tBCOzy4asD97mo3n7J6N1rh1dDgGcqxsbwQe0J594J6Cq11D7M7ASqXbs5OmUz3+01wc0VsVaIhf7MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoPXxcui7Z0MgrGl4Vm/NFMS3v+FT2aBxZ4r6B/uOFORhgI68
	Sy2Ep38zyqf6ehUoauw+RdDnd+geV42DN0oPYiv25QULaHtCkhoa
X-Gm-Gg: ASbGncsASl1SpXVotRFlbgKpMX2hm0gpFqGRV6sNFT4/h6Tf5ZDpuJclhU+cBuGNBhV
	ZY1JwqQH+1SaABIyTq+VBRNtu6VgAIBfqchghEfh9V4J80JMMGbXC+B73ZdjiQIc4o2yb9WsGi+
	MNRFtNP9qik20NmuSVdgY8zysQ/Fh4pjKG1UQcmIDtApoMvk6TaJ7PnvGXI7sv2/pfoUOb6G3kJ
	No4joTA9Tvl/J+/JUnFlXhjo1GB/blG2ORfT4Sdahp06D8ywDcga8GYziSHXTx2x26rFIiYmul2
	TyUuf2c0Ngl8gpIfeJXgeT29yIh/R0Vc9IQsb7TA
X-Google-Smtp-Source: AGHT+IEJsy3vkTjRbP6+v+NDuxlib60kx4G8TBCMBmUnfwfI36yqBxOdIvOVQdUUCQv5RYy001PbZg==
X-Received: by 2002:ad4:5aac:0:b0:6cb:6468:7eb9 with SMTP id 6a1803df08f44-6d8729e9e77mr5254776d6.21.1732731827153;
        Wed, 27 Nov 2024 10:23:47 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b6895asm66852826d6.130.2024.11.27.10.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:23:46 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6C56B1200074;
	Wed, 27 Nov 2024 13:23:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 27 Nov 2024 13:23:46 -0500
X-ME-Sender: <xms:smNHZwyQjpC6wvvd9Hna4JKA_YSK8XQ0_yLnYknx6s_HyHKaK0S8zQ>
    <xme:smNHZ0Q5JB2nFuPcLJex0uDydMnPrXdNUkSA0vE125UAYlKCMfgENcEiVE6FMsfjx
    cylsZzM3B3TSu-Jmw>
X-ME-Received: <xmr:smNHZyXS760Nv5b4fGyEL6O6JWe0nxIck_7qE1DgsiZ8Cg6BKbCEWcWdizW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgddutdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:smNHZ-gj6ZouMl3w9cVMLpex6ui5d4D-sKmQTHCVWrZHwgWRpSGmyw>
    <xmx:smNHZyB-qvG0satoEx_mq3NhECEO_T86mvyu72BFht2ceqnaRfuT9g>
    <xmx:smNHZ_IPT5mFUBs60vk2_ftRqdafhO7Pi8X1v1B33LtNhhsKXJFYZQ>
    <xmx:smNHZ5DHslCmLhIRTWV88u7avi2zI6ZBh6LZOrjHhU6ISpimczgRtw>
    <xmx:smNHZywl29x2SfJEwpktxbBf68T0D0E2mkvY8jfmX-nIT-hFRnma8sKJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 13:23:45 -0500 (EST)
Date: Wed, 27 Nov 2024 10:23:44 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v4 0/2] rust: Add Lock::from_raw() and expose Guard::new()
Message-ID: <Z0djsId9-YAjbNVd@tardis.local>
References: <20241119231146.2298971-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119231146.2298971-1-lyude@redhat.com>

On Tue, Nov 19, 2024 at 06:11:02PM -0500, Lyude Paul wrote:
> This is the third version of a small patch series to introduce
> interfaces for working with locks that we've acquired from raw C
> pointers, something that is quite useful for bindings like the rust
> bindings - where there's a number of interfaces protected by BFLs, or
> which require the implementation of callbacks that are known to occur
> under lock.
> 

Queued for future tests and reviews, thanks!

Regards,
Boqun

> Lyude Paul (2):
>   rust: sync: Add Lock::from_raw() for Lock<(), B>
>   rust: sync: Make Guard::new() public
> 
>  rust/kernel/sync/lock.rs | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> 
> base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
> -- 
> 2.47.0
> 

