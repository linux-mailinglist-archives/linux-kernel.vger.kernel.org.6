Return-Path: <linux-kernel+bounces-532583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E7AA44F87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D17A500B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536D212FAC;
	Tue, 25 Feb 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOMEJ8ii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472020F07F;
	Tue, 25 Feb 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521226; cv=none; b=dkmNxvhk7pzL7sJh8bIzpCvBcA5i8p/OaLjUQQAl3qFrKtQMvhay0LaPOCuHYyWUzOmJ9w8Axeb7RP0BFuA2LOmbq3mcUekufYf4j6kO2Us3jd1pFB06QlsSQo8/4xI5Fe08m6x/POgJkiSfDdWwa9L04TtO+487V4LasIE577g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521226; c=relaxed/simple;
	bh=JEmaqtdiToq9jxO6c3Wsow0UvDnRMn/21EJWWOqHliI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk3Ek5oETiY8bFDJcapp8mfA33LTyTdgTo9xYzw/apCy23o3JWAZhB6UGvRKwF+xr7/EIlGHikfbSXDXi5T9LQMZDAkLGYEqRh0BmUk6cGSm/KYO5SE2tkco44fh2t+o5GRimkNh9jyDrJDsipmCkNd5cYwO/xk0yRgM6r848/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOMEJ8ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DC4C4CEDD;
	Tue, 25 Feb 2025 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740521226;
	bh=JEmaqtdiToq9jxO6c3Wsow0UvDnRMn/21EJWWOqHliI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOMEJ8iib1/LVPNLDjkxXTztaMLLU2wIyoPdnbgkIPYZa7p9pIGOYHZeo6SWhB4vF
	 /dy7hhd6EZuLc65Ci9YEb61/ryM58oA2HpYur5BdSPoEFOizhhuORYz58j35tEY9kk
	 8ui7EGsc3+5Ajc4pR8psYIX/VfR2OEw1KaMunG+EFfiy755w4hnFyYZ3GY34U1DuZX
	 OoGN1Q1QlCdy6RhAOCm+2aB2Fz8v3W3FAjONkxqGvrXR1Fzv7I9it21mc467hB1Eph
	 VJc+TP3EXl8IDCHRQ/76xQWXOTHgwKnCtb9PK/vcfsmermY72IVKE8hcNXYXKCQi8J
	 Ej45mUhXbyrlw==
Date: Tue, 25 Feb 2025 23:07:00 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust/faux: Drop #[repr(transparent)] from
 faux::Registration
Message-ID: <Z74_BNjwDGriXD_C@pollux>
References: <20250225213112.872264-1-lyude@redhat.com>
 <20250225213112.872264-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225213112.872264-2-lyude@redhat.com>

On Tue, Feb 25, 2025 at 04:29:00PM -0500, Lyude Paul wrote:
> I think this change got missed during review, we don't need
>  #[repr(transparent)] since Registration just holds a single NonNull. This
> attribute had originally been added by me when I was still figuring out how
> the bindings should look like but got committed by mistake. So, just drop
> it.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Danilo Krummrich <dakr@kernel.org>

