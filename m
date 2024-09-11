Return-Path: <linux-kernel+bounces-324155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A26974898
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E60E286332
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE80383B1;
	Wed, 11 Sep 2024 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Ap8Mb1"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EE282EE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025006; cv=none; b=mUl8HdSBw+8rdYKKc1XIwLAxUJaR6xa+syaZhPfkpof2hYSideXChCVo/UQirJ8s72Cy5r8/adJYzLRBG15O529z4phAwd58QKM7mpKkBvH30vCyGHjBcq8QYRzuO1aKQpXEeVgXvPX9gJ8KjmcjGUkwAdXnylDDPOpzThaug58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025006; c=relaxed/simple;
	bh=q1q4Y2QhjQpl6WwEnjCpxKtr6dNfjA2cLqY4o6c/ZSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6YrSQJ26AbD8MXbq5tC6jBTgbf2vRHEFTXdiGnQuKsJJFcuYtNNjj4b2iXSA8GhC1U053hPJH/aUMtJG1JsK2L/oxnw6zZsVplruwIJTH6yGOqAQA3+nwY9HE646KOpuWYny/a/HYMZqOjGHJICNivK7dZWcLqLeNzaU4k2+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Ap8Mb1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so4336220a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726025005; x=1726629805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqYfpXVejCplSFybB5Egf8+lx/6e/7njKm2AgoF6nS0=;
        b=L9Ap8Mb13VhQjDxAnxpOk0DuPvnws2BfitvJ8E2epYfZnn7XFmBeB6ZnityTDTKm+R
         mCRJ+K0Xl4kRXAOdoqNEOnblzCnuViR8kdtZCorlbvHT73VBPeuKENtzRYVftAQNiVlt
         jNDX/ReXp6C7GxokLFkOgwzexLN07ijulLzV7Xuw5Urr1YTNwoHUaMGlJjGld2shY9U7
         yrFj8rK5x9248jEOUdNpHAvixurllx8NP5EgD5wKoBSOxF6q5Yy8KmycfqHLKDaIBHdJ
         /KXMKILJpg5YFGS4dzI2bOJ3KGb5yss+7sIVv2MKEhLalot0Ha+9PZfPEOLDZgdKojtT
         x0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726025005; x=1726629805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqYfpXVejCplSFybB5Egf8+lx/6e/7njKm2AgoF6nS0=;
        b=b3iHnjGiWqeJRDYYJoUDf/c2V2wcWeHRDj5Y0I4dWzXzL7VUUdXCtavpAGoHUJSSvj
         Zn9k0hhA6eaCZ8FVK75neBSLXe0pm9X/jLidFnJI+Sno+WNadEKRF3tdmbQcLXE9Yc3Z
         /pGBhar4iuIhya98cZwX83RAY3UWtsKqMvMzzGqAu0NkyMm4IBUJKzECgvPziKzSsV1t
         N2GCYbJ7skGBMD5gIZonXt1gblmTN1LrWb/+AcxAms0MKJArmIHwno7qJEAHJLfO1ITY
         U0dNYEsVq93ausT11ARBUExbeYvKiBG7Z0zRTpNunba22+kqerzheKkdkECcnyXZD4bg
         5SaQ==
X-Gm-Message-State: AOJu0YyH32dg3QkhbHYZz0ZOcEHccUWAPfEynDOOWy9pgFkkJUI+Y4Cx
	qsgr7itXEY9vS6Duqhi2Fu7SCdbxNvZFDgEzPYJDTdc6Epx/yYOQ5okPZjqVls+thaVKzTkPF2s
	k4E1Fq13NDVz4/GRNjrE80/QPNSK8UD9t
X-Google-Smtp-Source: AGHT+IGsWNl+S2UovMjCjGzVyU54xxqYvVaAB8s05ZSj07BgitXr/ftQmn9+/fhNSfrfVwSROcrH5GPf75X9hz2PiXs=
X-Received: by 2002:a17:90b:388f:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2dad4efde2dmr15379225a91.9.1726025004713; Tue, 10 Sep 2024
 20:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621073225.3600-1-jiangshanlai@gmail.com> <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com> <87wmjj971b.fsf@linux.ibm.com> <87tten8obm.fsf@linux.ibm.com>
In-Reply-To: <87tten8obm.fsf@linux.ibm.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 11 Sep 2024 11:23:12 +0800
Message-ID: <CAJhGHyCWh4QJ6db1vLpt=CJLUrR4pTCt2o4fhYLDVBG6HDyK8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and remove detach_completion
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Marc

On Wed, Sep 11, 2024 at 12:29=E2=80=AFAM Marc Hartmayer <mhartmay@linux.ibm=
.com>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 000002d8c205ef20: a7180000            lhi     %r1,0
> #000002d8c205ef24: 582083ac            l       %r2,940(%r8)
> >000002d8c205ef28: ba12a000            cs      %r1,%r2,0(%r10)
> 000002d8c205ef2c: a77400cf            brc     7,000002d8c205f0ca
> 000002d8c205ef30: 5800b078            l       %r0,120(%r11)
> 000002d8c205ef34: a7010002            tmll    %r0,2
> 000002d8c205ef38: a77400d4            brc     7,000002d8c205f0e0
> [   14.271766] Call Trace:
> [   14.271769] worker_thread (./arch/s390/include/asm/atomic_ops.h:198 ./=
arch/s390/include/asm/spinlock.h:61 ./arch/s390/include/asm/spinlock.h:66 .=
/include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:120 kernel=
/workqueue.c:3346)
> [   14.271774] worker_thread (./arch/s390/include/asm/lowcore.h:226 ./arc=
h/s390/include/asm/spinlock.h:61 ./arch/s390/include/asm/spinlock.h:66 ./in=
clude/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:120 kernel/wo=
rkqueue.c:3346)
> [   14.271777] kthread (kernel/kthread.c:389)
> [   14.271781] __ret_from_fork (arch/s390/kernel/process.c:62)
> [   14.271784] ret_from_fork (arch/s390/kernel/entry.S:309)
> [   14.271806] Last Breaking-Event-Address:
> [   14.271807] mutex_unlock (kernel/locking/mutex.c:549)
>
> So it seems to me that `worker->pool` is NULL in the
> `workqueue.c:worker_thread` function and this leads to the crash.
>

I'm not familiar with s390 asm code, but it might be the case that
`worker->pool` is NULL in the in worker_thread() since detach_worker()
resets worker->pool to NULL.

If it is the case, READ_ONCE(worker->pool) should be used in worker_thread(=
)
to fix the problem.

(It is weird to me if worker->pool is read multi-time in worker_thread()
since it is used many times, but since READ_ONCE() is not used, it can
be possible).

Thanks
Lai

