Return-Path: <linux-kernel+bounces-406640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381AF9C61B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5E2285027
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968E2194A1;
	Tue, 12 Nov 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L9OxH6ct"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200F209F2C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440764; cv=none; b=jFgEx2CTexYtZsCAXS++x5pOyCL6B96SiFxhfHKJjIRKqCrWwxV+4LcCGmGqtE3rk00HWeCoVhunUQPdxLm94vsdIgLj4dU1FV7MaEqrK1kG8ZZfgbWGnUjwQtW/AVhkZ8wzxqd/mz9yNRHPgywrPv136+QT84tao9sZ+Lpg/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440764; c=relaxed/simple;
	bh=CFygJSYOt42BXHIJZ0lPyOQG6V1ipw+GP6J4+TYjQsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/Vgzn74o3YxmGLM3WpDOT2Tygprxj1QnftfUxLzcg/qIAYC0rfSPXgVeF9ycDf4iyG0wk7JuXlRCR80YVxduVPEvbWWnBgxYlab6d28fO1ZjnvSrRsNTO4I5QzqXHqrc021COxb2K/PAaSO4ErZXMvVwtcw1equlwRUTPklW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L9OxH6ct; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71807ad76a8so3527088a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731440760; x=1732045560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsF6zD6OvaOEBJsu7L/s70N7/2ObH2lGwYuQuMDN1eI=;
        b=L9OxH6ctxIIUIjEJ2zNA5hnbm2+oORGjvSsbF9No9NaRBafkYvzZPvDX9pIkV/HZf9
         guQ2yNj8ftNKxX6W/WvCPMR+ZEktdg0VT0mat+sjJCTS2RYvi5eLMtAWw5ehzdA4z7kE
         B/aOD898qIYxxiNzXCSDue71olU/xS8k5/t+JR+Alhr4eGx/Ym+nei8ysFF3Ct1mLNXu
         lSBKivdK+O5hj5YcKoRpNLKCf+tOJIp+F82L8KAf63+p/f+/CtsvjwwGUs6qaELSln3t
         nn8Bc5rJiml9sawGUqw0lE85nKq7YakZhYvD3vG1URVElfYAHGmu8rH2ugjSQCRSssPt
         a6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440760; x=1732045560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsF6zD6OvaOEBJsu7L/s70N7/2ObH2lGwYuQuMDN1eI=;
        b=XRfl+tFUi/UapPmXVFGdVLcCXqz0QgoULzTGpdS0Vg2MJnd/slHuHIfffa3YwHymlz
         DDKndubpkxnNrywW8d7uPojriDHsBHbXL3nHXzX0lZSI+wc/cwrQXtD2wrkoq4zCtk4j
         LbaHt5nIeyY2zcsy2v/eE/5+BUuH5wvaTaqS4JF7y2N5z31wjMA5VBovFfG88FlheNgU
         /k9ESm211exOKK+Gic0Nkcu2+gqVBd8fyY1C2Psk9f3UOPZwcgnvBVKBRZNyloKdEfLj
         OTXHpVTwc+YBrjiuiCg9OUgjeyFrBgGEkgmm1WByxKtv7o6o99oLd1YI4ER3OKqZkGiB
         rcsg==
X-Forwarded-Encrypted: i=1; AJvYcCUNKmyFSPT+7/duJsyP198Vo/BHSBRCHpAHPTQIFoQM8stkrxiqK4nJnyv1kLn18T62LzLdTEOTwqIE+88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYtIee4YaIbzm+OUVQq65gUz9NHnRahYg9PnRaUAKo36EB374
	NmEF782wATkRYPJKRJcJIjiAwX98W0Ts8yjcVU1lS23tpDpzqekrz1ISY9RnlIo=
X-Google-Smtp-Source: AGHT+IERZmUOMukb4CnBanMbzQhg1sYsbeOpRsaBBF04wQSHmY0v3DpmwLSMOpmk/dayeZN0UHYlFA==
X-Received: by 2002:a05:6830:63cc:b0:717:d48c:5a4 with SMTP id 46e09a7af769-71a6010742dmr244753a34.7.1731440759908;
        Tue, 12 Nov 2024 11:45:59 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a60079d15sm33063a34.50.2024.11.12.11.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:45:59 -0800 (PST)
Message-ID: <f26d1d04-3dfb-40d3-b878-9c731459650d@kernel.dk>
Date: Tue, 12 Nov 2024 12:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org
References: <04fd04b3-c19e-4192-b386-0487ab090417@kernel.dk>
 <31db6462-83d1-48b6-99b9-da38c399c767@kernel.dk>
 <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk> <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk> <ZzOiC5-tCNiJylSx@bfoster>
 <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk> <ZzOu9G3whgonO8Ae@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOu9G3whgonO8Ae@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 12:39 PM, Brian Foster wrote:
> On Tue, Nov 12, 2024 at 12:08:45PM -0700, Jens Axboe wrote:
>> On 11/12/24 11:44 AM, Brian Foster wrote:
>>> On Tue, Nov 12, 2024 at 10:19:02AM -0700, Jens Axboe wrote:
>>>> On 11/12/24 10:06 AM, Jens Axboe wrote:
>>>>> On 11/12/24 9:39 AM, Brian Foster wrote:
>>>>>> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
>>>>>>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
>>>>>>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
>>>>>>>>> Here's the slightly cleaned up version, this is the one I ran testing
>>>>>>>>> with.
>>>>>>>>
>>>>>>>> Looks reasonable to me, but you probably get better reviews on the
>>>>>>>> fstests lists.
>>>>>>>
>>>>>>> I'll send it out once this patchset is a bit closer to integration,
>>>>>>> there's the usual chicken and egg situation with it. For now, it's quite
>>>>>>> handy for my testing, found a few issues with this version. So thanks
>>>>>>> for the suggestion, sure beats writing more of your own test cases :-)
>>>>>>>
>>>>>>
>>>>>> fsx support is probably a good idea as well. It's similar in idea to
>>>>>> fsstress, but bashes the same file with mixed operations and includes
>>>>>> data integrity validation checks as well. It's pretty useful for
>>>>>> uncovering subtle corner case issues or bad interactions..
>>>>>
>>>>> Indeed, I did that too. Re-running xfstests right now with that too.
>>>>
>>>> Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
>>>> for both the sync read/write and io_uring paths.
>>>>
>>>
>>> Nice, thanks. Looks reasonable to me at first glance. A few randomish
>>> comments inlined below.
>>>
>>> BTW, I should have also mentioned that fsx is also useful for longer
>>> soak testing. I.e., fstests will provide a decent amount of coverage as
>>> is via the various preexisting tests, but I'll occasionally run fsx
>>> directly and let it run overnight or something to get the op count at
>>> least up in the 100 millions or so to have a little more confidence
>>> there isn't some rare/subtle bug lurking. That might be helpful with
>>> something like this. JFYI.
>>
>> Good suggestion, I can leave it running overnight here as well. Since
>> I'm not super familiar with it, what would be a good set of parameters
>> to run it with?
>>
> 
> Most things are on by default, so I'd probably just go with that. -p is
> useful to get occasional status output on how many operations have
> completed and you could consider increasing the max file size with -l,
> but usually I don't use more than a few MB or so if I increase it at
> all.

When you say default, I'd run it without arguments. And then it does
nothing :-)

Not an fs guy, I never run fsx. I run xfstests if I make changes that
may impact the page cache, writeback, or file systems.

IOW, consider this a "I'm asking my mom to run fsx, I need to be pretty
specific" ;-)

> Random other thought: I also wonder if uncached I/O should be an
> exclusive mode more similar to like how O_DIRECT or AIO is implemented.
> But I dunno, maybe it doesn't matter that much (or maybe others will
> have opinions on the fstests list).

Should probably exclude it with DIO, as it should not do anything there
anyway. Eg if you ask for DIO, it gets turned off. For some of the other
exclusions, they seem kind of wonky to me. Why can you use libaio and
io_uring at the same time, for example?

io_uring will work just fine with both buffered and direct IO, and it'll
do the right thing with uncached as well. AIO is really a DIO only
thing, not useful for anything else.

-- 
Jens Axboe

