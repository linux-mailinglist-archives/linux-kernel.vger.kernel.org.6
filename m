Return-Path: <linux-kernel+bounces-539750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE6A4A81F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512F1168DEC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A98615A;
	Sat,  1 Mar 2025 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JenOwQ3h"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEC3214
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796400; cv=none; b=Vph6Ubyng7XAFiQBIRauE9olU56WPIl/1sw9ZI7oeQxM7Ms4/hslguaRpYsTjcP8HAI21xwIY649YolExk090PTrrFS3TcHz53VCZ+WNS7Iuxp9KhB9E11flHh2fgwjGtcKdmwkzn+J8sBMsS4uxsDUclquXV77zD8oGG+8b+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796400; c=relaxed/simple;
	bh=7Wk4vA28rba6Vu9K4bmzBzhcMFB2S3VOwLvqpMjhBXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpksFp716n0cry0t1mDXEA++O8Hz/QLxnirVkP/HuARWdkDws2jc2MeWkqE0kOJk84Jl8SqzoyJF25zChp0ce3pf1STAfCOLPtoPDiqzLqGH0s68Tsxhff8nm0FUjLRFzWANDR4zHj2QuVMc562iBiOs+fdmPSFw3j0Awrbf7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JenOwQ3h; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60d2152855so1244276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740796397; x=1741401197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2Y7PV9zs0gYf8Tt1Gn9HqJp4Nessds6ztaeQH7ivPk=;
        b=JenOwQ3hcDOZ9HnSVjyMLD/UAKGBbDEDK0q+9AeUCNjvKfhWNwQzC4MDO+LKntbJOD
         gBo2XpiWN8CCLDdqdocsuSsV3bV7SU0vuWSDQPu4iuzRwG2dW2VzoV6A5U4o6ow9nD/6
         E4fL8Ato5FHs9PY/FvhRhHVqTCwbgP1txiVB45RcYJsQBIdxoiupv5ncihLfwoRqEmLv
         uBOhSmaubHILtjhajbCYu2vi0XnjWdtjeevsWs7mUT9zuT38/qbo7Y/J4kaxWZoZYIN+
         ZtZ7ma9ggma4L7oMfgDpk5ssyBLssQv4MzfJqQRB/IQ4GI7WKcdyavl0vcDXxNUfr+q5
         MELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740796397; x=1741401197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Y7PV9zs0gYf8Tt1Gn9HqJp4Nessds6ztaeQH7ivPk=;
        b=aIREVfBA4Zu+DTL6XKjcMpxIwtxD+ifuA9m2I3PegeoNu5lbMQCjDwaO4n8Z5KXDnQ
         gwai7XkMvpz53y+HX8N/j7YYXXE6HOylQQZq3w25zSokE/Xn3bxPVWvzSggawjgdNcPQ
         ZChvuF+ueXEk88u694PNLrpFv2xn1xDQtZhGqeURUS+BXwRL+xvLTKv1h+roSi70CSxJ
         hbnorYkiQUkjCTrLseZ1e83d69UFLCXRHrGN5Uc8UxcJTNZO5gU+tFHHb+bolJS0c4nf
         f904esXtD2BI7PsIa/o7l3LU611YrM2edsCO5qlPOuidGq2QeQXYHdp+CQdiLMk8rh1f
         i5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDOzX+PJg9MfiVTA757GSzCK/a7VnID1XOkWByc+VftQqxpBlJ3/5zS1eSmUp24MdjXa1mu3U3SouNAoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzomFcmcRYpext8ZKHiAXUN1zU+UGODcVg4zyrKcS+6avMPa3
	nbIdFVqnqlDJATHOT1cUDTgcJCvcA2CjcZLtQHclwLvRyprdXZUYlZiJVrB99mc=
X-Gm-Gg: ASbGncue2xrqC3KY8MJHd3ygZVvkbAncUthXRfPE5WitcyBbwb7e7XmH0QKVGZRdU/e
	j80crOAYyKbHNDnSt5dVV9nSUR9F8obwn60p92/b9esx8cp5a6um6j6/3UHN9468kbsD0M7uOH9
	s61UyIVEneKHTvAj/U/Q3L59c1zfXBYm0T7MbpLIcMEL8C6eykuqvEuvqIoVGNuehbsocYi4yG2
	qtuLVFUFg+pYSzBhNnUUaSCgDs6sLP4b4ML804TuiKlvZIwJUZ4pv13IiT2RUj3fJe4sIzGZ4MA
	lll9iM2MsBzzLQ4YrlMH5vkcR4+JF9mc5io0t5bH6wtX
X-Google-Smtp-Source: AGHT+IEqTFM9YEjBMYUxDbhMLqG/qClqzb+9k7zk9QMQQVoQYG6ZWANlTYw1+3HQFaRAn0UUpMn3CQ==
X-Received: by 2002:a05:6902:18d6:b0:e60:ac55:a68e with SMTP id 3f1490d57ef6-e60b2e940c4mr6040098276.3.1740796397510;
        Fri, 28 Feb 2025 18:33:17 -0800 (PST)
Received: from [192.168.21.25] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3aa530dsm1424867276.39.2025.02.28.18.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 18:33:16 -0800 (PST)
Message-ID: <8855fc32-3cbf-450f-aca7-ed9d201a57ba@kernel.dk>
Date: Fri, 28 Feb 2025 19:33:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring/rsrc: declare io_find_buf_node() in header
 file
To: Pavel Begunkov <asml.silence@gmail.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250301001610.678223-1-csander@purestorage.com>
 <86d5f210-d70f-4854-8ecf-eb771f26685a@gmail.com>
 <CADUfDZrOoSgT5n51N5=UFSum96mj2MAytQbJNbBVC1BJrmNVtA@mail.gmail.com>
 <76a9617b-b1c8-44b0-8355-948758f6e70a@kernel.dk>
 <f3033c30-8a0e-4a18-aeb8-82fa97020bc1@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f3033c30-8a0e-4a18-aeb8-82fa97020bc1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 7:31 PM, Pavel Begunkov wrote:
> On 3/1/25 02:22, Jens Axboe wrote:
>> On 2/28/25 7:04 PM, Caleb Sander Mateos wrote:
>>> On Fri, Feb 28, 2025 at 5:45?PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> On 3/1/25 00:16, Caleb Sander Mateos wrote:
>>>>> Declare io_find_buf_node() in io_uring/rsrc.h so it can be called from
>>>>> other files.
>>>>>
>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>>>> ---
>>>>>    io_uring/rsrc.c | 4 ++--
>>>>>    io_uring/rsrc.h | 2 ++
>>>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
>>>>> index 45bfb37bca1e..4c4f57cd77f9 100644
>>>>> --- a/io_uring/rsrc.c
>>>>> +++ b/io_uring/rsrc.c
>>>>> @@ -1066,12 +1066,12 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
>>>>>        }
>>>>>
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> -static inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
>>>>> -                                                 unsigned issue_flags)
>>>>
>>>> That's a hot path, an extra function call wouldn't be great,
>>>> and it's an internal detail as well. Let's better see what we
>>>> can do with the nop situation.
>>>
>>> I can add back inline. With that, there shouldn't be any difference to
>>> the generated instructions for io_import_reg_buf().
>>
>> Yeah, in general I don't like manual inlines, unless it's been proven
>> that the compiler messes it up for some reason. If it's short enough
>> it'll be inlined.
> 
> It will _not_ be inlined in this case.

Hmm ok - I wonder why that is. But if we want to force it to do that,
then we can just re-add the inline for the local definition, that'll be
fine with it still being non-static and available.

-- 
Jens Axboe

