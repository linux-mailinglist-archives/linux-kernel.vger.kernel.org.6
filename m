Return-Path: <linux-kernel+bounces-571155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1828A6B9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D1E17C3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCB22332C;
	Fri, 21 Mar 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF7XwAO9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E8202C27
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556342; cv=none; b=HEmhQjsKCDviHTP/0P1Lflx+VlXcnHCCAYgJI/CLdS2FWhpWRcdxDiGGWeZSCc5nEOt3SA1LaNDxIwMlY0eab+zdoayi4dICF4QH4Jom0Q+inTpA4V4o7I+z3v05LYVROZ00pPEtKL65hLq/JkduG33VMxBggYHxcQn68hF07fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556342; c=relaxed/simple;
	bh=KI/2AGL86k52C8btarR3FdUk7s4SlCVth6HPJysL2Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eh+Gr/5Ebea5jmDWEgzSX7lNVXe4UmrQ47QMUB2eraeBT8kDIq3+Pdv4BiOkQ/Ada1nFBWLS+gM1lORYO3p7DcD7D9KsNdXIvxUl4jgTxuOgkct9IIhoqIR0ZKRGUcrIyjpunmOdLDMshUB8TbLUTkqktR3sfnyi87IfS1m7qjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF7XwAO9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcGxSxTbOVpMZyAZ/MNr7iuS33cKQJqIP8PXa1sShoE=;
	b=dF7XwAO9QIbn+DBO3KvZIs4gnkBZrYV0fEc9fEq3QDrJJjFmLFNj0pLbldVz/qt4bAQQ3j
	TomZjW/1J7tlTqEbHyKdoyUpdP5DXHBV59uvvOfnS7Q9r/nRsABpRALrM0V9jDIlFJ55HX
	ORPJiOhCQnPtEynn3KzRxGlTX7rCQIw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-SmCMqZMNOyiVB4MQ0ziXkw-1; Fri, 21 Mar 2025 07:25:34 -0400
X-MC-Unique: SmCMqZMNOyiVB4MQ0ziXkw-1
X-Mimecast-MFC-AGG-ID: SmCMqZMNOyiVB4MQ0ziXkw_1742556334
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso3131005a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742556334; x=1743161134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcGxSxTbOVpMZyAZ/MNr7iuS33cKQJqIP8PXa1sShoE=;
        b=CS0vn7RdTRrU7qO8gnaAH3hb9fMMv8RQgb3nAf9JDrYCc3E64suJ+FuKWKvbNNuJkR
         Ij3FWiM78mB4peJppEcVkfCSrXAX55BtPjSZdQ/s9o8I/AafO3RBUxreE3TEQhBY47Ax
         yVVAKTJ5qgOX+dAJMzZDhj3dnYbulAaON4vLplauYLaRV8CD6wEZgFM7a56cQUrC00xK
         vrDxFFRG8XMVUGlsIUTE95d6lxng4jbxYoXm1AyvJVVB9QxWRGw1Gg/DKF3ZRtUVXYvd
         JD3tDKiNnyKrpwkjfhqgffFjEQKPIdImxebylxaPP9/lYjwDgTirGOo+08kHfGsrUOSm
         KrGg==
X-Gm-Message-State: AOJu0YyKKmgr5KkTWPQ5EEkSrgfK2asyCQqaw3BHXM5Q76TN8cca9v6I
	50XBWfnZxN4Nawdaxi2j0uCZJXj66iBLmneqSps2qNby9gBnk/E1Y46WkS0G6hTqI3Lq7hj7FNz
	/hIkW1CAfAesqFsxlKSSqaOVnlO5HAnN7HkucsfxpFUYtGn3GrJdZB8nZmNeGFA==
X-Gm-Gg: ASbGnct/GxhLT0rqag5h1JoUXa2wC3bzKwg1ovYsnNfDjTA2/BbClj7HoyxtnLTra3C
	zpR/4Tvy6tBginUNjRpZEVz/5cGE0kSkxfMUXQYaqkH11ZasxPSMXFzs9ZEEE7IeY1U2qR0cBpM
	ELA/8WR8UhkuTSwh7JRK9jl19KgHsU4qFijc7T5oDCp5DMI36Pv1D8lp2U8//Tgk7xezoU83eWH
	mMqdxpR3C4bC835f1bBI/bnqVyk7r7B3NXH0/RDbOOsi1UlEdbnUmrPyZJbVepI7ygONo4jOZ3F
	rHXlQf65VDg63E+PRw==
X-Received: by 2002:a17:90b:4d08:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-3030fefd8bcmr3349330a91.22.1742556333721;
        Fri, 21 Mar 2025 04:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhnSanbQkjja3u7vjcfqJx/EYbJW2GJpG5lYb8dvzNwA2Xr5Zjdg+wi9FI4uk1RPAbUvu8AQ==
X-Received: by 2002:a17:90b:4d08:b0:2fa:f8d:65de with SMTP id 98e67ed59e1d1-3030fefd8bcmr3349300a91.22.1742556333271;
        Fri, 21 Mar 2025 04:25:33 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59e2desm5742121a91.23.2025.03.21.04.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:25:32 -0700 (PDT)
Message-ID: <5ec97dd6-6561-4687-ac94-41c63ffc82cf@redhat.com>
Date: Fri, 21 Mar 2025 21:25:27 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
To: David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
 <0d096764-302f-4b80-a867-22f5302b8045@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <0d096764-302f-4b80-a867-22f5302b8045@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 8:11 PM, David Hildenbrand wrote:
> On 21.03.25 10:23, Vlastimil Babka wrote:
>> On 3/21/25 06:31, Gavin Shan wrote:
>>> Found by code inspection. There are two places where the parameter
>>> passed to page_mapcount_is_type() is (page->__mapcount), which is
>>> correct since it should be one more than the value, as explained in
>>> the comments to page_mapcount_is_type(): (a) page_has_type() in
>>> page-flags.h (b) __dump_folio() in mm/debug.c
>>
>> IIUC you are right. Luckily thanks to the the PGTY_mapcount_underflow limit,
>> this off-by-one error doesn't currently cause visible issues i.e.
>> misclassifications legitimate mapcount as page type and vice versa, right?
>> We'd have to have a mapcount underflown severely right to the limit to make
>> that off-by-one error cross it?
> 
> Agreed. Likely not stable material because it isn't actually fixing anything (because of the safety gaps).
> 

Yes, it shouldn't cause any visible impacts so far due to the gap.
I just found the issue by code inspection. Lets drop the fix tags
in v2.

>>
>> I wonder if a more future-proof solution would be to redefine
>> page_mapcount_is_type() instead to not subtract. But I'll leave that to willy.
> 
> With upcoming changes around that, likely best to leave that alone. I expect page_mapcount_is_type() to completely vanish.
> 

+1 to remove page_mapcount_is_type(). After Willy confirms, I can post
an extra series to do it if needed.

Thanks,
Gavin


