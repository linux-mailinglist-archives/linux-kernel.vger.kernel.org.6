Return-Path: <linux-kernel+bounces-404308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEF79C4238
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745A4B27883
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A41A00D1;
	Mon, 11 Nov 2024 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ASQzsI++"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675D25777
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340644; cv=none; b=GZbw5CR/g4ivX5vWdzW0nnPTwUI/J7GfuPdTIjme0cVvQTAsORyBj8hAEoIPorJ9cHk9V8vOqBK5QfJHRYljP1bI5C8Om2vqk/vT984bZS8Pzm8LDMOwZhfFF2wp68mTUZshG8DpSvhfcD3E5TcnA3X2+JwE6677aapOGB7wkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340644; c=relaxed/simple;
	bh=/Ezjw7iweKivIIad7vOgJKgtvb4WVv8UnM9lGfTv6Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4dlDrDGelg68TnBDoefCN7Gl1SP6GturouEN/zYA0xJr1rSq7WCcEtMqw8nyTaE0qoj0mv2RYQpH81Fgandj0acpMw9DWyAYdmwy5Swxtu+e25i5aZ0ftoNP2WB3QH/kzcgwNZLFClSGxD6Bqc35muzxA/EsaGeNC9SV0UfJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ASQzsI++; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee55fa4b31so1810547eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731340639; x=1731945439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ju3j5igJOosMwn70qDznK7zcecUMPNasKKnWD2d241M=;
        b=ASQzsI++4fC+THxAREH0hheEtWa0toeeo5LgkTR1+2NYGzmOrKS9GjUmcOKZC/gxdP
         ptI5M7h1XlTvvkq+QSKqKQR6VWxpGyCpgBAMp6Hlc/bZDVmAUwwcafaoACAyH1v5Levw
         8gZtOzoOoDJ6v4g0GJ73lHfoySHKV3BcuSy1KGO1Utn8WiSw92tpyyBDDWcjn+QrqGQS
         2FM3cLmdW/7N8nhNG8ZrXYCRGhoED9svuiGo6eTCLnDfvsiOROC3MYU0PXmfRNXUfaZu
         dio6ZXwFNuO7iZdlb0VKbcLmkfVZnu+WQBhsu6tQu91n2dXkWNLl4VV/7GYv7uFhs0FM
         XXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340639; x=1731945439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ju3j5igJOosMwn70qDznK7zcecUMPNasKKnWD2d241M=;
        b=qBPBzKFKJ101n6XfJhvPnQO7P3MVFySGrm0NMg5CzYRdbs6by135uh77EQ8BHfda8z
         UEFiMV101Vs5ppcGSzZg+jVZljMrLiEiOfsYdZIVem+rj1j5nIQqaPxMlJudtvLEzFhA
         GgU75IPUong53cfJUt5DlcZALjm4IMSltQY3TvCRQJBbbmLhSBgKoKZCMCzn5SSbogC5
         mn/OfDe/lN/PvU7hK26zNOptDgG4hkMiRP6gt9UPH654CU0fk3oSlVG7pVmBi8KPQ2W8
         W96LHea5x08r6xV36AEKzbPFcZUfc1Q8hQWlsTovwGui9tuuFFcx0rNfC2HSN52DhvOM
         RC5A==
X-Forwarded-Encrypted: i=1; AJvYcCWXqSyurFyfjnGRkNraG89YefBBgmtDn05g716krgQQ6OzAF7k01LRc/TCvDT77cU7QT0LpkawNDNuoJHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WJgtzmnI6NLICpu4Pk7u5fXjJCX8ExSrDBsc3TrP4ceLoVDz
	p8PskJcChmOcKWvYavyGgrUcRaRat8Lz3hxJnf2VMEqxAdukN/jfZbxz+fNGVSM=
X-Google-Smtp-Source: AGHT+IGaR1PqbbjtaiXdsjeWdZcHVhMIc95tbonrmfCgnNUfOPReGyI9Wcp+ZBXIqvomwXE4PDwxzA==
X-Received: by 2002:a05:6820:179a:b0:5ed:feae:d5bd with SMTP id 006d021491bc7-5ee57cc4966mr8725265eaf.3.1731340639428;
        Mon, 11 Nov 2024 07:57:19 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4952777fsm1975301eaf.26.2024.11.11.07.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:57:18 -0800 (PST)
Message-ID: <9f86d417-9ae7-466e-a48f-27c447bb706d@kernel.dk>
Date: Mon, 11 Nov 2024 08:57:17 -0700
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
 <1c45f4e0-c222-4c47-8b65-5d4305fdb998@kernel.dk>
 <bi5byc65zc54au7mrzf3lcfyhwfvnbigz3f3cn3a4ski6oecbw@rbnepvj4qrgf>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bi5byc65zc54au7mrzf3lcfyhwfvnbigz3f3cn3a4ski6oecbw@rbnepvj4qrgf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 8:51 AM, Kirill A. Shutemov wrote:
> On Mon, Nov 11, 2024 at 08:31:28AM -0700, Jens Axboe wrote:
>> On 11/11/24 8:25 AM, Kirill A. Shutemov wrote:
>>> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
>>>> On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
>>>>>> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>>>>>>  			}
>>>>>>  		}
>>>>>>  put_folios:
>>>>>> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
>>>>>> -			folio_put(fbatch.folios[i]);
>>>>>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>>>>>> +			struct folio *folio = fbatch.folios[i];
>>>>>> +
>>>>>> +			if (folio_test_uncached(folio)) {
>>>>>> +				folio_lock(folio);
>>>>>> +				invalidate_complete_folio2(mapping, folio, 0);
>>>>>> +				folio_unlock(folio);
>>>>>
>>>>> I am not sure it is safe. What happens if it races with page fault?
>>>>>
>>>>> The only current caller of invalidate_complete_folio2() unmaps the folio
>>>>> explicitly before calling it. And folio lock prevents re-faulting.
>>>>>
>>>>> I think we need to give up PG_uncached if we see folio_mapped(). And maybe
>>>>> also mark the page accessed.
>>>>
>>>> Ok thanks, let me take a look at that and create a test case that
>>>> exercises that explicitly.
>>>
>>> It might be worth generalizing it to clearing PG_uncached for any page cache
>>> lookups that don't come from RWF_UNCACHED.
>>
>> We can do that - you mean at lookup time? Eg have __filemap_get_folio()
>> do:
>>
>> if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
>> 	folio_clear_uncached(folio);
>>
>> or do you want this logic just in filemap_read()? Arguably it should
>> already clear it in the quoted code above, regardless, eg:
>>
>> 	if (folio_test_uncached(folio)) {
>> 		folio_lock(folio);
>> 		invalidate_complete_folio2(mapping, folio, 0);
>> 		folio_clear_uncached(folio);
>> 		folio_unlock(folio);
>> 	}
>>
>> in case invalidation fails.
> 
> The point is to leave the folio in page cache if there's a
> non-RWF_UNCACHED user of it.

Right. The uncached flag should be ephemeral, hitting it should be
relatively rare. But if it does happen, yeah we should leave the page in
cache.

> Putting the check in __filemap_get_folio() sounds reasonable.

OK will do.

> But I am not 100% sure it would be enough to never get PG_uncached mapped.
> Will think about it more.

Thanks!

> Anyway, I think we need BUG_ON(folio_mapped(folio)) inside
> invalidate_complete_folio2().

Isn't that a bit rough? Maybe just a:

if (WARN_ON_ONCE(folio_mapped(folio)))
	return;

would do? I'm happy to do either one, let me know what you prefer.

-- 
Jens Axboe

