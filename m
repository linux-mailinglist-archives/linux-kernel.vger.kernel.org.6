Return-Path: <linux-kernel+bounces-384678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E677D9B2D23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DED1F22A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D180B1D47A6;
	Mon, 28 Oct 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ4aJRnN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D231D3573
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112220; cv=none; b=pQ/MctKGWKTPTdA6EMsIAxB5KVBJlWNNIJ8x9fX3WYUycDVId+VIObMMLffqdftAlRiv8OyQt4aCK4ey8sxj323oPtNEqvx/VJXtlU+Qxjd6M6k+s5yrKIj5CLCptm4CEDQDXJUWDV2a3NbxCSvJgMDDz7ohLgQwMmUmuFmhvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112220; c=relaxed/simple;
	bh=pKpAY5UZH030k+ndNggiQ5zjwQSAqbURCXK/mZDE9mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHFZLJ0vTYKNkaDK3VVmQB7mgxC0P+bXPO2PiHCD03Z5hDa+IrlytF4Nywubn2JxyyeuwdmPgiF7wPmpaKmAiSJN75+Uf6AYHBiyozw88/Mrk5uTc1VQYwnmjMjtje5lDan6NeQ7sjrSAGtAuMFDZoiSNw5fXwDxDUQYE/FNi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ4aJRnN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730112216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Er/R+Yifja4ImgVy7aS7mDXh8qMK063VpwbmeJxG23k=;
	b=eQ4aJRnNlW2ED5aJM3h5FKut0OAB2y5gftv+S+8w7RNDiBrwZ0xEqamTwytHGQtWVaMoid
	/gYmhHe6xmgm1AGrRq9/qQLDZaGvHsrfdfHkI/M5Zc/ELHMr875xVnqw//y0/kvadwf9bn
	+7Ejrl/Fmxunk4kqNDSOtMCbTuv+S/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-87hEWkZuPL6NtVVVMdl4kw-1; Mon, 28 Oct 2024 06:43:35 -0400
X-MC-Unique: 87hEWkZuPL6NtVVVMdl4kw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso2041283f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112214; x=1730717014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Er/R+Yifja4ImgVy7aS7mDXh8qMK063VpwbmeJxG23k=;
        b=rel8XzLUikL0CGHI5zbWX25ZmjNiqihH5bNkufdoqVEurkQZQ3Nyw4Wh0p7ijTqNtn
         4WQAV8KicYrO+4M72liwreVH5DfXIRMIljd3dFdqFFxp837gFcfwDlUc10xYVFifqa/b
         WyHqvSdazcD6yuJ+e/eHchAKdtBZVm3Tg4nAAEusqvd+KBKmJAtqZUDyjR/1jT0csmeJ
         vImsPq2zIuPKhf8W5LkEikMS33uouqemPrjmoKNSneVdKmdq/bGyFeRL9t7cjnBamm1R
         d45bEaLuWBH1/aSQC18MHGUDxMvUt585L6qAbVVdwqPrAOBMKji6qEw6fGbKmEtLlRuk
         Jv4w==
X-Forwarded-Encrypted: i=1; AJvYcCUe/cPXiGpo6ogSi1e76XccbszaDksRK4mSdw5KjxzGfit9mDRbVjwGgAHb8ACloLGcNUOZKsgOrtCc/eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/d8UCpb8dvD+h5fEr6A05Ae/WR0VqMFGxAP3ltJ0QGX29Msft
	gaL4EcBcETgw9VRsjnySrONgPMWHW+07JbCdgUNDV2uqhDJers629IvW7MDeNe2vMYZ8JzqxXvx
	+6XYuIBMKwJbdy6xN/9hXyCpn/Y6WlN+sde3UpdE9uUYwgFdx0Hxf3wGLCaTrEA==
X-Received: by 2002:adf:fb48:0:b0:37d:49cd:7b46 with SMTP id ffacd0b85a97d-38061158f51mr5431477f8f.27.1730112214348;
        Mon, 28 Oct 2024 03:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSubg4YPGmobJlrpNQHboFA2Zds+eU2DuWv2+2icFLHZ81z5soPdnzz2/2j3JTJSHNfYilsA==
X-Received: by 2002:adf:fb48:0:b0:37d:49cd:7b46 with SMTP id ffacd0b85a97d-38061158f51mr5431456f8f.27.1730112213923;
        Mon, 28 Oct 2024 03:43:33 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47946sm9154961f8f.47.2024.10.28.03.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:43:33 -0700 (PDT)
Message-ID: <154430c4-7b17-443f-8628-ef3bb7738ae9@redhat.com>
Date: Mon, 28 Oct 2024 11:43:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix v2 2/2] mm/thp: fix deferred split unqueue naming
 and locking
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
 <8dc111ae-f6db-2da7-b25c-7a20b1effe3b@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8dc111ae-f6db-2da7-b25c-7a20b1effe3b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugh,

mostly looks good to me, one comment:

> +++ b/mm/memcontrol-v1.c
> @@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *folio,
>   	css_get(&to->css);
>   	css_put(&from->css);
>   
> +	/* Warning should never happen, so don't worry about refcount non-0 */
> +	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
>   	folio->memcg_data = (unsigned long)to;
>   
>   	__folio_memcg_unlock(from);
> @@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>   	enum mc_target_type target_type;
>   	union mc_target target;
>   	struct folio *folio;
> +	bool tried_split_before = false;
>   
> +retry_pmd:
>   	ptl = pmd_trans_huge_lock(pmd, vma);
>   	if (ptl) {
>   		if (mc.precharge < HPAGE_PMD_NR) {
> @@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>   		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
>   		if (target_type == MC_TARGET_PAGE) {
>   			folio = target.folio;
> +			/*
> +			 * Deferred split queue locking depends on memcg,
> +			 * and unqueue is unsafe unless folio refcount is 0:
> +			 * split or skip if on the queue? first try to split.
> +			 */
> +			if (!list_empty(&folio->_deferred_list)) {
> +				spin_unlock(ptl);
> +				if (!tried_split_before)
> +					split_folio(folio);
> +				folio_unlock(folio);
> +				folio_put(folio);
> +				if (tried_split_before)
> +					return 0;
> +				tried_split_before = true;
> +				goto retry_pmd;
> +			}
> +			/*
> +			 * So long as that pmd lock is held, the folio cannot
> +			 * be racily added to the _deferred_list, because
> +			 * __folio_remove_rmap() will find !partially_mapped.
> +			 */

Fortunately that code is getting ripped out.

https://lkml.kernel.org/r/20241025012304.2473312-3-shakeel.butt@linux.dev

So I wonder ... as a quick fix should we simply handle it like the code 
further down where we refuse PTE-mapped large folios completely?

"ignore such a partial THP and keep it in original memcg"

...

and simply skip this folio similarly? I mean, it's a corner case either way.

-- 
Cheers,

David / dhildenb


