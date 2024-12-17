Return-Path: <linux-kernel+bounces-448894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20949F46ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B216C917
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4B61DE3D7;
	Tue, 17 Dec 2024 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jetVHmFu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41331DDA35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426665; cv=none; b=YdFBcfQtwFRW0zTpN9QOn/6VgPtNNywkzX98SLvw76HBL0aOQJUDsPzSCosPyJWeVqgLaTZGDFMWNiePUQjoZiN/k0VQ5s9l2UpdHG0WedA070wXdl8+9KQYC+DZ0n7UprSFgwU61O7Gwz5vCJDU1RcTpzWQMx3m+RC1da7blfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426665; c=relaxed/simple;
	bh=PiHRFE6CJKO6yPDo+BLU8FvgOdZY6NIehjT64UflC5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEwdD4gWTCWBXuM3S+Jxd2Cdiv722mbzIu6+Gd2yeY57RsUXFdyK0pZlLDgyt5jc3RVXIDVZBHMk5mVD32wuO4PVQJuYF0T6noJLJOCBCiZWVKGe4h183wPN1b0nD4oE3NKRtzWqJyIs44aeLxYyCKR8txcYY8Yy1Te6hegN++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jetVHmFu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so41465165ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734426663; x=1735031463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5VM3n7hNnnRBQt5LbKkQaziwSOAI765RsqifvciV4M=;
        b=jetVHmFu9YH38Npzf/zX7kVRG0njDzAj1EAvELm6A5o7yBYcbWVVLXa6HHWoNbHzFl
         Mj2EOggshv5htP0blOvGAZ0DIme9k0pmblmFEedVf2wNzG/bGLml6aAJlwSeo2/OKiVO
         /bs/nV6SFDbg1A104v5+Qjmx7COWJy3jYCV4DDScCjUiHFlSkL9FCuMtchGGohl4bA7o
         rg/WmgWG9XC5VbKn50j3XvWCMZH9Y2lb+NfpexwnFpQQtOa7r0oqCSHoDsajyo74uAcu
         j45rnTpYdNvu0eGR7QZVg3M8PglciMmufEq04S6vVUh3WcRp8J0DJkg7zTEb4dYleXyd
         kZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426663; x=1735031463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5VM3n7hNnnRBQt5LbKkQaziwSOAI765RsqifvciV4M=;
        b=re6qvCYu9N+15fP9MLrbfUZ5uAgdUB/JWc+MrwSVdjt0H93mfBY1MRmUnn66n7p4jR
         QJ+oblciF+c6c9I6NrDSWCa7I5YxTROgWK67xNNoiFMXeo18FMinGV/I+BSsiR3nfvJ6
         wKjIKvuINmM7VsafuQPs5fflW0ORo9mrvG7EcsNT3nqbDaZFc2j7Dhkl7ZOA/9svSQVl
         kKN54v1s9iJwzJ5Hv/l4otxO1F/a7rHipFnUrf7DtjHsCaMk+hXCjoOcmt7IpBDtonf5
         UfBOLvkuWf+FgCaOnF/2jn74fR14xyeM4U/fZg/Pfgu2l5GJrnkL+LoI+gu5LOPECfjG
         9CKA==
X-Forwarded-Encrypted: i=1; AJvYcCWiaHE5EAwvLYU7Tjg82tDYK9cLEGSKG772AC9cVBXI+obUHSZ5mkz+vvmIb844p7eUVv5BH9kZTPhYXEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nWGIZK/CL1XGWUmrTH/3pYb8XlHZhN1aDQBD1ouz6BqjipL8
	3DGL/w6RukiyvC2wIr5dkVp1ktBm9DMz516KRFDc1AMoG78gimDQIi3FaoBOd0Q=
X-Gm-Gg: ASbGncvMli+VmbYmFqg3aS9oW7br444HL/B9rlm7bZGN2YuaFWP77Palc9KjdiDD31B
	scsML0ACyC16+4BIHa6idFP3QTBR1AtkICrCpoE+tEasnSWVEx4FjYScBBYAndA1k6/CxEniT2z
	jpX1O499c4RdTzpXie2oFZWZt0WYLb8jLEfzn4QRuA+XDAp+5qMygOFKtDRWo6dUJZ3ju/KU9H1
	Q8K7DcPJnyrmx2ZFAmvG+s0TjUtpQMdsSTuv3gmKvsbMnYODoIWpdv4QAJfujU/pHloJCKZbLH1
	nrKfVw==
X-Google-Smtp-Source: AGHT+IETGzZ3WKNiQdZbK8zpOJPBRPKIILb1zdFxy2//Eni/fk83RoZCauwq0oscGqj2wg6cWLgygw==
X-Received: by 2002:a17:902:d4d0:b0:215:9c06:272a with SMTP id d9443c01a7336-218c9368bcbmr29948595ad.24.1734426662716;
        Tue, 17 Dec 2024 01:11:02 -0800 (PST)
Received: from [10.4.194.102] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5011bsm55183435ad.152.2024.12.17.01.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:11:02 -0800 (PST)
Message-ID: <d5d21a5d-565f-4762-a853-8e488948b2a9@bytedance.com>
Date: Tue, 17 Dec 2024 17:10:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vishal Moola <vishal.moola@gmail.com>, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
 <efc3f9c9-5040-44c1-82dd-59361281336c@bytedance.com>
 <20241216181225.GB11133@noisy.programming.kicks-ass.net>
 <6666f651-2a59-40fb-b984-60669d4fdaa2@bytedance.com>
 <20241217090222.GJ35539@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241217090222.GJ35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/17 17:02, Peter Zijlstra wrote:
> On Tue, Dec 17, 2024 at 11:42:02AM +0800, Qi Zheng wrote:
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 497035a78849b..11829860ec05e 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3064,6 +3064,14 @@ static inline void pagetable_dtor(struct ptdesc
>> *ptdesc)
>>          lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>   }
>>
>> +static inline void pagetable_dtor_free(void *table)
>> +{
>> +       struct ptdesc *ptdesc = page_ptdesc((struct page *)table);
>> +
>> +        pagetable_dtor(ptdesc);
>> +        pagetable_dtor(ptdesc);
>> +}
> 
> Right, that works, except you have whitespace issues and I think you'll
> find it'll work better if you don't call _dtor twice but instead replace
> that last one with _free() :-)

Ah, stupid thing I did, please ignore it. ;)

Will add this to v2.

Thanks!



