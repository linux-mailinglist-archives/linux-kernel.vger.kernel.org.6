Return-Path: <linux-kernel+bounces-308869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D929662E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B651C21E24
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD49199FCD;
	Fri, 30 Aug 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFu0Bp1v"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DF1ACDF2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024480; cv=none; b=o+QsPel8yz2NKiboQ0Cfz8MGxwuFeZNoYr8hahjgy6h/zkurCDEMfHpYf92TSIWXwxTbXzYp0SoKst86SGd6T/g/zUQ33b8FRTz+JJmwFJPFVik0rqUW6nZjb54uZCT7Vz08kpgkTsYqJjsCDZC+Okx9QBOIh5dFAL0nWFGCf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024480; c=relaxed/simple;
	bh=p2wn1LNLdYfziJyiiWzFLiZ1Mse6IK/17b+3O1mznw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wu3zLp2zV8TaAyibU2oktxva0b1Pc+GwlOb55GijP9lWwXGVoUBU5Pez+8WspaD7Vbcg3/CJ9CiCaiCgHeZpyPWGykbwBYlWMMZBs2bSCR0Jpmmfe4JnX/4oJt3ezXokXw4cPJ1L78Dwo5GfPWSnXtAefld7Gxzgp3yVezMpp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFu0Bp1v; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70df4b5cdd8so1182645a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725024477; x=1725629277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzO+G25f8saT1bkAkXCx9zRFYZu+Bejb/RnNLhu6+A0=;
        b=MFu0Bp1vppNVZJ33xA3Mw4ZxyDpitwESvs78VvBh0cHE/ac0VDes+AAbu5XaEjRWz0
         MBHPr6fsqwzz22JK5prUZd6FtnkMnnMn0fI5XURSb21RGSptnA8mx5VRC4D07g9nzPfs
         1Ti8LpfZit55kh5+NPVeN4POprtXy3HvJCnRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024477; x=1725629277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzO+G25f8saT1bkAkXCx9zRFYZu+Bejb/RnNLhu6+A0=;
        b=PMdpRY35mCF/thRGR7e48ztejbwQP956XK5ufwmnUc7Y3jZInwRh2a+ZFYhn4Y9ZvR
         btBpZyk7bMODrJ+a7nPU5mSVqbJBma36yrgK5awpX5MobZExWef/pUY/d2BLx5pCLEnA
         TEKf4MBCdwGsoKbyHKkMGxoeg9zlVgynA7IzFSUrC4yzYFYFkouROomL7HDo0PrTCv88
         PzFT3wKzNSewhBgvTNYMn0P/g4voWBkHGhkQk5ZmgHa/MpmVovMbaGcqfeI58WbqIp6k
         ymVOFRTcobvzFArjPpXdNJUM2c/CLqZAN4mDv8Ae6eYVHEE25UL/3UdpxXqiyejtvMc+
         ++iA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+/yhOu1L10czsv6BUWR9AkDL7tGjoxduUWReel6R9DRF3kr6xDaSrv77N7hTQ+MpUTGTtZP148plRtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFo6DyzqrJqQ23r/14yFdO8sZSCKajuypjUPt/JyZ2CprWL9qO
	zoke8mMi2fNkF5pG3SJZs1F8zNZ5b/hgBD/NdOGH9Y9Xsw2y/xMBa3L7dkIPGIM=
X-Google-Smtp-Source: AGHT+IH4Z4a4eNpdT6poNqlaMWEeHBVBQk0Fnx5t74ySm/SraCam6wS+xqO+N7CgMvBNJL63b68UJQ==
X-Received: by 2002:a05:6830:3c86:b0:709:4226:a61b with SMTP id 46e09a7af769-70f5c3973b9mr6402246a34.5.1725024476674;
        Fri, 30 Aug 2024 06:27:56 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340dad4acsm14470176d6.132.2024.08.30.06.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 06:27:56 -0700 (PDT)
Message-ID: <e6027cfe-1a5e-424d-8ba8-f153d75b774e@linuxfoundation.org>
Date: Fri, 30 Aug 2024 07:27:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Fix build warnings for ptrace
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 Catalin.Marinas@arm.com, will@kernel.org
Cc: broonie@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
 aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240830052911.4040970-1-dev.jain@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240830052911.4040970-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 23:29, Dev Jain wrote:
> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
> introduced ksft_exit_fail_perror().
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/arm64/abi/ptrace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> index e4fa507cbdd0..b51d21f78cf9 100644
> --- a/tools/testing/selftests/arm64/abi/ptrace.c
> +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> @@ -163,10 +163,10 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
>   static int do_child(void)
>   {
>   	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
> -		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
> +		ksft_exit_fail_perror("PTRACE_TRACEME");
>   
>   	if (raise(SIGSTOP))
> -		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> +		ksft_exit_fail_perror("raise(SIGSTOP)");
>   
>   	return EXIT_SUCCESS;
>   }

Thanks for doing this.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

