Return-Path: <linux-kernel+bounces-256879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794089371B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF91282125
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A328F4;
	Fri, 19 Jul 2024 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VXRXVLFC"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6AB10FF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350641; cv=none; b=fO7VzEyLPvNYcG2B3gYvWIw/SXDVf81ZZa/PzJE/Q9xkhsnr+RnCEh5Hby9ecSh7syTuOue+KEVMFoxtVRscizcSP+6ocb+uduxdoi5psfccQXK7pP0R0Jmp1foiNEUU9b6LN0Yn9dMFQhypXPdKH6cj1xPlUv5CzVrJMAXNrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350641; c=relaxed/simple;
	bh=bxkdekVSQ2JTN1XHhSUQWYFzQO1BovRjn57ADm1tuOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuYIZH2ecKHdQZT4UYCwpOOl7xppUvjZwRdlYWbQzXcZIEEeTJp6uBGXKy7y70lZH3gOBnuRnkgt4TXOVYw0l1dyopA7wYHwh2dAvLw5kR74FlXLZAgCiSMgPI1to1hcoMet6BFYQG3lc0opxnNBT8EdSXgsvL6JBLfVzvdwX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VXRXVLFC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so15854431fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721350638; x=1721955438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXMULHl1GDf0VFRHpPP3P720vcqt+kXwj4ZhGAYzGRE=;
        b=VXRXVLFCQ36MGuTauiRidczstMqpHWmlajONj1bfOAccrsWvFY5gLstVV6JNoKF7Q1
         yAlB3+eqJS31b4Je3tUurktmYDfs04oyyU0pcT0aJ9VJyydbI2yXqXlbENXRHT39JSvZ
         urbriE0jXJamWpcahPr5Ezu8+0V9zli5wbeJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350638; x=1721955438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXMULHl1GDf0VFRHpPP3P720vcqt+kXwj4ZhGAYzGRE=;
        b=USKLJ3MxWwoiKZkg96Fde19NTgRr8Q32LmNbn70v2OyXuDi7+hdwUMQwY9j9UUZZca
         sPYvDRtE9+j9z5F8fIQ1w2sahIrgLnFu2dgdcIud+AN037JhBTp/D/pDBI8z4UcsxHUo
         +tD7mmMvHanlIfI/waevNSXugVZJIN532ANaWiMy3GE6ser1eEctTg7tRu6l624nl7LC
         YZF2u6HcDK3Mg66OGUVA0nZNHgfj+EQu9KL3BtQk0n7HZOBCqrWFdrrDtTDNbgSxQKJX
         w3yfSvZGc6OU/nv9i7TN3VeBLfnJ1vZTPZMVa6n75rPbdmRr4Er/ELG49fXWKM5w65Jj
         K7eg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6Ix7vPbtl6KszFRY++jyn6bXhmZg3PRl29jJU0aj94lse8DW2nPZWxoiBTLF6F50BX3DwmqdM5KgkgvnQTeGwICbn2UoHgX+YY5U
X-Gm-Message-State: AOJu0Yxy6FHFAg2SlXRbpOImVUtDNONZtZKbb3IKdO3TaOr7Yufwq6Jq
	qSr1IQJc7lAEpiFuGVasseIsu2Vt/VzloZLFi2yNAYnsDBqnXYK3AJymjqPg6STBouThCFeY9gS
	4oqTcyQ==
X-Google-Smtp-Source: AGHT+IEgs2Afd29c44kkI7H+mmL7gM+p0W/GbwRAKTEfNw/tvDgsgaGDruv4Pd8GmrVdhYx3/X+jtA==
X-Received: by 2002:a2e:b1c4:0:b0:2eb:2e0b:72c with SMTP id 38308e7fff4ca-2ef05c7515amr29429941fa.16.1721350637650;
        Thu, 18 Jul 2024 17:57:17 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa254asm198119a12.29.2024.07.18.17.57.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 17:57:16 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso152440a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:57:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOBK3CGlghTyOkaIuV2igYrfHhUgOID97txJd+cXA6AT4ZFr8jdOclZLHgjgd2uaIwwEsA+kAbu1m+TlJq6FSUgF2VgzX70+mISUdq
X-Received: by 2002:a50:8d51:0:b0:5a1:3b03:d0cb with SMTP id
 4fb4d7f45d1cf-5a13b03d7b5mr2914519a12.32.1721350636369; Thu, 18 Jul 2024
 17:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
 <20240719102824.1e086a40@canb.auug.org.au> <CAHk-=wi6RzMFr3zWfkwHh1JwLxQzN0BtH3H7M6JJogVxOat8CA@mail.gmail.com>
In-Reply-To: <CAHk-=wi6RzMFr3zWfkwHh1JwLxQzN0BtH3H7M6JJogVxOat8CA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 17:56:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whN7k41rOGfGA+SBS-A07p5BcncgvLNLXVk-C6aa4tRdQ@mail.gmail.com>
Message-ID: <CAHk-=whN7k41rOGfGA+SBS-A07p5BcncgvLNLXVk-C6aa4tRdQ@mail.gmail.com>
Subject: Re: [GIT PULL] probes: Updates for v6.11
To: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 17:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> One possible model might be:
>
>  - remove the numbering from the syscall.tbl (because the numbers
> _are_ going to be different)

Just to clarify: the way I envision this "remove the numbering" is to
just make the numbering itself be the result of running scripts on the
system call table files.

And then different architectures could have different areas for "these
are the generic system calls" (and some kind of support to 'include' a
common file listing those), and the "these are my own system calls"
area.

x86 kind of has some of that kind of thing with the whole "system
calls above 512 are magic for x32".

Of course, *that* then failed too, but I don't think the concept is
necessarily completely broken.

             Linus

