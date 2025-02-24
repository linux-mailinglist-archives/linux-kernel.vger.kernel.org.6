Return-Path: <linux-kernel+bounces-529838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59130A42B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AC9177EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F35266194;
	Mon, 24 Feb 2025 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WissJBHu"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153926618D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422196; cv=none; b=ks9ouRB7VodoVuNQSb29DxhJfBQKjzdrA88RhL6aI6dc9MsxcDQh+Ag+jwP9QowgV/gQjpHj4QqOsb/og55dsdC28kjQEVI3JVrcx1I8x2Kele9ywJK7XxJPkd9flhDm06QsxLiUgXkfu9hOtveVPu4CJdbgJvWMjkWabQUUc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422196; c=relaxed/simple;
	bh=ZYpSCXidyUjMJOFUCDvYrtypRcnz0voN/kvAQYiPTZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b48KdDTuTdap8GWOiBdZcIUgZkQG51GwM7kYzziSh67riTr7+Z5YclgmOmntXFBp/dK35n4mVHIOw/OOCLbGftO5aqRKPl2fmPJcaF3nBn6aHtPPSCG+nNsrmVgFwdUb1j8MGy/ls5zDXKjQDf6Qda6GLCgqmlb5AsIAqfUbav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WissJBHu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb90c20baeso613765266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740422191; x=1741026991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjxCPCmnXeGeJyPZ9rvFlcH8jgmw1PsMh4lSp0OiRPk=;
        b=WissJBHuzwV3ZpQ6Eg0l7pGETOVqh0R1flEwUI16V0MUQ4FvxuYy0jA7/Lkdz3jzkr
         kAFkpPbhvuCAGmQM23mcIXrE99SvzqYU9/DzPFJkNabgM/NQIBqro5viOrGgvhPTxIJP
         7QWQJh9w0QDXwmuGUuaXUUJT5pEMidEPf6Pms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422191; x=1741026991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjxCPCmnXeGeJyPZ9rvFlcH8jgmw1PsMh4lSp0OiRPk=;
        b=MLR0cQiaJ7IU3VITTN7VnOz0U0cuFVcEv0ReBNXzUYeYwNc3K/NvECHNOhYZwU3Twe
         Wja4B05NsO4Pdt+sSCV0crAjVV8i/wdiaDmymVHYj8npjMgEUoIJsAjE8TP0hYsXmQzP
         tGo6T8oKVat5t8ZilvcWi7x7jXBUAJ2aWT6ke5Z6brx8WUcQpbSVb+2xwi/nT7jEBmnW
         cxs2BkdkrxZZtaACOaGk5z6ydSzDspbLNEsFEpgg+XO9b3SiXuX6nblCCJsF1iHMAdai
         Zn53S54hwPmy8WSqt3Upil3AFyRWomH6toaAMIUIKKIvSSFed9V7PYDKLjRMDk6N5eC9
         eCzA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXsdbHsuJ0TAl7+CyBs507/cJ/ZLd9176D3EfkK/qthIZjJXKhfcDAAtsek0A1PdwtxwjlzOedEE2VlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6F1kj4cFRDN7ZAOLWpC8Ad2taa6ugmU3lJEcVPSOQNKigvipF
	royyIhrkSZm6QUqoZH560jwjB50k9Jf6vkiqmTeTF5yICg4NMhW0z8OwRp4TOgY9J0goqWrIKKg
	I0lI=
X-Gm-Gg: ASbGncsZT8ZsgHrRY+g2ggMuYaRfDvUivFZVbSOKuyLbJOoS32oDcj9eEPZFXi1tzeB
	nGV4sIyHyJmMWqsW9+Jz/EAbYnPgUfTGfvpxCz0sQbt/BWhvIoFEX4NRX6fBiB1PM8brxbs4LNO
	17p4admOGo2JCbzvL5NFrOQEfcpi1VVwaR8yI4vlIWU0jNO1prGcwf8CZ2Ib9oQkDALjRDzNgBU
	TI8yGQ/54VD/xrSE9HexE9R6cD1OWn/QyySx4lFtBPUbY1cBiIGXBi0muqxA7mvj+kyhcXRRsGW
	VgH+C0F0bSdhJHMz30kTW/Hg9r7gq3Dai61j0oIok9eFZ8wqvrr7w2ETrIzFVA6SUk6mMkuIsTf
	F
X-Google-Smtp-Source: AGHT+IHgcMIU4jXnzmzR9Wo0HI1+JhYeA7R+DbCAVzBul+FHNbeP28rtucIjbOJISIEmKGbTPuuuPQ==
X-Received: by 2002:a17:906:730b:b0:abb:b136:a402 with SMTP id a640c23a62f3a-abc0d9d7e81mr1515104866b.18.1740422191526;
        Mon, 24 Feb 2025 10:36:31 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d54a1bsm4161566b.42.2025.02.24.10.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:36:30 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso737554266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:36:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBaMJR4LMU8VsM7/uSVESjHKg8AQrQk2r5JYT/yOJligmNuSw3tDQQDNI1EnDbpINL7G4jFqvszowZKIk=@vger.kernel.org
X-Received: by 2002:a17:907:3da0:b0:abb:83b9:4dbe with SMTP id
 a640c23a62f3a-abc0de4a335mr1505840766b.47.1740422190407; Mon, 24 Feb 2025
 10:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
In-Reply-To: <20250224142329.GA19016@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Feb 2025 10:36:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+P5__7LfbTX66shvYC1X11G2ZdKcg4psi+k_pD3sO+w@mail.gmail.com>
X-Gm-Features: AWEUYZlNu7bWtzV6VF8g9lWbkb0aBzMmKrKcCBQur_JXZyZHklFDpxcYe_w5ic0
Message-ID: <CAHk-=wi+P5__7LfbTX66shvYC1X11G2ZdKcg4psi+k_pD3sO+w@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 06:25, Oleg Nesterov <oleg@redhat.com> wrote:
>
> OK, I gave up ;) I'll send the revert patch tomorrow (can't do this today)
> even if I still don't see how this patch can be wrong.

Let's think about this a bit before reverting.

Because I think I see at least one possible issue..

With that commit aaec5a95d596 ("pipe_read: don't wake up the writer if
the pipe is still full"), the rule for waking writers is pretty
simple: we only wake a writer if we update the tail pointer (so that
we made a new slot available) _and_ the pipe was full before we did
that.

And we do so while holding the pipe mutex, so we're guaranteed to be
serialized with writers that are testing whether they can write (using
the same pipe_full() logic).

Finally - we delay the actual wakeup until we actually sleep or are
done with the read(), and we don't hold the mutex at that point any
more, but we have updated the tail pointer and released the mutex, so
the writer is guaranteed to have either seen the updates, or will see
our wakeup.

All pretty simple and seems fool-proof, and the reader side logic
would seem solid.

But I think I see a potential problem.

Because there's an additional subtlety: the pipe wakeup code not only
wakes writers up only if it has freed an entry, it also does an
EXCLUSIVE wakeup.

Which means that the reader will only wake up *one* writer on the wait queue.

And the *WRITER* side then will wake up any others when it has
written, but *that* logic is

 (a) wake up the next writer only if we were on the wait-queue (and
could thus have been the sole recipient of a wakeup)
 (b) wake up the next writer only if the pipe isn't full

which also seems entirely sane. We must wake the next writer if we've
"used up" the wakeup, but only when it makes sense.

However, I see at least one case where this exclusive wakeup seems broken:

                /*
                 * But because we didn't read anything, at this point we can
                 * just return directly with -ERESTARTSYS if we're interrupted,
                 * since we've done any required wakeups and there's no need
                 * to mark anything accessed. And we've dropped the lock.
                 */
                if (wait_event_interruptible_exclusive(pipe->rd_wait,
pipe_readable(pipe)) < 0)
                        return -ERESTARTSYS;

and I'm wondering if the issue is that the *readers* got stuck,
Because that "return -ERESTARTSYS" path now basically will by-pass the
logic to wake up the next exclusive waiter.

Because that "return -ERESTARTSYS" is *after* the reader has been on
the rd_wait queue - and possibly gotten the only wakeup that any of
the readers will ever get - and now it returns without waking up any
other reader.

So then the pipe stays full, because no readers are reading, even
though there's potentially tons of them.

And maybe the "we had tons of extra write wakeups" meant that this was
a pre-existing bug, but it was basically hidden by all the extra
writers being woken up, and in turn waking up the readers that got
missed.

I dunno. This feels wrong. And looking at the hackbench code, I don't
see how it could actually be a problem on *that* load, because I don't
see any signals that could cause that ERESTARTSYS case to happen, and
if it did, the actual system call restart should get it all going
again.

So I think that early return is actually buggy, and I think that
comment is wrong (because "we didn't read anything" doesn't mean that
we might not need to finish up), but I don't see how this could really
cause the reported problems.

But maybe somebody sees some other subtle issue here.

The writer side does *not* have that early return case.  It also does
that wait_event_interruptible_exclusive() thing, but it will always
end up doing the "wake_next_writer" logic if it got to that point.

The bug would have made more sense on the writer side.

But I basically do wonder if there's some bad interaction with the
whole "exclusive wait" logic and the "we now only wake up one single
time". The fact that I found *one* thing that smells bad to me makes
me think maybe there's another that I didn't see.

               Linus

