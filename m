Return-Path: <linux-kernel+bounces-430243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544419E2E70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C472831BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529EE208997;
	Tue,  3 Dec 2024 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggx/T285"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1701FBEA7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262711; cv=none; b=U1WbmEL7c1G5MNF46l6kvQNDd4IhddeS2j+mByQLwd0gPyRar0sDu01wlE2NKbv5yIrsMyEOOyvIIMPib3pFhAVI2wXOchDxNR1VmhE+wavelWuJ2xrHHVFEJyTejYQ0oMiFp07kMMdlee85McTkzFUiYpOvC36/WZ/SM5mSB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262711; c=relaxed/simple;
	bh=w/za6g/C2T8C1zYEm4lH01z3wiLU4LniKnBoSQC6CTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX0495/bmitrBgK6UoVFJ5Scj0YEtSnyKrMKFhesuNE50c8bP1Za2BW9UnMc+zSayNQaGFLQ+3H8XilK2wqkUHS1QrJXwvGmOU3h84cGclWoYF6zILQcOxOQygC8zSrgm/x5vUke/CP4IpYA7S5vAR+NOspUbaErCq55lniaXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggx/T285; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a777fd574bso24458805ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733262709; x=1733867509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/qmq4RkrTR0mwK5R2/n+7YJQwRc8U1zqrzjxyswgIA=;
        b=ggx/T285GUSYCrIsDrUDCafsbPXdSuLaOE89xDXyDv3cuzDfpFl3g0G/1Wc+PphVI6
         VwKBUd6caCG0gZwMv1zfeKu3cbx8x77Gb9ROPTxOkXTv7Ceelxy+lHM8X0xKCmze3ncn
         MibyjBKuRfMgtJEk/lbAaOthhRST57+Qt1uJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262709; x=1733867509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/qmq4RkrTR0mwK5R2/n+7YJQwRc8U1zqrzjxyswgIA=;
        b=WDYOopk7tCcGbGICnyANg2ggokM5h+ESqLKJQbFYJF1A4b3qUP+kLltQoKya4WsGIP
         JSAZpmt7DPo1YScD3PXlEJEPb1TDMmqOG8M2UMOcPIejXwHLNRKfE6NXih5ofm1WbgAa
         GkkKdCtC7Q4GBf9jzqmbeNq3oBxV00rTDM1UXn8nU5VwNDuNkbNhR1n3JrUSCfN8any5
         s/JTri1EKpjx07aRsrJ7Pr9Gxz7BeVOYsqKpNGBf+Bi4xfCvRQ9SIM8cpXAKj1nscCdO
         Pr7tSd9YiaWS0fnAW3WNOvTfnyWS/KQ/xyqfLHLHKkfII5U7IeEi06RRV8QTb0e72vYt
         P+5w==
X-Forwarded-Encrypted: i=1; AJvYcCVWBFqkbjgYOFh74OKGeZjs/voRY8SR2I5pEWO5RJPdah+lyEbHOqv9z+Mo4yhtup3Js7MhFhAb1epfrqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGE+GWZGSJ/fCjClfdhUjDn9cdxNiMj1G23ZLxq7QWYWWeu9E
	fFdRidFh+WoNF5aNsBnfW1oDFnQN7EfkAUGgY8TZK5yVgjZFYOhP43sWwGaDfbs=
X-Gm-Gg: ASbGncsme9iNJrXYGTH7Zod+wGspmhrVJfytIzdn3/b80O+JX4XNjjJsJtByLjs4Z6A
	d4SLl1zfy67zyittkkfkzHJ4+NLB8lNL5RHLXoplcnzc28bCQeA57YKkmkQQK4ankPsitk67nNn
	1IPdu7Xk1X0TAPtOW9JF4lVJ5cEL881wLpFG8pSHYzS44BvWZoDY7RYEUOIQA2nk9QpyAOihdZQ
	T8526iUmGZsosqJu9ldwEl4i3RKYK5SlwhlzDyZh9zMziwkvwPIpEMB3K7IWA==
X-Google-Smtp-Source: AGHT+IFJZm1pyj3Fg3MjUuY3Et/7tEKYtEYkkN9KqCfkKnr7F7oeZ0lKHKFB8IqY1HEBxaRaMn8L1w==
X-Received: by 2002:a05:6e02:17c7:b0:3a7:c5ff:e60b with SMTP id e9e14a558f8ab-3a7f9a3bab6mr60789465ab.6.1733262709011;
        Tue, 03 Dec 2024 13:51:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc0dd6dsm28689165ab.41.2024.12.03.13.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:51:48 -0800 (PST)
Message-ID: <63d5e3bb-9817-4a34-98fe-823a9cac7c16@linuxfoundation.org>
Date: Tue, 3 Dec 2024 14:51:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112143056.565122-1-cvam0000@gmail.com>
 <20241112143056.565122-3-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112143056.565122-3-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 07:30, Shivam Chaudhary wrote:
> Replace direct error handling with 'ksft_test_result_*',
> 'ksft_exit_fail_msg' macros for better reporting.
> 

Don't fail the test - skip is the right exit code in this case.

> Test logs:
> 
> Before change:
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> - Without root
> TAP version 13
> 1..1
> Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)

This should be a skip -- see above.

> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> - With root
> TAP version 13
> 1..1
> ok 1 Test : Success
> Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 49 ++++++++++---------
>   1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index f0b36e7a152e..c3a8c9c50c8a 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -40,39 +40,42 @@ int main(void)
>   
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_test_result_skip("unshare() error: unshare, errno %d\n", errno);

This looks right.

	
>   		}
> -		fprintf(stderr, "error: unshare, errno %d\n", errno);
> -		return 1;
> -	}
> -	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> -		fprintf(stderr, "error: mount '/', errno %d\n", errno);
> -		return 1;
> -	}
> +		else{
> +			ksft_exit_fail_msg("unshare() error: unshare, errno %d\n", errno);
> +		}
> +	}
> +	
> +	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
> +		ksft_exit_fail_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
> +	}
> +
>   
>   	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
>   	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
> -		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
> -		return 1;
> -	}
> +		ksft_exit_fail_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
> +	}
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 1, errno %d\n", errno);
> -		return 1;
> -	}
> +		ksft_exit_fail_msg("openat() error: Open first temporary file: Fail %d\n", errno);
> +	}
> +
>   	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
> -		fprintf(stderr, "error: linkat, errno %d\n", errno);
> -		return 1;
> -	}
> +		ksft_exit_fail_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
> +		/* Ensure fd is closed on failure */
> +		close(fd);
> +	}
>   	close(fd);
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 2, errno %d\n", errno);
> -		return 1;
> -	}
> +		ksft_exit_fail_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
> +	}
>   
> +    ksft_test_result_pass("Test : Success\n");
> +	ksft_exit_pass();
>   	return 0;
>   }

The rest looks good.

thanks,
-- Shuah

