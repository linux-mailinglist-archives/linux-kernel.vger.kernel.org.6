Return-Path: <linux-kernel+bounces-271333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F27944CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61855284386
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1581A0B06;
	Thu,  1 Aug 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPCtFnDN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34431A0730
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518141; cv=none; b=UaT40wKxso9HDZ4WvigzODpjq++NNSZND/HOa6nYkxLSDK7yWElcfHHgrjx7xLPfRSz6U6eBAOOLwckflfxW+UM+FgloDqbVuAxNb0SwqZAf7JHaOihZKyydLNdojIQUcVyzwfBXTMEiTrgMt4yIXFkoz6VfSUw3wuQpYMYPOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518141; c=relaxed/simple;
	bh=QBgtodtwQJ+kFedjpd7fkkeS9PNhdpSW3gaSnEgAY7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ8RCeIJzYAuZuGTRV+x4ua/TrwDeUk6+528L1oXTGsVHrqzxyZWBhpE0uQhhiKNbw3ld/9mAze3nZTvDgFlvLZ++Jps9qUGrejZhFdLNeq+q1kQSnNaNYeZFMNC6pFdazttlJ66+MBeNVnNRNghcrqUngdvGEHEbmjzXLMdgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPCtFnDN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wd4qOkTqfMM6g/u7n4QGd4KiakNqVtFE5pbeVVa49Rk=;
	b=RPCtFnDNVqYXI8LutrNRlHRlgzq6BUa5kEpowTZ8HbMh2bIcJmNJ0NLplsGEMc9mwiaBxd
	bOo2rrUz707SerU/VNXWptATpPmjzo/QOwK4rZgjp3YOnyN57uuxtYfdDipiEFd5ZfTqtM
	WRMlVHUGyKPbr0SGxbDLF2UYqiF07Uw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JSVvHrqePUKjiHAC9kQWEg-1; Thu, 01 Aug 2024 09:15:35 -0400
X-MC-Unique: JSVvHrqePUKjiHAC9kQWEg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36841edbc32so2850702f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518134; x=1723122934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wd4qOkTqfMM6g/u7n4QGd4KiakNqVtFE5pbeVVa49Rk=;
        b=RikXbqg/+I+/4/TH/FwIuAVRpVgwQGDjTP5qlVTjZbbWB12AqebZ1zlb3VCL35eFA/
         OhpxTA6K/qgVK8LjpApZH7z6QsWmTcPYsq0xpl1+JjmkXYwINDw0wOaUNp/P/OmVuAeb
         ade12ZOX/qF+d5cDaBPhSWaM29GicCWinJqZG7zRuNt0gmFHr61dOmaSFC28fQ5UPILn
         wcSafQHImUsuL8t12ssiaD/MnqsRP+OGfz2u5ILPHz1Tb0t9C+bvFPnjyow1IR1GeU4n
         I/HTcFVct+RBAfcMXOV01wsIHHhI6Yu2kzka1E3LDLcbzquIt8LOZnU4zZsva/lUIlbo
         DAbA==
X-Forwarded-Encrypted: i=1; AJvYcCV3X/87+cL5DO/H8qESa4emHZO63kS5Mz6cxpVIXyAQzWM/tvvlH3X1I3XeOpHDwPkwpbG4pg2sOdHwphQtd6S+p0M3xyLGFBoy9nbu
X-Gm-Message-State: AOJu0Ywk1Nmd5RnOyEwzm+CR+RvWJ+QlC8EEzASKuIJofWiOeU6rAhDS
	TJxmKJqMVRTtuzfkg3ECl+qjqaJycd5rsMu4p0sia+8p/sE3GlJcKZM07zK10itD7CmXPqlGhK1
	PFpKZ+3lpZIcU9ryHGj/Y5b2775KwjChelFNOvtK4IFaX2f6HC8LLb+XViNTZWQ==
X-Received: by 2002:a5d:4d08:0:b0:368:4b9d:ee51 with SMTP id ffacd0b85a97d-36baaf7d868mr1495340f8f.57.1722518134382;
        Thu, 01 Aug 2024 06:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4oQP5sVfIhdwj+jxrMRInm5TFk1QF8i2F6vKw9MjWwYsIa4liqP1hoO2y7JgLlMAcpplK5g==
X-Received: by 2002:a5d:4d08:0:b0:368:4b9d:ee51 with SMTP id ffacd0b85a97d-36baaf7d868mr1495299f8f.57.1722518133858;
        Thu, 01 Aug 2024 06:15:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863962sm19381811f8f.108.2024.08.01.06.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 06:15:33 -0700 (PDT)
Message-ID: <3636af63-8865-4ef5-a2f3-2a6538aca873@redhat.com>
Date: Thu, 1 Aug 2024 15:15:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 akpm@linux-foundation.org, willy@infradead.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, osalvador@suse.de,
 baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com, will@kernel.org,
 baohua@kernel.org, ioworker0@gmail.com, gshan@redhat.com,
 mark.rutland@arm.com, kirill.shutemov@linux.intel.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <738342dc-4a87-4dcc-a515-a9dc085e3186@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <738342dc-4a87-4dcc-a515-a9dc085e3186@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> What I am still missing is why this is (a) arm64 only; and (b) if this is
>> something we should really worry about. There are other reasons (e.g.,
>> speculative references) why migration could temporarily fail, does it happen
>> that often that it is really something we have to worry about?
> 
> The test fails consistently on arm64. It's my rough understanding that it's
> failing due to migration backing off because the fault handler has raised the
> ref count? (Dev correct me if I'm wrong).
> 
> So the real question is, is it a valid test in the first place? Should we just
> delete the test or do we need to strengthen the kernel's guarrantees around
> migration success?

I think the test should retry migration a number of times in case it 
fails. But if it is a persistent migration failure, the test should fail.

-- 
Cheers,

David / dhildenb


