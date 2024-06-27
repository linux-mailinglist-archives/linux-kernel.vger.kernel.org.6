Return-Path: <linux-kernel+bounces-232741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386A91ADDA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972D91C20F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543219A297;
	Thu, 27 Jun 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSlgsPFQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F71C6A1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508818; cv=none; b=FhycNl/OYWXqrQhFpkWmyOe3pN7iBVec86j6vfAJ+2CbnRr9DfDtU8crUL7Tesj0+XmMo8bkK+9ut+/0xqZES3q9mTy8QrDpurQBuATr/AK2wBAEalVU1ijIpgWX3AWd7bVE6ocyECsS2DHH2zMhtdVyXm/7BN0fhD5vYWyHfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508818; c=relaxed/simple;
	bh=azyPuelYFgTE6kdMySGrFuGBslfZhPvhxh5uHAHzalg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PreCf+ri+cU8Y8KI9TIHTl30sZULGeUB0znRKputkP/bUHU5ucE5mb01Env0MV4WWbxJvicAIZnjYauQ0QhsrTLBGyI9xn+UPpmeBu9hQ2zDQzorMMpK6Od6ZMGmrzyrLrFliAKD8FtyDgozDfOeObuK+71f9b+HX+22JSuptvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSlgsPFQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so2905891a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508816; x=1720113616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqlEDMHapqLffHeKiUQnC/6l2aCqeZ+JOD7CIqp8bOc=;
        b=hSlgsPFQCm7ptm1xFBwbh/+ZOFua5mCOQ1Dq7peL6mXJKAjoSEHD2pUsqgWNLK1RGc
         zxgRitK5IbDSM3aaMDLhaa8i6f3wGQPAnC3DG96geXELadhjB6JV+HD2f78EZTcu/Jg7
         ndKE1FgCqxKcB6yhYZH0srhNduNlbgCuI8b2Cjhx6CrYEMhw4Pl3S/eF0W0vgJWULi3D
         o/2zEqO5EeD6Mz/j8uZwHs9fEuEzjEjHun2UxH/umaY8DGMZ/a4Tgh8WRXjfuJFXyI3j
         511Qb91DXVUYYcaw4OJ56Issx9UHPsYDebxx7Vs50FoSDNTn8tUedEyfG9arZmbCiwwC
         2FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508816; x=1720113616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqlEDMHapqLffHeKiUQnC/6l2aCqeZ+JOD7CIqp8bOc=;
        b=TsSZ43QELbIgA0TdqrWP5L41PTMgSsjpHd1GcIWJYHRTs5JUUyfKMm2sQQkOUHPn4k
         aSJIu+qghM7MkrgWpjHLlhtOGSEGZm8tRunz+DQIqQ/sjj3wHfoBRSCcwDtlHbycGsjg
         296TsFriCchvWpwRWcyDmUQyibZajdcFhafLqM9JSeoapACrD4bmFZg/YPX5TUtFKUzl
         Hm4G//zdX+Aq9yHgsQnlCzWij56izBrTR9o5Fsxqi3+PiWEG2C9SM3TmJ5mb/UsKD7G8
         bxutKXhhFoqfUVA9zVajZdlgwuMkKLFVAu42jMr0K7jmlcPiV4k/LkHjlDupFdsfWlF0
         jqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwRGqtHg7gB3Ay2sOhxRjCI/uV8j0z4toPquj8NIktExPF60S08Sa9BpL44OneSCSk+0BFvRMMg/XknufoDa3qxvHzxhhwOzNJJQmx
X-Gm-Message-State: AOJu0YyTITe038QCBM6Tkij2IU7QS8U0fXcvOZMqxBIGNJZaevfIoETm
	5BKgghDfiOvAGBt6YPbamm9B4FfxpyjpAuhbxLD1FM27Ft+vRFZLd7TLQ8LZT8BHv87QAHAIQLI
	Fhjner7Ca/Ja0TQ1RyarWFr50UoY=
X-Google-Smtp-Source: AGHT+IG4CWSu9QAjyTQd/bZVVvY2xjOLF/BaGGxQpg5/QJVsTWHeQe2x8nTRh1GZOTs0VBpdd56xBsibnHwZCgkG43I=
X-Received: by 2002:a50:871d:0:b0:57d:46f:2cb9 with SMTP id
 4fb4d7f45d1cf-5847bad65e5mr2813927a12.13.1719508815637; Thu, 27 Jun 2024
 10:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <CAGudoHF7ys8bTCE0G6vLzEbo+_NyQXmAEEGPJ4hx1yoYmBsoUA@mail.gmail.com>
 <CAGudoHFrMkdo1CoVxJUiEvQ_DyW3hzaCz18GjvLi4ny=o-q9ZQ@mail.gmail.com>
 <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com> <CAHk-=wjkn=yL6vy5s7ZFgBfDybD3Gjg9C72zXchy-JF0Tp+a+A@mail.gmail.com>
In-Reply-To: <CAHk-=wjkn=yL6vy5s7ZFgBfDybD3Gjg9C72zXchy-JF0Tp+a+A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Jun 2024 19:20:03 +0200
Message-ID: <CAGudoHGuf8JZJjMcs+aYPN7jH+q6Og2CNvSg1-qjJ8kH6SJbJg@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 27 Jun 2024 at 09:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >   getdent subtest:
> >       +4.1   lockref_put_return
> >       +5.7   lockref_get_not_dead
> >      +68.0   native_queued_spin_lock_slowpath
>
> For this getdents load, the main call chains that terminate in the
> queued spinlock case seem to be
>
> .lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup_fast
> .lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
> .lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
> .dput.terminate_walk.path_openat.do_filp_open
>
> which is interesting because I would have expected the readdir() code
> itself to show up.
>
> But the proc_pident_readdir profiles have all gone down, presumably
> because there's just much fewer of them. That part shows no spinlock
> in the profile at all.
>
> WTH is that benchmark doing? The only readdir that shows up is for
> what looks like some /proc filesystem thing.
>

[snip]
[pid 24603] openat(AT_FDCWD, "/proc/146/task/146/ns", O_RDONLY|O_DIRECTORY)=
 =3D 8
[pid 24603] getdents(1048577, 0x561c7bb02b90, 131072) =3D -1 EBADF (Bad
file descriptor)
[pid 24603] getdents(8, 0x561c7bb02b90, 0) =3D -1 EINVAL (Invalid argument)
[pid 24603] getdents(8, 0x561c7bb02b90 /* 12 entries */, 131072) =3D 328
[pid 24603] getdents(8, 0x561c7bb02b90 /* 0 entries */, 131072) =3D 0
[pid 24603] close(8)                    =3D 0
[/snip]

Calls with EBADF and EINVAL show up on my debian version and also on
the version I compiled from their repo
(https://github.com/ColinIanKing/stress-ng.git).

This runs over this collection:
               ret =3D stress_getdents_rand(args, "/proc", true, 8,
bad_fd, &duration, &count);
                if (ret =3D=3D -ENOSYS)
                        break;
                ret =3D stress_getdents_rand(args, "/dev", true, 1,
bad_fd, &duration, &count);
                if (ret =3D=3D -ENOSYS)
                        break;
                ret =3D stress_getdents_rand(args, "/tmp", true, 4,
bad_fd, &duration, &count);
                if (ret =3D=3D -ENOSYS)
                        break;
                ret =3D stress_getdents_rand(args, "/sys", true, 8,
bad_fd, &duration, &count);
                if (ret =3D=3D -ENOSYS)
                        break;
                ret =3D stress_getdents_rand(args, "/run", true, 2,
bad_fd, &duration, &count);
                if (ret =3D=3D -ENOSYS)
                        break;

hence weird stuff mutex and rwsem stuff as well.

All in all I don't think this is a legitimate benchmark per se, but it
may be it is doing something similar to what a real workload would do
elsewhere with lockref. On that front alone it warrants figuring out
(and I am going to sort it out, see my other e-mail).

--=20
Mateusz Guzik <mjguzik gmail.com>

