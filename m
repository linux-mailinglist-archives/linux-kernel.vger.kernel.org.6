Return-Path: <linux-kernel+bounces-538554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D7A49A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F341888A07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569626B96C;
	Fri, 28 Feb 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/cro2no"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B22F41
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747858; cv=none; b=Iv8hcAEALyqGiBqa1AXZK63PsAXefQOCkD7+wR/dISbuIrhB1+khRz91hWdyT9EJCB87iJyWpQAGkM/5xVApiA669uxztwJ40a8/vcyfXXzO7SfZHsGrlT4xXf3B9zze9/lRWKJvRB3iDhU2tHEEdNakRdu6ozzXmV2MqAuraa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747858; c=relaxed/simple;
	bh=VhPyMoEJWSHzL635uSgBkZm3dqp5Xsq94bQLc3MM460=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxnnVmUg9hgmUj+vWa0hsn2z56Sk189jIAA8xqr1IBt9N+dFIEcB3GxO4bpdBo4k2qilFYSDy6Wp/RH7VpLPU5TtSR8NYNEwdC+bYw6mSQ930dCETik3kgbVtbNXUP0RoIB9c3NPEdLKKYUpHF/4lW+M3ntvWI9u6cJvfeO/98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/cro2no; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb86beea8cso377140666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740747855; x=1741352655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10Fkhp5xsWvMhzDZ9Hnkhm34939uK3s6cg26798CuOw=;
        b=q/cro2noUaTTqpexN6t86qhlX7eBZntO2OL3xf6hjUUA7x1l+DBXMWpcsrPX0WrKXX
         y1DZeespD+Tm8P618HqS7YwoK7162gR6V+cUnJiRCKrtHv4ZWE9KUsizpNiK488rv1Vt
         6FqTS7NSlBK0aUMGIERJ1Ur2sjunPUOdlglO/8RPUzXPDm316dtr/ccbBAF7jv2v2EcM
         3+Wk+6oBC+4hyWwP/TixxqmnIvJlvGrJttt5OIPSLEkuhhxcAdoUwhdDjED094hk7fap
         MQIjpS+9N09Qn3chD1xUrJ0yUZzqB+rXMtVTmbD/V0Q0JhYYjcPuCaTVqmtCQTawT7C+
         8doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747855; x=1741352655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10Fkhp5xsWvMhzDZ9Hnkhm34939uK3s6cg26798CuOw=;
        b=floZQEFMyRI1+iJGfTvg9ad9Zzf9J46qk+AXHSqC9cN7QR1l8B1JOpSR6Z615Inpu9
         cO9HOEgyxk2JO4vQYTrGXuPkdsE8d7jT4G0rzDMvLkdZMyzXAgItyM9qnlchkNfwX244
         vZMe6WgbC1nzPN80yX6fCvy4aehBF26ucBpnxWZ2CbSIF7P7yBNwmg8RlDclRJeBNs5K
         SJOTqFj0DJ90dgG8beB2pwYYovMMAdi+04zu5FkKm2/BOB6hEVV9GYaMJSSFPNCwZMVY
         VQjqwXijt6FgnXcotwYnKm8hVKFxWV5AFHJSndptkcv8xWv1dHukWHZwpbw6KkVQZLKu
         ABaA==
X-Forwarded-Encrypted: i=1; AJvYcCUXX2qjtorTxlZx5yUEz6tI6slwm7HGDeYopcj76hGtBG2CohC4Nyv9/MfJ46bqcidOhBGAXPrUr4nyKFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxycKVE6Q05BWBqOmDl2OCzi2CIXZCF6JolzfX7SBRyaYkT6fEL
	7uVcecMnOhKZ2dEGPrsQgLCaMwIVIr0GxbBlW6Vj+QSpGbISCtfdeZvYMH7JKCpbh0bMfzpQq/2
	w
X-Gm-Gg: ASbGncsbP2pyw0vbYoRdCdL8VE2ZcGi2tGnDnGMPVmBmIMV9n1HcC+0cU+yE5rXsKgd
	9LhHIwYQ6wW7kNy+Nbc96DoBpnLmySRqu6ZBcihrDHYuvBkemz+uwNANUlK9JLf/0L5B8XCGx33
	kBPIpHYlekRBZVysaN7Ru7qMyfnloWZExxtxXLGZA3rKjO5g+5lfYKEEnlS7GOkp5wXfypk7CWU
	eirUext6vANS9kfqRycEe3yIDhtqWaH04M1T6zvb3tERQr4V+Rp4HP1UJvjp1JEc3zcPvBLPk6a
	bPgUIp5BeSPCri4dLqQ2dbso1PomZUw=
X-Google-Smtp-Source: AGHT+IEUt1hmwix/p/NTJLkhDfTeZ90IH3mBi7jSL6LBqNJkRYtj0rKm6mJr2PdW+AYQwRFhzgJHvw==
X-Received: by 2002:a17:907:3fa7:b0:abb:b31d:778f with SMTP id a640c23a62f3a-abf25fabb6amr318360466b.20.1740747855227;
        Fri, 28 Feb 2025 05:04:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c0ba408sm286438866b.37.2025.02.28.05.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:04:14 -0800 (PST)
Date: Fri, 28 Feb 2025 16:04:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] [PATCH] gpiolib: Fix Oops in
 gpiod_direction_input_nonotify()
Message-ID: <084aad2a-83ae-4027-a934-797f53962256@stanley.mountain>
References: <0f3ea3f6-8ae3-4352-b790-de0642edc4a2@stanley.mountain>
 <CAMRc=MeF42NeNJ_kR7H7oJsCHt=grTtN=c-3RbjFhX=uRQ5X9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeF42NeNJ_kR7H7oJsCHt=grTtN=c-3RbjFhX=uRQ5X9w@mail.gmail.com>

On Fri, Feb 28, 2025 at 12:06:24PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 27, 2025 at 9:17 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The gpiod_direction_input_nonotify() function is supposed to return zero
> > if the direction for the pin is input.  But instead it accidentally
> > returns GPIO_LINE_DIRECTION_IN (1) which will be cast into an ERR_PTR()
> > in gpiochip_request_own_desc().  The callers dereference it and it leads
> > to a crash.
> >
> > I changed gpiod_direction_output_raw_commit() just for consistency but
> > returning GPIO_LINE_DIRECTION_OUT (0) is fine.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9d846b1aebbe ("gpiolib: check the return value of gpio_chip::get_direction()")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> 
> This doesn't apply on top of v6.14-rc4, could you please rebase and
> resend? Thanks for the catch!

Sure, of course.

regards,
dan carpenter


