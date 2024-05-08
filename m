Return-Path: <linux-kernel+bounces-173055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B78BFAD9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE451285E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD87C08F;
	Wed,  8 May 2024 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnGdBAhc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2822575A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163886; cv=none; b=id4UV7F5cCYdQoGoGPrcO2T3+ZcDmsse6Sha7Jd5t6xWPUdfzk15EDJ+oxAj63rJkfdC/vwcFUYKiJe1DiZRbqiUWgs6TNruZYM1BaSVuIbMMVKSLprXarJ34nHQzs8V6ExQ7ABVPWty5flST++LqrwKEjTSIAZQ6DpWeByJ0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163886; c=relaxed/simple;
	bh=4iYihW1yC8vybBr0yLnEg/lM0tpWJllrCUd0x8igwCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tleh0+2zevNtGKaFwSdebdZzxayjIfUC0eYqTnDyXYwQ6uvoWk2xGKZZZsJCFA1BIJkwprDBro7hs/dNsRCVTozwvnOANRYrmeQGCnLXrFxecBG582mheRdFrLlTQ/z6MJDLQ3rKltV0+tjXSNLOxn08xpEUT+7glrft4FLdPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnGdBAhc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715163883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XnG3psXeBYa/ivD3KAPPTeGItEb7Z4sGj5rmd5cHNeI=;
	b=AnGdBAhcPok5pnD0/VOuJp+B5TY9WP4IVbexoJrw0hwiTBnvEV8z2f/6OvzlFhqpQayjXf
	dznBRpjJZJkr/WwU3srP+g0xeljsU8nDeUZD3/PCnzVtXKMws1blGj2qN4a3YaAv8WsGdJ
	Q6iPSAdb0UbJbaobbO/6dfv8TPtaMr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-NFBIdVLRN8OPu6K0rcvQjw-1; Wed, 08 May 2024 06:24:42 -0400
X-MC-Unique: NFBIdVLRN8OPu6K0rcvQjw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so3608835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 03:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715163881; x=1715768681;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnG3psXeBYa/ivD3KAPPTeGItEb7Z4sGj5rmd5cHNeI=;
        b=fDD8/XDTh+w9i2M/gphxWekTkNI0AO5GzLoHuiWaQEkUroWNVOZEPkK9MILSf4AcgT
         eFuJAG37NBZ04Lwg8qyzqKvKdrcGwo33i4MaO1wDcw7aEJm4tRw6dqOlSe6JSraxdZ8/
         HYpmHHchAbPvtdCmOHKQMfEsDx/McwSSRmeC5qeIvjDvTXmTjQPk9F449FAKS+zdE1HI
         KT1Je1MiFdgKwVXsbC7cZfXgGewWKx+3TVPoScTQt0TdkG7Upd3tpaFHxe1LZ1jKg0vC
         0Qz9fkQwgwePyWoieFndIGq4J+oikYnZfHI1tv+giwWdTLWouySIn8cfmoK5yk733tYl
         UbUw==
X-Forwarded-Encrypted: i=1; AJvYcCWz1tPEfRRlAWqXBt33BKTqcLnvaUHyoNY/dk5k7a9vzpjgW6tV0Jy49h6XQaSymgW8SrM4Fl7vpL/ZbZv+xH1Ndo6D5rba6+AIevCx
X-Gm-Message-State: AOJu0Yy01dLyWfSmILOSP+yQzIFzQO53CDZirJewvQKXJFDPAo8Ymw9K
	a3tUMLOWAdsB2Po9qhZqdbhqhrZIkqYLIRpTatNzIDf7g8L5uqg8XzGvssVY/idPVlOcpKyGkzW
	dJ0Xfo2Zwp2fLhdiIlm1S2fq1sagopnaebtjxNkwyqz2QbX/Gsrtzel5bKsNJag==
X-Received: by 2002:a05:600c:3c92:b0:41b:ed36:e055 with SMTP id 5b1f17b1804b1-41f71ad0c4emr21790625e9.7.1715163880952;
        Wed, 08 May 2024 03:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxh8KFUNfy+USArt4pA1Qz9zzKEyel29xMDCV0k/Z92O0iZ0FrHMCLUzTqlCORPocJeVJsxw==
X-Received: by 2002:a05:600c:3c92:b0:41b:ed36:e055 with SMTP id 5b1f17b1804b1-41f71ad0c4emr21790485e9.7.1715163880564;
        Wed, 08 May 2024 03:24:40 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id dh18-20020a0560000a9200b003439d2a5f99sm14988890wrb.55.2024.05.08.03.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:24:40 -0700 (PDT)
Message-ID: <9a1fdac7-8bbd-48f4-bf31-86916ddcf4ed@redhat.com>
Date: Wed, 8 May 2024 12:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/ksm: fix some accounting problems
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roesch <shr@devkernel.io>,
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 11:55, Chengming Zhou wrote:
> We encounter some abnormal ksm_pages_scanned and ksm_zero_pages during
> some random tests.
> 
> 1. ksm_pages_scanned unchanged even ksmd scanning has progress.
> 2. ksm_zero_pages maybe -1 in some rare cases.
> 
> The first two patches fix these problems and the last two patches 

Can you find+add "Fixes:" tags for these? They look sane after having a 
quick peek.

-- 
Cheers,

David / dhildenb


