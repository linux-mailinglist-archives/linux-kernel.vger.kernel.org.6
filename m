Return-Path: <linux-kernel+bounces-210594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42069045F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182A71F24CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07314D2BF;
	Tue, 11 Jun 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HXAtt4Yg"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA01CD16
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138935; cv=none; b=mnB+wJOTybaAgnc7fqYFRWguaoy7z7UN3AOEos8VyZtRk/B+wq5CVLsEbckI6aGaDl7CMAGQzZGO5uiKpva4vZQhPc/VGSV0uAUujx8T0zs/9AeIHkupRN1U5v3FXX0+dZI8LDlJWzqrf2343kMpcmf4BtaiOrKEVAlXcRPiqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138935; c=relaxed/simple;
	bh=pJf6oJLRj6fBaf0jbjyNj/7Xde43wr4W4HUXec5nOYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sf/HuPu2CgVvQBidyJjP41JK8KyT+0Gk+KAzrjKEo/bcKqRQe7cac2OKOUQRkVfBHXbTtayB5SbF3GytIsQVKMQkX3jdoa7FFZlCl8TtPLgN7/DdWigt7aEO6eU7/dQIMQ6e6uMf5DBTtUbzmnfOoIiEuI3eI+9g7BKMxfnbJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HXAtt4Yg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43fb8cdb29eso4989631cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718138932; x=1718743732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y79weTWNeYH3OHuSeVZfaP6Dxpg6/VhmFQcWq0YiWSw=;
        b=HXAtt4Ygbe7+VefOwfV0otOanwNSQyqJg+uJzzSw5x1Z7kj+7hdUAuwMm0dBr3VWMI
         cnZAYOA7TUz9FTMBZAQwiDzesbLsPLHfdlQaq4PHYvyNBGYACpkbbOaFuy3OSc1HtkXu
         wEYIzUQJOSAyEWlVN3PMiYtKOkodP5mv7B2EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138932; x=1718743732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y79weTWNeYH3OHuSeVZfaP6Dxpg6/VhmFQcWq0YiWSw=;
        b=qiqQ+usPdikus7fkzeOfbPRIbfFX5zm7xXZst7G0N2oC9+U88e5gLNNrOnrkeHMZYD
         sy/NWZYRYGgPUlyL+fa/fiySZ20Swob0rl6k6RZfNuiqvARWccWXd8ZJfpwB+nGafpZ+
         siAl/BbYX+C4qFjdbrGR3+5IEuFh/CRFjYyryEkypJbehH+ndHFruQtD4S+H/5YOPoFe
         5DCu6DRW3oT3qYqJwP60Jm0HiozrTt8g9ORo5tAeVSLXQDryDmvo39SUVd3LFFiDprHZ
         cdbXqiWGAEtspooy7eAXIbYa7PHFdt9mb1V7sX68jmnGxsCpvJwmekLJ4/9+OuktihPv
         fDew==
X-Forwarded-Encrypted: i=1; AJvYcCWV5txGYhxT4SERjqLNnYGExGbEgJBDjd1tl0AjCqJaw2/4Oz3DBzpUCk23K9WvEvfNvGRE5wXuOxmDpIEHJPsvC8adT9lW7uklBwxf
X-Gm-Message-State: AOJu0YwD8mZbJ80AzlZkIDzeCssdh/UfaVeQ0ZPV9+3+pBBza0jy5dg+
	2cPWynVohzaJ7B4cr+0NTczqr5C8grISCqww3KUnIxDslRokETdIGHIOllTWmtg=
X-Google-Smtp-Source: AGHT+IHRldpAykaEnON3fBkB9QBArbrfuwvf1Dd1I+MToHaIlihAs8rpCVdS2ZOXDCs9HpZv/ySYzw==
X-Received: by 2002:a05:620a:4886:b0:795:6b7b:6923 with SMTP id af79cd13be357-7956b7b6b78mr783398485a.3.1718138932170;
        Tue, 11 Jun 2024 13:48:52 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79568fc92dasm251822085a.84.2024.06.11.13.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:48:51 -0700 (PDT)
Message-ID: <d6c5ba89-065b-43d5-8584-0c1effa50c07@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:48:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/sched: fix code format issues
To: aigourensheng <shechenglong001@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240611051834.2885-1-shechenglong001@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240611051834.2885-1-shechenglong001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 23:18, aigourensheng wrote:
> There are extra spaces in the middle of #define. It is recommended
> to delete the spaces to make the code look more comfortable.
> 
> Signed-off-by: aigourensheng <shechenglong001@gmail.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 62fba7356af2..52d97fae4dbd 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -42,11 +42,11 @@ static pid_t gettid(void)
>   
>   #ifndef PR_SCHED_CORE
>   #define PR_SCHED_CORE			62
> -# define PR_SCHED_CORE_GET		0
> -# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
> -# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
> -# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
> -# define PR_SCHED_CORE_MAX		4
> +#define PR_SCHED_CORE_GET		0
> +#define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
> +#define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
> +#define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
> +#define PR_SCHED_CORE_MAX		4
>   #endif
>   
>   #define MAX_PROCESSES 128

Applied to linux-ksleftest next for Linux 6.11-rc1

thanks,
-- Shuah

