Return-Path: <linux-kernel+bounces-207726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9920C901B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0641CB233B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8EF17583;
	Mon, 10 Jun 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcMznEtb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536911717
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000230; cv=none; b=nEEpIxGIgXmZNuvbOxfFDoIPKIylekmSgNei8hJ4/75KEh/oJOx2zlAZOXwc03C9jMwFvz+YIWNx4ZgSHygnaib3JZUUvfb+0d4IPxDr0tzWqkMRAXLOMlufNGK4FV03BFLN3MH37FRQGlLcZu0Z/gV7U3rk5OPe7hfaXqTkcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000230; c=relaxed/simple;
	bh=s4tHLeN/JQ4Sw0Rb/SIllLLkTuy/lx7zwd13CxrMaQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDHlJ1e1GsTSeZQISOYfoIkIK99tIw/1iOkfGfL0iuhL31Rg0ZC4MkfB5vXPIQ7biQBbbxb7CpD8fIWZp6ALmszTiLeD6Vmm5bDrVaRZJ6hL+PUzVX8WD/fSWhFohTmz2zBd/3EB6UKLpBCXslC3RgQ1aW6czZuPRv3x6r0oUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcMznEtb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f480624d10so36482035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718000228; x=1718605028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRyYafF7FFhRREQMxHKJZeOnD/kuer3fST0Jc3qLYZI=;
        b=RcMznEtb/0TzHm5zHp6xvZFGoZ/tYS6n/AAvvHsZOWDPE1bn3649SwEPx5IhIskqBE
         Afgm7v/zm3Kvj0qvr4hE8swxxqHfkrkZ/LE8X6LHiue5vnwyOvtG0Xfo0NJongLPvny2
         kt2wYsvz9ZIHY77sYfdB9FKjgwWlPnsw5mQaML6KZBPW0LyI891uPVfCq3MJ00FlTyQM
         HSIvt4uZVCWQeKzKHQFXq7VOk0VmfMmUiGPwZD/8SL/jOS/yXA6xkUolcsLysxnOP+QI
         DNq8ykKv/+Wv1qfK0OD7sXLouPvmPTG6OqbnPkszD9S1qGgBXzbxqRDaKNnq9NV7xTpy
         t11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718000228; x=1718605028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRyYafF7FFhRREQMxHKJZeOnD/kuer3fST0Jc3qLYZI=;
        b=m8LtztOazoc30DRD92Mon9D9BH65doI9i0lAzPTW4qruIpQ1PvO+zSB0dbNO/TWEH3
         TdxtOK6/w93Rs56nmdB655oEG1j2yCc3ZrKcrskYmKAUnK0JEE0lAGQu+eYyk8vR92H7
         wdshjN8GBgTSPe8Sh7rMt6E0lBtnIpM2GSE/ee85ILSjy0DXEVWvE+g5++RptnbzGGq6
         4ygMM4X9LYTKwAqVlUDfjsZV5eJN++LEx2O6OrzVo1SIJnXkVFJ7lAKob4qjBmdbK3Si
         BQersZua+ZFty0NvPeE6IV65fsD7xBypMtmNLftqflSpymNuRMnL+Sbu/myu6dqCMISy
         hrug==
X-Forwarded-Encrypted: i=1; AJvYcCX5DH8HlQrUwg8Mqkoz/JQUbKW301Ze1MjCAoQsOgEcC7Tsbf0bKnMu1PuEHpIM7S5UNKmb4gSEQTVab+bjr9To2hwcsNNQVIU+5WKK
X-Gm-Message-State: AOJu0YwDq2Xx88xzty/UUHpZNk78qcsWX2u4r0DDZbq/3/aLxVYWyyBo
	9GgcBCuuYucHCd7g46cM4iOh2GNEK6pqCs5zJXmBMuCo/Ni7unTEgFJpETIvp00=
X-Google-Smtp-Source: AGHT+IF/Pq85SQr6hwAPu0rpG83JvHV+XjAapFFtvWDWqW3dZBCDsURQ/IR/ZmdNh8HUADlr6aGwag==
X-Received: by 2002:a17:902:da8b:b0:1f6:65d3:296 with SMTP id d9443c01a7336-1f6d02f7476mr105244315ad.29.1718000227759;
        Sun, 09 Jun 2024 23:17:07 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd760225sm75473875ad.15.2024.06.09.23.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:17:07 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:47:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6?= rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 2/8] rust: Extend OPP bindings for the OPP table
Message-ID: <20240610061705.rismfufmsmq44qt6@vireshk-i7>
References: <cover.1717750631.git.viresh.kumar@linaro.org>
 <dc156230814a899e5e3ffb6f3a0e5471d92506de.1717750631.git.viresh.kumar@linaro.org>
 <epir3.2kxc5jzd28c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <epir3.2kxc5jzd28c@linaro.org>

On 07-06-24, 13:38, Manos Pitsidianakis wrote:
> On Fri, 07 Jun 2024 12:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +/// OPP search types.
> > +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> > +pub enum SearchType {
> > +    /// Search for exact value.
> > +    Exact,
> > +    /// Search for highest value less than equal to value.
> > +    Floor,
> > +    /// Search for lowest value greater than equal to value.
> > +    Ceil,
> > +}
> 
> Seeing this enum made me think about memory layouts which are not stable in
> Rust and can change between compilations unless they have a specific `repr`.

Just to clarify, this enum is a Rust only entity. It doesn't have a C
counterpart..

> Not related to this series directly, has there been discussion about
> guaranteeing struct layouts in kernel APIs? It'd require a lot of things to
> happen to cause a problem (multiple users of an API in the kernel in
> separate compilation units maybe even compiled with different rustc
> versions).

I haven't followed the Rust discussions closely, hopefully someone
else can answer on this. But isn't repr(C) good enough to take care of
layout issues ? I must not be understanding it since you asked this :)

> > +    /// Find OPP table from device.
> > +    pub fn from_dev(dev: ARef<Device>) -> Result<Self> {
> > +        // SAFETY: The requirements are satisfied by the existence of `Device` and its safety
> > +        // requirements. Refcount of the OPP table is incremented as well.
> > +        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.as_raw()) })?;
> > +
> > +        Ok(Self {
> > +            ptr,
> > +            dev: dev.clone(),
> 
> Clone is not probably not needed here, right? the argument value will be
> dropped after this.

Hmm, I was expecting the build system to raise an error for such
things. Tried both rustfmtcheck and CLIPPY=1 and this isn't reported.
Anyway, fixed it now (along with few other that CLIPPY=1 reported).

> > +    /// Finds OPP based on level.
> > +    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<OPP>> {
> > +        let rdev = self.dev.as_raw();
> > +
> > +        let ptr = from_err_ptr(match stype {
> > +            // SAFETY: The requirements are satisfied by the existence of `Device` and its
> > +            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
> > +            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(rdev, level) },
> > +
> 
> Minor style comment, the empty lines between match patterns are unusual

Yeah, since there were a lot of comments and code, I added them to
make it more readable. rustfmt doesn't raise any issues with it, so I
guess I can keep them :)

Thanks Manos.

-- 
viresh

