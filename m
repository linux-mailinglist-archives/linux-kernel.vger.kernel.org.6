Return-Path: <linux-kernel+bounces-335057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4DF97E064
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05636B20F83
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C119307E;
	Sun, 22 Sep 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivwm1e57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDD13D893;
	Sun, 22 Sep 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726988923; cv=none; b=XpRZ3FA878aHkXrFryR25b42bbvxI/51CdW+z6VBpiZOnQX2lsY4qEtckHyIVJkc4pbgH7JftJ9Kcz/4507DNoYc+0D86mNthVB7TZOlE9Oavo7LmaucGSGQaRisOsl7W7fv2sjqWR9ePOE7uBYkVItpGedc5Pwc5K0HDT1Jl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726988923; c=relaxed/simple;
	bh=Pl7LYO3PH7IY3j9QY3/tjp3FFfGRuEsI3T5Rp9sTW6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW3ahb8nfDI6ifFyK9WE6K+OjqDjVxSPnT7LVzCPXCB+RYCtpHOwfXyE9BgY4Y64TQNgctAf41gQYSqodelvmtS5Nj+4vpb3YarKjI901TpuzmmTiCzlfJ81KEopXwnIUqE4Nb24UkjddB/5CkB/lIvWXfWQRkgeT4b7eJxSdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivwm1e57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5E7C4CEC3;
	Sun, 22 Sep 2024 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726988923;
	bh=Pl7LYO3PH7IY3j9QY3/tjp3FFfGRuEsI3T5Rp9sTW6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivwm1e571wNQdXqM6SOXXlWAWg8UkYarzwFQC5sWGuzkMmdX95fCmpn0YJq60zBHy
	 PxvhmAjic/dTRGPHGEIyWAOQ68Z7cXvDH/ahPQSwfwHfr4mVBMNFP3DI2AKkR/j6KH
	 D7ucUtNXJwAWbQsTKeTnWSrXxSJUz0cfOijaLz7+G33K4TlvqaH9+xbBVLtjNvBURK
	 A7N05XyA7EIVnp2IHIi2VjT6k3m8jUi7eAlEFzEd7AfUp2ZiUXqMS3G4TZOXwZMHjE
	 jQSQdwE23Sn0ikDmaHeFzTtoPTaMdvX84sO1GwpC5jVJqk5mVjCCuphrUnyUH5DYbU
	 5UGvBXXsxj61Q==
Date: Sun, 22 Sep 2024 03:08:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Message-ID: <Zu_CeRfMKyyt4E5O@sashalap>
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
 <20240528-alice-mm-v7-2-78222c31b8f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240528-alice-mm-v7-2-78222c31b8f4@google.com>

On Tue, May 28, 2024 at 02:58:03PM +0000, Alice Ryhl wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>Rust code needs to be able to access _copy_from_user and _copy_to_user
>so that it can skip the check_copy_size check in cases where the length
>is known at compile-time, mirroring the logic for when C code will skip
>check_copy_size. To do this, we ensure that exported versions of these
>methods are available when CONFIG_RUST is enabled.
>
>Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
>on x86 using the Android cuttlefish emulator.

Hi folks,

I've noticed a build failure using GCC 9.5.0 on arm64 allmodconfig
builds:

In file included from ./arch/arm64/include/asm/preempt.h:6,
                  from ./include/linux/preempt.h:79,
                  from ./include/linux/alloc_tag.h:11,
                  from ./include/linux/percpu.h:5,
                  from ./include/linux/context_tracking_state.h:5,
                  from ./include/linux/hardirq.h:5,
                  from drivers/net/ethernet/mellanox/mlx4/cq.c:37:
In function 'check_copy_size',
     inlined from 'mlx4_init_user_cqes' at ./include/linux/uaccess.h:203:7:
./include/linux/thread_info.h:244:4: error: call to '__bad_copy_from' declared with attribute error: copy source size is too small
   244 |    __bad_copy_from();
       |    ^~~~~~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:244: drivers/net/ethernet/mellanox/mlx4/cq.o] Error 1

I do not have CONFIG_RUST enabled in those builds.

I've bisected the issue (twice!) and bisection points to this patch
which landed upstream as 1f9a8286bc0c ("uaccess: always export
_copy_[from|to]_user with CONFIG_RUST").

Reverting said commit on top of Linus's tree fixes the build breakage.

-- 
Thanks,
Sasha

