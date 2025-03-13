Return-Path: <linux-kernel+bounces-560079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B2FA5FD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254FB7A198C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5426E64C;
	Thu, 13 Mar 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/71C3Ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42826A0A4;
	Thu, 13 Mar 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886049; cv=none; b=aeRMrbXjWPxZJYXbxkQ6okSlHYDPwjKDFwP5KnarYmZbxafJz2JjkiL2VrHSS7AixXCfyFSowtXz4jE3XjcU9FN8Qn7MLoARVqnQwhIpQZ+vDZF38pyOgn8zaPjTXAgad/SNn0RKcxuwdFf1XjyrXpFZy+jjZKRTU6lQjc7uRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886049; c=relaxed/simple;
	bh=Ekfk4xszr9V+zTVnqnMwGYkIAsjM6mXFoc1R6nnM4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3OlisFZlFGam4RHR7X4lA08Ui2egmn+lsBexbog7L/MWIWYOVZB3nrdP79Gq63gDhxyuyHJiCPofj7VHnlRUb01WRA9AMUrIxcwvgydL62s1jeiXqLhQAXP/yETzw5eSSbs7t8SP56dWTae/K1vnm4w2RLTVnDNEfCyueAjJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/71C3Ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535E6C4CEDD;
	Thu, 13 Mar 2025 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886048;
	bh=Ekfk4xszr9V+zTVnqnMwGYkIAsjM6mXFoc1R6nnM4TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/71C3Abrdv+HXUXPYmLLfwl+/yM287fYQrzfIzp30fiSGJSlTf/FrCpOVKISMjzd
	 iSrIe3W+ivQ2aQ4chwXfTY8Pye1mhxCcnZyPl6C+IuYuGg0wNDPHa7BLnvKpNrVaKg
	 wCnmNYoMGNh8GaZ4CHSfUDAdcInLqqm30IqjZnbUEunS7dr9CNctOjl0V6wi7MTO+V
	 KZG74+IlVhQ2IARTkpZ65puzE0st25cqtJojxOuC2e4OYah2+/gcvwV0Bzyvz/5iDs
	 W8xDAD12dvVGGNjyad3rbTEbaqgyISQh7HId7RsaNdfodrlGO9cEwsSDH+YzihedZp
	 f+3yHT17qtQNA==
Date: Thu, 13 Mar 2025 18:14:03 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RFC] rust: add macros to define registers layout
Message-ID: <Z9MSW4VAjqWd4NmY@pollux>
References: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>

Hi Alex,

Thanks for working on a generic solution for this! Few comments below.

On Thu, Mar 13, 2025 at 11:48:25PM +0900, Alexandre Courbot wrote:
> Add two macros, reg_def!() and reg_def_rel!(), that define a given
> register's layout and provide accessors for absolute or relative
> offsets, respectively.
> 
> The following example (taken from the rustdoc) helps understanding how
> they are used:
> 
>     reg_def!(Boot0@0x00000100, "Basic revision information about the chip";

Should we call the macro just `register!`?

>         3:0     minor_rev => as u8, "minor revision of the chip";
>         7:4     major_rev => as u8, "major revision of the chip";
>         28:20   chipset => try_into Chipset, "chipset model"

I think we probably need an argument indicating whether the register field is
{RW, RO, WO}, such that we can generate the corresponding accessors / set the
corresponding masks.

>     );
> 
> This defines a `Boot0` type which can be read or written from offset
> `0x100` of an `Io` region. It is composed of 3 fields, for instance
> `minor_rev` is made of the 4 less significant bits of the register. Each
> field can be accessed and modified using helper methods:
> 
>     // Read from offset `0x100`.
>     let boot0 = Boot0.read(&bar);
>     pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());
> 
>     // `Chipset::try_from` will be called with the value of the field and
>     // returns an error if the value is invalid.
>     let chipset = boot0.chipset()?;
> 
>     // Update some fields and write the value back.
>     boot0.set_major_rev(3).set_minor_rev(10).write(&bar);
> 
> Fields are made accessible using one of the following strategies:
> 
> - `as <type>` simply casts the field value to the requested type.
> - `as_bit <type>` turns the field into a boolean and calls
>   <type>::from()` with the obtained value. To be used with single-bit
>   fields.
> - `into <type>` calls `<type>::from()` on the value of the field. It is
>   expected to handle all the possible values for the bit range selected.
> - `try_into <type>` calls `<type>::try_from()` on the value of the field
>   and returns its result.

I like that, including the conversion seems pretty convenient.

> 
> The documentation strings are optional. If present, they will be added
> to the type or the field getter and setter methods they are attached to.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> I have written these initially for the nova-core driver, then it has
> been suggested that they might be useful outside of it as well, so here
> goes.

Feel free to add my Suggested-by. You can also refer to the corresponding task
in our nova-core task list.

> 
> This is my first serious attempt at writing Rust macros and I am sure
> there is a lot that is wrong with them, but I'd like to get early
> feedback and see whether this is actually something we want for the
> kernel in general.
> 
> The following in particular needs to be improved, suggestions are
> welcome:
> 
> - Inner types other than `u32` need to be supported - this can probably
>   just be an extra parameter of the macro.

Can't we figure this out from the bit mask in the macro?

> - The syntax can certainly be improved. I've tried to some with
>   something that makes the register layout obvious, while fitting within
>   the expectations of the Rust macro parser, but my lack of experience
>   certainly shows here.

Did you consider proc macros for more flexibility?

> - We probably need an option to make some fields or whole registers
>   read-only.

Ah, I see, you thought of this already.

> - The I/O offset and read/write methods should be optional, so the
>   layout part can be used for things that are not registers.

I guess you think of shared memory? For DMA we already have the dma_read! and
dma_write! macros that may fit in.

