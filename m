Return-Path: <linux-kernel+bounces-571193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C964A6BA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8DF7A55F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A62236FC;
	Fri, 21 Mar 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXZzrSLB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB533F6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558832; cv=none; b=ruzDFyjN/kxu8wS5Efl9x8mpKAjG7ARufbiuFRrrLqYZ3uDt9LzhvPD13DsxmDV0p3yM0Hb+QUcE6ZC22wqYm3tXIUS0UAV+QgSaVK2l9OtKKGQ4qxOUtr9xEtLVTU4WMOuMQlaBxdJtyJSa25T3A76zwG1TSakKfGShjLiR0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558832; c=relaxed/simple;
	bh=/RRmGWbZTVl5euMeGSXKzjOM9H0wUlVrg/ACIOgbN/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPtP3dqIDBb7HsO0zThLnrFh0zUm/94vLtwu80aiUI+pBvKTAwadCTz/2T8S0a0BI8d+Y9klcIbbHRGCczCEwVIW0U44akJUIkAwyQYTdA2Vd6zja8pHh9vhEunbAowc2J3jOxIt9ccDZWrims8P3WWqQ5qIez6Zj8be7j0WWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXZzrSLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK8jbiRQUCuGzkEC8gp3HgeBh+Llwbi7i8xYVFzm5yM=;
	b=PXZzrSLBeYDSsNJK8Zn+9C/XxnvNHJQi0akOl8NcQ2xPt6sr5rmo+x/uRFzW9+LXN5uiX1
	v6qGG4wumpVeI3lwJp5xVn0tsgDYeJ6mjlCSy/mPdoIfTBL7jdFpXMCIeQZq3LUhJun82R
	+69h1Xo6dyN54ZXs9BG6gLx1TTh2MH8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-5Y2V34AnNtqd_H7FOOvO2g-1; Fri, 21 Mar 2025 08:07:08 -0400
X-MC-Unique: 5Y2V34AnNtqd_H7FOOvO2g-1
X-Mimecast-MFC-AGG-ID: 5Y2V34AnNtqd_H7FOOvO2g_1742558827
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22651aca434so30212915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742558827; x=1743163627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK8jbiRQUCuGzkEC8gp3HgeBh+Llwbi7i8xYVFzm5yM=;
        b=d4vmFB8HbWzixy3Gq8jGACv3mpDPIg9k4TxtzvPq9wq2Y5K2cVFaphYdv5HXG/WOjz
         Igv8F8I4WscXamLTzjyhaznNmEgnBeiR9lAvKi/HO1KLS6bOs9PNLFvkoT5tYCuzcDyC
         6l4nH1LlCS6CH45+Qx5CrFHCo6y6d9hpD0yKN8rw4mfFiRQMbJXNFmfEkodrZphqnC6b
         ct+ARWUPMPdsFMZJVNSqxKn+3XIQrZTMX2cJqBOnd9MxrHvAvSnkdchXOxWpvn6bD1Mr
         Okzc4ic5kmjPv1+j5Vf6GbTgeOjfT9AX+KRLY9s//5WnW0tR/1pj4DmqpsCv3lmav8/6
         OChA==
X-Gm-Message-State: AOJu0YzJ4+XTiapw6pMRdYoB2u7BntMhYN/V9AmcczeMHJqhz5FMq4o7
	x+QEvvwk+dqMDOeeNjYnxhqPijrCdl6hYkp1FNn3CPVfOKhiJAO602/MkOmWc3XujoG5XC9VgCN
	jMKm90qE6hJ9vqvbYh9+m43Yibew+pJ/m8yCKOQ364sElpO3IucONQ5EDQGDnNw==
X-Gm-Gg: ASbGncuuFypeZZcbWpzbqqxRSXbey6e/IdNGcAWVfx6Fj/TNqa9V4P2Q7Rx1gsDfnQe
	/Mcw9gLgzSs+zY/eU4CnVq8Cc1B3y3vP9eQAgMC2jvFAj/d7lJi+vYJNphJ1b3ReCglQVMvkwcx
	Vd4yoLLzN1jf/LUVpA4B7pByH6RFetsVt8nrPbMKK8V+3Qzo8d7QnPtStginCDxmOsQFJxXfUGA
	yL0ZoupvxRD1TXOFKNsQA66WcruhaBANPObLnurBxYpJfIw+GUcBbeiWAflitqIDKqCiPIi1+2j
	uBIVPaapfhYw/kxcMw==
X-Received: by 2002:a17:902:ecd0:b0:223:325c:89de with SMTP id d9443c01a7336-22780c5467fmr41490515ad.1.1742558827086;
        Fri, 21 Mar 2025 05:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPb2qv80bENSnWkHhgutNgJ7//gOod+EBH9idCsQBHHTDdPiAgWXiHA2ICcyAwYDDRfp7asw==
X-Received: by 2002:a17:902:ecd0:b0:223:325c:89de with SMTP id d9443c01a7336-22780c5467fmr41490255ad.1.1742558826586;
        Fri, 21 Mar 2025 05:07:06 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3bbedsm14789115ad.3.2025.03.21.05.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 05:07:06 -0700 (PDT)
Message-ID: <ebf97543-ee25-4944-9990-c0c21c180213@redhat.com>
Date: Fri, 21 Mar 2025 22:07:01 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
To: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <b9e1269e-e79b-446b-9483-4fdbc1ee42f4@suse.cz>
 <0d096764-302f-4b80-a867-22f5302b8045@redhat.com>
 <5ec97dd6-6561-4687-ac94-41c63ffc82cf@redhat.com>
 <fb1f1b70-6c6e-4b68-b3bb-fef45b8e8581@suse.cz>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <fb1f1b70-6c6e-4b68-b3bb-fef45b8e8581@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 9:33 PM, Vlastimil Babka wrote:
> On 3/21/25 12:25, Gavin Shan wrote:
>> On 3/21/25 8:11 PM, David Hildenbrand wrote:
>>> On 21.03.25 10:23, Vlastimil Babka wrote:
>>>> On 3/21/25 06:31, Gavin Shan wrote:
>>>>> Found by code inspection. There are two places where the parameter
>>>>> passed to page_mapcount_is_type() is (page->__mapcount), which is
>>>>> correct since it should be one more than the value, as explained in
>>>>> the comments to page_mapcount_is_type(): (a) page_has_type() in
>>>>> page-flags.h (b) __dump_folio() in mm/debug.c
>>>>
>>>> IIUC you are right. Luckily thanks to the the PGTY_mapcount_underflow limit,
>>>> this off-by-one error doesn't currently cause visible issues i.e.
>>>> misclassifications legitimate mapcount as page type and vice versa, right?
>>>> We'd have to have a mapcount underflown severely right to the limit to make
>>>> that off-by-one error cross it?
>>>
>>> Agreed. Likely not stable material because it isn't actually fixing anything (because of the safety gaps).
>>>
>>
>> Yes, it shouldn't cause any visible impacts so far due to the gap.
> 
> Thanks for confirming, please state that in the commit log/cover letter too.
> 

Yes, the commit log and cover letter has been improved for this in v2.

>> I just found the issue by code inspection. Lets drop the fix tags
>> in v2.
> 
> Fixes: tag is fine and correct, just Cc: stable is unnecessary.
> 

Thanks for the hints. The 'Cc: stable' tag has been dropped, but the
'Fixes:' tag is kept in v2, which was posted.

https://lore.kernel.org/linux-mm/20250321120222.1456770-1-gshan@redhat.com/T/#t

>>>>
>>>> I wonder if a more future-proof solution would be to redefine
>>>> page_mapcount_is_type() instead to not subtract. But I'll leave that to willy.
>>>
>>> With upcoming changes around that, likely best to leave that alone. I expect page_mapcount_is_type() to completely vanish.
>>>
>>
>> +1 to remove page_mapcount_is_type(). After Willy confirms, I can post
>> an extra series to do it if needed.
>>

Thanks,
Gavin


