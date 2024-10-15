Return-Path: <linux-kernel+bounces-366854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09EF99FB79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42228B21E87
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC7C1B0F32;
	Tue, 15 Oct 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fim8yw5t"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C221E3B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031733; cv=none; b=f+9zFw/AINHht+ilNIKKzKkRZTc5AaB5aRV2FICvAMvkJjJVa0Y6Z8Sj23WlENtG4f6cUPaNEZ2ZfX3doJCdgJC3vnzrpyvA9vdoJ62SO2FGRJ0mh+0IrsnUF/kknW9BqomZBQ7p6vKjYZv+LGZzyVPbrd+uARi5ieNU1P4ycYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031733; c=relaxed/simple;
	bh=JPcxb0MBfSmyg0lqjDguos35ekSSnWJaFqu5QJwB4LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwWWvNCK59yBsn1KoNnOZu76s91+LLJtOGvAHgV6uYy5P7cVGqG5sPlLcmS7aeqWRRVVvdmce7qJVmLUVcjZpAwfsV1/LtuBPDTCNlLhRbbwyJT+JjXWqq4UcFLHIKlhUgs3QlVwUS5/Rh3od7bPEBzaiYKMoHfZjOVTmjTIFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fim8yw5t; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b0247d67so19255555ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729031729; x=1729636529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXRCnoqzM1JhBOspHgulbLEu/aXFFZE816rKdSVssj8=;
        b=Fim8yw5tRnV9HWTt57Mm5CLIrNOnITJEdypeymaCWWgIJVEmWZ75jVIimIC9NYFlDj
         9JGz3rjD7nyR200OfLMIJ0BgMALztC5mQcGA8ZiboWeydJtfx7dYhaJXpl8XHWOjRjIB
         NkLpKyXYi+FvL3vSox+hQX50oM89FktpH19zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729031729; x=1729636529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXRCnoqzM1JhBOspHgulbLEu/aXFFZE816rKdSVssj8=;
        b=TrUukmAdjy1G3mvd4jca2uUAS6Y1u9InGGLVbpA1/hC/taovtMxlb+SplJxpElTHkm
         iNiwZnLjJeUsd6+W+EFe3kD68MO87SWcusHAuBYIyoMHn9F7JyfJ+47xtk+/U9WM3/3a
         gWkA9qEFNplikZ2GcJMEjr+/mHz3qKtnS0yMPPZmg/dA6mBVO6ApFQo1Vm0rv3yxZceu
         ZOuF53tTmMM2rUVHFfdEsJQRW7HngrG7nXLpBjnbMfOepBZDvekSp93bGEVly0hN2iyT
         V4y6eSipq5dAxCLbpSQEM9puKOpXyCziJ9HR881wsp6MC/F5SQ4EzaGcoB3bR86/vTTJ
         CmGA==
X-Forwarded-Encrypted: i=1; AJvYcCWXfj72sDUTl++e7PF6t/DmwvpC9OiOM3yBDo7P+OAuEvFEVpoDZAnDHfrV6KsO6hv/n8OTWrMUsCuOkhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1jKxD5zVfg2nYb+gPZfxGVPFX739kinc5gkrMKtyvU11FhKM
	qkZUDX+hV/OLZs5orowXqFsTGI+9S2YrG02tzsR38bchTo5QVVq7nGiWfLrvRN0=
X-Google-Smtp-Source: AGHT+IGQW6EL87nu0RI7VTlMHpQSpbGTwvfv/vh3kdihkb+1mjnSYKpir26C0GpR0Iqf3ZpZvi3VJw==
X-Received: by 2002:a05:6e02:2185:b0:399:4535:b66e with SMTP id e9e14a558f8ab-3a3bcdc0015mr112300545ab.9.1729031729103;
        Tue, 15 Oct 2024 15:35:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70aec30sm5226605ab.29.2024.10.15.15.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:35:28 -0700 (PDT)
Message-ID: <99056bd3-748f-42e8-a25a-131f7b194f55@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:35:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Move free after the variable use has been
 completed
To: "Everest K.C." <everestkc@everestkc.com.np>, dpenkler@gmail.com,
 gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015215157.18571-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015215157.18571-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 15:51, Everest K.C. wrote:
> The variable `in_data` is freed, but used later in the code.
> Fix it by moving the freeing the memory after it use has been
> completed.
> 
> This issue was reported by Coverity Scan.
> Report:
> CID 1600783: (#1 of 1): Use after free (USE_AFTER_FREE)
> 19. pass_freed_arg: Passing freed pointer in_data as an argument to
> ni_usb_dump_raw_block.
> 
> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> index 1da263676f2a..75f39e1f3ed1 100644
> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> @@ -690,12 +690,12 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
>   		kfree(in_data);
>   		return parse_retval;
>   	}
> -	kfree(in_data);
>   	if (actual_length != length - status.count) {
>   		pr_err("%s: actual_length=%i expected=%li\n",
>   		       __func__, actual_length, (long)(length - status.count));
>   		ni_usb_dump_raw_block(in_data, usb_bytes_read);
>   	}
> +	kfree(in_data);
>   	switch (status.error_code) {
>   	case NIUSB_NO_ERROR:
>   		retval = 0;

Looks good to me. Isn't this on next though. Don't forget to
indicate it is against next.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

