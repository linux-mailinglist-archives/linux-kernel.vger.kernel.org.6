Return-Path: <linux-kernel+bounces-410363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F09CDA67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296021F22C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCC18B476;
	Fri, 15 Nov 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXQBiES6"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336F16EB4C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659057; cv=none; b=aRHM8cdkLSS9uo2u1iOS9awkkkhS4Kqkvhjt5hcL77Lp32gj+ZcllRtFeIWfhP4L+XFnw0+XluCsZYqU/9xs1SOeUPb5wvZy7/B5PHgDxSjjBrWKFqNF6LzHASiag398fxZ6oXVHLQJv9f9ht7NQSSUZPjhzPUhN3mR0yiPQrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659057; c=relaxed/simple;
	bh=ibYVGR5cGY11jXY5MH7HJGwhiLSdI3f82ZXTv3gR5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5AqQ8Ms0b17CUrXHt3G0B46Hx+JCbBcE5Zp1xaE0p9X0GHziU5AieSE3P6f+FHGPhXHvhxWL2IaTeBUcBhcOs0CRDu8vAwE+WN4xO4xiipe5oFEQ+OtMVVDzROH3xJUePR4dTehSH9MFsE1E39GkwdUJ7Gca3HMbb+kAiVhtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CXQBiES6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43152b79d25so3503955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731659054; x=1732263854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWRrZUkhxGjMZeY29OrWmdvCo90xdRe7Aypy1R6OUmE=;
        b=CXQBiES6E+fgzH6WENOoQQifQin5TYPlQSOCuFDopaXXVhld5/Ol9lURGlRvcE6ZjV
         5EUkNFfQzteGdubCFuOV3ds9nAQHi2wy407T8fceoVh9H8ULHzonkq06BDp6IQ1X6z7i
         hDY/w2SeAQUBP/RgfntRzG1i4ntUYAKLslhbTcrltoqGKxcvOj2B5XKjhbqvfieyq49I
         ZrbdJ+/QkPTefaaYXCEzXPPhlLntHNiUN2HdFiGxmKeTC1tPSpLr0FWZLDlBHDf3HwK2
         k5qBwOAZdoatmpcQOvTj9TKQ13/tXdiBV1CZVGu/KouASWiG+81fARGCE8PIZzsIdv8q
         /ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659054; x=1732263854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWRrZUkhxGjMZeY29OrWmdvCo90xdRe7Aypy1R6OUmE=;
        b=K4iI+caIsZr27IiIs06z8yz2pN4xK0wBHqwJU1Z61vaoxcXUCCeX2+xWBn2JZYtIJC
         qoQM2PGOcvMMAo2cFP11zsWE4jPs3ChUZjH664eJqPE2rS+0eeK0MrUoqIKCAMya1d82
         cCqO2fgsvitc6rjnCS3wYLEZl6N0cOS24Rab9mYPe19UhGrqzCWQhFuWr4wzcUhi6gc3
         sgykW4oyTEtID10cPoU9fyS76dQmIzbgZ+NDWX1Jk+aTzVvvtoZBoc91I2MXym4Dcok+
         wm/SXg1oIHIk3v18urz6hkSt+PDGj1ynf3DbpKpVOUgGEpLlJH4QNMRShZ8YKGw9k5ep
         ygYA==
X-Forwarded-Encrypted: i=1; AJvYcCXfQicJYqLX1ehRjClRa0EisU/i+WLzGXdKjpl9w5WruQ/OoEyYQBxe/45GugaCd1hpFMu7aO8+csn+L7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXOjiLZ/skZ8eA1NhvAp/ZTZ6UxWpiIZIuvEqNGNT5C6Wgz3J
	3VzYNJnXWy8qyGnElJWqnxLkC1t6t3piBuuBISlw+Z2H+DPjpP4cXJKiJHuoO9g=
X-Google-Smtp-Source: AGHT+IE6iZRKIEII2jo7jJBhaHE9KSdI3yml3wTWpJc85CoFNhJyDFKxbpJmnFwfiCV7cb6knB5SAg==
X-Received: by 2002:a05:600c:3d15:b0:432:d797:404a with SMTP id 5b1f17b1804b1-432df78de80mr11268285e9.22.1731659053736;
        Fri, 15 Nov 2024 00:24:13 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78918sm45682765e9.17.2024.11.15.00.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:24:13 -0800 (PST)
Date: Fri, 15 Nov 2024 11:24:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: stuyoder@gmail.com, laurentiu.tudor@nxp.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 0/2]  bus: fsl-mc: Fix two double free problems in
 fsl_mc_device_add()
Message-ID: <e18e02dc-4628-4205-96da-fff67afae8ab@stanley.mountain>
References: <20241115023206.3722933-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115023206.3722933-1-suhui@nfschina.com>

On Fri, Nov 15, 2024 at 10:32:05AM +0800, Su Hui wrote:
> This patchset fixes two double free problems in fsl_mc_device_add().
> One is reported by clang static checker, another is reported by Dan when
> reviewing the code.
> 
> ps: There is only patch 1 in v1 patch, patch 2 has no v1 version.
> 
> v1: https://lore.kernel.org/all/20241114082751.3475110-1-suhui@nfschina.com/
> 
> Su Hui (2):
>   bus: fsl-mc:  Fix the double free in fsl_mc_device_add()
>   bus: fsl-mc: using put_device() when add_device() failed in
>     fsl_mc_device_add()

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


