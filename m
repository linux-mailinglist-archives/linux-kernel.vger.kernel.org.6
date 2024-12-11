Return-Path: <linux-kernel+bounces-442055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4B9ED766
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D43F166A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4C211A0B;
	Wed, 11 Dec 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rVWUf29r"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665D20ADC5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949760; cv=none; b=WauNtG6f4kML0QKKTWBEBK8DU+EEAtWpBoc466YA/OIfw7yKmzF8iSX+VcMJhx52RKZhsq4ZfGmHs/RjNOKT/9RohXpYklT/6EQ8zV/2dzYXr6bsQJmbmJqsTgrV3m8o6ukdmi9SgoQYTLB+7tIBGGPK+jCYDjIuN3iNjVsdJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949760; c=relaxed/simple;
	bh=zt+gFce7p9BmlGHKA/G5UtDVOqnwFe3Mu9Nc5y11DvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTW5L8YJO+AV6kmiSHHVceF41aSRJnhirJwAoGM1xDcFd23ISwSUsO8xr9ZR2zmczqijbYMRFnj47Z0X7Cj9xq4MQPMAYYugI0FbvwTddBuoP/9YIszB3dshrzYTTyST+MbSuoekSs7sFmWE++Eo4ZHCRuRxboGT6PG30OdLCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rVWUf29r; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d932b5081eso14131686d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733949757; x=1734554557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QqbNdfAl0+PnKaqyg/McU4dzsm66c1ARzs60VG3n/Q=;
        b=rVWUf29rgfOHsIWkogKVYykvGQDi1cCGzo5rNxJvYOdlxcfUDC8UT/CuWfUL1+klRQ
         ivsbxQKUfdxq5suQ4HcnL/NN+JC47xc0w7eEowRr2wes473c92MhYJAnBSb34s4/sAL6
         wbuPkDvClYJwwMcTg5+2/UEr7x9LgCAJrzXFG9BUZLLRtZHfyMFwO6pAL1Xj7LJyz2vG
         NEIFPsr+uNYMaLZdOBdBT8VQN705g7eGhKYWRUkPYW5sU2CS1NILxuIhp9BKgLfKkI6w
         1ZAXOp47GUJ18rD8Qnus47B+x9twXFESGiORtkrLN1VQ1OFAEUG4jpuD7z88YlbDVZjK
         WSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949757; x=1734554557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QqbNdfAl0+PnKaqyg/McU4dzsm66c1ARzs60VG3n/Q=;
        b=Hc/TxvaFa4gQZGaoHn5wj+9VtUl7yHS6I5C++SzM6igelOkuDYhh8caJsRapDMIDln
         d05NUdowY9eKu11aUMtWK2BKl7dsElvYLZ12r9YrujZN3zbXrvAVR+toK4Cc7TY9w/i+
         T93eQYyeLoFofYqYO7q8odbIN0eRiZsLrLDsU5QM8bTs6T5PdClrADuZqQYo71p0owxz
         CKIBkpXTEEQhlLeEDrSHZCH3F14HKh7zTVzedU3+XHCwg5oiMBBBVlNlI4p5KAP2oVNP
         hJmRPfZqa9ZKT7t7CDHX8oNJ1kXHSCwAhE1rCuH2QhM1vg7xsxw/jqJrChn18xTE6TQx
         rC2A==
X-Forwarded-Encrypted: i=1; AJvYcCWN7NKtCpWi09KdxL1WwBe44gvckL4M5oRaNRsGdzshPDQ40dccIpu55oWoWUGih4Qt1Ti2Neumjn9XTzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEFbK1HQCPT4r1/Uvukg8d0irWq5rvy+yhqZTacNNcPmgLfnl
	7z0dX+0oOrAemI8/aXCSWinc8IcZ4ZytGu2QEm3xO6DQqPChhcE26v4Qk03fdQ==
X-Gm-Gg: ASbGnctI7YvuqqpfGjQ7+v/A6s3SKbMlU50D1W/WY6+o0xT1x+uaFL56Tz1F9wnvV6w
	M0+yGbrT2cF6PYzgyGY5l2M9x0dj1x7aey13E9sSzPyCUL8JRSQJVTaB6uOVjAAyFGPp2elEA7K
	cPFr6W6fib6eMfpviuKzBJc4W3WwGUVyKmVGOtbB8fJ+xhpjIaJiKUXGcZsKe5/XUhXTDeHHg0q
	h9lePHKlwonBePRbD6z8S/vs5oBUDeYUJorN8xRL4Cy8mTs6zvOxCc=
X-Google-Smtp-Source: AGHT+IF9wfnACETnd7h+8oR2ewgyIJnzStpbi5TxIuMnorvz2Mi4NfAoRC3aWnanTSJRpGzamD/DJA==
X-Received: by 2002:a05:6214:258e:b0:6d8:83bd:5cfb with SMTP id 6a1803df08f44-6dae38e22f9mr10593686d6.10.1733949757648;
        Wed, 11 Dec 2024 12:42:37 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::5dad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d907713550sm43096176d6.6.2024.12.11.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:42:37 -0800 (PST)
Date: Wed, 11 Dec 2024 15:42:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, rbm@suse.com,
	skhan@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] lib/math: Add int_sqrt test suite
Message-ID: <ad95d09e-ddbe-4d43-bf22-00c2008823d8@rowland.harvard.edu>
References: <20241211203425.26136-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211203425.26136-1-luis.hernandez093@gmail.com>

On Wed, Dec 11, 2024 at 03:34:24PM -0500, Luis Felipe Hernandez wrote:
> Adds test suite for integer based square root function.
> 
> The test suite is designed to verify the correctness of the int_sqrt()
> math library function.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---

I don't know why you CC'ed linux-usb for this patch.  But as long as you 
did...

> diff --git a/lib/math/tests/int_sqrt_kunit.c b/lib/math/tests/int_sqrt_kunit.c
> new file mode 100644
> index 000000000000..a94c68816a1a
> --- /dev/null
> +++ b/lib/math/tests/int_sqrt_kunit.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <kunit/test.h>
> +#include <linux/limits.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +
> +struct test_case_params {
> +	unsigned long x;
> +	unsigned long expected_result;
> +	const char *name;
> +};
> +
> +static const struct test_case_params params[] = {
> +	{ 0, 0, "edge case: square root of 0" },
> +	{ 1, 1, "perfect square: square root of 1" },
> +	{ 2, 1, "non-perfect square: square root of 2" },
> +	{ 3, 1, "non-perfect square: sqaure root of 3" },

s/sqau/squa/

> +	{ 4, 2, "perfect square: square root of 4" },
> +	{ 5, 2, "non-perfect square: square  root of 5" },

s/square  root/square root/

> +	{ 6, 2, "non-perfect square: square root of 6" },
> +	{ 7, 2, "non-perfect square: square root of 7" },
> +	{ 8, 2, "non-perfect square: square root of 8" },
> +	{ 9, 3, "perfect square: square root of 9" },
> +	{ 16, 4, "perfect square: square root of 16" },
> +	{ 81, 9, "perfect square: square root of 81" },
> +	{ 256, 16, "perfect square: square root of 256" },
> +	{ 2147483648, 46340, "large input: square root of 2147483648" },
> +	{ 4294967295, 65535, "edge case: ULONG_MAX for 32-bit" },
> +};

For the higher numbers (16, 81, etc.), you should test N-1 (and maybe 
also N+1) as well as N.

Alan Stern

