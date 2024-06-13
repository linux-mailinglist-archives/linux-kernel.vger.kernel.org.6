Return-Path: <linux-kernel+bounces-213763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0C907A17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1561F2516A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B114A0B8;
	Thu, 13 Jun 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUDpZODq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE31433A4;
	Thu, 13 Jun 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300448; cv=none; b=Us2wHuKZUgybTulPZeAmv5hsE5KL1ldG/d8dAndFcgyUqkfc7Kv6YXOFj6O3YjA0MhqZATSVn+6OO3MA1KiYwcT2bm08ce7Fp2hjlVvIjo2V+5xl7EPy9kbyD8hsHU2BqZPOqYbgdElbxqivcAUl4oXTHYG0HwvUq64NNMD7aiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300448; c=relaxed/simple;
	bh=hAaUF5T3I8vPmUwK3zZqtOarg9gWX4lSB2Jkwl0QztI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r957IN5oQLQR3WlrFEBBS35pVNWlFDCU+gUBxBl8qwmuzikEfACNy+fFnu1Anr+BuKAmmbc3QlpVhCqqb0WgydJGtpb/cylwH1GdsM/NY0gWP7ir0roW0BOtDUcGW8l1l6S48bvA/KJLkimOqeT0zyo7if76T4GNWFy43ny/Cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUDpZODq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4623C2BBFC;
	Thu, 13 Jun 2024 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300448;
	bh=hAaUF5T3I8vPmUwK3zZqtOarg9gWX4lSB2Jkwl0QztI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUDpZODqOALDsA0WnL0MlT3i25SQ+VBoFilOYcAKYeeaW6blfDjGpuXgM08f5KSNj
	 iQ3f4Pc4WZOP5cJGUAtSrby5Ov9f3s4yeUUbwo9QvxIsXp14xeY+Al1csaIEHk09WX
	 5EKbaGZ03jem49NbCcXrGnTRAmRRG2hHd+Wr5oWE3rYTDQrZs7KRljUW5rsxeLeFGy
	 eprG1yzRsgUb3P0+grLsdkz8Hq+vEbVZRThH9ZdKDgq31y3kzXJuvzFd9v2na6N7j4
	 oI+4yzM7NLWQsVLKABUTyGWP/CULUzJYgc7gDzBjAvlmieRbloE740LhulTJ9cDF2q
	 i336UZmTjM/8Q==
Date: Thu, 13 Jun 2024 17:40:44 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
Message-ID: <ZmsvHBrYSpwYLyxx@google.com>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
 <87sexgrdk4.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexgrdk4.fsf@jubnut.com>

On Thu, Jun 13, 2024 at 05:51:39PM +0100, Ben Walsh wrote:
> 
> Thanks for fixing this! Unfortunately `in_range` returns -EINVAL if
> length == 0 (see the definition of `fwk_ec_lpc_mec_in_range`). I'm sure
> this broke something in my testing, but I can't find what it was now.

Somewhere like [1] could accidentally get the -EINVAL.

[1]: https://elixir.bootlin.com/linux/v6.9/source/drivers/platform/chrome/cros_ec_lpc.c#L232
> 
> My original suggestion was to add a test for "length == 0" before the
> "in_range" test, then do the test as you have done. But we decided to
> defer this to a later, separate patch.
> 
> There's also a similar "in_range" test in `fwk_ec_lpc_mec_write_bytes`.
> 
> We could:
> 
>   1. Revert this and change the `data & EC_LPC_STATUS_BUSY_MASK` to
>   `res & EC_LPC_STATUS_BUSY_MASK`. This is the same logic as before the
>   negative error code change.
> 
>   or 2. Put in a check for length == 0.
> 
>   or 3. Change the logic in `fwk_ec_lpc_mec_in_range`. Although I'm not
>   sure what the correct answer is to "zero length is in range?"
> 
> I prefer option 2. What do you think?

How about drop the length check at [2]?

[2]: https://elixir.bootlin.com/linux/v6.9/source/drivers/platform/chrome/cros_ec_lpc_mec.c#L44

> 
> Dan Carpenter <dan.carpenter@linaro.org> writes:
> 
> > We changed these functions to returning negative error codes, but this
> > first error path was accidentally overlooked.  It leads to a Smatch
> > warning:
> >
> >     drivers/platform/chrome/cros_ec_lpc.c:181 ec_response_timed_out()
> >     error: uninitialized symbol 'data'.
> >
> > Fix this by returning the error code instead of success.
> >
> > Fixes: 68dbac0a58ef ("platform/chrome: cros_ec_lpc: MEC access can return error code")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > index ebe9fb143840..f0470248b109 100644
> > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > @@ -139,7 +139,7 @@ static int cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
> >  	int in_range = cros_ec_lpc_mec_in_range(offset, length);
> >  
> >  	if (in_range < 0)
> > -		return 0;
> > +		return in_range;
> >  
> >  	return in_range ?
> >  		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
> > @@ -158,7 +158,7 @@ static int cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
> >  	int in_range = cros_ec_lpc_mec_in_range(offset, length);
> >  
> >  	if (in_range < 0)
> > -		return 0;
> > +		return in_range;
> >  
> >  	return in_range ?
> >  		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
> > -- 
> > 2.43.0
> 

