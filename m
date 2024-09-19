Return-Path: <linux-kernel+bounces-333096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD897C378
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3415F283AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708782B9C4;
	Thu, 19 Sep 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HkA5FCxt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA81C6B5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726721228; cv=none; b=G+/3XUYj6N7/cBOW0X0+bhP03La/V57gDqHxwOnmq8AaC10nwQJScTlmIffukodQt4Im0lW73PWBL1zrXNdu6VUCus9PjXvM4yUgTeVzSzl7lCd2YyiJZybWVxRn0BmjfhLY2wKW7kXb9AqsOZnACcvf798Dud0GM6/kAp5mtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726721228; c=relaxed/simple;
	bh=0x90BrRaLqj/i8vH0YC0E0hwcTLNOAmqTSYD3JcCxfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0SuNJ/Q3fdxiZEFmLzPzfQcUPnILQNh/vnlUmwKFm5O1T8LuN6L1xjk909dq4qj4EQEY3ZauBJwi7bnxQfHltGyEhPPcY2FC3jygs6D5XA85vGyqFC/kwU8bilwS0DDeiKPPhOzRuwq+M+H6FwHuh25HbLMXlMBt7UrvQVnBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HkA5FCxt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso46659566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726721225; x=1727326025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5K6WdNxpXbbHrFkTCJEcTGagR1i25Nnb2d6KDOnxQ4=;
        b=HkA5FCxtIdq8te0uOAHXujCJzyX52O6rnVOpdSnqUWbhd4u8+NXx05+vnZqEwgJjCJ
         9/O7WzTVQXdlxb5eJvKxMLH9TEGQK1OT5a4fsgCsr6974T9RRZIwfZb2c6y1NzlcW3nb
         unKi3V69Va6r4vNq1kMZMQRNIEItNDMMNXdVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726721225; x=1727326025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5K6WdNxpXbbHrFkTCJEcTGagR1i25Nnb2d6KDOnxQ4=;
        b=kTBiFEssfPg7euqEcv18hL1oByEvgjxqyqGk68FDXL1CIMTM0+6sFWTeV5TahCt0y0
         CeWNvDvIihIxfPctCKyCAzPAaJiWIjard1AS4HII1tFaE+pF3do7O1ljQUL4slR14Rg2
         BHOZ3F3vB2aiwhL7DwQpzDdbwwEBdJZBm/gJllTRx/DbmtLjAk7aEVh8t5NzAXC8XtFs
         S9kNQY2vYw20BmnILUPLzwgiKFP/5SypXwfLTDCyrLcS4evpBxgwnhgDXFZpmWIYXIIZ
         2VEFJY2xjVOGAZ3CgQdRUOCQaBhRLbYThd2hYS4gM3mZs7Wre+og+Bp60eaPhx+8RntD
         QW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTsPh2MLw7KMN8IlLHCY/697fwzuOmrpGlmwIXHdlWXHPAWpx1C7UFPw0FUiN3RSh8wnZguRxKxiU3opY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUaf7pxpzL+ZBZVmNkKlDnCztKcA21ZtqASFtapueXWO3GSre
	av7A1YdW5jnU2G2ICagbtl0MabXHP6eezi2kMki1Y+riur9vFGWHWM2QJRRFPUq3RHFF5UxJ00Y
	610QrCQ==
X-Google-Smtp-Source: AGHT+IEMFJO7pwuz1c19MkqNQT1ZjxNyfId6Z8kISo/sGezKBH3QxM4k/18wLwvNMVZtjMZoFVwFPA==
X-Received: by 2002:a17:907:e660:b0:a8a:9070:a6ed with SMTP id a640c23a62f3a-a902949a1ccmr2495306466b.31.1726721224792;
        Wed, 18 Sep 2024 21:47:04 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109671fsm680268666b.11.2024.09.18.21.47.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 21:47:03 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d4093722bso52693166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:47:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy0Q7nVJf3cKacYepsX7TJuLwQ6JAiYRFw8VcK8aR0a9NGn0IWAKJGGCipCWJnT4U11H1wMac1OjlTOUw=@vger.kernel.org
X-Received: by 2002:a17:907:efc6:b0:a86:9c71:ec93 with SMTP id
 a640c23a62f3a-a9029438edemr2426724866b.24.1726721223112; Wed, 18 Sep 2024
 21:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZulMlPFKiiRe3iFd@casper.infradead.org> <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org> <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com> <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area> <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk> <ZuuqPEtIliUJejvw@casper.infradead.org>
In-Reply-To: <ZuuqPEtIliUJejvw@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 06:46:46 +0200
X-Gmail-Original-Message-ID: <CAHk-=whPYGhCWOD-K2zCTwDrCK27Y0GST-nt+cb9QPzxO-iSHw@mail.gmail.com>
Message-ID: <CAHk-=whPYGhCWOD-K2zCTwDrCK27Y0GST-nt+cb9QPzxO-iSHw@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 06:36, Matthew Wilcox <willy@infradead.org> wrote:
>
> Probably xas_split_alloc() needs to just do the alloc, like the name
> says, and drop the 'entry' argument.  ICBW, but I think it explains
> what you're seeing?  Maybe it doesn't?

.. or we make the rule be that you have to re-check that the order and
the entry still matches when you do the actual xas_split()..

Like commit 6758c1128ceb does, in this case.

We do have another xas_split_alloc() - in the hugepage case - but
there we do have

                xas_lock(&xas);
                xas_reset(&xas);
                if (xas_load(&xas) != folio)
                        goto fail;

and the folio is locked over the whole sequence, so I think that code
is probably safe and guarantees that we're splitting with the same
details we alloc'ed.

                Linus

