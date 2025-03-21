Return-Path: <linux-kernel+bounces-571056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC780A6B891
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069DF3BC11A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590221F4199;
	Fri, 21 Mar 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8XSDnAZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2C1F0E37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552063; cv=none; b=W7W0/ma6720kkYu9Xo1BGLUpdNwrsiDDIyKUNTpkpmmQ19aWjd2xaPPyrVufa0i8qj3mSWiueO0Wc0WQdePJFRupxdxj1d50fBtZt1NVNXEp1lEFKDbnln0qB+vPD0ZWJXCzIE/5E1VtInCjkJQCtxvc4oP50goOc2u5anKOSEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552063; c=relaxed/simple;
	bh=rP+JsvMF36TxhV75cEq30zIoJ36SfIacsQTF/ybpU2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDEtNDBaUy3400+UxLFl8HDx8848r/ihHaiR1uXIBhc43LizBqP46ectqPu3VO4raX+pt+0M6NnrRWOoAGVmjKdm8qyaohoOcdSzIyTRuaBDWsy9dpPD7eRDAs8opoUFH6JfYyP83qqz+aLYIPNomlH4LuzyDdBGTn6T8mOC6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8XSDnAZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742552060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PHlbxQe01vLEiQ3mDcT+HixcFtHLS6rNVTX0kCx8V6E=;
	b=V8XSDnAZeBBSGAjCF8V7cWC1kIbCboYJaqRhH5vrtFjDAZdo6znmUihQe6vvcpxXCmZddr
	GhW44/bWFPS+HaUIowIX+pcCyYTCjKQH7krPoN0ThOXpSr3a7jaVnQ1XoikcMkqPJ0Z4s/
	G/6vVzU2iSw44QJnUS83VnKOVEztEkE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570--IEuQuqmOBmXcXyk4L23mQ-1; Fri, 21 Mar 2025 06:14:19 -0400
X-MC-Unique: -IEuQuqmOBmXcXyk4L23mQ-1
X-Mimecast-MFC-AGG-ID: -IEuQuqmOBmXcXyk4L23mQ_1742552058
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so13166705e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552058; x=1743156858;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHlbxQe01vLEiQ3mDcT+HixcFtHLS6rNVTX0kCx8V6E=;
        b=AWsPaseQ7iCZ4ZFwFaXvuZwdmKt9GPSB3jy6kdN2+EuldOtb8vq1LsqMAzgLSUyMfg
         SpyAFzuwBO5vcedbL1GfTTudjDD9nxgmYvAOrGPuhxADrjy2tEJZFOg/z5sO4nei3dOy
         stZzbl2QT3cQJDTlfvMPpBjsOq0dUCbeorQHsYLTPeS4TGB+bG4KJbXm0LMzowdxDPOM
         QGnEca9BcM8rwE2nNS9aU5GlWyyNLvkzEE/XIRbju85rVCkCTY8qBoBlxtog4bpUD5fu
         rMIMSfsDeqFBKCK4O7bWmqoemfwbrAeF4gR+0gUTlPGo835ZhbOaNchEOS6yjIQaQoJF
         odmA==
X-Gm-Message-State: AOJu0YxUuD3Ge9NIHDNu2SddyR1iIF/TdsAPhS2QuT+iTQWcs4HU1dso
	JIWJHs2nCETHG4qXUshDhLodDPszALd3GPdUAHiKlG56to1hM4JdJD3pR1ztsBez4feGgZJEJ57
	U4SMHiz7ZalkhZ1f2ukLmScXqFeryE2COiIHf5QXCJagiNCvTZZM29X8lxit/0A==
X-Gm-Gg: ASbGncsIC8Sir3M2P4pjUeOmujqa5UEM7J5jP2GPbEgWhOiNpqOCdwNK8Bd5bt2+BoO
	7PiXrJrlfSi9uwo0+7JZINnvly3rzR+WtscJjNZUGggbbEYqOp9Qox5NRd1zu4adTNL7Wa/r/8y
	kKc3Ewe42aMR5rWgB1tpkWx200KNAZon9h13ooTswVJN6fQZWmjz8oWOfVO0IPDg57zExvhnzMd
	eSxuVHyJlGNMt9dCfsm4wFkIVoQ8qCNmZAmTSUgXOJe1zwumC5Lgt+JRW9GHNltKBASrxKTh5Da
	kkRza/z8qbus3uiMzrL5RQVL5UwXWgw+qXou1WRYK1Our/IbM7VdWqcdepPgSSsCMEVAD7arJP0
	is/E7w0IqtbtGtwqf7gBRwCNBjnfskC6UbivAY80Ze7M=
X-Received: by 2002:a05:600c:3c9e:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43d50a4f8camr21606375e9.30.1742552058271;
        Fri, 21 Mar 2025 03:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGscQrhBBTGqOWY5+yPvlI3Utf38x4Ufv/GREG+b4A4kR6+FlCoSQJ/MfUa8u7VSgrtM4+SQA==
X-Received: by 2002:a05:600c:3c9e:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43d50a4f8camr21606085e9.30.1742552057876;
        Fri, 21 Mar 2025 03:14:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ba44e63sm68842565e9.1.2025.03.21.03.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 03:14:17 -0700 (PDT)
Message-ID: <6ef83b28-5f01-4405-a25e-0bd59e071118@redhat.com>
Date: Fri, 21 Mar 2025 11:14:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/debug: Fix parameter passed to
 page_mapcount_is_type()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, vbabka@suse.cz, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <20250321053148.1434076-3-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250321053148.1434076-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 06:31, Gavin Shan wrote:
> As the comments of page_mapcount_is_type() indicate, the parameter passed
> to the function should be one more than page->__mapcount. However,
> page->__mapcount is passed to the function by commit 4ffca5a96678
> ("mm: support only one page_type per page") where page_type_has_type()
> is replaced by page_mapcount_is_type(), but the parameter isn't adjusted.
> 
> Fix the parameter passed to page_mapcount_is_type() to be (page->__mapcount
> + 1).
> 
> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   mm/debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 8d2acf432385..b6bd9555ec7b 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -71,10 +71,10 @@ static void __dump_folio(struct folio *folio, struct page *page,
>   		unsigned long pfn, unsigned long idx)
>   {
>   	struct address_space *mapping = folio_mapping(folio);
> -	int mapcount = atomic_read(&page->_mapcount);
> +	int mapcount = atomic_read(&page->_mapcount) + 1;
>   	char *type = "";
>   
> -	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount + 1;
> +	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount;
>   	pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
>   			folio_ref_count(folio), mapcount, mapping,
>   			folio->index + idx, pfn);

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


