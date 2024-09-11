Return-Path: <linux-kernel+bounces-324159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1819748AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DB1F26EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75953F4ED;
	Wed, 11 Sep 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlYknTC7"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC4282F7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025550; cv=none; b=oPozbLWlmLIhjVwNUEQFi5IoeFdfQOtnWoH1Ubp02tBVhGeMKY/Ge8ImBnZ1Iwey6MJxLzXM0zKpbjRr4JIiauMPX+RG0vQHeI4d7PcfxAatbbEW5MJ8Zws3JA+s1v1jtMO33DRAYFaR3VS1vjTq11sJa6jUB5jZkPfQ0hFpfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025550; c=relaxed/simple;
	bh=IE8truzQ3n3Ma11ypQKJkzzwndCJhsFG0V8kIZCTyEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2DiFmQuh05beoFwnbKSGHqohr/hRtdviNC7MQhWeNbQHuDbECAUJHhrdB1MC/vNPtcTV6tN7zf/TCC3+EqSN4gffpKqsCalfxlsjIDmTwFUuYJ0odRkf7FEbFF9cRXY/2Ju64SKi5JUIxOss++R3u7lQtANChQS+6jFF8J2prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlYknTC7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso4002000a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726025549; x=1726630349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXb3DfJ4LIsWNK8ziA0xz9K0T9i5/w8KsiylCoZNgbI=;
        b=FlYknTC7QnvUnkPXBRfvljVF+uzKS2bOMabxIHG8HcHggfziEfNaoxaV5ZLW+38G+s
         gtMpuzhLVpS0aewTME5fEE0FVLe+bpJfh/SwqslHaNnzv1/TRbw2UrL1dLuwEKHb9MTd
         Ay17Q3xf2j+xmgRoYsc1q8q1VTuMGABQvd4R9Oza0xeZLaNaqnPd0Cgb63x3XEtC9Kon
         lZeTfnkywwUfVwU+vw1ZTGt1DW8ILep0iJi3ELeA+n57p7jRJ8DjlIj4sW5zPCmslbjw
         0mjmwMy35AkmpzOZ177giS3BxZ9LJlW1fd0WrJMqXXWQHJDNrodv5TLJcLIDmmvUbBYV
         wZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726025549; x=1726630349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXb3DfJ4LIsWNK8ziA0xz9K0T9i5/w8KsiylCoZNgbI=;
        b=B9AggN9SpSp7HqOCcYVPca7u8ZoRSiy3wj320vlgj+JPgYLZEoZgfQdLcoqVkPSHgv
         M/wx2rZL6wuiq+kQIb4HwSiYNRIiDE3K3VSEqpdCJyP8RhztV6UFn3L/JYqIlMAooK75
         yDcK5vIWaJ2PUwnQCdchqjnBKK1ZRV8CMMM1JZeSiq57+oZV5KLUxwcISWs9Q4YCCaxG
         Z4PAsWguV3V8npPhop+Nhgvlw63kpz4MK6MbjnPOFNn/TX9ay4pwH8iwvvQQfoZxnZAU
         DS4yErAqtfh9c08G0UKaYm4+SXX1Nv6a5mT1rX75MNlxmKZcBQjXxmE89xUYzc1ceE22
         jl8g==
X-Gm-Message-State: AOJu0YyPJg2Hk+wdfgc9AurJy6IWL8yMS/xcK4YoZzSf4QNzjnqfeYzb
	JDAnbuniBz6v3l/v4LNM+Efvk0lEa33RNlP3tLo82tHRjj3GgD1KE8qRlPwomI90Tv2ofHvg3dX
	Vhj+6gEMZRUyNQ13h4+zmvyEfCG0=
X-Google-Smtp-Source: AGHT+IEPOCXc+UXGiFM2iga7DFoVPZgGvmoUXJRCde6IS0l6RYA2XxQX0hwybbB9yKB3D7dfR4toPTYNVZWtC+QamfQ=
X-Received: by 2002:a17:90a:4a0b:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2dad5119783mr18059661a91.33.1726025548706; Tue, 10 Sep 2024
 20:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621073225.3600-1-jiangshanlai@gmail.com> <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com> <87wmjj971b.fsf@linux.ibm.com>
 <87tten8obm.fsf@linux.ibm.com> <CAJhGHyCWh4QJ6db1vLpt=CJLUrR4pTCt2o4fhYLDVBG6HDyK8Q@mail.gmail.com>
In-Reply-To: <CAJhGHyCWh4QJ6db1vLpt=CJLUrR4pTCt2o4fhYLDVBG6HDyK8Q@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 11 Sep 2024 11:32:17 +0800
Message-ID: <CAJhGHyBVq84_q5FevmpHPeseAudyf2gOX2LcWt0fMhNddkiz1w@mail.gmail.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and remove detach_completion
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 11:23=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
>
> Hello, Marc
>
> On Wed, Sep 11, 2024 at 12:29=E2=80=AFAM Marc Hartmayer <mhartmay@linux.i=
bm.com>
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 000002d8c205ef20: a7180000            lhi     %r1,0
> > #000002d8c205ef24: 582083ac            l       %r2,940(%r8)
> > >000002d8c205ef28: ba12a000            cs      %r1,%r2,0(%r10)
> > 000002d8c205ef2c: a77400cf            brc     7,000002d8c205f0ca
> > 000002d8c205ef30: 5800b078            l       %r0,120(%r11)
> > 000002d8c205ef34: a7010002            tmll    %r0,2
> > 000002d8c205ef38: a77400d4            brc     7,000002d8c205f0e0
> > [   14.271766] Call Trace:
> > [   14.271769] worker_thread (./arch/s390/include/asm/atomic_ops.h:198 =
./arch/s390/include/asm/spinlock.h:61 ./arch/s390/include/asm/spinlock.h:66=
 ./include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:120 kern=
el/workqueue.c:3346)
> > [   14.271774] worker_thread (./arch/s390/include/asm/lowcore.h:226 ./a=
rch/s390/include/asm/spinlock.h:61 ./arch/s390/include/asm/spinlock.h:66 ./=
include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:120 kernel/=
workqueue.c:3346)
> > [   14.271777] kthread (kernel/kthread.c:389)
> > [   14.271781] __ret_from_fork (arch/s390/kernel/process.c:62)
> > [   14.271784] ret_from_fork (arch/s390/kernel/entry.S:309)
> > [   14.271806] Last Breaking-Event-Address:
> > [   14.271807] mutex_unlock (kernel/locking/mutex.c:549)
> >
> > So it seems to me that `worker->pool` is NULL in the
> > `workqueue.c:worker_thread` function and this leads to the crash.
> >
>
> I'm not familiar with s390 asm code, but it might be the case that
> `worker->pool` is NULL in the in worker_thread() since detach_worker()
> resets worker->pool to NULL.
>
> If it is the case, READ_ONCE(worker->pool) should be used in worker_threa=
d()
> to fix the problem.
>
> (It is weird to me if worker->pool is read multi-time in worker_thread()
> since it is used many times, but since READ_ONCE() is not used, it can
> be possible).

Oh, it can be possible that the worker is created and then destroyed before
being waken-up. And if it is the case, READ_ONCE() won't help. I'm going to
explore if "worker->pool =3D NULL;" can be moved out from detach_worker().

Thanks
Lai

