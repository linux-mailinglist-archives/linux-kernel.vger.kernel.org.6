Return-Path: <linux-kernel+bounces-374480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5D9A6ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73771287C71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08811C83;
	Mon, 21 Oct 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FIuQo+VZ"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED821F8F04
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518325; cv=none; b=kd5w1XZwWAhIgxs5nrn8NYlsR/uxY98gvCtPH8MrYWiYjLXknVnOfhNPJ9cms5ZriMnvm7UhBG7/5vJ3kHCmj+RNrk+FljcVgMpPMSyt813ecJNppX3WCNgfRoZZTsdBD9T6drHzpnDfMSzAZroykl3XSBHE9q1nIbui1LL1oLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518325; c=relaxed/simple;
	bh=t1He/A5hzUmgmTjzLbYbSEEOBFdMRWGt4pzi6nDCHLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsH7qy5I2XseGAlAdwWwUuYluxw7AvO32G99ADM/C1kMOmp/uwHvgIkR4nqqJ10sbH28gSCSn5eKdVxlk4NkDDq8/Doo3pZHRbCGqQADhD0GE6f00CF3oD8CTI7GfYGpWdDEXDNFGS2g1QPWyUbb6ayBarfHo8h33qFMdl4CwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FIuQo+VZ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ab00438acso114893639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729518321; x=1730123121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5DjyIFnxBJCDtMArSsp9CEXODWyJb8IyJZS+DJGzds=;
        b=FIuQo+VZY/Z4is57G2ro8JA5KlMlvQXCHzaU3k1M+2a6ywCKqF7KXUsngF50Ll8DM2
         87DhJJRRx1vYc/7ZkK44NGDT39mSnU6ScikdiGzlcboHvAvA29scFfYB8WNQqbyDm2AF
         i7GiRWz7Hq+tzhhsukksBHkhbdKRHIxIWoTbnxz1c3wxG+4o0S22LzuAQKJLMVipc9nc
         RUDirpMCtiKJKu4uXITp7PoO5GyfZKhP/fQ1OGvuZMfJof+meQo5l9U6rJjRpwRWGEVd
         q5UDfFb8yQ+xt3PTkTWmDx579Hsj1DLYTlo2MM2v3+xtPCfF9SfoMQHlgwH2jqlFjIOw
         VIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518321; x=1730123121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5DjyIFnxBJCDtMArSsp9CEXODWyJb8IyJZS+DJGzds=;
        b=QembtfkY6l4APpQ1Sg1T+f5fenx065JcZAIs3jYWCtDHTSSU52j6+buySyRhhNbbn9
         wPtnJxr98fqKIE1/wuN8GWXIZ3eBmVFPGNUNZsT7uGlOBYb4/52hZiiN6ocsf904B8tn
         PIuK2CGzvUscFmjErNnR2rTOEWk/ES/0ZbsbTNPITiUUqvanQAub+kCGTkFi0fFpD6kX
         PCBpwn6WfD7sW7C0Z+phYXR3pJ3SZWyD8V6nS4tf7t69wJaqkJ+9uQxM0rsdPiiMhmg4
         JBXKEPICXA4JdLYHmlP3zQo6/J2uSU8v0AN1gLJf8gw7RY4f7foQ6XRZ6iES75xUXSzA
         Uijw==
X-Forwarded-Encrypted: i=1; AJvYcCVyHkw8iH2Kwu4SNCovLzom+ckBNSIYkVHaZjatV8S3rQqfPfaCaxa+UcakoQSTVB8XHbOFjqB7JtdRrLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsXqvuAtmdvcLf1MFaUtd//scBFahzBuzYqK7l7Z6VjIiMkvL
	nVwmGYkDv3grPO/CP+EBbDNgTgLKrB/WnRRNKs2xCg330/4Vwwa9MIIWiQaNR4k=
X-Google-Smtp-Source: AGHT+IGaZ2Kxhv2AHL9JRdXlTyGbBEnLcVsFhhuxb4rR6JZYfDWlpqBSZi+dbUjB6QvmlcsIpp9gWA==
X-Received: by 2002:a05:6e02:1886:b0:3a0:ce5a:1817 with SMTP id e9e14a558f8ab-3a3e51391femr111400275ab.0.1729518320461;
        Mon, 21 Oct 2024 06:45:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6092fbsm957268173.119.2024.10.21.06.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 06:45:19 -0700 (PDT)
Message-ID: <ab3720ec-b12b-4c0a-8e56-930753c709fd@kernel.dk>
Date: Mon, 21 Oct 2024 07:45:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
To: Muchun Song <songmuchun@bytedance.com>
Cc: josef@toxicpanda.com, oleg@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 Omar Sandoval <osandov@osandov.com>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241021085251.73353-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 2:52 AM, Muchun Song wrote:
> The memory barriers in list_del_init_careful() and list_empty_careful()
> in pairs already handle the proper ordering between data.got_token
> and data.wq.entry. So remove the redundant explicit barriers. And also
> change a "break" statement to "return" to avoid redundant calling of
> finish_wait().

Not sure why you didn't CC Omar on this one, as he literally just last
week fixed an issue related to this.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  block/blk-rq-qos.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index dc510f493ba57..9b0aa7dd6779f 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -218,7 +218,6 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
>  		return -1;
>  
>  	data->got_token = true;
> -	smp_wmb();
>  	wake_up_process(data->task);
>  	list_del_init_careful(&curr->entry);
>  	return 1;
> @@ -274,10 +273,9 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>  			 * which means we now have two. Put our local token
>  			 * and wake anyone else potentially waiting for one.
>  			 */
> -			smp_rmb();
>  			if (data.got_token)
>  				cleanup_cb(rqw, private_data);
> -			break;
> +			return;
>  		}
>  		io_schedule();
>  		has_sleeper = true;


-- 
Jens Axboe


