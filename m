Return-Path: <linux-kernel+bounces-386226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB29B40B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740962834AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799E1F429A;
	Tue, 29 Oct 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPDZA9T8"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556082B9A8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170962; cv=none; b=aER2aZf0MmdkQf4QXd+YtYlY3PWFFHKYsK30o9T1yh2+j4MT7S4azKoGQxi+ynSQl4JELRVqNwUfGa8K0XVKYplqMqcQgox9KeONzZPP0ZmA5EnLatAAfncjNQMkiJeOYwVQOYLZxfSgslRIatjrVlgvXFyAUNVxSk4AmJCdPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170962; c=relaxed/simple;
	bh=Tarkhdns4zQUFCrygJPfMG959nJh/2M1K0QJT8bbMmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8m+1KAzcnlP2olCqEz6RbWMegzhYay0mtLMiSP12rSXAQDIRMMtsPtfSew1ifekyejBwtawSnA8BhkbgwuUq579zF7GHsVAVStyXmTUWQyPgRjjzZS+QW4eZPdEvrYKvqYZkSLNSgDxKDaKBoT9GetNI/nCYPBvXJFc0/mZD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPDZA9T8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so3750470a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730170959; x=1730775759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KG7/MFb7NlYnbCy1CZIKlH97f6egaxrPChaTmh2LUpk=;
        b=FPDZA9T8vdLJXS1L1XEo2EPMAFKbpO4lLZtVb4JTk4vypPHo3luVZtEw09feZuCIPX
         k+trWWxbKaOxEFzPbAARi0Ne6h4DRFjp0LBRVsI5bSM2/n8jpmRG4rlVAYmx6THdfg0D
         ZYXFxMA/FD9O/pdJwWzZv+vJo5LnVSVFGhD8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730170959; x=1730775759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG7/MFb7NlYnbCy1CZIKlH97f6egaxrPChaTmh2LUpk=;
        b=IahfW6QW+2RebPmeoSxY+g6YglqhMduCzbTvy/tX2azqYqbqx3P1M6O8lDKZSGgHSq
         bth53xO5GfrTB0G2mke23dI60JY6vs66FU+HqFvjuwu0VFRX73yRw+44O4s0sxXVLxyc
         QiBgcifiqquQjciwFQ3dyNDHc/+laAyvoX+Wni5yxQTUx+Iaq13NIhHMZl/vspjCU2gb
         NRe2qTJdwTKTw/wZ4UINnKpbbXeBGKyeOKzwnOG0vgakKipFfVDvFhnqtgJ0ssZYxXj1
         wniFOtqWGGKfHVxZjUJ9SNz9s68w1SYIA7bTpvm9qDCrFGQ/HAyLFicDLljrnmm/ehJv
         sDgg==
X-Forwarded-Encrypted: i=1; AJvYcCXgrXpcuW2Yvrq3aOlUU1tY7lh58wYND75BbRmqYEE9ju3yZ7Uir0B1zzA3Q/Ovefcdj009WMTxP8Q1m74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAMF3H55UiSVCgVt6TTTUnkgkxIkJ027PEs8E3vmC74EEN5nW2
	rGhr6k3MYDIFdGHP3mUOXQ/XUQgEgX3AN3SH5N7jahCOQMSvBFddd98+B5+c4Q8=
X-Google-Smtp-Source: AGHT+IFuT2RtvfREc4D6T1bVVKvWd2xGU3E4k5Zs8zp45m6cMxR4kNVdxbaGkn45yEjrE9P1xmvK5g==
X-Received: by 2002:a17:90a:a583:b0:2e2:bd9a:4ff4 with SMTP id 98e67ed59e1d1-2e8f10819c5mr11511581a91.24.1730170959546;
        Mon, 28 Oct 2024 20:02:39 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4e3febsm10327372a91.26.2024.10.28.20.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:02:39 -0700 (PDT)
Message-ID: <17008f4e-e5c4-459b-8a50-7b9fbb426a70@linuxfoundation.org>
Date: Mon, 28 Oct 2024 21:02:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241028185756.111832-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241028185756.111832-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 12:57, Shivam Chaudhary wrote:
> Add kselftest support for openat, linkat, unshare, mount tests

You are combining a few too many changes in this patch. As such
this patch doesn't add support for the above tests. Instead it
changes the reporting to use ksft_* framework.

> 
> - Replace direct error handling with
>   'ksft_test_result_*' , 'ksft_print_msg' macros for better
>   reporting.
> 

That
> - Add `ksft_print_header()` and `ksft_set_plan()`
>   to structure test outputs more effectively.
> 
> - Improve the test flow by adding more detailed pass/fail
>    reporting for unshare, mounting, file opening, and linking
>    operations.
> 
> - Skip the test if it's not run as root, providing an
>    appropriate Warning.

Make this a separate patch and the very first patch in the series.

> 
>    Test logs:
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
>    ok 1 # SKIP This test needs root to run
> 
> - With root
>   TAP version 13
> 1..1
>    unshare(): Creat new mount namespace: Success.
>    mount(): Root filesystem private mount: Success
>    mount(): Mounting tmpfs on /tmp: Success
>    openat(): Open first temporary file: Success
>    linkat(): Linking the temporary file: Success
>    openat(): Opening the second temporary file: Success
>    ok 1 Test : Success
>    Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
> 
> Notes:
> 		Changes in v3:
> 				- Remove extra ksft_set_plan()
> 				- Remove function for unshare()
> 				- Fix the comment style
> 
> 		link to v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/
> 
> 		Changes in v2:
> 				- Make the commit message more clear.
> 
> 		link to v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u
> 
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 69 +++++++++++++++----
>   1 file changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..9ca1245784d9 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,45 +23,90 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> +#include "../kselftest.h"
> +
> +
>   int main(void)
>   {
>   	int fd;
>   
> +	/* Setting up kselftest framework */
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	/* Check if test is run as root */
> +	if (geteuid()) {
> +		ksft_test_result_skip("This test needs root to run!\n");
> +		return 1;

This should be SKIP - simply use KSFT_SKIP

> +	}
> +
> +
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_test_result_fail("unshare() error: unshare, errno %d\n", errno);

This isn't a failure - it just means that unsaher() might not be supported.
Since root check is already done, EPERM won't be returned here.

> +			return 1;

Okay this wrong. This changes the return value fro 4 to 1 - SKIP becomes fail.
Use KSFT_SKIP


>   		}
> -		fprintf(stderr, "error: unshare, errno %d\n", errno);
> -		return 1;
> +		else{
> +			fprintf(stderr, "unshare() error: unshare, errno %d\n", errno);
> +			ksft_test_result_fail("unshare() error: unshare, errno %d\n", errno);
> +			return 1;
> +
> +		}
> +	}
> +	
> +	else {
> +		ksft_print_msg("unshare(): Creat new mount namespace: Success.\n");
> +
>   	}
> -	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
> -		fprintf(stderr, "error: mount '/', errno %d\n", errno);
> +
> +
> +
> +	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
> +		ksft_test_result_fail("mount() error: Root filesystem private mount: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_print_msg("mount(): Root filesystem private mount: Success\n");
>   	}
>   
> +
>   	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
>   	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
> -		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
> +		ksft_test_result_fail("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_print_msg("mount(): Mounting tmpfs on /tmp: Success\n");
>   	}
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 1, errno %d\n", errno);
> +		ksft_test_result_fail("openat() error: Open first temporary file: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_print_msg("openat(): Open first temporary file: Success\n");
>   	}
> +
> +
>   	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
> -		fprintf(stderr, "error: linkat, errno %d\n", errno);
> +		ksft_test_result_fail("linkat() error: Linking the temporary file: Fail %d\n", errno);
> +		/* Ensure fd is closed on failure */
> +		close(fd);
>   		return 1;
> +	} else {
> +		ksft_print_msg("linkat(): Linking the temporary file: Success\n");
>   	}
>   	close(fd);
>   
> -	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
> +
> +	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
>   	if (fd == -1) {
> -		fprintf(stderr, "error: open 2, errno %d\n", errno);
> +		ksft_test_result_fail("openat() error: Opening the second temporary file: Fail %d\n", errno);
>   		return 1;
> +	} else {
> +		ksft_print_msg("openat(): Opening the second temporary file: Success\n");
>   	}
>   
> +    ksft_test_result_pass("Test : Success\n");
> +	ksft_exit_pass();
>   	return 0;
>   }


Fix these and split the patches. It makes it easier to review.

thanks,
-- Shuah

