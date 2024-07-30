Return-Path: <linux-kernel+bounces-268122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A6394209F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1316E1C22B91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76FA18A6C5;
	Tue, 30 Jul 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nYDNWydS"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2DEE573
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367883; cv=none; b=HeCcFUDtzLlHViRMgIvWBxOK8YcmW3WSqgG0APBuj65DE8PwFZc4pENUH/tmD/K0gMxjMhG58UGjWEV01Xz2Y4qjCVm3DcEt5AbRBaLM8jPevKS4S1IsxZuYxbE3dPzqxfn8a03U06C6K5WrmpUe9L+9doG2nNqqJMLrxrlMOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367883; c=relaxed/simple;
	bh=/O0uXPMa9k39h2aD43CifSFQhgjFQvpLBWFHzKEb02E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBH682y+Okpn3dcnzuQW0FQA4NA6PxD1pTr9aLISalHFVF3B+Aq7uKhhpazsQ3yuOiglyXflBk+uIDE26miGmiE69+/l2ztdYt3bgyrkaPB+ZC4bNoGYV+pRQtZkR6zaUedNo/uibrrGghtIMHZBkUjN5wgVmEhMHzZ5mELVUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nYDNWydS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc5bc8d23cso2094805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722367880; x=1722972680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tons8BpIpeie7eNn6j56L06MnCtszQ25aveHcXEzpYo=;
        b=nYDNWydSfnA6E3nQ/VgK9Ks4c/KUiQhDKk/IqJ/NDgSMPMCTs4lNlQx2BP3F74bnE1
         N2QVV0gkKU1yDgxkyD2QNV2LICvnffHkXTNjkOc8Ey/UxmrAx/11mw2Jmei1mVPybgyp
         XLEOEUoC++7Qxt5Y0Tv+FVPeoH6Xndi6FUxMrb/cRPt3dC7wZZFIvgKPbJOXaW9kvsnH
         WAuifZUJodcGSu21j10kIoAPMyEMLeS/7V9qigisy64kdK03GfsVoXBBfzx/g2DLmEyI
         PczkHzUtcoFD4ySEco64AqnJQwBPOzp4oLvqbtccNfQaVIwPSv3LXK8Y4b7UFD5z7oVj
         jm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367880; x=1722972680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tons8BpIpeie7eNn6j56L06MnCtszQ25aveHcXEzpYo=;
        b=Fyne/w2Xy0IjzKMnwBuCaAtFE4lThjMxjs6zMknwOKHtXXiYpIkqGwuwMdTXIp2Ple
         6K5dahadszoH8Jh+QUf+OMLl58A3RSkaUODEuszDnssWkuyyyRfnnQZHPecCddEB369Z
         qSzHcp1+z0fPHanTf/hYBVww970xUo+GrtG1NfLfHP1ZRIXb1ztIsaSb5tNYVDNe/D8k
         a5UhfZcdsIA8dBPUA0Tl5ydxUMaMVaJ+n2k0HqES9pCzyud7ZOvsQOv7tcx1b3SdYzwv
         7PelRUMS69oShJ0z5fosIlLa+DTc1YAl94vmyPBAPrvK2AofNER9QQ9r9kLwdCcFSHYO
         mQOg==
X-Forwarded-Encrypted: i=1; AJvYcCXCwAMJLLeQFYvJWT9ZLzcsj+BryilPJShYq6twKRcm1QYFQeiEehwK1LNRnRCHtTXwUYhC47d3tkwxOiWkwtT0gy1YgyJmEXhJJFTE
X-Gm-Message-State: AOJu0Yz8LC62UffazcDHHHyWWnUkyMZZmnM+EpWJhhMfj5bphaO3GmxI
	KD7WVtaEfyPvUFap4rN53AQwRr4c6E7jgto0TvdJLeFge6BsYodFwgeFYYXpAvNsLjNwQri8t+3
	C
X-Google-Smtp-Source: AGHT+IHvrRBjYf52ERYyfnN0/05TxMCvrP9vD0dwTdXKqZVi3p0ma/jIYbMrizirTVn9iVxQ5ZZSMw==
X-Received: by 2002:a17:902:dad2:b0:1fd:a428:a021 with SMTP id d9443c01a7336-1fed6d38bc0mr128253215ad.11.1722367880373;
        Tue, 30 Jul 2024 12:31:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffd12dsm106047785ad.308.2024.07.30.12.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:31:19 -0700 (PDT)
Message-ID: <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
Date: Tue, 30 Jul 2024 13:31:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240730192237.GR33588@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 1:22 PM, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:
> 
>> Which makes me think it's asm_exc_int3 just recursively failing.
> 
> Sounds like text_poke() going sideways, there's a jump_label fail out
> there:
> 
>  https://lkml.kernel.org/r/20240730132626.GV26599@noisy.programming.kicks-ass.net

No change with this applied...

Also not sure if you read my link, but a few things to note:

- It only happens with gcc-11 here. I tried 12/13/14 and those
  are fine, don't have anything older

- It only happens with KFENCE enabled.


>> Let's see it x86 people have some idea, but that
>>
>>    restore_all_switch_stack+0x65/0xe6
>>
>> and doing an objdump to see the code generation, it is literally here:
>>
>>         0f 20 d8                mov    %cr3,%eax
>>         0d 00 10 00 00          or     $0x1000,%eax
>>         0f 22 d8                mov    %eax,%cr3
> 
> That looks like SWITCH_TO_USER_CR3
> 
>>         eb 16                   jmp    <restore_all_switch_stack+0x7d>
>>
>> with that "jmp" instruction being the restore_all_switch_stack+0x65 address.
> 
> Thish would make this BUG_IF_WRONG_CR3, which starts with an ALTERNATIVE
> jmp. I think we landed a pile of ALTERNATIVE patches this merge window.
> 
> That said, Boris did spend an awful lot of time testing them... but this
> is 32bit so who knows how much time that got.

Since I got this setup with Guenter's setup, it literally takes me seconds
to compile and test anything. So feel free to toss anything at it and we'll
see what sticks.

-- 
Jens Axboe



