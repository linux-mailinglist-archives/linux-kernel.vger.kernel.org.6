Return-Path: <linux-kernel+bounces-571053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0FA6B88B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A55719C2A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8622135B9;
	Fri, 21 Mar 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBNaJKiM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAB1F0E37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551915; cv=none; b=D33Ki0RSvVyIE1+kjB4SoK0dqL14MjINYJYm69wqLcvrh0mpCNoztX/plteCX6MbNqJPppVeJc79NndIpoDyqdhmqQ3+hCfx/rgxs5PWG1n20zqfhZN7kNsM45h84a19it19phhRW5mhoDDEMP2t19PtV7WdrJzliPnlKDVkQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551915; c=relaxed/simple;
	bh=j0cUqSh9E9XuWWq+YGpMVDVupIrl+f1UpZ8OWli90e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USP0/h5MuL5MmZvtzDHHMQFNaOAQejT3ET8yoyBGYV8rTnAfDfIDz9Uvpvklu8NipJq+GQ/KOnaan2pmjPDP2lYV3HCfO1zV4nA6yqyEFDb1xFeg6CPDSXMf1+1nnteeKlFtUBFaHfn1B8Z/NFiuNZ5X5zbTNFtowez3tgSHwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBNaJKiM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742551911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cg7KFNpm/t6VITN57sK8jbD8z6qCvcOwqqtseqoNv4s=;
	b=UBNaJKiMNczPO/DE5r/3UQMbXql1fqiYqRqMgpSpAugw8/OVVJtbf/779STspPp8xuwBgs
	ehzpDugk3z1cCYEdlK3psYetXcWPPU8sXRjtBS+Z8vug7YKZwEx3z4lh1L8OZGNN2VkYIS
	zYbw4zwyr2J+bRYj1Crn6VcAt7Vkt0U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-tNX1OgkFNvuYD5ecOc3gzA-1; Fri, 21 Mar 2025 06:11:50 -0400
X-MC-Unique: tNX1OgkFNvuYD5ecOc3gzA-1
X-Mimecast-MFC-AGG-ID: tNX1OgkFNvuYD5ecOc3gzA_1742551909
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912539665cso1434113f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742551909; x=1743156709;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cg7KFNpm/t6VITN57sK8jbD8z6qCvcOwqqtseqoNv4s=;
        b=hs6nu0BtB0IMQJVbNASp9udAokvk8PBsoRywQojUyHWSs4X5lMFozqKSqUBNRJbG7l
         9GpUPZiY38Y/YY99SBZorUUgqh2YMoitNvuekJsN0MpTrJR+Zhe2cmnTUHSbt2zpCjmW
         0hLO5A2npBZne6mui01aTmEbDxdaYFoHXaviIAGD6kUlkF43xKsblR6ks5d45N85QweY
         Z0vIM3iegv96Txq+DjzvISt93xfNAfEw/5FDptv1Xg6lr7LyxHXlEWy8mpvWgbJ08vwu
         LFHMfhl5jJGInn7leaJOOElOMSsH/VJjfAC33lEXWR/dtxD2zMk8aS9mqXUNvfkEhkGK
         iC3g==
X-Gm-Message-State: AOJu0YxQ1T8VLY18deMUdlu/E1/X/VTMosP5UdeowL9T9T3XI636u8VG
	DpehwHcuRTqrvnW2RQ8/+FA5DgYQc2lrxvBnfaDRlt7Pu+DYk7cU7e5F5CE/lYvYEh+YBBdNCyX
	WnuUPEjPTozUG2kITuwseKQOqaImtNTEoi8Dg0VGD6SoCFD9H1BMGMeTXQakYjA==
X-Gm-Gg: ASbGnctuGPVSnBl6/LciN8aqAt4dq9Pmiun6GuA5TdFdnlSAUSCnHljWR7Aw2JPNBJl
	7myX2zq0X8w8dK00IJqNv5zjdlgzro2mN8Ui4G+kqot/XT1Uuc4ONWsVp2IRtkxel+ugbG0MUun
	E25V/GBw2osh5w3YAr89JQPW+zM9MusWCf9JFhGHgxSrEH1C88ni6yjLDte1FcuXhY/zLvs5izl
	Id7DTQHlLbTM86jLL2XJaBlhFj00rgsaMMLcnVZc33G/QvvNY2cNf2gCgBmEjyB838VIi6dQxy/
	a/2xVqJS4QCr+aQmTDFclV3fFnOOZFwe7CqPP92m8o6K95EQ/2irqWvGFG7mVxOlVPKxbc/HZph
	7rS0pid6WCqFtY44mjDMTDROhWsyZJ0CEMzN2Udqf1Oc=
X-Received: by 2002:a05:6000:4027:b0:391:2a79:a110 with SMTP id ffacd0b85a97d-3997f93d70dmr2186942f8f.29.1742551908947;
        Fri, 21 Mar 2025 03:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH41Pb+XnF8bVrwkbZE5DsbPBB96uVf+ftiz0k+zCcPv7G+G/FVnPQ4hJScG15c3weBo5N42g==
X-Received: by 2002:a05:6000:4027:b0:391:2a79:a110 with SMTP id ffacd0b85a97d-3997f93d70dmr2186904f8f.29.1742551908464;
        Fri, 21 Mar 2025 03:11:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6450sm1951589f8f.70.2025.03.21.03.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 03:11:47 -0700 (PDT)
Message-ID: <0d096764-302f-4b80-a867-22f5302b8045@redhat.com>
Date: Fri, 21 Mar 2025 11:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
To: Vlastimil Babka <vbabka@suse.cz>, Gavin Shan <gshan@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 10:23, Vlastimil Babka wrote:
> On 3/21/25 06:31, Gavin Shan wrote:
>> Found by code inspection. There are two places where the parameter
>> passed to page_mapcount_is_type() is (page->__mapcount), which is
>> correct since it should be one more than the value, as explained in
>> the comments to page_mapcount_is_type(): (a) page_has_type() in
>> page-flags.h (b) __dump_folio() in mm/debug.c
> 
> IIUC you are right. Luckily thanks to the the PGTY_mapcount_underflow limit,
> this off-by-one error doesn't currently cause visible issues i.e.
> misclassifications legitimate mapcount as page type and vice versa, right?
> We'd have to have a mapcount underflown severely right to the limit to make
> that off-by-one error cross it?

Agreed. Likely not stable material because it isn't actually fixing 
anything (because of the safety gaps).

> 
> I wonder if a more future-proof solution would be to redefine
> page_mapcount_is_type() instead to not subtract. But I'll leave that to willy.

With upcoming changes around that, likely best to leave that alone. I 
expect page_mapcount_is_type() to completely vanish.

-- 
Cheers,

David / dhildenb


