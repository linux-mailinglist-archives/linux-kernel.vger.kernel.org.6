Return-Path: <linux-kernel+bounces-342116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75F988ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A47DB22031
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771D1C232C;
	Fri, 27 Sep 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fwFlNQui"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828614EC5E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465344; cv=none; b=M3qR0r4gq7RzzXwDSJlVMX4H8TDR2kIKmJBf7s/j3O7dQit3F8QGKCU1eEqJB8XpCmX6hgwOuHyI0AA64QQn3Zpel874qvpDnS7fzq7Klewp3C838UQ/RFK4suMBXGGvwg/K9InBNAvnZozlCExo1w9/UKGmsmyQgB9skYHCB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465344; c=relaxed/simple;
	bh=kqt5Jntn1aPjnEibEghCyVBj7mxRi2cdnuwUrSdPgVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYK4wUNcBIgA5pUQViXes50SgyrnNzklGGH/8aX6hyziJmYi60nYcdOMtSfQBJlr63OecBnq2cGQKtn2GoK/aeO0caxEdGX0XES9Mx5M8A1fIt+YDRYq2qWm0WcxDL8d1rhtXMhbZZmTNjFr2u6DzDgtOOs3DyUKM0upLaOcr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fwFlNQui; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a843bef98so318281166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727465340; x=1728070140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4BYeztFGhrhYHEtsZ/kMOwsZ9Tbjy1c0Mm3O/TMTIo=;
        b=fwFlNQui0J7TdLfG0lzWnhNXBHED/ZXT+rn5KhQXTDILkL/9moufJNR543sHOEGk5z
         L5NtmGWhceAh4ZrMu3LscL/DUYomqsyoaXJCI3+wa+NoCnJZQrWVgesAjeY+YIRcYDu9
         v+DSHwaQr/5mZ/+tQ39i5VsTDpwwpP2yyimOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727465340; x=1728070140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4BYeztFGhrhYHEtsZ/kMOwsZ9Tbjy1c0Mm3O/TMTIo=;
        b=a7zlNx9T32uJyqsRs0J9jbaYzstI3tDbOY4szNI23hRfsKc9zPaaJ6aaOIksubpp/Y
         lvD0Frf241i6XVS+CqbTkInUvHkF/EiM5RHdSWKo/zMZAxy5n80eGSG2Hj/QjiLJY280
         jC6T2F7sw8KD3Shq3fw3OSCtn4f4pIIX9TMiU8FUKqZqLEZdSwEFmCIvUhFzL2qKLoft
         y3Ajv7Pl76vDB1dz2BcZ3001uxJtu6snPgK9gEqcKzNINB2eGPcMvXErlBzO3M03T2SX
         cIUaSjA0iRHpgtLMdvd7vFcPvvH41P5divQDc2HD9WlnoT16YtNxeyVcP5mEEm1Al/Hr
         GJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfeAVPaWb8uaIt7ryb0H0MAf78ukO1GUOwmYE16SbBswtOG1MZxHuPUF1wtThXGn/R5ySqxjf46wSXeqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqi+4QQURJgXov9EF7r0mW0V1a5Ak3g6k/jE98cDf0X9IHSdj
	WWt+ZfY+zpdAg+KVi8lgkkcelOSJfjnL9EB+PJY0ZQ8oevWUKLGrMjoRV1/m3s54bBJtEJadRnl
	utnN2pg==
X-Google-Smtp-Source: AGHT+IH/LTZmTsSBA7rXwvyFM/MlDh7aM4Oe9cBX/kqx7iSI7blq5aKkGUMbseOQ6m77IrjJJEhntA==
X-Received: by 2002:a17:907:1c17:b0:a8d:4e24:5314 with SMTP id a640c23a62f3a-a93c4918077mr429302466b.24.1727465339858;
        Fri, 27 Sep 2024 12:28:59 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775cfdsm165515866b.23.2024.09.27.12.28.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 12:28:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d2daa2262so266043966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:28:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNVXiIxlZQeNIA1lgLmWdTe9gBzRmZ6nbCAEnrOiFBi4xHnGq6i+EaNPS9Fh5oDvgU9G/WDqiIa7z4bo4=@vger.kernel.org
X-Received: by 2002:a17:907:36c5:b0:a86:7514:e649 with SMTP id
 a640c23a62f3a-a93c4a69d42mr423065966b.52.1727465337418; Fri, 27 Sep 2024
 12:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com> <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com> <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com> <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com> <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com> <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com> <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
 <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com>
In-Reply-To: <1b04e35c-8994-48d9-907a-966bb4dfabaf@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 12:28:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
Message-ID: <CAHk-=wgi9vqh6qUpPKSydfdqd3210MnekZ1VxB6aAmfqz2bFpw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 12:12, Jonas Oberhauser
<jonas.oberhauser@huaweicloud.com> wrote:
>
> I think it depends on which one you hide.

No.

Dammit, people, read the code I posted.

> But for
>
>   z = a;
>   hide(z);
>   if (z==b) { *b; }

No.

I *intentionally* made it an inline function, and only hid the
arguments to the equality comparison.

So the "hide(z)" hides the argument to the inline function - NOT THE ORIGINAL.

> then it would still know that b == z, and could replace *b with *z
> (which really is *a).

No.

The hiding is literally *ONLY* for the comparison. It's inside the
helper function. It doesn't affect the originals at all.

Which means that the compiler CANNOT KNOW anything about the original
pointers when it compares for equality (or inequality).

Basically, the comparison is now a black box to the compiler, and the
compiler cannot use the result of the comparison to make ANY judgment
on whether the two original pointers were related or not.

               Linus

