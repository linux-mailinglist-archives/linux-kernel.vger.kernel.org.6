Return-Path: <linux-kernel+bounces-173966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2718C0863
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F23B1F22596
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512FB4A2D;
	Thu,  9 May 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xpo/PAws"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A51FAA
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214209; cv=none; b=oU+f6FZ06edPZOJMK/2moC2M3SonM2fQjPzmdPhUuBN0xZgIERWSyQNegHKppmWqK8GOsjhXxjgEDGxIxWbgS/6UQq4AYlvtVVdn9dxQLXn1wOo9xNUGuD886rKj34ZcTHjE+F3yU/Sh77Ci6hbbWW26GMl9KX+OGMZlwZmqLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214209; c=relaxed/simple;
	bh=DODW/4URxRbA9DuTjYXWV8p06cnOAPHfE8OhcWBuxFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fah6J19zJlKA5R/Y8qKBTFpiKrQ0o8jM3IlkOgf0w54YTncuYnLgave5GI380fgilHx++a+u9RSl9D07piAL/SWlTBt6J83C0u6jzEfMCEPMmElQBqxQ18S95mk1GanTzLoWeCZWr2oV5TcvpduSmDMl4J8V8DRr7/c/YIe9hE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xpo/PAws; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59ad344f7dso57370066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715214205; x=1715819005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUREf8Y8+BNsNPUONsk6UGY92nmezphsmslNvqS96no=;
        b=Xpo/PAwsYDRRhcVVgrwnbY0zUMiOW/DCeIubYiyek5eabFag4nE1xkqSv/ppZr0XJX
         Ojr6FH75NjQJ9w9oyggoUaFzU4jsrJqBp8pZArjlaN1SZLMLIGBHy+eEgby4Fe88hO3u
         5VBisOXnbuR+/xXI0zO7yEHW/Y6ZTgeMDmPag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214205; x=1715819005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUREf8Y8+BNsNPUONsk6UGY92nmezphsmslNvqS96no=;
        b=fbTenb53eDwF7vRpGbeiiyLRYmt+bQ2QEkwdOac0HpaHXJvmQHyG6bArAWoa3DZqH1
         h5pB8WX0E/kumeGuy8ocbzRdMapq6qFHxaNUXlEBgv/uSqrIkXzdJJOxMeXGPACEvGbn
         3GUf++vqJ5MWLhq+S4exl1p67MsKDZgSshr0odcl3UAOsdnRlG12KtnlmMpLGRYCv6YT
         EYVgkXLjquqgzEgGO2hYYLoeZM38WOB26BXAx1R+czeUtqe8zkmh0LyRYD9HmGU5X55V
         XRbaBzmGr2a+XnY22PRhybd7GIVByxIZMFP5qfLlBCov6wAdXpPREuWlEbAc4gwtC9Z7
         H8fw==
X-Forwarded-Encrypted: i=1; AJvYcCWadYfhrMN4jbnFjGMOPgUx9/u0S7LhNwD6vAStysBNyaDvjqsJ+OObe08nwpbllpC3xmdrW8Ej8IbWzc0tlKrnOS75AGniTYBCXwMf
X-Gm-Message-State: AOJu0Yy6uh8wgPXXjzazVYohDsmsL10qQrzte0MqEhHYW2X4UFN/ABrF
	wL/l/w3c/lfbnXf6qJIQUuULabqFetUfvH+gka6CHgOycC8hWDB9ge/OesK7RG++Oq8ZTDhErXd
	ggYe3GQ==
X-Google-Smtp-Source: AGHT+IFr9JV83mFI/mkfzKohugU62qzfSYH4bTcpWfdwFm2ejO1ZcHUd4LM56aksThP4ajOSiBTEPg==
X-Received: by 2002:a17:906:260a:b0:a59:f3f9:d24c with SMTP id a640c23a62f3a-a59fb9e6872mr270339266b.76.1715214205413;
        Wed, 08 May 2024 17:23:25 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cf60sm15430966b.14.2024.05.08.17.23.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:23:24 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a387fbc9so68755366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:23:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyx1HcnbSXYn5f0m9sAwGjL9WL1IeiOzjuiodhk2GvZsTnEuoNpXI7A+pXgwxsQHQpmaWfzQQRU8/IFlsAIaCGXENUnGRO/+aZBRUy
X-Received: by 2002:a17:906:f6cd:b0:a59:a7b7:2b8f with SMTP id
 a640c23a62f3a-a59fb923241mr262394466b.9.1715214204485; Wed, 08 May 2024
 17:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 17:23:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf5mpRT_Aiw9aebX_z0i49aUbUBEPr6jk_dUaCTuR6cw@mail.gmail.com>
Message-ID: <CAHk-=wgf5mpRT_Aiw9aebX_z0i49aUbUBEPr6jk_dUaCTuR6cw@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 16:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So *that* I feel could be something where you can warn without a ton
> of compiler smarts at all. If you see an *implicit* cast to unsigned
> and then the subsequent operations wraps around, it's probably worth
> being a lot more worried about.

Side note on this part: quite often, because of C promotion rules, you
have "int" as an "intermediate" type.

IOW, while I had that example of

        int a;
        ...
        a * sizeof(xyz);

being questionably not-UB (because "int a" gets promoted to unsigned
as part of C integer promotion, and thus you really had a signed value
that was involved in unsigned wrap-around), if you have

        unsigned short a;
        ...
        a * sizeof(xyz);

then technically that 'a' is first promoted to 'int' (because all
arithmetic on types smaller than int get promoted to int), and then it
gets promoted to size_t because the multiply gets done in the bigger
type.

So in one sense that unsigned multiply may actually have involved a
cast from a signed type, but at the same time it's not at all in that
kind of "accidentally not UB" class.

I suspect most compilers would have combined the two levels of
implicit casts into just one, so at no point outside of perhaps some
very intermediate stage will it show as a signed int cast to unsigned,
but I thought I'd mention it anyway. Implicit casts get nasty not just
in assignments, but also in these kinds of situations.

I still suspect the "implicit truncating cast at assignment" is likely
a much more common case of loss of information than actual arithmetic
wrap-around, but clearly the two have commonalities.

              Linus

