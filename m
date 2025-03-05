Return-Path: <linux-kernel+bounces-546715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF5A4FDF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18484189113D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C02241697;
	Wed,  5 Mar 2025 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3D8gQuH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E50133987
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175225; cv=none; b=mLHXPMzlqcFN/o3J92LeANzS/+ymqNWv1aLk386vpUFyzUFNfUZk/u9cKJDSouCRDq4hnMRr9jiUTuVRc8U0+u7hwVdRAc+C3IWmBR4AxeRjkJldzv2pqyR0Y44VSRgoX2148oCyCFSoQBcZrc/umd4tbPPZmp2xZy1gGhR7ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175225; c=relaxed/simple;
	bh=Cas4miGuWF4X8Ueh2mbf616IC1RvlTWV01oJSrhCH5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7onmrlUxs94jho1LJAdymYMsZzRQ+0VwLvBK4i4xXer0Vt5eQoVB8+ruUPMqUG1MqsUUfjWmNtufw4xCG4kgGfqKDSwD+07sALPjkha6awS2rXD6McSdSyBND5VKr1gxZ74GepCu7zmN2AHf+t2jnV4iUyLfXwKSqM0JjlQKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3D8gQuH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso1974205ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741175223; x=1741780023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pfu3+TZx6+D0Zyy6rK5mXbmSh6WzrBwSPP3UW1ZgMZU=;
        b=X3D8gQuHJmLr9c6WRRxjiCr4vy/8Sp0fhPQPXtoVpSFbrupVO+pBd9KdtWAtAyeruU
         1AHX8L+ugZ2RwcyI72vbKxOu201g0OzW+KfmEixYE2T50HB8ha6nRj6cQPDHxkyoHAC0
         77jxOcceL6cS2oZiwHMJjzevf0miI9BhuCrzDL3iRpui/md+nE7VOkoRAt9aCjQXSPVp
         EV3AXi626amAmQ7xY6Sg9ubzICJKeCPiMcdqmuZ2HJ0zBDlQ+mrhNycOe3X9eXXhumOo
         JWVubh72+Iw+doy3b//E9nfNby0LePSp39yfIp9J1PyG1766CUEmCNNGStYcXm+4V52x
         tg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741175223; x=1741780023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfu3+TZx6+D0Zyy6rK5mXbmSh6WzrBwSPP3UW1ZgMZU=;
        b=CbX07dEV43K5WS6ZzNvaxMQQUlV5kGrx392R1nXvjqIQCYxtxTC3L5vqytQum7uH5a
         dmA+zM7KyMRlomnkmBrEKpf3C8hKUKOKitMcDvb45HEadbyps7p9bDxC3VuHjlxUuHaL
         sq27Sk2aDb+JasExcFuJTLitKr73clQWQVSgkNLVHPbzwe7sKDc2c1HLNSqd+2ch4CKN
         jgxRKGRvFY14KtEV6YL0WaoGRUojh0DOx2NZt1lOJqeuflgpdr9ftIP6yB+vLT8/E52w
         4dyF4h3TNydVtwLU/o1/1IoS6uCzinw1GaionprzAQeybOVLHP2Bz94pzZF0rlfQ30Ly
         COog==
X-Forwarded-Encrypted: i=1; AJvYcCWXMWKpBTTOpoCSRJlZHgma2cuKgL3/KbfeU6Pa8MvULop3bLX4Ygi7/6rjC/tBgCc9nmoIseY1LkX/nV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLDlBRGyTvfsyLPOkvlVu4tz+VXKQMCWpjepz0QPk4fLxP3st
	gD7ihjfacTFxWhqUIlYYXEdmCbtqg6rWNkqRG3G51LHqKpyffedD2MMOcNHb1KY=
X-Gm-Gg: ASbGncun7C+9vWFyYERLLv3I4eChRNJfW21ZKoEnk1dnTyDOsz7HsWPy3uFr4E0zsA8
	PG3APu8L//sgmf8wNYvRXX3Njm4ANI08KOn1KF7YDm+lDWKGm4KQC7KNNjQencbYgZNIdtR6UAR
	dfwGQIypg8uRUv5hCs2dJ2/R7C5QqKzQliejEj1VUi81EmVBgqu6LjaEOKfnj66R/yHMI5irlfu
	yZ/n6mYFDPG4pzTFtnAfMKPJc8xFpH2AkEzHAsWW0Vxu4BgWKd8mEHwJ6nz3CRRvup28OOsTAwP
	KbpYrBG/38C8X9+S1isOyTbxXM4j95TlyrZ26Cu7tBLRDg==
X-Google-Smtp-Source: AGHT+IHS3XolbnTHiz90ZHqMPzwfVi03ruXNsyC83Cm7ljJr1IitVbI67JnaTA9B26A8OYNT3b6gWw==
X-Received: by 2002:a05:6a00:3d4c:b0:736:3ed1:e842 with SMTP id d2e1a72fcca58-73682cc4160mr4386797b3a.20.1741175222794;
        Wed, 05 Mar 2025 03:47:02 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm10805158b3a.60.2025.03.05.03.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:47:01 -0800 (PST)
Date: Wed, 5 Mar 2025 17:16:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
Message-ID: <20250305114659.k5pptszvmusblynm@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
 <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
 <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com>

On 04-03-25, 10:37, Miguel Ojeda wrote:
> On Tue, Mar 4, 2025 at 9:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +///     clk.disable_unprepare();
> 
> Looking at the example, a question that one may have is: should we
> have something like a scope guard or a closure-passing API for this,
> or does it not make sense in general?

Something like this (untested) ?

+/// Runs a cleanup function/closure when dropped.
+///
+/// The [`ClkGuard::dismiss`] function prevents the cleanup function from running.
+///
+pub type ClkGuard<'a> = ScopeGuard<&'a Clk, fn(&Clk)>;
+
 /// A reference-counted clock.
 ///
 /// This represents the Rust abstraction for the C [`struct clk`].
@@ -139,10 +146,12 @@ pub fn as_raw(&self) -> *mut bindings::clk {
     ///
     /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
     #[inline]
-    pub fn enable(&self) -> Result {
+    pub fn enable(&self) -> Result<ClkGuard<'_>> {
         // SAFETY: By the type invariants, it is safe to call clk APIs of the C code for a clock
         // pointer earlier returned by [`clk_get`].
-        to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+        to_result(unsafe { bindings::clk_enable(self.as_raw()) })?;
+
+        Ok(ClkGuard::new_with_data(self, Clk::disable))
     }
 
     /// Disable the clock.
@@ -163,10 +172,12 @@ pub fn disable(&self) {
     ///
     /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
     #[inline]
-    pub fn prepare(&self) -> Result {
+    pub fn prepare(&self) -> Result<ClkGuard<'_>> {
         // SAFETY: By the type invariants, it is safe to call clk APIs of the C code for a clock
         // pointer earlier returned by [`clk_get`].
-        to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+        to_result(unsafe { bindings::clk_prepare(self.as_raw()) })?;
+
+        Ok(ClkGuard::new_with_data(self, Clk::unprepare))
     }
 
     /// Unprepare the clock.
@@ -185,10 +196,12 @@ pub fn unprepare(&self) {
     ///
     /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
     #[inline]
-    pub fn prepare_enable(&self) -> Result {
+    pub fn prepare_enable(&self) -> Result<ClkGuard<'_>> {
         // SAFETY: By the type invariants, it is safe to call clk APIs of the C code for a clock
         // pointer earlier returned by [`clk_get`].
-        to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+        to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })?;
+
+        Ok(ClkGuard::new_with_data(self, Clk::disable_unprepare))
     }
 
> > +///     let expected_rate = Hertz::new(1_000_000_000);
> 
> On top of that, would any other kind of operation make sense? For
> instance, `.inverse()` to/from time or things like that -- we don't
> need to do any of this now, of course, but it may be worth taking a
> minute to investigate how we could improve the type now that we have
> it.

I am not sure if we should be implementing them right away, I agree
about from_hz/khz/mhz/ghz though. Let some users come for that and
then we can consider it ?

-- 
viresh

