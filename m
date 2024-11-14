Return-Path: <linux-kernel+bounces-409139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2649C87DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B8A285ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBCD1F8935;
	Thu, 14 Nov 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhSTtYbf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A41F7097
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580831; cv=none; b=epEWcYKngsanIyWsRH9Gy+MrkOSokGFMgMkd3JdSwEyLcTDL0xvUoCaYnBHHTwcHo6U39JALYtU6ajrtzLols+zziC2gAcajPruQ/LO4zBQWtmL/7nVpJsPTmZ/u2bEQof/xgXql/j9hMydHmdAEHMiBAteEXQOdxJmKU0zPUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580831; c=relaxed/simple;
	bh=9AkKxEVBb49xweTPBUktV/8NfSLDBUfWsHDMby19RI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBdhP6UXo1aHiPbkdqPaNls+3EghHg3Mzny3gDhe+tVaOLYEX0ecblTJCXZuHsmtIdRyq4Ohmnu57hBOcC70qUAVUkmoW2E61vbEAR6N7yrJiGt0mLpzDDflxz0WRbpfC2sKZU5ELXCTO90ygZnCWGuKWkET/rsqfv4dASoFfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhSTtYbf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431688d5127so4217405e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731580827; x=1732185627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+KWyQHeoGoqflE1crVxP4Tsix1+zwZTB2zJKsiob7s=;
        b=nhSTtYbfCPId7ocJhieFoJDInmPxbpJ2uUhzld1Oe3NSUyWXPwV3l+adf5ShpXd6hh
         LaS3kzksBimJLXqK7MZHQeo4/z3HbE8/eLQU6WXj44QSU9WWDrfcjJ/EXJotACfT2VXs
         A1xe4h4IZBLzl8cl6qt7orOhD6XSR+/kg4CFx8wzXvQk5SLhNJoKARP3SGQujSF2Xn6V
         /XKegelz/x43vL+Z5ZXEU6e2hSBmO2H+9p5x8kCSBj/edLoyrSPmCAcJZIkAxTjLsrKL
         NNUmRma6UVJmMuLCKpFmA1tGrOU1JkzSK2DFJ/W7SGSd7rebacWSRp8JG3LJrOrC61z0
         qs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580827; x=1732185627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+KWyQHeoGoqflE1crVxP4Tsix1+zwZTB2zJKsiob7s=;
        b=MAEwSXTf97qyjDUo2mjvFrSnNaTvvbmKxX5aLZCtgtlA6X//tNP5207+9yYDLGw+UU
         F98SSLN5KdCtdrDJJn6pkn/vUWL9o/2D2gMq4zh1yZV/S7jecdXhQMhhcs02pkR0onTo
         gUZSmFfwubT9gZmWh/9FsmZtEPqbtMxYBjNrrGW76K1aWaTIi7LpPN+E3CAtb2f6N4eH
         V+6RCHpZnQQJae58kuffkhk+iARLRXYMtHPu9jS7Xo7dGGZ84cLsE4mBTiLoMNo53rtc
         LgTGr2gHbMOWyz5zkPFR334HXfLd2T8h0pkOnup60KeZ7/tJI02M6uXnGvXvZeBnoTgR
         0yzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcj5LSX+upQ1397ikeoPKxSmhhVcWZ+tA/e2I/Xf8FQOqeWeQTCul1/s3U28VsxvPxFATdoGyNHd74lh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqEYHlaci5LcXpWZgY4/1brRDRztffjm3cq9DJ0fIf2ugTh0H6
	uNNF3iXml0VN11/Dx97ZToi1gmmO9BOE5SGDijCYDqGZAuBqYUAyuZY6ywMmAp+R5hTyTmcPJFJ
	p
X-Google-Smtp-Source: AGHT+IHL0UzLkSLa2ICsA94lpf23MBJB+9BtCC/UgPCLuU8rRMTvtwPv3tETm2V18Af40d9WXc+dMA==
X-Received: by 2002:a05:600c:a40a:b0:432:d866:f45e with SMTP id 5b1f17b1804b1-432d866f646mr34209595e9.33.1731580826996;
        Thu, 14 Nov 2024 02:40:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298760sm19010355e9.37.2024.11.14.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:40:26 -0800 (PST)
Date: Thu, 14 Nov 2024 13:40:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for
 build_bug.h
Message-ID: <a2ed9ec0-4909-44bf-be11-21a22789e1d1@stanley.mountain>
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114101402.156397-2-philipp.reisner@linbit.com>

On Thu, Nov 14, 2024 at 11:14:02AM +0100, Philipp Reisner wrote:
> compiler.h defines __must_be_array() and __must_be_cstr() and both
> expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> So far compiler.h lacks to include build_bug.h.
> 
> Fix compiler.h by including build_bug.h. With that compiler.h and
> build_bug.h depend on each other.
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> ---

Fixes: ec0bbef66f86 ("Compiler Attributes: homogenize __must_be_array")

What actually breaks?  This commit is six years old.  It's weird that we're only
seeing build breakage now.  Or did you just notice this while reviewing the
code?

regards,
dan carpenter

>  include/linux/compiler.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 4d4e23b6e3e7..2d75e4892316 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_COMPILER_H
>  
>  #include <linux/compiler_types.h>
> +#include <linux/build_bug.h>    /* for BUILD_BUG_ON_ZERO() */
>  
>  #ifndef __ASSEMBLY__
>  
> -- 
> 2.47.0
> 

