Return-Path: <linux-kernel+bounces-222152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAF90FD72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349191F22E62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61F43156;
	Thu, 20 Jun 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNT+i4Qs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C5639
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868050; cv=none; b=UbgQRl8Npf5NLyG5KvcJQ/sYQPS0rOd1pO30+rlH+G6GhCEFE0bGNZY0aUOYkGEPPFG5wXfRDsNIfvs4h8ZJY1G8chLYGBJ6V+roNPPpvA4Yfgh0Xab2cEBt/xn7rGv9m2+7hBREGDlLo7vRnGNMQOBq5rCmfJf1FGfpZio8Xho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868050; c=relaxed/simple;
	bh=EHqC3LT1KS8c9adwJx8kIWsriorYV5wzQurMQbS9GdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4LQ97gdBtIgi7BikSiMl2eZJ1UzWRMBTA7gk54cR09qZXltMveFwEsjKREIu2Ld7qfrhL8ykMwQ8NT0ATLD2g9k4J0mIuLK/ZNlvm/arm+ItYLu+A4yP0cNYJb3aN/Qze/h4knqpp5C6H0NKjN+YK1sNWy8Hy1a52O8GDk6tSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNT+i4Qs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718868048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xu9euBcpsgyUYVlYjK87ZvCq29S8qX5GGr4uJ9/oh+M=;
	b=DNT+i4QsuBvH3hNBOzL4aeE1RJmbCJ9Uh6TD1eHSJS7DdZl5EB/BaDDY07wacB6AwJmEKo
	a7yLY0KovN2ng/jr2WyhmFSgKZk7NJ+E0cwwo92rCEAoVYZieVELHWpeXyzu8r7DX5bgqe
	AsZzhY0zRK3jjE6LPuwGMOGvooJT8bo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-He4fvU_yN5q96DgSvoLoCQ-1; Thu, 20 Jun 2024 03:20:46 -0400
X-MC-Unique: He4fvU_yN5q96DgSvoLoCQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-363520c91b1so314593f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868045; x=1719472845;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu9euBcpsgyUYVlYjK87ZvCq29S8qX5GGr4uJ9/oh+M=;
        b=afr2opSguyiJ8BKcxyVEPNd6tLTCBWcHXdnCWxSeoiB/BIJTx78/PnvGFrQjd+HCpI
         414TW43p4fW4HvBb4WyHNr65PAqs1ef4oDjP9yBnsafMbUAQV3Ab9s+U7t9LgOfsCL3D
         UyW/Jr20dPfrNk6ykA6Up1WDu+s3bd9Xpo2DhY6Spv+K4QcSkc070tHQMndScTILULAG
         RbsESd7LYiSCnc0Wb87utF9Sfg6HmbbsMANYyxnZVfW7irb5XKQJebH2U1+rbqci/DrY
         VPU7KQALxaUXG2CL3vBlJ1Ln2YSRqhgE9/DelzVZucwQPPcdv/vDeTK9Zc1PoEMPBxzY
         NRDA==
X-Forwarded-Encrypted: i=1; AJvYcCV0CRFQnxyaV4ubtAhxH5faUVll7U/I4+f4lPuktk2AO54dfrE1EqpOsmcfbor+ne8edqjM5hBnMKhG0MLzFBpgbrvYrCd2MVJtOyjd
X-Gm-Message-State: AOJu0YyUpDQU7faSOmQbLOqFehX225Yci3gO9XmBFWQKFiUVPLvkfX9I
	Xl+XvA9iEqsEBLGjmD2WRq6Ki18BO6m+vg2jes4ZLn92xDpjz42XbhXoOodP8gtzFOrQUoHqhK4
	9al3sMWsetcRQ+cdBM95AQiIo4YoXverpUZV59H5FiKwKP8X4oFl8ZR5MRXQWvg==
X-Received: by 2002:a5d:64c5:0:b0:363:7bbf:efcf with SMTP id ffacd0b85a97d-3637bbff08emr3799262f8f.33.1718868045556;
        Thu, 20 Jun 2024 00:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtTDVELp3/HuRAOkhWEzx1WIXz6tdc0c3RQShTCl5/oPzRDdjgzoB/K+6b2FbkBaK+9kj2tQ==
X-Received: by 2002:a5d:64c5:0:b0:363:7bbf:efcf with SMTP id ffacd0b85a97d-3637bbff08emr3799245f8f.33.1718868045127;
        Thu, 20 Jun 2024 00:20:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-365129ceac3sm492865f8f.101.2024.06.20.00.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 00:20:44 -0700 (PDT)
Message-ID: <3e185f8d-da63-4a61-9cd1-9804bd972515@redhat.com>
Date: Thu, 20 Jun 2024 09:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, chrisl@kernel.org, hughd@google.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240620002648.75204-1-21cnbao@gmail.com>
 <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 03:53, Huang, Ying wrote:
> Barry Song <21cnbao@gmail.com> writes:
> 
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> Both Ryan and Chris have been utilizing the small test program to aid
>> in debugging and identifying issues with swap entry allocation. While
>> a real or intricate workload might be more suitable for assessing the
>> correctness and effectiveness of the swap allocation policy, a small
>> test program presents a simpler means of understanding the problem and
>> initially verifying the improvements being made.
>>
>> Let's endeavor to integrate it into the self-test suite. Although it
>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
>> expand its capabilities to support multiple sizes and simulate more
>> complex systems in the future as required.
> 
> IIUC, this is a performance test program instead of functionality test
> program.  Does it match the purpose of the kernel selftest?

We do have the similar tests at least for ksm (ksm_tests.c) and probably 
others:

$ git grep -l clock_gettime
ksm_tests.c
migration.c
mremap_test.c
transhuge-stress.c


I recall that gup_test.c also measures performance things.

-- 
Cheers,

David / dhildenb


