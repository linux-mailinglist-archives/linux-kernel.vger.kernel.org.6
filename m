Return-Path: <linux-kernel+bounces-201913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC268FC52B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589B71F2687F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB1618FDA2;
	Wed,  5 Jun 2024 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIJp6EtW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4018C356
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574008; cv=none; b=Z+lgBSOXyKWoTPac/Xd+8umjvaGV1dNLNpZ1dwlVJqyycTcrUZzPlqfNjggvxX0G6/Pr8Rkp4sbHBo0ugbU1nZ98+ktw5XeFIsDoWFfA7ZZ11c5cGtF1FCckCvtv8hW9UqRxqGZZW62IVdIGl9MpF9DHacP9otOg58rCXZYxBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574008; c=relaxed/simple;
	bh=fGOH4FZgsCZMXhQ7Yv/XwFJ18BkdI5yevV+X97tT4wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B4u8MqeIwh8FCWN2UL+AURy/pBngDiTerd0+JGArj3CTC8DQtPpOQhddgZCzrGDdndsPR7c0+fclrs5/LO1ccuNArgSWPmE6hCrwtMDvhijZhc8N9Ddkj0qaV6ACGASfnUyKVPOxx3QwX1qh0n8rFpHfHqjB3iE7FcTMSmZwkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIJp6EtW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717574005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9EYpepA/fN+ldosWhJbgAllKaScF88wlJmj8k+gnXHY=;
	b=UIJp6EtWSmclns2mLq6xllNSgVo1Sma/7SpgVp94hJ9N5FYsYVA0zCcOtxgis0LiiFlUuE
	NSr/eMS/fkSQzeo9wU2Acj2+ow5Rg5SQ9GfoIIFT/orIWAUjEtBOVZPksGO84I9OWejL5q
	f6sdJIYrWUPAYKGx3Cnax1UiDSU3V7U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-7nZ4blqCMdWKcWugqZIX_A-1; Wed, 05 Jun 2024 03:53:24 -0400
X-MC-Unique: 7nZ4blqCMdWKcWugqZIX_A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35dca4a8f2dso3715191f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574003; x=1718178803;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EYpepA/fN+ldosWhJbgAllKaScF88wlJmj8k+gnXHY=;
        b=VnAg4Plqo+x1TrCi33Ob/v34bE+mMdQAccu4iwAq0/ouTFJ1lV2thJNDdnhW6Npnzd
         52T8jvZ/3+T9aW4vU4RyS09/qZt1XlF+5PGua8ZDMBJS6F7q0zYnU2AhTuuBBCuT4q+P
         EoOPAvYb0RF1IBsXIPMmkR9u4tPA8F5r3JC3hSlPX3rOVQDtX72rJoecqSHY4Squ1Kop
         gkdadJq8nl6uu8xf0DTLEabQ8CptStvR6yIl3GinfHpEH+73AKaW23NQYoBjUCmI732w
         RR677ZK52TdaPgArcvhlNGM8KKIjzutCKiZ7++NLZE5hBf0C7l0kOi5TkRw+p2Me79X2
         lCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5PsjWyKb/5u78NXKBaLvfTHSKkSsBWUr49GJ4CsXzf+V8KXRs0l43ymewgGrzv8UX0ax7Zt6zEDGS/+Z09FYZynGPt24lypGnfFDD
X-Gm-Message-State: AOJu0Yxq07kaywTcdLddBn2tJKY3Ah5MznBo1/GKhWBXDHSsLHuywFuy
	hHGHeDEcZgu31Pb3ND/cG6szOLPvDieUnbQ6Iot6rIHqGflLDmhKU+3csPbAcZ2GNnT4QsXiiOO
	4mCuV42tIx0Od63LMamiN+LAJZQCxTP2i8ZR5V1MRXd5yXfLwJebZpVGZ3EjeRA==
X-Received: by 2002:a05:6000:154c:b0:354:f7a4:5d9e with SMTP id ffacd0b85a97d-35e8ef964dfmr1450039f8f.69.1717574002963;
        Wed, 05 Jun 2024 00:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6epRicufGIhCPhgs4QBIN9wfjrrukLYcaWa9Wz6Moo7K55Q/nkkbnSEzGt5WOgIZaxrjacA==
X-Received: by 2002:a05:6000:154c:b0:354:f7a4:5d9e with SMTP id ffacd0b85a97d-35e8ef964dfmr1450023f8f.69.1717574002533;
        Wed, 05 Jun 2024 00:53:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ed8b574e3sm1264073f8f.79.2024.06.05.00.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:53:22 -0700 (PDT)
Message-ID: <2a9c760e-c5cb-4ca5-8651-cc870a63ddbd@redhat.com>
Date: Wed, 5 Jun 2024 09:53:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm/ksm: calc_checksum for folio
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-10-alexs@kernel.org>
 <ddb33c85-35e4-47c5-8a81-13a2012aac5e@redhat.com>
 <0a6603c4-ac05-460c-8bad-66813570b426@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0a6603c4-ac05-460c-8bad-66813570b426@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 05:44, Alex Shi wrote:
> 
> 
> On 6/4/24 9:18 PM, David Hildenbrand wrote:
>>> @@ -2369,7 +2371,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>>         * don't want to insert it in the unstable tree, and we don't want
>>>         * to waste our time searching for something identical to it there.
>>>         */
>>> -    checksum = calc_checksum(page);
>>> +    checksum = calc_checksum(folio);
>>
>> So for a large folio you suddenly checksum more than a single page? That's wrong.
>>
>> Or am I missing something?
> 
> I am not sure if this change are good too, anyway, comparing the whole folio may have it advantages on efficiency, but more splitting do save more pages.

Calculating the checksum of something that could be a large folio when 
you might want to deduplicate subpages of the folio (and decide if you 
might want to split it) sound very wrong.

Please pay more attention to the details how the current code works and 
how it all works with tail pages.

-- 
Cheers,

David / dhildenb


