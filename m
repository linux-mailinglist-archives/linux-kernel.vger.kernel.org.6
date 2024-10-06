Return-Path: <linux-kernel+bounces-352298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF026991D28
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839E4281006
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A916F0CA;
	Sun,  6 Oct 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a249WtrV"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5632206E
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202933; cv=none; b=Ttsct32vgqB5nepaj+ZDdTFOt6UdtsPGPDqZSsq/YEoWiSiKBiwiHMBUjo4tmJkL9js0jwSflP9dWv9Z7p9n+OTuxne/iBM5jKBJqg4E0rGrEb1IZ6EsBU0M81cMcIdtRgWZz4ONFKGPSBVwRRU/8TNaCBv3zmFBrR9cvCFBzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202933; c=relaxed/simple;
	bh=jBCgbQlaT/mvFS0PXTwXr/lueiw/I4vzO3+XvLSX44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myT4nqMjm6+Xdn6pYdGwQ9kqSKKMQ5He+l8O1z+vpvSi2xZiWk9rwIF01PKOOB5BJjlTOTLmBEsumZFbmUlbqC69An3TOHNIompMQGexHi5QYPxgW5qguXhLRDKrrUjYeH/rhCsEGqMTs1QjNSErjqm70046O+uocHi4gVXaHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a249WtrV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a991fedbd04so216588366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728202930; x=1728807730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUZc8yX718Sk9X3q6hGbPjXLUq2iV+4u1e+XOc/xaeA=;
        b=a249WtrVDE08oaHJkoNxm8d2Mdf6VNLap2EmYAlWW7tiqljsYLP8atCUgnYu8GS2nB
         yuIwQmqQ+f4Txxtw7iTfYSOL6piEJ3tPFi8nyHxEs2zXWLouIk1Bn19f1sVA1ccaPpfD
         f2Wa5HeM2/h/ym1w9hI7c+LTa/Tf3HRHCmc/JHXRGVxpYN2t0VW8RvNPh11cPk2zPd8F
         uNbGsScfHFNeUu55OfU3FVOFZu1LBPev3Kd8lcHgxEN/fPP8U/75zhERxdJ+/E8wuct9
         hPHukILmZ600ttA1+BzDIM0ihI3ZgiqjYBGZ/Jv4ht7qQxBvg+6tmEq80N62fAmcekKF
         zlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728202930; x=1728807730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUZc8yX718Sk9X3q6hGbPjXLUq2iV+4u1e+XOc/xaeA=;
        b=sVx1lxIWH5wS+kWArYXhs878lZ0XXDlI1g7mlIFY6bDCIk5lzrRqmI2HHjpZKMS92N
         nbHhMSC0xP+3C4Rn5xCHniKCxc4Lb/l2NQL8o82cFCV7NG001gOkeXxv6YOWz2lF5CSI
         cqc2JElE2Sc2zi/DgKOz4FrnYUL+h1RmwNM/w4TumZfTa8fTyqIb3iqYbDITwXiF14Jz
         79YaK+SjssnSMecBI1bvTjpqf/ys/UFA9ns2+X+3DvGKB/HLcVM3lk1iaWUfQBGcEQQg
         LR0sNPxcNQZbLN4HFIijtVl91zjWPTMqyB3oGEu5MqS28cysOmxf3PSPWapm5CI9HO3t
         0etw==
X-Forwarded-Encrypted: i=1; AJvYcCU+dSx4YKmfq5ltdTT71xzrd63TnERqRT9Ua20h+KCuE4cpDpuXXo1SnJ59jfrauVy5z8Bkb5xP6vdFTw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5L5MH9DX92Gkj9GxfjgRpLW+SRu+a+7d3CBpc+jNNXVLQN5xR
	e/1Y9yTqWglOQwQ4q8K/OM01cB2aNwosO4Z/lI7ojh43k6G0HLnw8xgm0G28Gm0ROo+vNRJnaiI
	9DBTAM1XMx4KX80CB1RdqZHsvbzw=
X-Google-Smtp-Source: AGHT+IEG/szba9o41GZvZVyygaFcn7B4dULOj1ZbCH8pA9oCgEUEzXzSpSY60pwhdeu9jGDdvVkH9l6DSoBzlN293qU=
X-Received: by 2002:a05:6402:84e:b0:5c8:9f44:a0b2 with SMTP id
 4fb4d7f45d1cf-5c8d2e1765fmr13108027a12.5.1728202929934; Sun, 06 Oct 2024
 01:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060042.17613-1-quic_pintu@quicinc.com> <a8393bc0-6f56-4e40-b971-4a837cf28323@wanadoo.fr>
In-Reply-To: <a8393bc0-6f56-4e40-b971-4a837cf28323@wanadoo.fr>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sun, 6 Oct 2024 13:51:57 +0530
Message-ID: <CAOuPNLiu23e4O_tP=1nzgAp4vyhsW7gH2351Y6oxbjK2NGEFRA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/psi: fix memory barrier without comment warnings
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, surenb@google.com, 
	peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Oct 2024 at 12:33, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 06/10/2024 =C3=A0 08:00, Pintu Kumar a =C3=A9crit :
> > These warnings were reported by checkpatch.
> > Fix them with minor changes.
> > No functional changes.
> >
> > WARNING: memory barrier without comment
> > +       t =3D smp_load_acquire(trigger_ptr);
> >
> > WARNING: memory barrier without comment
> > +       smp_store_release(&seq->private, new);
> >
> > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> >
> > ---
> > Changes in V4:
> > Added () in comment as well suggested by Christophe JAILLET.
> > V3: https://lore.kernel.org/all/00aeb243-3d47-42be-b52c-08b39c5fef07@wa=
nadoo.fr/
> > Changes in V3:
> > Removed signature of Joe as requested. No other change.
> > V2: https://lore.kernel.org/all/CAOuPNLi1mUKW_vv0E6Ynzvdw_rHvCye+nAf2bW=
v6Qj9A8ofX1g@mail.gmail.com/
> > Changes in V2:
> > Retain printk_deferred warnings as suggested by Joe Perches.
> > V1: https://lore.kernel.org/all/a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4=
b.camel@perches.com/
> > ---
> >   kernel/sched/psi.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 020d58967d4e..175423716e4c 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
> >       if (static_branch_likely(&psi_disabled))
> >               return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> >
> > +     /* Pairs with the smp_store_release() in psi_write */
> >       t =3D smp_load_acquire(trigger_ptr);
> >       if (!t)
> >               return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> > @@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const=
 char __user *user_buf,
> >               return PTR_ERR(new);
> >       }
> >
> > +     /* Pairs with the smp_store_acquire() in psi_trigger_poll */
>
> Sorry if I was unclear in my previous comment, but my main point is that
> I think that it should be smp_load_acquire() and not smp_store_acquire().
>
> (Also, if you add some (), you could also add them for psi_trigger_poll
> and psi_write)
>
Oh sorry, my bad, I overlooked it again. You are right.
Thank you so much for pointing this out.
I corrected it now. Will push the new patchset again.
{{{
-       /* Pairs with the smp_store_release() in psi_write */
+       /* Pairs with the smp_store_release() in psi_write() */
        t =3D smp_load_acquire(trigger_ptr);
....
-       /* Pairs with the smp_store_acquire() in psi_trigger_poll */
+       /* Pairs with the smp_load_acquire() in psi_trigger_poll() */
        smp_store_release(&seq->private, new);
}}}

Thanks,
Pintu

