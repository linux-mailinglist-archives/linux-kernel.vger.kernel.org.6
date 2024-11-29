Return-Path: <linux-kernel+bounces-415430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0D9D3602
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5DB23C36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879F17DFFA;
	Wed, 20 Nov 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCfmr3Nj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F7219ED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092906; cv=none; b=RXCS475bLfHXyodDG4l6FazUxXazWapeqhLf3neOup98IKtB9JiV67LzYk8BvfuNyerq/dFwyjaqt4wK4/PdE6WYtQ4zmyAdLFqrE9LVlbJNZKPQFQbidNz6b5VhVqADgNZ7Ur4GGeJ8YS8eDegWFxtUPFUa4UIlyzAHDz6Y4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092906; c=relaxed/simple;
	bh=nid7QSnQblLfZFZqlvoCYnby8cBRsCYTlv1NQ8OAb8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDBLSyFy1Nw2BnTvPwHDrPO2mneTmLVdil+ZeaOLPkB02G95sH3Kg6X9Q0bmekchtHorF0cd6HzJ09M0NeaC15fThQgWgUpakmFK73UkPBEVIIjcdwh11cAk39LW/qNVNqBdJzEauYKjjXXUVrXdCh+vRv+M41s3ZVoB5Vi6Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCfmr3Nj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732092903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JMYPpUq2XDxx8Xvb7qlMs/pEnqIP8D2NZt89L6OHoyg=;
	b=LCfmr3NjufGW65LFj3n29fOUlknf3FZPInMknauk12VtQOdTmhQa/Mn55rOQwEqhpcjgWS
	XUfC+S6VGkTUng0CwzjXWUpPiW+y6m3T7oNAdFNDo5L97ZcCc28pN6tIIkCB59zMvr+yhs
	2l0lW0qWKChrxWfS0Pp1JXIWXlWgwKo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-uPgSCJORN-a900BLZBvV_g-1; Wed, 20 Nov 2024 03:54:59 -0500
X-MC-Unique: uPgSCJORN-a900BLZBvV_g-1
X-Mimecast-MFC-AGG-ID: uPgSCJORN-a900BLZBvV_g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso14845935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732092898; x=1732697698;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMYPpUq2XDxx8Xvb7qlMs/pEnqIP8D2NZt89L6OHoyg=;
        b=fUpIaykbmgMjQESDZdLRIywA8r6ryU6unvVOkN2c7fgr6hw5vYHu+cF+DyUDhYRBOS
         4/gHx54p9OcYBkGxoQUI/PyI/pHrD8FiqagIxdXGhiy7SKQ4uajhuRlbDuAYbATLDxG3
         g1HgV74h8jyheBziipDZHDOIDfnV37j03DAu3OJGSv9l7/fM5KNnVuVR1tI7y4GRjLoD
         rmrfGAXM53Tm67OT9JX78gvQd6h2NxDkDstVVK5KLZneeIeQEgOekoIdVwQ+Yn6qsDDU
         usUOZ/fvqehxavFL+T+H7U81EzexnTy7hCf9osLYe2R4DzRed8o5m7EszyODWXjWyBG7
         cPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNBSy6xglTslIamoRcloK2qVrjh1wtjUC8khiFohmJPbLh9QCzh25gzUWVhEIcgx317wQ2Eosws87uk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWCtqCGLuhy8mdus5ddQu2WZ3u1BqJsWZubF4H0o1vImk/JaJ
	68EAQgBfUEy2TDlzdLKvmleRXb5ALJ3A7Ea3bDm0gGFJ0E7pIUvWFR1CDOimGKblQdHZFbJyYVL
	xOnIcpMcSe3LVlepmrWtkiNEunaI88hQ5l9zVebdZoZG+HN74TarPyCI6UdHeMQ==
X-Gm-Gg: ASbGncvZhIkXeaWxx1YtIntDyG+Goxe2AYcq/9gK6EeRjm5huazFLQdiWdfs7K5KO9w
	If5+AL1YUzj+j17548gSLgg5H7obNXMeowpftp1DxIsSuQPrGIkw+JZtXiFLF/TPOunAsSaf76W
	dlCGrpeL7UmLQRzdrDdDTNuewnaVTN+1LwjNrtWjC0w0s1QL2aNoFh6Mi2YDS1tZpP36J72GsXa
	E7oEyqJuMGAeAzqE3t2xvSw4HzQfIdOszzRTj+RNc5kYPgrrnnQE076Etf2wJhRDO81fOImlZLK
	yOwzF1oL/MnOWsV7KF2FwR4AcVZnHFX+aP5sRzO0Nff6+LDrE2UtDyHxsk9AQZws8vL8FGUOi8t
	NLw==
X-Received: by 2002:a05:600c:3d9b:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4334f016ecemr15122035e9.25.1732092898613;
        Wed, 20 Nov 2024 00:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAXo2WtFyTtlUkIZYThyUarlZoutt+Vkv1nHozZ0jnX+DGSyr3choO6UEwt7EDBYp0SzUvIg==
X-Received: by 2002:a05:600c:3d9b:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4334f016ecemr15121935e9.25.1732092898252;
        Wed, 20 Nov 2024 00:54:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905437sm1468998f8f.3.2024.11.20.00.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 00:54:56 -0800 (PST)
Message-ID: <1dd9689c-f392-4bb9-a3f6-359d84bb3183@redhat.com>
Date: Wed, 20 Nov 2024 09:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: Use outer variable 'page'
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, mst@redhat.com
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 06:49, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no need to define a local variable 'page',
> just use outer variable 'page'.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b36d2803674e..89da052f4f68 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -251,7 +251,7 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>   
>   	for (num_pfns = 0; num_pfns < num;
>   	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = balloon_page_alloc();
> +		page = balloon_page_alloc();
>   
>   		if (!page) {
>   			dev_info_ratelimited(&vb->vdev->dev,

Looks reasonable

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


