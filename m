Return-Path: <linux-kernel+bounces-266328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26F93FE36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F21282D60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D93187858;
	Mon, 29 Jul 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iY76AxuA"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2921187850
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281190; cv=none; b=iEmGhB7iTpscGu8RQRMBsQC+hpcW7+VHXt6zD7gO9Mlv0wDvh44y+LzSRRgCaOhPwrBq3mnGH8FV/DRaVemipfhdqFahlz7OY6VIFl0BX6YlNGy0zMSaQAb0V4iqwlQv6m8Qk4O7kI4kTHKVzQy/03Hz3Vl/+SnNVa6f/brPJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281190; c=relaxed/simple;
	bh=12r+qoVgIwNMujUj1Lw9nLCpW580cxRA8WuCewWiy8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaQQLzKTgfLTjxvsbjs0uO9dmOTaq99cx8ydF+1iGD+AcxxOqzu4TX1TtyEx27uf1/VtzXKReQNdP2V3ETs+DGvHKGApNzIrbjI5arL5wzLNEo+23NKpbyvL+Sc0kSqZT0zPWYF/JTC1Q7k2hoiawsbwYiuWVnwrZUwvqV5UiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iY76AxuA; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f7faff04dso23529639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722281187; x=1722885987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kwWLpKJa8JQmE+XMPSbBE95rM7lCL8UnHLXXsddUg0=;
        b=iY76AxuASfYwPjBb4cu2hEubkGwrSTBudFXsE55AviLcihah8C3TRs4syeBz2t/BCV
         NfoXZjeQbljOmTqi6Vn5RLbIVLMCebe52xJ3S13s9uVRx/axWRnTwqMLEMbnd0SMXhp2
         W8GQqpFVnwK4iYtaMMDXerM1xbWCvxp1gCQOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281187; x=1722885987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kwWLpKJa8JQmE+XMPSbBE95rM7lCL8UnHLXXsddUg0=;
        b=GOtL0IvYIFY1D0p9kPyu3NcRXxyRubWivy1Wczq9MkBOksMm5CttJTEYbeES14aU7c
         PMD1w+YuhfQezdrJiDajPqAN35ZVxZQJKcp/LXSfOv8foGn1HrFQwhhWfS/Z+HfejZsz
         7GsVpS4be0yBIkZ0NlnP9OxR2Zw/lFZjsN5Eld5HHGtQo3Z+rNg6tQ3MxYvXq7EtRYuV
         nQDT2QGPanB1kKuJgAUyrZw/iMtBYlUbMYPTN5ZFbA8BYUfriBgY19Orq9oaVVA9kws1
         WQIscnIiT9zwq+du5/BgT5DaSMbsPW0muAhcNAPpxQS56XuYU3XoJXqyrbKblgYcFQ2C
         45YQ==
X-Gm-Message-State: AOJu0Yys+3CpJiTAvvbRYZ9AurTxcw0OMc0jg922pOK4q2zZwOgoTkND
	Cbm/wENAlzjccIkz1D79bcYFTuDWaNnevTDpC28GmlebbvZa+66UkP8R2PqW1TI=
X-Google-Smtp-Source: AGHT+IH5qDpmLWMY5mYooQOyIzYHn29X3m+a786VYmBRROEY+94JBvmh76Ky2yQETad5sL8Ac8mbfQ==
X-Received: by 2002:a5e:c91a:0:b0:81f:922a:efdb with SMTP id ca18e2360f4ac-81f922af876mr527827439f.1.1722281187035;
        Mon, 29 Jul 2024 12:26:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d6cbfedsm308183539f.10.2024.07.29.12.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:26:26 -0700 (PDT)
Message-ID: <120ddb22-34c4-4d18-8238-306485680c5a@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:26:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tools/nolibc: improve LLVM/clang support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 04:09, Thomas Weißschuh wrote:
> The current support for LLVM and clang in nolibc and its testsuite is
> very limited.
> 
> * Various architectures plain do not compile
> * The user *has* to specify "-Os" otherwise the program crashes
> * Cross-compilation of the tests does not work
> * Using clang is not wired up in run-tests.sh
> 
> This series extends this support.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (12):
>        tools/nolibc: use clang-compatible asm syntax in arch-arm.h
>        tools/nolibc: limit powerpc stack-protector workaround to GCC
>        tools/nolibc: move entrypoint specifics to compiler.h
>        tools/nolibc: use attribute((naked)) if available
>        selftests/nolibc: report failure if no testcase passed
>        selftests/nolibc: avoid passing NULL to printf("%s")
>        selftests/nolibc: determine $(srctree) first
>        selftests/nolibc: setup objtree without Makefile.include
>        selftests/nolibc: add support for LLVM= parameter
>        selftests/nolibc: add cc-option compatible with clang cross builds
>        selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
>        selftests/nolibc: run-tests.sh: allow building through LLVM
> 

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

