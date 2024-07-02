Return-Path: <linux-kernel+bounces-238248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657A924768
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0585B214F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789A1CB314;
	Tue,  2 Jul 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O8uqzJqN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F31DFE3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945727; cv=none; b=MWyuonEW3TpeAmYkEoll5e2RdQMEsjAJpbPOANWaKIYp14lVOK6iM1r3AzO4iZln2R2T+LRJv/HRgnC7zR/rxU4eLMyabw6x2PHlhQVfgBLHd3chyZDVg/gWXNNNegRtVYXsZPvWXA5c1DHdnJZ/SpExahF2TsBacqCGIK2uMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945727; c=relaxed/simple;
	bh=9ivcoTOU/Pu3gOuzz1x/5q59HICfwlF3oMyQ4f7Nzvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUxCcI4YaOz61u8J7p6qZmz8EJPrZirstMkG7wAGrVet1+AGk/IE9wj64Iu6Gs9U6a40p4qU2ETiC+TTY1bJ6nw+mmr84vW0uqRp7/Fw8yc7+9ganYIvBb3hlfnEavLvkPnTIJCUYySh5DIu5b8do2jacx8mRYVc1e4XSEYtxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O8uqzJqN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cd80e55efso8032932e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719945723; x=1720550523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PGTXXsYfe5Sa08dwRDYVcy0L1nqIjL5SVkaBtsUXzro=;
        b=O8uqzJqN0O6PXkp+J7cCyTPq9dB0KJp2Q1X6kkyCfy1Z07dxQ0Fq8EJV+CrfVXO2ua
         4oe1C5SHdiD0y8PNxyRgA4jUou+JEhFIH1i9UP5Sl13LY5ol4G+ULvK2KuvWZAwozdGo
         EeF9lmQr2mGHJeLYNmoY/cpYubnXiFqr8jxnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945723; x=1720550523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGTXXsYfe5Sa08dwRDYVcy0L1nqIjL5SVkaBtsUXzro=;
        b=QrFQJSolTrJoXOpI1RId0JDzcxHUNbxMw9xDz0huAOrA/13YpBDWeo7zXBA6VXHYpK
         EAf3GDChoIq25m0lsh7ZW8/k+AG2pcKv4NRSLjmLSYNYNzEwlAadXIo/CsiFtRo3cgcJ
         J/tRwOefOQeGCZ782nSY2KKh3fAmH4uQbtcKY0Rv9ey+WZJ/lXMYSXdFkGeZithyrBKl
         N0kwnRZ45E8glcECLgi5RXPrIYnQ1KAXCA8qKBnGr3IprZCiK+upMcTQFO/6poZUnOO6
         LrX4EkR0SdF5IEjb1NLI5L9nJqBpyDf37OMS9XpKe5x6eyLaYKcGQlWjBrXfMtzR4Y6X
         iptg==
X-Forwarded-Encrypted: i=1; AJvYcCVJgpEWT6AEHGRpHxBgQHuOvKtHob3Mlka0EPJ8B5Bh+tQ+NCFqgqbPNma/SU0adGddtZd0yadrJk5HM8ZMJHd9qGOvBok7qD/E4+P6
X-Gm-Message-State: AOJu0YzCx2zOda9g7vOr2zY42IThcBhlHCox12tJ2YfPHutdPTyj6qhV
	+A2OlA75AAwUGHI7TANy83UDtSjOx/tTLVE8TuCi6JAbf9rCx7EGQDFkYUFXsnkVa4D9SSr4LBh
	wnoxIpg==
X-Google-Smtp-Source: AGHT+IFDbzVaf2X6L21lLXJiew/qfljRMgEqhj8gQLeDlg3fEhE7NASYeV8NGtMVtqlYIw5yaBZujQ==
X-Received: by 2002:a05:6512:104f:b0:52c:deea:57cb with SMTP id 2adb3069b0e04-52e8264acc1mr8201034e87.3.1719945723389;
        Tue, 02 Jul 2024 11:42:03 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b470sm1900251e87.293.2024.07.02.11.42.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:42:02 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so13735101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW55bzui388H9FsIWLi1WlXG/wsNdjZagYYBPktt05p6XCdP+aEN2Ns7xH+RgsdrkzJsGyuKB9ue49B1kZ9ZhmFwX0Z9ZluidDnkc81
X-Received: by 2002:a05:651c:b14:b0:2ec:5488:cc9e with SMTP id
 38308e7fff4ca-2ee5e3bbd14mr77301241fa.26.1719945721844; Tue, 02 Jul 2024
 11:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com> <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
In-Reply-To: <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jul 2024 11:41:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
Message-ID: <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 10:58, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Suppose the rcu fast path lookup reads the dentry seqc, then does all
> the legitimize_mnt and other work. Everything, except modifying the
> lockref. The caller is given a mnt to put (per-cpu scalable), dentry
> seqc read before any of the path validation and an indication this is
> rcu.

Yes.

> Then after whatever is done if the seqc still matches this is the same
> as if there was lockref get/put around it.

So this is partly why I was thinking of a callback. That "check
sequence number afterwards" is still important. And if it's a
callback, it can be done in the path walking code, and it can go on
and say "oh, I'll need to redo this without RCU".

If it's a "we returned a dentry under RCU", suddenly the caller has to
know this about the name lookup and do the repeating by hand.

And as long as we don't expose it to modules and only use it for
"stat()" and friends, I'm ok with it, but I'm just saying that it's
all a bit scary.

> The only worry is pointers suddenly going NULL or similar as
> dentry/inode is looked at. To be worked out on per-syscall basis.

We have subtle rules wrt dentry->d_inode. It can indeed become NULL at
any time during the RCU walk, since what protects it is the d_lock and
the dentry count.

The inode itself is then RCU-free'd, so it will *exist*, but you can't
just blindly use dentry->d_inode itself while under RCU.

Which is why it's cached in 'struct nameidata', and we validate it
with nd->seq when it's loaded. And why things like may_lookup() use
nd->inode, not the dentry.

And that's another rule that we probably should aim to not have escape
from the path walking as an interface.

Because it's much too easy to do

        struct inode *inode = d_backing_inode(path->dentry);

but that's just wrong during the RCU path walk.

Again, having this be a callback during the walk would avoid issues
like this. The callback can just pass in the separate inode pointer.

And then a sequence point failure will return -ECHILD and do the walk
again, while a callback success with all the sequence numbers matching
would return -ECALLBACK or whatever, so that the caller would know
"the stat information was already successfully completed by the
callback".

Anyway, that was my handwavy "this is why I was thinking of a
callback" thing. But it's also an example of just how nasty and subtle
this all is.

But I'm convinced this is all eminently *solvable*. There's nothing
fundamental here. Just a lot of small nasty details.

                    Linus

