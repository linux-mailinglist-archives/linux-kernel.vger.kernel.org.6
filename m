Return-Path: <linux-kernel+bounces-213681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F125F9078AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D501C2090A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719A1487D8;
	Thu, 13 Jun 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KOwz7Fox"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55863A5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297434; cv=none; b=lOfyZdirbK2dMw0usr20tgtGiWShLybofOsq2VBw+QjXcv9HoKLHTmZZpGPcpqsZ7IL+YFjoCbzyDGbptarEnv2auC6SKBhpXGX1r+IlmQL5b4bgJoWrVHG4Zlv7o9z49K4FiW0NCshigGfUTF9/wYQrSpamQ2XzLZcYJCad7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297434; c=relaxed/simple;
	bh=91rjHWfqxTOGztj0zBNywmYUrS6otdLE39NRyBM6T9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQH4qji32Y7cWrJ2qA7ytUVNTph+QHNGFyOKanR1F/jPw8jMthoOKwKf5cJIAHqt4zpbHgVot86Sh7aMZ2TgTucFcLlLxR0ZGiDIjYOJQNKenx9gl1MvAkV2Xx+UbUaCFyLMFQD+PJoC0Man+37+g516GJQug5BHYFliQAO9Jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KOwz7Fox; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso1180404a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718297430; x=1718902230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kGUfdjMjAIbrnKn5yz/1VobC5vlTgVC/FlKj6pp1/y8=;
        b=KOwz7FoxKkvS1PDjJVKvofQIZ1rdNmQPv7B+Mv67zyZ50PK5Ahr1Ybt7c74CQyHkaI
         wdiNpqsa9y49bLWYNJc2fji79RKLHQXa8jRrUaIIFGO5zueqVXea01O7Obp9uS1t2HfG
         /Y3hCbb1me4toEt6VCBMexz6c0JMJ7IM8QW/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297430; x=1718902230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGUfdjMjAIbrnKn5yz/1VobC5vlTgVC/FlKj6pp1/y8=;
        b=OzuJLO/eyHRpfVmP610BKEReuv9xZK2EuFNgqcezzttY8fZb25wTDYIvnipNqjGPqB
         GUfuWMNIDd+0VyiXuqwGSROI29UVaq36G2u5TdVI9RDW+bh0ZiHQcUxKEWLh6e+Cko/N
         y3GVf0K27ZmZJVPj8SLQT8rWp33Xrdu+vu02Cd25wBV4yluTCMqvulzIbsu6N4xqDtRa
         ZBK7hXZXHKpaH96WWVrLgolv74yqtOgjrjze85OvEpekfn8appw7QVDBfov1gq19Euiu
         4/hBjZBQdcaIDCMw0Kr5Z7mClD//l1eZwoU53tCykVFmzmfFg/H92WmArZ01dtbx4Kur
         +CVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTml+JYfbFULqYrjFbjmeXI0dQtQOWmfZj6NLfgeo9G6L5eQH5zimYFoth1O/3oRf27LGVBYP/ZrDSkiJTPcZ+tc2H6AY4J3VpGzVU
X-Gm-Message-State: AOJu0YzwahfpiM8y94igUEjSNf7c5u30VSOTF5sr2fq4NT7TV67N1+2Q
	nXku3gtlOFSI3QJ5YRv1wg+R9Sn1jWQcx4FeHPKeAKjarrU3nh3r9IFCZgDORtJFythTdPK7YU8
	M03JYwg==
X-Google-Smtp-Source: AGHT+IF1px1y8TExkbJzsmNSkInU0jT/ieNne64UB1QQDiDmx+hD7MejmCXm0jwuS8X/XpQ5mDinkg==
X-Received: by 2002:a50:d493:0:b0:57c:600d:5879 with SMTP id 4fb4d7f45d1cf-57cbd67ec1amr259726a12.20.1718297430058;
        Thu, 13 Jun 2024 09:50:30 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9921sm1113327a12.52.2024.06.13.09.50.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:50:29 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so146437566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:50:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGbaIsK+szFwurE1ieGSx0+oMDDAozwHG7EIHr+li1ooFo9UDd7mbHCZgBIYYJOs/8joM9mtccxDvixgtmBSnoLIG5Bz7tnDUucl2w
X-Received: by 2002:a17:906:37cf:b0:a6f:1979:7b6d with SMTP id
 a640c23a62f3a-a6f60dc571cmr22187866b.55.1718297429016; Thu, 13 Jun 2024
 09:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com> <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
In-Reply-To: <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 09:50:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijfQyv1BMHj5CFqj6C4LKaEzq4b==+Y-V3HPgDO7HR3A@mail.gmail.com>
Message-ID: <CAHk-=wijfQyv1BMHj5CFqj6C4LKaEzq4b==+Y-V3HPgDO7HR3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 23:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> On Wed, Jun 12, 2024 at 06:23:18PM -0700, Linus Torvalds wrote:
> > So I have no problem with your patch 2/2 - moving the lockref data
> > structure away from everything else that can be shared read-only makes
> > a ton of sense independently of anything else.
> >
> > Except you also randomly increased a retry count in there, which makes no sense.
>
> Cmon man, that's a change which unintentionally crept into the patch and
> I failed to notice.

Heh. It wasn't entirely obvious that it was unintentional, since the
series very much was about that whole rety thing.

But good.

> I was playing with a bpftrace probe reporting how many spins were
> performed waiting for the lock. For my intentional usage with ls it was
> always < 30 or so. The random-ass intruder which messes with my bench on
> occasion needed over 100.

Ok. So keeping it at 100 is likely fine.

Of course, one option is to simply get rid of the retry count
entirely, and just make it all be entirely unconditional.

The fallback to locking is not technically required at all for the
USE_CMPXCHG_LOCKREF case.

That has some unfairness issues, though. But my point is mostly that
the count is probably not hugely important or meaningful.

> I tested your code and confirm it fixes the problem, nothing blows up
> either and I fwiw I don't see any bugs in it.

I was more worried about some fat-fingering than any huge conceptual
bugs, and any minor testing with performance checks would find that.

Just as an example: my first attempt switched the while(likely(..)) to
the if (unlikely(..)) in the loop, but didn't add the "!" to negate
the test.

I caught it immediately and obviously never sent that broken thing out
(and it was one reason why I decided I needed to make the code more
readable with that lockref_locked() helper macro). But that's mainly
the kind of thing I was worried about.

> When writing the commit message feel free to use mine in whatever capacity
> (including none) you want.

Ack.
> I think lockref claiming to be a general locking facility means it
> should not be suffering the degradation problem to begin with, so that
> would be the real problem as far as lockref goes.

Well, it was certainly originally meant to be generic, but after more
than a decade, the number of users is three. And the two non-dcache
users are pretty darn random.

So it's effectively really just a dcache special case with two
filesystems that started using it just because the authors had clearly
seen the vfs use of it...

> All that aside, you did not indicate how do you want to move forward
> regarding patch submission.

lockref is fairly unusual, and is pretty much mine. The initial
concept was from Waiman Long:

   https://lore.kernel.org/all/1372268603-46748-1-git-send-email-Waiman.Long@hp.com/

but I ended up redoing it pretty much from scratch, and credited him
as author for the initial commit.

It's _technically_ a locking thing, but realistically it has never
been locking tree and it's effectively a dcache thing.

           Linus

