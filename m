Return-Path: <linux-kernel+bounces-344650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8298AC58
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1126281DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5A199248;
	Mon, 30 Sep 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JX2IytFj"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE535466B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722014; cv=none; b=hrLu3ybTacAq9w3mkIBZd26v4g+Tnb4pl/yPPh0n8J+uHMnfTcQG7jkF7wHgYKAznFkslKZD+I9RO65Rj84gOXQV+kvv0+aIApGPgdgcxx+oAV+ezBB6OexTf8EvieTdUmtHC9UJ/DoLBaSPPtarNi7scsMTJFPw9l95t5QY2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722014; c=relaxed/simple;
	bh=LJBd2XzWsHz164n1fTuK+B4D3XarcsLPTUGiEDLMWG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm7cdO63aIyganrsV12nlEJoznBhl/U7AIUfL52XVucn+vgG/sUtQ++qh/edOMPM/Bj9vUNMrCsobk76dLLu5WLSJYuZQarI/Oxue7CktQrQxiiKctVsbCdRwyP4mZdPeWm0u+pRTdWY+RA+HDYJtNq7avQE9/2yYMzcB6nPDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JX2IytFj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5399675e14cso1500129e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727722010; x=1728326810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZxtY/yExLakikPIWimGxq8rXeYi1ZRab5obj2wCNkU=;
        b=JX2IytFjK6uDYofVY6bhRn9dqxxuRzcYIY6Olru8nFDstHQtjmlQuol+wRluNQXrbH
         9+ItpMDby8QJ0U+8mGPljuKdS0NgptVs2zo07K8heAJTlCO2wOqufdcAhSga95t9w5hH
         QVG5GExg+ptMhgoPdGXhbkWg2VKVcxnQ/FdhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722010; x=1728326810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZxtY/yExLakikPIWimGxq8rXeYi1ZRab5obj2wCNkU=;
        b=wr8WTMPwmzevhxXmctL13MtzHfdhKs/LEYwMWtb4Yfo0znwupGMQ6RLdaMqNO0dbyX
         Hm32OZdLYmXv3sGnv6P22r24MdCGnjlpDsNN6DpDoY1t80Z7CJc37Eyu2mdnhMTSxD0U
         A+5n7+iFHkxpCkDSPAOZNtnH+f8sFPQEoZjfnIIW8/4S8UtsE1sRf4Q1AF6yR0tA5MLe
         wm+D8HDU+JzBiUE9MVL+EGTCD+pR5n5G/4MPbmjdLodSXEX7kKmlF1tbpB7ncUKHA2Z6
         g5yeWsOYmqh1c6KgLKVhUmXQHDSqzJ3KDckJRGJ53gKYJ0OKR6kAct6b8vzXYRH21Iwj
         rpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWqrp4RXL5qeq9EARfWiRC9WBYebhbbHivZ24BzrHEr/H0gjK1Ax72CqElwJyRfodkRyeKlpOd853BuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaRuvlOkXXAVOU3txfWih40o6pm6VLEvaypv6FdZ7BY6tFpNa
	Nkv3/Go+9Jt1NaJWPm5vUnt48ql19T8s7Y23AzLt8VrvUYNPOqzec7ATAZwbFTMzWK/zBUgixZj
	F0LU=
X-Google-Smtp-Source: AGHT+IGTa0sYeIccKy75tbCUIt8RQ4qbS4KRQAHtigVYY33aVUAQjgcTA0jX0rpuWRGsg2JL8W4EIQ==
X-Received: by 2002:a05:6512:33d2:b0:539:964c:16d9 with SMTP id 2adb3069b0e04-539964c18eemr2420035e87.57.1727722010054;
        Mon, 30 Sep 2024 11:46:50 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0439b07sm1310225e87.215.2024.09.30.11.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 11:46:48 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso17646511fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:46:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUffCnbg/cjFcGdrva2MtcEvx6TnpvFVG/1t7ViAKEOUVYF6jGQX9WOXE0ubrHg+th6d3OAz5vqqSkovKk=@vger.kernel.org
X-Received: by 2002:a05:6512:ad2:b0:537:a824:7e5 with SMTP id
 2adb3069b0e04-5389fc361dfmr6504852e87.18.1727722007490; Mon, 30 Sep 2024
 11:46:47 -0700 (PDT)
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
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io> <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io> <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
In-Reply-To: <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Sep 2024 11:46:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
Message-ID: <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Christian Theune <ct@flyingcircus.io>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 10:35, Christian Theune <ct@flyingcircus.io> wrote:
>
> Sep 27 00:51:20 <redactedhostname>13 kernel:  folio_wait_bit_common+0x13f/0x340
> Sep 27 00:51:20 <redactedhostname>13 kernel:  folio_wait_writeback+0x2b/0x80

Gaah. Every single case you point to is that folio_wait_writeback() case.

And this might be an old old annoyance.

folio_wait_writeback() is insane. It does

        while (folio_test_writeback(folio)) {
                trace_folio_wait_writeback(folio, folio_mapping(folio));
                folio_wait_bit(folio, PG_writeback);
        }

and the reason that is insane is that PG_writeback isn't some kind of
exclusive state. So folio_wait_bit() will return once somebody has
ended writeback, but *new* writeback can easily have been started
afterwards. So then we go back to wait...

And even after it eventually returns (possibly after having waited for
hundreds of other processes writing back that folio - imagine lots of
other threads doing writes to it and 'fdatasync()' or whatever) the
caller *still* can't actually assume that the writeback bit is clear,
because somebody else might have started writeback again.

Anyway, it's insane, but it's insane for a *reason*. We've tried to
fix this before, long before it was a folio op. See commit
c2407cf7d22d ("mm: make wait_on_page_writeback() wait for multiple
pending writebacks").

IOW, this code is known-broken and might have extreme unfairness
issues (although I had blissfully forgotten about it), because while
the actual writeback *bit* itself is set and cleared atomically, the
wakeup for the bit is asynchronous and can be delayed almost
arbitrarily, so you can get basically spurious wakeups that were from
a previous bit clear.

So the "wait many times" is crazy, but it's sadly a necessary crazy as
things are right now.

Now, many callers hold the page lock while doing this, and in that
case new writeback cases shouldn't happen, and so repeating the loop
should be extremely limited.

But "many" is not "all". For example, __filemap_fdatawait_range() very
much doesn't hold the lock on the pages it waits for, so afaik this
can cause that unfairness and starvation issue.

That said, while every one of your traces are for that
folio_wait_writeback(), the last one is for the truncate case, and
that one *does* hold the page lock and so shouldn't see this potential
unfairness issue.

So the code here is questionable, and might cause some issues, but the
starvation of folio_wait_writeback() can't explain _all_ the cases you
see.

                  Linus

