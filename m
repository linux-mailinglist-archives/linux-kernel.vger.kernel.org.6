Return-Path: <linux-kernel+bounces-256641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48A935167
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A171C222A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18B1459FA;
	Thu, 18 Jul 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I2vpzOwb"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691A14535D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325578; cv=none; b=HjrnIgBFITsxKt9ynYdYVY9ggA2vgAa5bwt0OTJv8aLKAauXfC8mnlsrNS9mq4h0ZaNA0ocIt74dHKqe+u7hXAZWbEKj9pqRGa1PcMBGTB842p4jVr3o1mzPyWMFNYhTs64SGphsbOvXGMbW9zVsHzOPqvZEW0ZO0wvxcn/DIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325578; c=relaxed/simple;
	bh=Wy0IFokGwJYGUXAIqugE7Z0e3NoK7kmoVt0wQteo6Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+xVjUttmjXZrxLF72QXbVVj1h+UVo30jFGWSLkcFNZfPW/Uub7NgEMj8jlUGOiM8qABol6R1JjrgK2LOlnkpKgfgdqg/E110LkndAxdRaGIDDgNl6ed1xkG772JtGQGbLiO04RqpSzqQSQmKp4HPzJi3r6ezPIxRo/tO1X6jJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I2vpzOwb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so204378a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721325574; x=1721930374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5aL09+/Yh6o0fwipgODCnyP5VYgOkPRzvmeaKHvEPg=;
        b=I2vpzOwbWsF9ZCqtE9WoxsSxa4Rs1Mf64ieIOphVgUfGf2RfeDJQEs9kynJC3y4C9e
         fRzyYzgznQ+4TX8VI3gDmXMrH2djgDVc68GQXSKn0d+hgXutCsQv0kH7KUdxTJg7X1nE
         m9RAAaRwOhKB+Fvn2Ug9a1fRXoCKZJzlzgBDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721325574; x=1721930374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5aL09+/Yh6o0fwipgODCnyP5VYgOkPRzvmeaKHvEPg=;
        b=n0PS4ufO9pUtkubeGAGCrnUYm/3UAqLIe/C2IJUWGmDc0iPnjFuRqD8FMhntjjOH9/
         I9D07OU2kx6A7skJANx3oUr1sqb/3UgtCYd/imJPRjTzMiQgRJQr1u79/TQU/a8An0XE
         DqqDgi70UUq2tC3mWqZaJg2NGSkFA7BPpp527CzGAb+JmtSJ/xDmthewrY9q/wgmsEJN
         zI01fnZbFFlzpZj3wmcZGN2BqdwuWDDR0/YAuJJ/6SyLfg3jVDnTymfXhdC4XWx/rMSK
         Q7RV1COA2KJm0KrEAyUZdA5lJWRtnkILBEy99aTctsPZH+lt1cyvb8OyhRd8SCLaFO6U
         kRFA==
X-Gm-Message-State: AOJu0YznSVZBqNO9wtUGSCDMMlNpDNlji7VaGc3qN1RGBlQEK68EbWTm
	a9kXTXpv8GdX8rXWb7A0OYb9IbinEnC3GbR0BAsn5nQAuhD9zAW/Ge5O+SGk89fOldOKpJehmG+
	Fb92esg==
X-Google-Smtp-Source: AGHT+IHgMR05ugFP0VvR+NXu6/NE3eoVzrJdWk/dM3OBAbDsi61INlpVY9R8XhdNv3EstVWiZpqIgQ==
X-Received: by 2002:a17:906:f294:b0:a77:e6dd:7f35 with SMTP id a640c23a62f3a-a7a0f137e24mr356530766b.13.1721325573995;
        Thu, 18 Jul 2024 10:59:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d1a95sm584590466b.79.2024.07.18.10.59.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 10:59:33 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so174585a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:59:33 -0700 (PDT)
X-Received: by 2002:a05:6402:2105:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-5a2d10bbd26mr13918a12.3.1721325573191; Thu, 18 Jul 2024
 10:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718120647.1115592-1-mark.rutland@arm.com> <CAHk-=wjVvVfZM-cakf49j7XixrN9mNimyL0P7zZm-zoYKpp0_A@mail.gmail.com>
In-Reply-To: <CAHk-=wjVvVfZM-cakf49j7XixrN9mNimyL0P7zZm-zoYKpp0_A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 10:59:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQVVXx=vu5O3MxcscKKujvjUZebfUG-QuOkBV1GrnDqg@mail.gmail.com>
Message-ID: <CAHk-=wjQVVXx=vu5O3MxcscKKujvjUZebfUG-QuOkBV1GrnDqg@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: remove CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, alex.coplan@arm.com, catalin.marinas@arm.com, 
	jakub@gcc.gnu.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, 
	seanjc@google.com, szabolcs.nagy@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 09:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let's keep the "which gcc versions are scrogged" as a separate config
> entry, and then have this just as a
>
>      default n if CC_IS_GCC && GCC_NO_ASM_GOTO_OUTPUTS

Ok, I ended up playing around with this a bit more, and it ended up like

  config GCC_ASM_GOTO_OUTPUT_BROKEN
        bool
        depends on CC_IS_GCC
        default y if GCC_VERSION < 110500
        ..

with then CC_HAS_ASM_GOTO_OUTPUT just having a

        depends on !GCC_ASM_GOTO_OUTPUT_BROKEN

in it. That looks fairly legible to me, and seems to work fine.

I left it all credited to you, since you found all the problems and
wrote that big nice commit log. But it means that if I screwed up in
my edits, you get the blame too. So if that happens, just point haters
at this email and say it's all my fault.

           Linus

