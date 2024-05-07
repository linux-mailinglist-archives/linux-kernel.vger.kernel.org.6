Return-Path: <linux-kernel+bounces-171930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890658BEAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C262819FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895416C85E;
	Tue,  7 May 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHJYTVhB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506E1607A7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104151; cv=none; b=OUcgeA4gWbPBlL4IMoIjJ1zIL2HgFP/fr3W5Mxdrnc411AFE1uR9RmrUhdBpd/ZpLv67Qj4E+R1tmLTGh8Py+zvd3QJUTUWLHiGjc4fJ2MgOV7Ovz31x9Cl9D5L7l//mu0wJ29yDf5n2/B6Xc/C5GzTUlCmRm/s84E8urI3J3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104151; c=relaxed/simple;
	bh=pwh4kKnyJTvJNbrZR87w9WNS7/BMALHW64bn1krHADg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sEBN9pgf75m2EcQohOA2/ksTYI6Y6XuBfcw80IcqLvNy6zPihPgZtjKpLfRRMLVE8VOtBCanZdu/ZVVktiUSf8k+pphzGhZ8n21SaMPqaE+bLZVGPIMhz9youQ/6uawoTFHvejZcMTaNe+Jz8w4JYv3sSqV49Ccr4Bfmvklk6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHJYTVhB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a86fb052so112962366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715104148; x=1715708948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KzNsGk04Aj/iaOaD0uQRj7sJlFSLSEs6o0qY1ztONQ=;
        b=hHJYTVhBDZRgrg5RqswHinfPStn8JnrTZGcUNUItjRn/zlDRAYtpV4oX62bJi5RQ1x
         KBF+ZWdAZVLR8ZW5riuZJiSs2Wnu78VdPUyqfh/AcBWQX9cz86vRsM07Cbq+7vAtV8Y7
         2aNeXzARj5PAjb89JcyqXMUXJYvEHtXoByzedD0Ioz2EK9SpJhWLYgkmfLt8pQUF1ixB
         8JXe/fplQc02xvv0sbeoKcerfzM4R176pCO7fn6q6lgcbmeo7gc3iaHFuZSv5b/slt7+
         fOUKXMoHApvLo3ixlBQl0I6Z42q+VjebbcU+UmjUbViqsf7L5PVqlFHW3pJUgdHanhlL
         kwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104148; x=1715708948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KzNsGk04Aj/iaOaD0uQRj7sJlFSLSEs6o0qY1ztONQ=;
        b=NqGMe2ibfC9Ad/NYYlAwZR0msflTrapo4yz058m2NTmmLtm9cNVnkFmY96fZEUQDlQ
         ErEQJTdVnTntHciAFwOt2HTUSzygocgZPpBfUL2rnn2A8i0G1r2nwF4y2lkeQXSw+AAm
         I7UGV4h/PjYg1zEMbk0W4zgZ4CdtgvkleZUtgaowwKmjTseCCTIsuyCjM31NmFEdGz1v
         3DJ/ms+PUHutVRVfxmaE23xya+v4MOGImZtU1vcmeN4+eRNjpLaAQGXS7e7/PYP3HBeW
         rIgWX6MWWni3c8JYLwJ6grn7idXJ62o/cDmP0UEENerosAo7VZyz5mr8YMxQr/YmPTGJ
         3tNw==
X-Forwarded-Encrypted: i=1; AJvYcCUH0g3niQ0sWRIhvfz/GpFw543DV1c2HsGlJVqoSsOH+zXcthW6Zp+D/Muo3aKUvza/y+9KSQwlOEWefmYMGdpfqx0mPnO7GwTwSXMJ
X-Gm-Message-State: AOJu0Yx1g85BU/vo3FAxhMfINarM97TvcKaRCZ1wDIs3bazXMQ740f5c
	6Q2FTLcRQC4b9a4lu9+jXObI/SQDmBM13SBRCV52gpNcgPEO3/Lr
X-Google-Smtp-Source: AGHT+IE5DMX+XI/tzZLisS11tES8cNFOzvMrHLvepHpBfRDTKb+hpqZQWQrvtTKVVJucSTr7rAL40w==
X-Received: by 2002:a05:6402:401e:b0:572:65f7:eed0 with SMTP id 4fb4d7f45d1cf-5731d91696bmr355648a12.0.1715104148260;
        Tue, 07 May 2024 10:49:08 -0700 (PDT)
Received: from [192.168.0.104] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id fj20-20020a0564022b9400b00572336c900asm6554848edb.74.2024.05.07.10.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 10:49:07 -0700 (PDT)
Message-ID: <42016d13-b69c-400a-98a6-f34db6dd3e06@gmail.com>
Date: Tue, 7 May 2024 19:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging:rtl8192e:fixes unnecessary braces
To: Chen shuo <1289151713@qq.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <tencent_1423E8EA63C9C00B49636738FF1050480C06@qq.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <tencent_1423E8EA63C9C00B49636738FF1050480C06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/24 14:13, Chen shuo wrote:
> This patch fixes the warnings reported by checkpatch.pl
> for braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Chen shuo <1289151713@qq.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index e3ed709a7674..1862a9899966 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -1640,9 +1640,8 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
>   	if (stats->Length < 24)
>   		stats->bHwError |= 1;
>   
> -	if (stats->bHwError) {
> +	if (stats->bHwError)
>   		return false;
> -	}
>   
>   	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
>   	stats->RxBufShift = (pdesc->Shift) & 0x03;


Hi Chen,

Please make your "Subject" line more unique. Consider that we may end up
with having dozen of commits like yours, all of them referring to
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

Also typically we use space after : and driver name in the subject.

It is not required to add the name of the tool who found this. Much more 
important is a good description __why__ this change makes sense...
For example:
.. to shorten code.
.. to improve readability.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Feel free to contact me direct for further questions.

Thanks for your support.

Bye Philipp


