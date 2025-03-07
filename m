Return-Path: <linux-kernel+bounces-551560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41470A56DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28A8179FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFA23E328;
	Fri,  7 Mar 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XR34Bs0h"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5023CEF9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365510; cv=none; b=hndKojVy3laXI6rSBMcKYzQGLL75E8J9POxa1l/5J8DAr4mhjdbH/p6WwnuyrjqxgJ4c9tbI9GMx7wTmqzlHq3R8EOPT4FMkVZiNn6ngsVRfANb/924VNWqcsL728Gw2gjL1kXAC6jzdCBLWdNyPCdCuTncRVSNLwmuAXDzYwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365510; c=relaxed/simple;
	bh=pPXL/isy15to+99HM9MMDlj0lOJ6uynPfv29x606Wag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw/q3VWLx+XiouCIoWmvJ/LabNkK4RtSZGqxxU36NaO0Hq08GjTRZO2+PTIkj3SQF2Kwb9265BBwNo8UcxIRgEtpL9JDWhqdqL2fl7pcCqshkuRD5uzUQbjwWjMeLNnMq+gInqXtyoHXI8P2nC5HRuUREjXe6PGgje8xsJigMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XR34Bs0h; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85afd2b911aso57734139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741365508; x=1741970308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybA+5EEmFKNdJ63NMrvySBU5slBwFK6pu41iL70gnsg=;
        b=XR34Bs0h1PKgl1OahOyZZ9+5H1kBG+znbnAWm91pwVH3hOp2VM2XzUn2IK2fLqDDLu
         YIHqusyI/TjUSTuZNc7P9eIjynvFIlCViqlq6ZDO9QVxlIEkzZTLYXTvrJ8we9EdUrgj
         jfxPNYgfnHmub0MjrnzQjznxQYXaZFgM4j/G/tbi4rhN1lAM//X3NGk9osZlPn0d6UyM
         jWQNFEYMtZ0zdDSVRhIL/GTUMeaimEOxbhgy1lbQNgmfIps3ejyXImRSd4hqPAo3D4Mw
         ZeJrb1Y8RdfsBkrzFjt2Ss6FBOjhhF25iuLDKLgwfd9aAmgtf6UDS2okN71qb/f5WQ4K
         CFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365508; x=1741970308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybA+5EEmFKNdJ63NMrvySBU5slBwFK6pu41iL70gnsg=;
        b=MLtRAzipemGAgg/gpuGU34/3+wG3qEk/nI3xlmrWgNwIBl2qSEtcLhgGv0tEwNf6Ld
         YahUAXVWpM0XIvXhoDL/tHXk8UgLNYMPLIs5PYV5jemOjBOZasm62Jw0dS49LM8hRz9A
         uEtjUqRKYc9ksz1yXs/Fqgwa7BG/+xnYhSt6DseoECyjdOHRQt6dpLnixRWaRl7g1aL8
         wahTzafoTrMpB5kgzENSUhe/KE9j8Zjuug3DBv/lBRGc9OY/KJobAhw5InVMh2HZGWRO
         JWxA3LgWnOfoIMDP8az8cSYiaJb2yLXKB0HJ2Xa1OMqa8U9WXaV7P6DsUXkXuHs8Z+oh
         +KZA==
X-Forwarded-Encrypted: i=1; AJvYcCXk6HEgYZGpEf251Yx2GkWd4kEuE83qmHPGA+j8olRmVNiFVNyn+USAoVHWeL6pHX2oDJaEcX+N18V1Luc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzBjTIIH5B1o6ggI6nBNunBV9V4GGSqKCf6wBRKxkY56tVa8j
	ypdHL91wMsHjQ8Wu4rUCeu38pdDPw26OsFQYP9IKfmlf/ErIcDSBnN58iPvER9E=
X-Gm-Gg: ASbGncuK9lgJltyjBscVsOLVplbvau4q+Fq6RTD9M6QyROYOUVU8w9L97Qv8ESPJO2z
	g87B0VQtEjGElSB4CSoLCY8Y5nqpf4dNgD2M+2RMkebsoDfGfC40I0fGI0lf3r0HB5/r/PBPInR
	4IDmSpFkBtMyu7jC+ACHZWQxkHkS8dvBwu0LQW0ui1QTGbBY2Q/+8Fn7/y8bxBrVEFsnCdiBOYg
	/mpPqLyOPK9HGKacPcQHB+crVjratnTK+5aKVbed901pSq1fSkKwooQjgif1RW/TSO5ozW4LTCb
	36rPxzCTaUHgWf91j4jVnwLmcsW/GLF8i7FEy4rw
X-Google-Smtp-Source: AGHT+IFXnu+ZVuExRLXAMFL77qJU20P86s6MIkDCRS8MHKyVaXM1QMQX4366yYXTzscbD6IJMPtNRA==
X-Received: by 2002:a05:6602:4c8e:b0:85a:f8e6:d6c3 with SMTP id ca18e2360f4ac-85b1d125756mr460052839f.9.1741365507842;
        Fri, 07 Mar 2025 08:38:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e15545sm1022343173.41.2025.03.07.08.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:38:27 -0800 (PST)
Message-ID: <ccfd73e6-7681-4c76-bdc6-7dd7e053e078@kernel.dk>
Date: Fri, 7 Mar 2025 09:38:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
 <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
 <CAGudoHGina_OHsbP_oz5UAtXKoKQqhv-tB6Ok63rRQHThPuy+Q@mail.gmail.com>
 <5a0ddd31-8df1-40d7-8104-30aa89a35286@kernel.dk>
 <CAGudoHFE8D4itzs=DC14cJpRo-SNqJTz7J4g5B0VsjrNuE0_pA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGudoHFE8D4itzs=DC14cJpRo-SNqJTz7J4g5B0VsjrNuE0_pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 9:35 AM, Mateusz Guzik wrote:
> On Fri, Mar 7, 2025 at 5:32?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/7/25 9:25 AM, Mateusz Guzik wrote:
>>> On Fri, Mar 7, 2025 at 5:18?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>> +static inline void makeatomicname(struct filename *name)
>>>>> +{
>>>>> +     VFS_BUG_ON(IS_ERR_OR_NULL(name));
>>>>> +     /*
>>>>> +      * The name can legitimately already be atomic if it was cached by audit.
>>>>> +      * If switching the refcount to atomic, we need not to know we are the
>>>>> +      * only non-atomic user.
>>>>> +      */
>>>>> +     VFS_BUG_ON(name->owner != current && !name->is_atomic);
>>>>> +     /*
>>>>> +      * Don't bother branching, this is a store to an already dirtied cacheline.
>>>>> +      */
>>>>> +     name->is_atomic = true;
>>>>> +}
>>>>
>>>> Should this not depend on audit being enabled? io_uring without audit is
>>>> fine.
>>>>
>>>
>>> I thought about it, but then I got worried about transitions from
>>> disabled to enabled -- will they suddenly start looking here? Should
>>> this test for audit_enabled, audit_dummy_context() or something else?
>>> I did not want to bother analyzing this.
>>
>> Let me take a look at it, the markings for when to switch atomic are not
>> accurate - it only really needs to happen for offload situations only,
>> and if audit is enabled and tracking. So I think we can great improve
>> upon this patch.
>>
> 
> I aimed for this to be a NOP for io_uring, so to speak, specifically
> because I could not be arsed to deal with audit.

Hah I hear ya... But right now it seems to mark it atomic for any of the
fs based ops, which is not really necessary.

>>> I'll note though this would be an optimization on top of the current
>>> code, so I don't think it *blocks* the patch.
>>
>> Let's not go with something half-done if we can get it right the first
>> time.
>>
> 
> Since you volunteered to sort this out, I'll be happy to wait.

I'll take a look start next week, don't think it should be too bad. You
already did 90% of the work.

-- 
Jens Axboe

