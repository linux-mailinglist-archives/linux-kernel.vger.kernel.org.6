Return-Path: <linux-kernel+bounces-431995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF89E439B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2763F28181D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899CC1A8F81;
	Wed,  4 Dec 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vVTHbReP"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9626AFC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337814; cv=none; b=Cxme4ELrmGyvgbJlVvtfrdmCVegcEo5ILchZkV1rJVunTh6Uo+3vtUfT4TQXZcvQsC8tZ8m414EuYQtiHi3zzzhMNpWmckLnMj0FPl6XBxpAxTny3EBATGHIPqAXO6MGou3LLt4s9rk/626HFJJyh0WDtWbvQIPnygjDc3IPdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337814; c=relaxed/simple;
	bh=EHUHYmqryRs/Z/xAHGeMfA6OuDGlUTFwWoqL2vGZRRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjd4CaqBqZFKniZ0xu3lt7YMoibwGJz7VbQlLEF0JV8dVGNra4hGhEuYPXabWvhWhxj6l4LPyGB2aZcG8OdITEaB+42LSqsgxMVGfDVBUyz8UpmCtV1Sfi11zabQw+OmtJhLLsDEczvRXa5yAe55Ikj9aMMM9l7FwSIzYLDTSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vVTHbReP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21561af95c3so372565ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733337812; x=1733942612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy/Up58FD+Iwl3suRccXqqaWRSwiHYWxV6FovUOd6tg=;
        b=vVTHbRePJ+rRdMLTZ9kYdcrIANZCcqGVKDjW02DgLB6rHGXsNRFNOCBxkT79ZuSSQt
         G5Dn5fwXFWQXifMN9bV0Fr4j3CW/Y1UKG+NbwECoJL56jtJ0icSK9HzBN8uVrQpTz/am
         JG66wvf61i4k5mG6zDCh4HKFqKwA3cR0bV3V8Wkhg6kQLINflITNd6BYjP0nKtwPN5HI
         5pa0pdipnEQy5KOPxb3fgrTW6LpPphca+p74BIfS/yB/blCjgIt9ObNvMRjUojwB3sgL
         BEts/ma74k28qfsX/j8Gz7FACNk6EB8oMS7A9p1DWCxvKj4I2aQLZXttlHtBJsiXN0x9
         zBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733337812; x=1733942612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy/Up58FD+Iwl3suRccXqqaWRSwiHYWxV6FovUOd6tg=;
        b=LdXqn5bHHsRwA9s7DFmry9KH/nRFlvKlLlHnG0moOWSUG4LG/MKqbvU0S4CEwuMb4D
         l8pub2QjuKYV8effowPhIB2JluPpfAnTGVxXGYGIU/LXvwLpUIMci3XzpN9wPeUB9HhJ
         m+GUeU0FF+oBTVUfTh/o1jW12G0JbXqCAJKAF+m7E8sVOo70RWBVtTPLZBdt0f9gyRmZ
         TkRsJYZ7D/2hPHep433PBBa6SqsA282DK15Fi7xjywiYe4IUCyEVVVB6cRmcFfR3l/0j
         G/8FU8eqdp2V1Q/1lJ8wrIG1KNTQB/shg8fJpQNe6O8Yiy1hzHTczy37PJy0maK35BT0
         WaaA==
X-Forwarded-Encrypted: i=1; AJvYcCXTxcFxIOLEcuOLysnkj+0VAeybHwwVIe7x7fHi22y+mx4Zks4xwin/9MjMhJ2Y9TF0sqJ2nviWbFrGuYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIIa3j5dwkOB4neAILm8M6uo3AsnoUF26LIv/Pmi3VtOrJ6EX
	qv/Y77nCA1E+L+YKVIk5CBJKImGXoEr8WzGseXtJQf6eHnDchnYf4ir0dVhGsB4=
X-Gm-Gg: ASbGncuuXyvOzpqko7OFyTRjghirXFyv+D8LR/PXdBPMgr3QP42xVTPaCT0hYW+tta9
	5uRmR/CJwXGb+VRoGxkF38MvkUEURtCQ3Hh0CT1UHRVcKPA0dX2G5D7QILXzxsE4CI7Jxh29S1N
	0zNWiND12Cv8kzAy2MYc22eULGiL8hwUxmQQzXstfYES+XTzGO3YgcPm4mAjGmUjgs86D8kIaGJ
	MXKe7Cv4hesaWLKX/HI8jPqEl3UP6u+EYPS3xa+WvesJz1WhqX15C3RMw==
X-Google-Smtp-Source: AGHT+IEhungpF9IDwEdc0oVMgZLsXxL8b0lcjls9v/9SUNlSkhwUS3+q8TtzRXsvpGsf6QAJilCCTQ==
X-Received: by 2002:a17:902:e5cf:b0:215:bc30:c952 with SMTP id d9443c01a7336-215bcea0b21mr104595775ad.6.1733337812102;
        Wed, 04 Dec 2024 10:43:32 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:f6f8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157145fd3fsm70721165ad.264.2024.12.04.10.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 10:43:31 -0800 (PST)
Message-ID: <9ddf41e2-bee6-4b31-a602-53b5485e0f6e@kernel.dk>
Date: Wed, 4 Dec 2024 11:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Write in
 sys_io_uring_register
To: Tamir Duberstein <tamird@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+092bbab7da235a02a03a@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Andrew Morton <akpm@linux-foundation.org>
References: <67505f88.050a0220.17bd51.0069.GAE@google.com>
 <6be84787-b1d9-4a20-85f3-34d8d9a0d492@kernel.dk>
 <a41eb55f-01b3-4388-a98c-cc0de15179bd@kernel.dk>
 <CAJ-ks9kN_qddZ3Ne5d=cADu5POC1rHd4rQcbVSD_spnZOrLLZg@mail.gmail.com>
 <1ab4e254-0254-4089-888b-2ec2ce152302@kernel.dk>
 <Z1CCbyZVOXQRDz_2@casper.infradead.org>
 <CAJ-ks9k5BZ1eSezMZX2oRT8JbNDra1-PoFa+dWnboW_kT4d11A@mail.gmail.com>
 <CAJ-ks9mfswrDNPjbakUsEtCTY-GbEoOGkOCrfAymDbDvUFgz5g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJ-ks9mfswrDNPjbakUsEtCTY-GbEoOGkOCrfAymDbDvUFgz5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/24 11:39 AM, Tamir Duberstein wrote:
> On Wed, Dec 4, 2024 at 11:30 AM Tamir Duberstein <tamird@gmail.com> wrote:
>>
>> On Wed, Dec 4, 2024 at 11:25 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Wed, Dec 04, 2024 at 09:17:27AM -0700, Jens Axboe wrote:
>>>>>   XA_STATE(xas, xa, index);
>>>>> - return xas_result(&xas, xas_store(&xas, NULL));
>>>>> + return xas_result(&xas, xa_zero_to_null(xas_store(&xas, NULL)));
>>>>>  }
>>>>>  EXPORT_SYMBOL(__xa_erase);
>>>>>
>>>>> This would explain deletion of a reserved entry returning
>>>>> `XA_ZERO_ENTRY` rather than `NULL`.
>>>>
>>>> Yep this works.
>>>>
>>>>> My apologies for this breakage. Should I send a new version? A new
>>>>> "fixes" patch?
>>>>
>>>> Since it seems quite drastically broken, and since it looks like Andrew
>>>> is holding it, seems like the best course of action would be to have it
>>>> folded with the existing patch.
> 
> Is there anything I can do to help with this?

I think Andrew will just fold it in once he sees this thread - but if you
want to be sure, I'd send it out separately with a note below the '---'
line asking him to fold it with the problematic patch.

-- 
Jens Axboe


