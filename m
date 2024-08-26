Return-Path: <linux-kernel+bounces-302291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEAA95FC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B91B2212A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2819A288;
	Mon, 26 Aug 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtRfqOZq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E2811E2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709381; cv=none; b=c3t8wTVL+PuabHl2AOPGRCkrJ7eSWmx6NtIhRn7m/LNDUEN1CZosrs6R2oOGnug56nWQvM5vgpxdptehQlg18CM0DhWFdpcY0lZD+CWgXPfimUZOFViGOmFpztOPIbuT2NDIPpiJEmZH+3ZHLCgH0Ym3tyGck1zOTjlvCx+qepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709381; c=relaxed/simple;
	bh=z1V+5X4NGL8P1NP6M55Sd9QL6xANf8ThVPfSxOkr7z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7mGYUJ/657VRcWrsJDDQpGA88uLUoCszIkOFhuQyBZLjLlUgINtbvIkRuhwJLAlmrWoi/xDAEHjR2av5TA+alELYncy3cZQWsiVJdgoHwyI3BXcx89MwrnPlIbQrWUmpB93SqIpoEKZu/2TSxgSXFI9YTyhRl4M77SxjKjQ0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtRfqOZq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so6144701a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724709378; x=1725314178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6dUkFSd+S/BDDOrXrzqOyvghgGgxpTPpn+EU6Vf05k=;
        b=VtRfqOZqqzMvg73kjYj/Cd7BL+hdChNoPhaBmZ47nuZT9gN49hj//Vd6U0VIrv8UvA
         A0cc1ulDEaxhnVzDLlRX4zOcf1snuZjHyd6ElSV/d91vSxhytm/KqiioVWYfZ01lYj6h
         BTaezfbZ6EEB+eyvCQrtWJvZb+BxoYdChvDYpzbruw3dNhVXLhxApFdxzJJsfT32WOxK
         MQRvNppDruVlV3UCqrE7PnZjBFdB+nHnAn53U8AdyQQEmh7CUzCnDiV+yKPJd+6AGdSB
         5jXJvz9IekG0lOp0RZpp1oUrCTJoQ2Akqq1yyaOH3XhlYpWvhjupEdlxRiFEIq4cEVQz
         57fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724709378; x=1725314178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6dUkFSd+S/BDDOrXrzqOyvghgGgxpTPpn+EU6Vf05k=;
        b=Le+u9rgY824WwtSTITupr0WSiQvv8u5WGkBVYoPwWewgZdOtQxRu12RdOo+1KifjZZ
         dotjkTkVwER7NUtpUzDY2eW68Og3MgcJG03S5aODvyf8OO/Cpk3gWY2OkOr8+aQ0uwfI
         i6fuAn7L6NaVh0tMFu+hKc8/5VE/1CvAxoPq66bWy/PKTbSoO0A5z849SpAgsG7M21yD
         OQgcFen+POGY41ZM3T5ThrAQqLuwdVEVOOl8ZRU8gOeVxzd09D8Mpu6NHEFb2rg/0fr/
         HgK6W/7tc3V1hoSbg4Zzg60rW9gUjs8hUa4AHjVkeA/mHxm/NPBfdYS0TTf2fFYkOE8/
         exGw==
X-Forwarded-Encrypted: i=1; AJvYcCWebGX5JUWBMYAlwj3cHYwF4Ego1/Wpe0tvnvtuNHbrfVNFbydamwRGVX3XG/wdM9z5fNraU7e6Wdy9vww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6He5XI7tLgjz+2l+GMDXYfSfG0wJH1yUZotkh9sdSHCTRLG3R
	zVi5EL1K7x7LPYSqMmYl+iXu9mxEjUPOMxjIbo3l6n9uqcmmCb/wdL3RDd/8Np0=
X-Google-Smtp-Source: AGHT+IH9lzOnn4XJQWgQEf0R30Ms8zeYbDabfY++XhhQRNHVljlbOHdyOf7a8ZpvfBq7LfL1HjNDYQ==
X-Received: by 2002:a05:6402:1ecd:b0:5a1:c43:82ca with SMTP id 4fb4d7f45d1cf-5c0891a1ff0mr6491430a12.26.1724709378040;
        Mon, 26 Aug 2024 14:56:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4722b0sm231354a12.69.2024.08.26.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:56:17 -0700 (PDT)
Date: Tue, 27 Aug 2024 00:56:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Remove unnecessary type casting and
 data type of geoid to u32
Message-ID: <1e365b63-64da-4ad6-9fea-1026c55b88a3@stanley.mountain>
References: <20240826144430.50488-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826144430.50488-1-riyandhiman14@gmail.com>

On Mon, Aug 26, 2024 at 08:14:30PM +0530, Riyan Dhiman wrote:
> Removed unncessesary typecasting to int.
> Changed geoid data type to u32 because it will always going to be positive.
> 

This does several things that aren't necessarily related.  But it really needs
to add some bounds checking to the probe() function to ensure that geoid is < 31.

Here is like a life hack: The one thing per patch rule is slightly ambiguous so
when you're writing commit messages you really need to sell what the one thing
is that you're fixing.  But in this case the changes to resource_to_user() are
clearly unrelated.

I am going to give you the most conservative advice.  I don't necessarily like
to split it up this way personally but it's the least common denominator path
and we will merge it.

patch 1: add bounds checking
patch 2: change the type to u32 and remove the check for negatives that you
         will add in patch 1.
patch 3: remove the cast in tsi148_slot_get()
patch 4: remove the cast in resource_to_user()

regards,
dan carpenter


