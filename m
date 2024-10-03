Return-Path: <linux-kernel+bounces-349238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A6998F2E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433CA2838FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F8B1A4E8A;
	Thu,  3 Oct 2024 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9iYYoLl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144D1A7261
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970193; cv=none; b=SLbZW+0mQc/u8z+LYSU1jdEhn/Xkx4/FZa/0ScLst4Njx0TzHE9ZUO0DOUh+1+C2J4FcKAzd03OVNQD6VIRjwket60nt2NDmja7xqk7FdWi9jQH5qYybOlx7IqxKIUpJ09uBYp3yL7c3WF67EBHXmzNmOmQ8ubW6I7B7IEQZCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970193; c=relaxed/simple;
	bh=3thy6fYLE1XrZlk8CwbAZRJK/EBujv0/7YIVTHt9QmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMhcMAP6SX1NdXxikULKx2mmqq1vQHBYjTliz54lqZ1iO624s36a7nJlEsu9LRQtC8BoIw7+1EmAVydlNoiXmBqoUbJu5Ppb3iM2pWXPh54Vpa4W+Ma7aRl3wh6bqD8orpEQCKpeaPkMvK/5+lTgaK8YKgVrFxoqtSf6zxhM6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9iYYoLl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727970190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKwfG7LI5xbJlyd4LReKRmAkPjHtixJufHf0iofjNso=;
	b=S9iYYoLlrWxYUOiA7Sl5N3MENic9wmk7TijH0DCJsP7jKb2KQRj1hNMhuB2ejxFgislZz8
	0X1BPlFFzlnhiqzgzohOufpTyNeKNtgY37S7hoTx8ikbgyaeDGuj8gCBbOMRr+Ngc03rxy
	atKhnJ39k4mrP5uFL6nnkIXj2j6r9X8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-Tz_YG1KGPXa0tOZgz-CTNg-1; Thu, 03 Oct 2024 11:43:07 -0400
X-MC-Unique: Tz_YG1KGPXa0tOZgz-CTNg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ae3f3529faso218374185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970187; x=1728574987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKwfG7LI5xbJlyd4LReKRmAkPjHtixJufHf0iofjNso=;
        b=jz2MHVyIJU/I8s1H1omUj+Rxs3YF875goZiFOIL5rRm+68WCq2cQJg8GvIxH28TxJ5
         E7xRQVAJQissYVnwqAoLbQDJ68mT905PJHS+1WikY8E0AvawtgAycbhaOvL3qy8fRefH
         nLnV9UC4SJk4lqnAqVtby2ZctdHUVh3iC0WhhWGdCD2Wfgn3lP/BYyRY9JgIibmWsyAk
         y8txhfy6ClaNQT6cX7YZxiMgYsMORkdObni9Xhrr4uE9S1+32yWICKzeIm1mnG5bgyJV
         JnYignxypMZ2qRNqdLxHqXcdtpA2CRyYx7Pfi3aPdB/9ITvpl9D2dTyCtEU6RKSOBTdt
         798A==
X-Forwarded-Encrypted: i=1; AJvYcCX0PQbsZb8Gcu0qO+TBtDAH/DVADps1Z3kVBBH0HCkMNkEgcr4D+MD/czG4YG5uWvbRu6MWc8nhjUWpJGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK538AN/R0iRmOkFG4aVnUwnGYWB/x5HjLcRIYQA22BVM7i5vd
	FztYHqsws2TLaYXr5bvDIBN4GDB0cPSIWzh9p3ft26/+lrVypbdB2s+jpE9tkHslNBT8EUqvlDi
	7rTSG7yZ2qhjeU+Uww1eC8EJZMqvHqL+b9uNk6J6SNusr8RnhpBtDhQ650Uc/xA==
X-Received: by 2002:a05:620a:4154:b0:7a9:ccbd:36f5 with SMTP id af79cd13be357-7ae626ac37bmr1024510385a.13.1727970187368;
        Thu, 03 Oct 2024 08:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExDXfHv4ql/VsRehAef9jA9CVotUtBYFlZaiom3PTW8LpTFLLM0SHcKrOX7MMcPdTOVQHW7Q==
X-Received: by 2002:a05:620a:4154:b0:7a9:ccbd:36f5 with SMTP id af79cd13be357-7ae626ac37bmr1024508285a.13.1727970187048;
        Thu, 03 Oct 2024 08:43:07 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e1eesm60775485a.27.2024.10.03.08.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:43:06 -0700 (PDT)
Message-ID: <030fa38b-5dd4-4a8c-acac-a4821a11dfbd@redhat.com>
Date: Thu, 3 Oct 2024 11:43:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dm vdo: Remove unused functions
Content-Language: en-US
To: linux@treblig.org, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241003011554.266654-1-linux@treblig.org>
 <20241003011554.266654-9-linux@treblig.org>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20241003011554.266654-9-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 9:15 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> get_data_vio_pool_active_discards()
> get_data_vio_pool_discard_limit()
> get_data_vio_pool_maximum_discards()
> set_data_vio_pool_discard_limit()
> 
> are all unused since commit
> a9da0fb6d8c6 ("dm vdo: remove all sysfs interfaces")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Matthew Sakai <msakai@redhat.com>

> ---
>   drivers/md/dm-vdo/data-vio.c | 29 -----------------------------
>   drivers/md/dm-vdo/data-vio.h |  5 -----
>   2 files changed, 34 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/data-vio.c b/drivers/md/dm-vdo/data-vio.c
> index 0d502f6a86ad..2b489e37538e 100644
> --- a/drivers/md/dm-vdo/data-vio.c
> +++ b/drivers/md/dm-vdo/data-vio.c
> @@ -1074,35 +1074,6 @@ void dump_data_vio_pool(struct data_vio_pool *pool, bool dump_vios)
>   	spin_unlock(&pool->lock);
>   }
>   
> -data_vio_count_t get_data_vio_pool_active_discards(struct data_vio_pool *pool)
> -{
> -	return READ_ONCE(pool->discard_limiter.busy);
> -}
> -
> -data_vio_count_t get_data_vio_pool_discard_limit(struct data_vio_pool *pool)
> -{
> -	return READ_ONCE(pool->discard_limiter.limit);
> -}
> -
> -data_vio_count_t get_data_vio_pool_maximum_discards(struct data_vio_pool *pool)
> -{
> -	return READ_ONCE(pool->discard_limiter.max_busy);
> -}
> -
> -int set_data_vio_pool_discard_limit(struct data_vio_pool *pool, data_vio_count_t limit)
> -{
> -	if (get_data_vio_pool_request_limit(pool) < limit) {
> -		// The discard limit may not be higher than the data_vio limit.
> -		return -EINVAL;
> -	}
> -
> -	spin_lock(&pool->lock);
> -	pool->discard_limiter.limit = limit;
> -	spin_unlock(&pool->lock);
> -
> -	return VDO_SUCCESS;
> -}
> -
>   data_vio_count_t get_data_vio_pool_active_requests(struct data_vio_pool *pool)
>   {
>   	return READ_ONCE(pool->limiter.busy);
> diff --git a/drivers/md/dm-vdo/data-vio.h b/drivers/md/dm-vdo/data-vio.h
> index 25926b6cd98b..067b983bb291 100644
> --- a/drivers/md/dm-vdo/data-vio.h
> +++ b/drivers/md/dm-vdo/data-vio.h
> @@ -336,11 +336,6 @@ void drain_data_vio_pool(struct data_vio_pool *pool, struct vdo_completion *comp
>   void resume_data_vio_pool(struct data_vio_pool *pool, struct vdo_completion *completion);
>   
>   void dump_data_vio_pool(struct data_vio_pool *pool, bool dump_vios);
> -data_vio_count_t get_data_vio_pool_active_discards(struct data_vio_pool *pool);
> -data_vio_count_t get_data_vio_pool_discard_limit(struct data_vio_pool *pool);
> -data_vio_count_t get_data_vio_pool_maximum_discards(struct data_vio_pool *pool);
> -int __must_check set_data_vio_pool_discard_limit(struct data_vio_pool *pool,
> -						 data_vio_count_t limit);
>   data_vio_count_t get_data_vio_pool_active_requests(struct data_vio_pool *pool);
>   data_vio_count_t get_data_vio_pool_request_limit(struct data_vio_pool *pool);
>   data_vio_count_t get_data_vio_pool_maximum_requests(struct data_vio_pool *pool);


