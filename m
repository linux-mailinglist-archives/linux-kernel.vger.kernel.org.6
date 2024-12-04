Return-Path: <linux-kernel+bounces-430419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71F9E30B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3541B2332A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B558F6E;
	Wed,  4 Dec 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHM4qnZ1"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15153BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275284; cv=none; b=pnEOxsIrn2m9nCkXyrfyZL2mT//7au3HXRf+hglN8X8aszmvxUzLLkv1svB/fI9r2k3a+2McfYkGASE9GQRIrRZ5i8Gs8d7W+53wgg7iZVXtq6q8n9v6EYDPqpANQ6oihUOleTTtOhR19xKuhITzee1LKB5lew3Ibnm/iqw0hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275284; c=relaxed/simple;
	bh=47+3mMULP6NaG5bFnDnhGZuBok5PLxqX879HrL19F2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvjiuzKNICNtsh35xdi9BYSlO++Fq6KKMj6/KQDwTVpkDkUeTuNk6sxOZZj6jDzhImip5ektHWTTqRf2oCQD4m+i/jGYWTfQHdyIdFjzHxJxdoRXM0SEykZZVq7j9BJWPiA3nLj9XLgghcBm6wp2zVLk19DgTkydbWIxDzDUZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHM4qnZ1; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a6be369d23so28902535ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733275281; x=1733880081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ujwYaTWXcrxC/+8OO/sj3lkfmCwrRVJDVmYLthQFSU=;
        b=WHM4qnZ1HvwlXd/ByArwtjDEu+m11VleAiLG+1HG+JKT3bMS88QTq7yzblr3vD5X4k
         CJRgz2GKdPN15LdQ/YkPcVNmjgjASWb6NAQ+luwwv8wQzke/KEQhnWuuvQmU26Q46LXq
         AJSZq8+b2NKAtkegLfYXYd8nCNQ4fSgr+mBKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733275281; x=1733880081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ujwYaTWXcrxC/+8OO/sj3lkfmCwrRVJDVmYLthQFSU=;
        b=dEG74IBnYElKoCnHaVHsb8ZdEtTTmtmJEnTGQivmcGtobmIl73xwim0uR49jKRjZ9V
         sy5KBMijK3CLDFJzoth/gYPdD2r478aD1NeOYEWvyKFn5wKNYkmISLx+bJPphU9y0GKR
         1f8whkNH+pHPQoy3MOd0diBsG9pOl1R0hGbe3zIlhf4E5o2dZ31Mvarwu7EdL4oqo1l8
         jmG9uI2wTUZnUESVwQfTwLuPh5StAy2KpBH4zflGOX4whtNIt5SkmL8jMab8LvGjS3Vr
         ZNZFZi5vC/Po6Jw+KYM4PDKo+mWOJtx4vUQ6nGmQzaafWM1/K6I45ltTiNEH5teaKDf9
         7VFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZrDAJBzue5BI3Mk1r19gia3Ru4XqY1xB22JXCJswdGuAWeP6mq/0nfm/VD6eyyYn8BPO8ZDs/3hSjLy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzESCOhl88oyhitDr34eszfvTRIJzSq+vke/lutge9sUtIl7vZQ
	dXLR2OMnart/FWy4QhI5yJjfq6OK+R/PSs9i2/gNSikBAF/rOMzhaDeRbnyxGRFyJ5cCsO0hzbY
	5
X-Gm-Gg: ASbGncu1eK2QNOFigCTyPVRi0gvMBWckM6bm3/w0x3I2OXkIDu0N3hrfjV+tMBjOwUP
	5dwjKNg/qyXCigDvEevTDuGibVYb9uPE09o4Kzep7y9MWL2aRZKFnhsRa7m/fuEbRCJuZ19jIyN
	2fwN+0phh9W5fyugMLYgeaVPTm/YLWxLMGZ6/GeFBmZKShfLTDCUw6ept+8MdTmP1bhpLh/zChD
	7VSQZa7tsEqETG6Uwq3k+DNMhmOGNGDwgu+fYG5BZxpDpTDG8OXXhOJRe/6Tw==
X-Google-Smtp-Source: AGHT+IFNn0gAM1mEU1FV0XQJ8uwXjvG6MV1GSwfecTFfL7kSyvjIz6QPSghHA25UuOk7f9bZUeL6cQ==
X-Received: by 2002:a92:c54b:0:b0:3a7:8c3f:edce with SMTP id e9e14a558f8ab-3a7f9a382e4mr60545865ab.3.1733275281643;
        Tue, 03 Dec 2024 17:21:21 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc0b9b7sm28983935ab.33.2024.12.03.17.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:21:21 -0800 (PST)
Message-ID: <95484cb4-b2fa-49fe-889c-03ad64e89c91@linuxfoundation.org>
Date: Tue, 3 Dec 2024 18:21:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/zram: gitignore output file
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 00:49, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>          zram/err.log
> 
> This file will be cleaned up when execute 'make clean'
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>    Add Copyright description
> V2:
>     split as a separate patch from a small one [0]
>     [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/zram/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
> new file mode 100644
> index 000000000000..088cd9bad87a
> --- /dev/null
> +++ b/tools/testing/selftests/zram/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +err.log

This doesn't sound right. err.log is a generated file
when the test runs.

thanks,
-- Shuah


