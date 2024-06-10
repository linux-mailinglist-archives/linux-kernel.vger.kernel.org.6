Return-Path: <linux-kernel+bounces-207849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AAD901CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F54CB23B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19C6F2E0;
	Mon, 10 Jun 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6UVlnOD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E641A87
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008252; cv=none; b=cyvC3Jr7fRZvic2m2tVPJSviQW945naTdZJBK1pwCLlG6+Jmqi+tGDyr0qfPJobnv9MPqpjNjS7LdqWjUXJ46zu3y9cioZAc/233OPldlPArz+kvmiBy1+ZL8cYLFtfPio98t1VEYJIhLZT2LL5oIfXW6JydZOqPqxtHc6oDu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008252; c=relaxed/simple;
	bh=svfRBCIa2houkuknkHtvYQ7IFXuHok59bw5okyu6P1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8y4gcPHXN9ohD2XhN/cU8gtzuf0U8By/PgtXsv9TuQ4kDGj5kBmn/WIMjAsXdv8rfz5ghj2Ddbqrs0uTQ4fEfuCrqdNpumjw4LyTl0Sa9GBBVAvai5m+G0e2Xy6zUAvt6IK/ZbWoAV6LZytCxjNG8jOPvTTdE3KC19u6saha1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6UVlnOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718008250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iL+OlEgwFsIAfF2aQMuTl+nq7e5pafaDKMqKHtmAfAU=;
	b=F6UVlnODClJQAdcpVvM71ZNplEHsEDUZnf745ItPMhHu5+1uWF6lfeJjnald/PavYPgXEu
	0uwZlUMrbp+091syGaTo3AybVoodUckTvzy+BBF3s01CxjG0b8PPCdcW6SSZsgDk9G57gI
	/KqImZTCSSdWTSUHOgMfNLjggpaawzM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-h7af-k9CNdS3wQFyskPbag-1; Mon, 10 Jun 2024 04:30:45 -0400
X-MC-Unique: h7af-k9CNdS3wQFyskPbag-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f0d66bed9so1390539f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008244; x=1718613044;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iL+OlEgwFsIAfF2aQMuTl+nq7e5pafaDKMqKHtmAfAU=;
        b=Ze329D8kbRaQnzdK/pVMQtBDQD1VkVRGBO2aj9wwu1xOyGiB0iwkIQ5zITA4IJfD1/
         tg/nqN3Z7AGL0yOijSQOp5GNlkTtjZsfNZ7U4O1I4cXDWyzaW39s14KMymuMYnbxiw6S
         lSWPjTS9TOfn4s4L43FHLVUflRRGx/q3layOGRST7oFSOlelNK4bPCyVI65JvWdxwfCv
         u8eRSmP4zhGySWdWTT6x9oNwa60DgEdH8yGA4/m9kgcIhljjO3nbZJc2s6UbagyTjqSj
         UqbALnb/geRJxrjx2YyoQAnwkTrsYpjdqEPkg6bwMMkKAy+nFm+BRp989e3p8SAozrTH
         LHHA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GS0Hdjl6KCZCSCrjGjLU7FfaJBlVsy0pum/DKESmPbiVx8m6kFoWWP4TTY7ijbPbNeQcq/6v8UoqSS6JRfjkVCCT5BBGulp6Rtqe
X-Gm-Message-State: AOJu0YxLXHfcwlTnBM46FE5G+iTMRWwRx14M+fXuHR5jv19JZxM5vpLQ
	aftOIA4BTzNCDbrnitLZwG/2puj+xAIORLJnXVnPpFHFIIVyIz+jzIPOK+iGd2dlQj/Zq1ZVOxN
	m/iwAeGeer9qttXlNWC5cEvyVFX+nQXG6fPJn5xaU9XzSY3+F3efofOar/+/CKg==
X-Received: by 2002:a5d:47a9:0:b0:35f:283e:dae2 with SMTP id ffacd0b85a97d-35f283edb0amr524522f8f.48.1718008244157;
        Mon, 10 Jun 2024 01:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIPxwrflpo0HBRIJ12Yi8sKQ1blcOipw8EkVSkJbOseyC7hyUqnGGLI8NQX0dvoJvRjTCOHA==
X-Received: by 2002:a5d:47a9:0:b0:35f:283e:dae2 with SMTP id ffacd0b85a97d-35f283edb0amr524491f8f.48.1718008243530;
        Mon, 10 Jun 2024 01:30:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1bcbc31bsm4747474f8f.44.2024.06.10.01.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:30:42 -0700 (PDT)
Message-ID: <9e8a9fdc-ca30-4e11-89fa-d18dddccdd31@redhat.com>
Date: Mon, 10 Jun 2024 10:30:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: introduce pmd|pte_needs_soft_dirty_wp helpers
 for softdirty write-protect
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org,
 minchan@kernel.org, ryan.roberts@arm.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org
References: <20240607211358.4660-1-21cnbao@gmail.com>
 <20240607211358.4660-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240607211358.4660-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 23:13, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This patch introduces the pte_needs_soft_dirty_wp and
> pmd_needs_soft_dirty_wp helpers to determine if write protection is
> required for softdirty tracking. This can enhance code readability
> and improve its overall appearance.
> These new helpers are then utilized in gup, huge_memory, and mprotect.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


