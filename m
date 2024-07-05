Return-Path: <linux-kernel+bounces-242782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA5B928D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67165285102
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBBF16D335;
	Fri,  5 Jul 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YuxOAW3l"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF716EB6B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201197; cv=none; b=OKKBX5WFkFhfG7WqHy0Z5VodwD9JZqvM7SBrYF7lP8n156xfAag+i5zY0TKmpZ9NR/NK7aIO0ozcKSXT++TwJdrPiY5hOdNg0OTQymWHQgZvhaR2owbPZs3aH52s0giiEQyJ2vmkoKSLGfJyAW2kcJgfrdxBl39oBvLhHiwVak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201197; c=relaxed/simple;
	bh=30Nh8qTVUoUkcFJjX80VwecXmqFO1XJsfJhv0NzYxKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu7uW9G5bAXuhZFz/bIc5AItYLY1PpQypAsBxcBIBO3svcAaXb4MFY9GNDWQ87RYFc7p3ZTPK0UHuVSvQ/NLNoiljblva/TBlpU9aRnJq+ZJw9WNPO/nxGXWBA0x3/6Dy8cSi5K7vmYkgC7yQ3LcMFtdXzazK6KybMbvsSghp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YuxOAW3l; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3d2f12d26so10672539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720201194; x=1720805994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unIf05UCU5IyJnCAhTNm6VO5/me2/U4T6hsWUv5BnOM=;
        b=YuxOAW3lcv5ib49BQwunRhmp1s3AVy+C0uSrjWVvDUnW5ENgNEVZxORe/LZvUWseBn
         ZFR4jZCt3buOJzp6oSUBgyIdsViTWQ/ypwhUIcN5USt0ekZElUFYq/NJUFpOXI6Mh6BP
         hhVZQ6jrOkGeycJTLAHhgpXk7xcaf+tGAwAW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201194; x=1720805994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unIf05UCU5IyJnCAhTNm6VO5/me2/U4T6hsWUv5BnOM=;
        b=PJzjST3dMxxtniSfnsBbkTsaOVXk9HUZujUE5RaspCnt8OQxsBhBvXWMuaKfO01Zhh
         iYO+acOqTRUrN+VjhKv594Xi94Q1o83SLOFaNd1amIV+Xf1csZ4ce31qa3JTp/J0cJIz
         Z2KyHa4JN6mePdKHO6a5kG1c0EBpAwDAh5775r1LObne1ZBiLzzpLF78OJqna9g4kRlR
         XkCd5XM9t09i+egq5A3BwHPe+Ybt6PRJpAld1VEo39sPMqZft/2SA9SK3zWHomUkDVkP
         mIhoWPMeAevA/giM0mEbunyErK+SmANbtVJ4I/DkiR1e47PuFeXMFXhmU91U0Bgo27P0
         ghZg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxn0svzCjSMAVuIU2+Up4q1Qhtejy4sD7jrfxQHASBDjYZQ62UfF1y7K1l23jqKFvggJOz3svZiRpCVKR+e0EinmF/nKAHz+jwryC
X-Gm-Message-State: AOJu0YwlkXBrLywitt1RQFAP3/XR1ym3ulwETfmHdQpM+ncfG9wIzC2V
	dbmXie+Hp5UtXpQ4szLQxx2iiYepGXWETpX+GEjOD+44+sy+4vh/RA7fHcteqlU=
X-Google-Smtp-Source: AGHT+IEM4SS6hOlhpK8tPtz1YFddZheyjJwcf695tdvlnP1W0P9Zvopi9NDI6WLp+A8FUY/8ggO8Xw==
X-Received: by 2002:a5d:8616:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7f66def7059mr523886739f.2.1720201194254;
        Fri, 05 Jul 2024 10:39:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd4dfbsm4565041173.49.2024.07.05.10.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:39:53 -0700 (PDT)
Message-ID: <85ce18a6-9783-427b-bfb4-64b82c0081cb@linuxfoundation.org>
Date: Fri, 5 Jul 2024 11:39:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest: acct: Add selftest for the acct() syscall
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240630-kselftest-acct-syscall-v2-1-b30bbe2a69cd@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240630-kselftest-acct-syscall-v2-1-b30bbe2a69cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/24 13:22, Abdulrasaq Lawani wrote:
> Noticed that there was no selftest for the acct() syscall
> which enables the kernel to record terminated processes
> into a specified file.
> 
> The acct() system call enables or disables process accounting.
> If accounting is turned on, records for each terminating process
> are appended to a specified filename as it terminates. An argument of NULL
> causes accounting to be turned off.
> 
> This patch provides a test for the acct() syscall.
> 
> References:
> https://man7.org/linux/man-pages/man2/acct.2.html
> 
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>

What does the test output look like?

> ---
> Changes in v2:
> Add testcases to test error conditions.
> Add kselftest function for reporting results.
> 
> - Link to v1: https://lore.kernel.org/r/20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com
> ---
>   tools/testing/selftests/Makefile            |  1 +
>   tools/testing/selftests/acct/.gitignore     |  2 +
>   tools/testing/selftests/acct/Makefile       |  4 ++
>   tools/testing/selftests/acct/acct_syscall.c | 89 +++++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 9039f3709aff..45a58ef5ad92 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +TARGETS += acct
>   TARGETS += alsa
>   TARGETS += amd-pstate
>   TARGETS += arm64
> diff --git a/tools/testing/selftests/acct/.gitignore b/tools/testing/selftests/acct/.gitignore
> new file mode 100644
> index 000000000000..8ab358d81bd2
> --- /dev/null
> +++ b/tools/testing/selftests/acct/.gitignore
> @@ -0,0 +1,2 @@
> +acct_syscall
> +config
> \ No newline at end of file

What is this?

> diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
> new file mode 100644
> index 000000000000..ff3e238c5634
> --- /dev/null
> +++ b/tools/testing/selftests/acct/Makefile
> @@ -0,0 +1,4 @@
> +TEST_GEN_PROGS := acct_syscall
> +CFLAGS += -Wall
> +
> +include ../lib.mk
> \ No newline at end of file
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> new file mode 100644
> index 000000000000..4fa00a88a1bd
> --- /dev/null
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* kselftest for acct() system call
> + *  The acct() system call enables or disables process accounting.
> + */
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest.h"
> +
> +int main(void)
> +{
> +	// Setting up kselftest framework
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	// Create file to log closed processes
> +	char filename[] = "process_log";

Where does this file created?

> +	FILE *fp;
> +
> +	fp = fopen(filename, "w");

What happens if file creation fails?

> +
> +	int i = acct(filename);

Chose a descriptive name for the variable e.g: ret

> +
> +	// Handle error conditions
> +	if (i) {

Is this the failure case - ret < 0 case - complete conditional.

> +		switch (errno) {
> +		case EPERM:
> +			ksft_test_result_error("%s. Please run the test as root.\n",
> +				strerror(errno));
> +			break;
> +
> +		case EACCES:
> +			ksft_test_result_error("Insufficient privilege.\n");
> +			break;
> +
> +		case EIO:
> +			ksft_test_result_error("Error writing to the file: %s.\n", filename);
> +			break;
> +
> +		default:
> +			ksft_test_result_error("%s.\n", strerror(errno));
> +			break;
> +		}
> +
> +		remove(filename);
> +		fclose(fp);
> +		ksft_finished();
> +		return 1;
> +	}
> +
> +	// Create child process and wait for it to terminate.
> +	pid_t child_pid;
> +
> +	child_pid = fork();
> +
> +	if (child_pid < 0) {
> +		ksft_test_result_error("Process failed\n");
> +		ksft_finished();
> +		return 1;
> +	} else if (child_pid == 0) {
> +		ksft_print_msg("Child process successfully created!\n");

You don't need braces here since it it a single statement after the
conditional.

> +	} else {
> +		wait(NULL);
> +		fseek(fp, 0L, SEEK_END);
> +		int sz = ftell(fp);
> +
> +		ksft_print_msg("Parent process successfully created!\n");
> +
> +		i = acct(NULL);
> +
> +		if (sz <= 0) {
> +			ksft_test_result_fail("Terminated child process not logged");
> +			ksft_exit_fail();
> +			return 1;
> +		}
> +
> +		ksft_test_result_pass("Successfully logged terminated process.\n");
> +		remove(filename);
> +		fclose(fp);
> +		ksft_exit_pass();
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> 
> ---
> base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> change-id: 20240622-kselftest-acct-syscall-2d90f7666b1e
> 
> Best regards,

Please check coding guidelines and ruun checkpatch on this.


