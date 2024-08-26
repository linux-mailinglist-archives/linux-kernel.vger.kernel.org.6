Return-Path: <linux-kernel+bounces-302219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5DC95FB42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35555B22D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937F13B58F;
	Mon, 26 Aug 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeNyOaDL"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACD19AA63
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706575; cv=none; b=G0WzUxmAo1VJK2U+XkUiXXuRKMDdReZ8REfANqRd3AwHpw3SiqBN+izbXPgzw5AEHPIbRVPa/GqlxRbd8BBKT7mftqJBxBgr4MqekjNVLeAbK6CRei4UMA7JbgHtpn0eWrq5rj3Gsv3S3hHn54A5XD9XCm3lWkjrJCqLw+y9+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706575; c=relaxed/simple;
	bh=vAw0jhnjl/TBb3fjv71HUyK8CMWWWW9nwcU1zAgdAQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BN+CTm0gMkKJBh0M0KDF65Aoz6ptEBeCdOiFkRrZbcYRuP5lKJyWV2gw8yFh05LUKhsIKDo+8toGQq7dHi9s48MEcSPcBhZy/lgdp2J8PrTaC6S0SrMp7XOQEzLIWNxvdbf2AI8+RedVidMVbTQltVCR6c6RJb0zhzP7b20owkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeNyOaDL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so5617898a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724706573; x=1725311373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maYmRQ8BUA18ToixsUnE3Tx/VOkcQJLLFkI/iV7swC4=;
        b=SeNyOaDL0RyPMu1iBrmnK3rRVNkdWvNzygKHlPknj1MUaMLU7pztYwIkhPyoJ/oBY7
         XepCN8EVPfygjWJxLHEUzdXWl19ebm1JLxIj2wOjgD/XJa7TKC5sIeV5Z+sJSNJoMWlu
         PNhcPQJpKgjlF5Hh+jdWmkq3n3gRAsqEzm95ugH16TGaZMEPMNwDbaCtivSLzuRHHMLN
         epE3Gp5jo5f1BGjPehkURkp7hTwcAspBIF30t2HYC96LJtp9D7nPH7CB9wNh80vsNcLv
         O1moe62WxVndLGfCuO1JZiRWBzjzTTH+PtX1pQ3nq+f8emfWT9vtO5X6Ktrt69K5zmk3
         SCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706573; x=1725311373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maYmRQ8BUA18ToixsUnE3Tx/VOkcQJLLFkI/iV7swC4=;
        b=E0Nsw5LO1TK4aRrWcPYoLAKrrHYlni2u3E6XAwZqciptiSfcH4nM1T+lQZwZdNz+Te
         fUcMQrvK9kIS9zPPNebdRQbFFUK1N8eWTwzi5wU7miHilO4eT42+jMV2x7Mo4sdg4IwP
         hjhERjuw3peV0exSRpcfNjT62JvYvS3FWOVep7tRdcxgHlHQUB+/5g1GT9ncCUgunUDZ
         fah2/bmfpLQGjMObcY/JkUXFraqhx3pMHQbSIRVXVfH1LsvY6gJbBOnOYM/fvqLYJRbh
         dsygEVQC39i0rTKQZY6pRKzuuJtQRPAFTw6QuCNVl9gYigkSz9CbB0sS6E+LowoJ/fBt
         Oebw==
X-Forwarded-Encrypted: i=1; AJvYcCW2CADnSWDwy/VLYUW8av9SQ9ySu3ysctNooVImuovRXnEZmGN9l1i6QRImtUBC9pd4eyfC0tEzZt4V+I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnnNAc/uIp6ZJ8+LF5gaBY3IwkzpX84oJG7RoO4nzR0tYd65/
	APNoN+pqDt0sxVJZZfHfR57sq3/CGwRQ55jHZhF0gyv6PeI/K6TF
X-Google-Smtp-Source: AGHT+IG+7yLIOwVvVVsGb2VMIvAi7E4PP/ggkMHJBEXY9FiKZ7RaG6OiSVf44W72QVjbLF6feq6mkw==
X-Received: by 2002:a05:6402:524f:b0:5c0:ab6f:652a with SMTP id 4fb4d7f45d1cf-5c0ab6f6697mr2751761a12.3.1724706572335;
        Mon, 26 Aug 2024 14:09:32 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8502:42e6:b0b2:a0bb:dc32? (p200300c78f2a850242e6b0b2a0bbdc32.dip0.t-ipconnect.de. [2003:c7:8f2a:8502:42e6:b0b2:a0bb:dc32])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb21399bsm195339a12.50.2024.08.26.14.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 14:09:32 -0700 (PDT)
Message-ID: <16df34b2-4d9e-43d4-9176-dea31d58ce2d@gmail.com>
Date: Mon, 26 Aug 2024 23:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8192e: Fix parenthesis alignment in
 rtl_core.c:325
To: Gabriel Tassinari <gabrieldtassinari@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ~lkcamp/patches@lists.sr.ht
References: <20240826195915.8494-1-gabrieldtassinari@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240826195915.8494-1-gabrieldtassinari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 21:58, Gabriel Tassinari wrote:
> fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
> silence checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
> ---
> v2: Include the modified file in commit message
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index ad21263e725f..18739583f579 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
>   
>   	if (network->flags & NETWORK_HAS_QOS_MASK) {
>   		if (active_network &&
> -				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
> +		   (network->flags & NETWORK_HAS_QOS_PARAMETERS))
>   			network->qos_data.active = network->qos_data.supported;
>   
>   		if ((network->qos_data.active == 1) && (active_network == 1) &&

Hi Gabriel,

I would do the indentation one space deeper to show that it is included 
in the if (
-                  (network->flags & NETWORK_HAS_QOS_PARAMETERS))
+                   (network->flags & NETWORK_HAS_QOS_PARAMETERS))

You can ask the question why I did not tell you earlier... sorry I 
missed that and I wonder why checkpatch did not catch that.

Thanks for your support.

Bye Philipp

