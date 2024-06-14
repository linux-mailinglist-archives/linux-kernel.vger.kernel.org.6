Return-Path: <linux-kernel+bounces-215323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E237909127
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD1FB20CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C6A1974EA;
	Fri, 14 Jun 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yeq/03nm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A818130E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385251; cv=none; b=m+YA1cOiOMJqf6doDqk355QDc2H8+wamAyxJE0FkS6XxoIErrMewOKxJDQSVcUNTL6HlRM1eV5wp2hb/vAEypY6/fos97SZRqzQl1eBUefj1lpXWgYEs9z5kdABtnqCcQbGad/wFRF122Pr2n1dT/42/dK4kGyXawnokaSrwFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385251; c=relaxed/simple;
	bh=ZKTD2kcnf+gL3JO78mJNToyfWLtc2HLjkwPLe+bKRoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkCxfOZxNZbhSySRlQzNcD7yy4WcnedBXTIu26La/RE9hzE/WIFQtAWJtSWCPlqpU21Vc5PilV7VUcWeO3xvKPjJ2ldT/1oNEQMv19jimtLnmbA6hqVVAtO8AF0RX2qdI0ai68rZOLjhxVYC59Rbtr9HwiSad4j+nnFSBAv4/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yeq/03nm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f61742a024so7285ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718385250; x=1718990050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95IQjCUrHkCT3SiS0CIW9AdJHC2xCd1IW8jzRM+4DVM=;
        b=Yeq/03nmexS6RJjAQaVGEiHhnuHiDy9RrmFcM2CRwVz0DKxCpKX6iFTQ69ioPn1diw
         BBGB3Gv8FqpcaRXfwLBZvgRSFE7KKRX1M+2NVI8unH9U7hcw9bI9519ZYqJKmaykGS7k
         bNtwuOowSLmHEKZqzzTxTjq9NAaxnvg+iflz5LnFhDAnbMOr+e+vRnBJzSLCV9ReWKxa
         WO4OQMKM0J1rcBbZe/p9Fz/okhlcy8Ge/pkujWdyksCdTOsssHOVGWf26x+tC0/aqfnI
         Sec/RyM7ZOc3brMJN3YE7l5v+p53OYpv5dFBhs8w9XskoBQA9ZefVJA4iTXuZOyovnvw
         0CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718385250; x=1718990050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95IQjCUrHkCT3SiS0CIW9AdJHC2xCd1IW8jzRM+4DVM=;
        b=cX931DJAOMG4Y52tyRdYS/k8oqlO89NDOCGxSjyOQHjO4Whdq5nGSC1OnbZNmLGLSM
         wLY3wMBuCFcOpa9Z5hzQKJq6bh+mICVpuNhxj1WcwOPT3TtxdJAqBkg3YizQa1oduYi+
         Pk/elVmebo3Y5EC/J45nXu1Kx5Sem0TqJhn2bsNMv9omkYEkH9vMJVO5pyFuVgjuK6iw
         gO2JhdhU48E5fQe9cQaCbGNRzrXgrEEQY3wyNFuGS3adv6ymO7yfgXWDrrsKnEAW2yD4
         dnvgV3gJU+iWlO8p58YiT/IpBzYnDafai0e0ztiybzM9diCAYy2R9r6LLiHj83CStTfP
         zVfw==
X-Forwarded-Encrypted: i=1; AJvYcCUwrJz/d8NTgDSewEKyMbqe2V69/6fCZ887nHm8Qz+R0GPpcoZyPb282dUsIG3zeq7ckylzRDqXYNaMg6z/KTVT99C27bhKtzTQ1Nir
X-Gm-Message-State: AOJu0YxRhoyZ3uAdB2NpoXzj4VPVp3OefjNknTRFsNVxCie9uByHKIvO
	vySk0L6xnPtC/tLNIjClNcbzAwfjEv2AwWqnjbpTJx85KeO85IhCyaPVvkXHHbOmE5HN/6Ndr1u
	VIuA4ikV+a76EG8icK1sdmp0i9NgqzGdcr6nA
X-Google-Smtp-Source: AGHT+IGpg1heoz1377T5rSttuavBkTh6MwFwQ7o1yVjNKteoBPLk91VThzKFQz4XP1tCwNupbZKcmvz71Yv+uFVX7RE=
X-Received: by 2002:a17:902:6b88:b0:1f4:33a3:4b8f with SMTP id
 d9443c01a7336-1f8642c21edmr3825675ad.8.1718385247948; Fri, 14 Jun 2024
 10:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611133229.527822-1-nogikh@google.com> <CA+fCnZdfB206Bjw=MAkZ9qbKUtf-KeGrrqJnOJ1ZrgH6fGXRhA@mail.gmail.com>
In-Reply-To: <CA+fCnZdfB206Bjw=MAkZ9qbKUtf-KeGrrqJnOJ1ZrgH6fGXRhA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 14 Jun 2024 19:13:56 +0200
Message-ID: <CANp29Y6x4Xx-a8z1DhR1NYh9SMuv1ikV1x=JXR5sKUFiqH6w8g@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't lose track of remote references during softirqs
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: dvyukov@google.com, arnd@arndb.de, akpm@linux-foundation.org, 
	elver@google.com, glider@google.com, syzkaller@googlegroups.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 1:02=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Jun 11, 2024 at 3:32=E2=80=AFPM Aleksandr Nogikh <nogikh@google.c=
om> wrote:
> >
> > In kcov_remote_start()/kcov_remote_stop(), we swap the previous KCOV
> > metadata of the current task into a per-CPU variable. However, the
> > kcov_mode_enabled(mode) check is not sufficient in the case of remote
> > KCOV coverage: current->kcov_mode always remains KCOV_MODE_DISABLED
> > for remote KCOV objects.
> >
> > If the original task that has invoked the KCOV_REMOTE_ENABLE ioctl
> > happens to get interrupted and kcov_remote_start() is called, it
> > ultimately leads to kcov_remote_stop() NOT restoring the original
> > KCOV reference. So when the task exits, all registered remote KCOV
> > handles remain active forever.
> >
> > Fix it by introducing a special kcov_mode that is assigned to the
> > task that owns a KCOV remote object. It makes kcov_mode_enabled()
> > return true and yet does not trigger coverage collection in
> > __sanitizer_cov_trace_pc() and write_comp_data().
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> > Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
> > ---
> >  include/linux/kcov.h | 2 ++
> >  kernel/kcov.c        | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> > index b851ba415e03..3b479a3d235a 100644
> > --- a/include/linux/kcov.h
> > +++ b/include/linux/kcov.h
> > @@ -21,6 +21,8 @@ enum kcov_mode {
> >         KCOV_MODE_TRACE_PC =3D 2,
> >         /* Collecting comparison operands mode. */
> >         KCOV_MODE_TRACE_CMP =3D 3,
> > +       /* The process owns a KCOV remote reference. */
> > +       KCOV_MODE_REMOTE =3D 4,
> >  };
> >
> >  #define KCOV_IN_CTXSW  (1 << 30)
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index c3124f6d5536..5371d3f7b5c3 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -632,6 +632,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, uns=
igned int cmd,
> >                         return -EINVAL;
> >                 kcov->mode =3D mode;
> >                 t->kcov =3D kcov;
> > +               WRITE_ONCE(t->kcov_mode, KCOV_MODE_REMOTE);
>
> Looking at this again, I don't think we need this WRITE_ONCE here, as
> we have interrupts disabled. But if we do, perhaps it makes sense to
> add a comment explaining why.

Thank you!
I've sent a v2:
https://lore.kernel.org/all/20240614171221.2837584-1-nogikh@google.com/

>
> >                 kcov->t =3D t;
> >                 kcov->remote =3D true;
> >                 kcov->remote_size =3D remote_arg->area_size;
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >
>

