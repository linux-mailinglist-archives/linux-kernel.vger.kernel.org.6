Return-Path: <linux-kernel+bounces-536919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A927A485C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C5D3AD6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832801DEFFD;
	Thu, 27 Feb 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fI4QZOX5"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE011DE884
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675088; cv=none; b=MPx1rVExbx+mART2QlzIUd4HybGXFNifiVi17XU/jxBLJLVo9/tMvbUcnjRBj7ml0IatuqfIonGmMHohKjjzKIhGjlE84+VvKlROsE+zqmdCbFWmbSUSmWfX5bU0A7ezUYu6GDsZ32Nrwl+A3sKPLXcFMm/eiAP4Z1Tnho5NUUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675088; c=relaxed/simple;
	bh=4gouhfhaxGfgdJQT2qIfnmuu//pDsJmSVA/PYTeND9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzPKC5UTn511phuJ+AQ45JcUI5nnwlXfTWphNhw/Ue/MXpmKwRS91ExMb4G/YGtZCtVP2hynARhD6VT55zashHveA2GDprefVdkA+ACoo8zP3bLPFFFu0AniUNa8tOcP5+2dZ4zdgbtuYSoE+T4VfcNH3FSRyKjd7wFekrUd6fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fI4QZOX5; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-856295d1f6cso86587139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740675084; x=1741279884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ic5EBkS7+JFP3KMIJYtrI+hREWqtDoF6xlcqoBHvEdI=;
        b=fI4QZOX5h031J1FhYTfKdSftuW3lwo3bPIjsE6Ert7Y2PJA96rab9OVfRSdYzYPPwL
         C+5SyaoFV+1+cj5sitAMk6OK5qEVn3d9iRlpFt99VVJcPCSnVJlDl8A1lrvrUMz4hpPs
         M41/8ZUCWXucaeBVjBsfYaYzXVy2PeCx8OlJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675084; x=1741279884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic5EBkS7+JFP3KMIJYtrI+hREWqtDoF6xlcqoBHvEdI=;
        b=sNqrtxkbdnBvngoEtauWhVOk5BjzeNNASEvidmow/Mj9nSXgkyhCVCxVKq12zKTgx5
         YJv4Lj5EMFZdzyLqcFQz0V8//x+dW2ODnYQGuQw5dzbTmA5uEMT1Y36KrC52UvycRW/E
         48/9aT7B2+FooYhsbqiUfdn3ATgyXkTJX26RXyuPXecnuxPzI9eNR5Eiu3/N4exm6anG
         xWgvg+yqrW3+wXVXLjuzASsrqduYDJSqVc4jfgIiFXEGSNXS4al/lqJIWYs5iTfvL5ic
         ubxuNaKdIDZhI8mXMWjAU4EUh/DOQ11GHvFDv2hYFTRDS8pWtb4/aMAakFu8cedpzCS8
         yK/A==
X-Forwarded-Encrypted: i=1; AJvYcCUkXgj/L7MOgOplDFdRoOc4jZ5imvIlk006M+zOxwuHTqdXzneX8z5sfD0seU7OpihHtrz5qw58PYI71P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZAOChJrBXpu9gKaeOJ+Yp8UvPp6lWx7KsGEfmV2nd2+uYMlN6
	bE8QSiizQ5ExlhtG6J9OnswFrsb82S3v6vURGQ0fz3SoouYqbpnondQfw+zryFLqgLKTL8Q6UDf
	y
X-Gm-Gg: ASbGncvTQ8Ulac1gLrGYzGfANoqZow1kVLGsS8bJBWcJgJGm++hYwnhMYcUlX/K2E0H
	EKMXsI+VPbIFH67j6/y78lY3tPWwtMamjd1HowiGeF6Mm3YEDSja9VsUWsHxxtdWl2F8YpMr/2L
	I3ICECaYHNI1tjNTpYQt5ts9sk6Hcr4p45FkulOJHelDgBBpvZ0BtoymTRCbzGgBlti+zL1mCUT
	3+52+GopeCAlPumN2u2BIf6k0LlPUOrpcBC8qTZTST7nYB20XkWE6jPJGRiSjELfd8qRFS7A1Zo
	v++Bc3/oPMIK9Eto+Li4FDx7KuJoajzl6keH
X-Google-Smtp-Source: AGHT+IEKP5jXvQi+gty0oL9paLtd6bEvnw21y9vRTtZa86aBrZwrysNK0Dih3A+SeI1kAgbG7udiYQ==
X-Received: by 2002:a05:6602:154c:b0:855:c7a0:1e33 with SMTP id ca18e2360f4ac-8562014a579mr1407018139f.2.1740675084458;
        Thu, 27 Feb 2025 08:51:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875115643sm38408539f.14.2025.02.27.08.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:51:23 -0800 (PST)
Message-ID: <083e94e0-dc37-4cdd-94a3-db258635a684@linuxfoundation.org>
Date: Thu, 27 Feb 2025 09:51:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2 RESEND] update kselftest framework to check for
 required configs
To: Siddharth Menon <simeddon@gmail.com>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org
Cc: pmladek@suse.com, mbenes@suse.cz, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250227053322.114215-1-simeddon@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250227053322.114215-1-simeddon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 22:29, Siddharth Menon wrote:
> Currently, kselftests does not have a generalised mechanism to skip
> compilation and run tests when required kernel configuration options
> are disabled.

Skipping compile by default is not what we want to do. Tests are
supposed to compile and run even when config options are not enabled.

There is something wrong if the test doesn't compile when a config
option isn't enabled in the kernel.

> 
> This patch series adresses this issue by checking whether all required
> configs from selftest/<test>/config are enabled in the current kernel
> 
> Siddharth Menon (2):
>    selftests: Introduce script to validate required dependencies
>    selftests/lib.mk: Introduce check to validate required dependencies
> 
>   .../testing/selftests/check_kselftest_deps.pl | 170 ++++++++++++++++++
>   tools/testing/selftests/lib.mk                |  15 +-
>   2 files changed, 183 insertions(+), 2 deletions(-)
>   create mode 100755 tools/testing/selftests/check_kselftest_deps.pl
> 

thanks,
-- Shuah

