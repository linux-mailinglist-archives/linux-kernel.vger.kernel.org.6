Return-Path: <linux-kernel+bounces-391419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647EE9B866C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8148A1C2108C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802471D0DE6;
	Thu, 31 Oct 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LNgey6bm"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7C19CC05
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415552; cv=none; b=m6FkZ0a/3uXJuNZOwFtROKUcArfHE49z8TlU9Z4IOUL3cHw2NS4fe2D1mYIJTKZ4tBP/aMCq5h5UxLX1SUwDU1T3mq6zbDU0NEr7NrBuAEAau/soEara4HGfny8FME5cIKIVzpwyQNW7C+yzWLzaXuDslJceV4zpRgvfDqIjDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415552; c=relaxed/simple;
	bh=dMZYa1/BBUZnoALeQgDMIM11iIQRpTDtFxihjAneHaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLyKGDNAKKB/Rg3NsEYmRiTCAzjNaHXvJaRv9MAR1cgpGZN9A32YCurv9w0ATtaCelo7htOX4gsuCNwGb/r9LfyxQyA8s1gcC+07sLm4IL1lIJGYNWewf5OpfC/lHeHWNSOfgxNxyDGplTuOJCXf+HDVDF0FHo52VaInqNUIhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LNgey6bm; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ab6cbd8b1so54529839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730415546; x=1731020346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGefwQ1P0wOgvwKYhBBohTiaStRH2947+iO8xsolrDg=;
        b=LNgey6bmAFeCGo8Dd9IBPFcCttwyuE3znebpAp/pm514p2y1DNRJtPsDYHwcEjR8fe
         H4SX6272zCTHLVoADQeRpAkaDwMJL32c3TIOIG27s+dP474FzvKWyhY13rlK9ZE7aHSq
         MKk9YZAflLoYf4V7ZPy55XsxUONIaqpUMEwMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415546; x=1731020346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGefwQ1P0wOgvwKYhBBohTiaStRH2947+iO8xsolrDg=;
        b=RPQ1VkIrINm6TWIrjJXxjPM5v6nu4lJKo0n9rK6ytZdyGNPrWkyky67Z9CA48VcUy7
         9s1/pgeYQ/MRFqj0eWUfMhao8cngDvvfjAEHstjQ/RdqqbdOG3RfwX2nv9Tf7f4V+xLo
         uZ0b5oxgB9ajzsMXs9xsEAc55c5y24eAvzYCiqXpuCdvrmrrRXWP2uidazpgrocZ6nj5
         u7NKDxMFL9ti7vIbOHhDJgkKjmzYymQahBT2zXEWWJoxczBnsGOShUwPmISPLoDTZ1kc
         v5bk1fLDuyV/+K9Jppy3YaXdEgXm0BOAPl1HQXlOks79Jnr98NrrDLpLMrIw/zVRFrer
         PNJA==
X-Gm-Message-State: AOJu0Yx0p4ABgWh65uomlV20Fe01JfGQrMaw5bChW3sQK3T8ISQt5qVm
	GSMjBbqPSx9BYe96Nds/QTy84FXOCaKbiN69/9xpO8bfvpPimYyhaieP8aT9Jas=
X-Google-Smtp-Source: AGHT+IHuQJNDP+ErBhgVYHSWVNUoJRkBof+T43WABDbY78sBsPTZbY1yxTrj43O0mofFjkRzlnnYDA==
X-Received: by 2002:a05:6602:168e:b0:837:7f1a:40af with SMTP id ca18e2360f4ac-83b719edb9bmr159104739f.14.1730415545623;
        Thu, 31 Oct 2024 15:59:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a4e31sm483777173.143.2024.10.31.15.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:59:04 -0700 (PDT)
Message-ID: <703c3b4f-399c-45a5-a1e1-45c628fb94fb@linuxfoundation.org>
Date: Thu, 31 Oct 2024 16:59:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: clone3: Use the capget and capset syscall
 directly
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241030025045.1156941-1-zhouyuhang1010@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241030025045.1156941-1-zhouyuhang1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 20:50, zhouyuhang wrote:
> From: zhouyuhang <zhouyuhang@kylinos.cn>
> 
> The libcap commit aca076443591 ("Make cap_t operations thread safe.")
> added a __u8 mutex at the beginning of the struct _cap_struct, it changes
> the offset of the members in the structure that breaks the assumption
> made in the "struct libcap" definition in clone3_cap_checkpoint_restore.c.
> This will cause the test case to fail with the following output:
> 
>   #  RUN           global.clone3_cap_checkpoint_restore ...
>   # clone3() syscall supported
>   # clone3_cap_checkpoint_restore.c:151:clone3_cap_checkpoint_restore:Child has PID 130508
>   cap_set_proc: Operation not permitted

Sounds like EPERM is returned here. What's the error number from
cap_set_proc().
  
>   # clone3_cap_checkpoint_restore.c:160:clone3_cap_checkpoint_restore:Expected set_capability() (-1) == 0 (0)

What's the error number here? Looks like this test simply
uses perror - it is better to use strerror() which includes
the error number.

Is this related EPERM?
  
>   # clone3_cap_checkpoint_restore.c:161:clone3_cap_checkpoint_restore:Could not set CAP_CHECKPOINT_RESTORE
>   # clone3_cap_checkpoint_restore: Test terminated by assertion
>   #          FAIL  global.clone3_cap_checkpoint_restore
> 
> Changing to using capget and capset syscall directly here can fix this error,
> just like what the commit 663af70aabb7 ("bpf: selftests: Add helpers to directly
> use the capget and capset syscall") does.

Is this still accurate for v3 - Does this patch match the
bpf commit?

What is the output with this patch? Include it in the change log.

> 
> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>> ---

Please mention the changes from v2 to v3 here so it makes it
easier for reviewers associating the changes to the reviewer.

I had to go look up v1 and v2.

>   .../clone3/clone3_cap_checkpoint_restore.c    | 58 +++++++++----------
>   1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> index 3c196fa86c99..8b61702bf721 100644
> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> @@ -27,6 +27,13 @@
>   #include "../kselftest_harness.h"
>   #include "clone3_selftests.h"
>   
> +/*
> + * Prevent not being defined in the header file
> + */
> +#ifndef CAP_CHECKPOINT_RESTORE
> +#define CAP_CHECKPOINT_RESTORE 40
> +#endif
> +
>   static void child_exit(int ret)
>   {
>   	fflush(stdout);
> @@ -87,47 +94,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
>   	return ret;
>   }
>   
> -struct libcap {
> -	struct __user_cap_header_struct hdr;
> -	struct __user_cap_data_struct data[2];
> -};
> -
>   static int set_capability(void)
>   {
> -	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
> -	struct libcap *cap;
> -	int ret = -1;
> -	cap_t caps;
> -
> -	caps = cap_get_proc();
> -	if (!caps) {
> -		perror("cap_get_proc");
> +	struct __user_cap_data_struct data[2];
> +	struct __user_cap_header_struct hdr = {
> +		.version = _LINUX_CAPABILITY_VERSION_3,

cap_validate_magic() handles _LINUX_CAPABILITY_VERSION_1,
_LINUX_CAPABILITY_VERSION_2, and _LINUX_CAPABILITY_VERSION_3

It would help to add a comment on why it is necessary to
set the version here.

> +	};
> +	__u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
> +	__u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);

Explain why this is necessary - a comment will help future
maintenance of this code.

> +	int ret;
> +
> +	ret = capget(&hdr, data);
> +	if (ret) {
> +		perror("capget");


>   		return -1;
>   	}
>   
>   	/* Drop all capabilities */
> -	if (cap_clear(caps)) {
> -		perror("cap_clear");
> -		goto out;
> -	}
> -
> -	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
> -	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
> +	memset(&data, 0, sizeof(data));
>   
> -	cap = (struct libcap *) caps;
> +	data[0].effective |= cap0;
> +	data[0].permitted |= cap0;
>   
> -	/* 40 -> CAP_CHECKPOINT_RESTORE */
> -	cap->data[1].effective |= 1 << (40 - 32);
> -	cap->data[1].permitted |= 1 << (40 - 32);
> +	data[1].effective |= cap1;
> +	data[1].permitted |= cap1;
>   
> -	if (cap_set_proc(caps)) {
> -		perror("cap_set_proc");
> -		goto out;
> +	ret = capset(&hdr, data);
> +	if (ret) {
> +		perror("capset");
> +		return -1;
>   	}
> -	ret = 0;
> -out:
> -	if (cap_free(caps))
> -		perror("cap_free");
>   	return ret;
>   }
>   


