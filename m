Return-Path: <linux-kernel+bounces-246786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D335492C6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077051C2208C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAF18561C;
	Tue,  9 Jul 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9W4TrX8"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEAA18786F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568210; cv=none; b=WwQlbDcfXWpThWliL8uS62uzo/ZArj2jlcwDyGHCh+7HzC7NeksuWR8qvP4u6ogtm7arHvvmAPZiXAON9N0LxJWOXJ7+2GMFMlyB93v3sgtDpb723lEuOjaxy/ZBfGBPGsNsjTX/ko09+XjobKMkrfDG6nbZIcVBwuQyv1QHf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568210; c=relaxed/simple;
	bh=n5MYWmUU+zJ2ToBZXhyOO9IWeN/BTKmPpd9NkIhmWxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgdbyHXEV5VTmIU/vUiHdAXX7p69mJg7JfjIq9/hwhum4DEXTOgQ8TLBnMXSTU0v4ETytRhN200zBs8kWdo5NOR0E45xkFdn5dHZArIvN26iIgpgX0CjHpIcmtc1PIhGkowfQHauHxnx1GrWRR6JYirOYzur6pKCLmktyqIxDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9W4TrX8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f7c41f1bb5so9510639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720568208; x=1721173008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Obet+zOgI/d3hoWH4SK5GTEdBjNetrBshISKYPEwy8=;
        b=Z9W4TrX8dKiyNFqIfO7HNKFtOnaUAkEa8b06D04fFPZJXywOiQgT4zg7J75qgaG9KY
         IwbrNlFHotYtTqw4f5jrxANJxCHVdd9fIkouH2JF8hNb8Fo5hv+w3O8HvTPJdJPBRqfz
         FVsS/uaudd6/WmAP2eptKxsJjN1VNaRHGGHRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568208; x=1721173008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Obet+zOgI/d3hoWH4SK5GTEdBjNetrBshISKYPEwy8=;
        b=KGE2IgT7Vjt04PUVZLuAWjeUsKP0wDsjh02kqz7jhrkS0MEaPdDWGjaxYU7pAXAZjk
         mU9fvji1YH3Lplxyj3pTxiw6xMWjpvS45WYDbHg5Hge8DIJxqH/RbZXjVsLntO+8afZy
         AXqe8fcQOpLmt8G4/mIZAXHwjRbbNfPdxvWpkzsLppnslBpR3fKERSHNrhAB/gw3CXj7
         r0cdz0vNf57ro9ff9WHJC6QYieE1OETc6Et0pM6XdyfHo4t5VXGFikvGzcVizvVar3vH
         ypnmX0MwiknRB1pVEknoREMmeDfJQGRbt2kvEzSTpkIpC9fkqZp8LKZ6R1kCtABohCOL
         YXWw==
X-Forwarded-Encrypted: i=1; AJvYcCUf+xElZKK4ShSj6czqbCsRHTfxYHa+kZB7WRpaekVOZCo+6EL7oIDzZ0QB6SrCz/48yUssSxnfwwPtKZVwp6W0o4zyyCSKy9p2IqqQ
X-Gm-Message-State: AOJu0YxAOkVe1Dju+vtafWJgOrhXbs6Spe9mlNFcjQsvI6D2iwJhggNK
	TNIb3fprJuAKphjBR6wbukXxck6bHu3EeIJ0TMXjHHd5l3urYOHXs5HGi/t+SP8=
X-Google-Smtp-Source: AGHT+IHsNYIFKKi8+YuyGeucGs9eDNkgkXTxNRKSb3UpG8nYC+rbPU4+HLdEcNir5iUkF3anyZzK0g==
X-Received: by 2002:a05:6602:3413:b0:7f9:90c5:4107 with SMTP id ca18e2360f4ac-800023b5fdcmr529040239f.1.1720568208034;
        Tue, 09 Jul 2024 16:36:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1af85efsm777378173.6.2024.07.09.16.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:36:47 -0700 (PDT)
Message-ID: <6940383d-68cb-4966-a587-9fa0cc56545e@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:36:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tpm2: conform test to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240702065559.772855-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240702065559.772855-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 00:55, Muhammad Usama Anjum wrote:
> The python unittest is being used for executing tests. TAP output
> cannot be added in the unittest framework. The python unittest is being
> run from a script. Add the output TAP logs to the script. Add "#"
> prefix to the python unittest output which will mark all output as
> informational TAP messages. Check exit status of the python unittest to
> decide if test passed or failed. Not sure why but python unittest
> outputs logs in stderr. So redirect the logs to stdout and then add
> prefix.
> 
> Specify the bash explicitly instead of sh to run these tests as all of
> the kselftests are shifting towards using bash explicitly. Some
> interpreters have different syntax and cause issues.
> 
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - CC more people which were missing earlier
> ---
>   tools/testing/selftests/tpm2/test_async.sh | 24 ++++++++++++++++------
>   tools/testing/selftests/tpm2/test_smoke.sh | 19 ++++++++++++++---
>   tools/testing/selftests/tpm2/test_space.sh | 19 ++++++++++++++---
>   3 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
> index 43bf5bd772fd4..0e6e5d9d649fb 100755
> --- a/tools/testing/selftests/tpm2/test_async.sh
> +++ b/tools/testing/selftests/tpm2/test_async.sh
> @@ -1,10 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
>   
> -[ -e /dev/tpm0 ] || exit $ksft_skip
> -[ -e /dev/tpmrm0 ] || exit $ksft_skip
> +ktap_print_header
>   
> -python3 -m unittest -v tpm2_tests.AsyncTest
> +[ -e /dev/tpm0 ] || ktap_finished
> +[ -e /dev/tpmrm0 ] || ktap_finished
> +
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 58af963e5b55a..2219a180de91d 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -1,9 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   
>   # Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +ktap_print_header
>   
>   [ -e /dev/tpm0 ] || exit $ksft_skip
>   
> -python3 -m unittest -v tpm2_tests.SmokeTest
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished
> diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> index 04c47b13fe8ac..6a55d13d74983 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -1,9 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   
>   # Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +ktap_print_header
>   
>   [ -e /dev/tpmrm0 ] || exit $ksft_skip
>   
> -python3 -m unittest -v tpm2_tests.SpaceTest
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished

Usama,

As I mentioned another TAP conversion patch from you  patch if the
following command gives you TAP, there is  no need to convert.

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

kselftest framework lib.mk and runtests wrappers take care for
TAP. The reason to take care of this at framework level is to
avoid changes to individual tests. The wrapper keys off of
KSFT_* codes returned from tests.

Please don't send TAP conversion patches like this one. The output
from the commands will have duplicate messages. The reason tests
return

make -C tools/testing/tmp2 run_tests
make kselftest TARGETS=tmp2

thanks,
-- Shuah




