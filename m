Return-Path: <linux-kernel+bounces-171180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9258BE0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46896B26EED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4F31514F5;
	Tue,  7 May 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awMh2JaT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F913CFAD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080406; cv=none; b=CqANu/JeYbUQ76qoUIO49PsYr5yCjZAa6nkSCF3M0KwkBCxFBfc2/kNgIWLL9uLVW8l6luIEI8AFiQaGkowm3GBfvIdA4rKu76AK6yRhgm6h0ax5Pk6jUqymBM4xc+1ljxlkK//96fbQ5J2feF8oDO0bP6YU9Zfkg6+8YGGa+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080406; c=relaxed/simple;
	bh=+dz9VZ4aO2jR0Kk/Po9Ht/G3AkuP89QGYDqUoCP2rqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0JS3boeyaRFEjYwlH4Ag55RQ7Sl8A5J33dP3or7sEpEyPIZ+M64uuZ47JC/BtOkJx5Ksh91Xjn8zWezsabhsn4iksQ0VL5wv7Q9dhh9l/28csIlqa2R+NOh5ZH2xgoFPnGCDJSFk1y6KqydyHjXxx8rmqhT+rvL5eDwI7d4Q5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awMh2JaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715080404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YQm3u/vQwX3jHOkAQZiWmCyY0GN6TydX2Y/zFgFUYpw=;
	b=awMh2JaTnX+Wx99ewINu53cH4QqJ8pVwxnceAd3wyy4UpvFy1lGbCMsA3w77fsO9DJXuRK
	hmhOGlNxJSqdNpSpQKGt1Dk9eA5NfG6PuBapr084PjHopKRdwKx2fIfYQLEs35Kopf+WRI
	Qel0CR6TB2Q1OtUixcn7LQXfgZTd5S4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-23ZrkO3lOUiWs-A_z0umuQ-1; Tue, 07 May 2024 07:13:22 -0400
X-MC-Unique: 23ZrkO3lOUiWs-A_z0umuQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da4360bbacso381081239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715080402; x=1715685202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQm3u/vQwX3jHOkAQZiWmCyY0GN6TydX2Y/zFgFUYpw=;
        b=jWDP0ktf45CqE+z0NgWX5T3IWmi4kEMNdxaB00VRC8Mjex9eKo6kCU63Zdtxw5NKt9
         1i2GDCwJgnMUqfWTYgtgY4aymUYrO2XNWlLP00Nyj/WfnvOFli4/m1osF0utW/Ty3BTp
         lKQlacaCbxXKxqamUDajeAAyJ9Zpp/AnoDIhovHF4hIsMe5hplwOcCby1ilZo23o2dMg
         l6/Xee0huGCNJ/y6lL7Fip/RYEIw4YZjcfvgRO9p65w1ltNRKY91oBucUxTeoFgoYeFS
         gGu9tEmy2uzIKXqsusxdjFr1y4VnJ1XmJavDvc5pVCyTfW+ZYRgOsPYzjIdvE1Tn+DtP
         3C/A==
X-Forwarded-Encrypted: i=1; AJvYcCVq7f6dUOMPAw0VOmjv6+0UUMm1ttKENaI+BpL4+R8Ih1LTMWA82zsPmCEx7ZZv///myGttp8AhsnkoH79tm4Ii56etVcWGJhZiBbJn
X-Gm-Message-State: AOJu0YzOzviZtu8rvha4Kx5FAwI05fU2eqHaO6Q7ezxBMvhYln/Iaq/M
	8ijaZlixr7HLROYKZstTvoSVvBRQSCHaW5x5QZYwIRLT3av28zTOdOiGztbh7xoMhdUuspjyDN1
	2HkoV3F8SVN1CZuo9wxIPaA2ZpfzFrsAd64qJonSLkVJalJB5Y7dV2mPMfnKI0Q==
X-Received: by 2002:a05:6602:e49:b0:7da:18b8:a4fb with SMTP id gq9-20020a0566020e4900b007da18b8a4fbmr13863832iob.9.1715080402027;
        Tue, 07 May 2024 04:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgLZ63aXunyVw0d4ucLeFiyGKLJk8OBbCGbqB4GeziSPAaxJYdgcBIiB+B5CQfUNEedPao7Q==
X-Received: by 2002:a05:6602:e49:b0:7da:18b8:a4fb with SMTP id gq9-20020a0566020e4900b007da18b8a4fbmr13863807iob.9.1715080401563;
        Tue, 07 May 2024 04:13:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f8-20020a056638168800b00488aa39b5ecsm832679jat.178.2024.05.07.04.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:13:21 -0700 (PDT)
Message-ID: <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
Date: Tue, 7 May 2024 13:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
 <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
> 
>> suggest. If you want to try something semi-randomly; it might be useful to rule
>> out the arm64 contpte feature. I don't see how that would be interacting here if
>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>> ARM64_CONTPTE (needs EXPERT) at compile time.
> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
> but will have a try.

cont-pte can get active if we're just lucky when allocating pages in the 
right order, correct Ryan?

-- 
Cheers,

David / dhildenb


