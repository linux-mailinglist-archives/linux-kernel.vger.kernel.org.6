Return-Path: <linux-kernel+bounces-347749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F8598DE0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B81F21718
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F21D07B0;
	Wed,  2 Oct 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V/LyAKnQ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F681198822
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880859; cv=none; b=sAjwxdBGiQGsbmEFB/k0L9s48M1voHTN9FyjI50gsCeMdb8MJt3Z06Q82cxmUmddzneXcokTApuh0JTLwN14HC/3sCiLlwJUZpIGvvo3CvVjkSx3SjE6/5Z/75it5/hLX0u3aczf2uh9+9xOguwUdfLAbLqJ1FxI6u6g0+Vqmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880859; c=relaxed/simple;
	bh=dDOM/miESTYcTc8d+P4O/cys6mYe2R10ZJE2IWdvkSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKecUDfh/O2Rt2JgEszRmeYE/wt44rgVjfLXSg8eFiNkZClMJV+QxNFlBdMTmAJDPagUx3BlNvbj+9PndatV/urQ2si6ISzGx1Q2N29KUb4G/kJB0yio6GWH3cEE/TyDkUUuxWNE+NqB0rAkhFlgbvqhWU0Et48neFt+JgiHzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V/LyAKnQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d2daa2262so774763066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727880856; x=1728485656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbv3ILFUVeEmssaFHftgOo6dWe6k4rKzxdcBQPU2ScY=;
        b=V/LyAKnQnM7BvWBfd6m2sLV/gV9OgaDcchOEJcpXH+zMms96BxWLyhnyhKDLBDdYQj
         V5YVSScPxac1qxnVlAtrNImOGDnncKPtnxFGyvMSDMlJEGpNmLAoRDcUx386pM28OfCK
         hTBPyJBN4zF2A0dZePGOF3dqJ/0rCEB87maJRBRvr8GhCzmw5WanRvqLDbkLjugVu6qv
         E3qL2yu9ixnNurgzTBq51AGp2Hwq3xP+qKKbwl18nv5DQ1nKDNSFvCOCuER7jlfcGuPA
         EgkSPoBFVJK9zk66laPni62x7Jha9MnTmDN4AUc3xuPzox3cVKVBDvZZJJLcGvCmWOlC
         pLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880856; x=1728485656;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbv3ILFUVeEmssaFHftgOo6dWe6k4rKzxdcBQPU2ScY=;
        b=ayyYx3I+EzS4MSuzYUjvpiCMme97gGu3jVwdPPBNdksslerYHUR3ics2lHYZV8QNdo
         owP9ZVfZl4keLSvL1yA3aLc4v3y1UDoxYzZpizUwdl40Dzjq87qY2tzDKodNYfpFTcfN
         LGBUV3Gg87DaQ5+KejTerPMcfeO90VB6OpX3KHweWDXWzqMVmiP0n0+n+P+ih+wpi2+U
         h9sfhwHuuUS3qzDDxoRSLTkP28Jrc1KZr6oxdwgAsirJZDod8+UOqaX22F+gdoYVNSVL
         Gcle5v2lpQ+87AN0gcqbDjVtoHQL/3ISuFuUxu4/2rgk1ZLfsI3iTQva1428mX1kTvDL
         hWhw==
X-Forwarded-Encrypted: i=1; AJvYcCVPJemTcA38bZR5U3VwOxq+OPx997Ij+9VYIq9GeB/wmTni5+3/ZAxNO41BqsVpGJF6uzAUT8+/zhlspxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yLFG6bQj1jG5pJcDbMjOlk/QnReckYjNRe64Du+cZtpTfsHh
	U3yuO153jX6Fa30jywKLmC3t6e4277IQLbWa1DojARXoIUDUxMpWOYSBcTo9QNg=
X-Google-Smtp-Source: AGHT+IFoM2JxYmW+j01WwZCBfufK95aNjZnSyv8OBtphS7Log3eS4QA/UaGnv4HDmpWQz8FsbSyE4A==
X-Received: by 2002:a17:906:6a02:b0:a8d:3338:a48c with SMTP id a640c23a62f3a-a98f821e810mr331037266b.7.1727880855998;
        Wed, 02 Oct 2024 07:54:15 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:75b8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2946bddsm869783366b.123.2024.10.02.07.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 07:54:15 -0700 (PDT)
Message-ID: <b5093703-1c86-4706-9e54-b6d2d413c417@suse.com>
Date: Wed, 2 Oct 2024 17:54:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] x86/bugs: Clean-up verw mitigations
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: hpa@zytor.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
 <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
 <fe2dfd0b-6b2a-496e-b059-0600d2ae474c@suse.com>
 <fdda8f74-4d9a-4aff-ad5b-c7a1f2b0ab0b@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <fdda8f74-4d9a-4aff-ad5b-c7a1f2b0ab0b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.10.24 г. 17:46 ч., Daniel Sneddon wrote:
> On 10/2/24 07:20, Nikolay Borisov wrote:
>>> +	if (boot_cpu_has_bug(X86_BUG_MDS)) {
>>>    		mds_mitigation = MDS_MITIGATION_FULL;
>>>    		mds_select_mitigation();
>>> +	}  else {
>>> +		mds_mitigation = MDS_MITIGATION_OFF;
>>>    	}
>>
>> BUt with this logic if CONFIG_MITIGATION_MDS is deselected meaning
>> mds_mitigations will have the value MDS_MITIGATION_OFF, yet now you will
>> set it to _FULL thereby overriding the compile-time value of the user.
>> So shouldn't this condition be augmented to alsoo consider
>> CONFIG_MITIGATION_MDS compile time value?
> 
> CONFIG_MITIGATION_MDS is used to set the value of the mds_mitigation variable.
> Same goes for all the other mitigations touched here. Those variables are
> checked in verw_mitigations_disabled() which is called just before this code. If
> all of them are configured off, we return without enabling any of the mitigations.

Ah, indeed.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

