Return-Path: <linux-kernel+bounces-308793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACE9661E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD07B1C213C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BE199FBA;
	Fri, 30 Aug 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZjOuUEn"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB91898E5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021491; cv=none; b=t5iXZfi1aMekepqwPsr8/KYNQPfFxgVY7YBRlIN4Z15jcrzmkaVw6Xnq9/PNrM7IrrBw4oT1/4T0lHF8gIYtF4EcBNogDJdWQiwwg+0LgKNkO6JE2Ss+axSMavToNiegO+94YzqrT/ThITqfvLUwIl3ipR4LKzdB5mX0ML4z1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021491; c=relaxed/simple;
	bh=yp196IwksZJ7sYAQ8R1rQrxykhZdy2GROPFhwzXA84o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNHwfn83mYdcEkN2qRBJ6pW9C4wjOUHqnncXRfI5O7MvOoEmYUQSILitjxHtBskxKc4GH/iPUGsSg/1qs+x4Q9bgy+b/nIZWGcAqMLRH7JAq7aRFf+lviUXwbOyyQwwLndae3Ycgs6buLxvNINAzjYS+iXixWi0Gjy4DHYskPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZjOuUEn; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3de13126957so1112979b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725021487; x=1725626287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwOyoOeR+Iv38nsYEcC70HzZBSGU/mDtER78grIPRQU=;
        b=RZjOuUEnEmShwm4EAKS+HNGi0MlXNhcia4GGc6tCHuyFgT3MYnnLJMoZvKU+keEIwp
         V2bJVV1B4kA7g5UygDlj8ZueVGf9H4pGMT0J8IpO7z1wQWOaGqOwA7phNmBrxXJ7Arwy
         ARtb4GdUUqjFyfSvCKOwuXV+c4lPMoqgTc00A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725021487; x=1725626287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwOyoOeR+Iv38nsYEcC70HzZBSGU/mDtER78grIPRQU=;
        b=CyewhmEhFX5W9G55PVD1h0877/EvW7A8Ty2o7NAylKT5mN7fPXXCb2RC8o29FSNJED
         ew34vToFK1+x+mLwkUz9X/fkSeAUX60FWv1UCsKOyJ5R9pjV1yKCfrkzD3M5IlU66vtV
         MAR8qb1Fg4fEH5G2CjjYsuciipb8hF0ZS8zvaDuWE0AY9V7LE1yRZxt9DTv8dJcb1vcM
         UfPD+HTRznBJotgTIMohQxit7j3nLmD/u6xKQP0aWKy7++QyalpFDz1r6+sX5X2K4u25
         YQmURS1ZJqWaJ2PLHWNStIgP+YmjFiz0YorXceO8dFW4vR2RvvCF54CoN8EVoqYuyIH5
         XTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthJi7Bs8YSL+mWCVBZYFaLMN13GLIY476xY+1dqqNs+WuOEWIQkrazWioAUTrge3yeB0ZT4sD3j3nME4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8I5hULPi/19HxhvYORcY4qSbiGSPRqIhpp+pt0sppnDtp388
	0hyA3KZcNHoUHhiw0yJM1ejjhszHXGSi7OHcaF/dcfV3lzc4i6LmQz22U7fg8AA=
X-Google-Smtp-Source: AGHT+IHmUNbIOg0Wb3avyaPMvQm8k7ZuTu9Q7gpTHmL+xuVu5Yf68OkEdM9G5jxoJ2Uk7GMUt2sctw==
X-Received: by 2002:a05:6808:1809:b0:3d9:273b:169d with SMTP id 5614622812f47-3df05e88001mr6525591b6e.44.1725021486920;
        Fri, 30 Aug 2024 05:38:06 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82771sm13376791cf.15.2024.08.30.05.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 05:38:06 -0700 (PDT)
Message-ID: <c15802a1-088f-468c-afe7-fedb374bce89@linuxfoundation.org>
Date: Fri, 30 Aug 2024 06:37:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: splice: Add splice_read.sh and hint
To: Rong Tao <rtoax@foxmail.com>, shuah@kernel.org
Cc: rongtao@cestc.cn, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <tencent_3E0DB88452B3022E6754AC5F8546B310BD09@qq.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <tencent_3E0DB88452B3022E6754AC5F8546B310BD09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 21:40, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add test scripts and prompts.

Can you give more details on what these scripts and prompts do?

> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   tools/testing/selftests/splice/splice_read.c  | 1 +
>   tools/testing/selftests/splice/splice_read.sh | 9 +++++++++
>   2 files changed, 10 insertions(+)
>   create mode 100755 tools/testing/selftests/splice/splice_read.sh
> 
> diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
> index 46dae6a25cfb..194b075f6bc0 100644
> --- a/tools/testing/selftests/splice/splice_read.c
> +++ b/tools/testing/selftests/splice/splice_read.c
> @@ -49,6 +49,7 @@ int main(int argc, char *argv[])
>   		      size, SPLICE_F_MOVE);
>   	if (spliced < 0) {
>   		perror("splice");
> +		fprintf(stderr, "May try: %s /etc/os-release | cat\n", argv[0]);

Is this supposed to be usage or help message?

>   		return EXIT_FAILURE;
>   	}
>   
> diff --git a/tools/testing/selftests/splice/splice_read.sh b/tools/testing/selftests/splice/splice_read.sh
> new file mode 100755
> index 000000000000..10fd5d738a2d
> --- /dev/null
> +++ b/tools/testing/selftests/splice/splice_read.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +set -e
> +nl=$(./splice_read /etc/os-release | wc -l)
> +
> +test "$nl" != 0 && exit 0
> +
> +echo "splice_read broken"
> +exit 1

thanks,
-- Shuah

