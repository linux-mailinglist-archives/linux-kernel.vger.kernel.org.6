Return-Path: <linux-kernel+bounces-272003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089969455CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310501C224B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECDA92D;
	Fri,  2 Aug 2024 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTpY7Ch2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6545258
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560038; cv=none; b=Q+j7iiRcHTRZvGis0bYrWz2yALqr9PCxAwymEbkq8mPTBCerITPFf/jWauUIoEqDR6Aj07pbBuzyZJCAtriAYr1eZYqMOQFRNWscQgVDZU/s2hUvQpFA2bo0RW/E+ovkh/rBNXqtujMKI5YDYO1LypZA7pXzEboP+JfIelDLI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560038; c=relaxed/simple;
	bh=wL60wtcFv4DiIDky6Z0DOZKrhvEnAUefZCHexB7aiGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCrR9WUAqbvO+8X90DU4M9MslOfpq/1z8oebAZ3hDEvs1te1pCffy4bEIB0GGhMCsJWuU7gBBU8iElMOniya0M98HLGnwUSrGCKSlrqNN6W6sw25MprZLkF5L7hm/tVFb0/7Kko9Bu+DJmY61nTPn9aJh8q4i/W14NPJHrTIX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTpY7Ch2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a94aa5080so81338566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722560035; x=1723164835; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tYvGp3U084S5c0hwzIWZhuijp7wwubaQOMFSuTVGIg=;
        b=JTpY7Ch2QDwcJCefNgwy0udFYbU1rrVvZ/FhE711s+yOjV/Rcy07mGiwy16N3HOG1k
         D8mNYrp04rZfnT0sQV2q5rEt1WyRIN2rMOrThitjQvvvmGZkAiRxR4uxSAyRFYNsrXZw
         eKnTXO0mN8Qo5km7e7Zf5GwTTh+cFlwl5QQJ/9weMQuw6K9MvIcYkAIwUIz33knW5Z4N
         IfPyMFAEhWLwYdwtCkrHLvjWKVi0yX7Q/yV9JSkmkt5x/3tbDeieRrz7ZKkJFyjvO84S
         G4+2avPCnYMAYMsNvv37ug9LnhOn6fLZyaHBxTtvJr+jROEsywRUMdFSLDLtaV9Yftvv
         9Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560035; x=1723164835;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4tYvGp3U084S5c0hwzIWZhuijp7wwubaQOMFSuTVGIg=;
        b=SlUrnP4qrYQzDPh9l3deh8Bb5PTzkhdGCRg+6oQRld6mUJ7IpvmM1kxbpTaDifmMNj
         65lUnLATbHQN+igK2Of0Uv1LrSAIZRyQOdvuJPPp+od6RMiXB382l/bTM5VJIM0bT3Ns
         XWZX/TdCB5gYJwBy3aHm3jVJjk9qTOEvUjhCA2ARiWNva8mq8mi6T0QUJdjLNDIdOYtP
         WEZs5kHP9Iq8OwE6eft8fJRJ37Og37mJnyUMBGY/lldr4IHO06oPv2lL5mtm7e24nbvW
         5dmhzxEkn3PKW3VuSOAfL24UokyjdcDHxP1m6+tUcNwxnixpY+cSP3pp5X9Dtc0hDYXW
         mXTg==
X-Forwarded-Encrypted: i=1; AJvYcCUfEUSypS/O3IHW7+5faIFqiL8RIvCmiN1kLk7kmXW9EZrpcsb0RcDrdqynJeCHbMx2mUYKPcanpGotafUtwkWnCdJio6OCVI/pas6T
X-Gm-Message-State: AOJu0Yy5qIu008m0BXc0H/SruSTTru/rDzX1CMgMQsxeb1fTU0c5pD/K
	QmimH87Sr0T3qlx5+GyBVsUL/SCkj+7LJeb5TBGsVNhEy4BpLido
X-Google-Smtp-Source: AGHT+IF4tf6695GDpsy8xbRd11nySQO0xjTnJX/MqzvH3aiV3HGyFCmSIjM55oiSMTRDLvGjPvwtuA==
X-Received: by 2002:a17:907:7f8f:b0:a7a:adac:57cd with SMTP id a640c23a62f3a-a7dc50800b3mr126699166b.36.1722560034449;
        Thu, 01 Aug 2024 17:53:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9d7dsm36716166b.9.2024.08.01.17.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 17:53:53 -0700 (PDT)
Date: Fri, 2 Aug 2024 00:53:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <20240802005353.z6udm2tw45i7phqy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
 <Zqcqky8XdiQy3mO-@kernel.org>
 <20240801000739.lrgmokbbgvikrlkw@master>
 <ZqsmisgECjaCt92Z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqsmisgECjaCt92Z@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 01, 2024 at 09:09:14AM +0300, Mike Rapoport wrote:
>On Thu, Aug 01, 2024 at 12:07:39AM +0000, Wei Yang wrote:
>> On Mon, Jul 29, 2024 at 08:37:23AM +0300, Mike Rapoport wrote:
>> >On Mon, Jul 29, 2024 at 01:47:21AM +0000, Wei Yang wrote:
>> >> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
>> >> alloc") introduce the usage of virt_to_phys(), which is not defined in
>> >> memblock tests.
>> >> 
>> >> Define it in mm.h to fix the build error.
>> >> 
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >> 
>> >> ---
>> >> v2: move definition to mm.h
>> >> ---
>> >>  tools/include/linux/mm.h | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >> 
>> >> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
>> >> index cad4f2927983..9db45c5d00fc 100644
>> >> --- a/tools/include/linux/mm.h
>> >> +++ b/tools/include/linux/mm.h
>> >> @@ -20,6 +20,8 @@
>> >>  #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
>> >>  
>> >>  #define phys_to_virt phys_to_virt
>> >> +#define virt_to_phys(p) ((unsigned long)p)
>> >> +
>> >
>> >Please don't break #define of phys_to_virt from the static inline
>> >implementation.
>> >
>> 
>> I don't touch the definition of phys_to_virt, so you are willing me to adjust
>> it?
>> 
>> The macro here will be expanded to code at preprocessing stage. I don't get
>> how static inline would help here. Do I miss something?
>
>static inline allows type checking of the parameters and #define with the
>same name as of the static inline allows catching other defines with the
>same name.
>
>So it's common practice to use this combination, line phys_to_virt does.
> 

Thanks, I finally get why we write code like this.

>> >And please make virt_to_phys a static inline similarly to phys_to_virt.
>> >
>> >>  static inline void *phys_to_virt(unsigned long address)
>> >>  {
>> >>  	return __va(address);
>> >> -- 
>> >> 2.34.1
>> >> 
>> >
>> >-- 
>> >Sincerely yours,
>> >Mike.
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

