Return-Path: <linux-kernel+bounces-188193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160528CDF09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C519128261F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CC6FBF;
	Fri, 24 May 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ/xR/h4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141181F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512280; cv=none; b=bhM5TPXsMYP7mKIeYV56FqHRMbzf5KEQHkzKuHj7327m0Gu/zPkGSckXTa5LylT+kJr/V4sq4bU5USb68cGGCSc3VQvAy5mQckuIutS1d83Gfo83eBMEbMMfmFx+Zc8VBXuKm2IP/vfh0zLFpVov8EO13oTPH/c2BN8EzL9/wSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512280; c=relaxed/simple;
	bh=B09WagMSQYqu2y6WcNLAL8j1PdOhiUvl64ijy52FX74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOtrMLAu046YeJj0fa9oaCiFJLOBG5VlexNMuVYayJEpKxg9VHrjpdQtdXqn+eC2Eu3VHjz6IJNjRFiv5AWNb5tdIcVLUvxwVpVv8Y+VgONfeKSeEv0+vYR95nljF9vNqd41f6GUYze0Aavm0b969xMtNa9iJ1LXNONlvRH/EDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQ/xR/h4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716512277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nW6ItyXHWrOBbIXTrs/WnWz6xyA/F9n+0mCPhSlCMk=;
	b=gQ/xR/h4N0XWH5X1vQjkK57d7QeFF16ASqUTQ771xQ/7yquXFGxFCWU4q/+Yr6LOOd13Ac
	2sjomchnxoSklDYS5CtsXniHLwA0cdJAfi+/CfkVZ8+HUIcmLH1lMEdHtFbjd1Vs1ADt7O
	lAIe+f472kjIX2noqTaq2gFdFTsKeXM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-vGc9NEQVOg6IbAAl5u1Xcw-1; Thu, 23 May 2024 20:57:55 -0400
X-MC-Unique: vGc9NEQVOg6IbAAl5u1Xcw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a8d4b98157so8147716d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716512275; x=1717117075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nW6ItyXHWrOBbIXTrs/WnWz6xyA/F9n+0mCPhSlCMk=;
        b=Ax+gxbJWNAqSLVkJvt4ATMl5ysaBi6owJ6kIZHe5FEkhduAK6EuRYWNC4hhr9ZwlxC
         xJW5vcQaBbawOlE5ToKp/dVa/8TB8cPEJov2s4whXAB7qlwAkgV44GVxNbFCPoxY5mqI
         jLNdlJZo8EXQQLfAwoPALv4WklAOfwZQV9DBbmdU3v+SSK3lS7hV8Ix9K+UpoCDx7359
         NXzuJ8NEYlrtDZeIG2ZNOFxpWyS4IuLWy9Er9i0CtNbrOL95Ok+oLJ+pApTmAeU/HYll
         1qOnCWaP4HdZnBM3U6idsYi9OqnolgzEQyGlXehdN/cb43xi/elvDG0ii2tu+0Juqzpv
         cLFw==
X-Forwarded-Encrypted: i=1; AJvYcCWhGJVrOCD2m6D1I6wDTFoAJX2CS8P8q8fHy1eTDttXs+nTugpOlDZ296t089S2V6/lcPPPLBm77vxW9ewdExJ8sf8p7djgxsqUA6AP
X-Gm-Message-State: AOJu0YyAFhjSEZd3kD90b+aHPbgLEuc2vwnWiEeuoEU7yQq+/it1tbsV
	ZPggbywA7yS0kyS8I3CoS+Q+Ntla6dv3wO2fQvIC7K99QqgFERi6MWemqgMPoUxLEbX9S9P/vk+
	SR7NnpZ7NSd6+Vx/NeKlYZ3UPwjFQT+fBu1GI2ptlZf7HpWOpR+wrRxj8hmAnf9AebKD3Pw==
X-Received: by 2002:a05:6214:5d11:b0:6ab:891c:54e9 with SMTP id 6a1803df08f44-6abcd0fadaamr6119306d6.35.1716512275069;
        Thu, 23 May 2024 17:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr9OA8GjcLWPDgYxGn3TRIwyBJob8LLed2gjUw9dHtXvVxRa+eApiMcnlNbmzT0L542FUa/A==
X-Received: by 2002:a05:6214:5d11:b0:6ab:891c:54e9 with SMTP id 6a1803df08f44-6abcd0fadaamr6119246d6.35.1716512274609;
        Thu, 23 May 2024 17:57:54 -0700 (PDT)
Received: from [192.168.1.175] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac16308ecasm2009026d6.121.2024.05.23.17.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 17:57:54 -0700 (PDT)
Message-ID: <5c063045-4bce-14e4-9930-77cc0ed2edad@redhat.com>
Date: Thu, 23 May 2024 20:57:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dm vdo: remove unused struct 'uds_attribute'
Content-Language: en-US
To: linux@treblig.org
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523210716.309324-1-linux@treblig.org>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240523210716.309324-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 17:07, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'uds_attribute' is unused since
> commit a9da0fb6d8c6 ("dm vdo: remove all sysfs interfaces").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Yes, this was clearly an oversight on our part. Feel free to add:
Reviewed-by: Matthew Sakai <msakai@redhat.com>

> ---
>   drivers/md/dm-vdo/dedupe.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/dedupe.c b/drivers/md/dm-vdo/dedupe.c
> index 117266e1b3ae..39ac68614419 100644
> --- a/drivers/md/dm-vdo/dedupe.c
> +++ b/drivers/md/dm-vdo/dedupe.c
> @@ -148,11 +148,6 @@
>   #include "vdo.h"
>   #include "wait-queue.h"
>   
> -struct uds_attribute {
> -	struct attribute attr;
> -	const char *(*show_string)(struct hash_zones *hash_zones);
> -};
> -
>   #define DEDUPE_QUERY_TIMER_IDLE 0
>   #define DEDUPE_QUERY_TIMER_RUNNING 1
>   #define DEDUPE_QUERY_TIMER_FIRED 2


