Return-Path: <linux-kernel+bounces-235874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2B091DAAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2371F22FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70487155A52;
	Mon,  1 Jul 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ft1Wn9T0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9715572D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823876; cv=none; b=kVyraz/2tnfkst/AykL4u8G/c7lT/IjH78fnHiWmrDmosFil8xWxEC5l+gapdjBU9xTDreqVWrAhDXUJgOyqpO1GYYdfWWUYCB7VRK2rtTC1wDtBbksXBSVm7MZZVTJVuVo1pOsuq+YEmsRX2bTc3sTJ5C8ZBHDrCdXCVYN2bbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823876; c=relaxed/simple;
	bh=pv5z3h3GJ3bX8KpKces8qLwgZDP5k02EwW8KogP8qF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6aqx5z23l9n6IerjFHdxKPpumWC/t9qLAqHHnYcGwlrc6xTy4juPIjL8zV/OA5rBdhjCYhhDZSto1yf6QKpJcgmBUSopQe3bkJgXWg0f4O6xg+gkQqjlNF45r4vPAlFfSeiCpeOdAzAI/Oi2Y7ij/irLJZbhXT6VRijG3/JBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ft1Wn9T0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Dwuh31FWXKFETeVE1bIi4aG9bVbhfrl9UVZK40+cBU=;
	b=Ft1Wn9T02dZSW20SwDono6WhQGSy5/ICxZ6TxBDUAHGJwqf+66u01oG9Hy1DgAIJaj+W5H
	I14EQnLaUr0AGL8SLT0+QiN3Y26Aq9dCxxR9MYzoQVyrtPAzPOdOoF6sxnPKNhoYxM9LJ4
	NiGRG1aEO8LqutKU9ctUJM3Ae4nawxc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-bYAFG5LbOkaC8B3a4ytF_w-1; Mon, 01 Jul 2024 04:51:13 -0400
X-MC-Unique: bYAFG5LbOkaC8B3a4ytF_w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a72b3066669so344775666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823872; x=1720428672;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Dwuh31FWXKFETeVE1bIi4aG9bVbhfrl9UVZK40+cBU=;
        b=BofWE88d7fl3n0x4AdpdIIM6HttVafrj3NEr6BENv+eXcbV1lvbtm6BABBdHYtQ/AU
         yXWmC8OjsKXNzL1x87+sAeUQ13MYB8d3nTp9UVc0kHuHLldu0nMylli7rnRBT7NXL4Dk
         kbCRTtFe9etll/wXY/O/jjIGlOiM8hkMvzW//crLdDOFkBP6HqgUb9je1D2IbT/tgdag
         SNUaCTC2WEdGxbBOmZTVZ1LW3PYkZuqUy5hHE8P7L5XMWc1OGGrsDoNHWwr9QYKslS4i
         JBz/DNgyVUBAoaZbz0k3yw280Dlk29u0gg/kspfGAeIIID+aa7qoq3W2wMH77xdcqjHH
         eUow==
X-Gm-Message-State: AOJu0Ywd8Md+Sn1vcirUd088ewL40lWYpmkTc7TsuHrISYu6oeXGwo9H
	pbjpGwjWYN7vikefuFBq2BD/JqZzEBwZkmMC5maFVYbT1rSMxF0pfESUKa0/fYyNoUUqtG4g7Iv
	xEtiswjNXmXhhbpEg5cWAQtDsbLr+Df/mrlxRUyROhmGnaXoY6ExZ00jKtlOGcw==
X-Received: by 2002:a17:907:3f29:b0:a6f:6df5:a264 with SMTP id a640c23a62f3a-a751386ec5fmr488694466b.1.1719823871255;
        Mon, 01 Jul 2024 01:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYvD40tgD05VnEwmXz0XcpYx3ec+54nXSBpU3yVu8tlzKFZdfjFxO8yOk+ow1/wiXC0tObSg==
X-Received: by 2002:a17:907:3f29:b0:a6f:6df5:a264 with SMTP id a640c23a62f3a-a751386ec5fmr488690666b.1.1719823870372;
        Mon, 01 Jul 2024 01:51:10 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1846esm312641266b.38.2024.07.01.01.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:51:09 -0700 (PDT)
Message-ID: <81d768d4-6d37-4d73-a1a4-39950a663105@redhat.com>
Date: Mon, 1 Jul 2024 10:51:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: drop checking if _deferred_list is empty
 before using TTU_SYNC
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240629234155.53524-1-21cnbao@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240629234155.53524-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.24 01:41, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The optimization of list_empty(&folio->_deferred_list) aimed to prevent
> increasing the PTL duration when a large folio is partially unmapped,
> for example, from subpage 0 to subpage (nr - 2).
> 
> But Ryan's commit 5ed890ce5147 ("mm: vmscan: avoid split during
> shrink_folio_list()") actually splits this kind of large folios. This
> makes the "optimization" useless.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   -v1
>   * I remember David and Ryan once suggested that this check could be dropped
>     while the patch was being pulled into mm-unstable. However, for some reason,
>     I forgot to request squashing this change.
> 
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3d4c681c6d40..0761f91b407f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1291,7 +1291,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			 * try_to_unmap acquire PTL from the first PTE,
>   			 * eliminating the influence of temporary PTE values.
>   			 */
> -			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
> +			if (folio_test_large(folio))
>   				flags |= TTU_SYNC;
>   
>   			try_to_unmap(folio, flags);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


