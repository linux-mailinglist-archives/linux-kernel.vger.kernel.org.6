Return-Path: <linux-kernel+bounces-171208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673048BE13F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F041C21A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD71591E0;
	Tue,  7 May 2024 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvP8F+JB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18B152E17
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082060; cv=none; b=S0zUMbsnElYXIxBlOvmPK3C0Qjl/SmGboX+izeb7ngMOEmiPCDMd6yLrfqrefCGXHCkEGGNlXqRvLv9TBbz6GXURxe+ZEedfCxkbMIz3PC336DL8Wcf7uPF364YlerGmRuuygkmlCXii9ehCkW4UqBulqSANPBLmsLnhb/jSaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082060; c=relaxed/simple;
	bh=IAaOaBe9HKl/3bBlkSAJiMu+9MBbtwV4jSprGToYaOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKu69PoQd0pFBc+GGNtHE9oQLTp3+bZ0erG6iwWcg6gi5Fq8/R8REP9OodDjFasLwZGU/gEA/+URvHjUm2X5Usm5rey2SmPGPHqBATMRNS0cLHo9sAiLqtovS+ltTlS7DF3R6/jOxLU+/2csItVdMPHek6UDtKQn9cCBhBS0WrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvP8F+JB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715082057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wPrd6Q/4h/14dxOUmXqg/1waGBKdKBBCP/xB+C/HFi8=;
	b=PvP8F+JBn/OUBX9+wFq/V+vAvsGWR9nnGg/zJfUFN/+naFRCP8lK60AsRDW6qPVWeIEDyC
	7+MZ56RE/uENs8JCOLIJ979sd+2udsxE8V9jhmAlo+zeNAoQNMLaIP1EHYF27hr3FLnloh
	Si1F286wGgJ8zlsOecYmH8mBufw3R1E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-UckAUssVO8WtvHK-EObXNQ-1; Tue, 07 May 2024 07:40:56 -0400
X-MC-Unique: UckAUssVO8WtvHK-EObXNQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51fa9758a71so2711661e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082055; x=1715686855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wPrd6Q/4h/14dxOUmXqg/1waGBKdKBBCP/xB+C/HFi8=;
        b=UsvwUlGzXMj1wFw1fISqOW0fCQdcMtViep4f6aDX4EYnT4wgy3tpqVjuLkaMdTMXVj
         vPcXLizHe4cQo4QtNV6YwnAwvJYStsD7qHf5fRyRv7TbNwnDtQ+y8wAFKwhAQG90AwkE
         lKj4ORhgYrrtVP025H4ru6zrWsHZeVI9Lr/YO1q/qzQ17fqKIlVbLe61P8il1KFXi2tA
         meVTwWKFYq9a1/wEecR4fcD70Up3v3REgb3RAgMytf8Lrt7b512Ni+24zl47N+bqbQEO
         2cVEPhhFDCaf60w83CtFR0wjCsZo6vJkYjfPgHEh+lXj/5xJ27ovUJiHUQd1lHIphJMr
         toDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfH4oEjlO1ON7JydZnEZWTQ42JlHt21mgf0PdBT56lgZiXizCIjUaqHuGpJCEIdY5islW/8heIBGcW6vCKUsUjs10qFmsiLw9P+wQ+
X-Gm-Message-State: AOJu0YyWDykwU3uJq6iBtj/7iitxYLBP2GktfROpoaP8NZ2d4fhcc7o0
	smrLoN5AV+16qhw6AhCFbIBwYAr4iOcL273Pc5u6epQksBHjYvWtsHNwoVZxTCcL5l/yzuAZVo9
	0wPuK+sB+wuGMeqg4mA93frZ37yxEPQ0xawFQM8gsONBd0BzGLsiM8RDLuUBJqA==
X-Received: by 2002:a05:6512:3108:b0:51d:4260:4bf8 with SMTP id n8-20020a056512310800b0051d42604bf8mr8629747lfb.35.1715082054720;
        Tue, 07 May 2024 04:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4hXSV5LqPLeIpWFEX4rkTKoBwuzoDnQsCGmR2OdZAQs/M5k2xY8xrSE4ntx++j7hWn170Hg==
X-Received: by 2002:a05:6512:3108:b0:51d:4260:4bf8 with SMTP id n8-20020a056512310800b0051d42604bf8mr8629728lfb.35.1715082054206;
        Tue, 07 May 2024 04:40:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id s8-20020adfecc8000000b0034dda041ccasm12814656wro.102.2024.05.07.04.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:40:53 -0700 (PDT)
Message-ID: <3f16a4e0-fb84-451b-ab80-f38c463d30d0@redhat.com>
Date: Tue, 7 May 2024 13:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64/mm: Remove PTE_PROT_NONE bit
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-3-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240503144604.151095-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 16:46, Ryan Roberts wrote:
> Currently the PTE_PRESENT_INVALID and PTE_PROT_NONE functionality
> explicitly occupy 2 bits in the PTE when PTE_VALID/PMD_SECT_VALID is
> clear. This has 2 significant consequences:
> 
>    - PTE_PROT_NONE consumes a precious SW PTE bit that could be used for
>      other things.
>    - The swap pte layout must reserve those same 2 bits and ensure they
>      are both always zero for a swap pte. It would be nice to reclaim at
>      least one of those bits.
> 
> But PTE_PRESENT_INVALID, which since the previous patch, applies
> uniformly to page/block descriptors at any level when PTE_VALID is
> clear, can already give us most of what PTE_PROT_NONE requires: If it is
> set, then the pte is still considered present; pte_present() returns
> true and all the fields in the pte follow the HW interpretation (e.g. SW
> can safely call pte_pfn(), etc). But crucially, the HW treats the pte as
> invalid and will fault if it hits.
> 
> So let's remove PTE_PROT_NONE entirely and instead represent PROT_NONE
> as a present but invalid pte (PTE_VALID=0, PTE_PRESENT_INVALID=1) with
> PTE_USER=0 and PTE_UXN=1. This is a unique combination that is not used
> anywhere else.
> 
> The net result is a clearer, simpler, more generic encoding scheme that
> applies uniformly to all levels. Additionally we free up a PTE SW bit
> and a swap pte bit (bit 58 in both cases).
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


