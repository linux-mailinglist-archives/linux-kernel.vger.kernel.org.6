Return-Path: <linux-kernel+bounces-261503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44693B80B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8681F21D71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78C73446;
	Wed, 24 Jul 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXRD21sY"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5620134405
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853150; cv=none; b=H8U3zp/jd48XR7WGQ3wo5bRUCtZ4pL1qhVyPeuWi1ApE/h8hfQ7gylSuswZbzhXnF24jZkk5x5JkgeRr3LCyxZfwMl7a4TmhMhuH8ydAKq+VzHf+8mQaS0ewnRSg0OVHj1ykutaGAlnkr1orPmIbUdfgGsvD9PuYh1KzPrH5Whw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853150; c=relaxed/simple;
	bh=N7tzuBatwvbK0zk6wfxUl2xqOQ/0ckqDXNdjnTzy7rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8UpRIvUpIwfsIHm+ILWFY/WoUeKN2CzG6wTKbl4uQhELnU+PEj3o78FLpy5cPdUbYGwX6bGtJARFLSUoSP4a0tTHGbthMezcnfVUjTKfwuwEbk/FW0NBPtlochZteWqKObWi2HY6YCySGGl+vZRKDBA6ZL2l+Zg7KYKprlpCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXRD21sY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so32374a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721853148; x=1722457948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfRUOZyU0ZZeZz6fU57bDtE2iUjP+Q9MDjhZaXIO9S8=;
        b=DXRD21sYe0f/v6q+9NcnK6W58g/FnqXUKsJb+qil6aY92iqovQqKUi2w3h1FRIcCcz
         ZrfvUqF9rjX6HmHqtBmSQ8Ke40Pu1P9YrmvVBqAc4E5z+DRCZ6oOwiWtwj2LVCWbIx5y
         qWa7Byx5BfXayNZVdhA2JAOyLoUr0YXaG5sIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853148; x=1722457948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfRUOZyU0ZZeZz6fU57bDtE2iUjP+Q9MDjhZaXIO9S8=;
        b=uT8H9TKnAItgNKpeIy7h8Fe3CvP3k+g9qjl58wc4ZGnSdW/Mi/ts1UWqhOd4qMZYja
         cLe+Ob0yauDzNIjTJINdWp6ze/FKPTIOqBeWdlq9eSOHXKqnPXq3ggRqAa6ehMijdoFW
         fKpwBkT+JRo09Iz8G07o6Zr2HmgGh7FDsts1B13JM6IADk3eeRxLBNS8WdH9LwpnsPoA
         3bXpZ8GxF+8k0tFHJQ4yzrqJpeK8YDe8p9oV4Xws67EggEKw0RtFQ7cOgID1jX4ljSUd
         RD1tKhpF7GlP6K2l83j0D/wUgb4NZE85ETP/CeG4gxVPx7omzf/ehWJQVs53mupg2Oso
         OqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1O6QsV5fxxJMvhHotGZLy5c7k3y58805bTeJcWediFyuqvEitIinlbyoQ4qbwJm999qRjHWkLQ8W9ry7/diINkl1Jv6K4m77hvqn2
X-Gm-Message-State: AOJu0YwD5A2D+AESjT/q1aS6yj7Xc9i9Mg34gvoMCXcV2dbbW3YGWBtZ
	abK+r2XJHsVhTcxeRGGxyYdAyNNJtgbugP0yQVhX4eM+aYIM3vP9PnWe94WDGkE=
X-Google-Smtp-Source: AGHT+IGCLZQwtPr52EaaK/1NDYoQBJLK4J6naJ4aMGWh77k+3IqF5nWwdqZBk6aLPMYn9FKHeej9Sw==
X-Received: by 2002:a05:6a00:8598:b0:70d:18e1:441d with SMTP id d2e1a72fcca58-70eac7b28b2mr224470b3a.0.1721853148048;
        Wed, 24 Jul 2024 13:32:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2208ce12sm6082637b3a.174.2024.07.24.13.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:32:27 -0700 (PDT)
Message-ID: <d7601a03-ba82-4a7e-bdd8-6cc23dec812c@linuxfoundation.org>
Date: Wed, 24 Jul 2024 14:32:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests:Fix printf format string in
 kselftest_harness.h
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, zhang.lyra@gmail.com
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240724062624.5157-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240724062624.5157-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 00:26, Zhu Jun wrote:
> '%u' in format string requires 'unsigned int' in __wait_for_test()
> but the argument type is 'signed int' that this problem was discovered
> by reading code.use macro WTERMSIG like those above usage to
> fix the wrong format specifier.
> 

Now the commit summary doesn't match the change you are making.
Also WTERMSIG() is incorrect for this conditional code path.
See comments below in the code path.

I would leave the v2 code intact. How are you testing this change?
Please include the details in the change log.

Reformat the message to too imperative mood.


Check Documentation/process/submitting-patches.rst for details
on how to write commit messages.

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes
> v1->v2:
> 	modify commit info add how to find the problem in the log
> v2->v3:
> 	Seems this can use macro WTERMSIG like those above usage, rather than
> 	changing the print format.
> 
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index dbbbcc6c04ee..f41f4435e9a4 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1086,7 +1086,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		fprintf(TH_LOG_STREAM,
>   			"# %s: Test ended in some other way [%d]\n",>   			t->name,
> -			status);
> +			WTERMSIG(status));

WTERMSIG() is not the correct call to use since it is not a
WIFSIGNALED conditional.

thanks,
-- Shuah


