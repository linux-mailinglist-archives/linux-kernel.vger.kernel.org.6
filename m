Return-Path: <linux-kernel+bounces-304803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82EE962527
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FE9284402
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82E716C680;
	Wed, 28 Aug 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+wPUG7d"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2861553BC;
	Wed, 28 Aug 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841899; cv=none; b=ZCvTyhql6948z7Szvz4vAcYy3t2ZijLrDGXrhIoEQnuivBgmew4hpCFf5eHUhBVDB8Tpve3rt+zjGDc9dNh7V0bOID/DWbEwO4jGU9S1EtYE1miWVHo6217u4Fez3iNQvoXeYlO5xWgbJL7RE7tTxogT0cuvml6v0gycr2cATS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841899; c=relaxed/simple;
	bh=8aaF19HI5B2yzFRE0SF8pYSauAEi73MVY06nUd8ylzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGb7Bm7sd9kRZW0nMrLvC0VMKp5M+agyFb9jEbJisCq+3o/jkOyVP7x2WIm+2v7Iwn0okW0R5fX35pjajlO7M/OYW4zZuGpx4f32wCR0u3FcMWY10/AWUlI4++aGJExAgTiME2UJAI01tE3p5IETKt+m7cZlRwoD3yRPMljm3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+wPUG7d; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86933829dcso743894166b.3;
        Wed, 28 Aug 2024 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841896; x=1725446696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2kNJxOTuqFsipbBScG0DLZ5hyvlGOCflIXITsRjahw=;
        b=Q+wPUG7dE0TbkAdGzq+6wgIBYq9stL/qAwHhWCmRWFOh+/cZxUtbAcM8vyL3Cp/9pP
         ioJoJFw60l1FE+QVCir3/2xJTwgah18wnIbcKWct2DIZWEMtQ5mcZFQL5F0al0VKZYJY
         H7r7Kw1vNBoCPiKn8fIoenC05l+79MbZSz6zQ4bpyFqHvnAC5RQ7kLO8MbE0iV+3KNIO
         TaNsilbCZQqLOP0IScjb5lBhwAcxaJKex5mhiy4HpMkLr4pgvaFM7mIMdHBLOEW7tOUQ
         ceU/NlGAGWBWljmpjt4Rsm5fXqfqAy+CxZE0xp9Agbb1CrdPgoFciMcsqNtXfDpgowCk
         zXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841896; x=1725446696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2kNJxOTuqFsipbBScG0DLZ5hyvlGOCflIXITsRjahw=;
        b=jqy0ySDl0E8f3LzfdLzAGNX0qrGa4DC6Y81v+JRVajIJzDvun2Gm0vQFb/G5ybDzuB
         aJIAJ0oTn36VfGFuD1Ce0VkVBQS4g0FoFYIEctOKiCs3IHgTpgbn9GxDIBgR0lWm9RVZ
         gW4AA8wUv1w0wwLGIM8Upn/7cxLczJfvOeS3C9JMP8xzjNoXoER4yU9+h/ablpZgvv7a
         aR8+FPPO7BXP2Fz8utlqQ5EQ9GoI5hPMuK+NDQ09lwifRfEgumBSboV/RMLb7H8H5GeG
         G0FeoBKEWwcnFjxkz5cqytLc08DgFcHBFMDanbFabjiQq/LDIKLG+ZvKskT+kqxvxmwE
         9wLg==
X-Forwarded-Encrypted: i=1; AJvYcCUh6n+DSHPRo9mFfWNziHLH83GRbjWOxuHapM+lqbUi3xWBnpOn2eRGiVvh6EIUHnWDgzfhBYbdMFKJY4UK@vger.kernel.org, AJvYcCXvoSVtbCBmqds4a6x8iUG662dhL46VDL5FUa5n5h+vGDg1fsQeM9f5kv+guuSt05J8uwc85Tou+A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0/BRU3JiaN/Ld88n5aBsXj4fec30HZK9tRaV2MUJbVrRhZfh
	2qTKpEIpOjLy1Y+XLaTfeCBcpfgiZyRCKAnhhpffbQhMqr3xV76u
X-Google-Smtp-Source: AGHT+IGMoYDTVcLmKtKBbEfgOB2rQ1TYZVKs5frEt7O1bdUKTrEU6PFwVisPNEMHr/crvWP4yyLLHQ==
X-Received: by 2002:a17:907:2d8e:b0:a86:83f9:bc1f with SMTP id a640c23a62f3a-a86a54de2cdmr1014126366b.61.1724841895200;
        Wed, 28 Aug 2024 03:44:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:b05d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e58315dbsm228435366b.106.2024.08.28.03.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 03:44:54 -0700 (PDT)
Message-ID: <18647b68-0c7c-47bc-9b9e-9cf46ce86761@gmail.com>
Date: Wed, 28 Aug 2024 11:44:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Rik van Riel <riel@surriel.com>, Nico Pache <npache@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,
 Rafael Aquini <aquini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Zi Yan <ziy@nvidia.com>
References: <20240729222727.64319-1-npache@redhat.com>
 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
 <20240827110959.GA438928@cmpxchg.org>
 <9cf237df1a7bb21bba1a464787938eba8f372658.camel@surriel.com>
 <ouerpxb676mei3kndz53j4am4fo2duvygoatfnposo2rkct566@akl7ckd7nrvk>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ouerpxb676mei3kndz53j4am4fo2duvygoatfnposo2rkct566@akl7ckd7nrvk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/08/2024 02:17, Kirill A . Shutemov wrote:
> On Tue, Aug 27, 2024 at 09:18:58PM -0400, Rik van Riel wrote:
>> On Tue, 2024-08-27 at 13:09 +0200, Johannes Weiner wrote:
>>>
>>> I agree with this. The defer mode is an improvement over the upstream
>>> status quo, no doubt. However, both defer mode and the shrinker solve
>>> the issue of memory waste under pressure, while the shrinker permits
>>> more desirable behavior when memory is abundant.
>>>
>>> So my take is that the shrinker is the way to go, and I don't see a
>>> bonafide usecase for defer mode that the shrinker couldn't cover.
>>>
>>>
>> I would like to take one step back, and think about what some real
>> world workloads might want as a tunable for THP.
>>
>> Workload owners are going to have a real problem trying to figure
>> out what the best value of max_ptes_none should be for their
>> workloads.
>>
Yes, I agree. For both solutions, max_ptes_none needs to be adjusted,
and would require experimentation with different values which workload
owners might not do or want to do. But as Kirill said, the information
on the number of zero pages in THPs isn't available. A possible solution
might be randomly sampling a number of THPs at certain time intervals,
but I don't think its a good idea to use that as a representation of the
entire system.

Its ok from my side to have both the solutions in kernel as they don't
interfere with each other. THP=defer makes sense to have as well if there
are real world workloads or benchmarks that show page fault latency is
problem due to THP=always as Nico mentioned in his reply [1]

[1] https://lore.kernel.org/all/CAA1CXcCyRd+qfszM4GGvKqW=95AV9v8LG5oihByEBGLtW4tD4g@mail.gmail.com/


>> However, giving workload owners the ability to say "this workload
>> should not waste more than 1GB of memory on zero pages inside THPs",
>> or 500MB, or 4GB or whatever, would then allow the kernel to
>> automatically adjust the max_ptes_none threshold.
> 
> The problem is that we don't have and cannot have the info on zero pages
> inside THPs readily available. It requires memory scanning which is
> prohibitively expensive if we want the info to be somewhat up-to-date.
> 
> We don't have enough input from HW on the access pattern. It would be nice
> to decouple A/D bit (or maybe just A) from page table structure and get
> higher resolution on the access pattern for THPs.
> 
> I tried to talk to HW folk, but it went nowhere. Maybe if there would be a
> customer demand... Just saying...
> 


