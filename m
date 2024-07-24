Return-Path: <linux-kernel+bounces-261065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538F93B281
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071F91F21973
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC11591F0;
	Wed, 24 Jul 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdOkvauj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855A613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830459; cv=none; b=uNukixnKoa84eLHy0V4D7P6NSfx2Wr1wTmVZquoDFiDsaYO4WwuoFVTTS07N9TT/qccGkUmY1YKvHFOxY42MWaNqWOaSGw6wkR8zjdZU5MFTUZKRxN2UOynl4v9jz1wfriiawuJISdpef4XMVMHCXxTcKFLosHhxa+I73vu1OlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830459; c=relaxed/simple;
	bh=BQN8CwA3tBXR7SN8guM6tSo/3bOjUcuCS5u7ERin3V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFQQoI8mZwVJseP9BOCE/5h3ruzTk368t/guYwY09aToPf43guZhMCwCRMTGq5OQDh4u6Bs/t8XtZTujBOHh5ZlW40bzTfuwCGSY80b6MdwPZm7v0nywPEx/rzQV+9uUI8MItVcD/tT4HGTEjY+5aqvp/blXdmnF9wSmjcmoHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdOkvauj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721830455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZfbnMjKn+Ou5xciqWaM2b9lfq0I+PXMBIRspEzGa++I=;
	b=YdOkvaujvtna4Hk374y50tP041ZvEsmJgc53yd+fmbyMED5ckgncWd1PDacJ46TpME3H9V
	HYSa7GSJBHpUqm0JhtFOsfQowjPTzPkpwEefLpxHKnf9nbYtAz3SM0Ndo3hahrAbmzR+/C
	bgEDHmFy0kvcMPi3hE1me0ekHCueRU0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-PoYwesIUO7CXf2-SHhUFtA-1; Wed, 24 Jul 2024 10:14:14 -0400
X-MC-Unique: PoYwesIUO7CXf2-SHhUFtA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3684638af70so3887781f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830453; x=1722435253;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfbnMjKn+Ou5xciqWaM2b9lfq0I+PXMBIRspEzGa++I=;
        b=jkP14vFbak99o/0Qcpeg65epIm6MuzMDCOYHRwBokWgKNp1ncM0B1rwz/kpsyNwBHD
         bNePsdZxD9QOME8iOg3hp5TQgsJAXcnqZvK0qMGNqEW5yrxjCju+e9/GlaE5lSiQfYZe
         gy6F4vUrJCGAU0aMPtcSpqokVLErF/Gri3jmSQKkiqjeX13XSwlTp736sYiej3ACVPwA
         Dag+A0N1j8DjkwSjkSXXVFSD/LG9Fwc5uevpk+Ep243FPKSC/4qy1wsfFxU5hLG+xq3A
         WBXxynf5lHGQ3Q3Xv+N7vuUY3IArDEG7bi1kI5DIAoSthz+GjYkJ39Yn4fiZuSFaQMmY
         YoKw==
X-Forwarded-Encrypted: i=1; AJvYcCU3P3SHlpeZrqS4J2rTD6P1Wun8OPDahW4wy/ZzIB5/CFoIsZ8UTpY8R3HEo3HKmJ7C4/QZZN7rbmyOhcTGO9+GABk8NRuIVidgtOZ5
X-Gm-Message-State: AOJu0YyXdLIiFRPFxk7W2NG8nk6MJ/9wYL00hsLn3eZ2b0l4AcRX6+VZ
	VyZj9RP/QhgQWZUltZP5IoBfpkqpSbRptJQdpj+os/IND/p7ytL+DQRk1HZy7O9P6dsp1crErqB
	iUZpege4YmB6RRHtqZKeY/phCtAIuHtzqRf7tV+Dbxt7Pe07fk1569vYHmoKE1g==
X-Received: by 2002:a05:6000:1291:b0:368:5b80:b8d with SMTP id ffacd0b85a97d-369f09b600cmr1946164f8f.21.1721830453170;
        Wed, 24 Jul 2024 07:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtlfF/4HJ9++sJPlr8qtuUlJiLPxaAiImPf5nhKWxysXeLXnCclTR9m6j5oaMuw9XBvi9vRw==
X-Received: by 2002:a05:6000:1291:b0:368:5b80:b8d with SMTP id ffacd0b85a97d-369f09b600cmr1946147f8f.21.1721830452732;
        Wed, 24 Jul 2024 07:14:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:bb00:201f:378f:5564:caeb? (p200300cbc739bb00201f378f5564caeb.dip0.t-ipconnect.de. [2003:cb:c739:bb00:201f:378f:5564:caeb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368786949f5sm14462571f8f.57.2024.07.24.07.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 07:14:12 -0700 (PDT)
Message-ID: <e9b2d908-5a48-4c4a-b7e4-d82e36ecf143@redhat.com>
Date: Wed, 24 Jul 2024 16:14:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem
 tiering is enabled.
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org
References: <20240724130115.793641-1-ziy@nvidia.com>
 <20240724130115.793641-4-ziy@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240724130115.793641-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.24 15:01, Zi Yan wrote:
> memory tiering can be enabled/disabled at runtime and
> sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
> it. In migrate_misplaced_folio(), the check is missing when
> PGPROMOTE_SUCCESS is incremented. Add the missing check.
> 
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e7296c0fb5d5..826afb82ca56 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   		putback_movable_pages(&migratepages);
>   	if (nr_succeeded) {
>   		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
> +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> +		    && !node_is_toptier(folio_nid(folio))
> +		    && node_is_toptier(node))
>   			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>   					    nr_succeeded);
>   	}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


