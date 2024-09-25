Return-Path: <linux-kernel+bounces-339334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CAE986452
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786DBB2E4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4650B39AD6;
	Wed, 25 Sep 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iijq9vdQ"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75138FA3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277197; cv=none; b=DaRJYJkJPZYU1sBwQyZRnb1GDPtZ8QFGTJLBLXuGl1vDVGYewPMDPXNk7Mu1FGj8y+ro/YcZHv+qdrENfBZt16GcUeNJ9ogBBnQbpayR/UJ+Oxyc9iMbZ1djDsvMK1rdau3ypMuW7Zg+l3rBxlrhbyPoPVDgF2B5820e+N19Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277197; c=relaxed/simple;
	bh=orysemYIOAAOVmrSgXc7YbMIId2a4I9QLWaG6kwa1MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVmEsp+Ute+I2ubZCfeYjZ5hleSYwe5TtxZhwy8zzrQd6tHjRDo0nB6yc1fcrScw4tVuQn+nV4fWV6uGdtQqn9jydTmuSDx3IVNMEUrUK5ZSuVZuyYb0xpuFbDcbtlWmN2RAqEj6pUEptWGceiW9aGG5CSyk9qORAS0CWxyOa2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iijq9vdQ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a626d73efso262374939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727277194; x=1727881994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeDepfrVJjJS1L25dHRrhNZeV7uLqen0lw2mzfoTy1U=;
        b=iijq9vdQvHavrU7hGstFuCbmExaBuLKBWr+blnCUK+Ow5i1Tuo3Mi4x8eNXiLhhG5e
         gYwsKsa5LrdEztGSL0TNFMHtKH/2oB15GGcI8f/mAsA4xFFtJtgYq+TXWIFzoC08WEHV
         Xg+bh0Yf5qc7bnuS+soKe7ipsh4hlsMCMOM+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277194; x=1727881994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeDepfrVJjJS1L25dHRrhNZeV7uLqen0lw2mzfoTy1U=;
        b=pYFFj5BdCjWXzLQky0GvYMT6eFszv9gIFKL0/QE4jTyRmtRQy+HBIEop/5jNpVp97Y
         MYuiy8YcHBH4mcGNegYirlGJfjRMIEIKTNBUCW+wpZWrAd3xSy2euggkfdegw6bvhj4n
         X+BhuT2pnuBNqN6fOuGsBB59quSa+LbO60V0TdA6r5Jnd8GZc9X7XYiaSUiSd5k+ywSt
         SdbkhTHLKmz1qPHYe1pVBvznafS2YRlLPQc683HdYr/kkLaw2Z5INS0No85SIi4OmPjV
         uDQhf9+6KacRNU9SvSM07iMjfoQtkx0qE9nozFKofSAi8XtmrCy9mZaKRUq0Sb2Fx9PK
         3+Qg==
X-Gm-Message-State: AOJu0YyShOXjtA++NYE0DPfVNW+t+wWBFBmQFk+MGZcTU1oXU8hnH6dQ
	sP5Q3Il+R9TB1kGoYXhXcTHrSMOqaISMhdsqUUKL31/E0qu+wnUrDP1to7EQHLbKGxmY59ixKzl
	n
X-Google-Smtp-Source: AGHT+IExjTKCbzt3SJ+TM0c/1itzBbHKZtRJG/mDo+qsHf6ISOkO2mVQLVf5/Yg9HENFYHgYMbPTKQ==
X-Received: by 2002:a05:6e02:160f:b0:3a0:ac0d:22b9 with SMTP id e9e14a558f8ab-3a26d745c5emr36059565ab.6.1727277193698;
        Wed, 25 Sep 2024 08:13:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a57247a5sm11239805ab.72.2024.09.25.08.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:13:13 -0700 (PDT)
Message-ID: <07999b46-ec31-4284-8869-1ecbdc0c7104@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:13:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests:timers: posix_timers: Fix
 warn_unused_result in __fatal_error()
To: jstultz@google.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 tglx@linutronix.de, shuah@kernel.org, sboyd@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
 <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 09:56, Shuah Khan wrote:
> __fatal_error routine doesn't check strerror_r() return value,
> which results in the following compile time warning:
> 
> posix_timers.c: In function ‘__fatal_error’:
> posix_timers.c:31:9: warning: ignoring return value of ‘strerror_r’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>     31 |         strerror_r(errno, buf, sizeof(buf));
> 
> Fix this by adding a check for return value and error handling appropriate
> for the GNU-specific strerror_r() in use in __fatal_error(). Check if
> return string is null and handle accordingly.
> 
>  From Linux strerror_r() manual page:
> 
> "The GNU-specific strerror_r() returns a pointer to a string containing
> the error message. This may be either a pointer to a string that the
> function stores in buf, or a pointer to some (immutable) static string
> (in which case buf is unused). If the function stores a string in buf,
> then at most buflen bytes are stored (the string may be truncated if
> buflen is too small and errnum is unknown). The string always includes
> a terminating null byte."
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/timers/posix_timers.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index 16bd49492efa..ddb1cebc844e 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -26,13 +26,17 @@
>   static void __fatal_error(const char *test, const char *name, const char *what)
>   {
>   	char buf[64];
> +	char *ret_str = NULL;
>   
> -	strerror_r(errno, buf, sizeof(buf));
> +	ret_str = strerror_r(errno, buf, sizeof(buf));
>   
> -	if (name && strlen(name))
> -		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
> +	if (name && strlen(name) && ret_str)
> +		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, ret_str);
> +	else if (ret_str)
> +		ksft_exit_fail_msg("%s %s %s\n", test, what, ret_str);
>   	else
> -		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
> +		ksft_exit_fail_msg("%s %s\n", test, what);
> +
>   }
>   
>   #define fatal_error(name, what)	__fatal_error(__func__, name, what)

Any comments on this patch John?

thanks,
-- Shuah

