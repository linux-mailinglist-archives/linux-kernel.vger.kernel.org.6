Return-Path: <linux-kernel+bounces-432251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A069E484E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1618E18803E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB6190471;
	Wed,  4 Dec 2024 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="El6aj0a4"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A62B9B7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353248; cv=none; b=fBMG7/3e2clel8EPL+mMQIt4BYBZtRLVJ6lkNqtSvG6b3oshDqlAQx1JliMFHKXVshnQSkbRC6+J4FU+FspD2nhtC2uBuqdPTnrLuAbdzfedY5uu1t8QS6xadf2qYQijELZmcNrkApSFWDBvKD4pQUlz/RgEBynV4o+uGrDtVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353248; c=relaxed/simple;
	bh=utYlGDElJuh7cwgqAPQiMQ/JryL/ykc++w0qj22g69Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dptoLV0ExOR+OPFUOJjnjMuejlzXL7R1ZWSquj6FjvTgjsXj3XXP1nbn/nkK6unbvkQx3L0iAhF22hVsxzEpAH1kxU9JAxldxj+JTZhjKi3bp/thsFSs6FfZvvC6p70T6IFb/Dz2hOqSxz2cbC0FUw2fSG5pZFEc5vWJncVNnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=El6aj0a4; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a77562332aso815965ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733353246; x=1733958046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8MjONOCveuqKobe9hgyWba31JDPN2COa51czWRUjXQ=;
        b=El6aj0a4YWTO6Kabwotitl3GjBN5QszqBQ6SYS6i+Z+zPALrQyXdzgGf3mB3uYfTR9
         NeicOIcx1Qg4y/SxjONBmO6Dsen+TjiRKnTJb1BKcZ6thlMCfXJnkEj5TORmYaCoKeCy
         fbdnmtnK47QBxXi/9QJiEMZ5dHzg60bTs49eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353246; x=1733958046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8MjONOCveuqKobe9hgyWba31JDPN2COa51czWRUjXQ=;
        b=Ql1Dvk/pQ4sY/SPlG5MShrHkWSpFJ3X1IaNRc/Jyh+0CbPelfMEmQ0wIezrja11yjb
         xokbSESkWItExL7d98n7Rzwb/X7AI0Y+MwrUfZb3ftXCJf5So0y33bnHc+Eqa85UZMrR
         wDerpX85mYRYc3/3ySuS3ospuUKuFofjbTESFpj7lPV0r9fqGCKJwV1/xUcKcSEb3Tq6
         5s9K9izc4QMmJptuWLrYo28tr9CWaz/1A9jxxjE2umP9pKPLZ/sKD/A53W9LYYro+owT
         bZgh0owu5EsW26E6UAUU/mC8RAL1xr/+7mWFLWSqa/1tnTPQcr7LLuEU1wKnOW072ExX
         FaHw==
X-Forwarded-Encrypted: i=1; AJvYcCXbSQfdIBYHnr2blWptFQeYqljf69xMyeCVKZRgvIMhuk7Eu+jDKKv5J08VBWAogJ/v3Z0UoLw0LZIvmbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbj7enR6Mgu8TZI2qJ3yq9z5aAURSihGRfTd51ycKrERfHwvSE
	HPV8z5JNzYMUznSVUMd8/7/qhO/lW5fBlucgdWeaiATZgUVc+lQQEEKJfw0prkY=
X-Gm-Gg: ASbGncsZGmiZA1DnWkCq3UXhQHJ65U2Fg6jsqYoRn1q0EcolxVcaYZA0fiikzHtl1XO
	ZuCoeUewbzp31SL3y5+kKgx7l6VIkITk9/NkKFWwDjO3hx20+MjMG5oKFEvy0SLk6/CyJmbqAHo
	h0Rylo++16Kdvw3btqc96zZfVY2Z0qfhF6saXq2Dy87F93B5FQWZzRov1xM59bWcUXOlB8NCzMV
	aXSZNBdKhDXsa4Iyi1YbxBLg2+/rrU8LHukcjH+ID0Im6GXCjlPZB+WQOooYg==
X-Google-Smtp-Source: AGHT+IFUgmhlOoSihcP/nqxkjyWw10Hk/UBc2m9j6X81IuSx2AXGwM+0j3uEXoKmJvc8OaldrCUQ/w==
X-Received: by 2002:a05:6e02:164f:b0:3a6:ac4e:264a with SMTP id e9e14a558f8ab-3a7f9a46431mr98377155ab.10.1733353245600;
        Wed, 04 Dec 2024 15:00:45 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e28611b614sm35076173.38.2024.12.04.15.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 15:00:45 -0800 (PST)
Message-ID: <f0fc34fa-d208-4bd2-8e0d-bfba60b06b90@linuxfoundation.org>
Date: Wed, 4 Dec 2024 16:00:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: prctl: Fix resource leaks
To: liujing <liujing@cmss.chinamobile.com>, shuah@kernel.org,
 osmtendev@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241128061827.4165-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241128061827.4165-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 23:18, liujing wrote:
> After using the fopen function successfully, you need to call
> fclose to close the file before finally returning.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> index 562f707ba771..7be7afff0cd2 100644
> --- a/tools/testing/selftests/prctl/set-process-name.c
> +++ b/tools/testing/selftests/prctl/set-process-name.c
> @@ -66,9 +66,12 @@ int check_name(void)
>   		return -EIO;
>   
>   	fscanf(fptr, "%s", output);
> -	if (ferror(fptr))
> +	if (ferror(fptr)) {
> +		fclose(fptr);
>   		return -EIO;
> +	}
>   
> +	fclose(fptr);
>   	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
>   
>   	if (res < 0)

How did you find this problem? This file will be closed when
the test exits - do you need this fclose()?

thanks,
-- Shuah

