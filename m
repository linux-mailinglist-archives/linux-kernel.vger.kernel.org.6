Return-Path: <linux-kernel+bounces-289464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA695467D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BBA1F21E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4C170A2D;
	Fri, 16 Aug 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YsOzddN9"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6916F8F3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802835; cv=none; b=hFXZdRrlDdlGmhGQgTKOVw8ayWJPYw167k2snjEkjmu9t/AKC+wo516xESOYyIByPrUVEdhApVmcxhd3SI9LWB5sUBH6eQye8h2+L2FoqdwGTaZw8d2gog4rPQBDWTS030xerIqYFKNHT0vQSuyMfbRzckIlvORJ5d7Ej3ktvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802835; c=relaxed/simple;
	bh=TrbEblL//fCnxivRWQhd3ICfG3RXBIKaA43UAzvZ+9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md28LI0u0mGg3nl6fNU8okReASJHkbMSyMSo5jCfTeV/5E6Tf8OUXBOvkNaEyh6wKwwYZDOchYB0f6CjrTpjuGLoYda/mQFaGjIK6QvultdHlzIKvyc0IJx/+U3kewtSaqsMofMvWxRqJw5c5twJXru4/B2SkrmDwaPxHWoy4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YsOzddN9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201f577d35aso1275665ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723802834; x=1724407634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93vQey3dDE6JBhZN9kNrawrapBOr++CGqyUNfno2weU=;
        b=YsOzddN9FIBdT62J1XsInLMpr9SLqyDPsPD09vdjy5P0VX41m5cRuCuh3tZSRh/fy9
         UITFCBjL/l0YGW8AyWOCxPi8meqnXA3XbZJnuPvBEkEM0z+muelYnds9z6bpqw04CbQL
         PqEdQm22uyC3Tumlj6TwrSO+Ih/aHKwNyynEbJxl+3o1L1M6/bEiHbJEA9Nqzz2Dq8dA
         cKKABZgtzkO52aCV4n7JCcDJ1il9VmnnoPsBnCBEMrAjWamTM3etXqelk8rKTSVCVOnF
         aQr4Dgt8nW2ztKed8uQN7tP+0fpJITrWFaflugLGoJZSzAF/bWtfEmOkULgth6qt7H7X
         LUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723802834; x=1724407634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93vQey3dDE6JBhZN9kNrawrapBOr++CGqyUNfno2weU=;
        b=qT2tf/g/XG3BAZ/iLMpc7wxCwSh9LlFTYXiZ4RIzufIPLikOPBbYPZJQreCCArp60H
         16+wKoFOaxr/m2xrxJ5uVVWRk7/MQNqMtG0B96Q+aycOb6zq7bjphhBxEGsMrY2DK5uY
         cPmr3Z5rLcTo+DiP9Rlj0JDkJHRMLXJUVno/aVbmleS0o83QR0soa1pf1JYRUN5cRQ3/
         HC29u/64uSN+mpXAq13Ho0IbbEGAx9schXRWAWp+sTyJTaPVgkFJahQLdM2go5F88oD6
         Suj/Tcn6oO/h5RZ9Nr5NNJ3AgrpDtFxD+GpWzgNoUZJnREBEMwfX2o7JQn8ej7uv6Gqd
         ji+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoB0sn+JQAoEDDJSevjUxJeU8PdbhmksWo7K/+J8Loy+LMogJ+7Jy28ZxPd4/VL5wPusxuaO8CQamhyDTMu9/OR7aCohwdglH2wFJ8
X-Gm-Message-State: AOJu0YzzoICu3k4MBagDehaoxqY1vnOETP3l8w6YVVDtlXxqtTS2l9UO
	IwG+L7L/Slw0UJJqW58IU4GjP0o781nqKc+aWt8VeLI94SSGpgfTVdd19jFduOQ=
X-Google-Smtp-Source: AGHT+IEu+ZMhZK1049mJK07ABG05W7d8WoCmPbx/I9BJgsBBIh18yKl0kVCZJRq3L5M6TimThj6PvQ==
X-Received: by 2002:a17:902:f546:b0:1fd:d740:b1c4 with SMTP id d9443c01a7336-20203e76303mr15907145ad.2.1723802833603;
        Fri, 16 Aug 2024 03:07:13 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0395457sm22648795ad.208.2024.08.16.03.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 03:07:13 -0700 (PDT)
Message-ID: <bff5b6c4-7bc3-4f77-a35c-1b1c56319f0b@bytedance.com>
Date: Fri, 16 Aug 2024 18:07:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in
 zap_page_range_single()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
 <2659a0bc-b5a7-43e0-b565-fcb93e4ea2b7@redhat.com>
 <42942b4d-153e-43e2-bfb1-43db49f87e50@bytedance.com>
 <b0b39543-498d-4b08-a864-b05be45f617d@redhat.com>
 <860f45d7-4d75-4d67-bf2a-51f6000cd185@bytedance.com>
 <2d757ddb-cd20-4695-a978-ea413881d9b2@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2d757ddb-cd20-4695-a978-ea413881d9b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/16 18:03, David Hildenbrand wrote:
>>>
>>> (b) if we didn't have to drop the PTL, we can remove the page table
>>>       without even re-verifying whether the entries are pte_none(). We
>>
>> If we want to remove the PTE page, we must hold the pmd lock (for
>> clearing pmd entry). To prevent ABBA deadlock, we must first release the
>> pte lock and then re-acquire the pmd lock + pte lock. Right? If so, then
>> rechecking pte_none() is unavoidable. Unless we hold the pmd lock + pte
>> lock in advance to execute the original code loop.
> 
> Try-locking the PMD should work, and succeed in many cases, right? And 
> if that fails, we could fallback to what you describe.

Ah, right, I got it! Will try to do it in the next version.

Thanks,
Qi

> 

