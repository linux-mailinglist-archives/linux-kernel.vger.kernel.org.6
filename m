Return-Path: <linux-kernel+bounces-366463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0499F5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965371F2302C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D71F81BB;
	Tue, 15 Oct 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcbk1UAn"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAD1F81A4;
	Tue, 15 Oct 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017233; cv=none; b=UfZKnnrpriJXmTzpHDFlLCVLCNtnHUV6nB4HUdMaPQMzyUUpTA15srSJ68OCD9lC8bMmAlwrdhxbg5cpHmMKeeYxB/kig3f8uCS4ZRBl2jW/7ILufGsFXWsmGHtJnjHTx/z25F/Ip4muaUJoNj7de+o1GrYhqXkABDZkkG+z90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017233; c=relaxed/simple;
	bh=QLdn1pGiMX0eDct4lWvnXmyy1ifPJVhEbAjRezecoog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+0U9qUVU1vYrTTpDzdZEGtnMMqnJFrujfCaw1sy+qoDQjyDiq52bzVUCcMSTxGLKwYWcGzed+TmZPBWtv6I+9xJl2XCpV8SW6Nxo2xplDHAOnf9BlLTwm3nb4fGWph6tQANPqW/kbwIyRBYv31u+MEr/C2hvAChMZP5tL5igG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcbk1UAn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso21186556d6.1;
        Tue, 15 Oct 2024 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729017231; x=1729622031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwdSz4+8Ky45UzwFORY+UYW0E7DBFtoy97+eh38bxws=;
        b=hcbk1UAn9OK+IXAMHBN+PCGDC9tY1d8+YJsJSxhiRvFEJZtL+G4j/SnaztLeYk4p1t
         5ZgHocZujlh98DIeqoC7vXiEaU4goA7D7vyZGM8/UDRbty3Sp8A2sUnf8u9AIWdEUelS
         u+lUuClujr2OzLYgjGUGwwYLZN0uglzzHuprYkOe0s6watywmHTEQM7jiWB2j0+3McU+
         tM+3X2+5MdroDcHDFN0ZT0Y6jsgIf8l7mTyxVCIa/TpGpw6Fj7zj5t25+kuiAxPf0eOM
         /oQRw3Fp6cej8yC2iTGEmiZlCyRQ9+AXvtVXy4W9+LBh8QeK3aMrU9bn/oLSgbgU0Q3z
         aKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017231; x=1729622031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwdSz4+8Ky45UzwFORY+UYW0E7DBFtoy97+eh38bxws=;
        b=vDH3FHUxE7q5u5J3b66rf1ggVwGfwtYxRR4iI+tcif1+CAhkBi/SGZ4BvEsEYdWfA2
         ftVDawcc1LNx9jvt9iSAZc8eNOSRaRvxDFtn6hM2H7wherVlK4AUnpwwlR5i3U5VRNZU
         v/eMuvWSr09uMZSvYXFhfinWuuuM9ME/WQbVCb4y5oPCgwkxAShW1SgYURUbD8GML5qd
         2rTf7RgTPrsa9mtrEbsb+HVi9c8Rszf4j7ymfYfB5CswRopTxnPZ/dHR59hkjwwM86El
         qB/Hye6HjAjudnv/gNsbmjEM/e+i3CaVc3xXHG41CpIUbIK3Sw5JWkoEP0QDDROjQewS
         y/yA==
X-Forwarded-Encrypted: i=1; AJvYcCWORE5ByZNNKXsgB64IqeKVmV0F1LZnPla5mBhrXAAkADTLieLiM7J4GX00DJ5dImC2Nv0rjaB6js6bHzA=@vger.kernel.org, AJvYcCXphd1ojBfb2w+eo3mF3ZrcjkGRrt1ufwecvoHLg7iptdmbPGVLd9DYtlyKAvqT+NEylSJk/5e8g6aGjHeqxmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeyYLdxks4gcTy3SddQga9fYY7xdNv8OFmTBMUESTy/5hCOMj
	hPwJBCV8RxqbMoCEHs4CLGfcg2G6EulXovcptUM92Lp+ZH1cJVjK
X-Google-Smtp-Source: AGHT+IG47YfMpMWRfsK29ywOrKJ5I3JyLV5j7fESJj4JpLi+jJSQPwF7cEuVqLMekZBMWwKKEWVaZA==
X-Received: by 2002:ad4:4506:0:b0:6cc:2c7c:92e2 with SMTP id 6a1803df08f44-6cc2c7c9343mr4741956d6.18.1729017230808;
        Tue, 15 Oct 2024 11:33:50 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959a23sm9535806d6.94.2024.10.15.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:33:50 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E08C1200043;
	Tue, 15 Oct 2024 14:33:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 14:33:50 -0400
X-ME-Sender: <xms:jbUOZ_0pTuNf-yglbFQaW7x3QuC_tc_9ECbMm_Vex3QXwLEXeqwCFg>
    <xme:jbUOZ-FKM2UQVoxOiQjAWHQidrLnAnJQr47OOI8ZMfvmGdb9laSV9hrUSm1EDUs6F
    M6wZVP2fvb_PMhvtw>
X-ME-Received: <xmr:jbUOZ_5f6Uj9EXEtfnFNi7_u6edLEYkF9_BEPooguFzHY1kxVL6oCzPdGP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhho
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhope
    grrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jbUOZ01_p77o9hz84CLERyolspeHtnMogtPO9JzzLb0vt9QU9Jefgg>
    <xmx:jbUOZyEm8AY93ktQ8Ksf7QLW7fmtSbmXRWcIe37AM6t7ZvzHOlSNMg>
    <xmx:jbUOZ19-1Pv8FP6u8M8J0HcVM6yq2XaLanLRd18O1EdG_blQtbo2pA>
    <xmx:jbUOZ_m5NHeX7RudOLBf7eOI5fJBX-aEbp77pFx3hLVmhzjoJfoYCA>
    <xmx:jrUOZ-GxxYjD57a-86JGKj0mADqk12fH9B0gbNRV48uc8eKaOnSQOEGA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:33:49 -0400 (EDT)
Date: Tue, 15 Oct 2024 11:33:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: page: add Rust version of PAGE_ALIGN
Message-ID: <Zw61edSZrAb8pH1X@boqun-archlinux>
References: <20241015-page-align-v1-1-68fbd8b6d10c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-page-align-v1-1-68fbd8b6d10c@google.com>

On Tue, Oct 15, 2024 at 02:28:28PM +0000, Alice Ryhl wrote:
> This is a useful for helper for working with indices into buffers that
> consist of several pages. I forgot to include it when I added PAGE_SIZE
> and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
> abstraction for `struct page`").
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/page.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 208a006d587c..90846e3fe829 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -20,6 +20,11 @@
>  /// A bitmask that gives the page containing a given address.
>  pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
>  
> +/// Round up the given number to a multiple of `PAGE_SIZE`.
> +pub fn page_align(addr: usize) -> usize {

Make it a `const` function? For example, there is a VMBUS_RING_SIZE()
macro in C that calculates a const number for a vmbus ringbuffer size,
so it will be useful.

> +    (addr + (PAGE_SIZE - 1)) & PAGE_MASK

I guess overflows are unexpected, i.e. the users should not pass a
`addr` that `> usize::MAX - PAGE_SIZE + 1`?

Regards,
Boqun

> +}
> +
>  /// A pointer to a page that owns the page allocation.
>  ///
>  /// # Invariants
> 
> ---
> base-commit: 8d8f785ceb21b9a0de11e05b811cc52d6fa79318
> change-id: 20241015-page-align-7e5fa4c751be
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

