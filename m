Return-Path: <linux-kernel+bounces-298142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0395C2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DAE284829
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66118B14;
	Fri, 23 Aug 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUBI5Xpy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8CE1755C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377437; cv=none; b=Xjy5pUaKNFbD7xlPGT1Ek3AMO1yvHZ88t9AMSnWEWLEgKmel+jOIIWC6NNBcYHSQ13HtYt8OCd8XUDH1k5Meu6Uczj/B5jNRTwQ6Xli1TJlShyZJWsjKjQqZIR8OOFuOniK+3BbU/ZKDTH6PXCSDbarNHDgBBZvwju8d5Kcq/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377437; c=relaxed/simple;
	bh=NgVcCQ/knzm/n00VC2EBeQ+6MU+SmFAQYqMr2MBwrVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jc5EweP+g8QgTAwvge/VHEgpmcy9ARV4vhxL+hNutZSY9juigeTOEGsnQNMNF0dC9VBV5f3aGQijUP1kZiUxPUAjSURNbAiTinGRxHpH/UgubVVcxCVPdCG7i03ztQB+qcf7a5StUz1xtkqzvbA+VKkz8is0FpfWEn6GpV2s3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUBI5Xpy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724377434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiebQTQXIquzH5uU+5vCbj/ZQSVrIFh3t9Pwy/5cYBk=;
	b=NUBI5XpyfMqlexnkhzlBG5/gbyCkjol7ozgF6oHjqF5yxK722QVGrwjjOchyvuvjF4UQuy
	XAjmO/T0fGQFjS2V67mcRbnIwQCjyBp1KaqQ7dHu6SgzrgYum5+iXTVdMeh1qNJAInRmkg
	nfEaskpnjsU8nbRPRHZUOmdLg91ctOE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-jC9LHR58Ok2l8LcU_7jeOQ-1; Thu, 22 Aug 2024 21:43:53 -0400
X-MC-Unique: jC9LHR58Ok2l8LcU_7jeOQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7cd849a6077so1293122a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724377432; x=1724982232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiebQTQXIquzH5uU+5vCbj/ZQSVrIFh3t9Pwy/5cYBk=;
        b=L5ZMz4ysuQ7PQBjg+Jt6H5/XBxArAyGvXiF2Wmo/ntXVUMY9qEansf2JjjUSE1cdPn
         /RqjZ7ZoBSIiYdVWEq6c0YgeEUadvt+JSvVAgKilG3tQXvmvdn/23psj6Xn7AAyardyd
         PrsFccd2f9B1FYojUB/WM1AIdpAEn7bmMnnEOipUCcQYqA7ixutEEppGs/vdxXuyQlIv
         p8c3Yu9ZjHQ12tLEOwp+uQc0V72YXN/1v9hVTRL4UczJOaRobH/8MuNtQlAyRLgAYNvM
         qa+rF7RgjHXN7y+LBn2Bv/164gqmg+ayVR9gehHuk8ZPvqdBmqpfKeFBrbUqInr1o2xz
         LMfw==
X-Forwarded-Encrypted: i=1; AJvYcCWdS6NdyAIAjNsmnS0syMmLgPRw+pHOAgJ6rDgmZF9NeOWv8ami/soo+iKaKi6/whuJrFRaSy+IJTN1H5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURp3QRhN1WY2yX/oDBDjrCSNahzZrE2xjWiPSboULu4asxaUZ
	Gf7viQiCok48isOJX4/76/L3giSKzAlFEWOPrW9ztbkR7/0ACgdl8GRtMA17oCql3QnTzF1co1M
	6rF+krQP6zNNx9q32vzwZ1Xi8H1RDPS/QhlUj77hqwSmuTR5xLrlep5E5/Ln49DLONLIsjJq3
X-Received: by 2002:a17:902:ce0d:b0:202:4317:79a4 with SMTP id d9443c01a7336-2039e4c5ac3mr7035515ad.33.1724377431977;
        Thu, 22 Aug 2024 18:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEHCXpQkFKJj4TZLiD84ye/nQAAmTg7vAgIcp25w8JTbA2w+iIvVhCFxfBP0wCjLwUvW5ZLg==
X-Received: by 2002:a17:902:ce0d:b0:202:4317:79a4 with SMTP id d9443c01a7336-2039e4c5ac3mr7035335ad.33.1724377431600;
        Thu, 22 Aug 2024 18:43:51 -0700 (PDT)
Received: from [10.72.112.8] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fcf6besm18584435ad.304.2024.08.22.18.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 18:43:49 -0700 (PDT)
Message-ID: <1f8da693-4996-4a3a-9a50-4f757402d76a@redhat.com>
Date: Fri, 23 Aug 2024 09:43:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ceph: Convert to use jiffies macro
To: Chen Yufan <chenyufan@vivo.com>, Ilya Dryomov <idryomov@gmail.com>,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822095541.121094-1-chenyufan@vivo.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240822095541.121094-1-chenyufan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/22/24 17:55, Chen Yufan wrote:
> Use time_after_eq macro instead of using
> jiffies directly to handle wraparound.
> The modifications made compared to the previous version are as follows:
> 1. Remove extra '+' in the header.
>
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> ---
>   fs/ceph/caps.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 808c9c048..6a55825c3 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -17,6 +17,7 @@
>   #include "crypto.h"
>   #include <linux/ceph/decode.h>
>   #include <linux/ceph/messenger.h>
> +#include <linux/jiffies.h>
>   
>   /*
>    * Capability management
> @@ -4659,7 +4660,7 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
>   		 * slowness doesn't block mdsc delayed work,
>   		 * preventing send_renew_caps() from running.
>   		 */
> -		if (jiffies - loop_start >= 5 * HZ)
> +		if (time_after_eq(jiffies, loop_start + 5 * HZ))
>   			break;
>   	}
>   	spin_unlock(&mdsc->cap_delay_lock);
Hi Yufan,

Thanks for your patch and this LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>

Will apply to the 'testing' branch with an adjustment of the header 
files order.

Thanks

- Xiubo


