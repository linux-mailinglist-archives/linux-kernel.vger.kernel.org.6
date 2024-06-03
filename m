Return-Path: <linux-kernel+bounces-199415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752F8D86EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CFF1C21922
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FCE12FB2D;
	Mon,  3 Jun 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2Slb6Tn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8E134409
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430870; cv=none; b=G0CpwvGh0auQgGYz7hTrTcElWl1gXVFUA4r7MzoHp1ovd0vuHLnAxC4y4vDitbRUiwEXOvyYNMSTRHfSnkYtUZcmnIGZxdVYotjqxYYyxY9oi1ccZASZMjctN+jwkfmXc0tSeiNnITJzbFWYhDwBanoCCcaEMypv6r1FpgXC5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430870; c=relaxed/simple;
	bh=gAkZrmhsWjiuqSjaLWzrSfZcZKDPi/3J/0JelfMP2Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn5XxP4DgWoNpKrPlG4E5Vyq/CfpYWhjka14mxxxS9lZ1OPNaIySnOH/mVZ2hU1O3upapFHE94fmRETB2g+o/VtmMVDkWOmwg8CHqfFTuSs4JiEmvnpPQRqeEET6DF1eQpVDiVMWq2HX/1l5vnkMmzPSFVR7UfIm1bDBMg+TZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2Slb6Tn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717430867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tXPXokhm2bGedsPgz0iJ5Czp96sqvizSxz1KwzeJ7QM=;
	b=P2Slb6TnSFccqfeQS1jD2jz5hWzap1cPML9kvxojk12+ZhDGwarXtjWJEMPVBrBuu5RnU0
	ELQIMcuOQ8D2PZsQvrYXIFwY86fil5wAOr6F1lPrBwEwSEse4TNINxd/pxVMdY+JkTCkUk
	LLRn5MHwl37Rqa/As+SwBajZBce77jA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-4Xi6ZVXiN9iX_gATbYMGQA-1; Mon, 03 Jun 2024 12:07:45 -0400
X-MC-Unique: 4Xi6ZVXiN9iX_gATbYMGQA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ea91ce9225so29909761fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430864; x=1718035664;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXPXokhm2bGedsPgz0iJ5Czp96sqvizSxz1KwzeJ7QM=;
        b=lazUBIQW4mxLNW0O4D3TDoh57wdafM+nB+VFO4ya8/XNxh0oXAfE4zFQZb3jZ+jFJf
         cDtzeqU2R3qvkpSj1AWVRXSVLyzNHGvnCiWh0sawc5MMZYaP50L8eNnicVq0cAKVfqvp
         w18oZrloGP9yrSGkCT6pG+xs+Nyb1aOWAQD7w4E0FVbhoU7GHv7vIc9fl8jokzIemiDf
         P4bhZIK4A/Wl3RaGa7/zmB0SBU7AY96RE9Ux0XuB/Qm6vE/viQOOyUCYX6QJLmxjHvh5
         3A8KvAzZXE3a+1BADVC2A9F99o5LMen8O1J4MmP5Kqu1nYPAqyu0+74WO0hsFLxw/ksx
         emsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/eHmNFgKK18IsKEQI5HSoghaUOjVT6EjeGv1MMifKX08bY6Ise3q5ZO2U33RJhPG/uYauJXiTSzWF3mi0g7rKyiUiL87YYkiqizrF
X-Gm-Message-State: AOJu0Yyl246rZ+njuCf9GaHUS4Vg97FkUoB6uwuPh7Q+4VqpDhJ6rieJ
	pq/NA+1dWBU7vteO8xEZaSqQ7AfKoP8zc9Eo1ZuYzh8Uf8ceQwWPbVCCF9ZgIuUIYQ3u5ZkLhaH
	WR9LZyF+kE8IbfW8SI2PykSdp33pCjbXAtXM+h5XTDTUiSamRbDSHDIQg69oTOP+oNgyO2g==
X-Received: by 2002:a2e:8712:0:b0:2d8:5af9:90c5 with SMTP id 38308e7fff4ca-2ea951de2cemr89657341fa.39.1717430864082;
        Mon, 03 Jun 2024 09:07:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF555BWHci4QJX5r+lhWT36QemsiEtqxq9BMeWImzIx2tYHaR1C7OELl25mY6OrRPMFQwiWkA==
X-Received: by 2002:a2e:8712:0:b0:2d8:5af9:90c5 with SMTP id 38308e7fff4ca-2ea951de2cemr89657051fa.39.1717430863553;
        Mon, 03 Jun 2024 09:07:43 -0700 (PDT)
Received: from ?IPV6:2a01:599:908:c963:af9b:c64c:dfd8:5999? ([2a01:599:908:c963:af9b:c64c:dfd8:5999])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91b9d678sm12672781fa.24.2024.06.03.09.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:07:43 -0700 (PDT)
Message-ID: <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>
Date: Mon, 3 Jun 2024 18:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: prevent accessing by index=-1
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240603112830.7432-1-abelova@astralinux.ru>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240603112830.7432-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 13:28, Anastasia Belova wrote:
> nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
> array by invalid index with check for nid.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   mm/memory_hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 431b1f6753c0..bb98ee8fe698 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -846,7 +846,7 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
>   	unsigned long kernel_early_pages, movable_pages;
>   	struct auto_movable_group_stats group_stats = {};
>   	struct auto_movable_stats stats = {};
> -	pg_data_t *pgdat = NODE_DATA(nid);
> +	pg_data_t *pgdat = (nid != NUMA_NO_NODE) ? NODE_DATA(nid) : NULL;
>   	struct zone *zone;
>   	int i;


pgdat is never dereferenced when "nid == NUMA_NO_NODE".

NODE_DATA is defined as

arch/arm64/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
arch/loongarch/include/asm/mmzone.h:#define NODE_DATA(nid)      (node_data[(nid)])
arch/mips/include/asm/mach-ip27/mmzone.h:#define NODE_DATA(n)           (&__node_data[(n)]->pglist)
arch/mips/include/asm/mach-loongson64/mmzone.h:#define NODE_DATA(n)             (__node_data[n])
arch/powerpc/include/asm/mmzone.h:#define NODE_DATA(nid)                (node_data[nid])
arch/riscv/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
arch/s390/include/asm/mmzone.h:#define NODE_DATA(nid) (node_data[nid])
arch/sh/include/asm/mmzone.h:#define NODE_DATA(nid)             (node_data[nid])
arch/sparc/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[nid])
arch/x86/include/asm/mmzone_32.h:#define NODE_DATA(nid) (node_data[nid])
arch/x86/include/asm/mmzone_64.h:#define NODE_DATA(nid)         (node_data[nid])

Regarding architectures that's actually support memory hotplug, this is pure pointer arithmetic.
(it is for mips as well, just less obvious)

So how is that a real problem? Do we have a reproducer?

-- 
Cheers,

David / dhildenb


