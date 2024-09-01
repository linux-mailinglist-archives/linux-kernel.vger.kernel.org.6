Return-Path: <linux-kernel+bounces-310120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2324967544
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267471C211E1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8314037D;
	Sun,  1 Sep 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItbbpbGW"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2B39AF4
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725171501; cv=none; b=WSkGWAt3AgXjs9UjLrwFHfipnhNsjmqYw0tpWSHJaqPFh/YOZX2AWcCUNgyavh8aWXMxCCgldWXjzc86XY/o5a+O/PK9NWiKpc+d0yCVuhiY0LnfhQ191fTTkfgzId8HBbRRdhjIIaQ3eRRmL0llzXvdmFXO/KV8+xsoZUoPZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725171501; c=relaxed/simple;
	bh=aQbhNYI7KASk7MVzDUxUk9MF72rzusqjypGDgWEneJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDcbtypGebNohEHzbJd1pCM38eIuf2vQqQTYsN0Os7vA8jCLlFmy3qQ0PxEnUaZa1dHKL+UyUidY7UnFTP564lYd6cYAmUEKiCRhPwUUwuakqmjzsWbFcc15vlxnvcB619DXexIxg7f1EG2Vzbh0NSM9w2cOr8G/jG2bFiCkaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItbbpbGW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3dc39305ed6so336482b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 23:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725171499; x=1725776299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSkZ+h7hAmkpfDfD7YoyADZB8TG9ExCgLgy0zVby24w=;
        b=ItbbpbGWh0GZgnp+THeC06bbJvOI14OJzxHNAm/IZV0PLc+B9OKjsJDl+rO4ot6Iqa
         4FJUk8Zts52hQYg4/FK3WOk4hiq0t5ymDb6vxDM8NqJAkRTAiPlqt5tGITBnvlp4p/QS
         mROrKSV07rqHSDSEvSckA0NCMYgSGKZPKCY38iA3wEcbt1itxJMSM/0XOqfNVcY/C+Z9
         cvBcOEM/Qz2I0KlreBcGPUztjZGzBk8L7vlvVwWFsRSRsq3/F37/hUppEpUzEw5hGV/P
         80V9AutYxzv90pLJN0hrwZa6rBKZLQ83McILw9RrOsaVglEqxmvPCJ/0CrOKgji5wLXq
         TiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725171499; x=1725776299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSkZ+h7hAmkpfDfD7YoyADZB8TG9ExCgLgy0zVby24w=;
        b=chuXz0TO9LTOJ/OrLzCUVn3BfJ1VJiZLvHEOsyjVEguop70yhuEoQlrFb/CeAfy+aO
         IXsBPCB0fmXKooOew6hG5uwRRPc+UnuBhgfsEy5VvQGNuErM3sKuyuFTZ5yKjcHFjDpH
         uJS/ZYBI31GIjbDl/Uliq8VOXkvOaF/62nWSy/7pC6vGgEc2JByK8Rukzlu/PJP60N2z
         78QEEcketmVUmcXyRVqcE9tl9pTbLenqski5dz5H5Jc2p1USQvcF/vx4kt++VBJnwLEQ
         6zOJlJha0suIC6+c2Q4zlnTKA+NKwvhKwPOwK5yYpW4jb9ePTteelgVuKCZve7/1FL3n
         ejzg==
X-Forwarded-Encrypted: i=1; AJvYcCVcUmpdB1o781nuH9+6sFhrVsLKT9hdp1Hfyj9IV261Wzc5r1+4xffEIbx+YL/9dBRAZ0djf1pm+ZkLgsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhI7uFh3dgpzl8Q1bZp13UqAWuXIo4GyURMzqr4+F3E9KOrd4s
	n05hFMmOggAnxLHuGQoVEkcW01B4noBq5SpV2nxBRE+rOj2Ek10a
X-Google-Smtp-Source: AGHT+IEZj2KeZTK6d34ygjRyzUSAN+CtrqbDnzKeecReCJWWAKB/0NsCw4ci1qcy9wDPtxpwsJosDA==
X-Received: by 2002:a05:6871:2b26:b0:260:e5e1:2411 with SMTP id 586e51a60fabf-277b0d5bf19mr3627550fac.6.1725171499168;
        Sat, 31 Aug 2024 23:18:19 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:faac:461f:8c99:394? ([2402:e280:214c:86:faac:461f:8c99:394])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be199sm5517039a12.70.2024.08.31.23.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 23:18:18 -0700 (PDT)
Message-ID: <7d4d860e-6d0a-4144-acbc-45a328df48fe@gmail.com>
Date: Sun, 1 Sep 2024 11:48:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Removed @freeptr_offset to prevent doc warning
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240901055311.20905-1-prosunofficial@gmail.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <20240901055311.20905-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/24 11:23, R Sundar wrote:
> ./mm/slab_common.c:385: warning: Excess function parameter 'freeptr_offset' description in 'kmem_cache_create_usercopy'
> Removed @freeptr_offset to fix above doc warning.
> 
> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> ---
>   mm/slab_common.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index d48ef4fe1ea8..ad438ba62485 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -353,7 +353,6 @@ do_kmem_cache_create_usercopy(const char *name,
>    * for copying to userspace
>    * @name: A string which is used in /proc/slabinfo to identify this cache.
>    * @size: The size of objects to be created in this cache.
> - * @freeptr_offset: Custom offset for the free pointer in RCU caches
>    * @align: The required alignment for the objects.
>    * @flags: SLAB flags
>    * @useroffset: Usercopy region offset

Sorry , Forget to mention.

This patch is for linux-next repository.

Thanks,
Sundar

