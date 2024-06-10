Return-Path: <linux-kernel+bounces-208373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDD5902427
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E0D1F239C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2696613212D;
	Mon, 10 Jun 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoDT1lQd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FE130AFC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030043; cv=none; b=bKQNimeOoElur9JWhs4V3AeElcL0UFwWIPhxi2VU4imM4VVOi0iqrhEraDaznK7d0/lmPjod6GYLtjQhAThPSoyFPdKbJKNA2/G1hm/pefCGT/1WmHs7TXhxyTzmS53BiR0cTPmYiIkPl9Ts+goZF7Zri0HTLsT5wDEtaVNOPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030043; c=relaxed/simple;
	bh=KaiotnnIG7JlV5ktLvb4ITJmEDcfEaWy8aXFTBSPAWw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q5jhtEg9q7p8yeQY65cf2kDtKrz0YrQs3vyUQ36zYPYjijbL/TivE8Idkd1ZbIkVbjUw/RlpQYBW1aC3M9LdyZxiQ2vb/kUsumdr3upFcgNluGVdsSSZuRMVrfTxWUx6QV7sxndIQMn6xU8eRBgnfThpbb9zVQJjXKGPhV+HwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoDT1lQd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f09b457fdso177713466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718030040; x=1718634840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E3GG5XXobvKjAZfA7PiVHtxRsMACN+t5KN+R+O7yXqM=;
        b=VoDT1lQdP2sG9p8GWMVL3nRjuX2mIzi/yzIJHA2oz0zh+IxAF04cxjB/HktGO1+tVf
         1x4hcNDRPPkDmK8xYF9brQx81MoC3PPIoC/3JWvyLVosxYDtaGch94GkIH76lHVogJiU
         E5k76nRPTZyebXr4tMFBPXfSEiUQZoC+w+WbR7tWUqUoM7Pn0c2DMV1XQMczA4NQinKB
         UGOuoAmAWGaTP47MiN6UEdRqfXgtEe7cs6N9n8lLH0Wf2gchHe6taCZxB/aVK0hVhYmx
         aIi4W3lH/cIt1i24N5ULDJvracWFlwTx3WdvM3DpF06arDaNb4cCe149JYpuiQGUD8jn
         GzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718030040; x=1718634840;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3GG5XXobvKjAZfA7PiVHtxRsMACN+t5KN+R+O7yXqM=;
        b=mPcQ7Hgn7tNmhxjpiCcGupPSBWFxWDk28basGC96d2PMeMNjPaXkGLj/uKQWfpkaJD
         GSR+CYmnB60U3EQ7D7mOoLmVBSewLGZFtjNrFVttUkkutWnfuK7PL4CqlljHO+44Vaej
         7+IuJyYPmqkHAB47hZvTlin7lWA87T5yV+eA9RK28sFwMTYu1chHa+cmRTh0ZOu5EYcg
         bFIuKNQp7vaVzBkmr98ugTMIoBfX6Om/ZSxRWVN2wJBcnL/71Bvt5fscv5qXFfrJA6P8
         Fq37tEzbR7js1ajtcbVW9MHWtmWh6L0bW9Io7RFLIOJMMWrTDPcAvQ/iJ1bb/JkoBqKL
         b2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUbMeP2v8sBPl5a0pCfq86RSpXKbjHX23kXTpKPMjq8HngCb8ha/Ia4pU1XDmSPKArKbVDkzKlT/DkkRACTSL33/sHn1caYh0g8yIr
X-Gm-Message-State: AOJu0Yx7PJy2uj5MyGWM03QuLPyAwx4AaA8VbZ96GMp5I3HyqiDIou2i
	BQIoTCFjcQ2MxYX9itqbb80EsOJ13zv3Qf6UihpHANaQD3bDdoTO
X-Google-Smtp-Source: AGHT+IEXptukpboZLCf6DOn3vAUsLYvh18GiqGT8z6pVfXgmN374h/RR/lx3N7wpxf43P9IJYFrXzw==
X-Received: by 2002:a17:906:3e09:b0:a6d:ff12:5bd1 with SMTP id a640c23a62f3a-a6dff125c77mr503625766b.41.1718030040172;
        Mon, 10 Jun 2024 07:34:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:493])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f01a060dcsm337538366b.182.2024.06.10.07.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:33:59 -0700 (PDT)
Message-ID: <1ca65f97-572a-412a-b6fa-b1e811592094@gmail.com>
Date: Mon, 10 Jun 2024 15:33:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
From: Usama Arif <usamaarif642@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
 hughd@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <Zmb6r6vrP2UTDQrK@casper.infradead.org>
 <acb76cdb-a54e-48e0-ba18-a2272d84f0ab@gmail.com>
 <ZmcITDhdBzUGEHuY@casper.infradead.org>
 <2d52b1a5-4c44-4cea-bccf-57972ca79f04@gmail.com>
Content-Language: en-US
In-Reply-To: <2d52b1a5-4c44-4cea-bccf-57972ca79f04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/06/2024 15:14, Usama Arif wrote:
>
> On 10/06/2024 15:06, Matthew Wilcox wrote:
>> On Mon, Jun 10, 2024 at 02:56:09PM +0100, Usama Arif wrote:
>>> I am guessing what you are suggesting is just do this?
>>>
>>>      if (is_folio_zero_filled(folio)) {
>>>          swap_zeromap_folio_set(folio);
>>>          folio_unlock(folio);
>>>          return 0;
>>>      }
>> Right.
>
> Thanks! Will change to this in the next revision.
>
>>> If we have zswap enabled, the zero filled pages (infact any page 
>>> that is
>>> compressed), will be saved in zswap_entry and NR_WRITTEN will be 
>>> wrongly
>>> incremented. So the behaviour for NR_WRITTEN does not change in this 
>>> patch
>>> when encountering zero pages with zswap enabled (even if its wrong).
>> We should fiz zswap too.
>>
> Will send the below diff as a separate patch for zswap:
>
> diff --git a/mm/page_io.c b/mm/page_io.c index 
> 2cac1e11fb85..82796b9f08c7 100644 --- a/mm/page_io.c +++ 
> b/mm/page_io.c @@ -281,9 +281,7 @@ int swap_writepage(struct page 
> *page, struct writeback_control *wbc) } 
> swap_zeromap_folio_clear(folio); if (zswap_store(folio)) { - 
> folio_start_writeback(folio); folio_unlock(folio); - 
> folio_end_writeback(folio); return 0; }
>

My mail client seems to have messed up the diff, but have sent the patch 
here 
(https://lore.kernel.org/all/20240610143037.812955-1-usamaarif642@gmail.com/). 
Tested with test_zswap kselftest.


