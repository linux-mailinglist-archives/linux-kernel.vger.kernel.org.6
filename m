Return-Path: <linux-kernel+bounces-213890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBAB907C15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22B11F23688
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CFF14A616;
	Thu, 13 Jun 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="L4RxlyWP"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF1149E1A;
	Thu, 13 Jun 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306069; cv=none; b=GqCZgXHjcNehXRKLyL90cfpFY2dXui0pe9woeLOa7cGasi6cvb8rANnXB1X5PYZe0TKqOB9pEigySmOvnJutUKEMdC66iLPwQOvU05D+wt5zs1h/vPAF1nupaP7XV0thd1E8robgjdIjmbLudguJYfvDRnn605DogAZJjlZgRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306069; c=relaxed/simple;
	bh=SInef4o5M1AK1ysJCyquEWbuWWbqBrt9x4MkjqwsuwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AXGEc5a5QEqpYGcAZ1DtXDW2jsqWamHiZzZUyHNykw+mycbFEmSz8ASBq/mXaw3rkJoKeTTPqZqOe/Z3RmVl95lqL2azrkKqaSrwWv5b07szaiPZaxgpzMn+ws4qqCWqqJgSAO9t6YJJz2z6DUW2xniZe0VaXWQspPEpFdTPe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=L4RxlyWP; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W0XCF1gwBz9sxf;
	Thu, 13 Jun 2024 21:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1718306057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y2fqfo34jYOSwwgMfXN35xvUGJse2iPb8SuE0d9SRI=;
	b=L4RxlyWPdRZoDVbvUgoWt2/kWCnKJ7oAPnbO+v1RwHWV3LF2hCxNYY9N8vjMGTXuouXGBK
	iphm4wecR/ExSX/HS+R1hFOudMbV8ifHxVucEX5U5phwek+q6L4NNKO0Cjk2P6dY54Mv0S
	8exe4k+Waxw2CB0qK5agl+NEZG/pxZJSGRDjpw5lhIZSFSvRthHjbKnDhqjN8kJML2r9jT
	ws2jnB4NgmRYtSCK1gONy5RMpoIEHKYvQU4j60oGZa9wXaUZ9hkdJAzJiwOd5c9ekE64Gr
	ayP9w+14JxfuicqdivAQiuPAAHOrxbULdqg4p/bM9mSMlv+jYNe75tnrx/SQzw==
From: Ben Walsh <ben@jubnut.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
In-Reply-To: <ZmsvHBrYSpwYLyxx@google.com>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
 <87sexgrdk4.fsf@jubnut.com> <ZmsvHBrYSpwYLyxx@google.com>
Date: Thu, 13 Jun 2024 20:14:14 +0100
Message-ID: <87o784ac55.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4W0XCF1gwBz9sxf

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> On Thu, Jun 13, 2024 at 05:51:39PM +0100, Ben Walsh wrote:
>> 
>> Thanks for fixing this! Unfortunately `in_range` returns -EINVAL if
>> length == 0 (see the definition of `fwk_ec_lpc_mec_in_range`). I'm sure
>> this broke something in my testing, but I can't find what it was now.
>
> Somewhere like [1] could accidentally get the -EINVAL.
>
> [1]: https://elixir.bootlin.com/linux/v6.9/source/drivers/platform/chrome/cros_ec_lpc.c#L232

Yes. It turns out I'm getting it in:

cros_ec_query_all -> cros_ec_proto_info -> ... -> cros_ec_pkt_xfer_lpc

          /* Read response and update checksum */
          ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
                                                             ^^^^^^^^^^^^^^^
                                     msg->data);

(as Dan suggested in his email).

>>   or 2. Put in a check for length == 0.
>> 
>>   or 3. Change the logic in `fwk_ec_lpc_mec_in_range`. Although I'm not
>>   sure what the correct answer is to "zero length is in range?"
>> 
>> I prefer option 2. What do you think?
>
> How about drop the length check at [2]?
>
> [2]: https://elixir.bootlin.com/linux/v6.9/source/drivers/platform/chrome/cros_ec_lpc_mec.c#L44
>

This works, but we still end up calling cros_ec_lpc_io_bytes_mec() with
zero length. Although this seems to work fine, we could put a length
check at the top of cros_ec_lpc_read_bytes() to avoid it.

>>
>> Dan Carpenter <dan.carpenter@linaro.org> writes:
>> 
>> > We changed these functions to returning negative error codes, but this
>> > first error path was accidentally overlooked.  It leads to a Smatch
>> > warning:
>> >
>> >     drivers/platform/chrome/cros_ec_lpc.c:181 ec_response_timed_out()
>> >     error: uninitialized symbol 'data'.
>> >
>> > Fix this by returning the error code instead of success.
>> >
>> > Fixes: 68dbac0a58ef ("platform/chrome: cros_ec_lpc: MEC access can return error code")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> > ---
>> >  drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
>> > index ebe9fb143840..f0470248b109 100644
>> > --- a/drivers/platform/chrome/cros_ec_lpc.c
>> > +++ b/drivers/platform/chrome/cros_ec_lpc.c
>> > @@ -139,7 +139,7 @@ static int cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
>> >  	int in_range = cros_ec_lpc_mec_in_range(offset, length);
>> >  
>> >  	if (in_range < 0)
>> > -		return 0;
>> > +		return in_range;
>> >  
>> >  	return in_range ?
>> >  		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
>> > @@ -158,7 +158,7 @@ static int cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
>> >  	int in_range = cros_ec_lpc_mec_in_range(offset, length);
>> >  
>> >  	if (in_range < 0)
>> > -		return 0;
>> > +		return in_range;
>> >  
>> >  	return in_range ?
>> >  		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
>> > -- 
>> > 2.43.0
>> 

