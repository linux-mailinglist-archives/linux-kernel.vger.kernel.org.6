Return-Path: <linux-kernel+bounces-206690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF8900CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5541EB2299A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18A14A4C3;
	Fri,  7 Jun 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBHhDVRe"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99C79DC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791336; cv=none; b=GKz2k+EODiMGPEHvPrH4UbP86Aul9DmGq0YieQUCqfQOCuBP+E0yHLA7ea503jLBW+0F0jjo7Z2isDXGBsN7mCjb77JTfjnH4faFWYOwJ4aIMOTXlRerodzQU9TIYwM8lc1m2OnU+7wEhe+RMiMjLs7TmXH8mDBbTanAK137v3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791336; c=relaxed/simple;
	bh=8ZFQFPCQ4XXTULP5PE2A/hOB45BjJEr+QOidNYQ3gh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bphk6oWUaLfUqxP+fXer1hbQiV1+oqbZczlgFVV6yTsePH9BiBXJDzcDpsuViCo/VmizhCF+ID1smC2RcWb0FSlX4cMmENXCBqaonGaUahD84hGwy6Ic4j8eS94zSC/uj5fjkxOScaKR9RG3WCv9TjrP2lpGBSARoPBKZb6916s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBHhDVRe; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb358b6f3cso5075739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717791334; x=1718396134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8Xxh/Ngaec4PNLmxPRy2PuypzgB45wSzw/ULqzPxUA=;
        b=NBHhDVReq3YMh3TdZuiV5vhoMwPCrmqLFAZnaL2zUWP4/Jw7C4AqqmNJdTlSaRvn+g
         9/vi6bhI3rlIDPWT+VTjQw0065I9sz1jFMj3+PzSksRry5a9XMbNBtaUKeX+uc637wsR
         GFNhV8Iq6osfwU2BeHV5diFCmEVaWr9Sn6eSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791334; x=1718396134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8Xxh/Ngaec4PNLmxPRy2PuypzgB45wSzw/ULqzPxUA=;
        b=F0qJQJIgPWIMM8Kc5NAJdmYeHfSDSStK3nwgtEkY/XviZA8WvGPXS+Jh3NLvF9Mecb
         vvi707kAp6Ps/qNr/pJp/ujFsWvepQ3Idosb2i1u92tEynyllMXFhAxim3QbtpC9nqRz
         5B5/S1cMgDX5ACV8Zdr5a4vWa/NAE981TD29yEyinpL6KbN2rkMtrUSoqDoY0nAQEAk/
         XYcYK7wx+PFv/yJP76ZJA7NnUdc7QzjdLaZM1g/+/97sS1FvWKFe3hCc6o6oIrRbZJ+G
         Q5F1n3lxg87s1rVd9bketvVls/7EleXkBcke0Fx/rkUjH1eezSWieNo26Xh9eEjJfcyi
         jk8A==
X-Forwarded-Encrypted: i=1; AJvYcCXPuuozjqmZPGucNYp83Lk34DBrvSLka50WYLm93lQZXvoNeet/qpn72s3ZSMK4bopv97zXw7MSyONautOWbuCEVuP0cHdLw9z/JJwM
X-Gm-Message-State: AOJu0Yx6/TJOMA/F6WaGlvWEFPA2fGPHcT5EAyxDKOwJp/HSf7B8DFhj
	B5QVJq0hPu+yKZwQZUMLW3vLk4P66nX0TbC+IQ/fFl8n2NI7p28ABt/V+u6mYxg=
X-Google-Smtp-Source: AGHT+IFjt9n7MceFJ56j5EGGZXyZHBAx91KrQNRWYlCOUZsx281CbKYOqAW30JkztIFgbDxHIMIxrg==
X-Received: by 2002:a05:6602:8ca:b0:7eb:2c80:5354 with SMTP id ca18e2360f4ac-7eb5712c5a8mr362495539f.0.1717791333928;
        Fri, 07 Jun 2024 13:15:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a2386dc6sm1006305173.85.2024.06.07.13.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:15:33 -0700 (PDT)
Message-ID: <b1f1302f-faa2-4081-a73d-b57f9c924e23@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:15:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kselftests: vdso: vdso_test_clock_getres: conform
 test to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
 <20240529072454.2522495-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529072454.2522495-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 01:24, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

The message doesn't match the change. This patch converts the
test to use kselftest_harness.h

Please fix the message to indicate what changes are being made and
why.

> ---
>   .../selftests/vDSO/vdso_test_clock_getres.c   | 68 +++++++++----------
>   1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> index 38d46a8bf7cba..c1ede40521f05 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> @@ -25,7 +25,7 @@
>   #include <unistd.h>
>   #include <sys/syscall.h>
>   
> -#include "../kselftest.h"
> +#include "../kselftest_harness.h"
>   
>   static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
>   {
> @@ -54,18 +54,8 @@ const char *vdso_clock_name[12] = {
>   /*
>    * This function calls clock_getres in vdso and by system call
>    * with different values for clock_id.
> - *
> - * Example of output:
> - *
> - * clock_id: CLOCK_REALTIME [PASS]
> - * clock_id: CLOCK_BOOTTIME [PASS]
> - * clock_id: CLOCK_TAI [PASS]
> - * clock_id: CLOCK_REALTIME_COARSE [PASS]
> - * clock_id: CLOCK_MONOTONIC [PASS]
> - * clock_id: CLOCK_MONOTONIC_RAW [PASS]
> - * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>    */
> -static inline int vdso_test_clock(unsigned int clock_id)
> +static inline void vdso_test_clock(struct __test_metadata *_metadata, unsigned int clock_id)
>   {
>   	struct timespec x, y;
>   
> @@ -73,52 +63,60 @@ static inline int vdso_test_clock(unsigned int clock_id)
>   	clock_getres(clock_id, &x);
>   	syscall_clock_getres(clock_id, &y);
>   
> -	if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
> -		printf(" [FAIL]\n");
> -		return KSFT_FAIL;
> -	}
> -
> -	printf(" [PASS]\n");
> -	return KSFT_PASS;
> +	ASSERT_EQ(0, ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)));
>   }
>   
> -int main(int argc, char **argv)
> -{
> -	int ret = 0;
> -
>   #if _POSIX_TIMERS > 0
>   
>   #ifdef CLOCK_REALTIME
> -	ret += vdso_test_clock(CLOCK_REALTIME);
> +TEST(clock_realtime)
> +{
> +	vdso_test_clock(_metadata, CLOCK_REALTIME);
> +}
>   #endif
>   
>   #ifdef CLOCK_BOOTTIME
> -	ret += vdso_test_clock(CLOCK_BOOTTIME);
> +TEST(clock_boottime)
> +{
> +	vdso_test_clock(_metadata, CLOCK_BOOTTIME);
> +}
>   #endif
>   
>   #ifdef CLOCK_TAI
> -	ret += vdso_test_clock(CLOCK_TAI);
> +TEST(clock_tai)
> +{
> +	vdso_test_clock(_metadata, CLOCK_TAI);
> +}
>   #endif
>   
>   #ifdef CLOCK_REALTIME_COARSE
> -	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
> +TEST(clock_realtime_coarse)
> +{
> +	vdso_test_clock(_metadata, CLOCK_REALTIME_COARSE);
> +}
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC
> -	ret += vdso_test_clock(CLOCK_MONOTONIC);
> +TEST(clock_monotonic)
> +{
> +	vdso_test_clock(_metadata, CLOCK_MONOTONIC);
> +}
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC_RAW
> -	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
> +TEST(clock_monotonic_raw)
> +{
> +	vdso_test_clock(_metadata, CLOCK_MONOTONIC_RAW);
> +}
>   #endif
>   
>   #ifdef CLOCK_MONOTONIC_COARSE
> -	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
> +TEST(clock_monotonic_coarse)
> +{
> +	vdso_test_clock(_metadata, CLOCK_MONOTONIC_COARSE);
> +}
>   #endif
>   
> -#endif
> -	if (ret > 0)
> -		return KSFT_FAIL;
> +#endif /* _POSIX_TIMERS > 0 */
>   
> -	return KSFT_PASS;
> -}
> +TEST_HARNESS_MAIN

thanks,
-- Shuah

