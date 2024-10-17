Return-Path: <linux-kernel+bounces-369475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B29A1DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40184282AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9C1D86D6;
	Thu, 17 Oct 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6RJh0TK"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0A1C683
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155668; cv=none; b=hHcTqJySWk9W/2GSFHjOQp1/7BSaO3SUpNVTRyibrqjtfXlKw/dGC7tcLkzQUE+ZUmpa5HwL/5rONlmfS19388hkLEgDNVRnIeFp/KYpGJbWV1mrMiu9r+JgUCZmpP33hRO8Ra6rLu11c/2+pxzJ3KK1OHdfzMZemD97+4FLHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155668; c=relaxed/simple;
	bh=PRJy7kpQyQHQa8WGN7JBUsnJEu2pWPYsxmv+GA6Z7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkO5w/ppx/esuOpKq4URxBS9POWR1/HpJ4tGrJ1EJwuN8v87kSICYiixRs07AOx/dbRDbD6k/8Rwj4yfks3KXcOeSuF7oHRx575MWseGtJQcYgkFxTP0jjHjzD/SH3D+4ydm8HFNwKXkEOppOJ2Ojx82smleFgH8kql/pErhGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K6RJh0TK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1285856a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729155663; x=1729760463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6aGvl/8M/aufRUPMsZdP1oi2gwHcXIgNS9xwjweU+s=;
        b=K6RJh0TKp9lUS5wonCEo3eQRu8aT0M8YQu2zfuetyZZGjGzLD2iwCZH047A7ReWChS
         fJdLY2McnFnFMD4EplTf7WlkTmfekWM1lDeYJHGut7PYyaeumfDDRazQjI3WNIJchV8l
         FTVHYyWIMm7VJBVuiS3WXO5NNHSAhhcsJHTlzP9D5+iLCGXLI9oywW48FKFjmGym7b/L
         9qTiANZ/R+5P5ZxYPZZLE5sn4xuqRgOBaCrSztdaGziajJXv9rVnCL8pJnFRC0twzG4c
         cm47Hq1R1/06H1plL2gMuUPHmePgSjwrRsuUaKCQhAyh3sXzWxaZA1gYcFb1puZtc923
         9FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155663; x=1729760463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6aGvl/8M/aufRUPMsZdP1oi2gwHcXIgNS9xwjweU+s=;
        b=omNSesDMzM38ORc/HmzdvEqDo3mI22oDaqlw3rj7E+51Sws6Eykka/3BEz2QRpK+3B
         jGpYmHs/4qkmMeiSeOMNBCqELCVry3GndeQMc3/u9NMqjS6lRqwLPvYlRTmb9w+e1Pxw
         Sp65Vx8zkHra2SXc9E/U4fQYFvzR3HgqlDvsALPSjPxGZcUQ8NjIT5YvzHiZUMwmwaav
         Lab9P2mdqsBAjMOro6KDS27b5aAWUeEPFTR86AcvGtl5kyVfqqxNkQk6uA5My8D4xNYa
         rwWwRIcnNcufok5FDqVXPmefE5JfU95Iu6VslVjPSHMgXNxeRgvvX+0a8i3tOpoGnDP8
         SecQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOBdcRcDdFi8330lWjMx6ISnGs6peiuuOhLMs5CLO0h+ZW8Yi1IyzuS72P0C8wDHQlfNZEKgM263UGTtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCXt100BGZqgtrhvEv6quE0EnBZMtKyRJplVjEj6LeMQsZius
	OEdNbK2PNKQrz+/Ztdv5v4PvBHsNlb8lQXjZ/ES/E1Bimy2rzCZgDHuSJH4thrc=
X-Google-Smtp-Source: AGHT+IGSXyeHyslIg4MFh3k+NuDIEQtRyjgZZ2B7sQlpZ+zhsl1ze+Ey7jIpBlerPmTut/kVntEp5w==
X-Received: by 2002:a05:6402:358a:b0:5c9:72c7:95a2 with SMTP id 4fb4d7f45d1cf-5c972c7986amr12936905a12.22.1729155663454;
        Thu, 17 Oct 2024 02:01:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d5298d1sm2525207a12.57.2024.10.17.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:01:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 12:00:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Change return type and error code of
 fluke_get_dma_residue
Message-ID: <85cb4aba-60ca-4fea-8d1c-dd01578357b5@stanley.mountain>
References: <20241017082022.16874-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017082022.16874-1-everestkc@everestkc.com.np>

On Thu, Oct 17, 2024 at 02:20:22AM -0600, Everest K.C. wrote:
> fluke_get_dma_residue() returns unsigned int with -1 as error code.
> This error cannot be caught.
> Fix this by changing the return type of the function to int and 
> returning the error code, that was captured.
> 
> Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---

So like quite often we would merge a patch like this, because there's nothing
wrong with it and why not?  It's a step in the right direction.  But actually
in this case could you fix the caller as well?

Do it all in the same patch.  It's the one *whole* thing per patch rule.

regards,
dan carpenter


