Return-Path: <linux-kernel+bounces-526947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87464A4057C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71E219C0C73
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5EB1FFC5C;
	Sat, 22 Feb 2025 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1JvcrCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3EF4FA;
	Sat, 22 Feb 2025 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740199032; cv=none; b=ZaewnMS8XN7PARLgk5AlNMeGecuu5YS9qF52nX8az1KNEnvW5nM8FoMVfkfG4hOPM7F3yAe5MAITDX0oFnKnhq1ZSG4SzeXf86wvHeAbQj1au3PFsFjTzNGBizf87sLUwFuIQOTvyBySctKxFXyn8aJeYFRU7EfP9JVqmaEFESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740199032; c=relaxed/simple;
	bh=6eq/g2PeyxDykwM+pXNkLQVHqJBcSYgmgzkucXSwI/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcD4FfZMvC5XZCV1gpfJAuSspwXIL/bqYU3f7P/1FxyhTengD1idkqPh6PZ0kOkkjIpqx3TETIKP9t8Y5vZUOpwvmN+v1fGPZVa8CTP7hUD+28OTI0QVFq3i401OiVJbou1fUwnJjyrGJZEsw3atnTx6Jl1YpwYP3YMDvqFq+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1JvcrCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5EAC4CED1;
	Sat, 22 Feb 2025 04:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740199032;
	bh=6eq/g2PeyxDykwM+pXNkLQVHqJBcSYgmgzkucXSwI/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1JvcrCMzhduMegcbMfStWlWM7YTbzUWKvqwstztcIHlIs6LLuXDgX/MB/AE9KF6m
	 pn4oOLlkChQ3oBelN0pIyblgVVOSASQw4SYgV78fCheNowlYrUx12WbTxkerZ/azvI
	 p+LNta7yOVGVAuf6rgQVa2Qvtp9ncBL1MBfFqOc/v1TM5mD7PsIECcEg0xuunDaYmQ
	 tih+3IZoHGQ6EzyaUDeEwUnh8MdUdshSCwH28K6LdHXg3AZSrmn99OWNEYdYuLaIlV
	 huAIHnzOvFrAWcdzeYvi/8lSlPl+QNjzU7ssiTHd4ek7GcMBn+xW2bGwTfc4H2Wm5I
	 OLhulvtX4R8qg==
Date: Sat, 22 Feb 2025 06:37:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
Message-ID: <Z7lUcq3PycSSHiXx@kernel.org>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
 <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
 <Z7lP5VA374-TuNZz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7lP5VA374-TuNZz@kernel.org>

On Sat, Feb 22, 2025 at 06:17:41AM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 21, 2025 at 11:45:38PM +0100, Miguel Ojeda wrote:
> > On Fri, Feb 21, 2025 at 11:36 PM Hamza Mahfooz
> > <hamzamahfooz@linux.microsoft.com> wrote:
> > >
> > > We provide these methods because it lets us access these queues from
> > > Rust without using unsafe code.
> > >
> > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > 
> > Cc'ing WORKQUEUE -- thanks!
> 
> Not meaning to complain but it by practical has no commit message.

oops, sorry, "... but by practical means it ..."

Anyway I hope my message was received ;-) Leaves me wonder tho why
this was queued because it apparently is not even part of a patch
set. "zero callers" should never be merged to mainline...

If however such patch is merged, the commit message should probably
address this exceptional condition.

R, Jarkko

