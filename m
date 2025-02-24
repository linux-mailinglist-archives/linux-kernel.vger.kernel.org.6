Return-Path: <linux-kernel+bounces-528990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DDA41EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3169A16C775
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277902192F0;
	Mon, 24 Feb 2025 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjLUBFT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FC194A44;
	Mon, 24 Feb 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399083; cv=none; b=HABZ98tqXMaAqh59+yw7jI9GrHClt6ZzqJWLJDKs6tVDX5h70siZi1smXgQKQjL0/SyRWnzXFuSX9OsSmR5yjbVp+/2/EAQXYFUddxizD1Zqw1gupFqabMbSEHBoMSjZ9TUex/XIm9s9vUBrWygHYxAi+LEhuGlaa5qm7LCrDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399083; c=relaxed/simple;
	bh=ji86S+6hkK6jvEu8J3uKVH9gFMsbNKK9qSj8rPf2IYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNRJv5wJhK6wjaG40kQ3V125mY5SN8YZpTSjoCGabC3D9QuvDAqicXQskchIF3xNP9+LCxqH1GVOpxbIGeVq6Mmqb6Yq04PztoQQshco4Z1Wuz21gAu6Q2e7BQDdoNRfvFwSeow8XGvZ/xb4ZsBFKHUFoAFDUZS2K/tGCJ6o1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjLUBFT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8EAC4CED6;
	Mon, 24 Feb 2025 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740399083;
	bh=ji86S+6hkK6jvEu8J3uKVH9gFMsbNKK9qSj8rPf2IYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjLUBFT+aQe/w0i30iEK0+Bl/rX6PURlwNIcc12p7APTHAvuAc2UMi+I5qBs2tKGn
	 4l7p/pxNtSEZpc0qflUFl0Z/Xk2tMeCF42QFAdEru26eHTkPmsTRMHrD1vCs5IZOcJ
	 8JZXbQETu+0OKu+BkgchYQCFhch7XKPOBvkWYRB78S5RFIW+Rx+yWn4Vh/Cl8usQRI
	 z0R2MlmtaBrGDOOVxWTIjC0mOKnV0iyXgrrm3xiw9NipF9NoQJq08nERJeefr+jg5f
	 XrxpHk1fyYqIP+oiziXTePlI0FAdiu5b+/b3fgxrcQqIe7lUy32DA3QDPHJxttskdc
	 zEPYIgddcwS3w==
Date: Mon, 24 Feb 2025 13:11:17 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z7xh5bEyh_MII4WV@pollux>
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux>
 <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com>
 <Z7xg8uArPlr2gQBU@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xg8uArPlr2gQBU@pollux>

On Mon, Feb 24, 2025 at 01:07:19PM +0100, Danilo Krummrich wrote:
> CC: Gary
> 
> On Mon, Feb 24, 2025 at 10:40:00AM +0900, Alexandre Courbot wrote:
> > This inability to sleep while we are accessing registers seems very
> > constraining to me, if not dangerous. It is pretty common to have
> > functions intermingle hardware accesses with other operations that might
> > sleep, and this constraint means that in such cases the caller would
> > need to perform guard lifetime management manually:
> > 
> >   let bar_guard = bar.try_access()?;
> >   /* do something non-sleeping with bar_guard */
> >   drop(bar_guard);
> > 
> >   /* do something that might sleep */
> > 
> >   let bar_guard = bar.try_access()?;
> >   /* do something non-sleeping with bar_guard */
> >   drop(bar_guard);
> > 
> >   ...
> > 
> > Failure to drop the guard potentially introduces a race condition, which
> > will receive no compile-time warning and potentialy not even a runtime
> > one unless lockdep is enabled. This problem does not exist with the
> > equivalent C code AFAICT

Without klint [1] it is exactly the same as in C, where I have to remember to
not call into something that might sleep from atomic context.

> > which makes the Rust version actually more
> > error-prone and dangerous, the opposite of what we are trying to achieve
> > with Rust. Or am I missing something?
> 
> Generally you are right, but you have to see it from a different perspective.
> 
> What you describe is not an issue that comes from the design of the API, but is
> a limitation of Rust in the kernel. People are aware of the issue and with klint
> [1] there are solutions for that in the pipeline, see also [2] and [3].
> 
> [1] https://rust-for-linux.com/klint
> [2] https://github.com/Rust-for-Linux/klint/blob/trunk/doc/atomic_context.md
> [3] https://www.memorysafety.org/blog/gary-guo-klint-rust-tools/

