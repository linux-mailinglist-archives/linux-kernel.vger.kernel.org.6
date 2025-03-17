Return-Path: <linux-kernel+bounces-563869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8AA649F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2613A3E43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715423A98F;
	Mon, 17 Mar 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIbwQzri"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0322CBE3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207049; cv=none; b=ju+Jza7rR2+UGbRn14E2ZXBBjuUwX+ZQmSGHtwO6d16F3X5Fq5sr2uuPVQ6piyO34Tv1EcnNnjQp+hsmIlXxcoglDU13NDamhjhPVXnFTPO2g7m/IkjKPNeVA4JNd1WzSc9JFKX7NvWUWcowE8ofZAuvHleAcmnbgAD7uXm+/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207049; c=relaxed/simple;
	bh=bCANhreDkENKAEhk4KUIB7Cm7ZYifLCC60fKPlqYwAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inCHXgo9ShVAKkUbU0QeNTeHbWrQppRaFgVpnyMGzqOJ2xl3Dhu0BzCyNuFOgnVnaZPOUszLcVLYPJ4ubGusSUN+3GINM5jI4ckTPXed0nfuiX06m/nChjqyrlp0qHQD+VgFQBjeK9xGW0Z3d8cXI9xFzdgoV8D+2WrkLkC54ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIbwQzri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742207046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Oam/KdpgzWcAfFC8T6sIsWCKibErh7/9y30vLrSIxs=;
	b=CIbwQzriysLZj8Y5vUrX55aYRx19VJN5XsVFbZ4ffhrhCPTOz9DyFnRxukX/0yO0mSq8BU
	zNfKW0GW8mcC2TLNvQ1ZmyQhgl/QmeCVipRB2AkUYLh6UEhT4gvGJVdi+yxwhC9PrRg9tO
	Jksvyb7R5W5QcOJNFJtRqlXwc17eKgA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-SfIb3absNMqhVUBHvKeVFA-1; Mon, 17 Mar 2025 06:24:05 -0400
X-MC-Unique: SfIb3absNMqhVUBHvKeVFA-1
X-Mimecast-MFC-AGG-ID: SfIb3absNMqhVUBHvKeVFA_1742207044
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39126c3469fso1921592f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207044; x=1742811844;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Oam/KdpgzWcAfFC8T6sIsWCKibErh7/9y30vLrSIxs=;
        b=YcIsTLjCK/acRJnvuDkumY5QiToLrpocw6OadrW1Mvw3pLeRGpKcLqLIx6a5ZGLeKf
         IyOKczSr6ND1fW489+O+2+GxacCvMwxtr4TXzv3UgPSLI0edvRa8HQYUmxYbsFS2aM9O
         syppCDcP7bya3+k/xGW/5ZHmXnIKiWcQKxMyvVxE1xHYdAIzPxwhcSqC4JU5SDVbRBPB
         N9DRnyfHK8Jqte7OKvDqKX219Arh8eShJlC9EPiWecVbsJFH07RdA9RPKlUgDU8VQspR
         y+Ply2KXjHrnaJyCmwqFm48IAMagIIAOQrXn49SkPag74IqIcgkDGAvoFMT7U/6nL0+W
         WM4A==
X-Forwarded-Encrypted: i=1; AJvYcCUL2mrF2I9AbdpSJdA2+0d3QojE2axaU5OHdp+tL/d9vJMVDRtVvlrGZ6myB/PAg1W5WNnj4MmwiQho28o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBO11mE3vKFegrH2RrzwDCyuuurECc2WsdoqCaUEFv05Uzfv9
	qwQXhyIv5V+O/WFuvviySLcayFfIv0VIGKvbHNFwgbnX5zTHvtWE2ptYKsFDUU83ar96y/8kGWP
	RmnqPfgwBwM3Qqt1NEpsA29K0//BsxIs8WSnnQDg5sxRGscWvddldK95UEN/BEw==
X-Gm-Gg: ASbGncvXypij5iDYXB93AdUd4t0LYt2fiIdQTpaXrhX72R5Lxv/0T3c7BifFpy+3HA0
	qJvZeniUDkPOCh9RJMgrHvsShGC6Pt5pak7b9S9eFufIxTQGinXVP7YwWz49INb99tK16M9/dZr
	5s0YYef8vMy452VZvHkdCPXK/2oNmARFWAf56/Y3iQxdMAkb7VX2pmH/Z/Yd2Y4dEHqYWSdOgDj
	uyDs6GuEhX8bCekhpVD6Kb3qOuFfRQpaiJjF4of69AM3X7nV66b7ZkmUCuAkrWSqxRxHvx3hVvD
	1a8JnXlLCimXkvuhxf36fJbiI19faUZ8EbVlzdkqVzT672dgVvs53neLjlkAx2ru+zV8NeGEr73
	DToDoR/qE73OFa6wftJzRaobpeyPAVNcsPA7fAVM09Gw=
X-Received: by 2002:a5d:6484:0:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3971ee444e2mr12570887f8f.42.1742207043969;
        Mon, 17 Mar 2025 03:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGMajM7qeiu3bh5YLRlaSSbWaTncb/O+rwjUnc6izvixZyxF3h6+ZrClNs4vCrS4tsu4/jMg==
X-Received: by 2002:a5d:6484:0:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3971ee444e2mr12570860f8f.42.1742207043616;
        Mon, 17 Mar 2025 03:24:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1? (p200300cbc73caa00ab006415bbb7f3a1.dip0.t-ipconnect.de. [2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaf8sm14854833f8f.95.2025.03.17.03.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:24:03 -0700 (PDT)
Message-ID: <a43ff37d-497c-4508-b6e5-667e060908cc@redhat.com>
Date: Mon, 17 Mar 2025 11:24:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/proc/page: Refactoring to reduce code duplication.
To: Liu Ye <liuyerd@163.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ran.xiaokai@zte.com.cn, dan.carpenter@linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250317100719.134558-1-liuyerd@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250317100719.134558-1-liuyerd@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.03.25 11:07, Liu Ye wrote:
> From: Liu Ye <liuye@kylinos.cn>
> 
> The function kpageflags_read and kpagecgroup_read is quite similar
> to kpagecount_read. Consider refactoring common code into a helper
> function to reduce code duplication.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> 
> ---
> V2 : Use an enumeration to indicate the operation to be performed
> to avoid passing functions.
> ---
> ---
>   fs/proc/page.c | 166 +++++++++++++++++--------------------------------
>   1 file changed, 58 insertions(+), 108 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index a55f5acefa97..66f454330a87 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -22,6 +22,14 @@
>   #define KPMMASK (KPMSIZE - 1)
>   #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
>   
> +enum kpage_operation {
> +	KPAGE_FLAGS,
> +	KPAGE_COUNT,
> +#ifdef CONFIG_MEMCG
> +	KPAGE_CGROUP,
> +#endif
> +};
> +
>   static inline unsigned long get_max_dump_pfn(void)
>   {
>   #ifdef CONFIG_SPARSEMEM
> @@ -37,19 +45,17 @@ static inline unsigned long get_max_dump_pfn(void)
>   #endif
>   }
>   
> -/* /proc/kpagecount - an array exposing page mapcounts
> - *
> - * Each entry is a u64 representing the corresponding
> - * physical page mapcount.
> - */
> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
> -			     size_t count, loff_t *ppos)
> +static ssize_t kpage_read(struct file *file, char __user *buf,
> +		size_t count, loff_t *ppos,
> +		enum kpage_operation op)
>   {
>   	const unsigned long max_dump_pfn = get_max_dump_pfn();
>   	u64 __user *out = (u64 __user *)buf;
> +	struct page *ppage;
>   	unsigned long src = *ppos;
>   	unsigned long pfn;
>   	ssize_t ret = 0;
> +	u64 info;
>   
>   	pfn = src / KPMSIZE;
>   	if (src & KPMMASK || count & KPMMASK)
> @@ -59,19 +65,29 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>   	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>   
>   	while (count > 0) {
> -		struct page *page;
> -		u64 mapcount = 0;
> -
> -		/*
> -		 * TODO: ZONE_DEVICE support requires to identify
> -		 * memmaps that were actually initialized.
> -		 */
> -		page = pfn_to_online_page(pfn);
> -		if (page)
> -			mapcount = folio_precise_page_mapcount(page_folio(page),
> -							       page);
> -
> -		if (put_user(mapcount, out)) {
> +		ppage = pfn_to_online_page(pfn);
> +
> +		if (ppage) {
> +			switch (op) {
> +			case KPAGE_FLAGS:
> +				info = stable_page_flags(ppage);
> +				break;
> +			case KPAGE_COUNT:
> +				info = folio_precise_page_mapcount(page_folio(ppage), ppage);
> +				break;
> +#ifdef CONFIG_MEMCG
> +			case KPAGE_CGROUP:
> +				info = page_cgroup_ino(ppage);
> +				break;
> +#endif

In general, LGTM.

I do wonder if we should just get rid of the two "#ifdef CONFIG_MEMCG" by adding
a stub for page_cgroup_ino().

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57664e2a8fb7b..24248f4dcc971 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1788,6 +1788,11 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
  {
  }
  
+static inline ino_t page_cgroup_ino(struct page *page)
+{
+       return 0;
+}
+
  #endif /* CONFIG_MEMCG */
  
  #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)


-- 
Cheers,

David / dhildenb


