Return-Path: <linux-kernel+bounces-298792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23195CB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A81C20EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490C18756E;
	Fri, 23 Aug 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWM2MBgP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F8156C63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413148; cv=none; b=hZ0OlMBx4LEMgMuutwhuw5uZfcINWRFS4qeJmDpspfpjgJLWAYLU5NaqCQBDE5cejlXa+yh8rirM5IuFEFLMAEYyqeoQ6bVt8qpzDCiAkKtiXtetNUcXQc2TENz+S4yzbMRJQKfMEI9PEEXScpUuhLi2gwerJZPBdpnHOk1HFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413148; c=relaxed/simple;
	bh=0gO7wk8u84qxfm1j/HrOKQHBKXoIvdSEvV8z38YCeIo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GvzZpcbcJx5MsDWwvCGh4DbBGvNSDhY7qEMDdssbr0yfmZ+5V5BQ8k9UrcR+ONgxonWoRtuSLQF3Sp/95VEiAvWa8M/QrDs2RSkaTEvwP9ZiI+AaATkxkPj5DL4o7hgHcLS+NQXODbo2xTWh8JKiCdRpVAdYAjsjls18vt1UvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWM2MBgP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724413145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lXI92omx/LP0RGPICDJD1y6RS0OrWll0CoYFBSAz+eY=;
	b=BWM2MBgPIoPAUn8pladH2P5omuyxz0WZkxqERHIjy12VFa7esluz8CnqsRRcMiMo+ReBOA
	U236myMcgDYADFasIjhs35pYiTOtW5gtrJYVUJEnEntLWjWihJZvFEMjmuq8xChB+WFii+
	gvMgOpci8gwI7AYtweJz8yPKzYyfki8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-G2O_XnD0PCKrvpF55xTDfg-1; Fri, 23 Aug 2024 07:39:04 -0400
X-MC-Unique: G2O_XnD0PCKrvpF55xTDfg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso15088055e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724413143; x=1725017943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lXI92omx/LP0RGPICDJD1y6RS0OrWll0CoYFBSAz+eY=;
        b=DR2n+StyQ8JEVOC7W1KQUNTFTBjAsxU4l+z2wxvXn5SiglUw7xS/Sdaqjc9GZSyIPk
         l1gJr0mUhIrxsOPLBzizQDhocwXbUr2Bqm1WZl1eEkEEvtmQJb8+UU8/vAjPzX3ib5aN
         brCSR3EX9zf3zkd+j9utD5jqwJKdzDe992hV2p15kDp/eALMhjylaeekTI+sLG78cYbC
         Dw3edagP4k7O2r1mcjPo3Rj7qhyZEmu4vuvoR1HeN2QVgfleGdqh39v4Xoy0DxMIVZmh
         RnjrsLDaWYwVlk5NToiRPlVXMD39HC7gmvfxKB6iA4ZHw+st/r9xsqYitB7CPhYIDcRA
         zUPw==
X-Forwarded-Encrypted: i=1; AJvYcCV5hNGwvpxeSqolpYxJFlWPK4J2poa3V29iZ79hROArAZ3qWbqb1KhbTJZacSAXuVUKkcIwa2Ob70r4RuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnGVYXxiCD+bNS6HIXGnAE0g6CJc281EMrIvlYWqUWPKb7GxE
	tdvFejNCOyIpM5hmMNLQB+C9OSrbIctIZgY170WrYm3FQlpolzkyGqGGTIFqZdMvZWhlKqFeyhD
	UdldqAL2AB0yCiU7S4+Aqd37k4CYsVAhw4UMMLNmnvPeS1yzoL83g/11hyPigLQ==
X-Received: by 2002:a5d:64c6:0:b0:367:40b6:b90b with SMTP id ffacd0b85a97d-3730525eadcmr3876599f8f.10.1724413143332;
        Fri, 23 Aug 2024 04:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqj5RsrXLKQdXayO4DE4+Jgkh7s/S4sWe1HVsYRlTpK3PNC6xc7Df/zM7hd6O3sj/MGfzd/w==
X-Received: by 2002:a5d:64c6:0:b0:367:40b6:b90b with SMTP id ffacd0b85a97d-3730525eadcmr3876568f8f.10.1724413142513;
        Fri, 23 Aug 2024 04:39:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:e00:d307:70b6:92e9:1425? (p200300cbc71a0e00d30770b692e91425.dip0.t-ipconnect.de. [2003:cb:c71a:e00:d307:70b6:92e9:1425])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c5cbsm3949306f8f.28.2024.08.23.04.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 04:39:02 -0700 (PDT)
Message-ID: <a4fdb1a7-3748-4aa5-bd44-7d56454c3f79@redhat.com>
Date: Fri, 23 Aug 2024 13:39:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: collect the number of anon large folios
From: David Hildenbrand <david@redhat.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 yuanshuai@oppo.com, ziy@nvidia.com, usamaarif642@gmail.com
References: <20240822224015.93186-1-21cnbao@gmail.com>
 <20240822224015.93186-2-21cnbao@gmail.com>
 <7f9e6bf8-ec58-4525-ace6-98ba58de3172@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7f9e6bf8-ec58-4525-ace6-98ba58de3172@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.08.24 13:31, David Hildenbrand wrote:
> On 23.08.24 00:40, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
> 
> Nit: "anon large folios" come in two flavors: THP and hugetlb.
> 
> I suggest to just call it "anon THP" in the context of both patches
> subjects/descriptions (sorry, I should have realized that earlier) to
> make it clearer.
> 
> This patch I would call
> 
> "mm: count the number of anonymous THPs per size"

Oh, and in the cover letter subject you did it right. Just be consistent 
:) (I don't care if we call it THP or mTHP here, whatever floats your boat)

-- 
Cheers,

David / dhildenb


