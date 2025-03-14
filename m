Return-Path: <linux-kernel+bounces-560551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC9A60683
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FBC3BCA24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045064C8F;
	Fri, 14 Mar 2025 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bk9YWhzZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A717D2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911637; cv=none; b=pgOixsqr5JBN06n3eelTC/buGGY44rS2vOrTy4fhBiF1CNhGPNXNgWIGI6fw5yK/i9TYIRwXdZbVHR/tfbFwWN55mDs24Yr06dZRxBfPXG/EP/eaxOIsHZiC5WR4mRDlIhoIDtEtKQxHtecg1hA9VdEOU384Xt8cE9w8ZBomdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911637; c=relaxed/simple;
	bh=S5YjmPSadUARmwccSDcjcvFgEP5CfKEn0cJkIPybeFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppolG+EoW6JSRGwtoSDa/TybipqUhQyvRxZcN1R/SQwzNLzPhF//ezhS+sU7ccllp+w4BAawNgozo5w7DeWVX67Kqm+GpEXp+4X5xuyZnt3HGjj20GekDLjOuPlDLqhama+o9KX+3vdrHXX0ooLPOhHLwb+GB0ssWrvxRJOTBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bk9YWhzZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239c066347so33339935ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741911634; x=1742516434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKQQgSJ6pX+A9i14RTtMFH1e8UlSjoleXWfJUUAl0Zw=;
        b=bk9YWhzZD+4uzg9e5U9vm41+LBdIfHi2oP6vq9sYKcMX7KsEkwAcHu/BpZj+960OG+
         8HRCY6wGXrJcSYJM1D4s7vflTpyuynG0OWepheCkxLrK62PrLszL+LGCeuAjBzDKF8PD
         sj0OH9eIsbX6ngjm3K7Fl+ZvarBfZzyiAiXBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911634; x=1742516434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKQQgSJ6pX+A9i14RTtMFH1e8UlSjoleXWfJUUAl0Zw=;
        b=Y0AUtuHzJVeFbdeWnoDASA0PltNla0HdJdCnxYy25c+BQdHcB4V3GCcVHFP8PdQcAx
         XXn/FNg6wPJ1LCN+wtm0UVDaMYo1jYpPgez4JS4LSSzAEKFhvDQEYx+7/I+NZt6Kj8Cf
         tw9CvqISIMjrYzgcMgt+CjqCo/2fICTk0vYyVMClXfFb48VQgUjSx3ATKSYRF5sa4c8T
         WZcp8+y7NehOz9LPLnPfW7oDZcrSk8ATLaDLAFDOdPssisK+ARE492OxzU25IvbaBEiL
         7nMXLsJ5SZz/+iv2uGMbQuwqJ4wR5gcuh3gbeEDe/d3iweTvhjEavkK3zHNHMM3L9UlK
         5oeQ==
X-Gm-Message-State: AOJu0YyKgHBOPoz3AdIImTDT5b2R0wQR7vk7ACotX0A9a5RD0vJV5Czz
	mqarmP9CPfdHQQJArfQa/Mjtj4SjoSjQrSlUac7KfDwLLfl55val8Dauqh0lcQ==
X-Gm-Gg: ASbGncuiVmtBG0MSMjY+w07CdKWten8ra8YEh12hrCrVeJ7aCfWZDPH/xEpzfoZ9koY
	qtjLjmh3xasB+ZeyI2apvkiwQX+NAliAWGJdYtKjh0uXZRwBhBZoPWJu85dGUg5gl0tRXETJt/f
	gg9Ai503SFzYbZZqvuSb/IJlgYINQc7wNQxQIebPlRxVnU3pAKmet/CD6WsLj/HTPL6LvDEW980
	iGXnmY1BWAa6Fxn4kBXeALgxnMA8t1XZd/4y65nF2XxKRmvNPya6P7UVM9DJ7XDT6rzRpdE/Yi+
	+Q3ATZ7zZY0PWgE4M8cW2ABA3R3m0GJIZivnJrbDzfe3xz3UNvtUpWD+Yh1vBZrpaSg4NufFn+K
	ZYK3s
X-Google-Smtp-Source: AGHT+IFO4eHT7EMLxAUZQcUPLJax7b7GpW64YoD3Aqnq64qGUBHwbVXqhyOVEAxtzl2d2b/7JBsA6w==
X-Received: by 2002:a05:6a21:1519:b0:1f5:8221:d68c with SMTP id adf61e73a8af0-1f5c111720bmr946258637.3.1741911634454;
        Thu, 13 Mar 2025 17:20:34 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e4cd5sm1910573a12.31.2025.03.13.17.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 17:20:34 -0700 (PDT)
Message-ID: <547ce7ba-7042-70ff-8468-8e449be6fada@broadcom.com>
Date: Thu, 13 Mar 2025 17:04:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] misc: bcm-vk: avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z9Nd4AmgrQDiK1Gn@kspp>
Content-Language: en-US
From: Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <Z9Nd4AmgrQDiK1Gn@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

looks fine

On 2025-03-13 15:36, Gustavo A. R. Silva wrote:
> Fix the following warning by removing unused flex-array member
> `data` in `struct bcm_vk_peer_log`:
> 
> drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/misc/bcm-vk/bcm_vk.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index 386884c2a263..9344c2366a4b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -311,7 +311,6 @@ struct bcm_vk_peer_log {
>   	u32 wr_idx;
>   	u32 buf_size;
>   	u32 mask;
> -	char data[];
>   };
>   
>   /* max buf size allowed */

