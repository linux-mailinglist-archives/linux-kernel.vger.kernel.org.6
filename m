Return-Path: <linux-kernel+bounces-398632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A39BF3E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E620C1C2336E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFB2064FB;
	Wed,  6 Nov 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WwZg7eGl"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B51DE4EF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912770; cv=none; b=FG57RYpwVy6yhlKZr32ktltpm8tjR43ge8XVgCYpaLjSiqNPTzptBbkbL0F34GUxsRkJbYv7+j6U5/NwQ19MTMr9SRn+xU20Z4gmMjBOJFhMcYth+7m23C/877zbrMiBIcaBDE7B+RCYqILz1oV9wOEzV1BKPQYe4mDxzGXSTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912770; c=relaxed/simple;
	bh=EHHfV01+YzBryJK6oqy+NG1HYmJOBrkQ3gPa9wHwugA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvyEhTpzkuzXVV+y5+HiAhn4fwPZfHUD0nyu7p7mxjBgKQjWu0Htae9+MAKwwCyf0jQ2+prElaCTIiLJDZDspepmh7ZeqkUrvRpMjXh/8VKpnzVV1tiQH6yu0gwNoMse3Dh+Py0mmNffwLvkx8u/SHrnYWgT9EHLPcWwiyv9nDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WwZg7eGl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e607556c83so40292b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730912767; x=1731517567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZhbKhfLK1nW6cUD5V1lnrveGjn3mERSf9IypO38E0=;
        b=WwZg7eGlRU0H8MVDkJtHTxvQt78jeZoVfh9PpUakVnbBne7VGIIxnlY3xj/ezVcNvq
         EFi0i0X7jTuL/PD+AOtg3EfMZesHa41DEQcF9oEyVxgMNtzEHMYdr9lQCNNVffYFlP3y
         Kmkmtq+S/cwTrFINTCazhzTbgaaACM0tQdTO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912767; x=1731517567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZhbKhfLK1nW6cUD5V1lnrveGjn3mERSf9IypO38E0=;
        b=twu9jm/iSqX4nO4J52mKpsdch8v4MFsKg6qITnVrEnbWFOgHPCeYtYBfgXvPHAgTm6
         Kcwf9NpB3kfz5yh4pHUpGkTRKvtSrHJ0bVJQw+Jkb2GWykA6P8dWRZb7G+LiKsScWs1W
         rtO3jw+AR0m79/7SFXk1pD0X3bSZLCuwSLJBc87TboI7ZVF+2yil9Kqn2137KWmdI1MQ
         R+fcGAA8zLv874rl2l38XgM3mI9o2vpdBfFEsc/7OI6rSvrB3WZ5Bm4ApV5CrZzrhVSk
         fQDaxYXia4PnDBmy6lLCK3qOamKJ/SyjlTS9f99Brm2oGLwZWp60NSU8nQ78eMowu3FM
         Oa/g==
X-Forwarded-Encrypted: i=1; AJvYcCXO1A+rIPujHF37J0LGtaR2rg+hpMxyerzZ7T6fP3ftv86NdzeEJMYVqmTlcZcnhdQ2Xikj+IXCwIlCrQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRw1HWscEsJoG8DrIszTf5sq+mS5pVu7fw7fRO+bnTShhIRGPA
	u0/ostuUHPsLrs45mu7ektrWs+qe/WMYAJ9JusKjnZLft5538+cv45iZWiwzuITdnV+gQ0sanoP
	o
X-Google-Smtp-Source: AGHT+IGd+6QAHwLm4BRK4KI/o1F57lC601S2uhu+juKFHx8TGA5Du5HsaaVln/kyanZ/EY60PQ8t+w==
X-Received: by 2002:a05:6808:179f:b0:3e6:3647:ba55 with SMTP id 5614622812f47-3e6384b4cacmr39288877b6e.32.1730912767262;
        Wed, 06 Nov 2024 09:06:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a474asm3008087173.146.2024.11.06.09.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 09:06:06 -0800 (PST)
Message-ID: <8db9feab-0600-440b-b4b2-042695a100b5@linuxfoundation.org>
Date: Wed, 6 Nov 2024 10:06:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] selftests:tmpfs: Add Skip test if not run as root
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org
References: <20241105202639.1977356-1-cvam0000@gmail.com>
 <20241105202639.1977356-2-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241105202639.1977356-2-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/24 13:26, Shivam Chaudhary wrote:
> Add skip test if  not run as root, with an appropriate Warning.
> 
> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
> outputs more effectively.
> 
> Test logs :
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
> TAP version 13
> 1..1
> 
> - With root
> TAP version 13
> 1..1
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>    
>   tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..cdab1e8c0392 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,10 +23,23 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> +#include "../kselftest.h"
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
> +		ksft_print_msg("Skip : Need to run as root");
> +		exit(KSFT_SKIP);

These two can be replaced by ksft_exit_fail_msg() - refer to the
kselftest.h for the right API to use for each of these cases.

> +
> +	}
> +
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
>   			fprintf(stderr, "error: unshare, errno %d\n", errno);

thanks,
-- Shuah

