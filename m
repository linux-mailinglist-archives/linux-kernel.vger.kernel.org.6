Return-Path: <linux-kernel+bounces-334992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ABA97DF77
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA76B1F216A6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD1316EB54;
	Sat, 21 Sep 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a9jNn4gA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A753804
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726958410; cv=none; b=Xa9wmG8HvNoZICwGJFzmG5UYBdjj8K4s1+Vzr8yHeSGsS0u36xAFDxktiWn9u/fX+oamg8OC19f+vVdGeqzP8jlGujn/LqS+wFVGsXiNNHxzAIpfjmehTIcpPiBfdyXNkNovped/TrniRLXgVDwbfKdpX9070YRgPbf+Zi+sMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726958410; c=relaxed/simple;
	bh=i6UGHvn0NlCb7NMXzSQc6lSGYWO6d8Nh1O3SQketvSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeolQtp9SruxqgLG51kS39OeFz7U/dnnAg+xU0KK1QQRSGrIkjsUFzLB4seipzNuuqbXlTkMYMp9zLsWnF3QqR9cg3JOLeZpNe5aFJTD+yZZ6XLK84ba1k6CI82oFY2IVGRQSFteHdez5L3k3EchqaTLSHWnybHOYv4GmHXV0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a9jNn4gA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c4226a56a8so3805017a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726958406; x=1727563206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plt1UiMUWuPsIzwz+72FDwV5eGBDH42f9ag0oCj0M/k=;
        b=a9jNn4gAFAEhQzsyx9UIdaOig6yZS276LrJUvl6em/jJVAmZrYLsIY9Q9w78YnI/C+
         F1YFJ4QHXTITyUw9+uvr5OLA53NBsUKqT6x3legPHqcAGsHFkWyFvu4IKx+ZVR+jSnWU
         bb2MC2F/z00HuIRQ8Njk35RL63Vu698ZgbVGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726958406; x=1727563206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plt1UiMUWuPsIzwz+72FDwV5eGBDH42f9ag0oCj0M/k=;
        b=SGhbUZ0xFdRpgFePW2tWYBibENOwdEPT3PPnjOrmqCRoB0p9ihoXbirThgW9ju4+1r
         YXmrj6lGD1yKnWGHoDLDzaNbL0XJl4tJQVIpPSjN+u3cAmV4cgpoUEkeLermgfxNrUsb
         8mlGXlcsUkC+kKMEHSZwOwqOY+GAcXGHvxvY+PoAg55Z5PWGGeRxGuHYfUt7VUpvH3vv
         p3rSfG0DOhC05s0+J2Xq7K5IU6JSwUYz8xbnTHrLlNf/neX+efex59PjVmsqsaLd5CYx
         1F/mfMv+n3YgsXHatGdzCX/aGV7dbRRyjkSownZDsQXZwEZs61F0xTYn46P1Zopo5Nfl
         koTw==
X-Forwarded-Encrypted: i=1; AJvYcCVmusYpIbDHAaxA4CS/jvmpIj+BzKCCrMjN6V4vdFKGJqur7gHpp18dpNGFM+xASLKSwtrO2TcfF6Khm+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4PEKqpMPMMTBNzfMn1BzZs4bU2qXdXPKIweSFEol+E9xtVSy
	OHsRl5uTtRtESwYwMpIsp9mkPjIR2a/rHByzpiVrm5FEmnzGMA8q9IdN3uCtnWnRwq3LRVui9xf
	lw5M=
X-Google-Smtp-Source: AGHT+IHASOvkTdRuNspfdvzjgADvxHr9hnYBJECQ+CAgkIvMxOxnJrQN+42UzbCiIAOuNbwtfZvELA==
X-Received: by 2002:a05:6402:2694:b0:5c5:b9bb:c65a with SMTP id 4fb4d7f45d1cf-5c5b9bbc771mr2000903a12.1.1726958406072;
        Sat, 21 Sep 2024 15:40:06 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89d5bsm8688133a12.74.2024.09.21.15.40.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 15:40:05 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso448088366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:40:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCUP/srJS859zKYbkG9KARp166sw8jek76JQPHJui2BSZo9dYXNtXAsmurKdVKxm+6il5vejLcQChU0qg=@vger.kernel.org
X-Received: by 2002:a17:907:d3e1:b0:a8a:71d5:1094 with SMTP id
 a640c23a62f3a-a90d50eec25mr626803266b.46.1726958403863; Sat, 21 Sep 2024
 15:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <20240919082624.05ca5fd6@canb.auug.org.au>
 <Zuv0kA-um9ZT-Tjd@gmail.com>
In-Reply-To: <Zuv0kA-um9ZT-Tjd@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Sep 2024 15:39:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
Message-ID: <CAHk-=wiz_57SsfaX1JkmDJ2sMo9Pfiq27XciQeh7GE3tDBVDFg@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 02:53, Ingo Molnar <mingo@kernel.org> wrote:
>
> Thanks: I've queued up the fix for this ARM warning in perf/urgent and will
> get it to Linus later today.

So this apparently never happened.

I'm back home now, and so I now do my arm64 builds too, and it is
indeed failing.

                Linus

