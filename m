Return-Path: <linux-kernel+bounces-276386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C4E9492E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2BCB24BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2918D642;
	Tue,  6 Aug 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo4xQR22"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3E18D622
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953793; cv=none; b=rcR9Nbo9/5Xn2bd0fGvJRqOBgn0me9iOPq8OxF08fmrJE4MRceliDTQu1n3vr/ZId053tTkgdxxyws0zPpqggLANyV2D9fSBpYRI2npSG6sa7rwqQhdTX+7BvaLJbNfqfI3kvn6Gio1y+0DaEPFi2C3EhnOf2p06fY1SEltn56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953793; c=relaxed/simple;
	bh=sfn0+vkDnNLNkFjFhXUin9gjSPXHMMKZHGgEAs41UPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4PwHxnv/03vIs9b+SoCpRUrUXBdz8MZuKp5wh9N6DujBzUQliNRMgm0t4UmGONIIGyZh9ZylTSLAVAw8+9DfcYRVcB+Jamj2qvEnGnIOHO+2jdb28Qk6YMSimxwb9PUi0HrLTiIBuhEpO+Kh3HNyoXYUm+lVIvaVCZVeTLH7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eo4xQR22; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722953791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EL7Ofxdhacc3yjRzeB5Gmd4P1G6h3EEZVZ8SyN2fMcQ=;
	b=eo4xQR223bhRnmU/cpZdsi4xGjOoC6WxIqTRX4uZpbve8gWqp2ovMTQhz4pMgsmsjaI11J
	kjBkqmDJ9LqI+e+VOaWw85/x5vINrUP/4xrSSMneLaxCeyhTdnV695xFDBYqEBo9K7dLt1
	W3koYDJstGub8EEwJO4XM9l936y1DkQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-tyzbBMRjOtuFN8QZHModoA-1; Tue, 06 Aug 2024 10:16:29 -0400
X-MC-Unique: tyzbBMRjOtuFN8QZHModoA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42816aacabcso5734035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722953788; x=1723558588;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EL7Ofxdhacc3yjRzeB5Gmd4P1G6h3EEZVZ8SyN2fMcQ=;
        b=gTRWd8i6Qr5F2VNYR7Y7eebzebORa8D/gr+JtOZulQKH3DlJuOAAPz4aetCGJLB1jn
         5X2fMeGAFivlxMHtBQ6Arg4RDZQQPYW3uNGcsf34+NUKGj1saBd/qX2Dss5yxSzj6hl6
         VI5Gd78kwpllfQsU5WQ6OM57g9ukz9Nve5uYH1xcbYdUD2OZ0KxaltnJcSmBw/qhVbMk
         XX+v5/cvGVs5+rLBd73c6zNzXLat8MzOmreOxuYj91ePaOQmEq6cJPsw32RUTb19zmeU
         K5uy8EguWVtobGMgi3AWXYNk8edFVDmRMM+XwbG5n5R9F40JxOhdDWrltkF+ObXZAVif
         RiZA==
X-Forwarded-Encrypted: i=1; AJvYcCXQWhQILacLW3uwPGyj20wboXweiat5t4wny48hZJSwjjNQwu2aANCurGIt5KRyrtjnGS7ZmbLVRII+0XUzf3J80VoXk7TWuFA58a50
X-Gm-Message-State: AOJu0Yy1gYXSckvA4rN7dWvbTsRIbqNTMwXxtUyQRL3sdEMbGxs7rdE9
	0ZQbkL9lbTsFCrack8cELyPpoY93Ylsn+HeihD/yq9a0EGGg9IrK+DjM6/aLmqt2PWqX4L8qbpF
	gI8B2nNZrJIL+Yh2FbfQTKz2fWWR/295RgUm3gMoN0Ho0yJD9oqOTZ6PbcgjZVg==
X-Received: by 2002:a05:600c:1d04:b0:426:6353:4b7c with SMTP id 5b1f17b1804b1-428e6ae0069mr118942445e9.8.1722953788406;
        Tue, 06 Aug 2024 07:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqTx7PAz6Acw1Yq5ieSbKK6vlOgx2h02D2oDDcZE7Z/tqUE7MQX6MKogzdPNlrJjm9+Kv7xg==
X-Received: by 2002:a05:600c:1d04:b0:426:6353:4b7c with SMTP id 5b1f17b1804b1-428e6ae0069mr118942215e9.8.1722953787808;
        Tue, 06 Aug 2024 07:16:27 -0700 (PDT)
Received: from [192.168.3.141] (p4ff234d2.dip0.t-ipconnect.de. [79.242.52.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6405csm245769275e9.34.2024.08.06.07.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:16:27 -0700 (PDT)
Message-ID: <0f467510-a0d0-4a98-8517-43813fa4c131@redhat.com>
Date: Tue, 6 Aug 2024 16:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
 <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
 <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 04:40, Qi Zheng wrote:
> Hi David,
> 
> On 2024/8/5 22:43, David Hildenbrand wrote:
>> On 05.08.24 14:55, Qi Zheng wrote:
>>> Make pte_offset_map_nolock() return pmdval so that we can recheck the
>>> *pmd once the lock is taken. This is a preparation for freeing empty
>>> PTE pages, no functional changes are expected.
>>
>> Skimming the patches, only patch #4 updates one of the callsites
>> (collapse_pte_mapped_thp).
> 
> In addition, retract_page_tables() and reclaim_pgtables_pmd_entry()
> also used the pmdval returned by pte_offset_map_nolock().

Right, and I am questioning if only touching these two is sufficient, 
and how we can make it clearer when someone actually has to recheck the PMD.

> 
>>
>> Wouldn't we have to recheck if the PMD val changed in more cases after
>> taking the PTL?
>>
>> If not, would it make sense to have a separate function that returns the
>> pmdval and we won't have to update each and every callsite?
> 
> pte_offset_map_nolock() had already obtained the pmdval previously, just
> hadn't returned it. And updating those callsite is simple, so I think
> there may not be a need to add a separate function.

Let me ask this way: why is retract_page_tables() and 
reclaim_pgtables_pmd_entry() different to the other ones, and how would 
someone using pte_offset_map_nolock() know what's to do here?

IIUC, we must check the PMDVAL after taking the PTL in case

(a) we want to modify the page table to turn pte_none() entries to
     !pte_none(). Because it could be that the page table was removed and
     now is all pte_none()

(b) we want to remove the page table ourselves and want to check if it
     has already been removed.

Is that it?

So my thinking is if another function variant can make that clearer.

-- 
Cheers,

David / dhildenb


