Return-Path: <linux-kernel+bounces-411924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9579D0163
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E891F220C0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7FB1957FF;
	Sat, 16 Nov 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ze+SqWde"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072C1922E7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731798562; cv=none; b=BytAJp5i5k8A/zb1CHo1LUyNzzNlsXu1e56+wdLcjvTrcsk45WfNM8oUHtgyTEskZjUKGmi4Y6LwTsEZ5tmoDASrpVQYvGhvaqU2zmqT/JyHqAr0kwb4Nf1jS30uPSAQ9IvkBAmFLiIz61LIqxwHFaynL5d1C+5okfm0nMJMmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731798562; c=relaxed/simple;
	bh=NU+kRVq7wk4w3sdw5sdr4W8j0ESTx4lkx0o2vtQMEh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lq6ABPjTydr1YfmBo9rh5iF0KSUkL23Kk7ZcV7d4O2JoTU+qsEYx6+kdhkUHl8Pmfp+e2+nagfqlOEKPPD8Yq9u+Ef56nEpwjn+xcm+oGtUEIgH977toks/mR7ky25EEEVbYAR2Nc1l9T+5Vc/l+udUKWmTqgmLzfcnTobIWiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ze+SqWde; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9aa8895facso540590366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731798557; x=1732403357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Td7vCBCvy5qltO0Crd/rzRURZj8FOyjMicysTjqR3jA=;
        b=Ze+SqWdenoAqfX0BVukJe1OsBN/9L7KB2Xdl/OQsPh/rsQDFCLXdhtKtU3umOJWvOZ
         s7/IehUYlRAHvr4uAwq/tamMqqeg+umYC3zzVtz6iBgfHSYkBzcvVCJrU0DTIwR4BEx+
         3uF0VBZJsjyr+ClWKRQbwb468uD7AvjIQ8J+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731798557; x=1732403357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td7vCBCvy5qltO0Crd/rzRURZj8FOyjMicysTjqR3jA=;
        b=mb7f/INQg5tisNsdAl9d1CMnl0ORNCiAaWuf1Lxx20yjMcHIGF5Ilqp48/B46P8ENu
         A5NqVqri3UCRLj1uaWyElP/sA/uwrcBZsomA8ZOFPnVKqgYyvd6BrT2QKgEw+JJhyuqr
         MKRjhkzsFpnl6cRTH6OsMOivVqsP0LGLKSQFtUp+cO1re4dnCeV1bfVBb0L7QpvQZaSR
         HGU9fy+olpjcVj0eRdbVWOYxqyWJ64aA90Hvp6q/ROhc+LDWGvDgQWl/+SVqgurwvFqn
         ASzw3hh8wQTBE8jMWb6o02bC/YmNRd+VEvQPZa4Q46tiClNkYMGs9CWaYv1S0sKQDub7
         oQvw==
X-Forwarded-Encrypted: i=1; AJvYcCXNHF2djLaGV/s3t0NyeU50j7LA+g7mb+TViX7E2lLaybie0L9Kb599/5BwT/qUCAliimaOndpmNJt7DOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzF0AN49AUbkFpu5SvkdS03euR/wY2GXgYlT5f/qCqh+yttqA
	WYL9gBhaacTnKyVGJQg8sUgL/l2NbbhyS1rzos+pyMJs368ADRFhjai9FqNmux23j/Tp8sgGMPp
	fsUI=
X-Google-Smtp-Source: AGHT+IFLu0dv/BoRRPgcHqe3mXtL80Bef5LnLq4ZZjHtHx2FD5rN1k97Ca6AKSmG6t/H7DE9pw8t8w==
X-Received: by 2002:a17:907:7f8a:b0:a9a:7f92:782 with SMTP id a640c23a62f3a-aa483552713mr639990466b.52.1731798556734;
        Sat, 16 Nov 2024 15:09:16 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dff2065sm353183066b.96.2024.11.16.15.09.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 15:09:15 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so520848566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:09:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzqcEBf23tSZrvdlPrYFi+AKC+FrQvszAJDNdrVTodlSpzLX3t8KOTBISMsXPKcoy9PDMeMHRRJoK7qaw=@vger.kernel.org
X-Received: by 2002:a17:907:1c29:b0:a9e:df65:3a81 with SMTP id
 a640c23a62f3a-aa483554f81mr518293666b.59.1731798555048; Sat, 16 Nov 2024
 15:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <4055e18be7ff4f1f83fb9a4b6a8bc312@AcuMS.aculab.com>
In-Reply-To: <4055e18be7ff4f1f83fb9a4b6a8bc312@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Nov 2024 15:08:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=_RbcUfnjxL-X82wiCphU3_=d1qQ15JXy+49jmB6BVg@mail.gmail.com>
Message-ID: <CAHk-=wh=_RbcUfnjxL-X82wiCphU3_=d1qQ15JXy+49jmB6BVg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: David Laight <David.Laight@aculab.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Nov 2024 at 13:38, David Laight <David.Laight@aculab.com> wrote:
>
> If __get_user() is the same as get_user() [..]

No, the problem is that it's the same from a performance angle (and
now it's actually slower), but some hacky code paths depend on
__get_user() not checking the address.

They then use that to read from either user space _or_ kernel space.

Wrong? Yes. Architecture-specific? Yes. But it sadly happens.

             Linus

