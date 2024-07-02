Return-Path: <linux-kernel+bounces-237714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E4923D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443F01C2299B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FEB15CD60;
	Tue,  2 Jul 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0hgAjyB"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E4156C6C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921645; cv=none; b=Vh7zV99WGdcVNyRjzFMv+j+qDndydE4qdZtBicLi2GIyDSJvH30PwAoZhQ61qT/QIOsj0vNCnvaqgkspDwR64z3QfCQ71cwPi2w5+nzqabz6jigBOlZHixsnoeSoLeItZDNP2mzp9UguMt0Y2lJod5akGHzCHF18m722AG1kDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921645; c=relaxed/simple;
	bh=/GDLaLrNUqEfg/hXe3xHKwXVNhnVZYYJwt0TrT/XATM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAhqu+pUM7jDKJhFYerWgy7eK7cW73eh7oi9dLOaBwyAH9XV1hH3j2seT5jsAlwMeldEReVilnAYSqviGDmJPklY4YWa2mI6Hhuf1cygWroDjIU2ddAG/wW88m8RANSI1UPMZXN9DNXcqmlHY40uh5RlS8KuL4i1y9WmBqWIQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0hgAjyB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a725a918edaso620779266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719921642; x=1720526442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZ7jeVzIv0vrTPCXNsfT+SHNwN0Ej4JGm3GWkjnRfu4=;
        b=F0hgAjyBmLcX7YEgjDVysvYpNYBHh6fGqWUTkl7+HooQPy++DoyFDIAKOYrWJYAaqM
         cAx1y8fIimYOFDCscBj0Fh5Q+EZfEpeb8LfYLKnKRORu9b33GQBSeT7V9M/ZPqwF1yo3
         FCqJTms2ZkfysTKQzQj9+OWYUJ8cDxq9eCZwz7Xg0Uj92C7+VL78wx2iHH73/Wf9bTqu
         gYpFl4ThXFZAL6cVq43i0tU8763g8hJgQR9W4P8GBjnUqzDxJ3DPwwId69j94cy1t1Ps
         i/5kob8Z/Mqf8CaDyszYK8TI0Occu9y4gqtIKWVG6610/MplyK2lP2vsqUThwC9a5c73
         Z2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921642; x=1720526442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ7jeVzIv0vrTPCXNsfT+SHNwN0Ej4JGm3GWkjnRfu4=;
        b=ZzhoSM+P9mPYzZRtizQzg1EGThDfXRsOfRoIUQUwhB2iwZEH6QjtWe7JILpVWU5wus
         RUizh0JMots8f5tthk/2kIbimPWQPPCB5W7VghTOW6qtfW4M/M3NoiK14eYvDdRmdHXb
         E/OjEQJKjsDuUrED9/wZRUQ5ULrrO25+67B4/EUR1gD+U8rUuy4tSxRqrLysy4yCfaOV
         Bk/XKJdPWxaFobeTiVXQVt9oE6/bcwMYd7aUABtvTpacXbbyQGvzTxi9E1Jd5cFH1a8f
         SN+yXGwceS8uff8D4SFBNoWDc1mUh0RHCQ4ChO2NPauGY+yT7ck5o3faOiMX5rl7V1JS
         BY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIp4iwioc5ghyM1CkKXJk0XRaI6b5ZeoATChApPwHX15NXKNv3D8PoNksJNypC0aHTGVfIry2BBgjDwifAPeKv7LoT0VJ/GulPAjxV
X-Gm-Message-State: AOJu0Yz8ki6fXuOqPzopgoUknYnI5uiE34MXBu4HdQlCUy/NMF7z2qIk
	eIY9cLLqH+mMPxSR2X7HXzzfb3hJn4lxVaJxv1xnV6bk23QNTpdgyqBV7g4v1lC7nUvAxhWl+BL
	Zjw4fr6J+K7K7o6Q8uU9Wj2Ck/hy4imS/5Sph
X-Google-Smtp-Source: AGHT+IFPDU49eK6Qn1vTi7quTRJvUyfAtJV+lSnJs1GLv+/TXU+UgqL1l8LiV5fSOSvIiLkCuEQyAZurNkyMSf357hE=
X-Received: by 2002:a17:906:c141:b0:a68:b73d:30d0 with SMTP id
 a640c23a62f3a-a751446804amr698380466b.6.1719921641704; Tue, 02 Jul 2024
 05:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org> <CAJD7tkaybPFoM697dtp0CiEJ2zmSYiH2+0yL+KG_LD=ZiscOJA@mail.gmail.com>
 <849e7b86-b971-47d7-8e31-7eee0918ea33@kernel.org>
In-Reply-To: <849e7b86-b971-47d7-8e31-7eee0918ea33@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 2 Jul 2024 05:00:05 -0700
Message-ID: <CAJD7tkYvygYRz9jgUADE8JEH5Na6yrbfwp7bT6JH5tZMgk3PAQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:35=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 29/06/2024 00.15, Yosry Ahmed wrote:
> > [..]
> >>>> +    /* Obtained lock, record this cgrp as the ongoing flusher */
> >>>> +    if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> >>>
> >>> Can the above condition will ever be false?
> >>>
> >>
> >> Yes, I think so, because I realized that cgroup_rstat_flush_locked() c=
an
> >> release/"yield" the lock.  Thus, other CPUs/threads have a chance to
> >> call cgroup_rstat_flush, and try to become the "ongoing-flusher".
> >
> > Right, there may actually be multiple ongoing flushers. I am now
> > wondering if it would be better if we drop cgrp_rstat_ongoing_flusher
> > completely, add a per-cgroup under_flush boolean/flag, and have the
> > cgroup iterate its parents here to check if any of them is under_flush
> > and wait for it instead.
> >
> > Yes, we have to add parent iteration here, but I think it may be fine
> > because the flush path is already expensive. This will allow us to
> > detect if any ongoing flush is overlapping with us, not just the one
> > that happened to update cgrp_rstat_ongoing_flusher first.
> >
> > WDYT?
>
> No, I don't think we should complicate the code to "support" multiple
> ongoing flushers (there is no parallel execution of these). The lock
> yielding cause the (I assume) unintended side-effect that multiple
> ongoing flushers can exist.  We should work towards only having a single
> ongoing flusher.
>
> With the current kswapd rstat contention issue, yielding the lock in the
> loop, creates the worst possible case of cache-line trashing, as these
> kthreads run on 12 different NUMA nodes.
>
> I'm working towards changing rstat lock to a mutex.  When doing so, we
> should not yield the lock in the loop.  This will guarantee only having
> a single ongoing flusher, and reduce cache-line trashing.

If the direction we are heading in is not supporting multiple ongoing
flushers then sure, that makes sense. But if we plan to continue
supporting multiple ongoing flushers, then I think we should fully
commit to it. Let's just avoid a halfway support.

