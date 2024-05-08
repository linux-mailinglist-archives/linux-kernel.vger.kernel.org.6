Return-Path: <linux-kernel+bounces-173217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B548BFD2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277961C21DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC284347B6;
	Wed,  8 May 2024 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkffZYNJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB617D2
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171579; cv=none; b=FnrzJmDF9jT4Fbnbr85SX1EnkaebHq8uPNEfhcyx/O+rO7Eogg+9i9ZwK5Dgod2StkQnJETt0KzzB00eubNHUXXEHOkb4XGaCAZ48YF3vCvYNXgKr6k22QXqTZpkEXuVU+vWe64s3nq6uOAmBqxyEh2A39ucflg0YgETjt/VVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171579; c=relaxed/simple;
	bh=tuOTw0H0KxEwzAhq1txOo34vzGHOT4+dUgjGYtrlYaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey1RkJKpmiDDv1sNPavbB8BDs9Pe1q0CNWIkUdT7Wdl2eQRU2heGvasW8bpkMkVZxlkvyiWk06Gge12os9gDBj78BYCAdPSQ4YIDwJP9zgSnStyFmaBge3s2/iDDLqyN5Vl8sY/HbHYtznFo6UvKUOYIOBE/oHzK0s8E+349/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkffZYNJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715171576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NyEKmq7S0/dWXFUpRGdfaeCSpwrySCliso/AaofHKNc=;
	b=YkffZYNJ4Jips/mZRPWJXtpIUhWf2A6VXQ8BkOfFQKeCkgpd4HV2E6nJDttYgEtBAlzwce
	XX0tNasFrxUAyBDICXEOoO1Oh0F9knF20VruWEIXqhq0PMfzyQv3ZGX4MSfnvT4NBllBgo
	jUV2TCqOnjxdsPkppE6LJdC/okYmPzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-uPbjxSgPPmSQHvvklyozkQ-1; Wed, 08 May 2024 08:32:54 -0400
X-MC-Unique: uPbjxSgPPmSQHvvklyozkQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41ab62f535aso16285105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 05:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171574; x=1715776374;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NyEKmq7S0/dWXFUpRGdfaeCSpwrySCliso/AaofHKNc=;
        b=MMdVZMyKPgXA0TDBoVOUUqSylkF+kuGegNO1/avNOhx/x3mZHPdD5iX7+Oop+fNBLF
         XiptCZ9EKuNCg2xV0qWHH5LJEVsFMPHIrWOrG1W4aHLVh0PQAKyGJodkUW7arp1+OPJf
         gT7OXuwwWEJsW8NGToLqStLvZ51/v2S2l52uWNeRQM6xC7h4ULPbm0wr3qtsCHJSqJy9
         rBYZKGA46gqBdDlhxzT5OU7/HyD3nExkmT9TnysHZJOnSnDjAddAe7T3KvOY/9wD+fWC
         H9drmVFNkMnevoOHEyZY8uaTyszV1R1cp2Oz0sJbab4zeoX+3KyM49jUqAT6ogNHfnL+
         BsWA==
X-Forwarded-Encrypted: i=1; AJvYcCXNzGzQPkXbz8Jne09wls2bYJs1vZmlH8qn35mGVvyEmbrLdNamOlPaaZBagxwpzqLW+ATyA7U4s1LGVzh/M2UoD2HD3BDVv7SLahgY
X-Gm-Message-State: AOJu0Yyc7m4xIW+PTB5H8LmKEuRPZ5InpCRIAVtpHtQPEPLDuy3lL5RQ
	/xrSr9xinDCbpP8YhxpBi5HvSm/CLEc4kJ4Wzaqg22n8IsRYKXkmgE+M/Wfh+l04Kq1WBlly53r
	cdZYoe/BGH3RPk9RhVW9csXtcVfKMgnC2HcpnEQgVMt/jZo4akzD/DhUmpmAlYA==
X-Received: by 2002:a05:600c:3b8c:b0:41b:ef52:1677 with SMTP id 5b1f17b1804b1-41f719d5d52mr18230975e9.27.1715171573759;
        Wed, 08 May 2024 05:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsALbom9bN4D6PjfVxH3CyMKXuYiCR4T9mD7ks1o0R8DW+R71cnB8NLNkN11xerb402M7ivQ==
X-Received: by 2002:a05:600c:3b8c:b0:41b:ef52:1677 with SMTP id 5b1f17b1804b1-41f719d5d52mr18230825e9.27.1715171573342;
        Wed, 08 May 2024 05:32:53 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6bc3.dip0.t-ipconnect.de. [91.12.107.195])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb4c000000b0034f3e5452a5sm6701504wrs.1.2024.05.08.05.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 05:32:52 -0700 (PDT)
Message-ID: <71027eed-8ddb-4b67-b5d5-a55e52a7133d@redhat.com>
Date: Wed, 8 May 2024 14:32:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/ksm: fix ksm_pages_scanned accounting
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Stefan Roesch <shr@devkernel.io>,
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
 <20240508-b4-ksm-counters-v1-1-e2a9b13f70c5@linux.dev>
 <36168dfd-bdfa-42cd-965a-f7a0e108108e@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <36168dfd-bdfa-42cd-965a-f7a0e108108e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 12:35, Chengming Zhou wrote:
> On 2024/5/8 17:55, Chengming Zhou wrote:
>> During testing, I found ksm_pages_scanned is unchanged although the
>> scan_get_next_rmap_item() did return valid rmap_item that is not NULL.
>>
>> The reason is the scan_get_next_rmap_item() will return NULL after
>> a full scan, so ksm_do_scan() just return without accounting of the
>> ksm_pages_scanned.
>>
>> Fix it by just putting ksm_pages_scanned accounting in that loop,
>> and it will be accounted more timely if that loop would last for
>> a long time.
>>
> 
> Fixes: b348b5fe2b5f ("mm/ksm: add pages scanned metric")

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


