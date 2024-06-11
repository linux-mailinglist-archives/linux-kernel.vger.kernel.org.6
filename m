Return-Path: <linux-kernel+bounces-210193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13AC9040A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474F9285EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010839FD4;
	Tue, 11 Jun 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuxZ7kEC"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8E39856
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121556; cv=none; b=W3dCLUAqhOSaUydiQIff0T5JfteUvfHfoF+V9pQ0ZcmEpvP9kpAW3mydNII92XydPVkA9mLGoi4VOvVm7x+kyWkgbV0PQb+xCGIbEmJNVextoBu3jHWHOJfvGjsZIseT8VWZHUrzLd4Ep34V/K3kukTY8onIl5K8OL4p2iQ14QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121556; c=relaxed/simple;
	bh=gw9dRo2SVL+ByM3h6BkWNrij539U3DdTpUNCwlU6ziM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxR0gLKaqGBqZ8eTUFBDZSSOdnIFAt08cozH+Eo3xCUdDdRCLGw+gmO9Vc0m/i8eoe/yiOmv5re6Y9V7jrkAYLPeVSNW+vWAftOIqtBYlvfy3UTtHBB6DEPpfy888zd/1E2fl8frcLq2I3jngSVu4jjM8GMfbUXrm4B3cKuK4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuxZ7kEC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a63359aaaa6so836389966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718121553; x=1718726353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rnw1FQKN289UDS4/w5kh1z+KMtll11fpDUmcXvCr+s=;
        b=TuxZ7kECTxtSdAgcQfutORG+6GUQpq7dMd4QysPRwwtEJzRJOXKJ2YdTet4b37H7mQ
         zDavDFsKfW7JNwdA6vNr1kTyYZ36OkmPTEMMrlWXIe7Wq1UZdCBiCZw0hAhqb2FHWOVd
         uTJ8saUIMMCwyTvE8xD8ih0yRagqmABWuOG3XwKKbfVHkGvILS9ElnLBBzmcmBwjYbpP
         vxX+H6OgdSWH8aeWQWiS2Iz88+jk5spmLLD1Bsot+tqPtljxkX8+F0LX66ZLC/XhEZ6+
         +gpdzRz8l3dtOWi1PL06yvsNE8/BYQkZ3q9nxRT9WStHDPFphk3wWtqLg1+2eDBID5ez
         F/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121553; x=1718726353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rnw1FQKN289UDS4/w5kh1z+KMtll11fpDUmcXvCr+s=;
        b=CsNVRWpCoI9jGU+RjNGQjKEvoTxu87JPSM7AXei9UmHozcF3IaRiT80/cCk879ceke
         KGIC/eYU9lkkBV1OxqNpwT56Ny3XbegD4QuGZSLt4ZYidqS6XEX6J+kCZKJxyxdYeEnJ
         xnU56rN+LUdlW9Q9XGBNu4AB/g+XCGTOg4NODj67ArFUfXJI2T/eF1O3ybyttRnBz6Uc
         E1RDza0yJ+cqEvnvhaswYr8SrWPzN9K/v64T0FRBSnBmst8oT41SqzWpF7YJYL0MR3JF
         nF6PZnFZBYShP73AltQpiVDrlYnVDjAK56RKD+Z+9mGxAtzvpTSR6l2PzFPc5C/NG/Cm
         Z47A==
X-Forwarded-Encrypted: i=1; AJvYcCVTDo2mT0YKiux8zjEefjNrQW1BF2id2DFvq7HNmIESz1rtJzz6cBC6lBUL3JBcwIwnM9bRTycGxxZQFx4an7VpIvidsl1sDN5iilLV
X-Gm-Message-State: AOJu0YxTlT9+EwWSXz16XYvwu7nI3m0C8+L1w7OOL+EVZFANV/aBExuN
	A4sX5JVliePbIuE2hn0t+HCcDwnMNoCI2lNZj9pqdAIKtA970XnW
X-Google-Smtp-Source: AGHT+IHjS1MZMWIZVi7cvT2T/22zRVp9zjGEaMix5oaKL59nfhtDU6VerkK9JUfuY/0DOicCbpydlw==
X-Received: by 2002:a17:906:155b:b0:a6f:2a7c:b511 with SMTP id a640c23a62f3a-a6f2a7cb5cbmr257590466b.51.1718121552767;
        Tue, 11 Jun 2024 08:59:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:57b4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1244180bsm382816266b.116.2024.06.11.08.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:59:12 -0700 (PDT)
Message-ID: <227d931f-18b8-48d5-8306-64940fcf1425@gmail.com>
Date: Tue, 11 Jun 2024 16:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Chengming Zhou <chengming.zhou@linux.dev>, akpm@linux-foundation.org
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com,
 nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Shakeel Butt <shakeel.butt@linux.dev>
References: <20240610143037.812955-1-usamaarif642@gmail.com>
 <5d051998-015c-4da4-83f0-1b4fb9009c68@linux.dev>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <5d051998-015c-4da4-83f0-1b4fb9009c68@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/06/2024 10:53, Chengming Zhou wrote:
> On 2024/6/10 22:30, Usama Arif wrote:
>> start/end writeback combination incorrectly increments NR_WRITTEN
>> counter, eventhough the pages aren't written to disk. Pages successfully
>> stored in zswap should just unlock folio and return from writepage.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Looks good to me, thanks.
>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>


Fororgot to add:

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>
>> ---
>>   mm/page_io.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index a360857cf75d..501784d79977 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>   		return ret;
>>   	}
>>   	if (zswap_store(folio)) {
>> -		folio_start_writeback(folio);
>>   		folio_unlock(folio);
>> -		folio_end_writeback(folio);
>>   		return 0;
>>   	}
>>   	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {

