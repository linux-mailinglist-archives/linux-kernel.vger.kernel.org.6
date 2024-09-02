Return-Path: <linux-kernel+bounces-310897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3A968297
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5D02843EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17144187335;
	Mon,  2 Sep 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0nysi5n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7717F4F2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267621; cv=none; b=PzZ6OIqaIHVQk76S0Q8UufBZtLwaZTvgTi5b0OSI3Sg1vnMmouOV2LMQ6urDwrSVAnlLit/o6xQ0dL7g+uDeLu4YoR1zpTMII9ZbyOof9RmaCPIdMBYz7pv+7qhG/6Ct8ItXSLvgGpDemtGQ/63Z+Rt4G1oP+JpxY3cYReDZtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267621; c=relaxed/simple;
	bh=bTSO+21iJR7+UK2+/jNQfRkrM04qpj8CHb/bk6uGtEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igao2v7RnSB15TBrqN4qT2rIu/YvDWX/Mzox23BTSuFcUUUtlBXds7dvRuKgUVc3JaWg4wU9thQTueBR6xkeuua7qh42i4TZJasxGFafi6q0lpitafQ1wSCv/5vnG8hs97HXp5ruwFmCjIDew4gV6TaYWEl4GbTZNu5eFLvYZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0nysi5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725267618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cy1gHndhF472qa4vFtdvjwY//tpLnp3sCwL0IYVT2ZA=;
	b=h0nysi5nIdgC6vGeDU/tWz6TQPGfYYDjWeeoGTi2rKPB2ORb6zOycuBiqrPo93hcTL2dKn
	9ljiBpifnZ1irDakSdU7soPZWkYMgKcp5znduuIjlOG9Z+y4BLUR9IMLXyF8wbGJQOmYDo
	9C2ox8sUY2gb5O4LYHz410w3/N9FlP0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7ukHZwesOuqoBrhsQetCTA-1; Mon, 02 Sep 2024 05:00:17 -0400
X-MC-Unique: 7ukHZwesOuqoBrhsQetCTA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374bacd5cccso1625695f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267616; x=1725872416;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cy1gHndhF472qa4vFtdvjwY//tpLnp3sCwL0IYVT2ZA=;
        b=V1x5id4zxcH3MmtPvh8JjNoqwGatIfiCH0DAqZM3fNUdewJDYWnjw2elL8xjHpb5tE
         s/ObkvfKPiSFv8uiKb3Cj/wj/3N9FOykVcQ7sB2SrOa67BtX7dGIvUty5Hg/xFubl+Fs
         vwMc6P1cGYcwDEZYZoToZQwwsLc8U4IU4FWsNbx7y4LH/MxekXB76ddDADkpveCNY1eT
         zxMFa+XCXDGk6jmBsMVzDNuf2iu0F2GmNh5NcqmGX97yuz5KnD2tTbWhQH3lZBpyemfJ
         n90iHeZ8L5qtlRnSPqWKlEGFu1x51UELTTddJH+uPCBfuGFUk3wTaCEFiVEca8UuWtMO
         hrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs7ESuefhaLlTOvh9oB6agolxqDvkXZ5vO0LidyfAlvaDCALWgCIvJ46w4drgqlXXOc1F4TA20Aicjcls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLlvdNn7vxJjfibcIeHlZhZtcugxX6XNeemlQVWC1poHNnyw/
	H3PkuzvWhQi82tuAnZ9xLiyGlBaFfSPI5wgpEjYq1U4NbyP8l+6aD5gl20Grs91XM2WvPSLnVDM
	Pt9dv6Z3YczuOFHDUIqzQ+TLRG64G4jVdvIqs+TxC+9kf2V0ZdOWnVriRuPUWBw==
X-Received: by 2002:a5d:4d90:0:b0:374:ca92:5e44 with SMTP id ffacd0b85a97d-374ca92604dmr1515240f8f.32.1725267616456;
        Mon, 02 Sep 2024 02:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ6qOSxy2r87iGu9U8KwWuh4uQnOj2DQ/5pLilG/GBonGCO+41xAIdCmq1ro6SoP6CbpziZg==
X-Received: by 2002:a5d:4d90:0:b0:374:ca92:5e44 with SMTP id ffacd0b85a97d-374ca92604dmr1515205f8f.32.1725267615600;
        Mon, 02 Sep 2024 02:00:15 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c0f6f4c4sm5534191f8f.44.2024.09.02.02.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:00:15 -0700 (PDT)
Message-ID: <e4ed13f0-5a69-4624-9fea-20f980ff14be@redhat.com>
Date: Mon, 2 Sep 2024 11:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] mm/page_isolation: remove migratetype from
 undo_isolate_page_range()
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-4-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240828202240.2809740-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.24 22:22, Zi Yan wrote:
> Since migratetype is no longer overwritten during pageblock isolation,
> undoing pageblock isolation no longer needs which migratetype to restore.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Yes, that's the right way of doing it.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


