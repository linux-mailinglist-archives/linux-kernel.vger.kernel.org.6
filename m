Return-Path: <linux-kernel+bounces-449148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD4B9F4A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1CC18893B8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7791F03E7;
	Tue, 17 Dec 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+qCglS/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C51D5CE5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436752; cv=none; b=UMKfWtlq19AkKNQjFK58yElI1JR3J/d2GvbQP1SbA4i42mDoov0t+b1q5R2v3/nM5nX569HpcHDzZhNE53gonKnSlr4pnF8dHuc46Ey7Tc/Fn17RmwXHPV3h8xTnWSRfgFwUPQ/aHaaSvZJXnlGhhWHSjqculsCHQxGWQ5Au++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436752; c=relaxed/simple;
	bh=kGlQCcotvigSdinL/s6RbcfyO+9v40wFoH3i1xv+1/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GL4Zs7pvw8zV7NlDjqeiyY1nrrEOGLDWi290iO1dV2OfEgKuuxrr6uwptCn3gGVMuXRXz5oC35eyOodsyYKViKybNQOV/Li7f/HQOcCqbICMtKJvBSXn3uPHuec+yW760g1t87p1lp2OckWxgAC7RttQcWR2m7yNsCx3tD9cLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+qCglS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734436749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8sWRpdNZgctGTHu3KqQVRpinwJ/Y2z2MprvlNUN+8tY=;
	b=i+qCglS/P8I1eb9oOZCPA6DOy8trS9tIDJw3LRl1M8hN6W1mz9/euiGIxBZlIYYy5KBLt5
	BUwb2QRIwz4R3sWc2Ux1kkxW5q7cYof2nX5x+CdJnoUHYykL+fp/v6tDwlKHWtkG5GPMmf
	CF/QvfLmbZ9r5RqFaacgwb1/sxWVJ10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ySI64bcVNUKedJTeN0gDwQ-1; Tue, 17 Dec 2024 06:59:08 -0500
X-MC-Unique: ySI64bcVNUKedJTeN0gDwQ-1
X-Mimecast-MFC-AGG-ID: ySI64bcVNUKedJTeN0gDwQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so23293675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436747; x=1735041547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sWRpdNZgctGTHu3KqQVRpinwJ/Y2z2MprvlNUN+8tY=;
        b=rNHOefMC1Dbu+dN96OCqCDAOj29LYyAwY0Ogu39R89+TE4qOuex9yH68Dmf0V77gI4
         puRXxe/nPKt5TYqx4BhI8iYqc2wFqm5Q7gmJalo4dXiiNrqmpHBjb3AWbf3+uDMizxnv
         ZSKEWkJk2taPfAnO5Zzx6V4TGa6cG87V8fUez0IEQBFAW9eCOtQfdF4tvWm+Vhg2cgUp
         QMUocQOFF1fjxsT2kYJYbjxeEUWK2f8BtUgs+OjJJokpzHcN/sRor15yB1ujoDyizpKE
         NspfbctLKSJip80lO5Z563syEJ4Is8Ei+4uKkdOz6Ms/2FHKJvKYTokNLq7pq70tSJet
         7+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3GeCte0wcdM2uAfJFR5LqxiEWFLlrwuO60JhxLdsZgbXuQu1cTSqlx5uvprjGrTzF32dN2pN6ujEjnsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uytY43msD+cbNs4GN/iFLYKq+AAoJEBJCgy9VeLyHmu+js92
	ddwFLycTwvszXEptzayfxBhizGtBrwepSyLlKDveiz+F+iNZtbwrR8+CrgwDGxKHl6iRmA2rN5Y
	Oc/s/adNTMJHyFfooNGNlTiFCEP7Yo+CiywD5Z5LAfowljJ/U+ac4UOEH44y02gGdM+TON+gX
X-Gm-Gg: ASbGncuVkI+8pwDNkPsjbqv9IBLNiSr4dFyHP2/Yq08wAUbF2Lc6cZCx0nTR7Y7Nkv/
	3loLQqcfizf0uHXfoL9Zh6cnGXr0ILPOZrOLXdCiYhEGoFbSuoieNkGlnqgZYJIUTMlA5k9zglk
	plsLmbITGOkEFrtGMmGh6s5RX6Y9/E1aTETGjWqS95Ot6rGkcPWPLirNsHokTGnLa3qAjWZmOkx
	BcP20WJzNL6MFb/3Nu8WJxFtqtZaNZzkE6UTBoB0ZU5zWemHqryQJWDc2j2PtcJjBxcxNiUN8nZ
	7/yD7OuYfuMbw1I=
X-Received: by 2002:a05:600c:1c82:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-4362aa6f39emr152766385e9.18.1734436746979;
        Tue, 17 Dec 2024 03:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW71De1Rdm0MC1KPUPjb0xlpbR4pUE3qOiFK4KjUPLhPG6y6+QDiNPcSNR+Po+/ZC3wLkw1w==
X-Received: by 2002:a05:600c:1c82:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-4362aa6f39emr152766125e9.18.1734436746595;
        Tue, 17 Dec 2024 03:59:06 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706cb9sm173561245e9.27.2024.12.17.03.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 03:59:06 -0800 (PST)
Message-ID: <dd96e6d4-b8fe-4360-b6eb-f6375df9eaf2@redhat.com>
Date: Tue, 17 Dec 2024 12:59:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: mm: fix the incorrect 'FileHugeMapped' field
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <d520ce3aba2b03b088be30bece732426a939049a.1734425264.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d520ce3aba2b03b088be30bece732426a939049a.1734425264.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.12.24 09:55, Baolin Wang wrote:
> The '/proc/PID/smaps' does not have the 'FileHugeMapped' field to count the
> file transparent huge pages, instead, the 'FilePmdMapped' field should be
> used. Fix it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 156a03af0a88..dff8d5985f0f 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -466,7 +466,7 @@ AnonHugePmdMapped).
>   The number of file transparent huge pages mapped to userspace is available
>   by reading ShmemPmdMapped and ShmemHugePages fields in ``/proc/meminfo``.
>   To identify what applications are mapping file transparent huge pages, it
> -is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped fields
> +is necessary to read ``/proc/PID/smaps`` and count the FilePmdMapped fields
>   for each mapping.

We should probably change the above to clarify that this is all about 
PMD sized things.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


