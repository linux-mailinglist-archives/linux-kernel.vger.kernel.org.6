Return-Path: <linux-kernel+bounces-375131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788A9A9157
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BAB1C21BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD151FDFB8;
	Mon, 21 Oct 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKXNTed6"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E51FBF56
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543023; cv=none; b=nTzrCrQtYR0klsOQqhtosEeJbkg7TyDCo1JEsX3ms+6D/yK8ic6d/ONbaD7x2ZnxpoSHe/d7JYFw2C5OCcSB1FwLYmOSCgqd1jccTySwRHcO4JVlVYl8uYpkzK2QXOga/T2klWpdsQOCsmli6Tsy+3FVYoNUyjhwSyu1Km3bAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543023; c=relaxed/simple;
	bh=3BLj+3yhD748I/r0mF9XZVwihCLj7hfN2EkqM3NrUIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAEw7kWlk3Y+xCl5lZJvvExW+j6XNm019O4X+jpvB/iR6aTOkJt8LwYtG+WG07xOSfeHcrnVOug4HTZhFZQgnPIsxc3QQDB/yE5lpWvstuWlqhkLjuZhYioS5GvE3KxQY0dZkkP95YXeg28lctNoiMDj342e8WH2NYB9kl+pU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKXNTed6; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83ab3413493so157606539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729543020; x=1730147820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LDzS8XBxlPJ8LeGX1kjubIGqVbUJ8pCbQpYyZJmaIw=;
        b=CKXNTed6y37vETdFMkTIROyMUBi5n5WSeDuUG5+4C4mCE1aD4kYhXyoAWFECjb34ES
         eadfKx8Qq/PgZGjb+dolOPauLfE0xKZcYWlHyd5NwhJdY6r14lqzVVU3N86JM6Nps2u7
         8DPdbZsjNXuSARgtwssQOEvl/zDLL7GwuMSpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543020; x=1730147820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LDzS8XBxlPJ8LeGX1kjubIGqVbUJ8pCbQpYyZJmaIw=;
        b=bRhI7x7Uqgf/wajf6/iulsJI+e2lmRUJKFlXTzuTI294wu/tQ+tIUZHiuLy09G5iTI
         j4vg+04O/5/XRwZ6BaZ0XOpeIdga3He5TP6WLITMTiY0A7bT1jStJHTjh2ec8GTxjXgm
         8G3rVb3DYhQfGq6cgls2IKT9OAxdD/vHA81IbZwmYAE+N0Z/ll3Q5DynnUo2zCiNir9i
         xtw1c1rNlWiN/4JrubbR/HJc/31w3bZriIT+szW0nTMzfjljGghtVhEYXhmU66C+R+aM
         ieEINahvDPLZQv/0UJZROaZlH1b4EG1AFqSPbXyIiDnlrJOfWbiIFFZkUxaIuxt+io1T
         cfKQ==
X-Gm-Message-State: AOJu0Yx8YRQKZZriinU//8M+CFz0eodtt3OBDhvm2e3ApvJPvX639Xml
	h1DgAVa4ZPCBgdHpRHIn5RzvOvS1zzWmgaxnIqtlEeoivZKa4JE/S/FqJRI3frhXJvJcgy+NxFK
	6
X-Google-Smtp-Source: AGHT+IEig6+d2k16HjNVgjv3iEenex2U3S+h9GabtGXCrH8EGB9qAuXmoSN7JYXZE23N3jGZCOBnig==
X-Received: by 2002:a05:6602:6018:b0:82a:3552:6b26 with SMTP id ca18e2360f4ac-83aba66aaa5mr917333239f.15.1729543020429;
        Mon, 21 Oct 2024 13:37:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a661aeesm1205668173.179.2024.10.21.13.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:36:59 -0700 (PDT)
Message-ID: <d8cfed44-3bc0-4774-b39c-05fa0b82f6d8@linuxfoundation.org>
Date: Mon, 21 Oct 2024 14:36:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] implement set_enabled functions on powercap.c
To: Vishnu Sanal T <t.v.s10123@gmail.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trenn@suse.com, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241019124233.194140-2-t.v.s10123@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241019124233.194140-2-t.v.s10123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/24 06:42, Vishnu Sanal T wrote:
> Implement the functions sysfs_set_enabled, powercap_set_enabled,
> and powercap_zone_set_enabled on powercap.c.
> 
> Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
> ---
>   tools/power/cpupower/lib/powercap.c | 43 +++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 94a0c69e55ef..1cf2b0de5536 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -70,6 +70,29 @@ static int sysfs_get_enabled(char *path, int *mode)
>   	return ret;
>   }
>   
> +static int sysfs_set_enabled(char *path, int mode)
> +{
> +	int fd;
> +	char yes_no = (char) (mode + '0');
> +	int ret = 0;
> +
> +	fd = open(path, O_RDWR);
> +	if (fd == -1) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	if (write(fd, &yes_no, 1) != 1) {
> +		ret = -1;
> +		goto out_close;
> +	}
> +
> +out_close:
> +	close(fd);
> +out:
> +	return ret;
> +}
> +

Why can't this all be simplified using system("echo 1 filename")

That goes for existing get routines.

>   int powercap_get_enabled(int *mode)
>   {
>   	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> @@ -77,12 +100,11 @@ int powercap_get_enabled(int *mode)
>   	return sysfs_get_enabled(path, mode);
>   }
>   
> -/*
> - * TODO: implement function. Returns dummy 0 for now.
> - */
>   int powercap_set_enabled(int mode)
>   {
> -	return 0;
> +	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> +
> +	return sysfs_set_enabled(path, mode);
>   }
>   
>   /*
> @@ -180,8 +202,17 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
>   
>   int powercap_zone_set_enabled(struct powercap_zone *zone, int mode)
>   {
> -	/* To be done if needed */
> -	return 0;
> +	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP;
> +
> +	if ((strlen(PATH_TO_POWERCAP) + strlen(zone->sys_name)) +
> +	    strlen("/enabled") + 1 >= SYSFS_PATH_MAX)
> +		return -1;
> +
> +	strcat(path, "/");
> +	strcat(path, zone->sys_name);
> +	strcat(path, "/enabled");
> +
> +	return sysfs_set_enabled(path, mode);
>   }
>   
>   

thanks,
-- Shuah

