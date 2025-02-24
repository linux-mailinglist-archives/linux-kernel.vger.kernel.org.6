Return-Path: <linux-kernel+bounces-528984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B100A41E95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48843188E8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCC2192EC;
	Mon, 24 Feb 2025 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llLJM4oI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF602571A7;
	Mon, 24 Feb 2025 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398839; cv=none; b=XCOuBmt4TanssUJ8bf75GghRB8ndbgXtMUnQdZG5nzPfrUByskHud2FYF+/Cu3UGNVRQ1072nb+Ix0T93i+hb/yR7kZVqzxnuV5PzGz4TDl2V5QfTLF1SXi/4Wi1zvO+SvrX/ZoXjS/Yc8HzIZoT4oS67KpZ+teuKyzPOFRBQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398839; c=relaxed/simple;
	bh=Lj7AnxrvrJdZGqg0jt9Y26sh/3qsXsYiQTfMs9xf2bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhWeit/ywx05mWPZtJmIg7IPwCqkaZUHaqxCQQzBxQa2MtxeEsxwlLLZlBzLKLO5Jb2xeuNjE3H0eOXeEbnY5YRwf0lEDPNR19sXCfDYE4Xl43ky4Y84VsK0lgNFB+Bms9ZoUNNq7DDyoc/mk2F5zsBOWAjlEIVpsXkvlrV5UZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llLJM4oI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4B2C4CEE6;
	Mon, 24 Feb 2025 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398839;
	bh=Lj7AnxrvrJdZGqg0jt9Y26sh/3qsXsYiQTfMs9xf2bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=llLJM4oIRH1SLrvaPQn/ZipABAJlry7z52TN2eJOr3wP5G9JsfqnpscjFGCMEcK0x
	 8h6u8Z8F9FO/IrKvQmSInGHVYZyjCA4n8NPAdChcqiW8pamjDLpiYEm/tjc1KD1chO
	 gPgq6fG6Butmyj5gzgDdtMxtB+a8bgmhCk+9RG+Ra7a56X29e0UiAVXPW3RYiNi45m
	 GKySzUVt2gWhsMERCGpGydGPZc8P0Qu9aivv0nTPC6JCU5JbBR2+BquXhVrMNqw5ve
	 0hpKJoEX3QmwYqoMfcgj+WrvP2XJq43S05I2/+KvqbGPfdboYqVmmDHe5UMv7BGhRo
	 BxtX0sof8DcyA==
Date: Mon, 24 Feb 2025 13:07:14 +0100
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
Message-ID: <Z7xg8uArPlr2gQBU@pollux>
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux>
 <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com>

CC: Gary

On Mon, Feb 24, 2025 at 10:40:00AM +0900, Alexandre Courbot wrote:
> This inability to sleep while we are accessing registers seems very
> constraining to me, if not dangerous. It is pretty common to have
> functions intermingle hardware accesses with other operations that might
> sleep, and this constraint means that in such cases the caller would
> need to perform guard lifetime management manually:
> 
>   let bar_guard = bar.try_access()?;
>   /* do something non-sleeping with bar_guard */
>   drop(bar_guard);
> 
>   /* do something that might sleep */
> 
>   let bar_guard = bar.try_access()?;
>   /* do something non-sleeping with bar_guard */
>   drop(bar_guard);
> 
>   ...
> 
> Failure to drop the guard potentially introduces a race condition, which
> will receive no compile-time warning and potentialy not even a runtime
> one unless lockdep is enabled. This problem does not exist with the
> equivalent C code AFAICT, which makes the Rust version actually more
> error-prone and dangerous, the opposite of what we are trying to achieve
> with Rust. Or am I missing something?

Generally you are right, but you have to see it from a different perspective.

What you describe is not an issue that comes from the design of the API, but is
a limitation of Rust in the kernel. People are aware of the issue and with klint
[1] there are solutions for that in the pipeline, see also [2] and [3].

[1] https://rust-for-linux.com/klint
[2] https://github.com/Rust-for-Linux/klint/blob/trunk/doc/atomic_context.md
[3] https://www.memorysafety.org/blog/gary-guo-klint-rust-tools/

