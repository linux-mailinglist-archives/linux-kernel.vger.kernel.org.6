Return-Path: <linux-kernel+bounces-266347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D293FE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63851F221C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC318784F;
	Mon, 29 Jul 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gg/n+0qx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECC8479
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282655; cv=none; b=l8cXuInchoxiTdyJEGrYQK07BkoLyvXVwYU3TEmLq6nwfBugS+EhtE7e49R2jQEaerAcY25i83Y6Tmc9guud7L/mZcY1RYUK8+uF/PrtkoD44n13KNc1n3rQZI2q3NqVRZfdLQ7fyVXAJ30GkBEvK2nYN6pGNw3vmeaFBlAJZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282655; c=relaxed/simple;
	bh=UwPmtlWq84IcAFL6qRfqv9UndI5Fn6iEXMD04ihIqNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjIr+FQGi5H/lXIFao6NyQl7WM2xcIBfEcQV/vR2gbJzs6LBNtkt1dSlPcW9P7rQ1c3WcCIox2A3hcQeS7U6KBopYz4EjdTTucNQCCuxcuVZGJdH3WXcsi8B8N3PNZCLWbHokT86fyBs8HVoXyemov7zxsowrNHBD8L646zxR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gg/n+0qx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so6052913e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722282651; x=1722887451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwxEFIYqnVGHhr8kmrb9sUEThb6F9FzPLLTaFyHHqxM=;
        b=gg/n+0qxptaOh5gzb6660rt9v7lbKWHkWESRLOr2J2d4gEoFOTd5y6TJRLQ/FQlrsX
         2Pb7fCqvL3JevPVJqT2TsSisJZcycW0IngGA81xDYQuVAD3rBlNwK0CwpCtfLlJl9gI3
         qHEVOZBfLYf1La+V3VsQcjPYCRaoy0rH95HPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722282651; x=1722887451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwxEFIYqnVGHhr8kmrb9sUEThb6F9FzPLLTaFyHHqxM=;
        b=JgMkmRpYLl6M1Z9/moRsB63AD9JH+e4d/mM02db/Sitj+j1MO+2d0ODxEoHO1v9aWA
         wI4X+608U5ZsfFtAVBYml5BAF/HfItR7Rc3bfjpPwVUcLnliXENabVDnWjO0sYRZQVnM
         9MZTBtjuhMzyaML3eLyz6qom9MyJ3YJwFKFVo4C/xFvnQaZfn+7c3KpwajfrBjT4ZjMN
         DFhHVSqJTllobhvRzGrWTTlnT5L9dkhp2UBilAdq0KxMQZ98IrR78su8xjFPHI+y2466
         cEcUdSj3lP+Bq2wlzNdoEvh8nRvtNYklzyFXmvjj6NsDvwzAIdMqcKeJuKlo9+sMLnYM
         ipuw==
X-Gm-Message-State: AOJu0Yyir7cNWCJuWo9fpuU9bNAS7rM2tvn444WH1Ygvtdj3WBctims9
	4J/LjGsVE7nR+oAixoAFp97yD0spjNR49UtMYCUeNC4bpu0+qEOm9K0C1GzOCODGOLIHeGME7aS
	w/xTvdw==
X-Google-Smtp-Source: AGHT+IE45JdoKNfpVKLdOxlA+2EE+MapPUp4eRrvZR87GFAefrnbatvMX9/xGg6eTQiUz2J2MiCtAw==
X-Received: by 2002:a05:6512:3e1e:b0:52e:7444:162e with SMTP id 2adb3069b0e04-5309b2e0ae6mr7324689e87.55.1722282650762;
        Mon, 29 Jul 2024 12:50:50 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2fdb9sm1618112e87.286.2024.07.29.12.50.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:50:50 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso47723881fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:50:49 -0700 (PDT)
X-Received: by 2002:a2e:a615:0:b0:2ef:2c0f:2846 with SMTP id
 38308e7fff4ca-2f12ee05031mr54973551fa.17.1722282649585; Mon, 29 Jul 2024
 12:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net> <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
In-Reply-To: <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 12:50:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com>
Message-ID: <CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 12:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And that fix (if it fixes it - I think it will) still leaves the alpha
> allmodconfig build and all the failed tests.
>
> I'll take a look.

Well, the alpha allmodconfig case is apparently

  ERROR: modpost: "iowrite64be" [drivers/crypto/caam/caam_jr.ko] undefined!

which I suspect it just a result of commit beba3771d9e0 ("crypto:
caam: Make CRYPTO_DEV_FSL_CAAM dependent of COMPILE_TEST").

IOW, that is almost certainly simply due to better build test
coverage, not a new bug.

But I didn't look into *why* it would fail. We have a comment about
iowrite64be saying

 * These get provided from <asm-generic/iomap.h> since alpha does not
 * select GENERIC_IOMAP.

and I'm not sure why that isn't correct.

I get a feeling that lib/iomap.c is missing a couple of functions, but
didn't look into it a lot.

I suspect Arnd may be the right person to ask. Arnd?

           Linus

