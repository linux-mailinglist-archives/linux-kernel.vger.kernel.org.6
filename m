Return-Path: <linux-kernel+bounces-257861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E08937FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069181F21AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B6C250EC;
	Sat, 20 Jul 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I05Yb8IY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCB3AC0C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721462292; cv=none; b=tbQfDi4nJg/zlBuPg+FqGPze/sXf1kpONYxgy2lmYW79RPSChDDksUuoVI3u68GNR4MeKJVfHEY0DYF+BbBd2JvTrTTFmV1N44T1OqALjruJTi0oPWHmdZFQB+NDcCfrexTLpR1PWv9nwe7OAtJ/FVnp9W6tpYkBLOeHMxtVpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721462292; c=relaxed/simple;
	bh=Dq9mEwBaFXTGM+hiazChu7J5fn6+BqZk9HMW3uMVsrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcM2rz4BeESxy4h6SKWakDP4ia0/nxZTu+x6dXlYWQJUFzwcNwDWO6HGF24b9yWrI5RFfSvgE1FyPGQJBZ/e9aOdbeYw0ygr/UI0C+JkxntvElbkRFK4cbOvHbX3sX8Ew9J+XJwP2xNGoDX+fKjmZUHhjWVw1pnDCrmEvrMIraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I05Yb8IY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so1740462a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721462289; x=1722067089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq9mEwBaFXTGM+hiazChu7J5fn6+BqZk9HMW3uMVsrM=;
        b=I05Yb8IYj/CWWMiqtYQChGIB3mRqHLvGFQFB2B8UhCLyiGcLrBQ8QCvJOGBDvAlUmF
         SD+gpGTl7SzYm+pdp1Jdq8Ib8SDWUJHaRlcfhtPj79Vsc8Yuko3v5/UkQoqp2me/ftuX
         jbEKxYY9UE7Ay9HRyxm8NP7g0Jm8+hy5R/8mL12RcTUKJ7TT0BSFlxVnSorEUGrcAHz5
         BgYBcDHDE3FlHy/gKRmZmZtdcei+zqvMNz3nGtZmTuxuU/EquLOzFNQEeObAGVMh9lw2
         gGifb14GgnHvjZW/gsI70sKBNO+xjSE8Ic1yjdMWh8BDuxOu6/78QeWXpKvyx1i0690W
         Bydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721462289; x=1722067089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq9mEwBaFXTGM+hiazChu7J5fn6+BqZk9HMW3uMVsrM=;
        b=jgcjy2OIgvbYKN24SUhOUnyJv8fGWVOpaq2gb0a9q2A9i/j7h78alEGPOFdK4CsNod
         ygXvXn/pLd4VHbu6TIdDeM2jZx4LjrCvNq70GxAJUb8p6tUL2GIk1De7J2qqg+uaweS4
         yXdn3nsq9F3oGtXqKzh6eu1J63AZrdp3xoidyySfG/jPXU47PPhpr2iIvnME1iOAxYFv
         wPzJvzW6wst90kpyQZsntlzR62+Erc64jw7XPg2lRJRH6Pgj5iwTnvvWlpnrMCVOEGfr
         n/PetM3YeMw3Ja6XwMt2isLfxz2c6D+4fcjrFjyBMTZFnn34t20bBmTGyMZoTeIq8J1o
         s7cw==
X-Forwarded-Encrypted: i=1; AJvYcCWQv+ynTPgL34esNRIgXr5d0mncbgqCdbYxroS5LoEnKMnNtwkMrlMeYDPebyEA6wxF++g0rzjeMl/g8LnG33f6DsFY6iLoDAdzk0w2
X-Gm-Message-State: AOJu0YxaqczR7iuM3atBpJp4B/muvL0vg029uaA5N3quKJ0xpYMAM+Kl
	LBKCghInwzrRx1hKXAi4HWYu3LJJKeFSPmIjqTjyMaFmx4O8lUyCWadgAkMctZC2kEoe5jkpwnT
	Al3LEFBpGnn61+bpJ3iWcqRMAqVs=
X-Google-Smtp-Source: AGHT+IEhrGLWpJ1TYjgdsuTbvNS/K7q0osoWIkuu0IhKJUG2afbVyZKksQPBR2EXLlrhv9rayzo+j8S1NHDSTgxYE3k=
X-Received: by 2002:a17:907:3e21:b0:a6f:49b1:dec5 with SMTP id
 a640c23a62f3a-a7a4c445037mr53146366b.46.1721462288778; Sat, 20 Jul 2024
 00:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com> <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com> <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
 <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com> <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
 <CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com>
In-Reply-To: <CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Jul 2024 09:57:56 +0200
Message-ID: <CAGudoHEd9FL+Mhk8GdFm+3gvBk35ho-BTX-f7jn=O5Lz2mij-Q@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Yu Zhao <yuzhao@google.com>
Cc: Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nikunj@amd.com, "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	vbabka@suse.cz, kinseyho@google.com, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 10:21=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
> I can't come up with any reasonable band-aid at this moment, i.e.,
> something not too ugly to work around a more fundamental scalability
> problem.
>
> Before I give up: what type of dirty data was written back to the nvme
> device? Was it page cache or swap?
>

With my corporate employee hat on, I would like to note a couple of
three things.

1. there are definitely bugs here and someone(tm) should sort them out(R)

however....

2. the real goal is presumably to beat the kernel into shape where
production kernels no longer suffer lockups running this workload on
this hardware
3. the flamegraph (to be found in [1]) shows expensive debug enabled,
notably for preemption count (search for preempt_count_sub to see)
4. I'm told the lruvec problem is being worked on (but no ETA) and I
don't think the above justifies considering any hacks or otherwise
putting more pressure on it

It is plausible eliminating the aforementioned debug will be good enough.

Apart from that I note percpu_counter_add_batch (+ irq debug) accounts
for 5.8% cpu time. This will of course go down if irq tracing is
disabled, but so happens I optimized this routine to be faster
single-threaded (in particular by dodging the interrupt trip). The
patch is hanging out in the mm tree [2] and is trivially applicable
for testing.

Even if none of the debug opts can get modified, this should drop
percpu_counter_add_batch to 1.5% or so, which may or may not have a
side effect of avoiding the lockup problem.

[1]: https://lore.kernel.org/lkml/584ecb5e-b1fc-4b43-ba36-ad396d379fad@amd.=
com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=
=3Dmm-everything&id=3D51d821654be4286b005ad2b7dc8b973d5008a2ec

--=20
Mateusz Guzik <mjguzik gmail.com>

