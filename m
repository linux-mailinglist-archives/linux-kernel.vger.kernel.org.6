Return-Path: <linux-kernel+bounces-280588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26A94CC7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79451C2167D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C018E055;
	Fri,  9 Aug 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SelXHZW1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A392712FB34
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192943; cv=none; b=KuxVEoD5ejUZJXBnqP/1OqcrxaH8wD76y8JCpmZQmzZtd12lqJT/hnJhE+DtJNTOj4LUXk2UqWB0fqZ3stvaI1TWmJ0jCoildW+40c9dezaqvOiPM+V08D6suH2cp16cKKBcbI/oBooXkGnzud9YKnObJjpdOGZZnsRvGZQXQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192943; c=relaxed/simple;
	bh=49eYlWF6N9al54DEvvTGtA00v5eUNmPl6WyZERMAOnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccLs1pwMIncb4lgbrS5syw5LhDMx7OE/NVezUjeodkssgyTK1PwGnr45j1CccOnsFxirKCwZM/ThtPRtjZ1Z+zrJEMIJzFBytqlgTY4YfxUarG2X0ZeDn8fhX271ufKPf0NwQ6VOv+/n2uT8++QouYATj3Pn5HW9hdv3vF4Re0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SelXHZW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723192940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o8dU1j47wBaVmdxtmpM/u5bzIOpmMPMBAHatYBFq7dI=;
	b=SelXHZW13LB0VqwWUuLm3k7w1zoZHuN1n8rU1Q9r40a1ra7QXXCiXXOiH918OnMwwcBdmO
	m0UtWzSIZuak8D1exv4aMZtGKtGDjvaqgPy48UrcmSAd5wpwkVSLt3th+IGdul6eYmgW2L
	cf4RQtLx1+ndezGPpQFbUzfLtX9FtVc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-NhceZoRLNwaIAk77_KzIJA-1; Fri, 09 Aug 2024 04:42:17 -0400
X-MC-Unique: NhceZoRLNwaIAk77_KzIJA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef2d0509a2so16249731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192935; x=1723797735;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o8dU1j47wBaVmdxtmpM/u5bzIOpmMPMBAHatYBFq7dI=;
        b=s/ABdm7i/FfRasIsZv4jZdKWcda2Zgid2IqYDzue11cCpHG96BHHpwaD6V0NiXGwHq
         i4cIkitFD7K3+ZTpoOD078/w4HSAmozzefnokEAJAvD6RQjiztyV/HQsRdskC1nU+1r7
         hXMhId6vAzZXpeOqeQIsO9ypZm/mpSxs+endIkqkuIUaLQkWgK/GHg8bs8kzdjRzqSia
         Z+kafDrw7ftWOJny8pfY+qB+U8yYIFDv3GGWkv7UUlY0wtQ+36ap2zEuxx/GxkqYCavS
         CdYToU1Op8F9yq27tT77XMmqLBrjpA2Af6h9ugh8z2Cp6I6XJsEywZ8OuaoTCgFsLOK7
         ldRw==
X-Forwarded-Encrypted: i=1; AJvYcCXUt/dOTDyPUX7IoX5CYk0JyEbCfAai1dRI6A3hWnQbn+RKuqLUIuGI7OlxrtFL2vtQpW/bBg1mYnFifq+rSsB/LZhM4zaARpe1VD20
X-Gm-Message-State: AOJu0Yzn87X8gvx5VXQeHWV8OwjpXpiIzqRtDbDqatwsGpTFIEZlKOWG
	Dv5OiTvK5rBexXM03LkFJ1jxUoGLRvazb7Tcblc9Ad08GDxDYuQDwqlkgfK4TdBYLSWlpZ5wdi7
	NewZkLA7Fz4+J7g2Ay9bS1+48nAXtAZKMRktzF0LD43McPNPUK+SShjooPp0EFg==
X-Received: by 2002:a05:651c:1545:b0:2ef:320e:cbe9 with SMTP id 38308e7fff4ca-2f1a6c448b6mr7791621fa.9.1723192935581;
        Fri, 09 Aug 2024 01:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHADDLJUcNHwS9K94NJcMbXjpltKdjNfjQU7CmelDNKKozWmbTsmV3/91z6D/zixvZFwCz4wQ==
X-Received: by 2002:a05:651c:1545:b0:2ef:320e:cbe9 with SMTP id 38308e7fff4ca-2f1a6c448b6mr7791381fa.9.1723192935028;
        Fri, 09 Aug 2024 01:42:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290597199fsm118698135e9.14.2024.08.09.01.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 01:42:14 -0700 (PDT)
Message-ID: <4465afdc-23e9-4844-a0a0-519f49b1229c@redhat.com>
Date: Fri, 9 Aug 2024 10:42:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
 <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com>
 <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Not sure I fully understand why David prefers to do the unaccounting at
>> free-time though? It feels unbalanced to me to increment when first mapped but
>> decrement when freed. Surely its safer to either use alloc/free or use first
>> map/last map?
>>
>> If using alloc/free isn't there a THP constructor/destructor that prepares the
>> deferred list? (My memory may be failing me). Could we use that?
> 
> Additionally, if we wanted to extend (eventually) to track the number of shmem
> and file mthps in additional counters, could we also account using similar folio
> free-time hooks? If not, it might be an argument to account in rmap_unmap to be
> consistent for all?

Again, see NR_FILE_THPS handling. No rmap over-complication please.

-- 
Cheers,

David / dhildenb


