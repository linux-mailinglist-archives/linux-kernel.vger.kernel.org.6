Return-Path: <linux-kernel+bounces-567880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92409A68B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2883174F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514B254AE8;
	Wed, 19 Mar 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4fAt4UR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669B253351;
	Wed, 19 Mar 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383377; cv=none; b=gXE3q2aMj4ata/wpVKTwPZCRBH6WmaCn06oWf8VV6ErIF4wQQuwj3nQ32SbmMlqGrxAnOa8VJLAajytQc3/bMST+qCi5siG5pLLV3jVG+YDo+fkutjhkqo4BMFQf/oltUpt5FRCzOT8b960p7sSMVphrCq+JsKrdinGLChdGuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383377; c=relaxed/simple;
	bh=7fB+Q1MU36xNwuP51zEOf7SZsy0PlEFZ0MMEK4uHCPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SILxSgbngBK5PGVxSiAyGeWEOVSxKzUzfv2URd+6V0vCbtR24scb95HJG83z8f47fhZTv69DWeA7pbuIyOCcmeo/3Z1ETkUTXJv7iI/lsPgUMuYKr1R6hvbQfB9PClnJaUUnFpIudiEPsfC5un4oq7N9P30KLRcsrEs9K+ea0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4fAt4UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509DDC4CEE9;
	Wed, 19 Mar 2025 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742383377;
	bh=7fB+Q1MU36xNwuP51zEOf7SZsy0PlEFZ0MMEK4uHCPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4fAt4URPZbgEeMRNwaTGWAHXUYCpZJ46KfDkR2D1zVKsUHtrn5+6lNCRuayWpg0s
	 F87Vd3Sdy9kcl4SH9SWcjv+OLIpdsm3F6yJPExzcCGLsVYzSuqdoX11ciNx3y8CEW7
	 ASd8Cm1Z9HxmIVDwRlatdJBNFXU/6+zFM1/xihcOqW/0iD/5hdPp07AEO8AUkh99hS
	 GULL4P0JelFyut1xJnuuqkapmYCRFu40PHFjr6CrO9f8/osmt/gus2w8v8U+U02vGT
	 sZAQvkxa9oPwgVAOKJdczt4LSPJ4G9ItyBeM7UsMxmENziRQfsEWR8IyP/ce4ToGMv
	 z0tDxqA+3Sh1w==
Date: Wed, 19 Mar 2025 12:22:51 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v7 3/3] rust: platform: allow ioremap of platform
 resources
Message-ID: <Z9qpC1EapJFNadME@pollux>
References: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com>
 <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com>
 <Z9mwu-RHwZ8qwcbH@cassiopeiae>
 <FF128DEF-28D6-4302-9C53-2DD4D417053A@collabora.com>
 <D8JTUPQ28758.2SKKTA6IL6Y8E@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8JTUPQ28758.2SKKTA6IL6Y8E@proton.me>

On Wed, Mar 19, 2025 at 12:48:00AM +0000, Benno Lossin wrote:
> On Tue Mar 18, 2025 at 7:22 PM CET, Daniel Almeida wrote:
> > On 18 Mar 2025, at 14:43, Danilo Krummrich <dakr@kernel.org> wrote:
> >> On Tue, Mar 18, 2025 at 02:20:43PM -0300, Daniel Almeida wrote:
> >>> +    ///     // Read and write a 32-bit value at `offset`. Calling `try_access()` on
> >>> +    ///     // the `Devres` makes sure that the resource is still valid.
> >>> +    ///     let data = iomem.try_access().ok_or(ENODEV)?.readl(offset);
> >>> +    ///
> >>> +    ///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
> >> 
> >> I'd probably write this as
> >> 
> >> || -> Result {
> >> let iomem = iomem.try_access().ok_or(ENODEV)?;
> >> 
> >> iomem.read32(offset);
> >> iomem.write32(data, offset);
> >> 
> >> Ok(())
> >> }()?;
> 
> Why use a closure here?

Calling try_access() only once and not having the closure is fine too.

But I also think it would be good practice for an example to explicitly limit
the scope of the corresponding guard.

Ideally, it uses [1], once available.

[1] https://lore.kernel.org/rust-for-linux/20250313-try_with-v1-1-adcae7ed98a9@nvidia.com/

