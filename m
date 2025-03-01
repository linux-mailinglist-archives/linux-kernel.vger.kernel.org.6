Return-Path: <linux-kernel+bounces-539738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A22A4A803
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F35177D6B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95431B95B;
	Sat,  1 Mar 2025 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R1WOGBfF"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332A128819
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795746; cv=none; b=K1CSdF2haz17S0srKXLhwROesBR+Mb2EPrV17/ZIrw/tllgng7ctCXPRV69EEWWuzGvR5NA6JKceHHCxaL2QISy5svbG8bhybFRyLBgWufyt2vVxMPkq5wlCtiwTOAC3IrLqV5F0bi2NFMEv9WmOzj1Hc9e0QvRGxA60yw3tdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795746; c=relaxed/simple;
	bh=2wTqxOXtafVmEkthQzwVuwSao99tForzQfDyN7jLsyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9TRFW5HplTqG5j2TaCTWpHXzizUkPagArHhM7fU7Ug3RMrbWwjpTgEf5bMDeWrI2ebJ0mRXDuk76SbNtr7kFkeUujSMMNSM3r8LDOuX5RHb49clHXkt8eQ/CF2UHchJyhpdrrDVceC9YZAJj1aDJe0uAe+omg0NTubUKdfmg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R1WOGBfF; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e60c4412127so468269276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795743; x=1741400543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Im0HMDK2H1242B1xgpvNQP5Lm6a65yD85HN7f6w03Y=;
        b=R1WOGBfFFc6G/H0jwjIn+UY5DuLCMM4K/jlKR4xN7wICvFP1v8SVOb5+Qf+T/0vn8m
         vPPk13ZiT7ejC/jOfD8+5iofUTemqNpMmemhOpDFEiwgrvvDpOiXoXjsqK6R6fgz3/8q
         IcR3OocTl/CWx8EjdPLmJCkp0npKW07HOuK4Eb+xiQ2i311egxiixaJRQ5tGRJkM8jsI
         NyuomHk7TCTEV0unIGq/GZUd3Et6f/ws3ACNtStZAEwJoQCdVGgYTDbrjDdu3R2Sqvgr
         5O/w40x42GkxsJpLW5OTpQ85nQICT5Hnz9rdepYJzGse3YwoE6yNi3NPrUS1ayKrbQv7
         TEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795743; x=1741400543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Im0HMDK2H1242B1xgpvNQP5Lm6a65yD85HN7f6w03Y=;
        b=quUEwYOWuSCnWoqEFRg3ezzJgDYMEtbvJe+FKz+HdUhqJ98ZGvF78spxkOm6KaEKj7
         y7fTMo3faXkXPExkBvd1yNUUCL1rjmsLg+SUZgaGfWui3vyZZeyP7TWQbRHPcIAXy5hM
         r2wOs9MO4yZAhJOXeemga5x2tbell+eQqjoS1hFLxz1cbTtTzZKptzfsYCn3geojCynt
         +RiSo/MX7KCGQ+0ZIDuKn1ZattlEG19VeRxZAaBN3zUb/c+gkyURj1qLvngiB8oRD+Eo
         k1sA3qR/vUqzfA0I0B+ReiNf37Q6u2wV3ebIQLX5WU7qfRV8ehfi7h0JOaer7j59pbUE
         GpZg==
X-Forwarded-Encrypted: i=1; AJvYcCXR6s/XVDjYHes4NtIJT3JoejkRWVNyAL5Tp0YJWLVyJXZzyAU3r5nBHj9B2xGS0jRroxjhvMdWvalXNLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnS+U/pmyIbwOW5WdBuiiehhisrlWa9XoBHqdmnWH+P/oFCJD
	Ut2v4qn9nwfgVmoOtjNPVW4UUahAdvFT1oR1fXx4AgnpAm1wWWM8vqedDtkL1To=
X-Gm-Gg: ASbGncs9EZSW9tCtRPYfPSsPIcl/LMX1sXvx2F9DvW5SPpCrzguuxFd3R+x92ml46IY
	KeBm/lrh7gw+GYEhoYu39PfHDHfBoypRmHr/UPs+UFJVZ2xSYhfP+PsFPJ4y2fgVv/kA1W13qG4
	7MDRs7u4QGhl/JOaawmDDY2EiSjPyPyTS1O4gCL2VlPjDJLJCCSGQyzSZx4JSJ7xtoEXwJxjJ+U
	IiFH8YW2SoySKcjt7v5viBm6lWEG5dbETkyEGuYc6naycMgVwRsrH+MP6Z2h1vq+olx4u+qJpQB
	YGnKBI3lUeao/UKWmd5PtefEKYhhCIcIYuJqyyBlYziE
X-Google-Smtp-Source: AGHT+IF2+WLZ5LJ+vXsSgmDSjOUgyyxMU8EfMTjGqndYoP4XYbvHhyH+4d96gcwBTsElp6mLxtVU6g==
X-Received: by 2002:a05:6902:2209:b0:e5b:45ec:b841 with SMTP id 3f1490d57ef6-e60b2eaa326mr7252333276.12.1740795743226;
        Fri, 28 Feb 2025 18:22:23 -0800 (PST)
Received: from [192.168.21.25] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3aafebcsm1408282276.51.2025.02.28.18.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 18:22:22 -0800 (PST)
Message-ID: <76a9617b-b1c8-44b0-8355-948758f6e70a@kernel.dk>
Date: Fri, 28 Feb 2025 19:22:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring/rsrc: declare io_find_buf_node() in header
 file
To: Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250301001610.678223-1-csander@purestorage.com>
 <86d5f210-d70f-4854-8ecf-eb771f26685a@gmail.com>
 <CADUfDZrOoSgT5n51N5=UFSum96mj2MAytQbJNbBVC1BJrmNVtA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZrOoSgT5n51N5=UFSum96mj2MAytQbJNbBVC1BJrmNVtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/25 7:04 PM, Caleb Sander Mateos wrote:
> On Fri, Feb 28, 2025 at 5:45 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 3/1/25 00:16, Caleb Sander Mateos wrote:
>>> Declare io_find_buf_node() in io_uring/rsrc.h so it can be called from
>>> other files.
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> ---
>>>   io_uring/rsrc.c | 4 ++--
>>>   io_uring/rsrc.h | 2 ++
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
>>> index 45bfb37bca1e..4c4f57cd77f9 100644
>>> --- a/io_uring/rsrc.c
>>> +++ b/io_uring/rsrc.c
>>> @@ -1066,12 +1066,12 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
>>>       }
>>>
>>>       return 0;
>>>   }
>>>
>>> -static inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
>>> -                                                 unsigned issue_flags)
>>
>> That's a hot path, an extra function call wouldn't be great,
>> and it's an internal detail as well. Let's better see what we
>> can do with the nop situation.
> 
> I can add back inline. With that, there shouldn't be any difference to
> the generated instructions for io_import_reg_buf().

Yeah, in general I don't like manual inlines, unless it's been proven
that the compiler messes it up for some reason. If it's short enough
it'll be inlined.

>> btw, don't forget cover letters for series.
> 
> Okay, I didn't have much else to add to the brief commit messages. But
> sure, I'll add a cover letter in the future.

Indeed, cover letters are always great to have.

-- 
Jens Axboe


