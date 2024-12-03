Return-Path: <linux-kernel+bounces-430234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D419E2E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3540B282F53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B0209F5E;
	Tue,  3 Dec 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1oFMMPq"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BF20A5C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262037; cv=none; b=fX/0zuSm402zh9aQshuDoYWqzNhKmvNTgqNNWcgMhWOXaT2VDA2fnQkfZNquKP5lBcILneOyXydo8eENUUrx5HmJUjI6gngm4KX3srieoPGgQVZjjZnjNSlrAfAwr8al/2oAQUZlewyCSxVs0ZJRAp/ohDGoG225GOssaqEzSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262037; c=relaxed/simple;
	bh=TL7NNcboBRw+u0U/0XJWPG/O4JlBO8FBSu18p5zeI7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeAypGN4O9ep3hvHPrMITmCVL7+D0KIuiFPwUw/JNQAUQ+gcxl1YvmEluyt9FubbxlioexwsVR2QpFtRU6JPG7eFip0TTlNcnvMnYYhyy/c8FXi9ObeKyKhiRGzFAQ9ZyLrKqOBOCTU2BRUkWegEOIlhYlC4m54eRCug0mvL2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1oFMMPq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a7a2c7a9dfso27136205ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733262034; x=1733866834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qM7KSOsD8erGpBwu4XmxDy5UG6JA4dUx7y9RJZFxbcY=;
        b=Q1oFMMPqFijd7WRWehz2CEHCS8HybkVkaUwacU3q+0OHpuUyscgrEeu2SRcgb7P5qQ
         9J99xzvizCUt3LMZyXBk5JYoiivNKxGNTsLTm8IWtx8uuhEqvKOi4NjZEsHEvMwOu8nv
         TGtSbSWkk96BibZ8XorxP16HsfNcGbQtYEd9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262034; x=1733866834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qM7KSOsD8erGpBwu4XmxDy5UG6JA4dUx7y9RJZFxbcY=;
        b=NGxplc2QTf+FnyTfLCZaM3y02qV4AMqSO6J5bJNn90oHgVeEOJwYat+N+5mgls6eoX
         Ko0K2bEFUBy3EALDHywNTBjUwyyMRHBWIxeajl3z55r+GSmzUtKsB3q76kueOS/jJIS7
         na4gXPFbRo/Bb3pQtn3lMkYMsTEAeNsXq3g1/ig1+2UbvdKQn9iT7P1mx9JWcDvPMWNb
         VzTWpDpJY/0xgJZKDvBUWAaFfd6nWhsIv2nzj7/3N+VP4q24COqvGQGj5mqaiqO8ZlGT
         Wlkc3Qk+cqgmFAM6XE9JytIOViafcmZ6AnGltzTaAnB2QyoKVh/BDuZ/iL4N6ylV0aHh
         vm7A==
X-Forwarded-Encrypted: i=1; AJvYcCWiQ3sZdI871Aq7OET0gI0DEVxeeL4sGEmNo0cWPCAMS73rMozvqTuwDBg97bROu1FMhgZcPjDczd/NNgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IarabuIhXuy7PK7Meeor1Ahu7M/CRvBs11M71YrKKbHZvrcg
	G92Z+CRJ/TkVlP7Vz9OM5KrXiROBAbPhRcC1Nm/TWSqotSNiNs1Jo1cG70MqH38=
X-Gm-Gg: ASbGncu5A1dI/YF7p8HcQj6wxAZKtUZw9Zs1GRt9RQGp3AptHZxkFAA/19bqTvnePnK
	UWvBi/DU6fDvouPgekQjEMq3hLJZGXRHdTIWzsoPtxGQaCPFkp8FE0Sl8X4P8+sXmWyOHNkFshW
	LL/MEvIw4nOGIBrG3eYjkgTLeSWG7oZnXxeYNpFKdP3CvHaZ1D7A/+GbiYiQ9vloUWweyKu1CL/
	wOkUh00EfdmR6IKOCftNBEyW2ApLxdMhXQclfT/IVRZZ1hW6RXnhKqykz5FjQ==
X-Google-Smtp-Source: AGHT+IGcCgiSiPMG4IWRRA7S3qbf0jUp6oiRy/fO5CjDu0IzR+tGuqUjn0+sxzpQiSkobfCdAbWyGw==
X-Received: by 2002:a05:6e02:174b:b0:3a7:5cda:2769 with SMTP id e9e14a558f8ab-3a7f9a4e226mr44814475ab.12.1733262034454;
        Tue, 03 Dec 2024 13:40:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7e9380606sm15800645ab.57.2024.12.03.13.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:40:33 -0800 (PST)
Message-ID: <1e770394-00ab-42c0-a940-97976993184d@linuxfoundation.org>
Date: Tue, 3 Dec 2024 14:40:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: acct: Add ksft_exit_fail if not running as
 root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org,
 abdulrasaqolawani@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115191721.621381-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115191721.621381-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 12:17, Shivam Chaudhary wrote:
> If the selftest is not running as root, it should fail and
> give an appropriate warning to the user. This patch adds
> ksft_exit_fail_msg() if the test is not running as root.

This change introduces a problem - skip is the right exit code
when a test requires root privileges.

> 
> Logs:
> 
> Before change:
> 
> TAP version 13
> 1..1
> ok 1 # SKIP This test needs root to run!
> 
> After change:
> 
> TAP version 13
> 1..1
> Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   tools/testing/selftests/acct/acct_syscall.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> index e44e8fe1f4a3..7c65deef54e3 100644
> --- a/tools/testing/selftests/acct/acct_syscall.c
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -24,8 +24,7 @@ int main(void)
>   
>   	// Check if test is run a root
>   	if (geteuid()) {
> -		ksft_test_result_skip("This test needs root to run!\n");

You can change this to ksft_exit_skip and keep the same message.
> -		return 1;
> +		ksft_exit_fail_msg("Error : Need to run as root");

This is incorrect - should be skip not fail. There is no need to
change the message.

>   	}
>   
>   	// Create file to log closed processes

thanks,
-- Shuah


