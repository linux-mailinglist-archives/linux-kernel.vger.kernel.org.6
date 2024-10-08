Return-Path: <linux-kernel+bounces-355938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635B995974
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE51528423C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E220ADF0;
	Tue,  8 Oct 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUkvS+aX"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAACA194A4B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424238; cv=none; b=kggNtBr9gi7ENGf0N15/UtOnu4WSLIz4Wf4w7YuCmO6KhdzqB80+NCz85a2Ubw4wH3Akc8piFL4pGvVXRs5C537n5RwEJmMV4xK2mWKGPfLh3Q3mPeCYDwH5BIQYeX9P3lJhAG3IAH16GR99IKPYqUBrPzH/mSNXtdPL1SbksQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424238; c=relaxed/simple;
	bh=Iqje6EWpPEn8D42gRQnfAepziD04Y5SoxxzHbH/QF6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3/ao8csbzZjSFCeZvgzG58S6hwWZylAcWSdXInjhiDUBiLxq6LITUMg5BQ8T21XPsjaKq749i/68w2+ZeSE5G6ieyGrMa4m4dN9/FG+FOTjNNGHdtyLgbmPj558TZCuatfjzRjUyvZUcfTQEtbKoxnKi3WidkuI+DFtyIwvUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUkvS+aX; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a1a3090f93so20154815ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728424235; x=1729029035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4kIYoVybwY5oCfCX6nUbuZCgO9vStiTi85PSAC7K80=;
        b=bUkvS+aX7m1xeimPuMsyta7hkDBQ6C6RzhIrginZfT4BqQIHTtYzM6BeSX0SmmjVQk
         eOYZFp+5k9OztigGbXiGJsNUq5HFLWAtp2AWPnI4Cv5bmDoC2c8VJjeE+hGBCl0rqUiP
         WF0FCFO1Dyw3Peo2QesX4gi5XWflo00Q2nAVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424235; x=1729029035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4kIYoVybwY5oCfCX6nUbuZCgO9vStiTi85PSAC7K80=;
        b=cQmO2nPUPeDgXG33mBspxF7V6Y5r3oTlGT2Hlwqh6t9/4I5X4rN5BvLJx45h8AcbXl
         RdYZlRu3U9b2ReXFhd85YGugP//07pqaavym5DodVpw4bqugiYednd6XLzlhOKFZ6m/Y
         8Rtm91+viLRwI8c+XeDfgWuAZ1CrlQrlxEkHQ61wwBHxUnU3usjUHN2JlBF0Yp97jIg2
         N1MLe7ddrX6yi4+aZclcaFhGzkCNzfdfF6tr3o3GhBUL6m+lU4l6Gr4M38M/LUc3WGv4
         MRyYSL1EgHLiilMGffTrae6rJopOSBrxaqbOC/19GlNB8Nar1x66w5w3vFd+GeG7zyqO
         SMVg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Qcab9P/7cGCyH/ZuJVTTSy7kVJbx+uRAh3VAJ4xRtsHzAcBLi2+TVnu+ppbUcnGZrn7z0ci5kN6xSXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuVRj2lqnZ1ZK2j1y7Unm0ssQ3RiEV1YJJ2UwGIzDCUHqMvjlv
	DeYJ5WACqEsY2Wv7EKwQ1Kbk/e6dv0UZ+fkQ6D+De6PlaX8dS+upTyDtSbSbTYk=
X-Google-Smtp-Source: AGHT+IE4mDv9oOLC+DbOrP4btguo7lo7rD5XZ/nuEUQcWCy7kUVGwLTqx0VDDeSxhqPYY7SA34Asyw==
X-Received: by 2002:a05:6e02:b47:b0:3a0:beb4:e402 with SMTP id e9e14a558f8ab-3a397cd8bcemr2852325ab.1.1728424234956;
        Tue, 08 Oct 2024 14:50:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a396975214sm1204025ab.9.2024.10.08.14.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:50:34 -0700 (PDT)
Message-ID: <4564d4e0-6384-4b84-a330-fdd6a026c9d6@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:50:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: vDSO: Explicitly include sched.h
To: Yu Liao <liaoyu15@huawei.com>, shuah@kernel.org
Cc: xiexiuqi@huawei.com, Jason@zx2c4.com, christophe.leroy@csgroup.eu,
 broonie@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241008023332.19902-1-liaoyu15@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008023332.19902-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 20:33, Yu Liao wrote:
> The previous commit introduced the use of CLONE_NEWTIME without including
> <sched.h> which contains its definition.
> 
> Add an explicit include of <sched.h> to ensure that CLONE_NEWTIME
> is correctly defined before it is used.
> 
> Fixes: 2aec90036dcd ("selftests: vDSO: ensure vgetrandom works in a time namespace")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
> Changes in v2:
> - Include <sched.h> instead of <linux/sched.h>
> 
> v1: https://lore.kernel.org/all/20240919111841.20226-1-liaoyu15@huawei.com/
> 
>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index 72a1d9b43a84..ddf37e3ab18b 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -11,6 +11,7 @@
>   #include <string.h>
>   #include <time.h>
>   #include <unistd.h>
> +#include <sched.h>
>   #include <signal.h>
>   #include <sys/auxv.h>
>   #include <sys/mman.h>

Thank you. Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah

