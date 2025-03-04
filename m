Return-Path: <linux-kernel+bounces-545357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B6A4EC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514FC881A39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115E27816F;
	Tue,  4 Mar 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AStJNVhm"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA427700D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112939; cv=none; b=m31ni3lb6cCb4rpIIPqmLXkRMFACJGbzeIRrDJx4zfJeTetk0UKEmFHMRL5axmVIPycWTXAZ0eYnT9f4iZ2FptNF0O7ZV1uw9SeKlJEKQIUFMw04BF+JrQ1OkK3o3/Qn2rRdBUvRvt203FC+Namoh1+olqs5IoVDsvf+0edKdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112939; c=relaxed/simple;
	bh=dsFhdaUzdEqC2qasKpn7vKxpyhWg4Pb3DHkJzlpkFgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYD/5tKL/79ETqHdNtYORet/RtU6FamcxEm84xI1nDokMpVkEk2BBht5POopySt1SAR2fkNcwCrGvL+VIdypdaErBci6FuZvkhU7Oc1y21EsssMHZ7f/7pkVMOyL4/WTNFiCE42lamqRk6e4RhJnPWLwLCja8KIf9tQuM4a8TZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AStJNVhm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbd96bef64so934770866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741112935; x=1741717735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tpV8lKFkk0m0qBuXaVnL7ZIVzaNVj3zbGGJTa8/gDWI=;
        b=AStJNVhmOavzMC6lUaa++YFcWEP4afxr4X5TIn9RexsDAvay5IDFwOyY4zRyFS2AWZ
         F7pKNLTHqL1MtwaWuTwxGHn6PcVHjepbic16CHZMjKE8p1jbVXRqfU3ur+3I1gn3wmRA
         hQVgJpae/RcMT6G8mH2mbR94uFM0aiL4rltgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112935; x=1741717735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpV8lKFkk0m0qBuXaVnL7ZIVzaNVj3zbGGJTa8/gDWI=;
        b=e6oal99s78aJJuNDTRTI/X+wBBKTThy0hEfZX+kpiepxZ4XkV21lNiwM8mSvdlYl6A
         HHHNwD9UL5FZ1F5A9t5/uPfBcz1A+PFe0HFcTRhezX8yd6uIzbGuBARh70yrOxhwvGi1
         n7TncwoKYVLBjCqk7XauUzYQpaW+RJPoQV4OKY9lMXrTjTmSbuiK9RJDOg+ECqZ61EsO
         bNr9zXF+JSVgZXnjcsSWTumnCtRT+R62xQ0jEehbUN+9ZGqFNAInveZdmODr5ZRVVefV
         odlvZssD3hcDD03t1q9HW4eO8m89ZPlUts+gTRZen2Cq7X+PWsNeI4/lLplv+RLcC577
         xDmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEFcOVl6fOCwzS3gKW5lCUGGPGbKbh2GeDL8SYGIZSjOrwCyMsc3Um3eIB4Ry/g33QCsbYtoJUYC7LLco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5q8tspxgIlG8wJBU/4ejx5iVFwcX/w8P034RS/BF1/x+EGhJ
	RnfVXO+U+bCDYTEZK7uut1CsBtg9+SuZBwmPqBjisaABPbtV/Pr3S2c5snE4uX6HJeiXNHzu1dE
	578lspA==
X-Gm-Gg: ASbGncumUUMgCxvJ6RZVff650B92Gqo7//F3IrtGl8lRLAvdGKWdvW4GY3ZcYd8Bt78
	PUe834uarLhNqFvr5cYcHX/OviikgIVFGlLz8e+iy2EvKXjp7/XfJvNjM4uudDZ+9yOD11TUZ40
	02FpUjTnLNV6WFblVjJQ4NyU1AXb1uqBE6X9HPebmkYeFCmQNAe7LEL6AigDINKMnyAfFSzLTc3
	Zih60W/kq8pOKuYwvkOk2LDWK05/UlPmGD+BjlfPi9udm93O5Tnqifx5En0gCwMYqwJnbmnONIh
	PuoVBxyQz8rhXUMX1VFKDDFf1YGfMnfSbyZGGKg+6UbNASui/NEP960Ph4rUbZCDJje3SLAYzhJ
	wjZ5OIMF0AGtfOc8kDMg=
X-Google-Smtp-Source: AGHT+IEd6KxEVtX0O3pUkEkzjJPYuCxoxFd88mT4rLxVdLSJyUu70FJAV2SDAM4j9g70TAK13Sh72g==
X-Received: by 2002:a17:907:9406:b0:ac1:e3f2:483f with SMTP id a640c23a62f3a-ac20dae038dmr35590966b.35.1741112934652;
        Tue, 04 Mar 2025 10:28:54 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac20381299asm64844066b.46.2025.03.04.10.28.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:28:53 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf628d653eso479872466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:28:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEnvm9JniJ2ckzJhxp2gc+vuRS2B0AQTzdjhl2mFFHLgTLiBukXcf2xnGBtO0r5YsWSEx8ft69UPWwbfc=@vger.kernel.org
X-Received: by 2002:a17:907:6d19:b0:ac1:e1a7:9445 with SMTP id
 a640c23a62f3a-ac20d849e4amr25960866b.12.1741112933068; Tue, 04 Mar 2025
 10:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304125416.GA26141@redhat.com>
In-Reply-To: <20250304125416.GA26141@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:28:35 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
X-Gm-Features: AQ5f1JoQpUveK-5XVbjjjnj7fnXJcnsNWYU213h7waPs2Np3fpI_1P-OUj8BWmA
Message-ID: <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 02:55, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I thought this is wrong, but then I noticed that in your version
> ->head_tail is the 1st member in this union.

Yes. That was intentional, to make the code have much less extraneous noise.

The only reason to ever use that "union pipe_index" is for this whole
"one word for everything", so I feel that making it compact is
actually more legible than adding extra markers.

> > + * Really only alpha needs 32-bit fields, but
> > + * might as well do it for 64-bit architectures
> > + * since that's what we've historically done,
> > + * and it makes 'head_tail' always be a simple
> > + * 'unsigned long'.
> > + */
> > +#ifdef CONFIG_64BIT
> > +  typedef unsigned int pipe_index_t;
> > +#else
> > +  typedef unsigned short pipe_index_t;
> > +#endif
>
> I am just curious, why we can't use "unsigned short" unconditionally
> and avoid #ifdef ?
>
> Is "unsigned int" more efficient on 64-bit?

The main reason is that a "unsigned short" write on alpha isn't atomic
- it's a read-modify-write operation, and so it isn't safe to mix

        spin_lock_irq(&pipe->rd_wait.lock);
         ...
        pipe->tail = ++tail;
        ...
        spin_unlock_irq(&pipe->rd_wait.lock);

with

         mutex_lock(&pipe->mutex);
         ...
         pipe->head = head + 1;
         ...
         mutex_unlock(&pipe->mutex);

 because while they are two different fields using two different
locks, on alpha the above only works if they are in separate words
(because updating one will do a read-and-write-back of the other).

This is a fundamental alpha architecture bug. I was actually quite
ready to just kill off alpha support entirely, because it's a dead
architecture that is unfixably broken. But there's some crazy patches
to make gcc generate horrific atomic code to make this all work on
alpha by Maciej Rozycki, so one day we'll be in the situation that
alpha can be considered "fixed", but we're not there yet.

Do we really care? Maybe not. The race is probably very hard to hit,
so with the two remaining alpha users, we could just say "let's just
make it use 16-bit ops".

But even on x86, 32-bit ops potentially generate just slightly better
code due to lack of some prefix bytes.

And those fields *used* to be 32-bit, so my patch basically kept the
status quo on 64-bit machines (and just turned it into 16-bit fields
on 32-bit architectures).

Anyway, I wouldn't object to just unconditionally making it "two
16-bit indexes make a 32-bit head_tail" if it actually makes the
structure smaller. It might not even matter on 64-bit because of
alignment of fields around it - I didn't check. As mentioned, it was
more of a combination of "alpha" plus "no change to relevant other
architectures".

                Linus

