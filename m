Return-Path: <linux-kernel+bounces-317499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26C96DF2A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A589286A60
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAB19F41B;
	Thu,  5 Sep 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBgN4Pma"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAE19E7E3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552476; cv=none; b=pPu5DqbSG7nF+bL3FBfqD0kfMUxmRb4nA+j0zuprkZMx5cVvcivHlPHZ550fthwy+xtpkevO88EdISDoXPL+exA3K3XHdkl+H34tjVyxZV9b7UZTEEUFQrP7WiMvtvbZlSncV/C5J14vFopmbm+pI9fatA6XjspcEKr7ASFq/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552476; c=relaxed/simple;
	bh=3hDV8MPZl2eeco4sWtcX1QKF9GuPivZcxQ7EeyYXZ7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq3U3+vod3mrNf3URgYSgDiXYcQS7iF/7oXFnkD5WMsw5nJw67ujISc0djuHTBORqCvdkn68RlkjZRSYGmK66dlz6inpduDjOqifdsIZqUPdK0XdIGru22t6gkLjGSPkWpNASdBOXr/RjM98XKlkH8pdHjmSGrExENO0SxmpOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBgN4Pma; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a2a035b59so44483139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725552473; x=1726157273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T591UkCT0IYbn+oRGt8t+hSNqz5uHQFl1/H0d1Ig8Os=;
        b=ZBgN4PmaTd4HlJUa+TiRVrrpDOlftgBWpbA/yVPFyLsxa/JU0c5Y82AN+hP5jqzz1H
         pDt01KZ30KMK+UMRTAIlSIZ/K89btg76cstgrOzRt1rpI5GduEchYax8XybL4gW9PQDD
         QugYV/IsXzQ7K8RQ/L7ffKplxfAR/iJZLA7EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552473; x=1726157273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T591UkCT0IYbn+oRGt8t+hSNqz5uHQFl1/H0d1Ig8Os=;
        b=ED3CLtcPRrVjdTLACRslmFXOnhPYKZICmQ1gHq8j5yrstt+Q6QYdQrIekth177Eo/X
         4XchRZLypULuy6vbwjkxP5qJYVUWskTA1M65HSQIIf0H32BJl8QF31V18mKq5YX15DSl
         DmBp5clon0lOiv5j2K88Tr+W0WZJz3n0TXVtsGp0dREmCMFLEkxC/yyXbzZymKF9fTdQ
         DrC/zxxKzFPMzjlgJJHtFLIxVksIm32VkhuHTwLY+Yx2qVSxe2VDlbaha5Wb1qdRnaZ3
         mrleKYInFR4axzqMGozbFsAd0kS6GoHCIkCalDG/JD0Tg2uQy3HHdl60kRsosELnoBmi
         V9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX2+TV992oRlY+3b63Vpdp18n8K068uBppQzHVHGIxrVDuRsaEnvGOpx527/Rct3MkxXemMcX3Y/UUxfbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg41v6bAEQr5711B78BDhc8za3m/RzCoUaXISnL1PqdBAvs7hV
	nw4RM9JFgtA47bVUHF/f0Uu7oRvmf0e2KMCKRZUQJqPzi34itiqG3cCEfnSc1nk=
X-Google-Smtp-Source: AGHT+IH34WOoMeDnGk9Vnz5Oe/4XHQCc9dZANduVVgdF78YsmCXfvLa8Fh7v9CzXGfwh7/TVQaalzg==
X-Received: by 2002:a05:6602:14cc:b0:82a:51a5:bd72 with SMTP id ca18e2360f4ac-82a76fb3aaamr870290839f.2.1725552473085;
        Thu, 05 Sep 2024 09:07:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a5cbba0sm418479939f.51.2024.09.05.09.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:07:52 -0700 (PDT)
Message-ID: <7e9edd64-9a2a-4c69-a167-2e8e94fd239b@linuxfoundation.org>
Date: Thu, 5 Sep 2024 10:07:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Date: Remove unused macro
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, anna-maria@linutronix.de
Cc: frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240905081325.47673-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905081325.47673-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 02:13, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> This macro NSEC_PER_SEC is never referenced in the code.
> Just remove it.

I think I commented on your patch on futex - include how
you found the problem in change logs. Also you have to
include subsystem prefix in the subject line:

selftests/timers: Remove unused NSEC_PER_SEC macro

I see another patch with similar problems from you.
Refer to submitting patches document in the kernel
repo.

> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/timers/skew_consistency.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
> index c8e6bffe4e0a..83450145fe65 100644
> --- a/tools/testing/selftests/timers/skew_consistency.c
> +++ b/tools/testing/selftests/timers/skew_consistency.c
> @@ -36,8 +36,6 @@
>   #include <sys/wait.h>
>   #include "../kselftest.h"
>   
> -#define NSEC_PER_SEC 1000000000LL
> -
>   int main(int argc, char **argv)
>   {
>   	struct timex tx;


thanks,
-- Shuah

