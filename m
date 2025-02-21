Return-Path: <linux-kernel+bounces-526346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5991EA3FD72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D687AE24F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85B2505A4;
	Fri, 21 Feb 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="S97xNopL"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAF2505AF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158940; cv=none; b=I/XuUmFkhIsUXjGMUlRC/qtXuPBbXrma0nNL5cMlDE09Tlj+1PBEr4WJ26XsJAnbFzEpvVXwPKYEIOGtjdoJ049hu4OYHT1spvinvBp5P16uUf0NsuXo9oGSFY7aNnDdulVY5cUP/vB3twYiudg5PWZ8XkXuKe5WYWWyD3m5gZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158940; c=relaxed/simple;
	bh=ssnP7xR5IX0s1ZnFseYvUfkt85pqBiRp2h4Q4S5mkyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXBNWSBiC0MIfAXBVTvPtmza7Es9bXWWlIcHqLoRm8g5Cx9YAVm7aBdFOsnZhoImFIqB9jQ0I+4E661dF4i7Js1GJYND9oiMC+PRhZxK+b0608xELnrjLTLE9OfE6xAFs9f0RmrBF4qQZX5sIM2TdqOL/NAwO9S1VszTnD0XF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=S97xNopL; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3cfc8772469so7767555ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740158937; x=1740763737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDZTfHmSgit6Hdb4LSC2+LwR3rhMNBxY6UI+uK+57J4=;
        b=S97xNopLG5OylwEM7sDy5EQavgtOf+MayQx9bnWjpArBWh3mp4EzY3Ef8X3nBfY1we
         3bwqKwCDMiErQeyihY6Bsm74VFfNAKPZienADefq/ObKYtEqymoWBZ2HMVdqLGyhzRIf
         YZqTGLKUg8sKR/ynQUL+QLbbKvhBr6+YvRR3BGoc6kMaL3cgA1VCienKbW2raHo2IBXA
         d3Ip7Uku46zFbuj3JtIruCf1N6eS/zvLdgkmcN9zc9+pUhV+ScICNER/NypUUha0gjlF
         KCVk2W99bX+ce0rS+AL7zADTbkWX6EyDubqLWx7eSCLRBmoPx18v15kgJhLqb08detDO
         V6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158937; x=1740763737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDZTfHmSgit6Hdb4LSC2+LwR3rhMNBxY6UI+uK+57J4=;
        b=asOXpL2CmScMRnp8NVaRe5mV89z9NUy3jw4HFCD/Ju9qLRBHIVpsTl6FlA7P3Jdp9B
         Di8HXU2C4PNeVV+RFkIm4nQ3Jk+EeUpiyePXJBJ0ZVjwy829/RgcGaxv2ESNKcdwA92N
         VjU+LwSpWy/QioinqOhTskSr7CpXT0UWKzBhIRlChb+NPFxFKokBrstaVEBnUYlAwOsH
         HtmjCNFAyVltvqtVkxk8qUDFr3POsq9ET+2Dp+dXCzeCB20hJu8i0W0ULcgsJIjNCCuc
         V2k2a4qGBFFU/vwaZjtnk9JK7n37XNQnEMnUnLyU69PG64N0O8fLcg9j86sYvpdJC1XM
         XuDg==
X-Forwarded-Encrypted: i=1; AJvYcCVxxRdznSuj4hpLimMIoS50Sx+kxoIL5GPS/KIvBDFaLDuARaHVXatnhs5dbNznsHiBnn1yilDNkIKbNY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIko8ZhtjfbHQjShUiQw9iBDXc/L3RDhiwDCyb68u6J1WQhlyI
	EBWxsDqXlU8nAVkEC23V0xkvs9JJscRlfRHTqkElSRxHCk/B6BDOsCJ6DNSVMrlQtUjzG7NfCM9
	M
X-Gm-Gg: ASbGncvl9hcz3tNZkBpWriLLNTfxwnwaId3d7kgml3R9LoAEdYkO5246XwwLhEG0doC
	dOCsBs3w8vUBJUNyQH1KsPprXnVnKfcLmRHL/DjLN0OUzKRt6ImZ4nX6f0uHCvwBucXhH1ktBhG
	9FkccZ/WpsiGAYYEAlP9WDWnSyjdayu9MbI1ajTUkWChw4wNZ68YaXSdygzUoGAxThihmD4IaN0
	8QjTGaIX4VPEJoyPJw7dXOktZYM8QzTOD/zT92d5p5z17BEGnNzMQsoDQNcZrA2OFbovWaPzljS
	I3NdzjeOokTJRmityPpjM10=
X-Google-Smtp-Source: AGHT+IESXRf1yl6h7PyEHQmBUGrv9XVl2XmLwA/QxwaTFWH5Y02ORzR6Hbof0RMkoUqPvVurTqR6Jg==
X-Received: by 2002:a05:6e02:1a2a:b0:3d2:6768:c4fa with SMTP id e9e14a558f8ab-3d2caf0980emr47338065ab.21.1740158937487;
        Fri, 21 Feb 2025 09:28:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee93efe46csm2701099173.132.2025.02.21.09.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 09:28:56 -0800 (PST)
Message-ID: <7980bc81-8077-4c99-88e4-19188745d3a2@kernel.dk>
Date: Fri, 21 Feb 2025 10:28:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in
 io_uring_mmap
To: Pavel Begunkov <asml.silence@gmail.com>, lizetao <lizetao1@huawei.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: David Wei <dw@davidwei.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20250221085933.26034-1-minhquangbui99@gmail.com>
 <590cff7ccda34b028706b9288f8928d3@huawei.com>
 <79189960-b645-4b51-a3d7-609708dc3ee2@gmail.com>
 <0c1faa58-b658-4a64-9d42-eaf603fdc69d@kernel.dk>
 <d510f0c5-d25d-44cb-9974-46026964beca@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d510f0c5-d25d-44cb-9974-46026964beca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 10:06 AM, Pavel Begunkov wrote:
> On 2/21/25 16:39, Jens Axboe wrote:
>> On 2/21/25 5:20 AM, Pavel Begunkov wrote:
>>> On 2/21/25 09:10, lizetao wrote:
>>>> Hi,
>>>>
>>>>> -----Original Message-----
>>>>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>>>>> Sent: Friday, February 21, 2025 5:00 PM
>>>>> To: io-uring@vger.kernel.org
>>>>> Cc: Jens Axboe <axboe@kernel.dk>; Pavel Begunkov
>>>>> <asml.silence@gmail.com>; David Wei <dw@davidwei.uk>; linux-
>>>>> kernel@vger.kernel.org; Bui Quang Minh <minhquangbui99@gmail.com>
>>>>> Subject: [PATCH] io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in
>>>>> io_uring_mmap
>>>>>
>>>>> Allow user to mmap the kernel allocated zerocopy-rx refill queue.
>>>>>
>>>>
>>>> Maybe fixed-tag should be added here.
>>>
>>> No need, it's not strictly a fix, and whlist it's not yet sent to
>>> linus, the tags only cause confusion when hashes change, e.g. on rebase.
>>
>> I do like using fixes still, if only to provide a link to the original
>> commit without needing to dig for it. And yeah there's the occasional
>> rebase where I forget to update the sha, but those get discovered pretty
>> quick.
> 
> Maybe a "Link" tag would be better or some more inconsequential
> "Refers-to", but otherwise you can call it a feature and avoid the
> hassle of fixing it up, and people getting spammed by tooling,
> and Stephen having to write about broken hashes.

Having the sha is nice though so people can just look it up. But yeah
the tag doesn't really exist, and I think we have way too many tags
already, which is why I just use Fixes for stuff like that too. Link
is good for email discussion, though 99% of the time it ends up just
being a patch posting and not really interesting...

-- 
Jens Axboe


