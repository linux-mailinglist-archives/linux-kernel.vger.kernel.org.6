Return-Path: <linux-kernel+bounces-209136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D1902DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D92A1F223C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB73B662;
	Tue, 11 Jun 2024 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NB6h105A"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EBAD2C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067055; cv=none; b=JuAlfjQMbjsmNRpJk9zRkGmoQ10q7EUI8fJ8s4ou2pIsrak88hIjC+HTteHdhzPfJzAkb7aHAQrF5GOaQrZFR3hgKILsYwR/J7nkt0v0FRA263SyRWrKxjE9PX3ftvceUhg/n++E+6KWCRPE4zInWRDaaENgObw5KwK599srDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067055; c=relaxed/simple;
	bh=xW/JsFrvvdxfv6EVqr7rZU4s6vm7IMnNTV0x4eaBiKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfnJvbau/SgCYLrq6gBIyNJb5XKRTYqmCPLE/rWHnMcM2wglN01F3Tcv8SY8wjbfnUqJNw/OEmQ0clDV5dfl+ztwds1Ax6Xr3vhNG5IwUXvQTrK0JyJpFwNauImVO/iY+InT7xTZnClO0XN/2jdhjqroVsaEXIY9oidIHhxSJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NB6h105A; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f1dc06298so56247066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718067052; x=1718671852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEyzkTSmfTg9rMLE5THHkOuiUGT58uE3ZSUkLeaSyYQ=;
        b=NB6h105A2N/KNIIlkJJVfOirnWOPxQQ+9PirqH3T+3/1esYzkyUnrMyS8fGQCahNP6
         vHblRl+p+81xseSoD3Lf6gh1R5b6Rj0+p43C7BRuixY+L5dj1o5XibD1RrTqLs7UjhMH
         dV9wSUjGSJjhg4uhc/yNmLgc/u8FsOOQ38Zvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067052; x=1718671852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEyzkTSmfTg9rMLE5THHkOuiUGT58uE3ZSUkLeaSyYQ=;
        b=CbEoxHKNPPuxQ+63+ANdQoatdLYucvW4onEDcf0/Tte1JXGkEb408hmrTkOk7zQXOa
         HfP93byK9BzmdZSaYwYs80fcM9UO7a8U5cubR35K3NUNsDvjDFEfuKf0bOuGyOXFDzMh
         7ryf8nfraEzUHJpAGspdOYuAKbTtzwfaqfQh+pXE2y1UDJpfZ42EFePd7n6X2CwEq3YY
         dOuz6UQlUBPv1YaS1Z9T3KzIKjYVJdxJ3ZWitfoF4jRN3gYpkhPNy6mGw1d8Ygg3tC6o
         DtPV/oX3TtrctqV4UpMXkzqmz4u/GuzBFM1wrrm/L/LxIz6XYjv0Q3aAZg22L8cZhb3O
         zxpg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZyfhUBCTNnVyxLN8J/3cYgwUwLwIdybzvKpeDYri68q/gLxTa+/odrmOea41FkaeIOnQPEZqYDo4hKu1FheYhb7+DPFUj1rYUO4+
X-Gm-Message-State: AOJu0YzL/4tkGs2lyZkM1+NE7P9HKGZLgBcqSUaaW68+5JevQhsW7U5h
	PNgdbcqdfwy+tC3O4Ecl4tlooYFJb9IFsqKUSEr6VGmopexEWWxPkOZZUi9dtGB0RsWHegsRGxS
	f+RY=
X-Google-Smtp-Source: AGHT+IEYjXjxCE5vyBCgn4fKX3gFp2/0/KAcgafutCZ2pi14DL9fUQsFfMMbEJyjTtNaExlvqtzIpw==
X-Received: by 2002:a17:907:2d89:b0:a6f:d1d:75f4 with SMTP id a640c23a62f3a-a6f0d1d76b4mr478760366b.55.1718067052084;
        Mon, 10 Jun 2024 17:50:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6effd5bfc8sm393809866b.2.2024.06.10.17.50.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 17:50:48 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so56844966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:50:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaOxN9CQwGJ7PsYX9TjAqtK7gD/MWSqDyTPAJdaIj3XU9fFlsYHLye4EKRH1yM7OnbQoR7iPdGa46ABIrf0bFo/nZR+CgSkPAZx6u/
X-Received: by 2002:a17:906:17c3:b0:a6f:2b19:e82f with SMTP id
 a640c23a62f3a-a6f2b19e99dmr137168366b.28.1718067047933; Mon, 10 Jun 2024
 17:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com> <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
In-Reply-To: <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 17:50:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLytEj0Ccs1CsVPxmbLavf8Wk4ciDskhwy47rgyq7Oig@mail.gmail.com>
Message-ID: <CAHk-=wjLytEj0Ccs1CsVPxmbLavf8Wk4ciDskhwy47rgyq7Oig@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 16:35, H. Peter Anvin <hpa@zytor.com> wrote:
>
> ... which can be compacted down to a single instruction:
>
>     addq $bimm,%rax

We'll burn that bridge when  we get to it. I'm not actually seeing any
obvious for 32-bit immediates, except as part of some actual operation
sequence (ie you might have a similar hash lookup to the d_hash() one,
except using a mask rather than a shift).

When would you ever add a constant, except when that constant is an
address?  And those kinds of runtime constant addresses would always
be the full 64-bit - I don't think 32-bit is interesting enough to
spend any effort on.

(Yes, you can get 32-bit rip-address constants if you start doing
things like conditional link addresses, but that's what things like
static_call() is for - not this runtime constant code)

                Linus

