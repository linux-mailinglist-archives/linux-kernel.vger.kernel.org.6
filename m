Return-Path: <linux-kernel+bounces-313883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3820F96ABC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0331C23831
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4741D9D7A;
	Tue,  3 Sep 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QABMHt+J"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792901D9D75
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401277; cv=none; b=uUxIcsT8srdToyTk/CVCeFuXPmP2KKNe/oCau04nKl6LyWakaR6djsFlBemNcqSLr8DC16Z0Hulu+ZUeHIvsNMAh6Q37iyXHvkI9Q5RVPIn6+MRyAUQkXA2gVEoLeirznZR7wg//p1klmoJp9/CkW4jSEHxqmXzHexzpsjJydTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401277; c=relaxed/simple;
	bh=IYU3OAd/bz3G+NVs5Qp6S1RQ33GKRTp+vDtFwpIA22s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzNiWz5ewh3roDp6BrAZoXNcwEA88ZwCUf3YpDrU7Ce7JWvugT2iLYPeiyPg3jkKSpMD9UuRgNMc0dfMDRQeNZa2HCjDuxUj2MrPbiSwczKHqzpKfa+llGgZKyZH7ji9WB9BrxloiDNVPye8PY2tg/c0Sj5gAQQGfbLFl8IP5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QABMHt+J; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso223436639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725401274; x=1726006074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRdhI2LkJxHnaOi7l8tehye5GVUcctO8UI43httEcw=;
        b=QABMHt+JiO0WHtj9M+u6YPCwuhDVmFkcixYyqRgNODjR0G6EP6pBCj09Jo7+/OmviJ
         hPLbKwBg0l6APfZwp0l0XcrZeHPGnnQvonbT3WQo70VDsTtRgU4hAGM4fhj+ZVkI3Vcq
         x9WT38hvcBnYXEGf5IzMYGx9o1uSr9iLI6oyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401274; x=1726006074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFRdhI2LkJxHnaOi7l8tehye5GVUcctO8UI43httEcw=;
        b=QnK852jqqVzmkmP4SfSGni3WJSlXbXWFHWXubCwVfehERUYREmwU+3xzdQG93x73Qz
         1Uh0qDgNnKLVR6nJOzki8+1n54DAiVxo9PtK/vKKPKhya/9vy8WyxlSapU/VWoJ0zlvq
         GCR7A6Qvb55jUTjIKhWufLjMC+0sSh9RNCAohoBoFX+iff834nCckj4rB2dBRLVPvsHR
         YOWiTZo2Xt8NT15rGY3euk3HcXilkQkof5wxRlY+/oLkZXf2srvdsNiw9EbBWEwulfOz
         /PLMO815/apJvyvzc/a50euFXiWf8E+vtYmSB1ZAW0EDAo/K2Wq57b8u5L2Hh/eEGu3n
         K74g==
X-Forwarded-Encrypted: i=1; AJvYcCXFxOOc9iZBDgyhq1THeRNf89yx01kkBWil5bHLf5/ZaDeGZeFH2LYC/Wsv6UZ3wxo8B0rFuwKjI6ZLcjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XXS1jaLWduMTk5Y8gWKPM0IQ0RWCfLIp3fcCoR6qi1+Ly3tr
	/CufMFjZWsGyutmspSQPU4tXD5eyyeTh+ZhGdequ/yfeSoepfaDZYWZCHEnrRIo=
X-Google-Smtp-Source: AGHT+IFTQtThwwC/leZotSmM5t8ciwjzBTdIC6A534twT5TmyUqI2imfLa17eQgS5pJZFaROgPGUNw==
X-Received: by 2002:a05:6602:2ccc:b0:829:e6c5:cb0b with SMTP id ca18e2360f4ac-82a5ed0d2ffmr569688739f.13.1725401274391;
        Tue, 03 Sep 2024 15:07:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a2f0d9fsm328832439f.7.2024.09.03.15.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 15:07:54 -0700 (PDT)
Message-ID: <52a6d4ab-99a4-46b3-bd43-58054602d86b@linuxfoundation.org>
Date: Tue, 3 Sep 2024 16:07:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: splice: Add usage() to splice_read.c
To: Rong Tao <rtoax@foxmail.com>, shuah@kernel.org
Cc: rongtao@cestc.cn,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 23:14, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Give the programmer more help information to inform the program on how to
> use it.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   tools/testing/selftests/splice/splice_read.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
> index 46dae6a25cfb..73a8bc146f97 100644
> --- a/tools/testing/selftests/splice/splice_read.c
> +++ b/tools/testing/selftests/splice/splice_read.c
> @@ -9,6 +9,12 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   
> +void usage(const char *prog)
> +{
> +	fprintf(stderr, "Usage: %s INPUT [BYTES]\n", prog);
> +	fprintf(stderr, "       %s /etc/os-release | cat\n", prog);

How does replacing %s INPUT [BYTES]\n", prog with /etc/os-release | cat\n" do?
Also what happens on distros that don't have os-release file?

> +}
> +
>   int main(int argc, char *argv[])
>   {
>   	int fd;
> @@ -16,7 +22,7 @@ int main(int argc, char *argv[])
>   	ssize_t spliced;
>   
>   	if (argc < 2) {
> -		fprintf(stderr, "Usage: %s INPUT [BYTES]\n", argv[0]);
> +		usage(argv[0]);
>   		return EXIT_FAILURE;
>   	}
>   
> @@ -49,6 +55,7 @@ int main(int argc, char *argv[])
>   		      size, SPLICE_F_MOVE);
>   	if (spliced < 0) {
>   		perror("splice");
> +		usage(argv[0]);
>   		return EXIT_FAILURE;
>   	}
>   

I don't understand how this change helps user.

thanks,
-- Shuah

