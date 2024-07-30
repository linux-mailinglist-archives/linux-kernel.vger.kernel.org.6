Return-Path: <linux-kernel+bounces-268342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D58942367
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CEE1F248A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0FB194081;
	Tue, 30 Jul 2024 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPoZX1q+"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32951917D5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382195; cv=none; b=AsVoiVBgW5R9vFZmf8FRXvkLKf+9cIyuWffsL3PGEu5CZRCMdiJ61nZtQpFjLElcH0E7E57l9JTVC1jg8pOua/X7+XeU4/nsCZzPIieAsH1g5ewdXo+BV1gPOkFMiAjR7RtDk9e/UCoI5iVpYNk06NdBz99+0GTAbHCT9Lv9q4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382195; c=relaxed/simple;
	bh=siTDA9EpZnUo/ERXSZ+IbnseTsFYvXI3bdHP9iwPIUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdW/hR613n8bArqEXgvhHnZCAKKUiz4VXFqafvI+Wz+gQVCvHe6004EPOzmi9bgOhqpLzdRuA6YNfrnuPL9P5PUSkzPHLKOFtF5fO1Zt4jX3z3KkgKB+esnn9/MavAmHRcIJHoyUySXZtB0JHO299r44eN7iCTlsFVBXja87ZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPoZX1q+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3101749a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722382193; x=1722986993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v9IY+HlC4GnOMk0NsMn3t6Ap1Bon+7MwY1w6yluHk8A=;
        b=QPoZX1q+OAJng6zmWRxM4DS/RSEZSJWhAu2G2UyybHxWGgtHytEW7gDTZ76m4LP+UP
         hdTGUXBxja40fWUWoT280k/QOVFi+G+TjYgc7RA03EgTdawo2PAfJX20TBqJNCgmcUFm
         55Ld3f8sCTyocwOhFPgq/nkL4Xj1B9KqGn9DXxlrmugR0vX3oGxx6Kp4UGLepVqAo/GJ
         wID+1aRKTNj4MfFN76j1Y7HdlDwEQQwfA4ZqIfMd4IG3XU/YmGhIszyyJlg3/4Iekl0R
         xYDgwdvSzlG5LqZutjp+RCjr7YmJOts4Vb2pLw7tm/CbNZFcEh7BR5qtTRTnLbmdsLEQ
         K+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722382193; x=1722986993;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9IY+HlC4GnOMk0NsMn3t6Ap1Bon+7MwY1w6yluHk8A=;
        b=BgYrwkmqzyYTjsiRuXUOCEYn14zQwSodq+hRQS73pNZa9kl4eDwq9qGZ0uaLa/aU6k
         4+8vwGOpJ6qcQwyIZ+tWYUUarfNB5KOK29TFbQm9I/dhPVvDVdMvifvRG0dlQ7xD0WiN
         9nr3p0WgqxnbYTTCCk3rb4wX3YCJ15af2sow+xFYcTAnTktG2B+sXdP5RnyB2+j4fkKa
         4cfo8/Bc8cGWKwbgwL80rPE9cBG+HyFc399ancIdKv2EWak/nJVBLpUwOEvUUhSZg9SO
         g6Ui+/18M3nRmgCaPn8NtMnLXgANGN+vrCzzX2j9wttuDysJq3oKEOSWPfHOYt2jhpqP
         mFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUjAuecQfwh6rQQ5gv7OkLcgqqrRfWq2R29ydtagnGEamtid6OyZms780pyF3gteNnWpA9xWh7tAhx+Xb8IPkCaKtnnwqf9LCCNqfJ
X-Gm-Message-State: AOJu0YzJDr1IKZq9VUXRflSe5V19/e8MdmHe9Y8hnf4reO70m46LVj19
	4cFHpiestDxVDJ/rtBC/ulcbr5VQ73NyA24zPkUBjlOZCnAuOby+
X-Google-Smtp-Source: AGHT+IEpiG37RtoCgYfmTBJ5/NBDIQMalah3OX0PPCx1/y0WrAGLhC3IrreRjuWVfWIMaIrKPdp0mg==
X-Received: by 2002:a05:6a21:3284:b0:1c4:860a:bc09 with SMTP id adf61e73a8af0-1c4a1529b8amr12241388637.51.1722382192857;
        Tue, 30 Jul 2024 16:29:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff37552f36sm20513825ad.117.2024.07.30.16.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:29:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
Date: Tue, 30 Jul 2024 16:29:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240730200947.GT33588@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 13:09, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 01:04:49PM -0700, Guenter Roeck wrote:
>> On 7/30/24 12:38, Peter Zijlstra wrote:
>>> On Tue, Jul 30, 2024 at 01:31:18PM -0600, Jens Axboe wrote:
>>>> On 7/30/24 1:22 PM, Peter Zijlstra wrote:
>>>>> On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:
>>>>>
>>>>>> Which makes me think it's asm_exc_int3 just recursively failing.
>>>>>
>>>>> Sounds like text_poke() going sideways, there's a jump_label fail out
>>>>> there:
>>>>>
>>>>>    https://lkml.kernel.org/r/20240730132626.GV26599@noisy.programming.kicks-ass.net
>>>>
>>>> No change with this applied...
>>>>
>>>> Also not sure if you read my link, but a few things to note:
>>>>
>>>> - It only happens with gcc-11 here. I tried 12/13/14 and those
>>>>     are fine, don't have anything older
>>>
>>> One of my test boxes has 4.4 4.6 4.8 4.9 5 6 8 9 10 11 12 13
>>>
>>> (now I gotta go figure out wth 7 went :-) And yeah, we don't support
>>> most of those version anymore (phew).
>>>
>>> So if its easy to setup, I could try older GCCs.
>>>
>>
>> WFM with gcc 9.4, 10.3, 12.4, and 13.3. gcc 11.4 and 11.5 both fail.
> 
> 10.5 and 13.2 worked for me, and I can confirm 11.4 makes it go boom.
> 
>> Maybe I should just switch to a more recent version of gcc and call it a day,
>> in the hope that it is a compiler (or qemu) problem and doesn't just hide
>> the problem.
>>
>> Thoughts ?
> 
> Tempting, but I think it would be good to figure out what in GCC-11
> makes it sad, gcc-11 is still well within the supported range of GCCs
> afaik.
> 
> Lets see if its something that wants to be bisected.

I tried bisecting several ways, but it always ends up at commit 0256994887d7
("Merge tag 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux").
Manual build confirmed that 0256994887d7 fails but 0256994887d7~1,
which is commit dd018c238b84 ("Merge tag 'bcachefs-2024-07-22' of
https://evilpiepirate.org/git/bcachefs") is fine, at least for me.

I then rebased 'for-6.11/block-post-20240722' on top of
dd018c238b84 and tried again. Result is below.

However, reverting this patch as well as the subsequent patches does not
fix the problem, and reverting the entire merge from the mainline kernel
doesn't fix it either.

The next step was to bisect starting from 0256994887d7, reverting the block merges
at each step. That points to the io_uring merge (second set of bisect results).
Hoever, reverting that merge doesn't help, and neither does reverting both
the block and the io_uring merges.

On the other side, reverting nothing but enabling CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
makes the problem disappear. But that doesn't really help, especially since reverting
the patches touching CONFIG_CRYPTO_MANAGER_DISABLE_TESTS does _not_ help.

Baffled. Is it possible that the crashing code catches some page boundary ?

Guenter

---
# bad: [a9dd34ab77277f0fb7fa41a3edb8f0a71f7d791f] block: don't free the integrity payload in bio_integrity_unmap_free_user
# good: [dd018c238b8489b6dd8c06f6b962ea75d79115ff] Merge tag 'bcachefs-2024-07-22' of https://evilpiepirate.org/git/bcachefs
git bisect start 'HEAD' 'dd018c238b84'
# bad: [113799f9042573ba197de7a78a1e450cb40573ac] block: don't call bio_uninit from bio_endio
git bisect bad 113799f9042573ba197de7a78a1e450cb40573ac
# good: [473252aab8bf1a86e4266cb65f7baac1c10a70d9] block: also return bio_integrity_payload * from stubs
git bisect good 473252aab8bf1a86e4266cb65f7baac1c10a70d9
# first bad commit: [113799f9042573ba197de7a78a1e450cb40573ac] block: don't call bio_uninit from bio_endio

---
# bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
# good: [0256994887d7c89c2a41d872aac67605bda8f115] Merge tag 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux
git bisect start 'v6.11-rc1' '0256994887d7'
# good: [b2eed73360dffea91ea64e8f19330c950dd42ebb] Merge tag 'linux-watchdog-6.11-rc1' of git://www.linux-watchdog.org/g
git bisect good b2eed73360dffea91ea64e8f19330c950dd42ebb
# good: [0ba9b1551185a8b42003b708b6a9c25a9808701e] Merge tag 'drm-next-2024-07-26' of https://gitlab.freedesktop.org/drl
git bisect good 0ba9b1551185a8b42003b708b6a9c25a9808701e
# good: [8e333791d4605dbce611c22f71a86721c9afc336] Merge tag 'gpio-fixes-for-v6.11-rc1' of git://git.kernel.org/pub/scmx
git bisect good 8e333791d4605dbce611c22f71a86721c9afc336
# bad: [5437f30d3458ad36e83ab96088d490ebfee844d8] Merge tag '6.11-rc-smb-client-fixes-part2' of git://git.samba.org/sfr6
git bisect bad 5437f30d3458ad36e83ab96088d490ebfee844d8
# good: [910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef] Merge tag 'rust-6.11' of https://github.com/Rust-for-Linux/linux
git bisect good 910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef
# bad: [8c9307474333d8d100870b45af00bfeb1872c836] Merge tag 'io_uring-6.11-20240726' of git://git.kernel.dk/linux
git bisect bad 8c9307474333d8d100870b45af00bfeb1872c836
# good: [29d63b94036e561a016ec8878b44aad6650d23e2] io_uring: align iowq and task request error handling
git bisect good 29d63b94036e561a016ec8878b44aad6650d23e2
# good: [358169617602f6f71b31e5c9532a09b95a34b043] io_uring/napi: pass ktime to io_napi_adjust_timeout
git bisect good 358169617602f6f71b31e5c9532a09b95a34b043
# good: [ef9ca17ca458ac7253ae71b552e601e49311fc48] hostfs: fix the host directory parse when mounting.
git bisect good ef9ca17ca458ac7253ae71b552e601e49311fc48
# good: [bc4eee85ca6ce5335efe314215841712b5531449] Merge tag 'vfs-6.11-rc1.fixes.3' of git://git.kernel.org/pub/scm/lins
git bisect good bc4eee85ca6ce5335efe314215841712b5531449
# first bad commit: [8c9307474333d8d100870b45af00bfeb1872c836] Merge tag 'io_uring-6.11-20240726' of git://git.kernel.dx



