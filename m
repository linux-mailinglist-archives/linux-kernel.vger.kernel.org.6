Return-Path: <linux-kernel+bounces-210625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE9904659
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0501C22E62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC5153BE3;
	Tue, 11 Jun 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F+cXvwq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F152CCB7;
	Tue, 11 Jun 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142251; cv=none; b=qLmreUrb72qPeRKudan1O4L2xWBH0Pf+Mj8x8ocq2sTJb9iMI3Q0wd/ktxsjubb1xenebi9QK9J72w3ytfYZMystQZm1miodLWRo8DisbdBMBxs3mrvix4bCAjf7xzJiTMP7EQCl4yxV8lT2whmOjK3Moa4JLeH0v80392TpL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142251; c=relaxed/simple;
	bh=MnMMMfKpCzwe5zM46Q5EbI2heIEE2LunZ3AvfWvTS6g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FcHKWT+zuz3mtazc4zksw9Ygre2hENydL3klx329F1qu8cjOnjFSwhegfZCk+L6OnPWyK5xwVhhYF1Ek2UUXEBHmMiVSygY2LgRz/8o/tqYB/SR+/oyc5bZnDuh26Bhl2tG32HlcmqNHtA8G8fgN3ORzjQQtGa5kooimw/J3OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F+cXvwq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C7C2BD10;
	Tue, 11 Jun 2024 21:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718142251;
	bh=MnMMMfKpCzwe5zM46Q5EbI2heIEE2LunZ3AvfWvTS6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+cXvwq1E2TzxC4y2mbbVqf/tGLnfTL2o8VAOeFV12pQ7Iu7bYct4JQXZ+EtFwN7k
	 rGqjg6WRjlAenK2E+/iCAhFqW/WNhMsTRYJcY43kCiht/z4G2QhQc5Di5rHjQyt2Lk
	 8/A3i9mcX3XNNNebCUrrEHW9Ly/0IHUBh5MrrTms=
Date: Tue, 11 Jun 2024 14:44:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?"Bj=F6rn_Roy_Baron"?= <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-1?Q?"Arve_Hj?=
 =?ISO-8859-1?Q?=F8nnev=E5g"?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor
 Gross <tmgross@umich.edu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Message-Id: <20240611144409.21840c70387b29eddcf5c2f5@linux-foundation.org>
In-Reply-To: <20240528-alice-mm-v7-2-78222c31b8f4@google.com>
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
	<20240528-alice-mm-v7-2-78222c31b8f4@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 14:58:03 +0000 Alice Ryhl <aliceryhl@google.com> wrote:

> Rust code needs to be able to access _copy_from_user and _copy_to_user
> so that it can skip the check_copy_size check in cases where the length
> is known at compile-time, mirroring the logic for when C code will skip
> check_copy_size. To do this, we ensure that exported versions of these
> methods are available when CONFIG_RUST is enabled.
> 
> Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
> on x86 using the Android cuttlefish emulator.
> 
> ...
>
>  include/linux/uaccess.h | 46 ++++++++++++++++++++++++++++++++--------------
>  lib/usercopy.c          | 30 ++++--------------------------
>  2 files changed, 36 insertions(+), 40 deletions(-)

Acked-by: Andrew Morton <akpm@linux-foundation.org>


