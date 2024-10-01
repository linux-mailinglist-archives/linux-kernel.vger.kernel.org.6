Return-Path: <linux-kernel+bounces-345291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BF98B434
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D9F28416F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864801BBBED;
	Tue,  1 Oct 2024 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etsPoELH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF119046D;
	Tue,  1 Oct 2024 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763807; cv=none; b=iKycE/5waqY1nPewd33yfGVehNKQiWZixCgc2cYlkjWeGGjlBvuwAuKj0xqLK7ubklu/gxUdgld9yPh1P6j8IxQBfQIY4sMhExTGylw72ryqMyAFWoeeA+BRPwNt9mZkMsYdaCbqF5Zo8eS293B7WbYUe6A/rlyh5s3nLnYWDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763807; c=relaxed/simple;
	bh=lKwsQYNeVzuykSh6+Uq3YzXdZ7KiLz01Dl9Ii8/rOKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjClYV9NIUXtm1ddhvfgnCCPtHU9eE/9urTnE/iddeWvP2lPnhEwRoK5uLZ2QrYyamCLnUvns4eig8agHIamBGkANi8HV8dgGGbqzOKCCvA3hO6vqiOPxauTfEci5Y2VQnN6EAUS9YGlv+SXk/zHkwm9QfJVuQEoHW1h7FHcXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etsPoELH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDFCC4CEC6;
	Tue,  1 Oct 2024 06:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727763807;
	bh=lKwsQYNeVzuykSh6+Uq3YzXdZ7KiLz01Dl9Ii8/rOKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etsPoELHTRAlzBvG+fo7UbgyTc5kXDwMQjaFDsA5Ri40/au6Wq7N8Kke4kaqzNVrK
	 7RISUfMcAKgsA9JtNe0Yiz0mZHF95o+gBZUwKOFvvOxf7YiMuxgaMsfR59FueB4iMC
	 O2b7fgbZSmOIQcIXX6jS2V+bd0Xm0VXYIEi2oKjI=
Date: Tue, 1 Oct 2024 08:23:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org,
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: device: change the from_raw() function
Message-ID: <2024100107-stipend-lid-1beb@gregkh>
References: <20240930194637.98260-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930194637.98260-1-trintaeoitogc@gmail.com>

On Mon, Sep 30, 2024 at 04:46:34PM -0300, Guilherme Giacomo Simoes wrote:
> The function Device::from_raw() increments a refcount by a call to
> bindings::get_device(ptr). This can be confused because usually
> from_raw() functions don't increment a refcount.
> Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
> semantics.
> 
> The new name of function should be "get_device" to be consistent with
> the function get_device() already exist in .c files.
> 
> This function body also changed, because the `into()` will convert the
> `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
> `AlwaysRefCounted` trait implemented for Device.
> 
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  rust/kernel/device.rs   | 15 +++------------
>  rust/kernel/firmware.rs |  2 +-
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

