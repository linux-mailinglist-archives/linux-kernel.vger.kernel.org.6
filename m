Return-Path: <linux-kernel+bounces-240876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24898927411
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851731F26DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99E1ABC27;
	Thu,  4 Jul 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwkEdEZU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D201A0B1D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089011; cv=none; b=sDzlwWsWbDRTcbMwFBHM0512GTpBStRw7LvW+HoqONNTZkE/iEORcsFcTAA4Rr4x0oXsD0L5b6AMCUaMVIPOf3JKBwNlh+EwoBt+0ptiuc431jd5FF8/0ft5Xy96PyqyuNQdb35J3s15HMRUJCvFczpvj5HkLBinMJELTXqYAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089011; c=relaxed/simple;
	bh=+lkrIR1bq56Bpkqbe4+GtA2NbAz4kJNIVK2yylj+f8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP4mRCod++lKvka3rftpg5u5YoHKSBPBpEJGEifXhQ5k3bbOavzktcXpMK8QnmLXu1dQNtH65So20oG/iTyL8nNn09I2c1DLRkMwHzlOIB242UvawPZQiWmmXMl9w06VfaTzPfM2OVjfizGIcoWIV4lJ/j6TEPPEc4pABowsiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwkEdEZU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720089009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P+zInmx7lAEsRqrQSKOo83k0FgJwhGLLhx0HfM+9dWU=;
	b=GwkEdEZUw9wh/I088N/eCed2gvp2Q0LL9o2dpFaOAw0oTMuiH8KL/gSJ4gQmUXeCPhFGhb
	xhZk1slvbVd6HW6t4GVHwPnNLex1in8oxEmV/AC+4biOWB/Ahv32S7Dt2QoVcM/lDADPDv
	TS4ekyWDFe8aGFPXyUfddgYaTOJnOGA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-c362JvdkPIqdMDX7_u7iQg-1; Thu, 04 Jul 2024 06:30:08 -0400
X-MC-Unique: c362JvdkPIqdMDX7_u7iQg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367879e8395so298628f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720089007; x=1720693807;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+zInmx7lAEsRqrQSKOo83k0FgJwhGLLhx0HfM+9dWU=;
        b=A0GxUbp7LQFWdHZrfXgVA077osMcrf8+QjucCurSWcRYefw6+hufExSumghdPvD2gm
         lG5bE5Rm7B3bxrohw6Xi+pNYxUm2ggF54JGm123qbVOxH32mrsPj7Pz/7b7x4u61lACd
         +I7ysEcZApn7Nol3Igy1J3JN8DOiD+ufNMCxrremjkTdl2Wn/LxDGOzWlTGLY7zZtE3N
         PDrHn54LiwLkrQceRp/n5BAnJ8+LuA2pG/oPH6PqEh0HGRAPIPOKNY31cp0ePpi2LDMA
         98kAyg5WWV+ZxpBu2/hgyjmmmLPVhP7RXjiaOYyU8VCkhWzOWPXnVS53lORdfkKOqTbs
         XY/Q==
X-Gm-Message-State: AOJu0YyNnMi2tAXPBzNkdqluxM/LN1qX3Sy14k+/fSQ+Ohfc1qKHdACG
	/pshDC6Lm/gaK8XmWk5dxq9hMyNwEfpaa/QYellA8O+Jd1Q4rDNIngSZDyR3ITkF5fWYBC7xmyH
	rAG+iQcEC7UyP+zr9oDxa/fZg/JKFWPVm88Byw0WCmmxiEjeEFNasHO/MqMQv1g==
X-Received: by 2002:a5d:444e:0:b0:364:4b4e:9310 with SMTP id ffacd0b85a97d-3679dd0e904mr940330f8f.1.1720089006748;
        Thu, 04 Jul 2024 03:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrxpb2E97sEwgxs7eh5fcMKhcnWD6ZNMPDQtn24tupytfspqqLIW9DgVQaoZnd1L92fMlHvA==
X-Received: by 2002:a5d:444e:0:b0:364:4b4e:9310 with SMTP id ffacd0b85a97d-3679dd0e904mr940304f8f.1.1720089006282;
        Thu, 04 Jul 2024 03:30:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36796b3efb4sm3026251f8f.96.2024.07.04.03.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 03:30:05 -0700 (PDT)
Message-ID: <f8a7b3a9-251f-44bc-a8db-3cafaf88487e@redhat.com>
Date: Thu, 4 Jul 2024 12:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/45] fs/proc: Enable smaps_pte_entry to handle cont-pte
 mapped hugetlb vmas
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240704043132.28501-1-osalvador@suse.de>
 <20240704043132.28501-12-osalvador@suse.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704043132.28501-12-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
>   #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> @@ -952,6 +956,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   	struct vm_area_struct *vma = walk->vma;
>   	pte_t *pte;
>   	spinlock_t *ptl;
> +	unsigned long size, cont_ptes;
>   
>   	ptl = pmd_huge_lock(pmd, vma);
>   	if (ptl) {
> @@ -965,7 +970,9 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   		walk->action = ACTION_AGAIN;
>   		return 0;
>   	}
> -	for (; addr != end; pte++, addr += PAGE_SIZE)
> +	size = pte_cont(ptep_get(pte)) ? PAGE_SIZE * CONT_PTES : PAGE_SIZE;
> +	cont_ptes = pte_cont(ptep_get(pte)) ? CONT_PTES : 1;
> +	for (; addr != end; pte += cont_ptes, addr += size)

The better way to do this is to actually batch PTEs also when cont-pte 
is not around (e.g., x86). folio_pte_batch() does that and optimized 
automatically for the cont-pte bit -- which should only apply if we have 
a present folio.

So this code might need some slight reshuffling (lookup the folio first, 
if it's large use folio_pte_batch(), otherwise (small/no normal folio) 
process individual PTEs).

-- 
Cheers,

David / dhildenb


