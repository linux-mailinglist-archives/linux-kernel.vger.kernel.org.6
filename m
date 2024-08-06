Return-Path: <linux-kernel+bounces-276391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3989492EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D8F283F56
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982F18D657;
	Tue,  6 Aug 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpc4Uoe5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8B18D623
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954340; cv=none; b=srXGx6bPkJgkY0uzoyz53quB0FqOu6PYHx7PEQLkY0ahTstlEolXEGyNJK3KIpmYrmXsq0tVZpONl0+ztI6jgrfkJ0ZLLdXchkwLSpcZHQ7hc9QUwvc4uZ+LIbgxTo41kXgU4fQj8Ug9t4Zr8cgwICSNPUyTYD1jkemIYxgIP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954340; c=relaxed/simple;
	bh=r+ryOZyy/NKtkKoBxUqQ3TX3+ZfdfcOgVsyvylX13ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y15SsnJM55g3OfS0bBbobwE0qDMrd8foaXYKlS7mCwKBrx/dM7v0qOAD1SwmLqv0QDOTIbhYZZw5Yq51ktgpwzc57J8c6RqUwd5Xzm6zmLeaMqFYZruq4gV1H8gX+Lpb+NSyFYNY5e47bs1HLZkb20yo1ykPdGRmTxlWa1oDcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wpc4Uoe5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722954337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DqUGq/0Kgq2Yu7zgr3wSC7+vxO6NwSTjNgfn/SwFeLM=;
	b=Wpc4Uoe5Ft0Ny3d2SVMxjAzqKjJoxKVMwez6dVSgSneXphzcMKpk9pCGJdnWnw8UKsfbp+
	PGpCP9PgG2TpJ6Hv0WA5WDQwPkJxfPiDj4FNnAYqww5Aq9r2lsHyPFaVGilPGVKL0izRhL
	5M23O1jaUEDFFk1uVv9GpgWVAzhqP0s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-KbR77BU-MDWSJ3qIZRoMDw-1; Tue, 06 Aug 2024 10:25:36 -0400
X-MC-Unique: KbR77BU-MDWSJ3qIZRoMDw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36831948d94so574592f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954335; x=1723559135;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DqUGq/0Kgq2Yu7zgr3wSC7+vxO6NwSTjNgfn/SwFeLM=;
        b=VMhPbvmqnMrEz+gm843H683nUVWThXhjEpu447YPVgfQgP363ZUqGhbDx+fo+MinZv
         dIXN6vi1vpNzG1JJR43eTAP8FU0iidrHvj+L3Ug9CF68067Xe1MKgJpLXHfNE+Dmzsr1
         jv8iEn/2imI46hCFdWpzVUyUnaEANPecjY8br22ijWMaC4CQY2UMWOujTDOu/a2+ckTE
         39H7yQ4Yqn6J5PJ7K/GhZky8UOWGkGjh0f9vMjLQvb1DnltPfDopStkoxjQX+vyjKJPS
         uih+pBKSjIJvCktSUew704I2epnFJy95saf52/wIZRX+J7jiXZZvYn/oTv5QzcN2x+AJ
         UmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTc3/Ao25zXYrzgA91dyE/3pe0NHon73iI173LNX9EecWcpoNQ9RgVgSGl5DiD/x65iMcfsarjbouynG8eUXth068ZN7ElLlNbgVbB
X-Gm-Message-State: AOJu0Yw/v7xIkTfhrleBdDWUAw9lpLtFh7XkKDV0wOuSlWXAmhke7jBE
	/h4yuPga28rWgiTraMqBoGe7HHTLiHiq9gnKAReqhyUPtDbKhn74a5hs0Gaw+NbgRJY6xr5OXJ5
	EQlRaZAw3gKxQqsDb2ieMABduGObyKH0p8sRw/g6tJluEKNXqWYSgJdntz3U0Gw==
X-Received: by 2002:adf:fa4b:0:b0:368:6633:c54d with SMTP id ffacd0b85a97d-36bbc0e91b8mr9271362f8f.35.1722954335048;
        Tue, 06 Aug 2024 07:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZRDsdJGAPhQkoV/gj483WgTWjE8EmoDzSY706AKGJRYMJuVd/vy7DJYu8CHBG6COMo7kmRQ==
X-Received: by 2002:adf:fa4b:0:b0:368:6633:c54d with SMTP id ffacd0b85a97d-36bbc0e91b8mr9271348f8f.35.1722954334580;
        Tue, 06 Aug 2024 07:25:34 -0700 (PDT)
Received: from [192.168.3.141] (p4ff234d2.dip0.t-ipconnect.de. [79.242.52.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059836sm13036287f8f.88.2024.08.06.07.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:25:34 -0700 (PDT)
Message-ID: <20485870-2156-4b60-a8f7-bc3d9a2f98f9@redhat.com>
Date: Tue, 6 Aug 2024 16:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/7] mm: introduce CONFIG_PT_RECLAIM
To: Qi Zheng <zhengqi.arch@bytedance.com>, hughd@google.com,
 willy@infradead.org, mgorman@suse.de, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, zokeefe@google.com,
 rientjes@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <7c726839e2610f1873d9fa2a7c60715796579d1a.1722861064.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7c726839e2610f1873d9fa2a7c60715796579d1a.1722861064.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 14:55, Qi Zheng wrote:
> This configuration variable will be used to build the code needed
> to free empty user page table pages.
> 
> This feature is not available on all architectures yet, so
> ARCH_SUPPORTS_PT_RECLAIM is needed. We can remove it once all
> architectures support this feature.

Please squash this into #4

-- 
Cheers,

David / dhildenb


