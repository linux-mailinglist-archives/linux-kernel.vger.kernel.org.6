Return-Path: <linux-kernel+bounces-296678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C395AD99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC08283819
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4213B5B7;
	Thu, 22 Aug 2024 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceYXTkL/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8013B298
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308546; cv=none; b=QcPlR82GhZVsDvZ0TwnIKV2Mxy9DSd5FXu7ec8+ak96Ef6tSRWZc7S37Vzl0D1NTmdarpwumcJJB1Flu8UNxT8VVYiwNi02CnPpiFnlNBeWxemFULtWdp6wbqlN/T6L46MMdgZIDdgra4c8PBA1aSMTCvO2r3evqldcswlCDE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308546; c=relaxed/simple;
	bh=b1Rjn/LoT4SVNUvdIbtF5xG4HCH2Vh03+ZvfsoT+6QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nd5sFCk3Ocm1MWVMuZJlrnRieHV5hCXUJVnq6eGHpKls3aXdEheYVtPnanI9EzyJVX/D2tBt2uPsdUwgFu+TcVgdbQ+atvctGEXU4Q4W3Yz34CwsmKtJo5e36V5ZYoqCgCRN4005bk86T6UcoX7X18Jcwno+X8YUrhY+vcqC4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceYXTkL/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71431524f3aso374508b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724308544; x=1724913344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBvE2aI2i9bgj0oTunHmmcWZsTQKUBCqSDTMQZFxlBk=;
        b=ceYXTkL/a8YyxPp7tYM2LM0CpsvJ7S3/d2fFXq0NoDisg43fTl6uc4an/CnbD1Wnwn
         kYkjyri/4n8mRGg7lkpcfr/vKKjT7fM/Ar8IqGhdDibdoHh1kuKVZ+nn6KvvVu1OU9lJ
         jyWh9Z4Z6Envzokr1pdmjjtpdokeUrhtAcm/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308544; x=1724913344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBvE2aI2i9bgj0oTunHmmcWZsTQKUBCqSDTMQZFxlBk=;
        b=xJt05xyt0m8+7++LleUzODdT51fDa8/d3RP6o9AMQIptqppt23jR5mBvz6j6oHIozl
         O8nHOFjcpYRST01bktx4++z4RHJJr5Xes/fzMNDmXD1oTp/LNi9RW/wXxgTI3ktOAEJx
         xAek+fW6R4Ftggu990J7Ww7ISRFqpucgBkLeVLLgP/TJKkrR8g6C6SvrTLSTxMvr5H2v
         0v7AQJ4A6B4OrqKO9bvq+91U+YjRvNYgcdyoUekhKS32gobP7LrhazYga3IPHzoQCCtE
         eDsWPrKyI1gQ5K2v3xNK2rKQeOdpwzEX0mrb44QLmmumKcaooGNMqjcu9YwSjw3+0MZk
         gPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Se0AzJvQxT4tAKzU81RcVWLPP8peEhm0HDpOkcxSMkhCVT2m9dCrEnJc04/kE2iE5sHuSbkV1hzzPWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRv190FUrl76f93qvk/Vs5mqqbNz8QkzPdnFLM6Hz6qe52Rh7J
	yY/LL6U2hN1XyJBX451wzM5ZsEMDX8usvFT1XexAl2m27dAa5Gs9rY1fWi4WojU=
X-Google-Smtp-Source: AGHT+IER0WQ+/su1lz1ifCQxR447du9FfvrK0RFQYuNrUA4Yvo/ANK+eRZi8xzBprVPl4EDdhqPgwQ==
X-Received: by 2002:a05:6a21:9786:b0:1c6:fbf3:a0ef with SMTP id adf61e73a8af0-1cada177b21mr5940374637.44.1724308543509;
        Wed, 21 Aug 2024 23:35:43 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e69sm676348b3a.194.2024.08.21.23.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:35:42 -0700 (PDT)
Message-ID: <875a6d1b-31ba-497f-90bd-a36c18f015a7@linuxfoundation.org>
Date: Thu, 22 Aug 2024 00:35:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests:tdx:Use min macro
To: Yan Zhen <yanzhen@vivo.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240822044630.1267500-1-yanzhen@vivo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240822044630.1267500-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/24 22:46, Yan Zhen wrote:
> Using the min macro is usually more intuitive and readable.

How did you find this problem?

> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>   tools/testing/selftests/tdx/tdx_guest_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
> index 81d8cb88e..d7ddf5307 100644
> --- a/tools/testing/selftests/tdx/tdx_guest_test.c
> +++ b/tools/testing/selftests/tdx/tdx_guest_test.c
> @@ -118,7 +118,7 @@ static void print_array_hex(const char *title, const char *prefix_str,
>   	printf("\t\t%s", title);
>   
>   	for (j = 0; j < len; j += rowsize) {
> -		line_len = rowsize < (len - j) ? rowsize : (len - j);
> +		line_len = min((len - j), rowsize);
>   		printf("%s%.8x:", prefix_str, j);
>   		for (i = 0; i < line_len; i++)
>   			printf(" %.2x", ptr[j + i]);

Did you compile this patch and test it? I am seeing warnings during
build.

tdx_guest_test.c:121:28: warning: implicit declaration of function ‘min’ [-Wimplicit-function-declaration]
   121 |                 line_len = min((len - j), rowsize);
       |                            ^~~

thanks,
-- Shuah

