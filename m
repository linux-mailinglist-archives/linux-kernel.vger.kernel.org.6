Return-Path: <linux-kernel+bounces-540813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CEEA4B547
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AF51890C1B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F961E7C32;
	Sun,  2 Mar 2025 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CFwy7Kvr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58245CB8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740954701; cv=none; b=bO8g64L1TfX06V4Wy7jOdAt0HRu8h3y3cqGOqK3085Z6DvKCl2xSn4egEIiw1ZcIl7mco4sIDAnX0M7ZCfttyHHDz++0+zvhCnwL5Tx/19BbAXWqR7E5hMW+iCU6rMNKEA+g+IFh7Kf7AAzvZLwtUYJ1bn7kdhRt1zmx/DAOXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740954701; c=relaxed/simple;
	bh=YGdhUEyu851eI88iQgZntamMfebTWiMDM9nFxwv7FZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRk5icvWKBj5aM2Wfx7nFe++aZXq696bTIbyHLbSwCUzos/HP75tzy9149Jtn7bbqcxRRucnSLqcj6cOfmRpBwWsQzGdycxD/KCinl1eVt7SlgqQHYYkocibsiMnmsJMqvVF8GbfuFSy8EE1lhLUg1ofThAnfeOQEJKLPSLecio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=CFwy7Kvr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439950a45daso23828925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740954698; x=1741559498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YGdhUEyu851eI88iQgZntamMfebTWiMDM9nFxwv7FZ8=;
        b=CFwy7KvrsmD8AqowyHQJS4PHG4StHUQynA4jiN26lZipQQwxrqQNu3381b+Gm481ZU
         KdzkOSfbXkbuwkm1JOHC4uSwXBG2L3cbi0+dnW+Yutz00xfuzod2OzcX7YC1xNB5AjTh
         PHeusFAOAe7MVo1HB1vZpTW46zD1nhXLXjtOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740954698; x=1741559498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGdhUEyu851eI88iQgZntamMfebTWiMDM9nFxwv7FZ8=;
        b=PH49ucCEdhRDCCi6fJTxTMzoFIFp9+5x43cn2v5phTzFaB/PUpqp9JH4iCTjUNBXH0
         Vwa6jSV0IVhjEYSaSd60GG4S194/Pe5l7H3+tvJXHGborq+5Pum+YomdZ/wd0Fy2ezxL
         1MgO++Uo9h6XbRcCcwmGlGZkTJJgK7uaTjjfL/AJ2vwo+YDlk+lKi5cDGN8sirGOqYyb
         dBUS7JS1qYrzIAmJ6WUCbfbELXQrEcgQZwAXnFCEsfcP6dR6AEhNDShXJkqdU9JfTTKo
         dcQbvKps5wX2KGnBAvmhRrG0Um5lIGijqH7FVqTV5hAEgexD4EW7+4yQ27OA0oYMc8mF
         oFfw==
X-Forwarded-Encrypted: i=1; AJvYcCWa6CYpQwmAJjyDc2OJn3ckwZBz+oRA7dn9jjh64FFHandRyzJnvqWUnarS1ev+Izx4Vyk/EbJXeglbxbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxqm7X4Ni2ZbBQnSS3kBAJgPxK1+YIgC/7d/2V5aEhnATo7bqt
	n3u0qhc8R5J7aRgGxG8bty/93X1TvkGZtYl+OY+w28hosI+ZnStbp7SsdC/yE6E=
X-Gm-Gg: ASbGncsqpxD/5grjJC+nppphrJpskwWtPIsqbPJi+kIFq0Y1H9EI0EPAAI7xhL4GIMa
	JiEtB5LGcxO4Bm3V3PZrH/pL2jVsUsPSIkk8gG1et0MfrJ4L9CVX1fPs791HEWuMjOFax2TUDVC
	UkXbiWmtYIZjgZb8TTrV+k4bhxWcRz3dftv1S2/wVzLTHmuADqP7javHNFMctBwRMFBwNjkFGwS
	riJakBX6AhCvKD28dqZHGPSMPLmNmuZx0REwd71i1rbEPq8s5PDxb/GqK5CPRAejZ7iyMt5SMa5
	fjEsoJ9r7S06HFc6LK6KgPQALPHDG6zwxzs4UfWRQIylEzDa0xu5YI7PLYhxH6k1YlUdoHTiIbc
	DBgaFmNci
X-Google-Smtp-Source: AGHT+IEism2SuG00NPPSL0d4NKjeUcs7nV+32sbb6Fu/1Ljhzd1n5laPcMx/VdhwU9NqPp98vfla8A==
X-Received: by 2002:a05:600c:474a:b0:439:8185:4ad3 with SMTP id 5b1f17b1804b1-43ba67721a4mr82341885e9.27.1740954698169;
        Sun, 02 Mar 2025 14:31:38 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7370372dsm135115955e9.11.2025.03.02.14.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 14:31:37 -0800 (PST)
Message-ID: <edf50534-3c31-492d-b975-824bf19cf36d@citrix.com>
Date: Sun, 2 Mar 2025 22:31:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Rudolf Marek <r.marek@assembler.cz>, Jann Horn <jannh@google.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, luto@kernel.org,
 samitolvanen@google.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-hardening@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 x86 maintainers <x86@kernel.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
 <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
 <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
 <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
 <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz>
 <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
 <73ef8000-661e-47b4-a8b0-a02d3a849645@assembler.cz>
 <e3f98cf1-71ff-4425-9deb-31d2ae989eac@citrix.com>
 <b99d222e-e65e-4865-8035-12ce889c4388@assembler.cz>
 <aae74f5e-454e-4de7-839e-bfd5be865a82@assembler.cz>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <aae74f5e-454e-4de7-839e-bfd5be865a82@assembler.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/03/2025 7:16 pm, Rudolf Marek wrote:
> Dne 01. 03. 25 v 23:48 Rudolf Marek napsal(a):
>> I don't know how slow is to do the jump back via far jump.
>
> I did some micro benchmark on Raptorlake platform using other
> operating system I'm very familiar with.
>
> I added following sequence to the SYSCALL64 entrypoint:
>
>  .balign 16
> syscallentry64:
>     .byte 0x48
>     ljmp *jmpaddr(%rip)
> continuehere:
>      swapgs
> <...>
>
> jmpaddr:
> .quad continuehere
> .word KERN_OTHER_CS << 3
>
> And well, it is  1.5x slower. Unmodified syscall benchmark took on avg
> 261 cycles / 104 ns and the one with the indirect jump with %cs change
> took
> 386 cycles/ 154 ns.
>
> This whole thing is quite literally a trap next to a trap, because GAS
> wasn't adding REX.W prefix and somehow complained about ljmpq.

(I've not finished replying to your other email, but here's one bit
brought forward)

Sadly far jumps and calls are where Intel and AMD CPUs disagree on how
to decode the instruction stream.  Intel CPUs obey REX prefix for
operand size, while AMD do not.  i.e. AMD CPUs cannot far transfer to
kernel addresses, at all.

This is why you only see far returns generally, which do behave the same
between vendors but require a stack.

~Andrew

