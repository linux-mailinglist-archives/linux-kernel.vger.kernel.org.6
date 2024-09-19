Return-Path: <linux-kernel+bounces-333089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72E97C354
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8C11F2261A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED51B7FD;
	Thu, 19 Sep 2024 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gieE/7yW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56E1804F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726720363; cv=none; b=XBvyPwTffRl5eVkwkCifSSfkCjQ1HxDQZDu8TDqTP3mYreaOa3tP+HXrt6ntdDGr9YWNaJQDGkfzX8qmfScKGzTrSUwLwXNhcM1xI54YI55JXLE3hf0kLg7VLO8gs9sW0yFi8qfMwGa3AyHmR3TudjrRHtJ8QodFu+1Mc769RtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726720363; c=relaxed/simple;
	bh=fzixIv7mDCApwoPr19Yl5C0aFP9P4Wj7HGNtS5Rhh7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpUyeD/4WbWmh+qvxGx4OBECceLqyj3YeB9uUSvdrQqMrOiYFQmIShJU63NlPtk1xvaVYwUTHfMUOOrbZeQu3xLUpbW0993hLTlAQkZY0MlIlh3bO5BSg18biY4oBiG5acnyh4kpHtE2ksRz1ETdYTq0i55Fxzevs9THsoNJq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gieE/7yW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so371123e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726720360; x=1727325160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9yFEfRvpp3RBfmF+3PJrVEwQqIIGgrTWijYjV6RGF0=;
        b=gieE/7yWndLUNQNHFyjg62RsFEFjLi2iWM3Nzf41KG6Xz8MYeYFmjPuxjaDslLW2h3
         EuMhLTxVU8hxUB6U8zVhQgaGKQ8IAEsMYyXST4hxI6uvQtUtjLIDGFoc1JVAbL2CqZse
         f2S0I01Ka/xwo6TuM82t56xJuKDxZ54AueH7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720360; x=1727325160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9yFEfRvpp3RBfmF+3PJrVEwQqIIGgrTWijYjV6RGF0=;
        b=dHDiN7V96pYPLBvaadqLMLQU2bi9UoIOdDCmBE2K2pen3v8sz4TrUb9rPXF8YW9Gfi
         sqlFylBYSx6TXkcfVLKtXWL+uXJIZlMn1NbohnuPv1KXhM9byjc4QD3B33EiMJTx/y6e
         fQpYv171x9xoKFWTiRvDJBYL91lyL50gt/0tidMlLlqrfcN7Dhl6SRwNDe8VNjNV7Wih
         4cBlHzBI00MYHWqhwV6qWsJMx/hoO8E59Am3G/EtpmQVuY1Kddp5BxrHfSNnZODlnc0D
         dZr3jRB3a/EaMPyUppQfKxLBKe05C+F0ppMUonARfWde4zjBilTwYcpvQoUfl/NNq46K
         jVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+w1zWKfB1c93KRN8bpxJ9sBDeC4DUP80RlfnLba0aGpMCUjkhOotVNEIUaBx7v5C3EagxRST+NOFcKGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzgzfMzxd870RnTemWZ+Tj9ezpdDxc78dY0waUVy27fG1NLCD
	kSwtzL4PvooNoyRuT8Yib32WpQzmpE9+25mt4W4FUt2uhMhfllszwNfVt0pMJFe/94+eksHbSPf
	j9lfUeQ==
X-Google-Smtp-Source: AGHT+IHz2/AvOVa35wsoC+RCFmUr3RhGTF+ciV7J1IMKeSEAKqqwC1SbsO+yolAs8CLCfh8QaSS5Cg==
X-Received: by 2002:a05:6512:1106:b0:52e:9619:e26a with SMTP id 2adb3069b0e04-53678fcd182mr14296530e87.26.1726720359518;
        Wed, 18 Sep 2024 21:32:39 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89d5bsm5587838a12.74.2024.09.18.21.32.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 21:32:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c4226a5af8so576590a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:32:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYm5do3ClykzUkAInkG+MdcYw98kQpNtfLVRIaGpvI9RCuSkWjWZrBi9oKtSWDnt05IaMeKrLk2g/LJ+A=@vger.kernel.org
X-Received: by 2002:a17:907:f766:b0:a8a:8d81:97b1 with SMTP id
 a640c23a62f3a-a90295a2171mr2279810366b.27.1726720356520; Wed, 18 Sep 2024
 21:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com> <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
In-Reply-To: <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 06:32:19 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjsf9eAsKf-s6Vcif8wHPFj3iycaJ89ei=K1hQPPAojEg@mail.gmail.com>
Message-ID: <CAHk-=wjsf9eAsKf-s6Vcif8wHPFj3iycaJ89ei=K1hQPPAojEg@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 05:38, Jens Axboe <axboe@kernel.dk> wrote:
>
> I kicked off a quick run with this on 6.9 with my debug patch as well,
> and it still fails for me... I'll double check everything is sane. For
> reference, below is the 6.9 filemap patch.

Ok, that's interesting. So it's *not* just about "that code didn't do
xas_reset() after xas_split_alloc()".

Now, another thing that commit 6758c1128ceb ("mm/filemap: optimize
filemap folio adding") does is that it now *only* calls xa_get_order()
under the xa lock, and then it verifies it against the
xas_split_alloc() that it did earlier.

The old code did "xas_split_alloc()" with one order (all outside the
lock), and then re-did the xas_get_order() lookup inside the lock. But
if it changed in between, it ended up doing the "xas_split()" with the
new order, even though "xas_split_alloc()" was done with the *old*
order.

That seems dangerous, and maybe the lack of xas_reset() was never the
*major* issue?

Willy? You know this code much better than I do. Maybe we should just
back-port 6758c1128ceb in its entirety.

Regardless, I'd want to make sure that we really understand the root
cause. Because it certainly looks like *just* the lack of xas_reset()
wasn't it.

                Linus

