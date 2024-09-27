Return-Path: <linux-kernel+bounces-341191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799F987C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56A0B23070
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF91BC5C;
	Fri, 27 Sep 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbNSHQ7K"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD34C74
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727398141; cv=none; b=AAeMDnx+Fe9Iyr9ii+Kr0fuDaZfFunS60G1cObdJTwc9mHH5He2Mzejw9/PqfJ8JIGglDDBQf9OpMmPJgi2M40QAX6ruagUDZOiBC3oq1W6ZUsgZ7xRtZzDTPQm4iJf6diI2G/x7GGE2sidEPMELUA6zIO1H1t3KCFGQFDUOE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727398141; c=relaxed/simple;
	bh=iY/t+3OozCaP73WTM0TyA7rGwJvmolvARYy3nfPx/DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8bJCt3949yukNxADX38hyolaZmHf08rXxeshpx2DBnJ18cLQ43zyOwBHqZ6sojq78+e7O2pfoYbsu2Ncsm6IL6knSOVR5ko2poXMHDYm4kOZks7C46C/OYbX621LxEj+An6Iof77nzdVR1UCnWyUBF0sUUQJO/qMbjUgpiQdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbNSHQ7K; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so834856a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727398139; x=1728002939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NlIqPw2RTrEGU033VxGxvlzPh2cm7rrP5Tz27iXdWc=;
        b=HbNSHQ7KmmroPsboXmBuBfGJZDLklzKksivy9BFGioCwkD6SzybqDccTNZIquGdTlp
         9cXagY1Mm18E1Jp52zc2mHhWeHCZ3NX//6vDhRgaj8Ye8mSr+2d+iAByKXtOMxSTynSP
         wwUsTwE6IrnlmIy87MWi50474PnVx2TKNQNDW5IteZUQQmLNCpQiGZR9yFESDKARehA9
         LJDRtB2X/ltlO2efKL14PA2ti/9p+lAZ4E86j3uUHhvJQhY3jaOIJ8Pege/+lAQNTUgZ
         ssIRZZqD3LwjczRpKfterHMr9rdMqQr7xSz3KsVrQsZHBIfR2CQWgrsBapk3PRkzcdFn
         5KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727398139; x=1728002939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NlIqPw2RTrEGU033VxGxvlzPh2cm7rrP5Tz27iXdWc=;
        b=FzH4xYpyY1JD8mTmMg1vV73T8iXFTA6dmNyrt8qaL0jhMRm31FgoYVpiecdt22FiSH
         KQjPk3yFjwef0OonP0XKj6EyK2DxIXfuUtmXEBKLNGZ6oZpERNS8w7r8q1EpYAFaYm69
         22OJ8bCy8GkYJtBdG1biu382V8T+ts9oZaQWgmritpu4hqyac2wx0pzammW+3AqfvYfQ
         4sRz8CRM4goCjtw379raHEEI06O1JPghFtQLxggVLwULdJmIRjJqQ3HW1l6Rlli6NOd7
         Jlz0Hga0oCvHDP2KDc6i3Io4FVQaNvfTgUdv/bJeKQQFEOHiY+c35FCTYrzqLF3CEvWy
         3mHw==
X-Forwarded-Encrypted: i=1; AJvYcCWaD28erv7Odk+q0jvgaWX9oW6Quvrl3vX6HIfnBXgh6sMdDWn9ArQOajDS75Hdaqv8C+y34BChK0qv3KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jGy7ei9YXkSV4CP8xg2OnzVRUui7+hupxRgdBrXZdNKpYnji
	3FDoWTa4r/05rDaE6zF4ccPmnJznvmHgaOvrqzA78asfDEM4xI7SILxAsQ7xLq4wvX4UFiol31p
	q/yIP8olpX2H/8SZgM1dOCdmVjg6cLya9dAiL
X-Google-Smtp-Source: AGHT+IGNoRPqV3cnZXRVwVexIjMSvYV3WbX3ssiB/HUaVeBJudab4ib2Leryc3NXno32SiuOM+41R8a9J9z2bV3ICbI=
X-Received: by 2002:a17:90a:df01:b0:2e0:82bf:1aa2 with SMTP id
 98e67ed59e1d1-2e0b89a46b1mr1720687a91.7.1727398139229; Thu, 26 Sep 2024
 17:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-7-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 26 Sep 2024 17:48:47 -0700
Message-ID: <CAHRSSEzj2UWrLBdUuFpcDwkyW_4R1Q46nZK49guqWhAPr8nqJQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:36=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Alice points out that binder_request_freeze_notification() should not
> return EINVAL when the relevant node is dead [1]. The node can die at
> any point even if the user input is valid. Instead, allow the request
> to be allocated but skip the initial notification for dead nodes. This
> avoids propagating unnecessary errors back to userspace.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6=
RWWUNKKyJC_Q@mail.gmail.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 73dc6cbc1681..415fc9759249 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_pr=
oc *proc,
>  {
>         struct binder_ref_freeze *freeze;
>         struct binder_ref *ref;
> -       bool is_frozen;
>
>         freeze =3D kzalloc(sizeof(*freeze), GFP_KERNEL);
>         if (!freeze)
> @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binder_=
proc *proc,
>         }
>
>         binder_node_lock(ref->node);
> -
> -       if (ref->freeze || !ref->node->proc) {
> -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFI=
CATION %s\n",
> -                                 proc->pid, thread->pid,
> -                                 ref->freeze ? "already set" : "dead nod=
e");
> +       if (ref->freeze) {
> +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION a=
lready set\n",
> +                                 proc->pid, thread->pid);
>                 binder_node_unlock(ref->node);
>                 binder_proc_unlock(proc);
>                 kfree(freeze);
>                 return -EINVAL;
>         }
> -       binder_inner_proc_lock(ref->node->proc);
> -       is_frozen =3D ref->node->proc->is_frozen;
> -       binder_inner_proc_unlock(ref->node->proc);
>
>         binder_stats_created(BINDER_STAT_FREEZE);
>         INIT_LIST_HEAD(&freeze->work.entry);
>         freeze->cookie =3D handle_cookie->cookie;
>         freeze->work.type =3D BINDER_WORK_FROZEN_BINDER;
> -       freeze->is_frozen =3D is_frozen;
> -
>         ref->freeze =3D freeze;
>
> -       binder_inner_proc_lock(proc);
> -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> -       binder_wakeup_proc_ilocked(proc);
> -       binder_inner_proc_unlock(proc);
> +       if (ref->node->proc) {
> +               binder_inner_proc_lock(ref->node->proc);
> +               freeze->is_frozen =3D ref->node->proc->is_frozen;
> +               binder_inner_proc_unlock(ref->node->proc);
> +
> +               binder_inner_proc_lock(proc);
> +               binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +               binder_wakeup_proc_ilocked(proc);
> +               binder_inner_proc_unlock(proc);
> +       }
>
>         binder_node_unlock(ref->node);
>         binder_proc_unlock(proc);
> --
> 2.46.1.824.gd892dcdcdd-goog
>

