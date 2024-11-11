Return-Path: <linux-kernel+bounces-404283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E39C41E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BD1F24D37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C731A7264;
	Mon, 11 Nov 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R2KFoCXZ"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BC1A7045
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339094; cv=none; b=TtGK54Vm0VWuppSBDt43hHprr6frDh6jeeziY6vrkKW6EMdJvy8gZQh7gERoWFgW+7SpWIy2hMSHcReBN8Mcus7d0XpwVOdEWCwy6m1QZAEFfxYUkoQ5Ik0c3yqHjV+sNLnR18skbcjQ+2teZxNv/uVUVYV2BoY6PvBxUjl8tM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339094; c=relaxed/simple;
	bh=nGzmnUJ0XCr1W6HLEg7Z5lxVP05+5l/MeSpfHWFa4jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt+7iNI5be3Z9tpvF/TnTHEceeF25SBRB5QAGiQici4PgjGq+KEIoUi6e0fQxH58BAYr0DzOTz2NS5c6XQZhvn45Vg9O8BtP8hm5E+9djFQuaGEI1Gf6l6X/M3NXGcohl7sLmwZYjFPKCfh2Z/X0UQhnn3zolx6ameer3dApHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R2KFoCXZ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ec4a40e95bso2072921eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731339090; x=1731943890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1DPFbMMG0bghAJqjBOvnibqygsBLp8K2SmGdvme5is=;
        b=R2KFoCXZ2SThKL8B8X1S8CaAkHRN+IAXCgn07XGYzCJCIjiLY9MdsMXB5PoZ+mB0dJ
         EBHnSrS2G99jJkSGXgBIKk1mEatmI4JREcIWbtgahFvg0J4N47iGpO2nNC4zL71D6gso
         4mn+TlmptOp1u8zceCtKlcFVpXeXRfT6SMegdH/DfNDlLSU31griAjoccanSHX11ddGB
         40v9nE42CiqK1upP0mFyAmTYM4yMWTi/tk8DFBQ01ssEAtcoHt0E5MmD8hYymcb5Y+WM
         yQHEA9cFWJRVQ8z+fzfO2eY6Wy1J+lXCtQxRk0WYG2KqZacLu/2ZJrnSn57EkvbJn2OM
         H/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339090; x=1731943890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1DPFbMMG0bghAJqjBOvnibqygsBLp8K2SmGdvme5is=;
        b=hlv4f64GJZc56l6TWCeEGW5q+1iT3TNssrxlECbCJ8rbYRFXhCppn0rd3j6Xj3Aw/N
         FIvywxxQvWBt3HLqLsWQ8AARaTGJLobpcd1fqrKZk6SwefKFuns2qNZSemZy8heqTpjh
         AMRjC8mdR7CY0JhUJ7/nUTxkkjO1bp8c3QMK4Cxs8i9Sr8cVLh5CpVEAIPVCH7VXHkFr
         PiArblemwv+p+djmVzlr3/2MYMd5Rte/vQSlNCN/AiF6N0RFOciiXpMTUNf45bDenOqA
         TGcrxt5FXrpMEioRex1Pm37IF6ozWT5ymPcivj35Cc0YPoPWhTtFuW4IGSlL524oVN6I
         Gsvg==
X-Forwarded-Encrypted: i=1; AJvYcCVpuca124hCnoAyCBU/ax/KB6hXmCWg02EHByln8sMrnQ7URUPDY5sxOdw2M+jyhnN4HNthCfcYf14uCVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrp99wB6oq+hTwXC8OxCar+42fk1m4+dsvsacP5e+s9ooS91D
	Zu8LH4L4avZNsh/Bn3+4a3TgfzquXRsLsSt1b9jJYRZioqTUb0SzYjzkbrEc1Js=
X-Google-Smtp-Source: AGHT+IFBBwgd+HTtvajAHT7N6ZkZWk9/6qqxXByCJTHv0OS2DvsOrYQmAs9Ew4IfnM6+AX9sX5K17Q==
X-Received: by 2002:a05:6820:1e0c:b0:5e3:b7a6:834 with SMTP id 006d021491bc7-5ee57b9c8e0mr9694042eaf.1.1731339090154;
        Mon, 11 Nov 2024 07:31:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb142sm1943666eaf.5.2024.11.11.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:31:29 -0800 (PST)
Message-ID: <1c45f4e0-c222-4c47-8b65-5d4305fdb998@kernel.dk>
Date: Mon, 11 Nov 2024 08:31:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <kda46xt3rzrb7xs34flewgxnv5vb34bvkfngsmu3y2tycyuva5@4uy4w332ulhc>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <kda46xt3rzrb7xs34flewgxnv5vb34bvkfngsmu3y2tycyuva5@4uy4w332ulhc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:25 AM, Kirill A. Shutemov wrote:
> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
>> On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
>>>> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>>>  			}
>>>>  		}
>>>>  put_folios:
>>>> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
>>>> -			folio_put(fbatch.folios[i]);
>>>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>>> +			struct folio *folio = fbatch.folios[i];
>>>> +
>>>> +			if (folio_test_uncached(folio)) {
>>>> +				folio_lock(folio);
>>>> +				invalidate_complete_folio2(mapping, folio, 0);
>>>> +				folio_unlock(folio);
>>>
>>> I am not sure it is safe. What happens if it races with page fault?
>>>
>>> The only current caller of invalidate_complete_folio2() unmaps the folio
>>> explicitly before calling it. And folio lock prevents re-faulting.
>>>
>>> I think we need to give up PG_uncached if we see folio_mapped(). And maybe
>>> also mark the page accessed.
>>
>> Ok thanks, let me take a look at that and create a test case that
>> exercises that explicitly.
> 
> It might be worth generalizing it to clearing PG_uncached for any page cache
> lookups that don't come from RWF_UNCACHED.

We can do that - you mean at lookup time? Eg have __filemap_get_folio()
do:

if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
	folio_clear_uncached(folio);

or do you want this logic just in filemap_read()? Arguably it should
already clear it in the quoted code above, regardless, eg:

	if (folio_test_uncached(folio)) {
		folio_lock(folio);
		invalidate_complete_folio2(mapping, folio, 0);
		folio_clear_uncached(folio);
		folio_unlock(folio);
	}

in case invalidation fails.

-- 
Jens Axboe

