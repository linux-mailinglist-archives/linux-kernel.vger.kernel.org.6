Return-Path: <linux-kernel+bounces-396720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA09BD136
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB69282CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5E1552F6;
	Tue,  5 Nov 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0GyxO+XG"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5514A0B8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822204; cv=none; b=RtI6gvUUUC/taNghHPKsEzrlGSbPfLLdX62NyEWDTwrM4OX7Voa+UGoAsVshbHFhrk7tJzXDIX/9Ppzf+ls3JO96FkUjs6Qp8MCNv6OakKmgSrNlXn4cWmLJvl4aL2xj7uoyGSKOUqeUjxV0sLse1Au0E9v06MG0z+nILlvRTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822204; c=relaxed/simple;
	bh=92AZh3kx5JsENG6GS8STIOKISYRx7SKwMhQXCM9A1yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz97jULYAieUbF4whxgjFiL6+bkZvNAm4dRdjHzWvhoAiXYTgRM7Fahcy8MqvszBtJcfETcMsY7TVZn/T31HAuj0Ig6z8niOaw6f6fW5kJjM8JcvcTWIqh0flvYicyDn2GpPX/7/8413CaBKa3BbdcZz23Tb7oTJRq032cHTB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0GyxO+XG; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83b2a41b81cso221196639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730822201; x=1731427001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j86P/j73xXbIc0Sgbkjbx26V1QvrkTI65ukghjFGMbQ=;
        b=0GyxO+XGL45lmduMLnuq0OiWXZ6X0HbnNNhUA7+lvrm2qFUvRR8XqrAHO1+IbSPt+u
         NvK+ahX0bfd7FafDNIAzTNtbVzDDEUqvcEwZLahekzBGWBcEMJkP6YMO0xiZNEFO/04A
         PaGHPa/gZ5XdXVsUg46Hbf4CUI1S+pgJ1Gim2gCap9/2YxrDlCs/FE4jygwx2vqc6+xU
         dAdojLcVAckV4FR9xzdOVcNX11EBsFRJjHHPTpNN18RB2AIVa6iDCM0PDPmj9c5wPDhj
         GwcZZRr0SmwnsKee2ntw+me74QOYnZ2+hFzRrZaJE0LIuNLBjsvJlvQozNW8cdflgQWV
         SOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822201; x=1731427001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j86P/j73xXbIc0Sgbkjbx26V1QvrkTI65ukghjFGMbQ=;
        b=PwJEVw0Mx2ULtRagq2W9F7WmLOd1XCYH1/jsv/7rtjFrAtGlM9SZigpESymbo9o04n
         9AcAPGJhNNUb7w+ywbpQcPKaDrrq215D3WDlfta++1/6hHxWpp7obe0pq+1NH3rnX0WW
         k368O9lAuc7KcnLI8GZOZa8ryaACNo9QaHu2gK7k7EjaTk2G5n3FjyW5aPK+8Y9jO79X
         iEP869OtEMOY0WH+yk6VVOPCagSiS4lQsJbYFum9dgLfQglW0PdipiwtRxnStm9TqiDe
         bhpzWLazMGdAJVAFEpjuXkyCPatG16QAymRu1JQ4+59+a6szW856LIwvBZjgI+mvE3L4
         +A8A==
X-Forwarded-Encrypted: i=1; AJvYcCXJVhAg2x/CTd9oXSSzgxaxasoAR9wMD/aHtM6Zi6UC4XftNFnH0Z9R8iKUKRCbISWTvf2x6mXWZZEjxdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDeJZAJ1DmMcLA0byw/PGhcs2iXa1ZEknhOtAMFw/nto9jE/s
	/TEnMVhwHsmhZfZcCY0T4oJZGX9toIlTL8Iv7JWHRr7aZjpA/g16aQacJv/4oTI=
X-Google-Smtp-Source: AGHT+IGilxiFrTN0q87owPzZjbrVhQuTpfBPdHKU0L9k7569VXUC7mgu1negXK7Gs7JhHxoT1KW3aA==
X-Received: by 2002:a05:6602:490:b0:835:3ec0:9 with SMTP id ca18e2360f4ac-83b71a1b34cmr1422609139f.15.1730822201494;
        Tue, 05 Nov 2024 07:56:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de0497812fsm2460484173.96.2024.11.05.07.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 07:56:40 -0800 (PST)
Message-ID: <5b55417d-6b27-4186-bcfa-d6952624e99f@kernel.dk>
Date: Tue, 5 Nov 2024 08:56:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test
 variation before object free at line 583.
To: Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <lkp@intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <202411050650.ilIZa8S7-lkp@intel.com>
 <20241105153422.GA7132@lst.de>
 <e86904d7-bf42-4b38-889e-3978e89358f2@kernel.dk>
 <20241105153733.GA7219@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241105153733.GA7219@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 8:37 AM, Christoph Hellwig wrote:
> On Tue, Nov 05, 2024 at 08:36:33AM -0700, Jens Axboe wrote:
>> On 11/5/24 8:34 AM, Christoph Hellwig wrote:
>>> On Tue, Nov 05, 2024 at 06:52:25AM +0800, kernel test robot wrote:
>>>>>> block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation before object free at line 583.
>>>
>>> Does anyone know what this warning is supposed to mean?
>>
>> It's supposed to mean "use refcount_t for things like this".
> 
> Have we finally resolved the performance problems with refcount_t for
> fast path operations?

I mean it's closer, but it's still slower. Will always be so. Does it
matter for zoned devices? Probably not.

I don't think it matters for this case. It's not like the ref itself is
something that is user controllable in terms of being able to get
anywhere near an overflow.

-- 
Jens Axboe

