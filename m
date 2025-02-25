Return-Path: <linux-kernel+bounces-532185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4969A449FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066423A6AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE01D19F116;
	Tue, 25 Feb 2025 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="vM2nQPXw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C419DFB4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507049; cv=none; b=WR97p+KeFAd5x0/oP8ncg/tQCl+0Tup5i3emEp4P/Kl83vLu1fd1mVejMYmuBmllU+1FVtfW8hCHLZ/XELMwRAjSlmjV4EcV32CwBAUnzaOCxzFwBHm1tigT3dWGvIyC2rkJPv0E3gE8HbDIdSbEIFWg2M/6ys0q6F1Y6IwoY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507049; c=relaxed/simple;
	bh=0kagRtFzm8Sg8hNgrYsnkVHfez94hwdJouxKPKp/jwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+gB9Bhz+nr0igMLgKMzLNSGwccjFhvpwrGLTD1YUd6zFVX9R/pbilXe/3kKpcmZQXqbK4TSTxkfDw0dOxD50j4bgt9jIw824X5WPt0oBdI5gFFAh/8f+arbiXlPv0bQNf+tE5HTatd/R8jCOy8C1KkDhG38LR+zM0Xs0i7eh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=vM2nQPXw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so40907975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740507045; x=1741111845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0kagRtFzm8Sg8hNgrYsnkVHfez94hwdJouxKPKp/jwQ=;
        b=vM2nQPXw/WzSO+wmw1KTx7KrFS9ZLnE0auUpjWV8g17xs+s0tI3yH0HZKh+xAgwBHW
         NY82M/DMzXjs3OPc6booetmBlhUG7k5W3kWxNYiUfl3yuLaiAvvKznLAHqFAqUgz3wFN
         R1HWshOpTCyJuv2kvC+PUVZJawQrNiq/ZrTRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507045; x=1741111845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kagRtFzm8Sg8hNgrYsnkVHfez94hwdJouxKPKp/jwQ=;
        b=SxQbLUOezaOVVlcJrIuw+wPd3Ww3IZjhM6LWRewSlKquP3ncz/jIlLPM+QyunLpLCs
         a2fai/qgEUGYmyyVOARQaK+Kz+jXcNdkpDOLBTXbrUfi6gmxtzL7shVtANPgaSQBEbCt
         QGNaZw8ZD1XOg4gPBu479h0KV6FHQRaDupgQIKTvKaXmdbq4iy1AdlvGcjH0CJ3XsI+6
         8B3F+/pvNFsTY/0D+bLbFrS1qh6JNuZlHPxQX6kte3r2gkXjAxX6AreNk0/0vP0OTp40
         7+RykvraJmXThvdXaIZsZQezkPhyQGBMsHs1mE09n58dwb+LOjuyF+9n6twJNlduvs32
         sPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6E9LlAQo0aFK31BJP1zlIkd0NOUAy7EvDbtpzwlnv0Bx3V6PFSnIMa+e/0n/7Tt2HoSi4d1VeMKJtN0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcsQ6SKbTDfGB/76r36BPJPCkyc2Tnj7hd+gL3nXR3wc8MkfV
	z1VirOuty/COdQCp8ANOl+UOQ097T5Dh+CjOjgWWz+R6EwUyvc0z1OFJys9f6UFjDVeTqttS1FZ
	i
X-Gm-Gg: ASbGncuElcGBB0UI9gRoeRsR6lFq3XElcwxbLBApjvZ/ghWP9rkCBeLLb07ksn91qnI
	0MeEQek7ToAoC17KliQN1YAoT7ouekyd7V+W/tRJ2BBqWTUDgZVMLYyt40ZPMNxOf0iXYVcRqkK
	WJ/VQlnk2dnVjH1FzoU9+mf4eWCiq8eSGwTlIS7PbOVx07X59vze+adWT3MJdJCrb6mjb+Y02Hq
	4mjH/HShjz5NzflgXylsmlvQpEKKWSupuwacU0FzTjePNgR2Nvcq+xwaLgJenkmSDApNDM8uFAh
	111UoD56jyP8Hp22iAxVMWTayiZx9Vzf0jsBcRFmSPb6b0Dd8b5rjrP3MzUaRNvzKA==
X-Google-Smtp-Source: AGHT+IG9zEYrz279GnRlIYQx2hGfJtQTkJ0pTYmtHboiyYfH27LPFowEQjM9SOPBl/uYZJVX95Hruw==
X-Received: by 2002:a05:600c:1e23:b0:439:987c:2309 with SMTP id 5b1f17b1804b1-439ae221d7dmr149222535e9.27.1740507045584;
        Tue, 25 Feb 2025 10:10:45 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c40fd2sm24904785e9.0.2025.02.25.10.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:10:45 -0800 (PST)
Message-ID: <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
Date: Tue, 25 Feb 2025 18:10:44 +0000
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
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2025 8:43 pm, Rudolf Marek wrote:
> Hi,
>
> Dne 13. 02. 25 v 3:42 Andrew Cooper napsal(a):
>> The SYSCALL behaviour TLDR is:
>>
>>      %rcx = %rip
>>      %r11 = %eflags
>>      %cs = fixed attr
>>      %ss = fixed attr
>>      %rip = MSR_LSTAR
>>
>> which means that %rcx (old rip) is the only piece of state which
>> userspace can't feasibly forge (and therefore could distinguish a
>> SYSCALL from user vs kernel mode), yet if we're talking about a JOP
>> chain to get here, then %rcx is under attacker control too.
>
> The SYSCALL instruction also provides means to create "incoherent"
> state of the processor selectors
> where the value of selector do not match pre-loaded values in the
> descriptor caches.

Very cunning.  Yes it does, but the state needs to be safe to IRET back
to, and ...

> Would it work to have KERNEL_CS as last entry in the GDT table?
> Therefore executing SYSCALL would set the CS as usual,
> but the numeric value of SS selector would be larger than GDT limit?

... this isn't safe.  Any exception/interrupt will yield #SS when trying
to load an out-of-limit %ss.

i.e. a wrongly-timed NMI will take out the system with a very bizarre
looking oops.


You can do this in a less fatal way by e.g. having in-GDT form have a
segment limit, but any exception/interrupt will resync the out-of-sync
state, and break detection.  Also it would make the segment unusable for
compatibility userspace, where the limit would take effect.

Finally, while this potentially gives us an option for SYSCALL and maybe
SYSENTER, it doesn't help with any of the main IDT entrypoints which can
also be attacked.

~Andrew

