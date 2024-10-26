Return-Path: <linux-kernel+bounces-383411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53499B1B61
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524F828233C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E91D61AC;
	Sat, 26 Oct 2024 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gz8PY4Yb"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D121531F8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729985530; cv=none; b=ognZ3+gmOCKY01CsDn+2pSc8kz6TMmPsnrinLYe7lJkSeFaGUMKPiZwBJeBxUjeZ5ETQsAsbaDJXvoTYjj4oJ7ZPmzDdGzan+pdqaGNOVvjFqMfXXapU2bHYS6PrklnhNNTKcfgccWem8EfFi8P2mJTGECRnDi3hokZj5XSY0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729985530; c=relaxed/simple;
	bh=A8zjttDJbtwZs5JGIefLrJLAzMWQ2XBwhd4ODpsue3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxAnXh1vVbhgj8jIxooedLa3pWdABlMC0yJcQ6sBj6WtiSvBC7Ji/ebmPqTV13PUD2ANPWNl92QPrYS2S9qHRKqhcB2ggN09MvU9AhsJwxQv0pD2hrheava44M1RcdUBgi+6tQU/6tK788eZiqyfjKUi1RKpkH8+ZiRfPcwpOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gz8PY4Yb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460c0f9c13eso28529721cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729985527; x=1730590327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pzTDkHgM5H320SIcVgLwbioTva8Y/3QBZN2C+npNqs=;
        b=gz8PY4Yb3H2rUSFZH/055tpFuDo1UFXhw4SI0fHmUZXy2o3ZuEGwJIzpnSoammIpkr
         0xoILsSCRBJFsjGbEKoQWvahgqdJ3rVCQKFgrdyfoUjN+KWUyo0Yl04hhBMPhI13rYi2
         nRP4oe7krtXInhg/EIIKlFYxeRU1q81lhqqM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729985527; x=1730590327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pzTDkHgM5H320SIcVgLwbioTva8Y/3QBZN2C+npNqs=;
        b=hRL/wemQ/ZsXX1QNU1kDzeEeDc+4K5rQy5q1eoNso2frqE5b5Ye5p3NdXh9+H//nsf
         KjIceH9aHSGK1kaJlVZKU5LWQ7G4+ZD53jmgApIwp7bUHKQMV17JIQkc5+9xDNH4SQ5q
         Mt0I+Sm00edwzpZBkm4Pysim5CREVw4rYBD7YOqCh8CfqEcyARthP1N1VbCdq6kssRwS
         baXkj1JUtxeEYjaNB1AESmO8x9RcX5pPck7qfhiR5UDlxUwyaPpE7RrzL7DjfBt8eszV
         cRyaov4iBDCI8rQcR3y04H4+yTpvE8vgq7MDaJqcHI2CfkrvpoYkTdncU6icbu1hRnGi
         TWvg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ay57EH8hv/8kskH+c7BqFoowR4ORPaVZisLuH8iBxxTlTjgkr9jA0yyPi3cZqtVvR2YT3l0eOzGLBKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynDpQw0mJH13FvcYAR7Uy2PA5hnyD1yMLyelPwqV0B6i4n1qX
	2QmqDa/ezX8r88s3OfQQQSniSLilg7Broe2XDSPTTqsiVgRB35I6YEfE0uq/Xzooqs5TbI8s/V4
	S
X-Google-Smtp-Source: AGHT+IFg5sZ3T0vHZWwv6gpgQOgLw+o4zUjDP87LErJtuZUQvXdrJLJrZBqhycxX3QOeNoMPLeF9ww==
X-Received: by 2002:a05:622a:150:b0:461:1593:9234 with SMTP id d75a77b69052e-4613b4052b6mr86981751cf.1.1729985526626;
        Sat, 26 Oct 2024 16:32:06 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613213326bsm20464131cf.23.2024.10.26.16.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 16:32:05 -0700 (PDT)
Message-ID: <98fa9d54-a2db-4c31-a0e7-ee4ecb59a172@linuxfoundation.org>
Date: Sat, 26 Oct 2024 17:31:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241026191621.2860376-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241026191621.2860376-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/24 13:16, Shivam Chaudhary wrote:
> Add kselftest support for open, linkat, unshare, mount tests
> 
> - Replace direct error handling with
>   `ksft_test_result_*` macros for better reporting
>    of test outcomes.
> 
> - Add `ksft_print_header()` and `ksft_set_plan()`
>   to structure test outputs more effectively.
> 
> - Introduce the helper function `is_unshare()` to
>    handle unshare() related checks.
> 
> - Improve the test flow by adding more detailed pass/fail
>    reporting for unshare, mounting, file opening, and linking
>    operations.
> 
> - Skip the test if it's not run as root, providing an
>    appropriate Warning.
> 
> Test logs:
> 
> Before change:
> 
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> 
> - Without root
>   TAP version 13
>   1..1
>   ok 1 # SKIP This test needs root to run
> 
> - With root
>   TAP version 13
>   1..1
>   ok 1 unshare(): we have a new mount namespace.
>   1..2
>   ok 2 mount(): Root filesystem private mount: Success
>   1..3
>   ok 3 mount(): Mounting tmpfs on /tmp: Success
>   1..4
>   ok 4 openat(): Open first temporary file: Success
>   1..5
>   ok 5 linkat(): Linking the temporary file: Success
>   1..6
>   ok 6 openat(): Opening the second temporary file: Success
>   # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
> Notes:
> 	Changes in v2:
>    		- Make the commit message more clear.
>      
> 	link to v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u
> 
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 72 +++++++++++++++----
>   1 file changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..26dea19c1614 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,45 +23,89 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> -int main(void)
> -{
> -	int fd;
> +#include "../kselftest.h"
>   
> -	if (unshare(CLONE_NEWNS) == -1) {
> +static int is_unshare(int flag)

Why do you need a new routine for this? Looks at
other tests that do root check. You can use getuid
in the main*( before trying unshare.

> +{
> +	if (unshare(flag) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_test_result_fail("error: unshare, errno %d\n", errno);
> +			return -1; // Return -1 for failure

Match the comment style in the file which /*

>   		}
>   		fprintf(stderr, "error: unshare, errno %d\n", errno);
> +		return -1;
> +	}
> +
> +	return 0; // Return 0 for success

Same comment here.

> +}
> +
> +int main(void)
> +{
> +	int fd;
> +
> +	// Setting up kselftest framework
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	// Check if test is run as root
> +	if (geteuid()) {
> +		ksft_test_result_skip("This test needs root to run!\n");
>   		return 1;
>   	}
> -	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> -		fprintf(stderr, "error: mount '/', errno %d\n", errno);
> +
> +	if (is_unshare(CLONE_NEWNS) == 0) {
> +		ksft_test_result_pass("unshare(): we have a new mount namespace.\n");
> +	} else {
> +		ksft_test_result_fail("unshare(): failed\n");
>   		return 1;
>   	}
>   
> +	ksft_set_plan(2);

Move set_plan up to the top

> +
> +	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
> +		ksft_test_result_fail("mount(): Root filesystem private mount: Fail %d\n", errno);
> +		return 1;
> +	} else {
> +		ksft_test_result_pass("mount(): Root filesystem private mount: Success\n");
> +	}
> +
> +	ksft_set_plan(3);

Hmm. Why add another set_plan - one plan for all tests is sufficient.

>   	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
>   	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
> -		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
> +		ksft_test_result_fail("mount(): Mounting tmpfs on /tmp: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("mount(): Mounting tmpfs on /tmp: Success\n");
>   	}
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +	ksft_set_plan(4);

Too many set_plans - check the usage in other tests.

> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 1, errno %d\n", errno);
> +		ksft_test_result_fail("openat(): Open first temporary file: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("openat(): Open first temporary file: Success\n");
>   	}
> +
> +	ksft_set_plan(5);

Again.

>   	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
> -		fprintf(stderr, "error: linkat, errno %d\n", errno);
> +		ksft_test_result_fail("linkat(): Linking the temporary file: Fail %d\n", errno);
> +		close(fd); // Ensure fd is closed on failure
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("linkat(): Linking the temporary file: Success\n");
>   	}
>   	close(fd);
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +	ksft_set_plan(6);
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 2, errno %d\n", errno);
> +		ksft_test_result_fail("openat(): Opening the second temporary file: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_test_result_pass("openat(): Opening the second temporary file: Success\n");
>   	}
>   
> +	ksft_exit_pass();
>   	return 0;
>   }

This is a small test and there is no need to add these may set_plan() calls.

thanks,
-- Shuah

