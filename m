Return-Path: <linux-kernel+bounces-304786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320D9624D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969B61C23635
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B7C16A94B;
	Wed, 28 Aug 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYDW5o9B"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CF86250
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840718; cv=none; b=Ruad/tJiKoXeJkVzfETKM41N0pQt7h28qA5ckQak6koAKem5O4vi4nNlY4wCM80joq0dKqEk1Cy3ULdA292zD95TZ5wOaDf/mFdOzDTtFMubqOCJIXbX0KSleaov4MUcgVThTg1+RBk/U80Ph164m/JhyLNvBwYgpB5QPRrEi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840718; c=relaxed/simple;
	bh=v2U9Jvrzu8FM9RThS8YhoqSwZg/ytfc+nZ8NshoJWOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpjfNi6gYxg1g3KH4KJHSbH41wPgVIKYuAzS8OfKs49h2PKhHp7KH84fhSd6FYIN62hxkbhFFD2a4T2SE1fkD+xXaeEAbYclvDmsDgnxiR4ntROUyBPJf8ul1yNazTFyxqXaorxdEnaGov702jy0O07v1Nn4z8dyWxKyOFPoRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cYDW5o9B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428178fc07eso54713785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724840715; x=1725445515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Lzp4oHGEN8/PxMaUUHsZAh0vkNYG+xd0zc2zsHZgl4=;
        b=cYDW5o9Bd60MfRLwCNGLOVJJpB+dZeO4w6vLY8vjxhPqm4HOGD20vgoExsbYtNfm2W
         soSoIe0VTwFHJhR1z3YDXIahmUN9QjBvvhvPJckjlW2zBBTX8GftZuyZ0o6ezAvu4h2n
         BmNPuNk8x46bsSTvnpZgBbjZIDAQg26lQNJslwglM2jeXpdrdbz/KnO+upeEZJJ5/SHG
         DgrTlGhX3IBFb67b4SsN4wXRl8lz5V0ZZ+GbG4JvVjZ3UKdnTU8+5UXLSiZSzHPeZWPD
         mTjPk+ALf+GCyDKfvBjNugH1EWt7akYpqhFI08/ET8QnwlzfBiLhqxZ8G8653qmWKryv
         VvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724840715; x=1725445515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Lzp4oHGEN8/PxMaUUHsZAh0vkNYG+xd0zc2zsHZgl4=;
        b=nti3biBBzzIoWwfHO/zX0NzpfzJLiAq27ZB4/NSx4sVaNgmZyF4g2pSrQTKb0OkhhV
         vX7bKdZ/9rNGGHBHrdUVyBI8TtFrraiwPxab5O3uPHPDW9Kp6fO+/sJ2eGCdtdvm5O7u
         QRDBwHaZjdeeR3Uc4YoYBZUUczATItDZPYXoHe3mKa+oHgzJ4drqrCYjjdz8DzEqByeF
         scFMufLgi3qgGFIWlHIXUvw36xUrl3LfcENki2mmVUHAjbS0gwXh/mBrTPVIWSt49XNq
         kfdfINjh6fIocF5Uv/sOnvM9GX6xuyKb576pT9SjF+G8sQ8hLt8Z+5fwtEaMa7ICwAHA
         NgPw==
X-Forwarded-Encrypted: i=1; AJvYcCXhmE5h98FZe+HWwTBVqkyyzXGRYizGzLGlyGU9YVxGH0msxaFs7JjaLhJw/kqA4ScrFoZCFaOwTBbQIqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mzc32W21VkSJLwhMxwNz+UkLXJYKQKSxRmq53PtAZqV5H+xb
	jaDUjfVpomzWrIVa3Y6t+mUWl0mCg4X+ZcGRpiNOBSNELQNsNdWYwJ+t4KgUJd4=
X-Google-Smtp-Source: AGHT+IEp4R0TyxUVAN/DCult+Gly4yNrgEo0qXCuWLCZ3cQk3nKdUAD4f8ccgCbvcdHUOkn0Xldt1A==
X-Received: by 2002:a05:600c:1d0b:b0:426:593c:9351 with SMTP id 5b1f17b1804b1-42acd542a3cmr103707135e9.6.1724840715323;
        Wed, 28 Aug 2024 03:25:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425a82sm17164015e9.44.2024.08.28.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:25:14 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:25:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: vivek t s <vivek6429.ts@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Rename function SelectChannel()
Message-ID: <2092a3f1-e319-45c5-a33c-3f271e70785f@stanley.mountain>
References: <Zs7vQXhcYRCxCDaH@victor-IdeaPad-Gaming-3-16IAH7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs7vQXhcYRCxCDaH@victor-IdeaPad-Gaming-3-16IAH7>

On Wed, Aug 28, 2024 at 03:04:57PM +0530, vivek t s wrote:
> Rename SelectChannel() to select_channel() to avoid
> CamelCase warning from checkpatch.

I wouldn't have commented on this except there are some other issues.
Line wrap your commit message at 72-75 characters (similar to email).
So "CamelCase warning" moves to the line before.

Rename SelectChannel() to select_channel() to avoid CamelCase warning
from checkpatch.

> 
> compile tested.
> 

Put this under the --- cut off.  (This is the real reason why I'm responding to
your patch)

> Signed-off-by: vivek t s <vivek6429.ts@gmail.com>

Your signed-off-by is like signing a legal document.  If you were buying a
house, then would you write your name like this?  If so then that's fine.

> ---
  ^^^
Cut off line here.

regards,
dan carpenter

>  drivers/staging/rtl8723bs/core/rtw_ap.c          | 4 ++--
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 4 ++--
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c   | 2 +-
>  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)


