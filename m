Return-Path: <linux-kernel+bounces-440011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08799EB77C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5524282149
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB82111;
	Tue, 10 Dec 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gt3CEPNK"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891501C07ED
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850585; cv=none; b=g+Vw5u4F+GWTWJyo8gvo6wzgvVaXTVmodxdNT0lrhx0483m8auPAIKdrFyjeiQzQUc72bh+mjkBFK42sXs3ch/CN8+fYItGhghQvMXXu6/eSsezWzdottQmX4jhymBru68d32dafj2RxoTydUqpxh/DnLzFDZRhMucpdj1scCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850585; c=relaxed/simple;
	bh=tKekrqKeGf6d9vYVMyQ3P703Igc2K4qbjZIE5eQv+pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYJ61ZPa6EtioZ0uGjLHOTZ3n8vw+d2Qud6YTIir86q769HzVO8+S2JARmaSFR0SRfp1p8sltLAQt0VufM5etcNEkzf5xxj/X7xr7iO+TakYAB3L37yXwMaZJneEwtegdK64uGM+B/NsVh6DYd3g7HmZnPVlr/p5oQ87yYcXb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gt3CEPNK; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-84192e4788dso192723339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850582; x=1734455382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mW0gDbfd7x2YjOT5s67ijl4s8F1BicI07drWQ2jAwxI=;
        b=Gt3CEPNKO+mh0ZmNvoyBkrcKMecaV+/lUC0lLD8wXt2YbpHiCdf7JA5ZEa4TTzVzVi
         l2TqiJZyRgdm9XoEHT41RzDHZHEibvGhos3U6JHCHjtSdcz2nm0Ybie1JH9SJWQBR9zr
         O9ZUe2qD2vAedKRqUNQV7jDuw23mzbuN/i0/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850582; x=1734455382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW0gDbfd7x2YjOT5s67ijl4s8F1BicI07drWQ2jAwxI=;
        b=icK3NKHh3h3h8p3RVQ37doe4fZDIsw9QgSrMYNxt2wvzfJhO8j2LO0jxmP6SBAu90N
         M7krZ7C1HFX3+TrT92rbGBKmnEwUYh8t9EIU1brFeAijW9Q+EYBpxXdpE9Z8Egzxa+OT
         oLxXg8ub5T+UlWFTiJ/+shkcXF3DAaWsQm+ycDiZIUR4s1cnqGoHZo96QQ7GC/laUS0L
         tyXVXbGUEBfTnR+TP2bm3wVTz67gRnPpTY5xbsUNn8YzXdk5Z5tKx//gyX3AiYR8+xdw
         fIYsb+R1grtn3iMHlMHWD18JWKDVcMt88YcuFI9JHlXbYprZIT3Wrx2aQkLZygjBfvwa
         MrIw==
X-Forwarded-Encrypted: i=1; AJvYcCVh+1lbkm3o6jja9UfM8cfQBqeLMwng9uuJOqmur6ny6ooz9toLwGCuiOBbTPGU9C+cgSGIqz6Umjw7rJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LNKsXhSxr124z8lNHQMhroGr0VkJCRlAN5M80DwlKAc59Vgu
	YYble2lZH4NnfRR/VPLbd+zczqMthvgeKQeqZQtyjEmKg4VXTch6AprVfQKeMRs=
X-Gm-Gg: ASbGncvOvuGFAosk9jXCXpmG2xYPhO9JZBitV0eXCfSqTqEmTboL64mDvj6mkqorv8O
	mfWsjONok77NtrNCuETMrR2cjNkCKIjwZMglFBqAc8zoEYEDbqTStR7sd3D5a5k82gdaeSK76Tq
	I46KeD75nqBTJMK844I1PK+YaH7RQuiZsei7Rx4uf+BloyalMdurJ8ew2ATGZEijHFWpXmV0x+L
	EB0EvtsQIx0LWEPpFRohhgHendBuK8QHPAcfPdTFt32E+mZTAN+kvuaFF39Gz+TDA==
X-Google-Smtp-Source: AGHT+IGWgeP8na4CqUGSLInUNKTCqSBVH8PPSLnNTomVYr/Tb4GqyreTLn1kP9mkki1218RqwK5WQw==
X-Received: by 2002:a05:6602:134b:b0:83a:639b:bc44 with SMTP id ca18e2360f4ac-844cb5bc021mr4606839f.3.1733850582516;
        Tue, 10 Dec 2024 09:09:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c0635f98sm1095839173.9.2024.12.10.09.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:09:42 -0800 (PST)
Message-ID: <d139fee4-aadc-4c04-8e1a-1fb8751c7734@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:09:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/zram: gitignore output file
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122074935.1583747-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 00:49, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>          zram/err.log
> 
> This file will be cleaned up when execute 'make clean'
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>    Add Copyright description
> V2:
>     split as a separate patch from a small one [0]
>     [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/zram/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
> new file mode 100644
> index 000000000000..088cd9bad87a
> --- /dev/null
> +++ b/tools/testing/selftests/zram/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +err.log


I am seeing duplicate signature warning on this patch. Please
fix and send a correct patch.

thanks,
-- Shuah

