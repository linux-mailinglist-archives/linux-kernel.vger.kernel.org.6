Return-Path: <linux-kernel+bounces-279129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003794B95E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B448B210B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726EB189B9A;
	Thu,  8 Aug 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPF6Gcyx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153F146019
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107288; cv=none; b=sBkTM/68kiBLZ74c8s5ktEIvHpMusSIzhKBAaSXvTDFep70yGeowz5j+UO6XXRKceW12jXsA/wlE/xu8HX8RzDLrkk5uhjRl2Nnai9ckDtkyYF4AGtJV5EXV+BTsQkEdCDJP7a8POz0ovuo8URVlat8u7dpQ0kkHMRm6fako27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107288; c=relaxed/simple;
	bh=C+6qaWiU7ldnfOdGSRJjv3dwvSHHiJKbeZg2c/a2N7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCGJewqllSK9zngD5e9QHJPVmsKS/E2I1GyHd0TXVLyLXVPePtv3FigSKwjbU9+mtZtNT7rePs+kMYEL2sC5DTH9pze6E+dj1CO98xi0vXSsXnOmSDOflmtHQGCaSA85S41xZlIzPzjvvrYdHT8hBZdNmXBjXhEhhvg9rgwEt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPF6Gcyx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723107286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S+2Sr/SXocmPKAfko1wTPHTKMwDLywA/S85Vw0GvJA4=;
	b=LPF6GcyxhSO5edAdqx/pjx39NeHt9dafAYXg9Vck2qVQv6vQmAoAgzTEeOpDwyl0UYxCIX
	ZdlIMv8KkXN3KLe/laHe5VDdnWwBvgqpO1gj6z1CHySaFnPkLPYUzF+onJnc4nQUvOXDYM
	nXlzeLDEp2I0mIZ2BYTSP3zotPr6ayQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-d4Ps-sNVPziezG28fn1jwg-1; Thu, 08 Aug 2024 04:54:44 -0400
X-MC-Unique: d4Ps-sNVPziezG28fn1jwg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280f233115so5076155e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723107283; x=1723712083;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S+2Sr/SXocmPKAfko1wTPHTKMwDLywA/S85Vw0GvJA4=;
        b=UrBtADXAHPYOIt07qPvKHUrgcxcZPSr33Lt5tBDWXOMdRKf32JNZnMGuKEThf2H5lH
         1GPo8PiCvPEaR3OrDnxGUsKp9Ghi7XcJDfQSQrKCp0Kl/2udC1FRtBpkBl8U9XF4Zjat
         9RsD6RNEOj17n0EaFS9VqfXL+fhinsMKpV8BT189N5uPwhRamxfKURgA9X8PgrmhpzZW
         YVhuNuM1EFpkZKCMAmbKeSVH+qrihnvLi8w0+BDqwkaE9Dz6HL0zi/aYDosIM+1znyDt
         hv13vf5admRxnUt3vgwJ4HlhIiLqHOTXPc6pdJtuZirL23/bgXIfFLQycew+mxAo6eRZ
         nt9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXj+/GPmjQYVObTa6WrWxzdAeV9ebmqkfw34StYxu4jY/+yq25oU3u/DC5ObfLcZ7YglLfp7ZF1V7J+ZcbHD8Xn950Qj2Sg5fzUwM2A
X-Gm-Message-State: AOJu0YwFlAcVnepNhLG65XEcoTSgY9U04zMMx0IlZBckUo8U+ppVu+yb
	dwIgxxsE3x7QhzIBVICWI6X5HA8nm+LQDmxth5BPzdtBfwjXxTBWuf8r+27HHkalZH9EcF0r1pQ
	vaBTexujTs2psdzqqPg3zvCL30Gcuq4uoUkp6dq6gu0kImKxOFRCBdPMd47kH2g==
X-Received: by 2002:a05:600c:4fc6:b0:426:6000:565a with SMTP id 5b1f17b1804b1-4290af06895mr9038075e9.16.1723107283332;
        Thu, 08 Aug 2024 01:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWJ4lkTOOFrjc7T8g6GBCNwRTf30oI6KZ6AHA+AkMyd7AvN9j/5z8buc82mnPBC7mnhTpT/A==
X-Received: by 2002:a05:600c:4fc6:b0:426:6000:565a with SMTP id 5b1f17b1804b1-4290af06895mr9037905e9.16.1723107282930;
        Thu, 08 Aug 2024 01:54:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598f53bsm65213775e9.29.2024.08.08.01.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 01:54:42 -0700 (PDT)
Message-ID: <e8a73722-6597-48ed-bef4-34d7e145dd29@redhat.com>
Date: Thu, 8 Aug 2024 10:54:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] kernel/fork.c: get estimated free pages by
 memblock api
To: Wei Yang <richard.weiyang@gmail.com>, agordeev@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, rppt@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
 <20240808001415.6298-2-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808001415.6298-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 02:14, Wei Yang wrote:
> Instead of getting estimated free pages from memblock directly, we have
> introduced an API, memblock_estimated_nr_free_pages(), which is more
> friendly for users.
> 
> Just replace it with new API, no functional change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>
> CC: Oleg Nesterov <oleg@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


