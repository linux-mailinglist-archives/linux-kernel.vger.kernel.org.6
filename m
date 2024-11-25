Return-Path: <linux-kernel+bounces-421360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8809D8A21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6495E284C79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5A1B415B;
	Mon, 25 Nov 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQQXhKnn"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90325771;
	Mon, 25 Nov 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551625; cv=none; b=rD+JUkHKND2/dsoEWIXuP3ckj4xgYfO2s0Ciw5DTKHhsZEuihkZcieJ8/E3ApjKiU2gscMd8avZYcKHWuL+g7GB1KaKgfvGjO1vX94+rIpG1XJKtaxqqnMJiEQMUj/WJmRvBqC1BrcxY8rBtTyRGA2fiswYumxE+iqzT2uqHwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551625; c=relaxed/simple;
	bh=wiJO8EafWrL3t6qlIiyV2F5okSL6L2pFYmTGRurbNkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/e+jGioaxEuSiUzV7fYlGSTwg0VRXr1sz9rEDrFw1RbzACoBaLtsAtzketjIn9hR2CmTEVGMwntpdqXnFhzXORog0e17Z1dlZSOi0zxCKEkFIYbqrBE1MFJNLgEtW91Z41GQ4Trno8AlgD4FvY510WDv5ea9EWM7XxUwo2UuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQQXhKnn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d4184f2a39so33662846d6.3;
        Mon, 25 Nov 2024 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732551622; x=1733156422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kGAJxqXAxllg/W2VuJ5ECjZPkQ6tCWdsZghimeCyrgk=;
        b=cQQXhKnnvdCnzYrh3TtPYsVjeyWpelW19oiPdCVcCSbzf5Hdt3osXmWgdCMZ5IIfEs
         G70RerzfCOk4JGAbr4efjCmhc8G2MXz6Afkobb9N1c9kBxkPpH/iSGpixyZKx+cXNpRi
         xNsiLy1toPMgyJJQNJYCDrTpm9oiUF8CRGc9u2dqWjV3BJ0jxpk1nqyOCnIVHi6WcarO
         reye+Hzue1Ik9eyRHBKIDJD80wwZJVOpiPNeD5FbjGnB10ravcdR++1CjH/t+UcUKjjx
         hDIFmN774XzgiHIyOndZdBiM5VcwQ3n7L9gEkUnb9OETDh5MgvdUBsGtFMIJFTZzphDw
         5AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551622; x=1733156422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGAJxqXAxllg/W2VuJ5ECjZPkQ6tCWdsZghimeCyrgk=;
        b=cq3S2diEk/LJGUr4xiOLZNb3pTzfgv0msV6QnwfYQQDDEFU4apUGMt2CHR+ep3o3hQ
         bptqsIp6gyx1iH6OxvQ4wLRZDWdrLBCrvzTC8PX7z+N+Z42gSe2Bl++cRQMqBLS3Hw+u
         YhxwzMBVbxxNi++4XsmNdfd9oUfAXXNAyL6ejFRKep6G0l0f3i9taRsWjgNc/KrfWPNP
         JZc2A+Jagl3HbRpR9LBgkbLzszXbLard9UgMRiwPCUGDEyeSXASUVAcXFSrd/GGT6sPK
         +sR2wZk+wDLQxY1QCAu3mplwPFXK6OxtgBKrPUt3yPedJnm2V0ReBXLOYeMJtqvRqI47
         AB7g==
X-Forwarded-Encrypted: i=1; AJvYcCV6oZEyEAf9SdeSfgG6Hn8a7SgD1+9hcSjyaugYYvwdVxX5FuTnU5F+295PFAnK7jYT98+ICZ4FfPkzlP7M8PU=@vger.kernel.org, AJvYcCXODc9hKtx4/Nov8+eI0FLtQ+q4t4iQuJDwmowDNWVx7oCteIF1GAl2YmbXjpb6fub83TNloEFkSnpdDMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24B8QB3Jwz7w5Rul/mBbHVJKUJ9oiDuHjhssskjZD5ym9o8I9
	MImPuv+NIYMGTomqop5SnPH3OBZlHvEWmA2ugKNhEAVtlwsWXpW6
X-Gm-Gg: ASbGncsFhyiAdoPh4cOFItjNE9Oug8Fwlqwg2fCuOksmH9TQx3KW//B575Iw+MdWMUJ
	gT/4/fBmJmVKyMKeF1Q6O0sfNX1WAq7xqMVLKT6BhKa+rXLkVjnOBU2nmpimWGo1XNScUh1qWxk
	UtpekyhcE9m8An7gBDajljBxHEYcMlb29Ynbm4KLtRZIHjrzOKgM3EkuHxceSAsOUkWIPIWKMzg
	3hAw5NF3rXSfnkcFmVBvvL+QFnf7ji6W8bSL97QTn3DHU1CaEN7ZX4f3wAgigxxLZQFCS+PwNaY
	kPLZmeQjIKmZXjcRgaMKDmzJNcNJo02PQE+QspcE
X-Google-Smtp-Source: AGHT+IGPkw8t4N9gDzf9lwkJ1qKoELH7ZpcCc2tznTmePFzUIMnxy8viKSeF32UNYG2rISDhl961FA==
X-Received: by 2002:a05:6214:508e:b0:6d4:287d:b8d6 with SMTP id 6a1803df08f44-6d450e7c2dfmr232620986d6.18.1732551622507;
        Mon, 25 Nov 2024 08:20:22 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab6198sm44259746d6.68.2024.11.25.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:20:22 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 73B0B1200043;
	Mon, 25 Nov 2024 11:20:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 11:20:21 -0500
X-ME-Sender: <xms:xaNEZ8jgXg6EClOFb0EdNDQapx01hExRBG23E0qN6FB-Q4OLwnz60Q>
    <xme:xaNEZ1CBr0wBExBiBJNfQN8dAWhalqJDjuHivAJRywRyQ3MfcfhbTvvbeLRDhyDYd
    C2dcdYwHL81tYuUcw>
X-ME-Received: <xmr:xaNEZ0FHCOIR1D06brxo3ypPQ_QA28DNBMsYUlJDU0SkzKVZdUNmBnj48qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffg
    heegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguoh
    hnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhgrsegrshgrhhhilhhinhgr
    rdhnvghtpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprg
    drhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xaNEZ9QoWgDXfljotMT4iAiewSfrNSieGrP0EnlgO5FoIDwbFlECbQ>
    <xmx:xaNEZ5yexd6XKa05cooNYWM1L9-1cqCbFoqk6I4iVjbWgUSWlpoKzg>
    <xmx:xaNEZ75MW2dAI0LQ8f5LH0eitJbQxgJ2lsixwBzEIDGjsC35SOtYEg>
    <xmx:xaNEZ2zyl_4NzGbdw7vyeRju93LVm-ecnRhjqfTMPI8zPtLwioSiCQ>
    <xmx:xaNEZ9gMwBYCS9jL5CZJPQhQ9fhU6-GhOIK2una9n93U4Djii5DR6H9Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 11:20:20 -0500 (EST)
Date: Mon, 25 Nov 2024 08:20:13 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Janne Grunau <j@jannau.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
Message-ID: <Z0SjvVIALIkOE3nj@boqun-archlinux>
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
 <CANiq72=axLe_WvPohRRpAnmmPOHtwSK1W3e86n7FMF2mao8HUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=axLe_WvPohRRpAnmmPOHtwSK1W3e86n7FMF2mao8HUg@mail.gmail.com>

On Sat, Nov 23, 2024 at 06:39:23PM +0100, Miguel Ojeda wrote:
> On Sat, Nov 23, 2024 at 11:30 AM Asahi Lina <lina@asahilina.net> wrote:
> >
> > We were accidentally allocating a layout for the *square* of the object
> > size due to a variable shadowing mishap.
> 
> Good catch, thanks! (Square?)
> 

While we are at it, I think it'll be good to add some example/tests for
those functions of ArrayLayout, for example, the below will catch this:

I will open a good-first-issue.

Regards,
Boqun

------------------------>8
diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
index 7e0c2f46157b..bb3ce3b2218b 100644
--- a/rust/kernel/alloc/layout.rs
+++ b/rust/kernel/alloc/layout.rs
@@ -7,6 +7,7 @@
 use core::{alloc::Layout, marker::PhantomData};
 
 /// Error when constructing an [`ArrayLayout`].
+#[derive(Debug)]
 pub struct LayoutError;
 
 /// A layout for an array `[T; n]`.
@@ -43,6 +44,20 @@ pub const fn empty() -> Self {
     /// # Errors
     ///
     /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::alloc::layout::ArrayLayout;
+    ///
+    /// // No overflow.
+    /// let layout = ArrayLayout::<i32>::new(12);
+    /// assert_eq!(layout.expect("sizeof(i32) * 12 is 48, not overflow").len(), 12);
+    ///
+    /// // Overflow, should return `Err`.
+    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize);
+    /// assert!(layout.is_err());
+    /// ```
     pub const fn new(len: usize) -> Result<Self, LayoutError> {
         match len.checked_mul(core::mem::size_of::<T>()) {
             Some(len) if len <= ISIZE_MAX => {

