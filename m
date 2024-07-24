Return-Path: <linux-kernel+bounces-261063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6293B27F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7CDB22F49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE31159209;
	Wed, 24 Jul 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9XAcHWQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A87613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830404; cv=none; b=uZkLlsaVJNgUCaia0/h4sic8/uYX7/eMFRrJokpH58raSLe/09fIcBy7et7XbY6Pu4BFkm9GAiuXUsb4G7dDC5Xr7olDlkWoLhP+JUMu0BF8ajkiU7hhDwLK2Zp1fsbKZKNgegassGRQ0QlIW7udCGkKGtHk1WI+fO/5dtIi4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830404; c=relaxed/simple;
	bh=axOhgSN/h+4s8YNx3dU9fmqJiAgRy4X4sKYS4LwPnjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0rPFuXDv+HTAdj0YMrS44MGcTsrbWAYbMa2zaVCfxVwgGPbTo0zxdnfv0p9SZDRXsu0JjCuxTk7hdtYEblDum7cUc8MlrJy3arpwDLu1QDoU0GH+FOJEb4Cu1fIiXnB1B6SeB5yQKaByL0EaXa0xEmSLjGRcibAsCfMApPzPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9XAcHWQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721830401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+xtyyriQpPG2jOYEXncJPMO03t7UItOSKfTUpQm7Qq8=;
	b=N9XAcHWQeo1WoaBnVA5+zaQQpwwU29ATI57hHKQXR3yv/MZMhGJpGwDsf2iPI3XA+ODUR6
	/vPxTHG48s7EKcQlVJ6AqBf9A93PoHSjttaz7hOVD9sjbj15a7kBbkrGngelTAtlyk4lbz
	60DH60j3B4mapzL20GEoY1BzfrMZVv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-iDdFiqMEMC6_7OD4CsuTAw-1; Wed, 24 Jul 2024 10:13:20 -0400
X-MC-Unique: iDdFiqMEMC6_7OD4CsuTAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280291f739so1061305e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830399; x=1722435199;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xtyyriQpPG2jOYEXncJPMO03t7UItOSKfTUpQm7Qq8=;
        b=fHksPlaa+FfWhsRg9A59QdgUpDtUIn1v1DY/iosWi54VaR0BPwIjBlxUu68DVggU6j
         swqco7uG1v5aDF+7WrAqC4afkKR+Q+3T0AkSht9osQGdNpLDwwf43WxBbDWT3TE6Zqz3
         uw4E0bQQ17o0keCxY6Pis2NrQoVcSQgGm6JdVLelSc1aNiC/FpfIk/AoAMEWXuo7OGZr
         HmfVn7ArGR+5z65+ENMC/G4tJccaZMsLyxJXR97uXxl2guCZQG1oTdf9O2im1K/ZUvPi
         QlQF/c9ZWIrA7ze25Y33tDv58kZpl587EM04gb/wElE2lvAT5TyzXywgwqsRWOh3f4B9
         ZOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdj7y0mR3vFuPRAcaF17KdBGawnbtJEKS1GOSK1uzDsRoN0wNLe2f+ErkDk8tVuYNjlG+07T4afDHRo/FzEbaj7TQUHZlZ0D6/u/xs
X-Gm-Message-State: AOJu0Yx89V2A+IvrBHO6eZlVSKRfPu+71y9yV1IYv7sX7JwrQupZO3oW
	n1snCMMXYEktXZm5AT4TiZqbna8c4o8fCsI8nERbDS0SXVCwmO8hOJHdSY8lS3X3I04/WYa9cxk
	xJl6iYL3uX3deiimWPNBkO0J/WqIZfv+psIjNnyKUYGznIhwfRc1KZeEL4pfwpg==
X-Received: by 2002:a05:600c:46cf:b0:426:60e4:c691 with SMTP id 5b1f17b1804b1-427f9558e51mr16010305e9.11.1721830399033;
        Wed, 24 Jul 2024 07:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxN8I+cLfhjN1Kmb+nXATIfbf4aIdralVK5ICkoeMlRtaUjf2dwOGDJhlToye6cS5E9mKx1g==
X-Received: by 2002:a05:600c:46cf:b0:426:60e4:c691 with SMTP id 5b1f17b1804b1-427f9558e51mr16010035e9.11.1721830398604;
        Wed, 24 Jul 2024 07:13:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:bb00:201f:378f:5564:caeb? (p200300cbc739bb00201f378f5564caeb.dip0.t-ipconnect.de. [2003:cb:c739:bb00:201f:378f:5564:caeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428029e32fesm4607205e9.25.2024.07.24.07.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 07:13:18 -0700 (PDT)
Message-ID: <f82d58f6-4549-4f74-9bd1-0507d2e1afc1@redhat.com>
Date: Wed, 24 Jul 2024 16:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] memory tiering: introduce folio_use_access_time()
 check
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org
References: <20240724130115.793641-1-ziy@nvidia.com>
 <20240724130115.793641-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240724130115.793641-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.24 15:01, Zi Yan wrote:
> If memory tiering mode is on and a folio is not in the top tier memory,
> folio's cpupid field is repurposed to store page access time. Instead of
> an open coded check, use a function to encapsulate the check.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---

Yes, that is much clearer, thanks!

-- 
Cheers,

David / dhildenb


