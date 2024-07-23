Return-Path: <linux-kernel+bounces-259880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633F939EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A7C1C22040
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212414EC44;
	Tue, 23 Jul 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhJFhM/y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946314BF98
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729692; cv=none; b=sETpIp9hGkNAzmJQ62jqcggB3NilK8D19/om3eAfXIciP2E3SrxpZoJVhPs9+v0w3nxnIROhDe2YlFlM5TXvrLQV0BuTgl+y2ShYywVaUGo33qv2zXllXkgun0jPG72FZ3BEpXTwtLyJc1jntD8RuXoxeBaE53RYXFpHoIuSHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729692; c=relaxed/simple;
	bh=o1PBCFurvor02xw1Jr9yFx4YhULShAR9tXsLCZPFcVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFAiJ9BxP3SlhGQ6bb7gS6ghWhIJ/ehvDnT+s8hxWqnx6jvbOEBz0Jz1oIp2Cm2bqZ6VQL3jEzJc2bvMDCITWesepCIKyOYEBz54ozZGkNUXOfaVALYgRrNTaLceDd6aT9mp048uh7h/U8YBBX2jGZDktHhwJZP06u7KUY9tegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhJFhM/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721729689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XlFxZ+XlkpR4+j6b6lDCxwV3tYEU5UHjvLxc8Lst/vo=;
	b=dhJFhM/yWJbVgMBYuSk8Ln7xMaPLf+BNYphFrpAwUKSPn8XKqLrPVXxofEV9bgDl71VIbJ
	RHgEpgXIGulzhYFwpb9u/PqA+jrGXwOAo3awdJPkr6BrIS8m0oz53Ip684IXe1KXOn07VR
	l2seIlKaxqzeMGozji3uIARJTwMWI50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-i-aMQbnLMNqBQ-siiCJK6g-1; Tue, 23 Jul 2024 06:14:48 -0400
X-MC-Unique: i-aMQbnLMNqBQ-siiCJK6g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265464ddc9so23773655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729687; x=1722334487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XlFxZ+XlkpR4+j6b6lDCxwV3tYEU5UHjvLxc8Lst/vo=;
        b=ZAlSJ+Z6ubwjcrE2zRcJIUO8nSa/O3SUaTHu4aqOKyguty9uwlCadtLovhfmuhgebu
         xb/hEO6BKk7fGzdaf7Vv1Ma1D2qO+/jw0ymichjKNifBpFmoeBQXOIjG02HTL7Io7+FI
         ClSCxa3wVicLbHbzj/UTUCzQANzoYkT2cFyy6r6r3aHl/soRGffwlF+phlMHPous1eyO
         f6OFy8Emc7z7OnECBgaChWaMmf/xYo+mU0pfCizyvPpASdqH2FLk4/UIOhcc3ntp+gdA
         p8m4cKvgNPtlbjwRYyU13+fasaIxKPLFLPHpIMBNJs3WvJ4VPcbR5V1TMjfCy+p/s/Jy
         MNuw==
X-Forwarded-Encrypted: i=1; AJvYcCUBPgRhiH4jA3jTYdgpYLhxbM4y2f7YW+khPE9HhwNFGHQ3KoF87T013VBTfn2q8MunPQvzR4CyMOOk+L+QY/a2ukra4Uy8VhBfgnxu
X-Gm-Message-State: AOJu0Yx0bDQu3LXRrFivCKXufujBgpTgZ7QO4GpoM8ne1sAbQHCo7sgh
	LqSTiNalnmJ/xsO0/5K0kzFOxwM6s82H6ekFH8kRrjxDr/3esnGQOjnDyj+L9oSwDJJu/wiIyco
	vzyNXtNfOI9QPPFyDixNucMtE3MPWCSrlPCb0PFKTiOgD1CWz0b1/HurndCqEsA==
X-Received: by 2002:a05:600c:3583:b0:427:abfd:4432 with SMTP id 5b1f17b1804b1-427ef3a885emr11669875e9.12.1721729687158;
        Tue, 23 Jul 2024 03:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHoBse6L8kdIBGmNij8ozd1MUp8F0t6d3W6q/68QdWE15CCDvEAXBZx3wnDH0cQAASoS0VLA==
X-Received: by 2002:a05:600c:3583:b0:427:abfd:4432 with SMTP id 5b1f17b1804b1-427ef3a885emr11669755e9.12.1721729686762;
        Tue, 23 Jul 2024 03:14:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:ed00:9dc2:1adb:d133:4434? (p200300cbc72fed009dc21adbd1334434.dip0.t-ipconnect.de. [2003:cb:c72f:ed00:9dc2:1adb:d133:4434])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa0a6sm167944555e9.9.2024.07.23.03.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:14:45 -0700 (PDT)
Message-ID: <3d9ea6fd-03f4-4fd5-8407-2201e8ba5010@redhat.com>
Date: Tue, 23 Jul 2024 12:14:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] memory tiering: introduce folio_has_cpupid() check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-2-ziy@nvidia.com>
 <6effd690-3cf2-46bc-8061-2d19922ad4fa@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6effd690-3cf2-46bc-8061-2d19922ad4fa@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> The static version of folio_has_cpupid() is defined in include/linux/mm.h
> if !CONFIG_NUMA_BALANCING but you define the function in memory-tiers.c
> unconditionally, a file that is compiled predicated on CONFIG_NUMA.
> 
> So a config with !CONFIG_NUMA_BALANCING but CONFIG_NUMA set results in a
> compilation error (I just hit it this morning in mm-unstable).
> 
> A minimal fix for this is to wrap the declaration in:
> 
> #ifdef CONFIG_NUMA_BALANCING
> ...
> #endif
> 
> I've tried this locally and it resolves the issue.

Agreed, with that

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


