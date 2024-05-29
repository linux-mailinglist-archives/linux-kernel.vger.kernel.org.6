Return-Path: <linux-kernel+bounces-193323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620EA8D2A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA20C1F2B1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010F515B0F3;
	Wed, 29 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0SjqMna"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0415B0F2
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948029; cv=none; b=a7YL9q1mlBToSrXlITOGvteigKU+9fiHJqCNfq/xYHlm+DqmRWUTJm+OdErhkJ5PbRKLk9Uvy8GKCuohjKExnxjl/QSMRR2cGwiH4cLG+Im1F2Ry7cGfP0nE1XuaO7ZG/q1YIbmbCeI1hhUuKLRqnZvIEHMC7En6lwdj3kNVSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948029; c=relaxed/simple;
	bh=1q1tCShYiNmiz3QmxyaKlUD5m6tjnboeasn8VoDi/6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxs9Ov6AnK8gvL6jqmmDQgBVe4pXdvqTyYFFeTpdcYusAlbA+vs11RP8gIqwtTSxmT0lfh+DW1HjlcyF4gpMiEdsqXy33DvTwYUbTcdryGxEpgfcMzNAN6CSQymJPSp/ibZW6TQky3ppERG1+5FhnXnKhX1LIQ673QYg0pU1hMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0SjqMna; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716948026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IJ2FBrWGqchGLvqswCTBuy+BPhnPSfu4z6uyGfELVY=;
	b=d0SjqMna73qxI6W/wIEyy8VO6+248neSJHHGwWZwOb9Hp/tS+WROxQy92uYpORFTe5dPSR
	FxAcWoZwPhu0VE2LAmO4uYEjqsFXaZMmigDRvF3F8b9yr8l+BnLQ2j9JikWiH5REPAXg5s
	Hg9RGpnhE2g2HKcdLFVB1+fn2kpba5Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-zTqJrIKCMbmq1h-Pp3vzoA-1; Tue, 28 May 2024 22:00:24 -0400
X-MC-Unique: zTqJrIKCMbmq1h-Pp3vzoA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ab84e71724so18626756d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716948024; x=1717552824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IJ2FBrWGqchGLvqswCTBuy+BPhnPSfu4z6uyGfELVY=;
        b=dpRs4XFF84AejFdAlXdhw2vwtHNggl795GDEvNo8KuLDtQ4weo05IKNdqBzvglOMbd
         xOPOZe9E3SMqSCN45ZfrH/EVih2+kgXn0L/5SIIgDc0Oo4GO7G5TLhqvyRylLpbQIy13
         rwB0E7ClzosHJVFHAt7Uz3V5o+9TAavk5bKLchecItLIU/xfwIlE5UreMRrdGABXv+1f
         vRkAHMoSa6ZBXXJP3ndT/MVxnyMT3foAXja0HRklmiQhL0UR6g4auiTHoIXeY52LnyLH
         X04YuMLtJiqCfaVxoVJQjgwycJRYxasNEBlnbPhw/O4TkCDkrp85Y86BmDeHEPM/yhjL
         v+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUAJRPH9qJUT50iL5jhpPa/ah/CReob7WiHNUbXSVZ1CvndzYGEpkvQ0RG062QuyRlYUq2PKsonKdTwcma5Rvpj3hZn+xpFfHFF2xgY
X-Gm-Message-State: AOJu0YwAMQvHg2ErUALvuJHHd/dQ8itXc3BJar75jnUz8iodc0SumixQ
	MM/+UWEE5D86zhDChiAV2EwVrKyeafTabJcI4UWX7TARJbn3ujz832ev1GoIim5rryWB73xQqfP
	vanTwPDURC0E9nrjQRsK5ERhSswkon/l3wkHMyeFh/HDa0KHe2gCaHOmS/xY8KQ==
X-Received: by 2002:a05:6214:5988:b0:6ab:1b6b:c8ba with SMTP id 6a1803df08f44-6abc7a9f3famr154298216d6.1.1716948024232;
        Tue, 28 May 2024 19:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIqWMtUS4LMCQMI46PFt7oF6eIakE+BnJJ45NfXiWEsWFHSAaiN+W3QyLy0HZkGaVGZVH0tw==
X-Received: by 2002:a05:6214:5988:b0:6ab:1b6b:c8ba with SMTP id 6a1803df08f44-6abc7a9f3famr154297036d6.1.1716948022387;
        Tue, 28 May 2024 19:00:22 -0700 (PDT)
Received: from [192.168.1.175] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162ef448sm49771756d6.97.2024.05.28.19.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 19:00:21 -0700 (PDT)
Message-ID: <a1ceff08-164f-d0b4-36b6-41a7798b82be@redhat.com>
Date: Tue, 28 May 2024 22:00:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dm vdo indexer: Use swap() instead of open coding it
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>, Mike Snitzer <snitzer@kernel.org>
References: <20240524074109.13433-1-jiapeng.chong@linux.alibaba.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240524074109.13433-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 03:41, Jiapeng Chong wrote:
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
> 
> ./drivers/md/dm-vdo/indexer/index.c:207:43-44: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9173
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Matthew Sakai <msakai@redhat.com>

Mike, can you make sure this gets applied with the rest of the pending 
dm patches?

> ---
>   drivers/md/dm-vdo/indexer/index.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
> index 1ba767144426..df4934846244 100644
> --- a/drivers/md/dm-vdo/indexer/index.c
> +++ b/drivers/md/dm-vdo/indexer/index.c
> @@ -197,15 +197,12 @@ static int finish_previous_chapter(struct uds_index *index, u64 current_chapter_
>   static int swap_open_chapter(struct index_zone *zone)
>   {
>   	int result;
> -	struct open_chapter_zone *temporary_chapter;
>   
>   	result = finish_previous_chapter(zone->index, zone->newest_virtual_chapter);
>   	if (result != UDS_SUCCESS)
>   		return result;
>   
> -	temporary_chapter = zone->open_chapter;
> -	zone->open_chapter = zone->writing_chapter;
> -	zone->writing_chapter = temporary_chapter;
> +	swap(zone->open_chapter, zone->writing_chapter);
>   	return UDS_SUCCESS;
>   }
>   


