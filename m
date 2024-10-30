Return-Path: <linux-kernel+bounces-388753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056E9B63FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4E283003
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842B1E47BC;
	Wed, 30 Oct 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT/q1EmJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A017579;
	Wed, 30 Oct 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294634; cv=none; b=nX6QE/QUeCBymzBJOc6/tiwOI89x4vHY49lfAUKD8Ld4F4WXCyd3NcL6oBHj9ZhMzqJ4c0WIwl6tY8Cf21Y/TgzjzMINeMXTyCHYkkAklvuM3P433jx87Ap8C6qZR511tn7uMpmebUb6rfZaP4G06UKOz46Pm74Xez6tD1YL/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294634; c=relaxed/simple;
	bh=lzXY+yCdfPlj98msG/MiyYCkRskAcL9FLvH7GLyCceQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ5qTCaud5jTHnWlMEv9aBPaoKRiM+KXAZerbBe9RynceW6+IhNsW7h13TjJVAAL3cbDHoVTCnTs+5DZl4teUFtfsDtlK7eBVqdWUca7lzKHYCFu8X+JqKMCm/dMM9SF2IHy1C6v32fRm0lJsPLIlYowmu3N0HTLZJzvbLaT2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT/q1EmJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdda5cfb6so64191065ad.3;
        Wed, 30 Oct 2024 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294632; x=1730899432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oRByv3KDH+KfzMWMhdV9lilvV/e1T2nv/m5OlVLfpWk=;
        b=HT/q1EmJaDNbK7aoWf/iF+kL6065daq/F2ur2Cd5kRwHIJ1vEXN8+Hiui+4VwP5rxX
         e3sQdMWB85YPUY+raXgEnBySRkmIA8F1mhFotHCi7LtVA/lS64SXyQzzOdACfK5Qv/E0
         q6SMu+FNknSOoA76yorqeZsHd7h1TKx5IqyI0hH+dwUtHMM4fB1adMn/JnHivHsb3SWn
         1gjD2Bd+b78+iT4MLD2w/s6rWXQpqlvns6u7W1TTBjkFM952sZJliXukPEZfoYN0z+8f
         KdtZUtDyBVV1m0zrmFFOZCcaFWxmbraZqm6coO+IizUEZ1cnr4/vbO8HbbZJ6OONuXOy
         LeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294632; x=1730899432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRByv3KDH+KfzMWMhdV9lilvV/e1T2nv/m5OlVLfpWk=;
        b=XCFS1jJypxrmVhLc1Fn3nB/5cpkwEbbL7BX/++3mQmSLynFYRuawNBabNt0KDrKYfH
         0Wgrmh3yNsJvUGsXaNYv9WvgaLv8sOU31mu6m32e2DDKSq/AtJZSS6qicCoGuSBfCmpn
         8ComyZ2Ogh+kYNGV2PuhAKS+uWZNKiFP3Fm9gecpb7MznJv0SYa7Ha7ZvvRPNjPxSzN0
         f1f9Ra2zv1Bm6aIRBBniJyXHsQFQN7Qk8Cl7YkepsDP0rCq1gceFdjvgTHwpsILtKv45
         Fn6c+W+9kaF3wUwyZ9F9KedHZm7k2E4Pr8TWo0fmaCRDp4wpVRqIql4Htfc80g9bTQ92
         ECtw==
X-Forwarded-Encrypted: i=1; AJvYcCWVwDo6We9f4/9xQyg0VVT5S1CqgERLaj4ISNBdYWv51lzIA6dynPypF9BKboowf0oZnhrc+6RP7f8m37Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8oasDH52PRGpa/YMMFITNBILpMOybYBMj7friUZ/i6XrwFA6
	AwPCPOrJAFmpksCFR7xr7ZNWZnjNw37C8UFjfo9cz1kTDglX0Vn0FsLF1w==
X-Google-Smtp-Source: AGHT+IG+3ttp/NbflmcNwKhussepwCYakjMESjT2qsF2VXPxHu/n5KcWVuYMA56fDF4iIrgW5A85Sg==
X-Received: by 2002:a17:903:946:b0:20c:e6e4:9d9f with SMTP id d9443c01a7336-210c6cd38eemr228013225ad.40.1730294631691;
        Wed, 30 Oct 2024 06:23:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc012eeasm81646845ad.172.2024.10.30.06.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:23:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5d037bb8-6e59-4da3-b8c6-b199c102fd31@roeck-us.net>
Date: Wed, 30 Oct 2024 06:23:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] docs: ABI: Fix spelling mistake in
 pretimeout_avaialable_governors
To: Colin Ian King <colin.i.king@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241030102624.3085369-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241030102624.3085369-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 03:26, Colin Ian King wrote:
> There is a spelling mistake, pretimeout_avaialable_governors should
> be pretimeout_available_governors. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/ABI/testing/sysfs-class-watchdog | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
> index 94fb74615951..70eabccf0557 100644
> --- a/Documentation/ABI/testing/sysfs-class-watchdog
> +++ b/Documentation/ABI/testing/sysfs-class-watchdog
> @@ -76,7 +76,7 @@ Description:
>   		timeout when the pretimeout interrupt is delivered.  Pretimeout
>   		is an optional feature.
>   
> -What:		/sys/class/watchdog/watchdogn/pretimeout_avaialable_governors
> +What:		/sys/class/watchdog/watchdogn/pretimeout_available_governors
>   Date:		February 2017
>   Contact:	Wim Van Sebroeck <wim@iguana.be>
>   Description:


