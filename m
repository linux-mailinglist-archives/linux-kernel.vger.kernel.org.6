Return-Path: <linux-kernel+bounces-202975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7DE8FD41E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417C5281AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D013A3E6;
	Wed,  5 Jun 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QLW96YGG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647D17559
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608505; cv=none; b=TNevjmlWj2ktl2t3aMhh4gynLgzJx7VZoNLgaU8B3SloTVBf8ufsjcUR/ERCdIjT0W+UWn7hfh+nBQV30Ja4P7rKMkv4n44riKCUAZmiD5hXYGNIkLorio8WOHueVF8r1h0c3gWizG7ctEMT9q66435akGHkSk5vth8AsIZK50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608505; c=relaxed/simple;
	bh=XP6tkOFd0C072GwY8agXH+2tb4jHU3NoYBT8an63N8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua95+N8NY2F5FFmdrBWiTOo5NnmuNFyY7KXfLu1AuqGX03DwUpwRIjYiaLaC6h2hS+0ZTvf9FuZvQMdAVh9hRUm6pD6OJ8Emi2oGS6VKBmcJ6PiJz0CqvDj8cprEku557UX8ghllJJPvzkejt78uU7DHjdt14kLxGDTJn88AhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QLW96YGG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a68f10171bdso13725766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717608501; x=1718213301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PJRw7eSxoA2KEV9jozZythLGW5dH+2O7MsCsi/2+KsA=;
        b=QLW96YGG+UxI95xSyWdSS0SjIAAO+lzGx6ymOjEXIAeilgYgvjZn724BY+sY5KCXeu
         rGVJ0VqgD6c3oSftp9a+fcXs+NY2LVLVnNqaeAIaNmvvx7Yi7OmrYjjYMHmk03rJ/vFo
         3KDAFzSEeYPlc+qcdjm1DcJqkKC5JzOMp9myc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608501; x=1718213301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJRw7eSxoA2KEV9jozZythLGW5dH+2O7MsCsi/2+KsA=;
        b=WNI76AIG6xk0tCn6rM2cxeNKYe1Ua/4XPeBETtj52EWfo8MECLL5ldvyJiMQ7Vqgqs
         tLoaTjAaYXfp8fjc20IPNOaJKpf6z04ZQVdx7lVVtCMytaDUIQiMVA2mdgo5eHChMrCg
         LK+gQf+a0NLjYdQimS03Ak+gDEjuGA+CExWFFmZ6RB6FfCw8lE60ZMwosKWCZI+H91pA
         p2UZks9RZcr9cObHUhCpLhKIn6uHvcO2nMmBil4MgKCKkgqGUwlBtGyu1qRgroKai4Vw
         OFlPf7nTv8eK3C2cElIYkU/hoJrQGBNih2nSJoidQOG3+GMhOTRQIzNPHHfZa0mvkFcO
         VY+w==
X-Forwarded-Encrypted: i=1; AJvYcCV0yE8yMg+Jg/JvB1lPTWRrXYhWsC5WY9npDMVIT2eQw6SiiacsURBZEWSgfx4wEyB6t1FqPav37+iGVPBpZqwUjprk+1kwL0ku+kuJ
X-Gm-Message-State: AOJu0YzZWW+/RiRGGZybks8BwWgTT3cvvTt0Gsf/qLVF80RrxJfaqLLi
	PUJU9Pk5G3zZ57L/JIsI7rZBaovw33Twp4YMXBYiTklN+T5uEl+MCVWVg1QQXPhTeh2wEDYF6FY
	1/W3KSVXx
X-Google-Smtp-Source: AGHT+IGv7LX1ooX1K2oeD41J48YjZ+9r16RJzk/WrgcjRCC+OA1PXgcX/nA2nHMXQQG5Z2yIik4glw==
X-Received: by 2002:a17:907:bb84:b0:a59:c23d:85ce with SMTP id a640c23a62f3a-a69a000e2bcmr252024866b.51.1717608501382;
        Wed, 05 Jun 2024 10:28:21 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68cc45cea7sm619236066b.51.2024.06.05.10.28.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 10:28:20 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68c8b90c85so8446566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz6CG0Uqbetq9/W2iDQPksHvj3H1jJ7NMcQCB1MEso2Qv+q/SKiqN3Us08XbpTmgcRTL8rkoWX6X+pWq6kKildBsWnTSBNt4osOFVH
X-Received: by 2002:a17:906:2b9b:b0:a59:b02a:90da with SMTP id
 a640c23a62f3a-a69a002af78mr237486266b.68.1717608500241; Wed, 05 Jun 2024
 10:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605083557.2051480-1-mingo@kernel.org> <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com> <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
In-Reply-To: <20240605162610.GF25006@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Jun 2024 10:28:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
Message-ID: <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Remove init_task FPU state dependencies, add
 debugging warning
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 09:27, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Yes, but kernel_fpu_begin() never does save_fpregs_to_fpstate() if
> current->flags & PF_KTHREAD ?

Ahh, and init_thread does have PF_KTHREAD.

Ok, looks fine to me, except I think the commit message should be cleared up.

The whole sentence about

 "But the init task isn't supposed to be using the FPU in any case ..."

is just simply not true.

It should be more along the lines of "kernel threads don't need an FPU
save area, because their FPU use is not preemptible or reentrant and
they don't return to user space".

                Linus

