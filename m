Return-Path: <linux-kernel+bounces-324634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3D974F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A551F25163
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F6314A606;
	Wed, 11 Sep 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USMmgR4X"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510713D510
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048225; cv=none; b=GiF860RK5fGx6tlrU3VYqSS9JEPQmyJyBFGy/09Ld6XzVvVuU+TJU9b2/JE6fPZUar2ofdjE7kJ/1vGIrGh5QOsckoVCgIUBPaIu8jpu38hJQzmBYzz0lYwEHFCN2Rgtxs1dmHqiylKCYfx2Dmendrf+zge7JBVE9Vb+aktiR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048225; c=relaxed/simple;
	bh=GL/tcH/FM58Yb2bt1pTAn5v9Hk42SZ++bAKDveVCzn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0wT2pMA1Al0ARBNyB5dUJpdQfz6N6VoaadjX+/rjdwGkbMlT/NzDT6xuclauRN2laeqeXsyGDcw1Kxt1e2iISPXHzXGPOKFtycgg/Bj0sB5YLfwFc0kk+CQw9N95qkoQRqk/7cDUu0dvUt7aNDSP6J+KGMAGjHnRZamnIObjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USMmgR4X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so20982965e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726048223; x=1726653023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnXXE7Wk3VZnoTwCFRNM4He68pp1akde5BsNQFTxy9w=;
        b=USMmgR4XvAOU9uyFIs2lwgu2KN3SPCGL7xF/om58CcONDlH4HJ6S7/HB9SFFNnU/TU
         pkkzupkbEdDEu54VZLnm1pIKGrR7No34vgXPo0K6ryrYpzuZWTKDvRPkk76Xc8zU3sZJ
         331Z2Whp4LM26nEknm5jsOXdjEf5KLjprZ/Ai8QrzQhYd1V5CX12vd4Q/LPO6i4A0nJX
         vprY+zSBf8UKFojeZy0VEwP7xJuA+3c5NxYaYSdcwm3d5mJEJPQEo6UqgwkNjirQssVw
         TN6Q2Rzo8hifRTLFinhJs7XIoq6QDCaCXQ9lD9APTD9kElY1jii1nVf1vOhnWYIin9dy
         T63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726048223; x=1726653023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnXXE7Wk3VZnoTwCFRNM4He68pp1akde5BsNQFTxy9w=;
        b=Z1nPKrN/1I2Plq+dpQNaY73j4GMQMnwJsW5fF6v5NDOx3p+kFtI3y3d1Eng5UxRD+A
         00Iu2YFSa4/nX1bzfeXEtskpp9TBwoRPxqB1bc47rMfrASfr0/VJUsrLC+wajLg3iphB
         vcR/2ADTvawlt8pGUFtb7KPhBIYjkwJGmPWFiTRpttEz+4n7qyeNAI1czeMGjktbZVd4
         XHNIcOGNS9N806hrmQf4qfy8+3OPwtHC8uql9KQ/CUxnNzzzgsU6S7DjX6y/mGMfA2KH
         RLJGZtnKVyl9lHmkG1YOhNDg2FOLYGH/+OnoGCQ/nlIaBM1+obgcu04WidWxegFqJhoy
         DgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKeMiVO8qCgYOf3uOKy0eIW6nkCWo8bShWY4m2Nx2U0GZTM6yFxstakRwL015ci01nS/FHHJUCg+qbOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LGElx9T4NI9/lHktdhGrbaeVS5XEYgf15W/Xjax/g5joVAx8
	SliN6RuKRBDHDsKm2aL+JYe5aFDPMBpynQx+P/tzoe0z1yWoVwGEdFUYnaM4PMlfIbSWVlRfy78
	u76g=
X-Google-Smtp-Source: AGHT+IE0Il1dEbGGOXjuSySsMoG7SwHGQpfxHTJbZir2HEOgjbgf+Ck2VXRQ1ZglX2icnraJipJPfw==
X-Received: by 2002:a05:600c:4f88:b0:426:62c5:4741 with SMTP id 5b1f17b1804b1-42cae70a06bmr100393585e9.2.1726048222438;
        Wed, 11 Sep 2024 02:50:22 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d35dasm11031673f8f.67.2024.09.11.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:50:22 -0700 (PDT)
Message-ID: <42fd10c1-21fe-48bb-b7ee-c5b42eda7afc@linaro.org>
Date: Wed, 11 Sep 2024 10:50:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] perf parse-events: Remove duplicated include in
 parse-events.c
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20240910005522.35994-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240910005522.35994-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2024 01:55, Yang Li wrote:
> The header files parse-events.h is included twice in parse-events.c,
> so one inclusion of each can be removed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10822
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   tools/perf/tests/parse-events.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 639e65a9bf61..e228511c85a5 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -5,7 +5,6 @@
>   #include <api/fs/fs.h>
>   #include "tests.h"
>   #include "debug.h"
> -#include "parse-events.h"
>   #include "pmu.h"
>   #include "pmus.h"
>   #include <dirent.h>

Reviewed-by: James Clark <james.clark@linaro.org>

