Return-Path: <linux-kernel+bounces-557156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6271A5D452
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28431189CFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5E85C5E;
	Wed, 12 Mar 2025 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="V6VDUx4o"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142A360;
	Wed, 12 Mar 2025 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745786; cv=none; b=KPSIDvjgcFcWw8kFgA1Czzg1Wn69YLsWELuiphDNmUAiBqbJzm642bhWhWgZjnYFXYpacRWlbBIb5INROH3w4sAOxpeqtky63aArzEXD/FLvIuFG9AFe/yaog/rIP7UjjwVzkiw1ZTlLMnC1vfk0+1gFsd+KbXJx2c8ge1nmQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745786; c=relaxed/simple;
	bh=0AOrgMV+q+5+MEH9xVUPqdALdhZNbcvcpqK3PmtlZro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPASzvgvAxqcIbOLAx60OUrtT+TTlM9lBnUyLdWT86MMm8vggfOoi3hQhU+Gv51npW7GcZ0NgvH3AWaEyRPD2iUKNnEUMNBUgisNC+JVYqn3006XZ2uL/krXOHhSLiruHIW6mMR2FjXC9thrIlhLkYOBem/D+iOqHUqN41T87cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=V6VDUx4o; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZCDl266PNz9t5v;
	Wed, 12 Mar 2025 03:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741745775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X8v1IpYK+tZUP7qO9gxS4wMcIQWAfMp9xkqkbS17JNU=;
	b=V6VDUx4o65v8o6MksI+XIKVKr0z4Ell4vFyesd0Pl8ynBnNjQrP62VuYTU+g3i4yjOzaOV
	XcS0boR8vf86+H/deXDd8BRZUGflKUO3yvs/Qbvh89tbnW6bFJjj/QrpOkqEjzhM99XA46
	jwqAI1h5seWfoVL414PzCNi6UQtbVoztTvFVqfusWjWf9XyUSAWPifuYBNJDExW3lkS+CV
	3KNE8JcNJCzdngvNgpTgWgvdhVdlsBxJXXfDiVNZvKBQQQdoX+0wackRKijGhxFtpdop9N
	SK2KbT5ZIC73uYzT24qjnCLiLqqk4B70uFK6/PvJE+DsDqu2WDKQW9dpg5P9hg==
Date: Tue, 11 Mar 2025 22:16:09 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?PT91dGYtOD9xP0JqPUMzPUI2cm5fUm95X0Jhcm9uPz0=?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] rust/kernel/faux: mark Registration methods inline
Message-ID: <usm5gqhdi65f3vtqfgp4vwqn24omj56f7rlnomw23suo5usmi6@bzdjrfhch5gf>
References: <jesg4yu7m6fvzmgg5tlsktrrjm36l4qsranto5mdmnucx4pvf3@nhvt4juw5es3>
 <Z8_vDWjk2LpBqLre@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8_vDWjk2LpBqLre@google.com>

On 25/03/11 08:06AM, Alice Ryhl wrote:
> On Mon, Mar 10, 2025 at 03:51:38PM -0400, Ethan Carter Edwards wrote:
> > When building the kernel on Arch Linux using on x86_64 with tools:
> > $ rustc --version
> > rustc 1.84.0 (9fc6b4312 2025-01-07)
> > $ cargo --version
> > cargo 1.84.0 (66221abde 2024-11-19)
> 
> Is there a reason you didn't drop this from the commit message?

I wasn't sure if the authoritative answer was to drop it. I will not
include it from now on. Thanks.

> 
> > $ clang --version
> > clang version 19.1.7
> > Target: x86_64-pc-linux-gnu
> > 
> > The following symbols are generated:
> > $ nm vmlinux | rg ' _R' | rustfilt | rg faux
> > ffffffff81959ae0 T <kernel::faux::Registration>::new
> > ffffffff81959b40 T <kernel::faux::Registration as core::ops::drop::Drop>::drop
> > 
> > However, these Rust symbols are wrappers around bindings in the C faux
> > code. Inlining these functions removes the middle-man wrapper function
> > After applying this patch, the above function signatures disappear.
> > 
> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> 
> On v1 I replied with:
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> So you should add that to the commit message when you send a new
> version. :)

My apologies. I forgot to include it, as b4 usually pulls them down for
me and I was just using format-patch and mutt to send v2. 

> 
> (Unless there are changes that require me to review it again.)
> 
> Alice

Thanks for applying the patch, Greg.

Thanks everyone for their help. Rust in the kernel isn't as scary as it
seems! I'll be back to help some more ;).

