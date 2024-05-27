Return-Path: <linux-kernel+bounces-190171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB88CFA82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B711F2192A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4F3A1DA;
	Mon, 27 May 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtS4Lh/I"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C424B34
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796260; cv=none; b=sDLMao/pVoKqGS25UtpUvcg+W9tNmeQSaleykr8DnAi4rVam/JtCiNbiEZmJoUQw32lXbA8E+0QYHOPBGUQL3/LC9X/YQvceS/2fyyKTkTlqLzwOAEwfUaYYKr8ns3/qXxtztNJrfKtlylmC6q6SYqw9nBRzeWXYj5I+n7/qKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796260; c=relaxed/simple;
	bh=/krQonlYmbw1sOAOMQ2N1SXExQJOfJ1+7eOEm+fnXnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw8J6qpzO5o5e3/dmtA6emj0cvSjgUSV98YnmWbLN/C1cVwuV0dJvLI9eZJ1fwuKN4DjuAvZxF6kO/t1j9Dq2qJ9q8VEcVAlATZut4xHXvvudz9rNIDZTJT2Spd3HGtgmGrU08Jba+uhTPm4VRY7w03oj80PEfQ6hIBLVTVqkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtS4Lh/I; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354f1cf2d3eso594340f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716796257; x=1717401057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pBJCfU1EMiwbwjvYVHX4+y6MSOaDGyPtDJJSN/EFcc=;
        b=WtS4Lh/IMWWfIfmSsFkqyXyqb4MuwfGX1z8JnI+0n/UrNwy67v4DkvzHsyeyXSfvFT
         CPSXHoQSsg0hSSxZ/BsN1TwNh3RhJ9NMzDkdHzs78fW4Sj2lKcI+K6OJH0OgEA9RH7O1
         d8Tc/wiSCviZHL0wjww4cabWhEFr5dPgqEMVTi0695+Ex0dN/4NpJOtOGzRu88JL82k4
         DEtkYCIGSoqsCdarjkcjC/OR05xrw+eBMhULVh5FcGedZhFOM5DQPYcRrzzcqUwAjN/C
         h3Z6fTFbyrzStE3tp8lM5B7f/N+CrqhS09JkN8FwWqTPcv36kXb/m3Z4+YOrUdFPvT4S
         FJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796257; x=1717401057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pBJCfU1EMiwbwjvYVHX4+y6MSOaDGyPtDJJSN/EFcc=;
        b=UNEPEwUdLaxHPo/D8kRkjZDoTXHYRQSBylp/QEUh19LShttVP0nOz3syr0IBkLox2L
         PRWBffmH61Wao3mb/lps5w0URJDNFPs5fBmOIf83WAssiiYKRaP3uRoyojjJAO1pZLiK
         o7+KZPmgyUZbW3oRyVihWu8lHNYXh6kdEuS9MnLWyz8bOSW+VDUSgi+4U05ABer452Fw
         Lz6yRcaGcYz/1Gfi+iqcgMWOwGAqultKVWa86RyqsZXuzyKCbwtfyfpbS+BqvpmcR/yI
         Rt8FM48V63Smqg3IMzPKIYw4IVnoBbrddK7DyC9hEXeQWSwknr5Svd9Ajsh/dRNa56Rw
         OGew==
X-Forwarded-Encrypted: i=1; AJvYcCVmwaxoLGSjXQ21Pg6sV9BTVF9gKyQV83OvbKX7Z0xpqTScmNMgHo+C5Jcp28TPadVya0riChK41RTukGDkPnooeyU+q+yRWnIhOpyr
X-Gm-Message-State: AOJu0YzEHBBp+AvKxa8YRURQYlAM6ip3Xl1dljjxn88Dy9+DuvTQsJZW
	4hztJhku8E3F8iM6Th467HdxcgFbvogEJlkbsLMkUnBabQnOZspN
X-Google-Smtp-Source: AGHT+IFFITWv20yApzO6c8RENiggymT4uirN2a/LQ4AiUTVW4jfuNKTjDnDnY1lxFcDigAzxvKlddQ==
X-Received: by 2002:a05:6000:a8f:b0:351:d33b:51e8 with SMTP id ffacd0b85a97d-35526c29719mr6479298f8f.4.1716796257095;
        Mon, 27 May 2024 00:50:57 -0700 (PDT)
Received: from [192.168.44.127] ([185.238.219.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35671d03330sm6762544f8f.64.2024.05.27.00.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:50:56 -0700 (PDT)
Message-ID: <7345af0c-945f-417d-bf18-33a4cdb66df0@gmail.com>
Date: Mon, 27 May 2024 09:50:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Fix spelling mistake in rtl871x_mlme.c
To: Roshan Khatri <topofeverest8848@gmail.com>, Larry.Finger@lwfinger.net,
 florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
 ayushtiw0110@gmail.com, namcaov@gmail.com, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240524154001.63946-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240524154001.63946-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 17:40, Roshan Khatri wrote:
> This patch corrects misspelled word to increase code readability and
> searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl871x_mlme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
> index fccfa0915a02..70c295e97068 100644
> --- a/drivers/staging/rtl8712/rtl871x_mlme.c
> +++ b/drivers/staging/rtl8712/rtl871x_mlme.c
> @@ -944,7 +944,7 @@ void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
>   
>   /*	When the Netgear 3500 AP is with WPA2PSK-AES mode, it will send
>    *	 the ADDBA req frame with start seq control = 0 to wifi client after
> - *	 the WPA handshake and the seqence number of following data packet
> + *	 the WPA handshake and the sequence number of following data packet
>    *	will be 0. In this case, the Rx reorder sequence is not longer than 0
>    *	 and the WiFi client will drop the data with seq number 0.
>    *	So, the 8712 firmware has to inform driver with receiving the

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

