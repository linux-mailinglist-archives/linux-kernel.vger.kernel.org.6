Return-Path: <linux-kernel+bounces-352264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB5991CB7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0412428307E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 06:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9801581E1;
	Sun,  6 Oct 2024 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6sm+/dE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDEE4A23
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194654; cv=none; b=CAjuSQbW3tRSYEPlPIrH5B0wPGcw/1KyfCyOOZXtM4/NuZFhpPpqbbXNPISO0okrqnzeot7JHQ/EJR795mVlfKBZR5Esfk8ddtwZX06DPBsSS7zUSpc1CnUbPx+bfNT1JIGR+ev5yfjer3+Rd177DjRvwgjhGXrGAJ6y9yD+vEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194654; c=relaxed/simple;
	bh=cJAbKa1HlxdU5tp1+t53Cgq6/hbRAP2LguedRJOhMGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KusqyVNIdM2Nfub8Bk6JGrLrIok5P6EcphQCYqQ3/ov0ZZqrXuHfOme364b9z1EPjQPct+qAn1kZrgE1nYqqTfcXVSpNlmsNL7NaaseAJ7RNk7b1CupGZP8xIUV5by+LP/XWTd0a0JxJGhtDhDu8fkYa1I0OViFQcbanc+WtZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6sm+/dE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so4438288a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728194647; x=1728799447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdKgvqgyhdRbNukhn7GAUAA3F2ZCVtcmSJVHAQGbL6g=;
        b=N6sm+/dEiJPvMwcueYG1Xo5W2S/5C/e1A8mAeJ0zQ9c549pdU8QNPXDC8GXm063gab
         LXHxVqEyE9bjdbqeccn+2U06sOYBH8bfWrn9KJfaHk52esRw3YLJTuUuyuQ0ehllD+Yp
         Y25r9H1PrX8K/9+OOS6/VyNW3fr6PpCKrVL6ifN4aTyGTgHRNwxzj3u6Ap0VcyXMC7kJ
         mjVReIkDM5hEeXk8pVZzX4viSeMIgwzRkoNCC2P38PeouSvNG0AAz8PZWXvUeXx1Kmlb
         lURrnsq6RzGAwh8pIr/bwX6lJ+UOjh5qTIzseg/jBxX+vAXODyA8uzizHgW2zb5x7Dyb
         wD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728194647; x=1728799447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdKgvqgyhdRbNukhn7GAUAA3F2ZCVtcmSJVHAQGbL6g=;
        b=vSY48giRD5Q9FTZeFzXNM7sMsqYak1mMwEd+jt5K2gk9uRSHfpX+1Gs6FY2SVhG1d4
         4A69eg3Dx61Bs9cbnZpTsYby8rWF/ghiCJbRjb9+USHSm3ZCCnTbbL8r+sRur3M3wW7X
         e2VAiXwVooh7JviRZuPGEfb4YZNmsvYPO7mT0jjlVahs5+u2jyYR3B9yKTscJV1TPY5o
         P/KX3p5rilOKJlAoNM2fJRXE+35BgtNHCQEUNVNdzwJwdL9KvDSrhKyjEU413YidY6Dk
         rwKoWCU12/XSNGKYSOSigVhpR+iBgJq8+HuFIMI/DMbC6CoXRsvpXPQ/JYuJ9185PTzR
         0N/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEZZ6rJM8w8O9XhjrODYiPcl0zoqr81xZr1u+LrrrPPkmyKTrZTytP0kzJyO73zHMfRdbS3zt1V4N9css=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9j2cqCKpdnsoOooO9uAzOgbSk/CR4lFpZCxfk/QuBbXAsKp0
	6aO2qihPPzF+TIrLSs6gFih8SIdmKPwTZLKnI3DSagftH7Rfg06gSZj/YllxieA58uYKkPSXywf
	Ust+8kViTO97bPjCI9U/2ubcTAGc=
X-Google-Smtp-Source: AGHT+IHa7Icp+oWQHVt/WZpsUAZhmpntZHmGpOId46sMq7kXlt8qVPEUG0IYmgGQBRUzpAjKumLj3tWGAH+v2J1Ev00=
X-Received: by 2002:a05:6402:2685:b0:5c8:839c:81ad with SMTP id
 4fb4d7f45d1cf-5c8d2e41e73mr6249540a12.15.1728194646970; Sat, 05 Oct 2024
 23:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005174535.2152-1-quic_pintu@quicinc.com> <00aeb243-3d47-42be-b52c-08b39c5fef07@wanadoo.fr>
In-Reply-To: <00aeb243-3d47-42be-b52c-08b39c5fef07@wanadoo.fr>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sun, 6 Oct 2024 11:33:54 +0530
Message-ID: <CAOuPNLjCXpSrnR2AWkeaEaqMCG2noqUDgHTshSy4W-JbrMT6Sg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/psi: fix memory barrier without comment warnings
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, surenb@google.com, 
	peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Oct 2024 at 00:22, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 05/10/2024 =C3=A0 19:45, Pintu Kumar a =C3=A9crit :
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
> > index 020d58967d4e..4e4ff12fdeae 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
> >       if (static_branch_likely(&psi_disabled))
> >               return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> >
> > +     /* Pairs with the smp_store_release in psi_write */
> >       t =3D smp_load_acquire(trigger_ptr);
> >       if (!t)
> >               return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> > @@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const=
 char __user *user_buf,
> >               return PTR_ERR(new);
> >       }
> >
> > +     /* Pairs with the smp_store_acquire in psi_trigger_poll */
>
> smp_load_acquire()?
> I would also add some () after the functions name, here and above.
>
Okay added () in comment for function name and sent v4.
Thank you so much for your review.

Thanks,
Pintu

