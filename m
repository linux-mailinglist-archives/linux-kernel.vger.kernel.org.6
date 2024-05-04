Return-Path: <linux-kernel+bounces-168737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474728BBCEC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F183E28275A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6565821A;
	Sat,  4 May 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pk5o2wu6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B214594C
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714838048; cv=none; b=eVEC4pkxrD0AMCTpi8aOKTV6BU0yxGQAl2a0RQNai2ieItbjy34bEtGWYJ7pobdIWIbhLa0FyF3OeqyuzCY7eUV4ihgOxhxHQyTbM7qLBVpuQ4DRHUCdN0E2F/L0Izv6VhtzM7JxCN9SUPj/JTwY7Jm1zmlaMR0LnkWo4sUrRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714838048; c=relaxed/simple;
	bh=/aq2jAO4DmSNrNoBrUEE3/qpOKGIfIhWERou7A/I/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zba09Yfk7aIv86kot/eHguyiJzBbBW8zpe48XfLC636jXkwsgSoM/GdZA1hbBKc+2d48dmc07GbnYRpqR7pUkqUeVU/oi+BEebryIrN6qK6pZlSH2Qfu5YDW+dhy+JV8PQicWAmQ50aOmurLwTKiYTFGZsKE+olLRm4Kdhy3Xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pk5o2wu6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e271acb015so8147621fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714838045; x=1715442845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZo6ArVOf5NVi3NAdVYQGqHRs84wzKq7YB5CfjfJdNw=;
        b=Pk5o2wu6ylkaml0n6irgR+hnwmSMMhEvT/ppILJjg+eTVkaTgWi4GbkvBuCyg5FnvQ
         O8VWJuo+jANYfUPXScgrqxsikan+o1pfz9aD8O4Or+rujOgbZBqcd8riHSsK/V7y/Iop
         K0TzPRQzUEP8vLcZr7iiSwo8fZ/sIFKPykW1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714838045; x=1715442845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZo6ArVOf5NVi3NAdVYQGqHRs84wzKq7YB5CfjfJdNw=;
        b=XMhQeWvXkOaXd1fBH0U/YoBRykQCB56v1xXpDq+1MLTjk0A0n1nd7CyQkN7Z9LjK2k
         WrpL+EqK/qzuJ2Mmp2Aqcie6+crx7LT6L3AsLE178El7dX2UpxVEq7lxa9yBpLZhLhq8
         L2qaQDdj2BJ4ClfuyJERUP0WsXh2R70NFFAetZBcy+fE+pLU42C4ak4/91xqYnQg2pnq
         ASpja2nXcSLT3Vly8z9VSU7fWlL3arGaq5bOU5WtALWGWHBR0CerpEdgKUfUJnLDlaKw
         Sq6Yvl9lQkKttq8PGKxFUCuBHUT3u664DjBz6NTTR9BynkkayRg5oCqOSucBzoSS7ThH
         N+BA==
X-Forwarded-Encrypted: i=1; AJvYcCU03LPCTYVGz0Fu/y5zkTstsrpuYuG4+2NudyoKcp4w+6g4Tjnk/eFVCi4v8F4R/87oTvUU/Rn9iUjE77qvJ5/8/v3+mU7QY4nlSWco
X-Gm-Message-State: AOJu0YwJE0iyXm+hzRaMo2oCsbRqRIvFNVYg5LWYV3tJ77jndRewbWYF
	gfAJBQuParBrTbC3W1Sl6Oz3aqw4WnSnCEtdvcxh8HTrE8FXikmxZORhpic9Ng2Hq741c2OuRt+
	CtxBdrQ==
X-Google-Smtp-Source: AGHT+IFT0uqJGEIKNEsqPl1Dt4oKZf6gXrcC7tvGl1/T9PWusn8Nz0Hab+HY7IR8KixDn8Xpi9/4vQ==
X-Received: by 2002:a19:8c16:0:b0:51e:150e:2c45 with SMTP id o22-20020a198c16000000b0051e150e2c45mr4076582lfd.63.1714838044920;
        Sat, 04 May 2024 08:54:04 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ko19-20020a170907987300b00a599dbd2a6esm1500983ejc.189.2024.05.04.08.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:54:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a598c8661f0so134237566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 08:54:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwE8Ztvj0hoEZkJ6pIf9+U+f4CgC25s14ggyRA/iugp1EuolWm8jC0R0uKzsJesjw6oJ0v5UfCzUtMf6DAeCL/cOa6Kip+eTTYsOzI
X-Received: by 2002:a17:906:a842:b0:a58:5ee1:db43 with SMTP id
 dx2-20020a170906a84200b00a585ee1db43mr3389515ejb.23.1714838043724; Sat, 04
 May 2024 08:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
In-Reply-To: <CAHk-=wirxPSQgRV1u7t4qS1t4ED7w7OeehdUSC-LYZXspqa49w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 08:53:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com>
Message-ID: <CAHk-=whrSSNYVzTHNFDNGag_xcKuv=RaQUX8+n29kkic39DRuQ@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 08:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And maybe it's even *only* dma-buf that does that fget() in its
> ->poll() function. Even *then* it's not a dma-buf.c bug.

They all do in the sense that they do

  poll_wait
    -> __pollwait
     -> get_file (*boom*)

but the boom is very small because the poll_wait() will be undone by
poll_freewait(), and normally poll/select has held the file count
elevated.

Except for epoll. Which leaves those pollwait entries around until
it's done - but again will be held up on the ep->mtx before it does
so.

So everybody does some f_count games, but possibly dma-buf is the only
one that ends up expecting to hold on to the f_count for longer
periods.

             Linus

