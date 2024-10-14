Return-Path: <linux-kernel+bounces-364742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249899D8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946321F22354
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613971C75FA;
	Mon, 14 Oct 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJDBwxoa"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C84683
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940009; cv=none; b=oXSC6ZETXu4pUAb9rZ2HfIpt59bD9zzsmJHb1Kh/DMa2A2sctmYL+Ggl8P8I/t2uiSSa8b2cGzxGJRforQ8mGex84fCnjjsI8+8UYOR9WwQmfOa7bb1wp/jmiJtPdj0REJyzkpDfc3Wzz+oLQ0tCANEKTSO0MGN+ekgbTRJoNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940009; c=relaxed/simple;
	bh=ofp1M6mLyfdQCFvbdCuNd+kLdWVhOCGG3/mVGb0aUu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAbp83Yy9Nyuyc8htD2faiTHWVsJrw7rgevFlZpDPsDP3lSmlY44HQ/uOw/bkepXkk0ayEZVgQ2dcRgRTH3Xm4fb08tKrEkqNfhHyh8Q1UIM0ejCT5VnvJFbKi7Mga/h3coJDWYfwv3sGvRMAF64XLi3jlyy6urukPKa0bO2JHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJDBwxoa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4601a471aecso498411cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728940007; x=1729544807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf4JHOMqMaJ9U0uXdgKjmaPpWxRgnMWK6r8eup/nOZY=;
        b=nJDBwxoa9itJxK/rJS0ypd6vIBRCOuSc1z8p6/N7aoihNysWi67i6jO+jCHwIBy9La
         Kst0FHmnHlU0DJod4NVqYLM9mgrDHc8bYGCq9R0n01ccv9mv3KNGrk2a9ZyCFsWkWNrj
         lqjXjiHVp0H0StoiNChXIgnGuMlhq8HtoJCf3UobMIMu3h8PijFiRIXtyYjRZClFt+Dq
         uXDk0m47n8rwwR3GrMRofCVkCzyBwDOzqRGRUp6TYLVWZ/YL4JEEyFf3KJgMxWewGh2U
         T/E8eqeIXyWaQrv+BSzNdcNYnx5gqNOvJJ5txuBxIX8VygN6NpZlG8ruNoyQFD464kn8
         KnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940007; x=1729544807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf4JHOMqMaJ9U0uXdgKjmaPpWxRgnMWK6r8eup/nOZY=;
        b=qCrWdl3K6oeeViO5BKDGAf8ETEV8r4h/7wozgtRQcS2zcH9LSY6ns38R5c3eRribbf
         laZ8padd16tAA+hauABe8Xv6+IzlNllSVepz0ZnPnzmMSoynEmB4UJQ1gucSSxiurmxL
         gkYmngOfrD2+JLfWyum/9GcYMzbj5eZzfkwrn4LHxg/cquVGBkev8Ue4S/WkX/iuP7hU
         M98h8gbQ04qLCfEbJ+Cc/dXuY4GUxftO1Mpp4ziiIio5aYMBLGFDGcQg1o/ecz52iC99
         ka6pQ7xBPGWNNKkbFBoQ4DS8GWtX/skrsE6b2I9Zli+JctuGf4mjCfA/wiYWzc0jxCLv
         Ealw==
X-Forwarded-Encrypted: i=1; AJvYcCXgqyvijCesLAA0GyZ/YhFxl3xJnERuY/Ik+Jud1VBjIR+T/Se0YM3XyqtjEfg+MR9dO5KzRZ7ox4YLAFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ypqNqaqKo0n3JhvEtOAk3t0J8ouGUNMxMfJQ0uINRQLbJUqS
	dgbNjgjqE8BRvmeEZApwdAJp8dy69JaQwzrb4l5GI5s0rshmq4urKCmd/YqeGDa++IEqyPe2Q3j
	Lz/nXPqvIXmYKZF0PwqHdHWIiIQRTve2XZmhC
X-Google-Smtp-Source: AGHT+IFjbGfE3ZRyy95DmB7/9AX+vSm5K7j1N9l0bMdayEw7PDF9ZtzD7M8cbsy4Q5m0XBxG1c5ll/dQm93btJ3tNJg=
X-Received: by 2002:a05:622a:2a15:b0:460:4aa1:78d6 with SMTP id
 d75a77b69052e-46058f594f8mr6354781cf.20.1728940007010; Mon, 14 Oct 2024
 14:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082926.20647-1-quic_pintu@quicinc.com>
In-Reply-To: <20241006082926.20647-1-quic_pintu@quicinc.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 14:06:36 -0700
Message-ID: <CAJuCfpE+LSd7hogwGnLMT5y831unLjCpS3DpOASgphDFxDjGJw@mail.gmail.com>
Subject: Re: [PATCH v5] sched/psi: fix memory barrier without comment warnings
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: hannes@cmpxchg.org, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org, joe@perches.com, 
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:29=E2=80=AFAM Pintu Kumar <quic_pintu@quicinc.com>=
 wrote:
>
> These warnings were reported by checkpatch.
> Fix them with minor changes.
> No functional changes.
>
> WARNING: memory barrier without comment
> +       t =3D smp_load_acquire(trigger_ptr);
>
> WARNING: memory barrier without comment
> +       smp_store_release(&seq->private, new);
>
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> ---
> Changes in V5:
> Corrected api name and missing () in comments as suggested by Christophe =
JAILLET.
> V4: https://lore.kernel.org/all/a8393bc0-6f56-4e40-b971-4a837cf28323@wana=
doo.fr/
> Changes in V4:
> Added () in comment as well suggested by Christophe JAILLET.
> V3: https://lore.kernel.org/all/00aeb243-3d47-42be-b52c-08b39c5fef07@wana=
doo.fr/
> Changes in V3:
> Removed signature of Joe as requested. No other change.
> V2: https://lore.kernel.org/all/CAOuPNLi1mUKW_vv0E6Ynzvdw_rHvCye+nAf2bWv6=
Qj9A8ofX1g@mail.gmail.com/
> Changes in V2:
> Retain printk_deferred warnings as suggested by Joe Perches.
> V1: https://lore.kernel.org/all/a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.=
camel@perches.com/
> ---
>  kernel/sched/psi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 020d58967d4e..907fa3830c8e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
>         if (static_branch_likely(&psi_disabled))
>                 return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
>
> +       /* Pairs with the smp_store_release() in psi_write() */
>         t =3D smp_load_acquire(trigger_ptr);
>         if (!t)
>                 return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
> @@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const c=
har __user *user_buf,
>                 return PTR_ERR(new);
>         }
>
> +       /* Pairs with the smp_load_acquire() in psi_trigger_poll() */
>         smp_store_release(&seq->private, new);
>         mutex_unlock(&seq->lock);
>
> --
> 2.17.1
>

