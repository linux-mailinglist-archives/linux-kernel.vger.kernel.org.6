Return-Path: <linux-kernel+bounces-282839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9494E943
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1D0283AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76916D329;
	Mon, 12 Aug 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qr6EP+A2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0415217F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453620; cv=none; b=Z/lQwC1/JmOgxqUaABy+NX+74HXaYK/c79VQTrqUg2hWdNVBmNNBfPpSZhVMdbfhfxprUqJ8jcTNGAKWNq4GlkoMPuM/zwsQheuEfl5L6XMFnoUeewjSUCoAzt7r2k7meIhOmfPdcqe8kaoAVU6SQP2/cUrRinBue8d9UJmLJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453620; c=relaxed/simple;
	bh=DGGrHM1EQNyBZ0sGeMkfzVJKqnwJxgNxVVMQ+IB3Vco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDbre3Ew5f3SsBXoRn14qV4H1v+YMlUvNKyJXErwfHEVdM1GXZM6DvtCI1rnbm5Tc6xVFo3oS4yBWNFY14ByB67YLG92f4V/jO6pke1q/vnTtsqBNigss/qsfSaeuc1AOADg55i47xCtvM7B2sn1PBEL8UuoGDglAWIVWXPPWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qr6EP+A2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723453618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k8LZbL/6ueQa/mJCD/ETkWFRcptMRfzelEcTzQzcJJ4=;
	b=Qr6EP+A2yFhGTn4PxlssLM1d7emKWCbRDY1F682SNHxwbdYAVLcvcSMYiaBV7RjVniK4K5
	sVNmOt1rWAuBXi9VthADEmzA4wRXwI4nR1m6z9DMNAjpWvKrxaTZF9WbEX2imz5fOSuBGz
	mUuefOjJN+YW2hD4yjsaZq/oj8UYJjg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-ZCo5yT7KM2iHZEsKmAn3mQ-1; Mon, 12 Aug 2024 05:06:53 -0400
X-MC-Unique: ZCo5yT7KM2iHZEsKmAn3mQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367962f0cb0so2435309f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453612; x=1724058412;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k8LZbL/6ueQa/mJCD/ETkWFRcptMRfzelEcTzQzcJJ4=;
        b=Pccd9liUKoKk/oN2tad4GXEi2Qh7Ek9OA/F8SKopfRj1UCkTEsgEWR3tgM3THJySvr
         7gsPoTky/BXoKMMvGf+i4FuW/LMrAGYt0JhgjL4VA+S7lagW0ExBLosKDYqdSnNa5aOy
         Bb5dz2CmRr5b9C6XyEmlkPuv5kKTnWp+dlmB4KXZZ3/I+GlPbNjSN2WXI+cw49L033mA
         uhqfu4klPlnuHkBmSNRe/TBDpYMmXmN8RzcHqfz16gj9LJIK3S7T0g+KYVUZ5lr1H5x5
         hDFWrJsILcPezV/Nv/HqTT3JcWHYIZcWf+mx8rL605uKGEC993XsE93rzbFnRTqRXhRz
         0xpA==
X-Forwarded-Encrypted: i=1; AJvYcCVD7ApkI2ltfjxY9CXrtzEStwGHiecQV6V7GNGxByKEUf92hC+qFTsYXKGzMdiR0YOocgM5nutUHNemPNLi4jyRu68XvhpPGCXKXMeF
X-Gm-Message-State: AOJu0YwZKNXlJAacE/FJ2+ccxASYC325FhVT9ULn0EyjnJxA6+jvcm+V
	Or47Ho83aiG/kaDD57Nbhq1KQoWkz4A611BRZWDweCOiVKcWolgsV2RsgiCpg/yaqLb/WI6mVT0
	7y7Yl8VNsNtpvoAQljUv/pdtVIXdZrBhRvLnWRtAe8Fiwi/QrHgvHVY2c3wonLw==
X-Received: by 2002:adf:a196:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36d5ea04d9amr5772367f8f.32.1723453611699;
        Mon, 12 Aug 2024 02:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxmZToUvqjc6oUL/CKcIdAEqeiD75GTnifBA3Ws9+qjbkmcWEcyrr98vgLkznw4GVXWj8NpA==
X-Received: by 2002:adf:a196:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36d5ea04d9amr5772344f8f.32.1723453611132;
        Mon, 12 Aug 2024 02:06:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c93714asm6897461f8f.27.2024.08.12.02.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:06:50 -0700 (PDT)
Message-ID: <40b6c730-a5ff-4bf3-b284-179098bda0fb@redhat.com>
Date: Mon, 12 Aug 2024 11:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm/migrate: move common code to numa_migrate_check
 (was numa_migrate_prep)
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi <shy828301@gmail.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20240809145906.1513458-1-ziy@nvidia.com>
 <20240809145906.1513458-4-ziy@nvidia.com>
 <17597d58-7da8-4555-b583-1997d78be018@redhat.com>
 <87msliv5wd.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87msliv5wd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.24 04:20, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 09.08.24 16:59, Zi Yan wrote:
>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
>>> reduce redundancy, move common code to numa_migrate_prep() and rename
>>> the function to numa_migrate_check() to reflect its functionality.
>>> Now do_huge_pmd_numa_page() also checks shared folios to set
>>> TNF_SHARED flag.
>>
>> Yeah, I was also wondering why we didn't check that in the PMD case.
> 
> IIUC, before commit 728be28fae8c ("mm: migrate: remove THP mapcount
> check in numamigrate_isolate_page()"), we don't allow to migrate THP
> with mapcount > 1.  So, it's unnecessary to set TNF_SHARED flag at that
> time.  However, after that commit, we need to do it.

Thanks for the pointer, rings a bell. Indeed, the check was remove for a 
different purpose, so introducing a check for setting the flag makes sense.

-- 
Cheers,

David / dhildenb


