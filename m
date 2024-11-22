Return-Path: <linux-kernel+bounces-417716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA29D5846
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618E11F235DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48970838;
	Fri, 22 Nov 2024 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRoxEP6U"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F62309AC;
	Fri, 22 Nov 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242315; cv=none; b=nulxX4xaLYtZRRWWZ4534jlEUXWQYJv0YECNoW2Q82K5tMAwodYizKNYhHM53MlOaALmS7Zp+sgwSwZOZ29eKJk0QfUn54VC+7bLzX3RvCKJFn3pRwaGXoj6qgr+FlBxavJU3q3yHUG63lQMDgwt7BLP0C/L1t8GNEwEfOreH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242315; c=relaxed/simple;
	bh=pKM4mlHB4z2bF0hncW5P/3Qmuyp7hCGw/atY1GdAfrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obBR8Pa87Yug4hVJwSH6gJQXGUafHsK7+KaCNYO+P3NWMFxP+FuoBGIlDn6dScTHlti+KsctsAGbtrFWpP9ur7BB83Qh+wp5clqJJ6bWrBlBS1TfikPADoseTi8jnhUsCNK8C2EUyfYh3dQZdOu5xQDX3JKgDx7LBATsW5eXYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRoxEP6U; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so229707a12.2;
        Thu, 21 Nov 2024 18:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732242313; x=1732847113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gc2soC/8z+9mXZZwtqt5EFFOwjjp39gwmVDTOM8H2o=;
        b=RRoxEP6URNI0Yfy96bwIiJXsKM12SQOzj5mfdnwhod7p0xf3oXiAl7Qvbh78NTc/UU
         rgk+lpsXi1ozGDzox0fs0Iykj5eLruoKscYYHiN/qskI/FVFhipbvSMDAk8JZ7Y4ND40
         tCUkt9r1xU5HLvzmGYi+CTByMYCVVxPs0UlQM1fk/8+EbM2dAgSzFdKlYRuoBXGZsTXm
         DoOor57lePAlBaRN6aAAPlwRaCSQ4brMPwlH3OwbO7vHJE1sZCSFtU3+D1G6HqoUY1xe
         /Sc0zXe/9CTDT1qzOzb0Xwk53RQTs26L2dMJIopwGZ2Umm9qNkQFKyZAlFEfM1stW46n
         ZW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732242313; x=1732847113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gc2soC/8z+9mXZZwtqt5EFFOwjjp39gwmVDTOM8H2o=;
        b=ANIdfU7KrGZ1fH2DejWR4OfgDQpUNF4M+f2k80iNyMzZZye9wLa/NzWnQGHDzW9Bnu
         bO53WzL/AgE355TfVw3GI7Xokvxtp2UwvsnH16vfkHVhobxknUNQb3eyrVZacetHGr8Q
         hoxz7ReNFpA3zn2JH6HkA65u+kCc9KETQ/Sz4MjMbCNkRtjxuQ3AcSxbCQuaxyur4YKF
         UYNXk4wje/f54Z/poC5WeLHHUjtmIFr9bI7Miykjqjq5fEsrvI1S3iNGOGL0orfBCnz+
         F9xCX/L1HjcaZT+/0RF3EeVDYzgeB54VDSCt94jnL7hbAD2+uWeDV5MjL76zQCDKQb/n
         R5uA==
X-Forwarded-Encrypted: i=1; AJvYcCVjEkN3DXkoRZVEztxfjB9GFFFtFk3KqvIT0WoRV+dTfl0PWCc2hguUihRf66Wd1Fdd9+7yoBavzQONy2U5@vger.kernel.org, AJvYcCWf9kM5aBF4fRH88MVvakdipx7DeEl+sZUskAwm+Nt5Z4TS7CACoSSVYOAFMvopqROdAqNZnliOarQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweF+6RzaHpRF9uuHPCMda/AgojCcsPzjHkwPQ5cxlRa3j6K8IP
	0nx7ty26lLRpGWWl1KRzjy/GLYeSyVL5UG85U2WnIgvh/EYcKHmv
X-Gm-Gg: ASbGncsMwd1OjBMTRu4kvXV828SAPBNFFuBG0WJqn10OHbLzsKCioVb9sJceEYC697t
	+qmiHOccF0WB1SDA9HIUEmW3qcXoDsnbTo3lN1mKROpkS+Oj8boIhcqqx1j5YrwmG3R9lHMeqS2
	xKCOsa7fpFpiCfBphPdMZbNicdUKiWFTol8Mfs8pj1nx/YJdm1/moXXPnAygB/LD9ex0pSHRTS1
	K9R4OLaxy7EiDJTIwBplSRl68Ny7V3zlck1SJJv4K5viozemYFS8SLL4g==
X-Google-Smtp-Source: AGHT+IEeXMF/evqCLvxPyuGGHVMX+yhco3bGpUNgP66IZpJkIcoAuPifLVFv0cOeNBYwoDbII7iLqg==
X-Received: by 2002:a05:6a20:244b:b0:1db:eeb3:d06d with SMTP id adf61e73a8af0-1e09e4576admr1697224637.21.1732242313231;
        Thu, 21 Nov 2024 18:25:13 -0800 (PST)
Received: from [10.192.35.46] ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5763edsm483712b3a.187.2024.11.21.18.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 18:25:12 -0800 (PST)
Message-ID: <2c641b7a-4114-4cc1-b87b-052e973b33bb@gmail.com>
Date: Fri, 22 Nov 2024 10:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add per-order mTHP swap-in fallback counters
To: Barry Song <21cnbao@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Usama Arif <usamaarif642@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241121162735.9558-1-haowenchao22@gmail.com>
 <CAGsJ_4yA-jaeUG-4i7eWwnrv1=P7ujivYq37btOFg8LwnhQAmw@mail.gmail.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <CAGsJ_4yA-jaeUG-4i7eWwnrv1=P7ujivYq37btOFg8LwnhQAmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/11/22 06:32, Barry Song wrote:
> On Fri, Nov 22, 2024 at 5:28 AM Wenchao Hao <haowenchao22@gmail.com> wrote:
>>
>> Now large folio swap-in is supported, but we do not have a method
>> to analyze the success ratio of large folio swap-ins. Similar to
>> anon_fault_fallback, we add a per-order mTHP swpin_fallback to help
>> calculate the success ratio. The new counter is located at:
>>
>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin_fallback
> 
> Well,  this could be useful for profiling, but why not also add
> MTHP_STAT_SWPIN_FALLBACK_CHARGE ?
> 

Hi, since my current testing scenario does not involve
MTHP_STAT_SWPIN_FALLBACK_CHARGE, I will soon resend a V2 version
to add it.

Thanks.

