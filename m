Return-Path: <linux-kernel+bounces-406373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC29C5E11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501C82815F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B8213ED1;
	Tue, 12 Nov 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkKG9iZ7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397B21314D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430725; cv=none; b=RIXukfn+DfCiM40Tt49wTKkVVLlpNaZ0o7IepA0pIuaPlcgViyAkcJHS7tFWT8/9IHssrKJx7CUaF9UMWWnRARZzGluVwoQrKVI5+/wrGqz1FVdNKm+pI/fL7+QoB43R/0i2TUr1TZ2hS4eaSD6om5xUKgdVTKAiTjlFaXTAiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430725; c=relaxed/simple;
	bh=HoxmzCT6mnj28Trnf1t4CyqZ6h/XARVGjiQMikKj4ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqzE0v0H/bOmCSkgKJlkcw59MTQD4ok3gZMUSiQxhMVvkFoh5IqtgMpldQkxLfY+yJW/lhc1oKdKJcDifqW9gTxsvvYVtHiEsOyz66gPNk1JGScS5KeduSfQtY1+dVzefJOFuFgh4jatCBnX/kpLz7vc4tUBhpQoDHZCUv/cp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkKG9iZ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731430722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9FaEMvbMjXEAnY/QQcdR8QO1T/C9D0TBGIj/rMfrLn4=;
	b=WkKG9iZ7gpwHsgfVNbIpgRaLqAQt0hC7rkMtIv9gwAkA6zYhrQvm8WgT5q1RcEmGdFFh7g
	qjF8WE+//NkOTo6588++dliwJwwxNlNZlOau5elHNep2CjpAwbHQjPrI/KJArlaWkoVHKt
	xyME7LP9Ifl1XbU6vp4W+QjNtc8kmkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-k9oJtS3oO0a7yUE00IThvg-1; Tue, 12 Nov 2024 11:58:40 -0500
X-MC-Unique: k9oJtS3oO0a7yUE00IThvg-1
X-Mimecast-MFC-AGG-ID: k9oJtS3oO0a7yUE00IThvg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso3850674f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430719; x=1732035519;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9FaEMvbMjXEAnY/QQcdR8QO1T/C9D0TBGIj/rMfrLn4=;
        b=B+Sv5evkewuqhAqi391ZFHxC1nvIFOUusoD//TpXtgb+iLFU/ifKtNyRWwBO7sVAkT
         1vpqs3sK+lImEn0W8hOUjZvN8D670lAm380IpDVq6ghsvZtBTS9Wh6WbADY8j1sBBNCM
         kdMzk6RN0cDmy+t6dTcbJ9yZ79odM35FCVSs2tZt9Qf9BXFDbbcy0z1thFu6pLAwjSJq
         s/9H50AgZwmWZaAh11HNjQqwzpzJ6PbGK+ZSwMcOwvI6+RIJoeyNNlamaA+gjUjB4sQt
         DQ38Qf7vyYa/pf9cgI6pnnwHbmrb9Bwj19Hhx23asLfHleYIdlkMG7jbEXqKMYg+pCzE
         BKMg==
X-Forwarded-Encrypted: i=1; AJvYcCUO+9X3X5KOB/bPCiXEMicqGH9vOLGnNsWHAJJ4I3n9ZbNgdRBHuNGXxi8piI72k6jVnOBTnMhAdaUrnnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyvz20PgMgOSah2ahcuJ4M6GHzCUzzWxHADPYfTf0CtRFWUugh
	RaoI8CrksDPf7EUzSrym2MTraZ3Lch+WGlY6U8hYv3Pv7hpgX1ecyQl0n3XmgZcJvPT2A3oKcAN
	/rvog/3gCvZiPm9RkwauBNl2joPZnLymC7raE7/9+ra8Ll7XB+XGvCX9gPqpoKw==
X-Received: by 2002:a05:6000:4605:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-381f18673c6mr12611295f8f.3.1731430719469;
        Tue, 12 Nov 2024 08:58:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlITkqDf7VP2Sw0yQoTtVIl0tkRy4bdXZ1v7tibUu6XVe3rmAStjPURbL1ibPKd93g2+wEWg==
X-Received: by 2002:a05:6000:4605:b0:37d:5436:4a1 with SMTP id ffacd0b85a97d-381f18673c6mr12611282f8f.3.1731430719141;
        Tue, 12 Nov 2024 08:58:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm213500835e9.17.2024.11.12.08.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:58:38 -0800 (PST)
Message-ID: <5dcea9d4-a2eb-4704-96fc-73273e94a370@redhat.com>
Date: Tue, 12 Nov 2024 17:58:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm: introduce zap_nonpresent_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>, jannh@google.com,
 hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <34ef26a763af7b2d8dee707b6f60ff85edda345f.1730360798.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <34ef26a763af7b2d8dee707b6f60ff85edda345f.1730360798.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.24 09:13, Qi Zheng wrote:
> Similar to zap_present_ptes(), let's introduce zap_nonpresent_ptes() to
> handle non-present ptes, which can improve code readability.
> 
> No functional change.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


