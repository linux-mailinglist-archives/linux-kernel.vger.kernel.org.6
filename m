Return-Path: <linux-kernel+bounces-534951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08450A46D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835C616B5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D125A2A4;
	Wed, 26 Feb 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELirHwpV"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41114EC62
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604367; cv=none; b=iYFd18mqS0Yj+Jkg7FqjyAQUY/r4BnyXwcxXBqT9g6z7Rh+LnKGPcnoW8+x43OxBA0k68kOI0tWeLTTO8pXzKBgukhoqiRxPMPq5GbK3pmP8N+FWtpCSY/bEJR003DMLzwwIK6am3lAhcLRHr+WEuIwyD+/NYA6flk0SdmbaqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604367; c=relaxed/simple;
	bh=a7D2XYmGoeKdz24VpbFVPzI8X7fRpawKWQ3rHB/7Fk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kA6ysEA9iE9i2fE1XjIlfWDmxxyQOEMSzhA49z3Mrc66nIbrOb62++jou+7CEgyZgDpYOsrC0/+vt5W+taFgn22hXlaUd/myze2s2j00eKZhIk+1pRo8nLpBZB/lOay/8sBRwN77lQEfVFzRIboVxUMT7hkqiTAJGfQcrRGgKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELirHwpV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855b09fca35so16682339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740604365; x=1741209165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzp4vdXBmVandIjCD1Ph9v4wYVEYC392IHskVG+hw1s=;
        b=ELirHwpVFWYsKNSXB3ZBKfx2hsFddLVs2ILPr9kqE0pr7PVGPPQf6+cEIv4pYv9geV
         jPcxRHYKWCzBPYmqHq1kAw6EQpgyjyDdMQWz6e6zkIOBsHnfpxWmjEfFOYC65pKuycbQ
         9m/KB08VBTTRqwZD5/lCX43Bk5jpf9IqUa1HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604365; x=1741209165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzp4vdXBmVandIjCD1Ph9v4wYVEYC392IHskVG+hw1s=;
        b=kDwUn7pZT/djBDKGWE4428iAiITg4IQRgnAz7fQnQU/PD4fMYClC+RsGY17nCIAxL+
         JAKecDDJ+lr1TPUlsO7m+VK/raej7RteO8ecBnd8jrt5nv+fphHFaTBgB6rOJrdTBjFC
         IkHxiAAfqZxOnRjwV1L2lwb4og3S97SQfb6P4juxoxsJMG1sOOewoTHAgvZOrKO8Px7Z
         7T1ppQsb1gZt+vShujj8QokhSltHSnpJmWJajMhChg/q+C+jWurNS9wsy3WpnmG7C4Kz
         XtvhRGdopuV+Pv+iT/rS3FSMN6HzH63Qr+0PPdf1KstVL+Sf6P8cuWjPeIIy95tYWnfE
         M0HQ==
X-Gm-Message-State: AOJu0Yxk9J6rie1nE+uths1Ve9AB0LeqBilmZf77QYjSRxkpo/cNaolj
	PaIiMWo21yfcEYgFV/kbS8jDXMKuStHTxuwKaQh5hGeyXnHyCgaw7gTgWRdTpiL3IyBMS0pkJTo
	x
X-Gm-Gg: ASbGncvCrj2RSp9/+a9DaURnN5jJsJZnZszofEDLWmv+TLlMhV+WP13n9qozaRGPT29
	2nKhkvqaimi6KvzurGYZ4XUSYao13pqnnI0lsuRhpouZttB45/GfW4f55KKr4P7DXHhhZKq/0wF
	3S52FwOcIOX3OfbpKjxjc9yV6YY4d+mCvmARWy65/j7xMJ1X5C7JISSAwYdiqWh9Tib5YplXj/s
	o4ikAfmtdoFt4wAnwr4a+ypCvGJkPL/UYBbZW8qnyVrx+EV8Zh2K8zHDAih4Q934jrHwbfVfHIn
	z34OZVPsU3zFv3smlwKF2o+fCc9LIs1xA7Vx
X-Google-Smtp-Source: AGHT+IFsXTQa1QaEqW6angF6LEd2bWKQxCM0gljjbQUjyQ2/aOGSMQuuVwDAAa1K/hkVZRGORxpUug==
X-Received: by 2002:a05:6602:2d94:b0:855:bcc9:a8d0 with SMTP id ca18e2360f4ac-855dac845b6mr2369569739f.11.1740604365049;
        Wed, 26 Feb 2025 13:12:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-858753f0a0csm1013139f.44.2025.02.26.13.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:12:44 -0800 (PST)
Message-ID: <9abade09-4186-4730-b197-91d9fd622b1d@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:12:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Revert "selftests: kselftest: Fix build failure
 with NOLIBC"
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
 <20250209-nolibc-scanf-v2-2-c29dea32f1cd@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250209-nolibc-scanf-v2-2-c29dea32f1cd@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/9/25 13:27, Thomas Weißschuh wrote:
> This reverts commit 16767502aa990cca2cb7d1372b31d328c4c85b40.
> 
> Nolibc gained support for uname(2) and sscanf(3) which are the
> dependencies of ksft_min_kernel_version().
> 
> So re-enable support for ksft_min_kernel_version() under nolibc.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/kselftest.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index cdf91b0ca40fbdc4fb825b86d4dc547b5afa673c..c3b6d2604b1e486af5a224a11386f75fe0a83495 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -444,10 +444,6 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
>   static inline int ksft_min_kernel_version(unsigned int min_major,
>   					  unsigned int min_minor)
>   {
> -#ifdef NOLIBC
> -	ksft_print_msg("NOLIBC: Can't check kernel version: Function not implemented\n");
> -	return 0;
> -#else
>   	unsigned int major, minor;
>   	struct utsname info;
>   
> @@ -455,7 +451,6 @@ static inline int ksft_min_kernel_version(unsigned int min_major,
>   		ksft_exit_fail_msg("Can't parse kernel version\n");
>   
>   	return major > min_major || (major == min_major && minor >= min_minor);
> -#endif
>   }
>   
>   #endif /* __KSELFTEST_H */
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

