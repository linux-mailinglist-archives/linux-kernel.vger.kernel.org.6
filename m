Return-Path: <linux-kernel+bounces-332701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7397BD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB0C1C22056
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8718A924;
	Wed, 18 Sep 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y5QQ0Ze2"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733371865E8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667523; cv=none; b=QNZFsweC8H2J/SPal+Pun/x+b3LZsHkUu625vMiUJ3O8S8EU07d3YnwMYvZEdfoVFOMaxhibH65hZ+pOVrppD7wofGKp/4+xNw+0A0M3oKihm8U/c075gwAuzzUDcKnQRupW9GQzfwhu/Thyi12wTZUb1f4R5CVnnt/N3AoGK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667523; c=relaxed/simple;
	bh=jJVr2CDyy7rQp2h2UjSJiI9buPJ4d++KINwnkdK6qcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkVsP6AoBMfLtKV2MAUILi5ykEBetpPnaHKljH+Q0vDXhwabOfGi79sh8pBg5XPw9+SKf70sFg0uk6KqyD5wHES4yftlMV3v+SGQPD7j1fxAqmlAmx6tUiooDeVO9k03Zixzv6yYXtd34E+j8uOjJ9EBcWJaTpQm9nrzWevicHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y5QQ0Ze2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365c060f47so7627653e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726667519; x=1727272319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OjIl9uDxGAJUC7PJ0lAX4rCR6IE5m7Lsi7Ws5gE7Fw=;
        b=Y5QQ0Ze2C2/Lyp3vpbQlEVIwUiAcRTMyC8tJNNyncaeNz+Fp9s60R858g9u6hMDnwA
         AG39e/vi9vbeT1LhsUCquDaK8DqKRQ392I6QMniUMEHf3SR/6m0FPa3ma7R5Tm0R5uN3
         0mscOYZU5Q5pn4BoUEg60al7/N2nqkeIZ1PL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726667519; x=1727272319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OjIl9uDxGAJUC7PJ0lAX4rCR6IE5m7Lsi7Ws5gE7Fw=;
        b=W4OauSHILJ8gVbH39hgfwgiJXWU9Mqy5/UO7kjxQD8+P5GDgoGfe5f032kkXkCWLx5
         ZYLoJBV/VPSa+W2779J6qEmZqxcgiMwzNAVVtGBrmMBbX+hwBCU2lfcGT8uKDVabcWmv
         1IkKgMAMrYJA7qFZw/SmAIfh2UO20rZ7kAlzHHcLiMgCcH6tFVWTe9CW3asMgu5P6flM
         iFeZtlfvmFC2SzEC0q+ELe9VCapRXG+OPESMrN7cYa0cv9JM+iH/dMoPG5oVaOcALdY9
         RKrz4OrjLmcLoKeq1aDx98VLHTLv6+lerqsc5WKY57Ea5vil/24AQhUOZalCv7LahB/s
         NSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj5uy3m5fLZlbHBBzIvGe9TmHFbaFwB5xuShhlsX0uczFVc7LUavGz18d7XizXjs8UOwTYCaf365wkz7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLkc3AyxXFtfT12eoDaddXUYQV/fASRBeKpDoslIBpur4IkBV
	6NzODMasygEYMl2FM7i9a+E9ZNxrvVEfouvlo3umgNAc5zUQ7WmXmTH2/0l6T0VzjBU+zfn9OS/
	AZpqHkA==
X-Google-Smtp-Source: AGHT+IEgNuCfh4Os70YpY5DfOYxYxXLK1gJe6LOoUGnVtYQ+d3cdX0WWoMQttNcENW5xm87wfFCNBg==
X-Received: by 2002:a05:6512:a8a:b0:530:e323:b1ca with SMTP id 2adb3069b0e04-53678fce6afmr12848014e87.25.1726667519371;
        Wed, 18 Sep 2024 06:51:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b411bsm1519430e87.250.2024.09.18.06.51.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 06:51:57 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-536562739baso5800479e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:51:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVa9oNuHZypvHT3YunRMjSV8ZwqNsPX9v37k3Nv7B+7ciaHCZY988inOKfGd20AEUNDNP35zwv5hd+evA=@vger.kernel.org
X-Received: by 2002:a05:6512:4019:b0:52e:fc7b:39cb with SMTP id
 2adb3069b0e04-53678fce759mr13328998e87.26.1726667516650; Wed, 18 Sep 2024
 06:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
In-Reply-To: <ZurXAco1BKqf8I2E@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 15:51:39 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
Message-ID: <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
>
> Oh god, that's it.
>
> there should have been an xas_reset() after calling xas_split_alloc().

I think it is worse than that.

Even *without* an xas_split_alloc(), I think the old code was wrong,
because it drops the xas lock without doing the xas_reset.

> i wonder if xas_split_alloc() should call xas_reset() to prevent this
> from ever being a problem again?

See above: I think the code in filemap_add_folio() was buggy entirely
unrelated to the xas_split_alloc(), although it is probably *much*
easier to trigger issues with it (ie the alloc will just make any
races much bigger)

But even when it doesn't do the alloc, it takes and drops the lock,
and it's unclear how much xas state it just randomly re-uses over the
lock drop.

(Maybe none of the other operations end up mattering, but it does look
very wrong).

So I think it might be better to do the xas_reset() when you do the
xas_lock_irq(), no? Isn't _that_ the a more logical point where "any
old state is unreliable, now we need to reset the walk"?

                   Linus

