Return-Path: <linux-kernel+bounces-244106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F9929F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5E0289799
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA05B69E;
	Mon,  8 Jul 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoLsbXqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FF3F9F9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431402; cv=none; b=Cgtw2tNUmU1LhY0ZDoH0lGA1VN2ZEqybrL1MrlRICTAr817NwNcR9aAfNt2dFBwNOLO1gKoklqcNxUf8+iAnVtsnAmDsKRlBqItnUr2Vkn1vKmXpz6qxgm+ueMugSQfkXjIUQcGc0JFPUtVPTmSjE555YaRckWqRknHUNja24Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431402; c=relaxed/simple;
	bh=KQreWbux+WJMpio2LNVzLl8noLFw/SrgaA8Ebm9jWmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZ5TQoVgRZPg4R4DmZ8mEnr7MIvyiMk7kA3VZlaxUufmNsj5l9ixzs97kgezHLxghT6FINIx41yiJYR1inPd0OQRZgWoV2luJaQjiSSH0KlWpJrZOQkbcqnLWRUrKErUjzV7wYL3vb/IbQQWtFxiNC8W9JJ9Au6Kq9gsWQb605Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoLsbXqT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720431398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eU7QmxHMjysAW236gNJ+2qLBiUzO+NBXRFbeORsAJCM=;
	b=IoLsbXqTe7DLBkIu5WFfh/Ri9cNKoM86TaFbq8MlwN2kH5r1fLx8xmsNWwlxfCWdeUbwOp
	luhRTDgeRKnc4snLWOZVrXeJ+90U5606+VgAGgpiQivcMQEgap+YcGAJKZVnH81JEXKkRn
	8hejgo1LsNPZziC+Tg8IQwZ95Pwpf2w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-wgoopNssNSa4fJhFPnIUxg-1; Mon, 08 Jul 2024 05:36:37 -0400
X-MC-Unique: wgoopNssNSa4fJhFPnIUxg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77c830aae3so231149566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431396; x=1721036196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU7QmxHMjysAW236gNJ+2qLBiUzO+NBXRFbeORsAJCM=;
        b=Rf4SX/4hz/eYRhfAcen0LzoltksJm8k2QHRz0Mv6Z+X0CoJeqZi4OD+Vcq2W+rNOka
         mQju7Dk0t4/qeJe2l/TxEaQ9HQR83VD6woBA5V/U81h8UNzrbo1xaPT/PQ3/b18JMuI9
         HOh4vIVdXQskgg3id+rzk9DoPCjpyedF+BjstcrE2QnmgHPNsUaTHCRcmWXjd4BbZNee
         KUEdkYvWsmOTYCZ2r5xlYIxZRmOw7BUvVdw06OwTEDhIrFzqcy1egGVMzaEcVwiF3ely
         lRZ7h0S4O6oPJiIutr5AJl3oSvlUs+O0s+P/Olnfp7Wz4U8s6fhgOu1Q4WDl/CRttRe6
         WE1g==
X-Forwarded-Encrypted: i=1; AJvYcCWS5cNnjTXGkAqdnRYaL8SkL9E0nlQYpkkOWtHVbBta1eLFd6pEecTtaSMbJE7CybjAxFkQBFk7/TNzMYrmu24+0Skh+8HPfc5ELano
X-Gm-Message-State: AOJu0YwcPoLGs8XT9ye+0KN0A4vryMR0hnjInWv122sFL+duMrkyI+GA
	gXX8jVHK9JZoL88N7osBGeDbJQnfcTsDiEGFL3l5w0WwIZDRPN79OIEPUZDz3zgHlGOAlMtaXhQ
	t6KK011RAyOiPlbLVnkTNX838K6c+iLK3jsNuZxJg7KaDWM5SZh4f4oYczSKcXQ==
X-Received: by 2002:a17:906:f8ce:b0:a77:d85c:86fa with SMTP id a640c23a62f3a-a77d85c877emr463779166b.13.1720431396092;
        Mon, 08 Jul 2024 02:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT1ZaoJIf6SEmzQZ2Rfn8IFMHpcuNwp/dBZWmltVdEGSFAlf1cKQcmOuURX0FRl6yZTD7L8Q==
X-Received: by 2002:a17:906:f8ce:b0:a77:d85c:86fa with SMTP id a640c23a62f3a-a77d85c877emr463778066b.13.1720431395649;
        Mon, 08 Jul 2024 02:36:35 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f924.dynamic.kabel-deutschland.de. [178.24.249.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77d37c97a2sm272449066b.40.2024.07.08.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 02:36:35 -0700 (PDT)
Message-ID: <ad7873f4-9c98-45cc-b7be-0c1c36b65ade@redhat.com>
Date: Mon, 8 Jul 2024 11:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: Zhiguo Jiang <justinjiang@vivo.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>
Cc: opensource.kernel@vivo.com
References: <20240708090413.888-1-justinjiang@vivo.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240708090413.888-1-justinjiang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 11:04, Zhiguo Jiang wrote:
> The releasing process of the non-shared anonymous folio mapped solely by
> an exiting process may go through two flows: 1) the anonymous folio is
> firstly is swaped-out into swapspace and transformed into a swp_entry
> in shrink_folio_list; 2) then the swp_entry is released in the process
> exiting flow. This will increase the cpu load of releasing a non-shared
> anonymous folio mapped solely by an exiting process, because the folio
> go through swap-out and the releasing the swapspace and swp_entry.
> 
> When system is low memory, it is more likely to occur, because more
> backend applidatuions will be killed.
> 
> The modification is that shrink skips the non-shared anonymous folio
> solely mapped by an exting process and the folio is only released
> directly in the process exiting flow, which will save swap-out time
> and alleviate the load of the process exiting.
> 
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
> 
> Change log:
> v4->v5:
> 1.Modify to skip non-shared anonymous folio only.
> 2.Update comments for pra->referenced = -1.
> v3->v4:
> 1.Modify that the unshared folios mapped only in exiting task are skip.
> v2->v3:
> Nothing.
> v1->v2:
> 1.The VM_EXITING added in v1 patch is removed, because it will fail
> to compile in 32-bit system.
> 
>   mm/rmap.c   | 13 +++++++++++++
>   mm/vmscan.c |  7 ++++++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 26806b49a86f..5b5281d71dbb
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio *folio,
>   	int referenced = 0;
>   	unsigned long start = address, ptes = 0;
>   
> +	/*
> +	 * Skip the non-shared anonymous folio mapped solely by
> +	 * the single exiting process, and release it directly
> +	 * in the process exiting.
> +	 */
> +	if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> +		folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> +		!folio_likely_mapped_shared(folio)) {

I'm currently working on moving all folio_likely_mapped_shared() under 
the PTL, where we are then sure that the folio is actually mapped by 
this process (e.g., no concurrent unmapping poisslbe).

Can we do the same here directly?

-- 
Cheers,

David / dhildenb


