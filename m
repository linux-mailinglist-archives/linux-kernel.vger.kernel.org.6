Return-Path: <linux-kernel+bounces-432544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBA9E4CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952771881974
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41A18FDC5;
	Thu,  5 Dec 2024 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bNWzRBEZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F754193
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369711; cv=none; b=fBiwhCoqFxavAv01lKf6R+5p2VcJPtDr0FrXlgK2dW+Tm/JTMd8SWUxm7eV2nyjnS6/S+PVvK4huvwW8ugQY3xCWblFyA+1EIBdudFA4iXVqpBOvJct/GO5b6kLo5uGJKR+Ih/3KY+6+HLZPtKJEhIi4gviCALWT8PUK6vK7aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369711; c=relaxed/simple;
	bh=Q0axvJ/QIfWCtXxAfwulx9Cn++W42nJibSDZNnpqQk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqFSyJ7GBQPkJIluejiqc6tuV1ULYbNTi2ze4oBTbLNnuoD9VcZwdonjwZTfiic2z1hnebW4ZULtPI6fTr9V3Jr+k1bXhoWHkVjKlOH0JF5LIrdqun4TCl9S13gPWJS53oMUtljQ6J3EM1C3Lpk7P4U7WlMdxumwXLbKtV7Myb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bNWzRBEZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21145812538so3481955ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733369709; x=1733974509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYQ7tM72j3M6OrGfErua8grmBm66miD19usAoOvI/I4=;
        b=bNWzRBEZorFsWy3Wo54yKPQnqp6ORavVJzgbnC6ZcRybRoqf2ExM7ca5uFWI+LKBKZ
         uvZqrblrA12s8ccHZ4tKQxKZxzMrCjYD2WJwTVlHLKU6U2WXTbWh3IV6wN8TXjtlEPMz
         lPux72smfK9teZ/1hUDohGtaQCM3qothlauzlh3dAj2MKiPEry6ZJHBMcL6TSE2jfEEb
         mmZtt7UFNGqrjx4xOIRXbW+UHIq5ViXqSJqGVwyVIJ/Emwbw2A8CYFPnx9FW54JNtKzF
         6cx7B9Jd307WYNhdRiTS4BPGLnY1CgD5DnPhOCuH98dABpfOSZzdiTvWHQYQUz06c6Pq
         6GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369709; x=1733974509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYQ7tM72j3M6OrGfErua8grmBm66miD19usAoOvI/I4=;
        b=qB7X2Lt3Lv3raIi4+ycVAkOc5qTHwloOSh/3QSUeeNdK9XmXYiZG2WMe1WaMU2sTQX
         5uc5Ownut2P3lnMicONuoIJpsW/WU2z9MJ7fs051NMyMpmGpjhA1cbbuOa7Wwpo44FON
         BZypB+xAzXYLRRfsaLN46FYEHAWApzvl37b960OzzbadvJ5rcYEgYAwHs/VkVx7h+YGL
         qjtxJWs+2JnUk7qNqkIxfzpU4N1zaXzYn6kHuZb4YHYY4A8KNHs9ufNwtmTdcUZ+iMY/
         IXKrXVbwDnEx/KMATZ/RqasVLH/K/b1L9/zu2ieNUicnUhdTpvxAYka+eFF4m3o+si9O
         BX8w==
X-Forwarded-Encrypted: i=1; AJvYcCVRqCPAJZ9BAhTOboUr3r5RPWyLVIj648BRnOFkKk7vgBKYZdI7Bsmu0+i1eU79AcZNUz1FPYacufPaeFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhp2QFEa6WE7fdbyRsdFriPqKmFcKTDHYNsq6OTE5fnF1gQzkD
	sTbKOdg2Rijp7NaqT5dmC6sNnlp1waVSUYQFi33uMjqqTRXO+7Jyi2JFA1ayaW0=
X-Gm-Gg: ASbGncsV5fH6mqW7tBSHpSol57gRsGoCtN7CFNYCMeSpKiHMKJvYBetWPJ2YVZuDsKZ
	Xoh4dnmjY0RLaeWC2YIqsWOkTiS4I+mXAUO9s23i90op2YJSDNAfJXkjSc0Vy97Q3lSukecbNbs
	KUpmFa6skc16qYDN4crFoihFFnTNXg0/sw9fN6ZOEmGuz6BarvA/rFJ0tTtg7vDpkWFPMZNX5cX
	U79oZ2orwMQ3A85G3wrGLi+okjbeuEJfz05h3sePMG1rVUTcGO9w9V3dWUKSX7cYBiUOVrDnKI=
X-Google-Smtp-Source: AGHT+IE6M3/T/ty3wOo5/tgiz1/0jgbteEGUOeQLurv09QDBS2aci/DJUkBXdm0sre5R9RhN5VWtrQ==
X-Received: by 2002:a17:902:f54d:b0:215:6f62:3091 with SMTP id d9443c01a7336-215bd0ecd88mr81222815ad.20.1733369708803;
        Wed, 04 Dec 2024 19:35:08 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e6e8f4sm2853275ad.108.2024.12.04.19.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:35:08 -0800 (PST)
Message-ID: <c35de63b-c0c6-47b3-95e2-d37ed3801b13@bytedance.com>
Date: Thu, 5 Dec 2024 11:35:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] mm: pgtable: reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, jannh@google.com, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
 <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
 <20241204143625.a09c2b8376b2415b985cf50a@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241204143625.a09c2b8376b2415b985cf50a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/5 06:36, Andrew Morton wrote:
> On Wed,  4 Dec 2024 19:09:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 

[...]

>>
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1301,6 +1301,21 @@ config ARCH_HAS_USER_SHADOW_STACK
>>   	  The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>   
>> +config ARCH_SUPPORTS_PT_RECLAIM
>> +	def_bool n
>> +
>> +config PT_RECLAIM
>> +	bool "reclaim empty user page table pages"
>> +	default y
>> +	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> +	select MMU_GATHER_RCU_TABLE_FREE
>> +	help
>> +	  Try to reclaim empty user page table pages in paths other than munmap
>> +	  and exit_mmap path.
>> +
>> +	  Note: now only empty user PTE page table pages will be reclaimed.
>> +
> 
> Why is this optional?  What is the case for permitting PT_RECLAIM to e
> disabled?
> 

To reclaim the empty PTE pages, we need to free the PTE page through
RCU, which requires modifying the implementation in each architecture.
Making it an option will make it easier to gradually add support for
each architecture. And for now, we have only added support for x86.


