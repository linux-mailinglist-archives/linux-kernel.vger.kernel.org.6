Return-Path: <linux-kernel+bounces-547288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA6A50571
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21492188B08C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E1198857;
	Wed,  5 Mar 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LL8O6rfE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8119884C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192862; cv=none; b=WUjoTjgUdAZ4+sZv/hajZ8CBy+XJ048gQvbRlsPEf3qTV0Bv4epY4+iBFDXe/aslWuxOObCv4uThz5WC+p8mufxA9uT5+++r3taJiD1RrJYkz38LBU9rfCwzYaVlfNDwsKSK6URos34wIavdQlKxikwTA3ZBdfwyT3MkSoS62Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192862; c=relaxed/simple;
	bh=GIZj5nXeV43qZLaLKVSZeSCAfiZ1aV247XMQYfCpLOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcQBHGsZeQUhaFOpregvnaC0nsNhU770gXjNjjjV51a/O3UlS4P2mB13D8/RSvFF6WlwuhK8Pw9DhMBCHVbl7wQAUuSiuegrk3Gc1TEis8TokK+kVTwsRegSMwQi47tm+GBNL1c3zB/+czqqw2mVsWDEShj32L1qyC2uzxllVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LL8O6rfE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so815250a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741192858; x=1741797658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcj+FL6rUqtMKI8ucbJjAqXrCeckB3SlFcAWKVcfex4=;
        b=LL8O6rfEcEjX6ljXVha1OzPX06D6aMqGyFtSrUZrduv97mfafIUPu04Q5UnjU/D3lC
         H477pbltdUtZy7ktlrIQBvURdyBhD5u9jDl0D2O0nCnMvlZ3u82Kx03qXQiMBSCA9387
         uwjt41CZ5AWmcTlzoURb7J7cxNgEsdz4jIuho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192858; x=1741797658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcj+FL6rUqtMKI8ucbJjAqXrCeckB3SlFcAWKVcfex4=;
        b=FebmHdW9VjeaUEvxyvEyiVpMeIf5CAKyU8e5vr8p1Fy7DoatRr+LSyH0NDqkOj49CG
         73YmfmQCvWuHXm/D7l0iiqBPbrY6HDkXpYo+qAqVW02gW7lJnDTG2dxPBbxBy022hjsa
         UhvADuebj8qgVn9BYXSXjeebX80qWE9lX7Fd5j9qOIkPi1LqoJk7WmZTlmthkjh2Fw4s
         r4IU5sjZOOsg9kQkkP54dJzEEpM7jZ+oZNP37Ij0D6bGf5vElXK5rAr4Z/4M4wCz/cbj
         qatF1aJ+RdSewf1JS+tVIwI11H/8shArF2fuUabRjTgzyJslIL4N/iEs0GffcvGY3bOU
         GCiA==
X-Forwarded-Encrypted: i=1; AJvYcCWkMGvtMBWRoqN4Tz9sKjYhzWMyW79S9fzFdOW2MhWWwpPNYn1Tx8ZHIIPslkyjI6gRO++MMQ5E5us2ayI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+W/KdU23vcyHrBBj1Y+N5Q3HtY8GuFDUarD9cllYmA7hZVKe
	cpNM02KHM+MwlscXP6Q8Hh+hbBFRcOR/eK5uTGGDAUH0ZtGYvdwu3+1+ZdGMbYZhJ2SteKOWqPw
	OinLnvQ==
X-Gm-Gg: ASbGncsRlWyQ2RmL2dFDl0LZg5GIRmhN9Ih46y9tL1qjzeLOmCTQSYO3sjlENpTv8xk
	4NqOJOFcNqO5t3wFLtNUwJT1KTfERiGjhwpR1SvizEN8oIB3ua4pLvwI5/DLX52WeMrQ/Q52+r1
	CdlX+FMOCJ/2c5gAfJMPuyGbKXxvoHuAM/6W/EFw0Q56dfziFoo2sIf6yhzRenwxV8VtPEdU9En
	FUUzy4CqItXzG3QkWIpQznFHxcB6rCHtehBJ1w/4YPWnQZD4fxiL5hpcoTCN1Atx9YNwM9xeZFA
	XA7UhvKa9bKPEbcd4X1rCQuGZuc8eHwtwlvBzXQzBLos2+TMtYiIGuLk0TJdwWDj1bdOVehcQvr
	O2LaK0nVWjppuFpKMcXY=
X-Google-Smtp-Source: AGHT+IHvJAVVwBDJaW0CZjWFJ5geMTQODPradPhOlZWlSIEP56IEzN7SzOTtlcVqc3q/TgmzKBqNnQ==
X-Received: by 2002:a05:6402:3819:b0:5e5:9a2b:167a with SMTP id 4fb4d7f45d1cf-5e59f3e9216mr3696718a12.17.1741192858045;
        Wed, 05 Mar 2025 08:40:58 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm9739211a12.53.2025.03.05.08.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:40:56 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1294171366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKdg0Tgx/Q7WfboIXeAs/7r8EDd73oWAvpSxb+TF7ShZeSaDyEGF/e4ARJJ4NWxK/iintrSOHtOJpNMLg=@vger.kernel.org
X-Received: by 2002:a17:907:7290:b0:abf:615d:58c2 with SMTP id
 a640c23a62f3a-ac20d92d6c5mr406399766b.34.1741192855487; Wed, 05 Mar 2025
 08:40:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
In-Reply-To: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Mar 2025 06:40:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jp0qXBcEd52erShw3zCywhVPd7l8QG-JqnvkqqMzAhLfYEXemeEXbrVY6s
Message-ID: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ENTIRELY UNTESTED, but it seems to generate ok code. It might even
> generate better code than what we have now.

Bah. This patch - which is now committed - was actually completely broken.

And the reason that complete breakage didn't show up in testing is
that I suspect nobody really tested or thought about the 32-bit case.

That whole "use 16-bit indexes on 32-bit" is all fine and well, but I
woke up in the middle of the night and realized that it doesn't
actually work.

Because now "pipe_occupancy()" is getting *entirely* the wrong
answers. It just does

        return head - tail;

but that only worked when the arithmetic was done modulo the size of
the indexes. And now it isn't.

So I still haven't *tested* this, but at an absolute minimum, we need
something like this:

  --- a/include/linux/pipe_fs_i.h
  +++ b/include/linux/pipe_fs_i.h
  @@ -192,7 +192,7 @@
    */
   static inline unsigned int pipe_occupancy(unsigned int head,
unsigned int tail)
   {
  -       return head - tail;
  +       return (pipe_index_t)(head - tail);
   }

   /**

and there might be other cases where the pipe_index_t size might matter.

For example, we should add a check to pipe_resize_ring() that the new
size is smaller than the index size. Yes, in practice 'pipe_max_size'
already ends up being that limit (the value is 256 pages), even for
16-bit indices, but we should do this properly.

And then, *while* looking at this, I also noticed that we had a very
much related bug in this area that was pre-existing and not related to
the 16-bit change: pipe_discard_from() is doing the wrong thing for
overflows even in the old 'unsigned int' type, and the whole

        while (pipe->head > old_head)

is bogus, because 'pipe->head' may have wrapped around, so the whole
"is it bigger" test doesn't work like that at all.

Of course, in practice it never hits (and would only hit more easily
with the new 16-bit thing), but it's very very wrong and can result in
a memory leak.

Are there other cases like this? I don't know. I've been looking
around a bit, but those were the only ones I found immediately when I
started thinking about the whole wrap-around issue.

I'd love it if other people tried to think about this too (and maybe
even test the 32-bit case - gasp!)

                         Linus

