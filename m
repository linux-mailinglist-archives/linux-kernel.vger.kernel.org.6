Return-Path: <linux-kernel+bounces-187904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A08CDA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F571C2190D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AC823AF;
	Thu, 23 May 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk8ffNGs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3D42067
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491010; cv=none; b=qtJRz/wjPX1iZ9MpyMx1323khWqiHjPD9XHf2We1JSuYNZ0BtVxR6drfWd3diRZ+H6Qf6lagRqp6NFnIC6pU2Vs1wdm41szI8qwv3n1ugonoqE4YY8tCAyF7R5p/u6plq0u1wnI8hwNx1CqrY8Cwo7Lc3gV6VsVGe02fJ0vLsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491010; c=relaxed/simple;
	bh=D7okfcf2Ddj2mb6Zb05qyS285Q6O1rqPiXyMi5sYT7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbwEouQ0jAIzoTiDLJdcjwvY5CtnmQSf2zICDxObzrHmI+V687q1VyFBdSE5qqaqA4AROhvmhXLWYeaTCSurUvcer2QWsdC9XehNRUQEgL06TNIyqz3IizZk7gTyjLQV4lOV4UGi58FwZfsz5bhqBNcycpHlfrCPy/l9YaclX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk8ffNGs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716491007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZyHfRr2WLwSMfqWip/ip78bXFGU0WQWzWewHOWuVSkk=;
	b=fk8ffNGsk1ernHgreCyJCL9dbuKRsGkmC/4V7cJAKswchS+2AHuOzSmjQ8zrKIfJwvg+YJ
	jYLPuy7NU3gM8NiAFGtqIjuZvsf1G47Y/BKrpyA12Jareh5AbsUILOmp34WOD0caR2yKaN
	imoS5bVJcZM+RMtJRh3mqUXxIr52MVU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-OeXDaYNvPdCKe62adU5sww-1; Thu, 23 May 2024 15:03:26 -0400
X-MC-Unique: OeXDaYNvPdCKe62adU5sww-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4200efb9ac6so79984685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491005; x=1717095805;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZyHfRr2WLwSMfqWip/ip78bXFGU0WQWzWewHOWuVSkk=;
        b=sMFSfySSNxlAqP5nvACuiXO6s/SxZOMVmiiSob3ebrKYCThPYek8zznjvZP4TYJ7/S
         dhEepxfE+nJ+t2MaWrappK8x96V8eCbJUn6k3e9z3MemX6NX/80XFRCT4KBOe7qAeAMv
         eZLj4fPGQ4IXtH1lLMMYS72qTMGCE43q23luWR0RS8AQnMRVLNLWZ6fcr/rB39TOBRED
         Ef7Wc+V8vJJ5bmk4/gYtjB+sv4hb1kAbyBEjqtwFeSyDgSwifs4uzQwvlf/pEGVSF3pa
         k8VWdT9dwa6wdQTh1PocIFXzpnMv2GJ9xhpcToPNXyyf+nOg6vr/QpDMrzbDbWawOqmE
         UIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/bZ+ftMvQy0+/ACXyNJLiCS3X3H1sWIP98kDW8vzTvfpcLQ4m9kYtsrJWYBebcBQZ0tkcUoUuJQgqVcB9RWbsaiMLWpKyFZS4qo7
X-Gm-Message-State: AOJu0YyliCQmu27jjTPG0pvLcaWKKYUwUkqZZ/KLI6YOtkH/k9rvDsbJ
	B4sTH7X7T/o8AQew+2jlo15NEA4ng/0kFSW1+elIZvKhzJvo5M86O4DjUUIdntrsw2GfTQMTyY2
	zE5Uypon8B+JkrL0wQoJBSH7HSEPQRjPl18Xqiz0Elqg+St/Y8A3FBFJGgGJgrg==
X-Received: by 2002:a7b:c3d2:0:b0:41c:97e:2100 with SMTP id 5b1f17b1804b1-420fd2f2376mr44870415e9.3.1716491004919;
        Thu, 23 May 2024 12:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbDufpJvfBHRHt6fz6S/dC4VYfEhS3gzHvWBUY5Wx5sWqN/iYfT1BI+OirfoRtv5LzKedxpg==
X-Received: by 2002:a7b:c3d2:0:b0:41c:97e:2100 with SMTP id 5b1f17b1804b1-420fd2f2376mr44870205e9.3.1716491004427;
        Thu, 23 May 2024 12:03:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:5f00:c949:6700:cce1:e60b? (p200300cbc7175f00c9496700cce1e60b.dip0.t-ipconnect.de. [2003:cb:c717:5f00:c949:6700:cce1:e60b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fb0905sm32266375e9.41.2024.05.23.12.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:03:24 -0700 (PDT)
Message-ID: <cd609361-bf39-45c6-a01f-f88362a15847@redhat.com>
Date: Thu, 23 May 2024 21:03:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Gavin Shan <gshan@redhat.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20240523132139.289719-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240523132139.289719-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 15:21, Peter Xu wrote:
> Macro RANDOM_ORVALUE was used to make sure the pgtable entry will be
> populated with !none data in clear tests.
> 
> The RANDOM_ORVALUE tried to cover mostly all the bits in a pgtable entry,
> even if there's no discussion on whether all the bits will be vaild.  Both
> S390 and PPC64 have their own masks to avoid touching some bits.  Now it's
> the turn for x86_64.
> 
> The issue is there's a recent report from Mikhail Gavrilov showing that
> this can cause a warning with the newly added pte set check in commit
> 8430557fc5 on writable v.s. userfaultfd-wp bit, even though the check
> itself was valid, the random pte is not.  We can choose to mask more bits
> out.
> 
> However the need to have such random bits setup is questionable, as now
> it's already guaranteed to be true on below:
> 
>    - For pte level, the pgtable entry will be installed with value from
>      pfn_pte(), where pfn points to a valid page.  Hence the pte will be
>      !none already if populated with pfn_pte().
> 
>    - For upper-than-pte level, the pgtable entry should contain a directory
>      entry always, which is also !none.
> 
> All the cases look like good enough to test a pxx_clear() helper.  Instead
> of extending the bitmask, drop the "set random bits" trick completely.  Add
> some warning guards to make sure the entries will be !none before clear().
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/r/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


