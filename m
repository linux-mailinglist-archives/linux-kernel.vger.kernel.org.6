Return-Path: <linux-kernel+bounces-195515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4238D4DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D8F1C23633
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B917C231;
	Thu, 30 May 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RD+Z1RpA"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FC176248
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079124; cv=none; b=a9aUchAvjkGx6mxhjusvEj7c0Ift2zf6NkbYWGZnLk2Xe1nh8/ehSkfHQ3SwK1B0g2dfrX8p6MQzGmrSBLYPxVOPkH2Mpb5brzS/iiIyX/htc65crfN6Xj0ojDnHNpU6fPa4lUaDh1qJKTDvnqb1FILWBtERcmB1UD6LcVNpPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079124; c=relaxed/simple;
	bh=g/X45uSF6k+HRkBUhwjSpxSxuIqXtM9kMM336BDvTlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnCiM/86UVwl4VwxIh4dCEarAFojeY7L+dPoowNTD+3qLn3Xc6V4UUJiNuqjHsaEWSNkrSM+lflqdnyZT2TlKOJcvK6VE0WThZC0TqyO8SvdsJtfqc/tJZVWzydHLYi47YeHcOLk2VwezzO1sm2J3zAbIoWZvDCJQK2QRZX+kPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RD+Z1RpA; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e22af6fed5so4631139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717079121; x=1717683921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsdkf/hEokdRbVfsff4bOqv3Tbq/llwdsETViLwX3BI=;
        b=RD+Z1RpAzQpOdC7U+oHVdomJ6iMeO2XvQo57qkFkRE3lZuzhlcD0OstuzQqPYdcs47
         G6jY/SqKhOvKL2d+WqHDalzPAy5XSLFvXS2S9il20hED8braufeUBbUNKr7b2VK6O8zf
         vNj59lLtWXeH0iFIfQvy5CcoKDmguMLLBniek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079121; x=1717683921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsdkf/hEokdRbVfsff4bOqv3Tbq/llwdsETViLwX3BI=;
        b=JOywnyrf6K8NUvr/goz4kW6m6i1yE8k+ajBSpz23UhddU1B1Hd/5Hag9s1M0L3YYAo
         3jOQfOnTV8K6g1iXa8BLHAB2sn2gRwVyH2sA02IJUDrCbg/OBTb62r/bxhWYOXTCOQGt
         8+P9V5Yelq2VyvbzR+LPIGPVZ+Brk+IpZcUQaU2ZPIIZgKDScAynFVDoMUj19Pj3ad1a
         KOrFaVWkBujXJEDhxMA1vWtg6R3jZQEJAcOYu6XGR3R+CV1rkqp9jSMOaR4sowg4LXbR
         IxEgtYvcYHTvdm5xLALyj7xNTHd8sMoj370WEz/toavU/1VVSGv89SIPSvQTnISZYeTX
         CB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaZZaolwgb7tXSNclbjaK6dKRhH0eW9dfYE+hBCZy4Mswc/KoiSQN5H0S+aB3rV9n3+RBrwIq585MD5oC1z4lcSX2L3I7BwAbKHdUM
X-Gm-Message-State: AOJu0YwNGsP8VKBk5btMsGcSMog/WFLdCFlWaIyupmSBHyKKyQw16MRU
	Ac9mg1FEgwU7qn7SopMT/L3LeM7tKVDl/5ftJJcFsbxpGvOWK4W8ZH40QAl7B5Eu3a+tXwrBCip
	B
X-Google-Smtp-Source: AGHT+IF8O6GPnyWjF5VaTmv02b4u4/S8Ekhuksh/BQkhTKKplAGUx/4CG+uFBabO2++mbMvPZsfKCg==
X-Received: by 2002:a05:6602:19c9:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7eaf5b73813mr241539839f.0.1717079120876;
        Thu, 30 May 2024 07:25:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b10cf31917sm1404185173.45.2024.05.30.07.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:25:20 -0700 (PDT)
Message-ID: <88c64f5e-4586-4b38-b3c8-0c3af93a71ae@linuxfoundation.org>
Date: Thu, 30 May 2024 08:25:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/lib.mk: silence some clang warnings that
 gcc already ignores
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240529020842.127275-1-jhubbard@nvidia.com>
 <20240529020842.127275-3-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529020842.127275-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:08, John Hubbard wrote:
> gcc defaults to silence (off) for the following warnings, but clang
> defaults to the opposite. These warnings are not useful for kselftests,
> so silence them for the clang builds as well:

Please you add more information on why they aren't useful
for kselftests.

> 
>      -Wno-address-of-packed-member
>      -Wno-gnu-variable-sized-type-not-at-end
> 
> This eliminates warnings for the net/ and user_events/ kselftest
> subsystems, in these files:
> 
>      ./net/af_unix/scm_rights.c
>      ./net/timestamping.c
>      ./net/ipsec.c
>      ./user_events/perf_test.c
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/lib.mk | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 2902787b89b2..41e879f3f8a2 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -50,6 +50,12 @@ else
>   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>   endif # CROSS_COMPILE
>   
> +# gcc defaults to silence (off) for the following warnings, but clang defaults
> +# to the opposite. These warnings are not useful for kselftests, so silence them
> +# for the clang builds as well.
> +CFLAGS += -Wno-address-of-packed-member
> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
> +
>   CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>   else
>   CC := $(CROSS_COMPILE)gcc

thanks,
-- Shuah


