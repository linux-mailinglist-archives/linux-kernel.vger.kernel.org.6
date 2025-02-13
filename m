Return-Path: <linux-kernel+bounces-512802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FECA33DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367D018828B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FDF227EAB;
	Thu, 13 Feb 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpa7cMb+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2E227E9D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445836; cv=none; b=QTijQOOC/mc2Ndblfh07aHa1NA7Lbpot7hYBXMub/4Ys2RTM6guK2qsbNn5TJt97jwUMQoVaAiONuQwFeqxEJwN/CFi9ZriY+W5MKlOId9MbEi9T/Jap3zCROa0Xkot3CsCwIfUO43fw7TH98qIcNG8aIeBw0qWScGYc8pT3X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445836; c=relaxed/simple;
	bh=YY6DOrCUpQsyNOYx6VdO/TtggXIJ9ECRrzNJKzUoTuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auYVFRtCBMs+kuZN6Tz5xdDwwQOrN5M92NfllxrNBMVXZz3DjyWmBU0UsE5TOEa6FcChtWTsu5KW4ituX3ENV/NZ4GQ1G4VPz9kyn+lUdxlsqAFY35eDmSd0FrMOUnmNWYriBMgpFV/H5c4+AR+dFEjpBAwQ/8UUh2XVEMPHy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpa7cMb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739445833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL+aPdnFR/fkXCURRzOeY8yP7Oiq1xCa5VfoFeYynkw=;
	b=Dpa7cMb+judlLDy0wXs2g8zy30bhGz7ioRnh20TAP3m15dp9N+SoUK8pmQ80VcEvbvvJR8
	DXKqr0mtwTVAzqfzikQUjDH4I6vwBH6MSdAUNwfn/Mt37lceEmFuyFc7TMnHUjYnjn3tfR
	3+mSwsi0IqGSdMp3gAhcAv1ONc/zauM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-vsEG1SijOpSiiLjKi6Lrzw-1; Thu, 13 Feb 2025 06:23:52 -0500
X-MC-Unique: vsEG1SijOpSiiLjKi6Lrzw-1
X-Mimecast-MFC-AGG-ID: vsEG1SijOpSiiLjKi6Lrzw_1739445831
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so5672815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739445831; x=1740050631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL+aPdnFR/fkXCURRzOeY8yP7Oiq1xCa5VfoFeYynkw=;
        b=wZY092PR+8E12bFKOMMbCiFvZP4VxgcqzR2I/yi9I8jZ2isoTc1oJxqKR8bwmuSScG
         8JLGfhFJthPOawhavL4aQ9m5Q6Oza4p650tR+ZAW6vI9roGX5BMn2T8OV659PI0qItvI
         2C9deU2Xlca8GmfSl2eno/8q3wd2iks9QCzfXhW10gvf25uRqoTsDk3MrCp5y9rGStrK
         uAQ0Chtn4pMGXTjX0TAlzpMWR289shMQIQ/Xe/3OyGfvQnmsupdoWjVxF9kAimhgws1E
         amhdPBSfExPMX8pGeGEx47c2UnIY/jiEf0NP+6Bl16bqVVmS5E1M/vmZ1BqUa6MB5fWY
         9W/A==
X-Gm-Message-State: AOJu0YyIwA0q5U+XXd7zpL/Vs1AHce7y0xJzRRBGACXu+aae0af8JnOB
	XWKRoIOYCObV+bO/S56ct8hAB42SkuX3F4uE4iGm4Cvmiz6QpTDl9u1Z2B7g3L1eEZECAbVctQC
	euQqGewNPmgMVgVif+NGrFgVVjledZsNc8MzgRCdNBkbcDoN62W4J79kAJqg+Jw==
X-Gm-Gg: ASbGnctIBbpOghRuPUhFPoy8lsj/jJmke+5GssoEPVCXiDHSIo08B4UX+vYRQdjgjsn
	EGSyOruZxFv+9Y3ve4XexKT4EEtvUW901aWSOf/GQW/y/4BRQE9jlJ2FeCKedyxRyNmRuYRl1eK
	wnvT/js/HYcnkwlb9uygxfRCB7apQS6quKtF8zpRKutmTD7mmv/fzhPlMIuQVh2bmAmON7Bw3iP
	VMX+9+Wnx6KvvExNTOg5brx0wsWaqIxtiApt/A2Ag6P0etc/KTT60AcEq96umySIBW/a+XaZEhK
	oyUHDO4j231ovx+CbAgj4iS5f1SjJ2kcN44=
X-Received: by 2002:a05:600c:870d:b0:439:34d3:63cd with SMTP id 5b1f17b1804b1-4395816f381mr65177215e9.9.1739445831379;
        Thu, 13 Feb 2025 03:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFtFyqrjbkfQQqT9IE89MU7ZaXBN7z5Cz0szfxnDWNjv1Rol7DbNd/LzOv6OpYD5KnA0J+fw==
X-Received: by 2002:a05:600c:870d:b0:439:34d3:63cd with SMTP id 5b1f17b1804b1-4395816f381mr65176865e9.9.1739445831072;
        Thu, 13 Feb 2025 03:23:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc48d9dsm41234445e9.0.2025.02.13.03.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 03:23:50 -0800 (PST)
Message-ID: <3a979b56-e9d6-41c9-910b-63b5371b9631@redhat.com>
Date: Thu, 13 Feb 2025 12:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ti: icss-iep: Fix pwidth configuration for
 perout signal
To: Meghana Malladi <m-malladi@ti.com>, javier.carrasco.cruz@gmail.com,
 diogo.ivo@siemens.com, horms@kernel.org, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20250211103527.923849-1-m-malladi@ti.com>
 <20250211103527.923849-2-m-malladi@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250211103527.923849-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 11:35 AM, Meghana Malladi wrote:
> @@ -419,8 +426,9 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
>  			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
>  			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
>  				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
> -			/* Configure SYNC, 1ms pulse width */
> -			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, 1000000);
> +			/* Configure SYNC, based on req on width */
> +			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
> +				     (u32)(ns_width / iep->def_inc));

This causes build errors on 32bits:

ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]
undefined!
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
make[2]: *** [/home/nipa/net/wt-0/Makefile:1944: modpost] Error 2
make[1]: *** [/home/nipa/net/wt-0/Makefile:251: __sub-make] Error 2
make: *** [Makefile:251: __sub-make] Error 2
ERROR: modpost: "__udivdi3" [drivers/net/ethernet/ti/icssg/icss_iep.ko]

You should use div_u64()

/P


