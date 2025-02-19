Return-Path: <linux-kernel+bounces-521959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7DA3C455
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A29172672
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695551FCCF7;
	Wed, 19 Feb 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvtxlCVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA65192580;
	Wed, 19 Feb 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980729; cv=none; b=blrqpp07OAxpwfEwhxKg9OtRWe1YiN06v0Zkbx8YRZKu7Sb9aC2oTuIWaea1MK8Kux8VBsXRJj1nDknLoLeJv0fXR4RqBOdiR/u55dd3+wxT+op57AY9OmpaAs0oSIs2ZIbqnl3gpgLqhfctI9tVqURyizMMKYFWG18eJLs3dB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980729; c=relaxed/simple;
	bh=Q9QZKVxCZAmZgmwBcV2lUKpoTiM7WVccubym2Jp3FaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaM9WMLEjmKL0OcT8SPKyiNyJRovS5wLMikM+jXGqnuxrfSbCLL3/T189BN0Qa1ZvAHYStYYeVOx9o1meUmq9xPD0hVRfv0/rykQmjjdPWoZKkbNnH0eCbi8hBcq0N0LLlrAwqdLGSfl5QlQbZPZBKaAWBOJ4HLP7U72crATPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvtxlCVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB71FC4CED1;
	Wed, 19 Feb 2025 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739980729;
	bh=Q9QZKVxCZAmZgmwBcV2lUKpoTiM7WVccubym2Jp3FaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvtxlCVRUeE1cAxvkFEvKx43aFldmi2UE5+sG4Sd7ytoKj5fPv/apRs2qp25Za8eb
	 /kkxpG88d/8eDmvxRAHCYhERI+rEf4u39BPepfXBtGO8PsSkVu3rPR3rfyvFFtKFwg
	 WYofqwQQ1gwCplQepOnX57sGcgGWRBf77lUpj2Rk=
Date: Wed, 19 Feb 2025 16:58:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: miscdevice: change how f_ops vtable is constructed
Message-ID: <2025021926-transport-fridge-bc43@gregkh>
References: <20250117-miscdevice-fops-change-v1-1-ec04b701c076@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-miscdevice-fops-change-v1-1-ec04b701c076@google.com>

On Fri, Jan 17, 2025 at 02:22:32PM +0000, Alice Ryhl wrote:
> I was helping someone with writing a new Rust abstraction, and we were
> using the miscdevice abstraction as an example. While doing this, it
> became clear to me that the way I implemented the f_ops vtable is
> confusing to new Rust users, and that the approach used by the block
> abstractions is less confusing.
> 
> Thus, update the miscdevice abstractions to use the same approach as
> rust/kernel/block/mq/operations.rs.
> 
> Sorry about the large diff. This changes the indentation of a large
> amount of code.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 295 ++++++++++++++++++++++------------------------
>  1 file changed, 141 insertions(+), 154 deletions(-)

This doesn't apply against a clean 6.14-rc2 tree, what is is made
against?

thanks,

greg k-h

