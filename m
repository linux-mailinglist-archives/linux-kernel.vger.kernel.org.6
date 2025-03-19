Return-Path: <linux-kernel+bounces-568661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0EBA6990F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAC8886713
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678D207DFB;
	Wed, 19 Mar 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBIH2avP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C01DED58
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411908; cv=none; b=uWpTVY3x0FU+pYT9ER8XjiYRz3sKuAATBYIq2lunzYNJ+VbH5WKHbubXhfyuGXQnGagl7eD2jA7xo1PCVt2k+E8ZczueYe0LDryF+kvtN+x1KMJrTx40sC9Z7TN6d7p/b+9W964CJXCGNo+DMRRRhSdm0yFwKw2JHeG6xoCguzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411908; c=relaxed/simple;
	bh=JM4K2AdLeA/tZujIOKEWMcFPBaUHhRPzg4Vj8efT2og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKmmjKl+reg6M9g1xf6mDioQqWHcqnXAjh9INwdBlshfVaG9vMmofbPlgmUOszRu6MefCvuCR681qYnJf9NBMapw1y6kZjt0QGVw7cgfu7eMd0WWdcPet1XU8XpmfUjIhS9DIw/HRNC4hwb+yPjAmnRIejQAn7AfIP3gLO9FHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBIH2avP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso11022a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742411905; x=1743016705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtA1WJ3VEbM+4+rYSUti+wTKZv3AmrDUfBGPjqhAiH0=;
        b=HBIH2avP11ymVslgIm4oL/W30h8sm6tY42c53FbMsbw7vJMG9UMIrxcyxNCL09Nj4b
         DLNLwbpd6h3vEXU5NdKkZo7InvsBrIwcFnHSClZLTm1w/tkCzZi9tzu7LMEDGMOczJXv
         J7o+nv2az9AtvMlbN8pdjWFsL0pZR5Wn8JN1McFetIRzwHgPWReel6Nj9tHcaXSZmHl1
         x3yQh88FuAqNU89DYnFmhrgVZN/O2NToXXzM30zzouclm3yaMZpCJzjVAQ4+r9K4pweB
         b4bU6PpUnZfWcgITZAAiDQS4kaIKgbki38YWvvIzOT+1mkZ1Q62/jcLcX6SNd96ZbJXF
         pPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411905; x=1743016705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtA1WJ3VEbM+4+rYSUti+wTKZv3AmrDUfBGPjqhAiH0=;
        b=P3C7UwSadS/uQgtLL+1Ab+DxpXZVRmyW4X1xbrXhJPUrpKicxgcG+HTu17lohagjk3
         EdWm9xfPqNxGGKqNyTvLa6dcURQtxyae7tnJxwezIsISa0FRJtEOZIIHT7t3/yHfjpi3
         /bOX0ssaq19QelYOqw7jdzUV8aPFwXMMjBja8eCghaiXOBo3eZQ135qNq7KTvWuQWS64
         6q9ECSQ5zvSBrkxUW6ozYIsT4i40LfE35oSbp/XcLHhx0g9Lc7S1UyRbwde1iSVtjvx1
         T7t63x3v+zeZtodShM7TDl1tRIhKxD0PsRoX7KPvZlFYAETd8EmggcCMyANHOoeojbFy
         ndrw==
X-Forwarded-Encrypted: i=1; AJvYcCUa69Q/5Gy6UuIn2WuiB4iY7qFs1hfiQij5oFFiYWZCspbbqVli7PFjcx3WDCcGEMCvMUePXZlkst1QXHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGQSJWiuyMB8g+wV0IeSkX/R7JG9psSR2u/NVoZ5uun4C5ldz
	r7x+NZPxxqdGgiRDxvlFAOkZmtqeSmTquTk3cL9scK4PUXMP09wf/Lo3Q41MJgLQLyWAN5PnKr/
	E7hkgOpzCVS/MRq0FDJjMYP+mKCVLKuRi
X-Gm-Gg: ASbGncsTyDd8HuTb90LnyBSleuLfreZdJTEtEclppbVfNt6YjkSJblt2Y1FCeQmPHLO
	V5iuescp9mHZqIk2LAXgv16Y7PdPzYFUu0vcufUgnkUQs9TGR04bf61sAsBqs68XlgNV1lS4k+l
	Ri0nytnZGbo/rRqVPROf5D2QdbSA==
X-Google-Smtp-Source: AGHT+IEqiSO7u0PDEcFETsBJ55H3LO6ODeD6FmdJzYK/yWT3nCGDR2PGq2kxfKJ5grNSsYFqvkWBzACs0Ag8A8bfPDo=
X-Received: by 2002:a05:6402:5210:b0:5e4:92ca:34d0 with SMTP id
 4fb4d7f45d1cf-5eb80f89fd7mr3765797a12.20.1742411904512; Wed, 19 Mar 2025
 12:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319185433.1859030-1-mjguzik@gmail.com> <20250319190950.GF26879@redhat.com>
In-Reply-To: <20250319190950.GF26879@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Mar 2025 20:18:12 +0100
X-Gm-Features: AQ5f1Jp4Tnice6Rpb4cXilJ1AvnOJFnsu7JdAp3T4I0KP1inFhCWz_1pG546hyc
Message-ID: <CAGudoHEg3k96oNSK-kOe+3StBv3z86iMVQjPd1pn1=SjtPQUVA@mail.gmail.com>
Subject: Re: [PATCH v2] exit: combine work under lock in synchronize_group_exit()
 and coredump_task_exit()
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:10=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 03/19, Mateusz Guzik wrote:
> >
> > +     spin_lock_irq(&sighand->siglock);
> > +     synchronize_group_exit(tsk, code);
> > +     core_state =3D coredump_task_exit_prep(tsk);
> > +     spin_unlock_irq(&sighand->siglock);
>
> Well, but why do we need the new (and trivial) coredump_task_exit_prep?
>

it's not *needed*, i claim it is cleaner

but i'm not going to argue about this, i'll submit and updated patch
later this evening or tomorrow

> Can't synchronize_group_exit() be
>
>         static struct core_state *synchronize_group_exit(struct task_stru=
ct *tsk, long code)
>         {
>                 struct sighand_struct *sighand =3D tsk->sighand;
>                 struct signal_struct *signal =3D tsk->signal;
>                 struct core_state *core_state =3D NULL;
>
>                 spin_lock_irq(&sighand->siglock);
>                 signal->quick_threads--;
>                 if ((signal->quick_threads =3D=3D 0) &&
>                     !(signal->flags & SIGNAL_GROUP_EXIT)) {
>                         signal->flags =3D SIGNAL_GROUP_EXIT;
>                         signal->group_exit_code =3D code;
>                         signal->group_stop_count =3D 0;
>                 }
>                 /*
>                  * Serialize with any possible pending coredump.
>                  * We must hold siglock around checking core_state
>                  * and setting PF_POSTCOREDUMP.  The core-inducing thread
>                  * will increment ->nr_threads for each thread in the
>                  * group without PF_POSTCOREDUMP set.
>                  */
>                 tsk->flags |=3D PF_POSTCOREDUMP;
>                 core_state =3D tsk->signal->core_state;
>                 spin_unlock_irq(&sighand->siglock);
>
>                 return core_state;
>         }
>
> ?
>
> No need to shift spin_lock_irq(siglock) from synchronize_group_exit() to =
do_exit(),
> no need to rename coredump_task_exit...
>
> Oleg.
>


--=20
Mateusz Guzik <mjguzik gmail.com>

