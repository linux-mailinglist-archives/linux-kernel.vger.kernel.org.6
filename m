Return-Path: <linux-kernel+bounces-269586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62A943489
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6271C23600
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526441BD016;
	Wed, 31 Jul 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPMHPIO4"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021D34CDE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445050; cv=none; b=FNdR8uGvRNY5ovy3FmQNYwqVnOFB50cs0BQHUOirqu3gCiw+s7Iu/vX/iX43NUyJLhG3ZU9RqnpY4M/7lyoMEIcPnUE/Ttvimn/McuEBnyuYvUMVFtjkDJqqiQhziR6nd83W+6ZTKwSjCDF9prHj8aVEYuWhZxMm1HhBD3DkQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445050; c=relaxed/simple;
	bh=d+kkP0aMvAdSvYfIBJ+5tSpefV4yBmItxJsquTxy+R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxkHeRlSXYeXQgiXhXSFTUclM17B/hvDvRULwlr0fvhoqIJd9uFgte4rvALlztuON/zYktsz5WZ/vikcT339nVZTaVYlqjxbyf+bMbcYRpraVMWbEWx3cgJ7lPa29SdjSQa86fxH2UZHr6bhahrTKPzXYA/Tjz9eleSfsNvwhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WPMHPIO4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-812796ac793so30581339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722445046; x=1723049846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ClsNqpEyCM9KvAFI7Prgc5NoHr2vcPiQ1Jhf3PD+rQ=;
        b=WPMHPIO4kTdLXd/BBRmMh3HivCAZ01/2pam6pj+ZPY/PtQGMe/SPzzISGW0OtorOms
         XnN0rPOwZf2LUcrsGdADykUVW98X5Z6mqHs698mLx1cRXCrlKeXbCH8lXdMYexRjaDGp
         TZ3Pb2sqrtQSFOU5osD4Hhx6qMI2AMxW08JIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445046; x=1723049846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ClsNqpEyCM9KvAFI7Prgc5NoHr2vcPiQ1Jhf3PD+rQ=;
        b=jFK5pD3at1mZ/Sa/wLEdKkYoVUcvAdxBL6JiVGG0jrDkinqDjgcQTrXyeOGH2Cw+Zs
         J7asK6FXvx0LLQrRH//oUqffebMz9SrIu7OIqcunXRh1MauW6e09NzXaJavsOJrdDmoK
         +i2+eKBO4lEv9pEsLVLgZWjyWb577Z972mxNAzeH709zzNTUF4AEeGPQdQVae/+5Pugh
         /S580Bc/ifEjkQf05/QVxdGHu8eznMAn4ozqhUWhkV8mDp+opPm91IeGt1+PVqLnUOFI
         bE0c9/HcjL/wHV+8s6oUa7f7xLsVEReSWr+cfQV9Oslcj8QHII8m15XK+lNb4Poa2+LA
         M8XA==
X-Forwarded-Encrypted: i=1; AJvYcCWJWPhPJumQ9ryVxdy6qguSAb2eC21I7U2czbnogcTa2wkKWLpGwZsqARtZG0KYokwwQJrbgUmjJg6WDoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc08ihhx+F8W9HXlC8W5QSNYCoYotaopJxcAyUurYRDx4d7CIN
	2MV2GX+Jo8v1omudSMDsxr932wBW4N3tBsjoB4/Oe7gIbiRoTmT2VL12e5U9tsU=
X-Google-Smtp-Source: AGHT+IF8+NuvHGohdtP5ed7Ae5GJ+QJAyq6tglX3aLXewVVvJwuPGRQPSgMVbP98OQaYi47qzQt5Zg==
X-Received: by 2002:a6b:7b4d:0:b0:81f:c609:df28 with SMTP id ca18e2360f4ac-81fc609df84mr152809739f.3.1722445046601;
        Wed, 31 Jul 2024 09:57:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d730435sm413578839f.16.2024.07.31.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:57:26 -0700 (PDT)
Message-ID: <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
Date: Wed, 31 Jul 2024 10:57:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731133951.404933-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 07:39, Muhammad Usama Anjum wrote:
> Don't print that 88 sub-tests are going to be executed, but then skip.
> This is against TAP compliance. Instead check pre-requisites first
> before printing total number of tests.

Does TAP clearly mention this?

> 
> Old non-tap compliant output:
>    TAP version 13
>    1..88
>    ok 2 # SKIP all tests require euid == 0
>    # Planned tests != run tests (88 != 1)
>    # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> New and correct output:
>    TAP version 13
>    1..0 # SKIP all tests require euid == 0

The problem is that this new output doesn't show how many tests
are in this test suite that could be run.

I am not use if this is better for communicating coverage information
even if meets the TAP compliance.

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Remove simplifying if condition lines
> - Update the patch message
> ---
>   tools/testing/selftests/openat2/resolve_test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
> index bbafad440893c..85a4c64ee950d 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> -	ksft_set_plan(NUM_TESTS);
>   
>   	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
>   	if (geteuid() != 0)
>   		ksft_exit_skip("all tests require euid == 0\n");
>   
> +	ksft_set_plan(NUM_TESTS);
> +
>   	test_openat2_opath_tests();
>   
>   	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)

thanks,
-- Shuah


