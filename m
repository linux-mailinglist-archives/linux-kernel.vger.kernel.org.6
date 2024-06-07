Return-Path: <linux-kernel+bounces-205744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D78FFFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372A11F21E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603615B55F;
	Fri,  7 Jun 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CCeQKq4J"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9830746E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753187; cv=none; b=H1ypTEqD4U6OI1vfsTgtySZTgTaXjF7pHx8bhsKhymml2BWVWx7SMFYjY2Xf35S+QcRtoTKhNc7w7ikXOD2DQKqrsheY8upFOFAfG1Y2PoimjgKVPXfYhv9GQZjUsR7Qf1KhIbIjLGyRdhWVMpP+tFCFYdsYzJGCYZMMRq4qkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753187; c=relaxed/simple;
	bh=p7H/WEkS1vEQY7EXjvfPT9Xlv0CgkEzxxEjwZf7m/Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0HJaakTD3o5M3f1UA5x3yS5Q1gHpS7978W0IxjlqrAPzcr/5L0NKPMM5wE+Z7zWrOhMRVf6EjEvot8Fpfe+C9sTBDgMvgnP0jVAf71MVyrmwHXgov5bDhuuEgmqrCqQknWSbqxW6beHbgD9cLHi1ugDsXA0gWLP7Lzrxdy9tS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=CCeQKq4J; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso25204221fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1717753184; x=1718357984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LU9hhih+qXm4Na/DCD92BEwQks2+qxlfIe2jlRSflEs=;
        b=CCeQKq4JvMV6bQm0oKr1Gpa+cd1zz49HaCp1KsQL1lub6+7Wt90+SwM5jFjCrazfFz
         KmmaUHpSj30e8ogBuTRTA8u7G/AO3obb2JeHzjx2S7eSX93i0mjU7CYoYwRUsmvfZI9V
         RlwnBlD6Zr4VBaa/FVGA7V+vR1bmAxav7hKiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753184; x=1718357984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU9hhih+qXm4Na/DCD92BEwQks2+qxlfIe2jlRSflEs=;
        b=kK03pMSmd7wMfLyOdXMXEDOSUBfr59+AxSu2xjXNe8Md6K/rp+55dxbGe4cTtX7Gsj
         2zWxvDjZnyAGKtE/K3Ut0wjRCRL+6I9WEyGgN+CCQFzhg8P8CixoGiEN6/BKZNhd7788
         5NEi9VNV5DdHEOQKrqTBE5IEf3AVCF7fbwFxC/DyYqpu5gR6yVyADLBaUItahiQ4YUJQ
         OmRnHAM8FRzB7s08Yr+/Eo9chAI4p23RYbSCaIFnlqZi9mJgT8nXaCadITKUqTQ+CXJE
         KsUsHaKV9mMYFZObobs5cgVF21zrLhn9vGjiZCwvi5SzC/4B4wWnE1xNrZBwQz4mrZcH
         Pq6w==
X-Gm-Message-State: AOJu0YzjDIseMUCq13zsRPUvGe0i2nc5sVfD/WGirZsm3zeidtfegVVj
	tOqfsb00Do5KJa0RdUJ4/lz4AanVVz4fYieyVUdozibEsSFV2PL7o+VCLGI4ewk=
X-Google-Smtp-Source: AGHT+IE6M9yGD4DuGvtqXZ4+DYgfTslxvXScsgVHZzw6GVe2UX2g0RIDlvaIcsRhM21UL2X8yUbeNQ==
X-Received: by 2002:a2e:a16e:0:b0:2ea:9300:e135 with SMTP id 38308e7fff4ca-2eadce24a2amr17501971fa.8.1717753183830;
        Fri, 07 Jun 2024 02:39:43 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41b07absm4812231fa.73.2024.06.07.02.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:39:43 -0700 (PDT)
Message-ID: <8d43678b-6e94-49b6-9cdd-244c0e7b3898@rasmusvillemoes.dk>
Date: Fri, 7 Jun 2024 11:39:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: objtool query: section start/end symbols?
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 20.42, Linus Torvalds wrote:
> So this is related to my currently very ugly hack at
> 
>    https://lore.kernel.org/all/CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com/
> 
> where I'm trying to do "runtime constants". That patch actually works,
> but it's flawed in many ways, and one of the ways it is flawed is that
> I really want to put the "this is the use for symbol X" in a section
> of its own for each X.
> 
> Now, creating the sections is trivial, that's not the problem. I'd
> just make the asm do
> 
>         ".pushsection .static_const." #sym ",\"a\"\n\t" \
>         ...
>         ".popsection"
> 
> and the linker script will just do
> 
>         KEEP(*(.static_const.*))
> 
> and I'm done. Nice individual sections for each of the runtime constant symbols.

I'm probably missing something, but isn't this exactly what you get for
free if you avoid using dots and other non-identifier symbols in the
section names, i.e. make it "__static_const__" #sym or whatnot:

https://sourceware.org/binutils/docs/ld/Input-Section-Example.html


   If an output section's name is the same as the input section's name
and is representable as a C identifier, then the linker will
automatically *note PROVIDE:: two symbols: __start_SECNAME and
__stop_SECNAME, where SECNAME is the name of the section.  These
indicate the start address and end address of the output section
respectively.  Note: most section names are not representable as C
identifiers because they contain a '.' character.

And this tiny test program suggests that works as advertised, though I
don't know if we use some linker flag or the fact that we use our own
linker script then somehow suppresses that behaviour:

#include <stdio.h>

#define x(name, val) asm(".pushsection __test__" #name ",\"a\"\n\t"	\
			 ".long " #val "\n\t"				\
			 ".popsection\n")

extern char __start___test__foo[];
extern char __stop___test__foo[];

extern char __start___test__bar[];
extern char __stop___test__bar[];

int main(int argc, char *argv[])
{
	int *p;

	x(foo, 10);
	x(bar, 12);
	x(foo, 47);

	printf("Contents of foo section:\n");
	for (p = (int*)__start___test__foo; p < (int*)__stop___test__foo; ++p)
		printf("%d\n", *p);

	printf("Contents of bar section:\n");
	for (p = (int*)__start___test__bar; p < (int*)__stop___test__bar; ++p)
		printf("%d\n", *p);

	
	return 0;
}

Rasmus


