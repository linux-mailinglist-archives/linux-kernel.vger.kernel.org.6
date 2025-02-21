Return-Path: <linux-kernel+bounces-526723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C657A4026A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3CE189DA10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751E254AEB;
	Fri, 21 Feb 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3JvzTu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6017CA17;
	Fri, 21 Feb 2025 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740175173; cv=none; b=MXxAwRU+55gZbuyG1yE21XXfZt6CizqvGPnUscS00g2ZgQmcSEH4qOxfPYIa9aOD/Mg80FeGkgCEPxdNSOQV6/X/ACWf5c+pao8byFMJQ3Pc2IjYT//IMFx4TFcuUpe0+5QFktPZh+GGHD9O6E0VwMVbOxPbYATrRRq621zReI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740175173; c=relaxed/simple;
	bh=wkNJXN5KmQia3qc0vnjRQKnCI197Q8XmFWs2pvWUs9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqbY8HCmrzLKIuqdJkVz0KTQ3WIuxNgqwAHk4Su9q1KdR74T20VL4cZLLt3TSgZYpC/O1dA3bCFkDpSOmMwNG2AvjUdzlm/GKMHE4r44oqyURASD4s0DrwNm+AdNpBhV0UyqATj9tXJPIJwMYBqNdgrbhyQuDYqm14CTtooW8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3JvzTu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B10EC4CED6;
	Fri, 21 Feb 2025 21:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740175173;
	bh=wkNJXN5KmQia3qc0vnjRQKnCI197Q8XmFWs2pvWUs9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3JvzTu4zJkPsn2esLlCE1CGA91SJ2u7qCHOGM7lRAhIeStRB1AN0NRWOA+EYfGKf
	 bJPC9nez6oZJ76okTk6TXXpx2d06B6NkbSzWUuREp70iTqfe1WfcRtrNJWctmz8oy+
	 4as1RFekBsFyOdL2JcaaQZZSibrOd2j5Pc8ikPmYz3qGNZb3QR5ZAvkL/obyaez1Eg
	 cYyZyaw3PNh13RpCD0PF/Nz9ywsqD0FBPqwXi0MOqYaadr+NDrLhvshBslEgO5B596
	 jgaePrm3nRrjseizd3WJ+XxwOExSd9FWP7vNxz198B35V6nKvg7iC8kibMWzLeICI5
	 yL+1Wn2yCUL6w==
Date: Fri, 21 Feb 2025 15:59:31 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
Message-ID: <20250221215931.GA134397-robh@kernel.org>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux>
 <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
 <Z7iSHR0F2QpiNpMZ@pollux>
 <aoprvojsnmkbzmmpgx5wxjqtamnr3jyhyqfcqnwhxulp34gn32@aau57u4cotpe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoprvojsnmkbzmmpgx5wxjqtamnr3jyhyqfcqnwhxulp34gn32@aau57u4cotpe>

On Fri, Feb 21, 2025 at 04:28:18PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Feb 21, 2025 at 03:47:57PM +0100, Danilo Krummrich wrote:
> > On Fri, Feb 21, 2025 at 11:29:21AM -0300, Daniel Almeida wrote:
> > > > On 21 Feb 2025, at 10:56, Danilo Krummrich <dakr@kernel.org> wrote:
> > > > On Fri, Feb 21, 2025 at 12:03:39PM +0530, Viresh Kumar wrote:
> > > >> +/// A simple implementation of `struct clk` from the C code.
> > > >> +#[repr(transparent)]
> > > >> +pub struct Clk(*mut bindings::clk);
> > > > 
> > > > I remember that Stephen explained that NULL is valid value for struct clk. As a
> > > > consequence, all functions implemented for `Clk` have to consider this.
> > > 
> > > I am a bit confused here. If NULL is valid, then why should we have to specifically
> > > consider that in the functions? No functions so far explicitly dereferences that value,
> > > they only pass it to the clk framework.
> > 
> > This was badly phrased, the current implementation does not need to consider it
> > indeed. What I meant is that we have to consider it potentially. Especially,
> > when adding new functionality later on. For instance, when accessing fields of
> > struct clk directly. 
> 
> Just a drive-by comment - the current implementation will never have
> a NULL clock anyways. That is only returned by the clk_get functions
> with the _optional() suffix. You are right now only using clk_get(),
> which will instead returns ERR_PTR(-ENOENT).

It would be nice to handle the optional case from the start. Otherwise, 
driver writers handle optional or not optional themselves. The not 
optional case is typically some form of error message duplicated in 
every driver.

Every foo_get() needs foo_get_optional(), so let's figure out the rust 
way to handle this once for everyone.

Rob

