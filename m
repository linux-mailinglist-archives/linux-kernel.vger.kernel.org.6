Return-Path: <linux-kernel+bounces-213687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9699078C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427C21F23839
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47A149E1E;
	Thu, 13 Jun 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="RD/4abPT"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52F146583;
	Thu, 13 Jun 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297514; cv=none; b=ZVf0pFN3nVr4wco7D9Q6oNaWquMtcBt+C81SH3iBqijxgnkrPozTs5xX27XCQOy41jF9XQNej+3dgKNmXFV6/uLDD4IrB/dq8qE1cW6kkNqEvrIaNOghTNSQZhGPpHUg+EvhDh0Ylo39DxzaAw+5EAZ16JiLx4EnGydEWr7sZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297514; c=relaxed/simple;
	bh=VNcJSnvqR6/3seiRGBE6M9MZOINb+wobmGnn1qcsztk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+wNqWeRsUzi8erb7HR6ynpLN0NOvpcc8dUoDUi8yzXutucwOHc3a5LMYywNsD1+cDnLPlYAMYdzWM6uKNZktjHwCl9jegZ3+PDfUT70JEXM4A9l8hB5ipNwG316jv4KqPLLZr0HKk9GXBRauKq6Uo4b7R9W1ltU9HkzYQmk6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=RD/4abPT; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W0T2k24TMz9stL;
	Thu, 13 Jun 2024 18:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1718297502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CHPeQUmbiayIxQb12SxfsIIYWQF+CskyfBhwRKbz8mY=;
	b=RD/4abPTD9XsAvWgGQ1kW6r1+dvysVjmcjkwd00uhLfpT+nYTKZ6Po+oEBcGqYIR8gS9EX
	WzapVDFCCBl94Tc+fLzZ6uHZStfzcAMAX4zdUjwqiuCrZFYn7NkZjde/NteZQjRUyNgcRE
	ejPQlsxVHvAtBaXBa05+G6xTfix56WzW3R8ZMwsZYanTt7phip6WGPDpgkHAeQn5U5NOSh
	FooSWp7SHybL6b40IIi1kj6nk1B3U0dVt4xBA13PtjQnJhD/I+jfXp7RLeZhGS6uNu9chS
	t4T9EQ2dtHVUCY+ED4LWrWFLjICYz4Rq1WV0L3njOxLyY3HXjQCW/xKN5yIIhg==
From: Ben Walsh <ben@jubnut.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
In-Reply-To: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
Date: Thu, 13 Jun 2024 17:51:39 +0100
Message-ID: <87sexgrdk4.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4W0T2k24TMz9stL


Thanks for fixing this! Unfortunately `in_range` returns -EINVAL if
length == 0 (see the definition of `fwk_ec_lpc_mec_in_range`). I'm sure
this broke something in my testing, but I can't find what it was now.

My original suggestion was to add a test for "length == 0" before the
"in_range" test, then do the test as you have done. But we decided to
defer this to a later, separate patch.

There's also a similar "in_range" test in `fwk_ec_lpc_mec_write_bytes`.

We could:

  1. Revert this and change the `data & EC_LPC_STATUS_BUSY_MASK` to
  `res & EC_LPC_STATUS_BUSY_MASK`. This is the same logic as before the
  negative error code change.

  or 2. Put in a check for length == 0.

  or 3. Change the logic in `fwk_ec_lpc_mec_in_range`. Although I'm not
  sure what the correct answer is to "zero length is in range?"

I prefer option 2. What do you think?

Dan Carpenter <dan.carpenter@linaro.org> writes:

> We changed these functions to returning negative error codes, but this
> first error path was accidentally overlooked.  It leads to a Smatch
> warning:
>
>     drivers/platform/chrome/cros_ec_lpc.c:181 ec_response_timed_out()
>     error: uninitialized symbol 'data'.
>
> Fix this by returning the error code instead of success.
>
> Fixes: 68dbac0a58ef ("platform/chrome: cros_ec_lpc: MEC access can return error code")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index ebe9fb143840..f0470248b109 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -139,7 +139,7 @@ static int cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
>  	int in_range = cros_ec_lpc_mec_in_range(offset, length);
>  
>  	if (in_range < 0)
> -		return 0;
> +		return in_range;
>  
>  	return in_range ?
>  		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
> @@ -158,7 +158,7 @@ static int cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
>  	int in_range = cros_ec_lpc_mec_in_range(offset, length);
>  
>  	if (in_range < 0)
> -		return 0;
> +		return in_range;
>  
>  	return in_range ?
>  		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
> -- 
> 2.43.0

