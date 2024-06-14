Return-Path: <linux-kernel+bounces-214469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64161908527
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10A5289C80
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5674D149011;
	Fri, 14 Jun 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWJzsLY1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74EECC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350491; cv=none; b=E1+jPO4MkF2daxpuYXIfICKLWWzrZMwrIsk4x3x68ssLEMfPgPjU0YwJ6M28mRPGRpcrVdAVChvu0ZJF50t99TzGrVSqhbsPXgvxfLb/5lbJ/5V3ZkhR+lLcjEDPqIb2OBB70opng4R6bbJpEIvxMB/BZ74xUaPgoKE7P7ApHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350491; c=relaxed/simple;
	bh=VY60kalrKwnczMuk8yzLZNGd/DU5vvXWYcD/SO7OXv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0bWJpyl/lnjggSQw6RzdgaCkkTUv6dO2mE5VpmCYnIPo1Rbll9yQuo2QdtHIq7jd+fB+qS0VxkwLDcWdlPH1cO8/xRKZzpoiQML5tQRvWdLCq2d6irh4mKLtj30XSvj/ckLu0lK/ybBMbRMr3c4EMtlyQ7SafqciMz5g0MjDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWJzsLY1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718350488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vhVev5eg90093EG6VTzZKwAqU1fLL5DOVgG/qvzSWSI=;
	b=BWJzsLY1nnR7N6afN0HFb62AcSxFB9eMhwNujNVwMuoS2QhihezmH2FvmlTEKY9z7vCvgw
	CbPZHvoeVkpNyD6XvbHfycfqXX8v3QI+SjvLy1S58GPY/YqLrhDiC8xJ1m78aDCO9hIP11
	ILC4zDM3g5vHN9bgSt5vbMxrn67qads=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-meDaHg8-NQq3Tl_PKT4IbQ-1; Fri, 14 Jun 2024 03:34:47 -0400
X-MC-Unique: meDaHg8-NQq3Tl_PKT4IbQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4212a3ddb6bso14262025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718350486; x=1718955286;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vhVev5eg90093EG6VTzZKwAqU1fLL5DOVgG/qvzSWSI=;
        b=U8eiGWFalMYU/yUya5iEr78fJtcmmG5/FOij3ffqr9Ej6OXwABnnX3xpcHDA+JoD/A
         KTZ/5pEF/pTocEDfqBi2SxYOXhwuFGZnGQ9Z/kd8tHUBe28V9qgObusDVh+5wiiJoOLL
         P4VsCW++HAs6qHmICehKLZ9ncQGvY0kbUnCeUyuUOyrhDUldz76ZBTWagIy2v8nQHEeN
         tCFVVl2Vpe37mZGK3Y22KSyJ4b+fUNifqLqw0P2smLpVpmbpY7+Q75q57D/A690jFIQs
         naQkq8Oo6FVcpAcOu87whFuZ8KwIHFW0VHwfkKLwA34EnvTRt2JY/78A3tEwETAVI+Fb
         KKiA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMQ7evb2laH89t+xOQswDMX+vCtHksJQL7wMr7i9JYoQgz3d0EqOXh3nI1xQRdsX+uv1t1jp2PVlrh4Gc3+FMckhU+cVbWQPp07y0
X-Gm-Message-State: AOJu0Yyjo76ICYT9CGPUwa4oW6ru+ZNC/liDKrji3Jfpe48VDRtiDDw2
	BGWIMKKzFuvwwlz44kmu6eVlMNAYgLDEh4E1JHsGaNkSXXeW2t5KRM0hrX6SmsPzdvPNzkKcBDb
	SixvpBen07uOaAk/+SVnR/2XMLLcMAsr2X6NJUq/ftrn2zWNQI6SSMTyeGIOz/A==
X-Received: by 2002:a05:600c:91e:b0:421:f04d:ebd2 with SMTP id 5b1f17b1804b1-4230482fbafmr19347915e9.22.1718350486224;
        Fri, 14 Jun 2024 00:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdM8+eLlcOV7kPwNlHClMAOvLSS/9j7Nu56kRRk9usDJl6Ety/UD4TwIYPO2OSi7HEZD6V7w==
X-Received: by 2002:a05:600c:91e:b0:421:f04d:ebd2 with SMTP id 5b1f17b1804b1-4230482fbafmr19347765e9.22.1718350485820;
        Fri, 14 Jun 2024 00:34:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a633sm49911955e9.43.2024.06.14.00.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 00:34:45 -0700 (PDT)
Message-ID: <24765af3-2f2d-4451-9d9c-c35784ae95c6@redhat.com>
Date: Fri, 14 Jun 2024 09:34:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, baolin.wang@linux.alibaba.com,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240614015138.31461-1-ioworker0@gmail.com>
 <20240614015138.31461-3-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614015138.31461-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 03:51, Lance Yang wrote:
> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> folios, start the pagewalk first, then call split_huge_pmd_address() to
> split the folio.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---

Would have converted that VM_BUG_ON to a VM_WARN_ON_ONCE, but it's just 
moving code, so no big deal.

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


