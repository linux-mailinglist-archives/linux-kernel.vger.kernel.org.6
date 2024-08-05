Return-Path: <linux-kernel+bounces-274811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DA947D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F06284FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED413C677;
	Mon,  5 Aug 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8tL3Umb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B70558A5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868991; cv=none; b=J65Xsy4EhrA0JxcgPK28Dc1Cg7dIdLD8ePGesn7dyAez59rQqy09Wl4nuSMBzNZmm6AQ86pJHykL3yGRNwXTKIvzEHoX2Vcl6Gx2G0GDWfDXB2MgrnRUlG59xCEeYZQpAtZJJajKKD/N8hTb9+fH62wDFZ2qNAiVNNV1wHynVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868991; c=relaxed/simple;
	bh=DWrBU5WUadldlfhlsWKw8XIYGDu7yL1/QeOAjTGUoQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkOO8z1jabfEWfIfOIyCLsM9N9SNGnbjYk6iEqCf+vEbie7519qXgKnypRpagHkXDjJMzZFEVReh8DmDY/gc77fIAUQyekaCspYgTdRYCqUHhmnSY9AORXvY6njTjcPert0J+e9rXmvlDbOrIZLjkCST9v7c2DLDNUVQhLjLmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8tL3Umb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722868989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6GuDOW3hJCpdyMUYToFB5B+sVH2wG3fmOeztI4TFPP4=;
	b=g8tL3UmbF14298h7byZgfuH6JvXmntmjy9podAwEb6T0iodOiaQ9FpJYaiWM4BNFkbxQnz
	5u4MwGX/EzS68nyw4Q6akI5UkgEOb6h7TJq+nGiLFGY9z9KoHL6zk38LFmwk1GYaWcpS/S
	3aHHzsKRWM3+ccJ/e7ZOnH6/X5Bm32Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-WEdiBYijMiuGWxwAthJwiA-1; Mon, 05 Aug 2024 10:43:07 -0400
X-MC-Unique: WEdiBYijMiuGWxwAthJwiA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3687eca5980so5122298f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 07:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868987; x=1723473787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6GuDOW3hJCpdyMUYToFB5B+sVH2wG3fmOeztI4TFPP4=;
        b=tbiQqZOPBKijqqob5BCN680yaVRuKsSVfINFHZDeROkSJtc98EoQP3s2TdM+0iNt1e
         4JcHNtO24MYJrHxQ7b3fEtVviatJU0n+GzXZialFX+2fAzpRK927F4ukZNi+8d4hKoYu
         4vTYxDdWm7ZOeNHCavO4K9OVpNsV0XgD8r8do5MU+qGLeKwVSh0kD+Ml31oZbVHM8uHJ
         yW8i2jM1wWRCOPHoEKngLXoOZ7urFXfup9qEqqYHfpawZFSTeGrDFx3DjAycWWWrKiQZ
         WsidGkEMio5VJaMcDWtHtJX2nti+EOVVfpnEy9CFcoI3YMYPdUxarFxlun2CeoR0SwNQ
         AAew==
X-Forwarded-Encrypted: i=1; AJvYcCWlykODc4RXnwbwvKFohDUUTW0S+gxIDx+XHmKSWupBkjLjPM8/dpusuynyy8bQtkl9nX4B9UW4TUiy6wSPKrZCDehmEnKdIdKoUJFN
X-Gm-Message-State: AOJu0YwAVb2mLId8gh3mmqZISsI1cWihoR7VxC5n6FKje5rvC+ovO7Uk
	JY3wzRp23YixBx1AIZTKSf2Rh7R1PrpeyHR/y3dlF9pC1z/qL1g2HzIRGRPpZpxX5BdcyJJgWtN
	5lMcRfx2o9YVrCGQGjbByRx5WC+adoFlxAfd9tJy2JEL9J6C/ub/zptKXKekdnA==
X-Received: by 2002:a5d:51c1:0:b0:367:89fd:1e06 with SMTP id ffacd0b85a97d-36bbc1312c6mr7963720f8f.36.1722868986830;
        Mon, 05 Aug 2024 07:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMkMedF4HmP2hN92FNl8AFdQusVzu9OVTEbZeVZDbyeEnLyeXA+g2eAI7Lt35kGbSyyQEfBw==
X-Received: by 2002:a5d:51c1:0:b0:367:89fd:1e06 with SMTP id ffacd0b85a97d-36bbc1312c6mr7963705f8f.36.1722868986415;
        Mon, 05 Aug 2024 07:43:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c309sm9981160f8f.20.2024.08.05.07.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:43:06 -0700 (PDT)
Message-ID: <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
Date: Mon, 5 Aug 2024 16:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, zokeefe@google.com,
 rientjes@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 14:55, Qi Zheng wrote:
> Make pte_offset_map_nolock() return pmdval so that we can recheck the
> *pmd once the lock is taken. This is a preparation for freeing empty
> PTE pages, no functional changes are expected.

Skimming the patches, only patch #4 updates one of the callsites 
(collapse_pte_mapped_thp).

Wouldn't we have to recheck if the PMD val changed in more cases after 
taking the PTL?

If not, would it make sense to have a separate function that returns the 
pmdval and we won't have to update each and every callsite?

-- 
Cheers,

David / dhildenb


