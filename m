Return-Path: <linux-kernel+bounces-366849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336D99FB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E92A1F21D52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B321D63C3;
	Tue, 15 Oct 2024 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UaxgXqsd"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8FC1B6CED
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031251; cv=none; b=Y4Lb9av1hEtXY4wmi4j7AvbIp4DnDN+1pnPOnx0O4Mey4uDG9iikOdb/XYC5UCX7BO5KOufQ+BUKVvMKA0EVq7CSRYvFpgOtWADV1wFT4W7gzknW5Rm44/HrQR0DUYYubhFXVPQic6krsvmiO6jfAh8IPa+3DKVT4cFn5NzcxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031251; c=relaxed/simple;
	bh=xVhvvC5KYY4SRqxAEOGfcTdYI8AtS4CtPdx9l9AtehY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tt2OzD2AiiF5kkRFuxU9ewgmwlKxPqGbwnxFyUDg1GcUsylOkfi0S66jiN04/mQX1WDJl8sOtq34hupbBzxL/edsjyR4Dsdim66AnjKgEFnu97ElyJkWl8/x6BVwnKHFdIH0AqB5ypWieERAacsSquvu4fRcRU46U2HPIm3fD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UaxgXqsd; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-835453714e5so265429139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729031248; x=1729636048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbqYbvbPHC7jsWcXXkq+myvuos/TZJsUv956mH28u+g=;
        b=UaxgXqsdceQ6joCiLq8pO5hN9qUlKClgJ5UgVX5qWYbQM4pZDD5+j7e7d9fQP5S6ER
         T3QVe0IdHg3HW73r24LR9eYlUFv7ck6b9nKxumZ/YhMZNsVb96RQtakdh7Zs3L4Luwxp
         3Gnq+6hgqC9u1/yuttSgj3zSGEJukEh7/mkoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729031248; x=1729636048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbqYbvbPHC7jsWcXXkq+myvuos/TZJsUv956mH28u+g=;
        b=iijSoHjnzrUCOKxGuzhfxoFgP4OrbPHpdSvPpA+8iaX0z4OWqXOFeqIZQFbIqeuSc2
         qGzTY8AY58L6DLCEHPPTS99SUcf7U/hUBbK48jQ/0zVh3rhOSO4xv56mtlKHlAgPi0t0
         AyqUYfA4oTiNtUXyZn5D5jJVKLIZrPs/5HTQB0klU89vmwIMgOMYMcgezH8+8fOAmZ/o
         4KZUF8+bc8V2LHSRCQpPWwy8igc4vZVSEXe6SwU2TMlsxMtanH23q8eSRfCoAOc4YBiL
         O4Lz3xUM4lz0QwCVTrau3s9VbmUYk5LhjbgtYXx5Eahchhu56kW8NJP6NH7tuiwXQ+2V
         YO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVCQValV/DEeJoIUOq+naVIuinLuGrGFgcD5U5JkxH6IrfS8TCUjQ4TG8Z4MRTqiqQ1tFDZbnESB74WRgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHS4hXkW4rxmS3XUndhSq6Pfa5zMrCFRfUQ+CxjFk6HtL6I31
	UcxTYNULpTZ9pOgjBgakBW62DTO3WgdxikCJjQHWNpegePiLxYfdqn+Ypc3lDUM=
X-Google-Smtp-Source: AGHT+IE5if0ZnJaMCA5ubjPTpbcHWlT2DX0oWEry1+1YMZ0iEPhjqRzrVg9N4kV0pU85MnDBXLpQPg==
X-Received: by 2002:a05:6e02:160e:b0:396:e8b8:88d with SMTP id e9e14a558f8ab-3a3b5f61a5emr157523925ab.11.1729031248033;
        Tue, 15 Oct 2024 15:27:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb38cb5sm515234173.114.2024.10.15.15.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:27:27 -0700 (PDT)
Message-ID: <f7c92929-dcda-43f5-a163-9a167abf0de6@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:27:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>, marcel@holtmann.org,
 luiz.dentz@gmail.com, Dan Carpenter <dan.carpenter@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015193013.16790-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015193013.16790-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 13:30, Everest K.C. wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fix it by removing the return statement at the end of the
> function.
> 
> This issue was reported by Coverity Scan.

You forgot to fix the typo Dan pointed out in the short log.
Don't forget to include reviewers when you send new version
based on their comments.

+ Adding Dan
> 
> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
> V2 -> V3: - Removed that the change was successfully built
> 	  - Removed the link to Coverity Scan report
> V1 -> V2: - Changed "Fixing" to "Fix" in the changelog
>            - Added that the change was successfully built
>            - Added kernel-janitors mailing list to CC
>   
>   drivers/bluetooth/btintel_pcie.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index e4ae8c898dfd..660496e55276 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -391,7 +391,6 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
>   	default:
>   		return "unknown";
>   	}
> -	return "null";
>   }
>   
>   /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in

With the typo fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

