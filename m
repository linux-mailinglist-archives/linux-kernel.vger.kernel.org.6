Return-Path: <linux-kernel+bounces-416692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A759D48DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5811F22F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB51CD1FF;
	Thu, 21 Nov 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxjxwLIL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65041CBA16
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177719; cv=none; b=IWnIx77oCgC0Otg+n23f5v19pIcjxnJbPZozmvMeXFkq+1kXAYujp+5Gl1Z97Sr/HV8dO4C59G7vORwIEYoq8GZROx1naC3tauXsL/6wHXMDsoCu2g3yauWLsQ2xv5yXDZY320aUedTOhSXKeXGKEdjptVd7oadM5tXT0FRqHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177719; c=relaxed/simple;
	bh=rpfFLAFnZrY34Tx7YZQRkB4Xe7nOo8WltafnvqN1d2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMPjwqW89BBYy9m6OWtZg5WFWgK2gDHnKySf9HJrUc8yZzJukg/sA1F3ncZCQrfLJULpDvxQKr9j5hdSER0RcUOG27OZLYrB/GNMbY8w5VVRcDbcb6RgQGx7BvxoPjdA+6JpeXOEV0DoIO+CoTHzs6lnwLnh8pfxzIJzONVK6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxjxwLIL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732177715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//ytyIGwJU/7+usu7ACf7/NLRSxi7kbRDsQjYD5hFoQ=;
	b=SxjxwLILmTpKyuSozF9RRO30HIeRwme2B/YBTL0SRbyVt5qAXBWdALVUPLtzdJ7s9md0hH
	T6+0dJ0OzvB04bj58m9YmpG0d06xW735/N2h6OHP+vMchUqoVuS1akw8HmdsF9U1gMpcJP
	jwQjZMCYwcfeMD27uX1gut6BCYz5/3A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-r1IJO6VUP7ydDYqC_gSHUQ-1; Thu, 21 Nov 2024 03:28:34 -0500
X-MC-Unique: r1IJO6VUP7ydDYqC_gSHUQ-1
X-Mimecast-MFC-AGG-ID: r1IJO6VUP7ydDYqC_gSHUQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso4620215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177713; x=1732782513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//ytyIGwJU/7+usu7ACf7/NLRSxi7kbRDsQjYD5hFoQ=;
        b=pxX1CgJbo0scOIuGHMPW3UbddXw+NObdibsOks8BAj8whDfehU6+NxJ14mCGWc38EV
         wOIb+qiSXigPV52x6JqCHLLXKAHr+/AiS6D2S21pOtsogZfzCLQ6voRWcHey5JpN5LNq
         S4ZBv7HEJaxUYBdoVuUvKAfAjWbI3StdHnZr5ofEXxEJ2aVgiy80YCCGu1Rro3Wlnv/N
         J3vvFcNzcwzM2yWu7H0UaLKRGgJL2IBpLXObYBM+RV7qp9SklPC8YOuo4WBqo4mT9mh5
         5jrsMrN0UJxt+YjaFHAr11U34IpruvWYa9TpkuT9QYvd0lm6x0eCURVes3uautAzE9BK
         Sg0g==
X-Forwarded-Encrypted: i=1; AJvYcCV/7SsMWCs1OQY99p0XBf2WRR6MsdiO8+Md55uBgCYEBiE3CBFxPRCQF05+HPEm2QGqGoZcBxIUN1hefVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSrhgxDSgQ0kCl5id01D+HJTJXcqTXfqyVU0d7FdBDw1Z6nks
	vohwc+A9qQUZkQ1wIzD1XJRZB94jhPZxWMgr16tKidJ6ExBoVLTI9EwJ702Dj/mJBGSO3N661ia
	3ieWuluKZiq+HNrZRRvk56FbwEsoueBHmgpdF7CD8/4Ry1qlfM//XUa2XOhXdBQ==
X-Gm-Gg: ASbGncs4XAsxWsaz7liWf9jJs6BPKakbQLn6IZgtbsloHVr7HEeNwZgmZ+erAt5/mtK
	6Npx/8U1L/JJd/+QzaN9BCamkhMkTSsBg/ZsrbxiQQUag1BVjXutwTxMfhIxrznrj8eqboKVYJB
	aYaNCbtDMJjld9QPISn5CxX6sY2dLWZOCwXuvAGH5dsUxCcNbiNOfIf8k9QOK7+ln2lLpLX3Zkw
	CBXgpLYz47nM7SY5K1BwpetebIJVvMeC8E28Y7A9XncBBFrp8USZAUdRsZl7umDxPcQiOMFgQ==
X-Received: by 2002:a05:600c:35d5:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-4334898711dmr44379195e9.1.1732177713237;
        Thu, 21 Nov 2024 00:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHee7Tyb4QNMI1oZUcMrDDlSalmyk59Oq4LLlDqDJZj1F8D0rIMqICqUoUnjpkvfupaUq4c8A==
X-Received: by 2002:a05:600c:35d5:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-4334898711dmr44379045e9.1.1732177712894;
        Thu, 21 Nov 2024 00:28:32 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d40basm47402025e9.21.2024.11.21.00.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:28:28 -0800 (PST)
Message-ID: <722719e7-6f11-41cc-8a83-0a860bd1f12e@redhat.com>
Date: Thu, 21 Nov 2024 09:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: ocp: Fix the wrong format specifier
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, jonathan.lemon@gmail.com
Cc: vadim.fedorenko@linux.dev, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120062605.35739-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/20/24 07:26, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use '%u' instead of '%d' for unsigned int.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/ptp/ptp_ocp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 5feecaadde8e..52e46fee8e5e 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1455,7 +1455,7 @@ ptp_ocp_verify(struct ptp_clock_info *ptp_info, unsigned pin,
>  		 * channels 1..4 are the frequency generators.
>  		 */
>  		if (chan)
> -			snprintf(buf, sizeof(buf), "OUT: GEN%d", chan);
> +			snprintf(buf, sizeof(buf), "OUT: GEN%u", chan);

Note that the above would still cause a warning, as the formatted string
could be theoretically truncated:

../drivers/ptp/ptp_ocp.c:1458:61: warning: ‘%u’ directive output may be
truncated writing between 1 and 10 bytes into a region of size 8
[-Wformat-truncation=]
                         snprintf(buf, sizeof(buf), "OUT: GEN%u", chan);

Since 'chan' range is [1,4] you can probably safely cast it an unsigned
byte, and update the format string accordingly.

/P


