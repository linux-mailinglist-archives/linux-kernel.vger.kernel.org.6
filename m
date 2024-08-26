Return-Path: <linux-kernel+bounces-300848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1920995E93A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C566A281632
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625F82488;
	Mon, 26 Aug 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmRdLM65"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0CA4F215
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654947; cv=none; b=cn6r8La2cO8BJ3YvVPDZOt2/PcvF1fKgfcm8Mml3gXzISGLpV/fZLt6qVpc2fSpwd/Ohqpv5UAUc9bGDivyC5gUkXzFU337O3FmtdlVJxIVZoq9mmdFtu1O74K2vAdVV0eidjcXChjG7qX7M0Q1tVNifC7i7JcRjaLy7oMsdYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654947; c=relaxed/simple;
	bh=mDQo97VOE/AKv6ADGeWuwy/oXdqzO3SUO0ppXXxL6Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdEaJrHfXr90PDpYR1d+wzBczqQUElhyeMtW10San6ISRXVtlby8ONgYkY2kcwOtpbcxbqWe6KF4qiNxbJiC5AKSgtxjYFJH3On/UUiuLx2/HWnNXS3WT4fu5qhPhEdAwE5biz9Vhn+xPROv9v1bMq32UCdyb4zRK4mZ/9TWfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmRdLM65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724654944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9Za28ARncJb1ft6Y96OOTZ2p3gpMLY9nzc40/2R/vK8=;
	b=dmRdLM650qJSRrY+WYWJLjl5+VlIknDZuoRRwCrwVegFJ+NDPUvQrRHIJNNeJxjFEttMWE
	jZipEdJU6Q4L5RLOaRC7sh2BXkiBjjUqPUkdoct8CS4A/wveYFvfR3/ty9bedbjgB5yELc
	9BWggjlrYX2P9buuFjRjA/fM++xkEOw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-7q2Y61s3M_Omf5i2NHq_8w-1; Mon, 26 Aug 2024 02:49:02 -0400
X-MC-Unique: 7q2Y61s3M_Omf5i2NHq_8w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42aa70df35eso44912555e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654941; x=1725259741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Za28ARncJb1ft6Y96OOTZ2p3gpMLY9nzc40/2R/vK8=;
        b=XMkoaqaWPDi8ayU8GVXasZOLh99UX5b/gpyvfBHKs5F2ik8p7/cvz9AU6RiCCPgP7e
         a0ZXPxWKVbR1rPVY6Ytwb3MatBwYjm6Bw2vM8O215l/IG41rZklNxOiVdxzyfUtc/pfR
         7h3AcckeDoCTKqQIpTpq45pkMPgItERpVnbQNk8bBEYIxoRFkroyUmrag9OzordmsqFD
         Z/O3A1yqDtwcB0h4v3fWEd2wmYJ8nzh8GOowEw/HSNWCrV6QLw5GxfoPlSfE79MLR2TU
         WHpnzmzk7Et3OKTQc+A2L4Sppjl9/zuEvbsvFn+CaXdmztZkv4QkEcSmRjX+0MfQaffC
         4yZA==
X-Forwarded-Encrypted: i=1; AJvYcCUDbFYjjZ8BuzaNSFxh14gQb/36BN1VWkNCgyg7m1cRPqj5llTQBr9kPDRCdLt6pIHzKNyuSOVacXzZbJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFnZBPzpUFjvfy+0nADm9PuQ0LawimgCL6qpLizLP+1VFcp7l
	xRgV/kc6i3OBC3SPWx3BObF8B/35TvpLyLGpMcXw0WOvLO9G/1WM6Qz69uo15G0YVC4s3MpYUVW
	HmxJV4CoxMfeP3P45oILSG0d0pRiG7d+zFMZGoAWTfpkIyhlHh9ghPRGhTQiy/w==
X-Received: by 2002:a05:600c:450e:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-42acd540cbbmr76895785e9.3.1724654941593;
        Sun, 25 Aug 2024 23:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFruCCuhufOKQsvLCK8uxlZk8YfAkrjSPcqh2CDp51XnShl4zepD0E8tfxFKkbWIS54+kVOnQ==
X-Received: by 2002:a05:600c:450e:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-42acd540cbbmr76895555e9.3.1724654940728;
        Sun, 25 Aug 2024 23:49:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:c800:cf71:2042:6051:e26? (p200300d82f12c800cf71204260510e26.dip0.t-ipconnect.de. [2003:d8:2f12:c800:cf71:2042:6051:e26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac935211csm126624775e9.47.2024.08.25.23.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:49:00 -0700 (PDT)
Message-ID: <efeee548-fb6f-4670-880b-f0837614b5cb@redhat.com>
Date: Mon, 26 Aug 2024 08:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix minor off-by-one in shrinkable calculation
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <d8e75079-af2d-8519-56df-6be1dccc247a@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d8e75079-af2d-8519-56df-6be1dccc247a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.24 00:42, Hugh Dickins wrote:
> There has been a long-standing and very minor off-by-one, where
> shmem_get_folio_gfp() decides if a large folio extends beyond i_size
> far enough to leave a page or more for freeing later under pressure.
> 
> This is not something needed for stable: but it will be proportionately
> more significant as support for smaller large folios is added, and is
> best fixed before duplicating the check in other places.
> 
> Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/shmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 85e3bd3e709e..37c300f69baf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2326,7 +2326,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>   	alloced = true;
>   	if (folio_test_large(folio) &&
>   	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
> -					folio_next_index(folio) - 1) {
> +					folio_next_index(folio)) {
>   		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>   		struct shmem_inode_info *info = SHMEM_I(inode);
>   		/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


