Return-Path: <linux-kernel+bounces-269631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7094351C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C30F1C21B87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBF3A1B5;
	Wed, 31 Jul 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fky8v2DZ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13525381A4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447854; cv=none; b=EW8ZNDkytsgkPkCzxsKj1XRq0h479fFmz2wyD9fJc0YjABxqMi/NiDTTr8Q5+mGVsPooyc+oPVtdu7jgXIc9cToz91VinXlwvYvmhlAf8we4TTIzZxSqIZDslyFETdpWcTo8TEsVirnIosd0Y70sphaYIlFS8zCbuALHbx1G2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447854; c=relaxed/simple;
	bh=8kj4IaTGSnIoJ73AMoeqJoBXV3s476EBHK5JcoCuOf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjEkq7t6IQJ8rqt1n0Ue9lle+dFXexAiSRZlXQi6SN+D1jBn/aiOy7Oi0DGs7U1K+PRKQAYaw7UAjJyNbVMTsa4s0QSsmcj5KgxlUYKkN6wLXwBGMJ8JWeu9v6t2BU1rqPSkNO5+LmH3sZrrmPuN2T1HdTpjigl0IjfirCT5+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fky8v2DZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f8bc5af74so35122039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722447851; x=1723052651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6lecl9114nb1aO1eoXo+LK+IzPR8aY11XXCBjTQO6o=;
        b=fky8v2DZK0Dq/j9SVV97FaZze8JItkKN95HhMo1XvfrbZa83oKK5h648MhRvFrxviH
         xSwv7bxNgvKFQySXcZ01b7qejnd8xswHGQZfhJk8qM06QWzcIy4ok0VWZwli4vPiswC2
         dVOMu6roG97WEM0PXKDP9AYX527Z0A2oXSnAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447851; x=1723052651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6lecl9114nb1aO1eoXo+LK+IzPR8aY11XXCBjTQO6o=;
        b=jvSoSHvSery1loxD1BeI+UUGFA15eg8ZnvNgU6189YK3e54dKqLaWs4Qav9DigysrJ
         7Cr5S71tEAE30/g+AKN5+QorOuH5DkwqpyFbi57NalrjYRty3xYrAw15KdQ0h+rzmvYw
         waboCp/LO9qpa3fIEEuVAsBxan2Ofw8vpxzxdMFILvQwxJ5D2WrwarHszCd5R9a/F01F
         HGZAiOIHEjf6CNI3JPXTv2eYMVmFPUiVpl7fykANaL/IYeu9WI7riCBdUj8yLxZR6Z61
         InitqfEiAzS2E4c2PegXaV99opKzLBTOhcPlCqAYA99NzuEyRnkSw5f6wFrxGb8CXsZH
         sHKg==
X-Forwarded-Encrypted: i=1; AJvYcCUo5vK9caHqh0YsoVBq7QM4MmNcmSOHHqhRz3Jwj3RlpYKNysbeMYlSeKMbWqzVeRAmM0Qq+ZflPR6Dm49Kj3cvKfDi1hfSAq5r4jH6
X-Gm-Message-State: AOJu0Yx75Pxdvfk6ueF/Sm93tLkoj0jJ+iZwLlW4v/vBkmMlG4W7/7+U
	W3nlrv0VdfgafneZL07KjJ30F9+nnaI9aRp9cupoagHPkX5kWu8ybOc9ssCZTak=
X-Google-Smtp-Source: AGHT+IEApGy1keF/uYZ5p9Ukh/OxeXMECiYTn6y9QEOut1KFWNxFshaLHNDidYV4n+Wbi5Z+5sQw8Q==
X-Received: by 2002:a5e:c74a:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81fcc1598b7mr2618739f.2.1722447851158;
        Wed, 31 Jul 2024 10:44:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9e64sm3331066173.107.2024.07.31.10.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:44:10 -0700 (PDT)
Message-ID: <71f31fb9-2ef4-4bbf-99fd-83e30d6e9422@linuxfoundation.org>
Date: Wed, 31 Jul 2024 11:44:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: Fix grammar in an error message.
To: Chang Yu <marcus.yu.56@gmail.com>, ebiederm@xmission.com
Cc: kees@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 chang.yu.56@protonmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <ZqCBSPFfMeghhRGQ@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZqCBSPFfMeghhRGQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 22:21, Chang Yu wrote:
> Replace "not ... nor" in the error message with "neither ... nor".
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
>   tools/testing/selftests/exec/execveat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
> index 6418ded40bdd..071e03532cba 100644
> --- a/tools/testing/selftests/exec/execveat.c
> +++ b/tools/testing/selftests/exec/execveat.c
> @@ -117,7 +117,7 @@ static int check_execveat_invoked_rc(int fd, const char *path, int flags,
>   	}
>   	if ((WEXITSTATUS(status) != expected_rc) &&
>   	    (WEXITSTATUS(status) != expected_rc2)) {
> -		ksft_print_msg("child %d exited with %d not %d nor %d\n",
> +		ksft_print_msg("child %d exited with %d neither %d nor %d\n",
>   			       child, WEXITSTATUS(status), expected_rc,
>   			       expected_rc2);
>   		ksft_test_result_fail("%s\n", test_name);


Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

