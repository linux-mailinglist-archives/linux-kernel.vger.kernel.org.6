Return-Path: <linux-kernel+bounces-535943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F8A4799F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69561888B47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6511C228CA3;
	Thu, 27 Feb 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ER7DwiA/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086D42065
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650063; cv=none; b=mnnIkoqq2vzxDtQpSkbVi4LYO5nFW83sbAl+6ImCmyAwjllmvprUNCqQ2AWdD0NhLpdNWkHNPqpiJQ84eqeFrEd3QKwg6fJFTSU8XereCuPk0nhS6SIjO9iQUZjuzAfqU57kGrzm9MVPyjU+qAl23gdY/0Cm0tqz6fq+jiY9vAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650063; c=relaxed/simple;
	bh=OT7u3MXf2icGMgXG+9+uVOtQ+rdPV9FEFh2k+CzdviU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwHMn5xj2saIMMsSd2oZJZwDFEHp55y9PnmiPnO/FmuTIePeost1e7Cp2kzx/XBK9ZQvDdBdMZG8Ns0nIolLS6CCSBDEzFC1lCtRRc+ACOk/6NviqyYvoYnHxhcTlubGquk68jz5qvCleDB0vUqfREmUavEPz/nRSYvVtEFfXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ER7DwiA/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740650060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zhF1y4wUZzeCK4QWVW1ChNMJyWCwEu5u4WSFbQZ4nSw=;
	b=ER7DwiA/mohaJ09f7rkNleV0rGtCPTbmmpdm0aNMzdh3K1oqRhlS057NXMT9pqZza+4kH9
	7FeurGRXT+cj1RhjlST5g0k11o4NLSqPEGmD1DuIAt+R9twKBhxPBRfCDsrNBUE8P2Qy1e
	HubMuaRqEIuRw3Pd5hdXFPQKJY7R9Qo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-_sHTe4LeNQO8jTngFvhffA-1; Thu, 27 Feb 2025 04:54:18 -0500
X-MC-Unique: _sHTe4LeNQO8jTngFvhffA-1
X-Mimecast-MFC-AGG-ID: _sHTe4LeNQO8jTngFvhffA_1740650058
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438e180821aso3682225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650057; x=1741254857;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zhF1y4wUZzeCK4QWVW1ChNMJyWCwEu5u4WSFbQZ4nSw=;
        b=diMXTbcPNu5GyBlobz+frcerhDVRfH+wv7SRXqM16Wxo+RKBmHnTbMGnubssmrLLpI
         pQv7mPxm7G4hQoDibkHYnEfEPe70QKpZerzXyOC1KoCwJqpIWRaZiUOLj9kSOi9RO+wi
         mqM7Jghu3LSj/XFYyPCsa6ZU5dvWTeXWQ6mkazwU1F4Tprdz+Tt4ZoQU0RXA5KW9NunN
         7AOrCT2vrxUDIq8onYZUu0xpihFXulEA2MYLYBvHbNkW/68xNGVJ9myTPSIYJqt8/VmE
         2aC6CwEg1uXLqbWBzv9Geas+UxNMotV6gMy6vUX09QK+7t58HuQi4TJrT5QmzGpSz+Mu
         GVWA==
X-Forwarded-Encrypted: i=1; AJvYcCVAw2br8iguGz/XMWVaeFGydB3ZPHCmZdbUOxhBFjm7Afz2+l5KdesCaeTPltUhVodM3FNgoZWEd9zsniI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBRYHb8H+e6rCSKluLem5qPE+LyEy3CpllYwWAmMrmXLMTkzc
	CZG/DL6id9OrQk/gmX10uJOutlvOjy4Bu4WWLRRv3rMJJAlbKKdnXUCfW5SbkKmD8An4fKdNmQ0
	FJWqfOQujVxnyDD97HZl+089ANjdFIgfrtp7P2yd58CS/jzZxVvo/yGJKyHSdZ32/ifSIcHXa
X-Gm-Gg: ASbGncuwptE8oH4P8JEwRiXl0FcgYj0TEc16OuLqvvri0a/SS0JbD9M//LKrzO+EydN
	dNKb5/BddvmM/xiw+O7b42Ap5L8CNvMhGR5aMm7AU8MIUG0PipfbydTlbXSv0O8bmnkS8brglQo
	SnPq54Szevlv9fEWyI8jz1finNyiUnEHfzlMTOGOyJY2FUqwkn39aiEANXlacKB55sgawImHGKd
	J12e+9Zj2JqwXvzvd805h1oej658dP+juSpa6Rper5/sVaSJc9CKucw+AHMgKQ9J7w+VHhzdlb1
	kT/of6gty65uqNMOUF08Q+dvCQPEI7Oy+saEMl0eTtxmpLAgn6TmK3v7aZxOz+UjBGBZLm0tlF/
	vGi17fhuDNqx8mh9jaUzTgZoCxntKD8Ml4XtFpnNbvK4=
X-Received: by 2002:a05:600c:3111:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43ab0f31010mr100757445e9.11.1740650057567;
        Thu, 27 Feb 2025 01:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWjzm9W+sB982M//TJGWBWqz3Y7hd98JEuQ1xhV6qV30QxplxehIsAB/yRrMEVRftuuYzJZA==
X-Received: by 2002:a05:600c:3111:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43ab0f31010mr100757195e9.11.1740650057117;
        Thu, 27 Feb 2025 01:54:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c74f:b800:58e5:8355:5366:573d? (p200300cbc74fb80058e583555366573d.dip0.t-ipconnect.de. [2003:cb:c74f:b800:58e5:8355:5366:573d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73702bd0sm17232635e9.10.2025.02.27.01.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 01:54:16 -0800 (PST)
Message-ID: <15fe7b83-0a3c-47e1-9b32-7db7b6a25c19@redhat.com>
Date: Thu, 27 Feb 2025 10:54:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_PT_RECLAIM
To: Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250226183013.GB1042@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250226183013.GB1042@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 19:30, Johannes Weiner wrote:
> Does PT_RECLAIM need to be configurable by the user?
> 
> Why not always try to free the page tables if the arch supports it?

I recall that the reasoning was that it might negatively affect some 
workloads so we'd be a bit careful first.

I'd be happy if we'd just unconditionally enable it.

-- 
Cheers,

David / dhildenb


