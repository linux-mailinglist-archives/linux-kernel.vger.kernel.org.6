Return-Path: <linux-kernel+bounces-409651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFF9C90D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DE1B27B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81D165EFC;
	Thu, 14 Nov 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BfElo0y8"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFF1632C5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601515; cv=none; b=MbqpYLJyLpJrihsaor032XZ50FauJ+5RLMlz7xB1+zxAHuAT5JdHuG56/aYjKZwv1lXR1ouLFN/J+jDSSmsLCshMTPiC15/0SoUosYoFuvs/ZRMlDu6x8M4r6Mnt0FFXKDoUleEOflLtkPx+lodantaTlcVZbjwQ45v/BK7Lxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601515; c=relaxed/simple;
	bh=6Ha7uxNaK+n9PEyKhZrLgUrNGlLriEL3O6jXb4Jz4qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT+e6m2K920cdxxewVEZGtEaoK4KGZrL7hYEW0tXuu0jWMjE4+1/ys58Poh906DxLsbzvQPRlDBazfeT8Ems+Mz/hokrSTOW7q3arDff08ZW0XiBkp/HzpDYZTdUaUKQWIKv4HamMxIzVf985pKX+fYR9MUA2lIc+6c11oqDMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BfElo0y8; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83e5dd0e5faso29130139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731601511; x=1732206311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buo6iWrbAJctceKC3COg5WA7QA2TRFr7kULc06jQepM=;
        b=BfElo0y8QDoUpmv5PbgtCf6jFIemt56fdsjMi1o2v0wjzYvOgLkeDKyjYBtWVadIoY
         TtFcp1yVlnzsS/z2kLR61vRxDFHiPiTv3QFo0JWXHst/VBTPqWplAwmTV+0ONZ6F7QIQ
         VgbObEp4oLG2iGEFswRSwLEmhJyt3GghD1Yec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601511; x=1732206311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buo6iWrbAJctceKC3COg5WA7QA2TRFr7kULc06jQepM=;
        b=NrwthuitRyAn6BAvKCHNEzwa+LTqKz9RTc8vYVP/ANx0QOrP0RcwDfHIQKUpf4EAsL
         wfbLmBz2kqMl2yAET8otYBQruf1YjxoSr3WofVgqIS2FD79yNh9SKtgFLuQMskN2ay6E
         3VLas0d/sVSS3BwZCCCnsz6/nzXl7i/s9a0PrPmvITAqRsRkbaEMOPWqGYgoX6OBVpTQ
         9fz2i+BOjT9W5m/ErrEeeksj5Q3s7C+FgO0ZhbWJLA4o1rVpVX75LA5d8DwHsD9eZHE6
         r7kv/4cHqeKRF2iMGtXHEkIBqkYdymKhjadCZsQnIma7X4LOzYWo4GR4M5lI8tqbxkak
         +xUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJYLC600C88P5gpC//3ZfvMxc7Evpap4trDUtYwVs36u0hX2INqnhoiKM3tJ329rbAcMsmqIoAq/4s75o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyYPotjbSlbDbtmrQnhTmjC1JUP3C9lqWmWeNKdyZN6D/4D+A
	23YoCB9roqkNT93WI5iilCgZg7vKWxOaU+v89iVqQTHSIrA27oSaRGyOSW6uX5I=
X-Google-Smtp-Source: AGHT+IGrmfnV9irE2RmqR2nu682ZNoHCBmmsGPW80Shl2133F6qXCefXE/lr40u4emN9zp5hCGdmsA==
X-Received: by 2002:a05:6602:2cd2:b0:83b:5306:d24d with SMTP id ca18e2360f4ac-83e5cd3f503mr373740939f.6.1731601510897;
        Thu, 14 Nov 2024 08:25:10 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e6064446esm33821439f.48.2024.11.14.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 08:25:10 -0800 (PST)
Message-ID: <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
Date: Thu, 14 Nov 2024 09:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: lsm: Refactor
 `flags_overset_lsm_set_self_attr` test
To: Amit Vadhavana <av2082000@gmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, shuah@kernel.org
Cc: ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241112182810.24761-1-av2082000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112182810.24761-1-av2082000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 11:28, Amit Vadhavana wrote:
> - Remove unnecessary `tctx` variable, use `ctx` directly.
> - Simplified code with no functional changes.
> 

I would rephrase the short to simply say Remove unused variable,
as refactor implies more extensive changes than what this patch
is actually doing.

Please write complete sentences instead of bullet points in the
change log.

How did you find this problem? Do include the details on how
in the change log.

> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
>   tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> index 66dec47e3ca3..732e89fe99c0 100644
> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
>   TEST(flags_overset_lsm_set_self_attr)
>   {
>   	const long page_size = sysconf(_SC_PAGESIZE);
> -	char *ctx = calloc(page_size, 1);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);

Why not name this tctx and avoid changes to the ASSERT_EQs
below?

>   	__u32 size = page_size;
> -	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
>   
>   	ASSERT_NE(NULL, ctx);
>   	if (attr_lsm_count()) {
> -		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &size,
> +		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
>   					       0));
>   	}
> -	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx,
> +	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx,
>   					size, 0));
>   
>   	free(ctx);

You have to change this tctx for sure.

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Paul, James,

Please do let me know if you would me to take this through
kselftest tree.

thanks,
-- Shuah



