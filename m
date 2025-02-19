Return-Path: <linux-kernel+bounces-521946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19AA3C427
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DD216F541
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1301FC0F5;
	Wed, 19 Feb 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+1UDFHo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6091EFFAB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980367; cv=none; b=e/E+jd0+kMhIxe37UU/UsvQ0E4LObLwwQ2JxFrVgqxh5quWHyTbA2f/H+Hg7l2GTrmLnmySoBxawA+rRTYWmlMaP0us6xdFTjLmGHqAbggETY3YZ0XTlyr/f3STO1Df43q71eXuOgkL1w2tAa9Uf6ztYGE8JIVezabp1ihmShNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980367; c=relaxed/simple;
	bh=pEcxwQpBp3v3mtfwUr9cTBv0rgYK4fF8S41XDym7D9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eflx0ARaaR395+nFpbTAriaPqXmLNvqX2DbmlQrguE5ANwPD8QrYQ/nmNsm3UI/lJ3Dp4iwwaGWO9tgNVfiftoWMQI46tS9tsIp7tt90MmavD7rW4n7OpQzFbv2Zk4dXQDN7IFbNBM+7ogE/UFmBiTem2we5jS6akqpKRuSKUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+1UDFHo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7f539c35so882898166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739980364; x=1740585164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2qnzAL28gEBKt2chLF3/kynXlu482Vkn7hB2mE3QcM=;
        b=D+1UDFHow8aon359qGnaIXvMn1sxm1Ci2ytor9zB3cve60BlwDB1aGRg0X/GLnOSQ/
         GHGpEBXyt2rxONfTVbxLb3dbpB9pnMBbPbvFVmi+cMzWNCQr/7FeV4Wi6YBtD3FYmsKe
         WQg80hWcwpm+PE/JSCP0axXIBMJEDgLH9rDH1cMUeTYV4M9pk/889PFrDy2qwd2dNooB
         rWmvzszMeVeYSQfC6GrrIUEkIeRdovXgNHE8ye9xPCOr2k1LB8OU2EZTHxmYxnIVbxL0
         KZf+SNddcSh9HA2pBkCQoTXT7t94ZxGZ40xrPOgcJeCWzMhA9jox8KRNlOojm69i8r34
         xYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739980364; x=1740585164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2qnzAL28gEBKt2chLF3/kynXlu482Vkn7hB2mE3QcM=;
        b=wsS8JoQ5U2/Bn3HuYma6cihWryZ55OuY6pFMDxr/pdGzxWfPPgXEgSs4COBBQ6MQWP
         /mYP4xT7DtEYHKn7B8UnwQ3TQ7w+OLWIP/8H69j5splNuE/oIF6NKPOc7XrBKJwMYMye
         79MMWJzr19UjKKgLZUodgyqvcn/+qwWPjD+9NI4YmRV5H1sCPLrelgkN6rSC2nZpD5eP
         OChLosHZzvc0yWHvV61lihI6hRSFetnrCt3kiMUBaV+pebCQYum7lq3MryMN8PcXqScy
         fjNmyIJbWsXtoRpmjd8gYSqlZDaixkxPe8B+pYXq5oFzJFPEkvzNIIJULAwh6k1DUMen
         hVlw==
X-Forwarded-Encrypted: i=1; AJvYcCUYYeBhqlhRFOpnyCCyf4cG+eRz+gRKkvteZO5XvGKEcPeBvUNYlmt7spqjuWObd3Z2c47BNph8bA/gJgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRymKxWZB3syNCqLEcCrJx6dGjNtlQEvSCuBZoNGKN2KccKOy
	Z52wfK3FalEelMKOSR1X4a6vJo5wrHrRhhEN+m3aEjQHCEDUtREbXQVIAk/mDVY=
X-Gm-Gg: ASbGnctWjjUYxIHxyuR25Aoorie0glcNsbY2Xgmy4VN0WHXyv7MS7kYXOrDpZM3jbLP
	Q/ZD2ptbyT0YjtxB/863BJ/VCYidlTYLLIbXRt5/oXjVsXgEOdXa3wnlUE7bh56CxH/ibCMb8Td
	GXxWJxy+0dg6+jG3i3eOhOKZQR+Ds0UWVRddyZUfG9MpHDZo/UTERwA9Q74I4tIFiNYsAfvrCpt
	Pf8tLbh9FZgE0tUW9SqArSozwTYwbX5yny1Ocm0714Tv2opbYKU4vABp2Hmh+DEfZtgF76z9D5D
	aKf94fgVUDV7RlX5V7Gg
X-Google-Smtp-Source: AGHT+IHLP8OH1Z1QeNaiSlUTemN7jGIJS2Nar9mOVEeblc7NbIn6Q7XAtdRIn85h57qME8hSGTvqHQ==
X-Received: by 2002:a17:907:72d2:b0:ab7:e811:de83 with SMTP id a640c23a62f3a-abb70d9f420mr1759858866b.40.1739980364209;
        Wed, 19 Feb 2025 07:52:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbdd78ab59sm122018766b.74.2025.02.19.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:52:43 -0800 (PST)
Date: Wed, 19 Feb 2025 18:52:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <381bcb3a-9453-4d19-93ea-3608d3dc5ac9@stanley.mountain>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com>
 <b44dc8f6-7abf-4168-b96d-54f1562008e6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44dc8f6-7abf-4168-b96d-54f1562008e6@stanley.mountain>

On Wed, Feb 19, 2025 at 06:43:52PM +0300, Dan Carpenter wrote:
> Hi Catalin and Yang Shi,
> 
> What's happening is that we backport the latest kselftests and run
> them on the old kernels.  This is a supported thing so kselftests
> are supposed to be able to handle that.
> 
> So we need to modify the testing/selftests/arm64/mte/check_hugetlb_options.c
> to check if the feature is present and disable the test for older
> kernels.
> 
> This is not an issue with the stable kernel it's an issue with the
> new selftest.

Gar, nope.  It's me who is wrong.  Greg is right.  Why is usespace
triggering a WARN_ON_ONCE()?

regards,
dan carpenter


