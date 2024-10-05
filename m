Return-Path: <linux-kernel+bounces-351711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120B399151D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441971C21F29
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F01E13A24E;
	Sat,  5 Oct 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qlowxjur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736976036;
	Sat,  5 Oct 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728114057; cv=none; b=dJkArpFnYTBWuckTexFi1wTNcUQGmJteec8Sc4cnUf9hpKN6azs7MlAczk5TK6NXCVrygYQv6O2uj/LjEVvUhZE4B6MQZbrxVdWKvuQuRFIE3eJSSQ4Fuo06aA2RwbmNLrIm67XUW4jMsJNH05Ga672dykR/KZ2IalkogSMinSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728114057; c=relaxed/simple;
	bh=OOyGjemrI/6GNJZpq4lLbRxvulRXcPiW/aPQFXh7c6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz62s6MXfb9OMZ+oVlfGq5tbkJjRNTDH7Z6yePyxQvguRPkw5KDckfh/uPzjLN9JIkxfbv4jmqegitrSZSWXO4yKiobzoEnqIygZD1KEshcovrXH9UVvi/hNSk0QEJOsQYfw24PlJE2fjBlLhAnNVKCx8skVgyajq23tyvwRJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qlowxjur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C35AC4CEC2;
	Sat,  5 Oct 2024 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728114057;
	bh=OOyGjemrI/6GNJZpq4lLbRxvulRXcPiW/aPQFXh7c6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlowxjur4uhb0Ziu2f6fUriGDF632pACf4ITMBKMLnIISnGNxb2SK1/KhUwWkIg2h
	 YnVGpfhEUy1TjkQVW2LVNZ8lRVlZjqxME1fH09RCpmiR00SBN9QbViG7pR0+iBxj9j
	 /UXq4+H0DmBrnBW7VxkoxUytRLXQo0DN8MiNbU/Q=
Date: Sat, 5 Oct 2024 09:40:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dirk Behme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
Message-ID: <2024100505-aftermath-glue-7e61@gregkh>
References: <20241004155247.2210469-1-gary@garyguo.net>
 <20241004155247.2210469-2-gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004155247.2210469-2-gary@garyguo.net>

On Fri, Oct 04, 2024 at 04:52:22PM +0100, Gary Guo wrote:
> This is a wrapping layer of `include/linux/refcount.h`. Currently only
> the most basic operations (read/set/inc/dec/dec_and_test) are implemented,
> additional methods can be implemented when they are needed.
> 
> Currently the kernel refcount has already been used in `Arc`, however it
> calls into FFI directly.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/helpers/refcount.c      | 15 ++++++
>  rust/kernel/sync.rs          |  2 +
>  rust/kernel/sync/refcount.rs | 94 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100644 rust/kernel/sync/refcount.rs
> 
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index f47afc148ec3..39649443426b 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>  	return (refcount_t)REFCOUNT_INIT(n);
>  }
>  
> +unsigned int rust_helper_refcount_read(refcount_t *r)
> +{
> +	return refcount_read(r);
> +}

Reading a refcount is almost always a wrong thing to do (it can change
right after you read it), and I don't see any of the later patches in
this series use this call, so can you just drop this?

thanks,

greg k-h

