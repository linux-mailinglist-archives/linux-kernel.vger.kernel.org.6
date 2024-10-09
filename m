Return-Path: <linux-kernel+bounces-357524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F799722E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1064F1F247E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD21E00BD;
	Wed,  9 Oct 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMMSl//W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EE149DFD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492191; cv=none; b=Y5Rysv6V5nYnt+RCARQUjnqXNslEbj0++C9ScsYTvQ8HVTnc0xx3cA8t5SBH31rLMtKtUmzm2/M3wje9w3eQRAdgN401/49fuluL9bUVRln/FPYG4+6uYtP3Z63xfrKLCFtdHH/7zkwWAWVAZpJWZhkJrOcsdTvPvZbi7HU7iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492191; c=relaxed/simple;
	bh=9MiS1359+jHNvbM1ilMc2pS4s3ZhCwVYmM/EmA2aDk4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aLIgMo1K8AgRWzXeLcrhPDGh23dJk6UPW+aeNRHGWUXlDaU4nAFc2AtswAE8WwHAs/DqJZb3rtGqTMUMuZrODXTkUuozANGi7kt3Ya/TXHnNHKrSKdO7SxH/pc794RZu+uinUPrhObGKRNUkYJyiP0Xaxy2rAcPAp2Rd2KGvZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMMSl//W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728492189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CndDDmKrZa3RxYl9dfQ/fl5DTRtqBb0a89qbDh9r1w=;
	b=UMMSl//W9qeozmiYioc+27rq8FB8QbGuTVW2afiBNDYG2PHjkoORowJnukrasBOBar9RDv
	+Sdi1iedx8ZCRUE6bSIJMl/0e1iDbg6DJF8ceU/Ws9qJfsdv6nbZ5I25JJcIqGnV/LJjsl
	0Vvrtc4YndWjb1608vGtyYuxngS2eTI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-XLvJZd_aPDejk14wCfl3cw-1; Wed, 09 Oct 2024 12:43:08 -0400
X-MC-Unique: XLvJZd_aPDejk14wCfl3cw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-45d94168de2so708201cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728492188; x=1729096988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CndDDmKrZa3RxYl9dfQ/fl5DTRtqBb0a89qbDh9r1w=;
        b=GBQRs89B4Bx2j73fHyPiCXM8R3Nm4TqEHS1SeRsCii/YxOPZggI5ff62/YWCVbD3v0
         9mdOl8ZYybHPABQNZpOb8bRlObr+3eabdFLggBvLgJCnOhsJIDXu6CwDEZDI6lcU0RaB
         pK8CVQg7qOOwZy4aRTSHbavoc59nsZ9lXCFFUaER45dSIjOwGUOwpOZrtJyz5RPhS2iO
         5kesjo2wMtVOm4vCFifMeLg7HUsRiT8d2shB/PyXFKlS3LM3+M0NShcWDR/2182RvvTc
         AJY/yXSG8DPv08dEjhf+q8j4morjo8yB0XJ6YBzxKinLJlwinaItJry8y7YBgL3rRltD
         Cy3A==
X-Forwarded-Encrypted: i=1; AJvYcCX6IlTGXFqZtLYmBM2YOaH2LkNEIv72Kplz00A5y3DDxjUfBaAua/30LxsG/jGBz96Lu3Kx9hThHzwjpeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRLaaYgZlvnii+HSDAkUc8vNYOCyN/KV462Y6Xfm0ubF8Fe8f
	bU9jLmKppN45V9bHPgjEji+JeCN5FcXYAbwYyo0d4NcS2AxkFCP5h856n6Pmxf5ZrGcel0B9N4z
	mddAPY3Oilj+7NHdfc7qwEUjzrDBoNVbf9/9poT4DjJfxdTnTzSpbqV/fpPHwUg==
X-Received: by 2002:a05:622a:2b05:b0:458:23fc:1473 with SMTP id d75a77b69052e-45fb0e7b1admr58020211cf.56.1728492187687;
        Wed, 09 Oct 2024 09:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHi56lAqcSkFJvDKDVdskj2GFkQUBGmdOg6uFES6SCkeL61ifald/P3rcJ/Y4ET+JAEaZJ6g==
X-Received: by 2002:a05:622a:2b05:b0:458:23fc:1473 with SMTP id d75a77b69052e-45fb0e7b1admr58019841cf.56.1728492187268;
        Wed, 09 Oct 2024 09:43:07 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45f06ed49d8sm13742441cf.50.2024.10.09.09.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:43:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0fefd06c-58f7-4771-a811-ec26ab268526@redhat.com>
Date: Wed, 9 Oct 2024 12:43:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/Makefile: Make union-find compilation conditional on
 CONFIG_CPUSETS
To: Kuan-Wei Chiu <visitorckw@gmail.com>, akpm@linux-foundation.org,
 hch@infradead.org, llong@redhat.com, xavier_qy@163.com
Cc: lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <20241009154022.2432662-1-visitorckw@gmail.com>
Content-Language: en-US
In-Reply-To: <20241009154022.2432662-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 11:40 AM, Kuan-Wei Chiu wrote:
> Currently, cpuset is the only user of the union-find implementation.
> Compiling union-find in all configurations unnecessarily increases the
> code size when building the kernel without cgroup support. Modify the
> build system to compile union-find only when CONFIG_CPUSETS is enabled.
>
> Link: https://lore.kernel.org/lkml/1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com/
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   lib/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 773adf88af41..53f82de7cbe2 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -35,8 +35,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>   	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>   	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>   	 nmi_backtrace.o win_minmax.o memcat_p.o \
> -	 buildid.o objpool.o union_find.o
> +	 buildid.o objpool.o
>   
> +lib-$(CONFIG_CPUSETS) += union_find.o
>   lib-$(CONFIG_PRINTK) += dump_stack.o
>   lib-$(CONFIG_SMP) += cpumask.o
>   
Acked-by: Waiman Long <longman@redhat.com>


