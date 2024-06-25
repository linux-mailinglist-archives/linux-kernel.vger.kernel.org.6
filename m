Return-Path: <linux-kernel+bounces-228974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C7916942
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A38289043
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8015FD16;
	Tue, 25 Jun 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL4XaXwB"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE615FA74
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323063; cv=none; b=eaCwc6JkR/Ya4u09vDLOqAEcNVh1o6JkLBsstbRCCjQuDPsE+x9UZarguDonFdoX4R23FdHreFR/IQ3Mv6Vz6KC3Wwh5XANHSEMRjoG4u8CbyMFkcxn173YjwIE0/guN05JImHAq44hMPOUNTVGFLT3zkaZfjb4h+XJjhJH1glo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323063; c=relaxed/simple;
	bh=Zo9v/PZoNhTIUSu4h2uiVSNnpfaE0rPwssujIxYqbYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd5mJPD1gdEtHHf/AsdvDTXX/aVSqUKVMiw1HqmiA/XzHhS0YuG8goFJjc2gQUqUHoUKBv8w6EWJoMVb5yROVLOmgpdOM/NwNwr0LrY8r++2RMlb9z7QXA40YNHpXKTamr28wsTT6B/3kvKg36vumWcG9pTQ2OUVZY0cJvcoxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL4XaXwB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70673c32118so1961771b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719323061; x=1719927861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAl8J4MqP+4c3Z5hB3+MKmFrhSggCFQ2IlAm7f5yZiU=;
        b=nL4XaXwBVxo0FwvrhmTK+NL3XPNHCN/VAuqVpww8sdl/iO5RYTEYR0plAmjZr6USXo
         P+awfVsEJtfF4UETk/MRUqowt9biysWxPbxkD/2mRdoFXVTvtqO5EkZ+D4Pjr/DN6NUV
         XbcE8tw/LFpgTJJuuTp+krTE49EUx2qdqPulyhGlEqleDWvV1m7+m4OqUTtDb2VPSjhV
         nY0Gc6wPtv1qkCfZCMbWEBxof3fSXMl2whBBJL+jaZmByl3hRhCAHVRJL3YzzlLwOSTv
         svubmhSaY03kpnmSUwnxTn7epshmsyVRikLvQ7TUcoxI2KXSKPw4/d2Q9LT/6oE5iQhj
         tRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323061; x=1719927861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAl8J4MqP+4c3Z5hB3+MKmFrhSggCFQ2IlAm7f5yZiU=;
        b=ShlScAygYI0v2ez0Jg+jZF1MxdDrm92T/4KFfw4wIBd0eBQFhiUjRh3YKHgHzkNto2
         bosXuIGhB3JePzTRF1ouwJtTpDeZNEv4ACV7HOBxE3s3xlGYRv9QW/unWSmN8MtCVy5A
         qMdCZwYiQPNDZ3OBOeE8d+HMfJcdQ9YjA4w1fVVFo/mOcZ8S+pgBkvZDsKi6qzOhORve
         ecYcaONvwFYxuK+IlpgyaZRIV5FosbZBGWqNZAxtZsMuW/9tZMfRq9CO58561URJnYZC
         7unbQhA2Ht42rZMD10lnGQYcoiw8VcJkoZwEfzRp1IHi3npyvRfKMSJMe8TINP9/tcQp
         61Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWNAjrvgj9Y8h5fuuH4L522/jFD+pE1FrQbAwpVfnQhO2jg2Yroo30yEnx6+BcPI4XfH+otvbyJgGw+TXf1HvirnJyTvxGkM7Q1d+Ng
X-Gm-Message-State: AOJu0Yy2ARZxOOh9RfUcK6OBaCloC6zjab0NCb9tPJC/lVsgjIw7751/
	tFYgc8ZloM4RhlKCUL7BnhwbLjXQuGFJdklTIn6g9sEMd4zCEveU
X-Google-Smtp-Source: AGHT+IGIn3SURX/Iou535swnaQy0A2CsGueDkYGx96tHZzoERA4ZhGtMlE1BiwXsPPB0yNnw2rfcGw==
X-Received: by 2002:a05:6a20:dd97:b0:1b6:db6c:11dd with SMTP id adf61e73a8af0-1bcf7e6a5d8mr6325808637.9.1719323061188;
        Tue, 25 Jun 2024 06:44:21 -0700 (PDT)
Received: from [192.168.255.10] ([101.87.0.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbbc1cbsm81095205ad.282.2024.06.25.06.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:44:20 -0700 (PDT)
Message-ID: <c7b7122f-9f90-41cd-b030-763e03fd4ba6@gmail.com>
Date: Tue, 25 Jun 2024 21:44:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: Yosry Ahmed <yosryahmed@google.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com
References: <20240621054658.1220796-1-alexs@kernel.org>
 <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
 <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com>
 <CAJD7tkb=VNa6PLi_3gTvLbTFEnspmvQdScFf-CQ_KofdzXRKJQ@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAJD7tkb=VNa6PLi_3gTvLbTFEnspmvQdScFf-CQ_KofdzXRKJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/24 6:30 PM, Yosry Ahmed wrote:
> On Tue, Jun 25, 2024 at 1:11 AM Alex Shi <seakeel@gmail.com> wrote:
>>
>>
>>
>> On 6/25/24 5:46 AM, Yosry Ahmed wrote:
>>> On Thu, Jun 20, 2024 at 10:42 PM <alexs@kernel.org> wrote:
>>>>
>>>> From: Alex Shi <alexs@kernel.org>
>>>>
>>>> According to Metthew's plan, the page descriptor will be replace by a 8
>>>> bytes mem_desc on destination purpose.
>>>> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
>>>>
>>>> Here is a implement on z3fold to replace page descriptor by zpdesc,
>>>> which is still overlay on struct page now. but it's a step move forward
>>>> above destination.
>>>>
>>>> To name the struct zpdesc instead of z3fold_desc, since there are 3 zpool
>>>> usages under zswap, zbud, z3fold, zsmalloc. It looks like we may extend the
>>>> zpdesc to zbud and zsmalloc, combined their usage into one.
>>>
>>> Please do not focus your development efforts on z3fold. We really want
>>> to deprecate/remove it, as well as zbud eventually. See [1].
>>>
>>> For zsmalloc, there is already an ongoing effort to split zsdesc from
>>> struct page [2].
>>>
>>> [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/
>>
>> Hi Yosry,
>>
>> Thanks a lot for the info and comments! It's my stupid w/o checking the email list before work on it.
>> Anyway don't know if z3fold would be removed, jut left this tested patchset here if someone need it.
> 
> It's partially our fault for leaving z3fold knowing that it is headed
> toward deprecation/removal. FWIW, I tried to remove it or mark it as
> deprecated, but there was some resistance :/

Yes, It happens. Community is too huge. Always someone want sth.

